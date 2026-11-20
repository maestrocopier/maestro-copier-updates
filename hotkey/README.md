# Maestro Hotkey r20 beta quick guide

**Simulation accounts only in this beta.** You get 14 days from first use on this computer under your Windows account. This build stops arming after February 28, 2027, so get the current version if your trial would run past that date.

1. **Install.** In NinjaTrader Control Center, choose **Tools → Import → NinjaScript Add-On** and import **MaestroHotkeyBetaR20.zip** once.
2. **Set up.** Connect to Playback and use **Playback101**, or connect to Simulated Data Feed or your market-data feed and use **Sim101**. In the chart's **Indicators** dialog, add **Maestro Signal Bar Hotkey** once. Open **Chart Trader**, configure your ATM under **ATM Strategy → Custom**, and save it as a named template. Select the saved name in **ATM Strategy** and verify the account and template in the Hotkey banner.
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
| Already on this chart / A Hotkey entry is already armed or pending | Remove the extra copy or disarm the other chart and check its orders. |
| Waiting for the first trade of the new session | Wait for the chart to update, then try again. |
| Hotkey could not check the order | Check Orders and Positions before trying again. |
| Your 14-day beta has ended | Get the current version at maestrocopier.com. Either arm key can still disarm an existing arm. |
| The computer's date changed | Set the computer date correctly and restart NinjaTrader. |
| The beta record could not be read | A new 14-day beta period was started. |
| The beta start could not be saved | The Hotkey can be used for this session. |

**Partial fills.** In one Sim101 test, NinjaTrader submitted ATM protection after the final fill, about 461 ms after the first partial fill. Check your working stops in Orders.

The trial record is kept in %LOCALAPPDATA%\Maestro\Hotkey\trial.txt for your Windows account.

**Updating from an older beta.** In Control Center, use **Tools > Remove NinjaScript Assembly** to remove the old Hotkey assembly. Import the new ZIP, then fully exit and restart NinjaTrader so the old assembly is unloaded.

**Remove.** Check Orders and Positions first. In the chart's **Indicators** dialog, select the configured hotkey, click **Remove**, and apply. Then open **Control Center → Tools → Remove NinjaScript Assembly**, select the Maestro Hotkey assembly and remove it.

For email support, send a screenshot showing the chart and full Hotkey banner, plus the instrument, interval and replay date/time when applicable.

Support is by e-mail: use the contact form at https://www.maestrocopier.com/contact

Download: [MaestroHotkeyBetaR20.zip](https://github.com/maestrocopier/maestro-copier-updates/raw/main/hotkey/MaestroHotkeyBetaR20.zip) (SHA-256 A1FA9DBD415BC24826E61EEA32DB719C2A9814C3DB334CB120944B6310FA829A)
