# Maestro Hotkey: makes a license for every paid Stripe checkout of the Hotkey and writes it under hotkey/licenses.
# Runs in GitHub Actions (PowerShell 7) every few minutes; also runs on Windows PowerShell 5.1 for testing.
# Secrets come from the environment and are never written anywhere:
#   STRIPE_KEY          a Stripe RESTRICTED key that can only READ Checkout Sessions
#   HOTKEY_LICENSE_KEY  the license signing key, "D|X|Y" in base64 (ECDSA P-256)
# A license file is named by a hash of the buyer's email and encrypted with a key made from that email,
# so the public folder shows neither who bought nor their keys; the Hotkey finds its file from the email typed in.
param(
  [string]$OutDir = (Join-Path $PSScriptRoot '..\hotkey\licenses'),
  # The Hotkey's own link, and the Maestro Copier link: the copier is sold WITH the Hotkey, so a copier buyer's email unlocks the Hotkey too.
  [string[]]$PaymentLink = @('plink_1UdyzXQ4tCinVvg6Px2rqy6w', 'plink_1UVIukQ4tCinVvg6aDGW8y1h'),
  [string]$SessionsFile = ''   # testing only: a JSON file shaped like Stripe's list response
)
$ErrorActionPreference = 'Stop'
# File name (bytes 0-31) and file key (bytes 32-63) come from the email through a deliberately slow function,
# so the public folder cannot be searched quickly with a list of emails. Must match HotkeyLicense.PurchaseBytes in the Hotkey.
function Get-PurchaseBytes([string]$email) { $kdf = New-Object Security.Cryptography.Rfc2898DeriveBytes([Text.Encoding]::UTF8.GetBytes($email), [Text.Encoding]::UTF8.GetBytes('maestro-hotkey-license-v1'), 200000, [Security.Cryptography.HashAlgorithmName]::SHA256); try { , $kdf.GetBytes(64) } finally { $kdf.Dispose() } }
function ConvertTo-B64Url([byte[]]$b) { [Convert]::ToBase64String($b).TrimEnd('=').Replace('+', '-').Replace('/', '_') }

if (-not $env:HOTKEY_LICENSE_KEY -or (-not $SessionsFile -and -not $env:STRIPE_KEY)) { 'Not set up yet: the two secrets are missing. Nothing done.'; return }
$f = $env:HOTKEY_LICENSE_KEY.Trim().Split('|')
if ($f.Count -ne 3) { throw 'HOTKEY_LICENSE_KEY is not in the expected form.' }
$point = New-Object Security.Cryptography.ECPoint; $point.X = [Convert]::FromBase64String($f[1]); $point.Y = [Convert]::FromBase64String($f[2])
$priv = New-Object Security.Cryptography.ECParameters; $priv.Curve = [Security.Cryptography.ECCurve+NamedCurves]::nistP256; $priv.D = [Convert]::FromBase64String($f[0]); $priv.Q = $point
$signer = [Security.Cryptography.ECDsa]::Create($priv)

# 1. Paid checkouts of the Hotkey payment link.
$sessions = @()
if ($SessionsFile) { $sessions = @((Get-Content $SessionsFile -Raw | ConvertFrom-Json).data) }
else {
  if (-not $env:STRIPE_KEY) { throw 'STRIPE_KEY is not set.' }
  $headers = @{ Authorization = "Bearer $($env:STRIPE_KEY)" }
  foreach ($link in $PaymentLink) {
    $after = ''
    do {
      $url = "https://api.stripe.com/v1/checkout/sessions?payment_link=$link&status=complete&limit=100" + $(if ($after) { "&starting_after=$after" } else { '' })
      $page = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
      $sessions += @($page.data)
      if ($page.has_more -and $page.data.Count -gt 0) { $after = $page.data[-1].id } else { $after = '' }
    } while ($after)
  }
}

New-Item -ItemType Directory -Force $OutDir | Out-Null
$made = 0; $skipped = 0
foreach ($s in $sessions) {
  if ($s.payment_status -ne 'paid') { continue }
  $email = "$($s.customer_details.email)".Trim().ToLowerInvariant()
  if ($email -eq '' -or $email.Contains('|') -or $email.Length -gt 100) { $skipped++; continue }
  $bytes = Get-PurchaseBytes $email
  $name = -join ($bytes[0..31] | ForEach-Object { $_.ToString('x2') })
  $path = Join-Path $OutDir "$name.txt"
  if (Test-Path $path) { continue }
  $issued = [DateTimeOffset]::FromUnixTimeSeconds([long]$s.created).UtcDateTime.ToString('yyyy-MM-dd', [Globalization.CultureInfo]::InvariantCulture)
  $payload = [Text.Encoding]::UTF8.GetBytes("MaestroHotkey|1|$email|$issued")
  $key = 'MH1-' + (ConvertTo-B64Url $payload) + '.' + (ConvertTo-B64Url ($signer.SignData($payload, [Security.Cryptography.HashAlgorithmName]::SHA256)))
  $aes = [Security.Cryptography.Aes]::Create(); $aes.Mode = 'CBC'; $aes.Padding = 'PKCS7'; $aes.Key = [byte[]]$bytes[32..63]; $aes.GenerateIV()
  $enc = $aes.CreateEncryptor(); $plain = [Text.Encoding]::UTF8.GetBytes($key); $cipher = $enc.TransformFinalBlock($plain, 0, $plain.Length)
  [IO.File]::WriteAllText($path, [Convert]::ToBase64String($aes.IV + $cipher))
  $enc.Dispose(); $aes.Dispose()
  $made++
}
$signer.Dispose()
# The Actions log of this public repository is public: say nothing about how many sales there were or who bought.
if ($skipped -gt 0) { Write-Warning 'A paid checkout had no usable email. Look in the Stripe dashboard.' }
if ($SessionsFile) { "checkouts read: $($sessions.Count); new licenses written: $made" } else { 'done' }
