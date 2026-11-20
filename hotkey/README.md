# Maestro Hotkey r27 quick guide

**The Hotkey trades the account you select in Chart Trader**, simulation or live. Try it on a simulation account (Sim101 or Playback101) first. On a live account it places real orders: the banner at the top of the chart always shows the account it will use. You get 14 days from first use on this computer under your Windows account. The free trial in this build stops arming after February 28, 2027. A licensed copy does not stop.

1. **Install.** In NinjaTrader Control Center, choose **Tools → Import → NinjaScript Add-On** and import **MaestroHotkeyR27.zip** once.
2. **Set up.** In the chart's **Indicators** dialog, add **Maestro Signal Bar Hotkey** once. Open **Chart Trader** and pick your account under **Account**. Configure your ATM under **ATM Strategy → Custom**, and save it as a named template. Select the saved name in **ATM Strategy** and verify the account and template in the Hotkey banner.
3. **Use.** Click the chart, then press main-row **=** for long or **-** for short on a US layout while the bar is forming. The amber dot marks the bar you armed. Press the same key again to disarm. If your layout places those keys elsewhere or requires Shift, choose an available unmodified key in Indicators and confirm the binding there.
4. **Check the result.** A qualifying bar sets a stop one tick past its high or low. The next bar only has to reach the level. If the stop cannot rest, the hotkey waits for a trade at the level, then tries a limit at that price. If the next bar misses the level, there is no entry. Unfilled entry quantity is cancelled at that bar's close. Maximum slip (ticks) caps how far beyond the trigger a stop-limit entry can fill, with a default of one tick. A fast market can leave it unfilled. The fallback limit stays at the trigger price. Find **Maximum slip (ticks)** in **Indicators > Maestro Signal Bar Hotkey > Order**. Set it to 0 to place the limit at the trigger price.

| Banner message | What to do |
| --- | --- |
| Click the chart to use the keys | Click the chart and try again. |
| Armed long / Armed short / Armed the NEW bar | Check the amber dot is on the bar you intended. |
| No forming bar is available | Wait for the next forming bar and press again. |
| Stop resting at … / Waiting for a trade at … | The displayed level applies to the next bar only. |
| Stop rejected / Trade touched; limit entry sent | Watch the displayed level and check the entry in Orders. |
| Not triggered / No entry sent | Wait for another setup. |
| Filled … (average …) / Filled AFTER its bar | Check Orders, Positions and ATM protection. |
| SIMULATOR QUOTE IS STALE | Playback can show an unrealistically favorable fill even with a limit. Compare the print, level and fill. |
| Open Chart Trader and select a saved ATM | Show Chart Trader and pick a named template. |
| Open Chart Trader and select an account / Account … is not connected | Show Chart Trader and pick a connected account under Account. |
| Already on this chart / A Hotkey entry is already armed or pending | Remove the extra copy or disarm the other chart and check its orders. |
| Waiting for the first trade of the new session | Wait for the chart to update, then try again. |
| Hotkey could not check the order | Check Orders and Positions before trying again. |
| Your 14-day free trial has ended | Buy the Hotkey at maestrocopier.com/products and type the email you paid with (see "After the 14 days" below). Either arm key can still disarm an existing arm. |
| The computer's date changed | Set the computer date correctly and restart NinjaTrader. |
| The trial record could not be read | A new 14-day free trial was started. |
| The trial start could not be saved | The Hotkey can be used for this session. |

**Partial fills.** In one Sim101 test, NinjaTrader submitted ATM protection after the final fill, about 461 ms after the first partial fill. Check your working stops in Orders.

**Armed bars keep their account.** Once a bar is armed, its order goes to the account shown in the banner at that moment, even if you then change the account in Chart Trader or close Chart Trader. Disarm first to change accounts.

**Prop firm and funded accounts.** Check your firm's rules on order-entry tools before using the Hotkey on such an account.

**After the 14 days.** The Hotkey costs $49, one time, no subscription. Buy it at maestrocopier.com/products. After you pay, right-click the chart, click **Indicators**, click **Maestro Signal Bar Hotkey**, type **the email you paid with** into **License key** (under **5. License**) and click **OK**. The Hotkey looks up your purchase over the internet and unlocks itself, usually within half an hour of paying and at most about an hour; it keeps checking while the chart is open. You do this once: every chart on this computer is then unlocked. If we send you a license key instead, paste it into the same box.

| Banner message | What to do |
| --- | --- |
| Looking for your purchase... | Wait. The Hotkey is checking. |
| No purchase found yet for that email | It can take up to an hour after you pay. Leave the chart open. If it does not unlock, check the spelling of the email, then contact us. |
| Could not reach the license server | Check your internet connection. The Hotkey keeps trying. |
| License found ... the Hotkey is unlocked | Nothing. You are done. |
| Update available: r... | A newer version is on the website. Download it and follow "Updating from an older version" below. |
| That is not valid | Type the email you paid with, or paste the whole license key we sent you, from MH1- to the last character. |
| License accepted. It could not be saved on this computer yet | The Hotkey keeps trying to save it. If the message returns after a restart, enter the license again. |

The trial record is kept in %LOCALAPPDATA%\Maestro\Hotkey\trial.txt for your Windows account.

**Updates.** When a newer version is on the website, the text at the top of your chart adds a line: "Update available: r27. Download it at maestrocopier.com/products." (with the new number). The Hotkey checks once each time NinjaTrader starts; it never downloads or installs anything by itself. Your license and your settings stay as they are when you update. One exception: if you had typed your purchase email in an older version and it had not unlocked yet, type the email once more after updating. In Control Center, use **Tools > Remove NinjaScript Assembly** to remove the old Hotkey assembly. Import the new ZIP, then fully exit and restart NinjaTrader so the old assembly is unloaded.

**Remove.** Check Orders and Positions first. In the chart's **Indicators** dialog, select the configured hotkey, click **Remove**, and apply. For a compiled ZIP, open **Control Center → Tools → Remove NinjaScript Assembly**, select the Maestro Hotkey assembly and remove it. For a source ZIP, open **New → NinjaScript Editor**, remove the Hotkey indicator and its package-listed helper scripts in the explorer, then compile. Use the package's file list so you remove only its own sources.

For email support, send a screenshot showing the chart and full Hotkey banner, plus the instrument, interval and replay date/time when applicable.
