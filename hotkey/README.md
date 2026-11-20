# Maestro Hotkey r18 beta quick guide

**Simulation accounts only in this beta.** You can arm new entries through December 4, 2026, using your local computer date.

1. **Install.** In NinjaTrader Control Center, choose **Tools → Import → NinjaScript Add-On** and import **MaestroHotkeyBetaR18.zip** once.
2. **Set up.** Connect to Playback and use **Playback101**, or connect to Simulated Data Feed or your market-data feed and use **Sim101**. In the chart's **Indicators** dialog, add **Maestro Signal Bar Hotkey** once. Open **Chart Trader**, configure your ATM under **ATM Strategy → Custom**, and save it as a named template. Select the saved name in **ATM Strategy** and verify the account and template in the Hotkey banner.
3. **Use.** Click the chart, then press main-row **=** for long or **-** for short on a US layout while the bar is forming. The amber dot marks the bar you armed. Press the same key again to disarm. If your layout places those keys elsewhere or requires Shift, choose an available unmodified key in Indicators and confirm the binding there.
4. **Check the result.** A qualifying bar sets a stop one tick past its high or low. The next bar only has to reach the level. If the stop cannot rest, the hotkey waits for a trade at the level, then tries a limit at that price. If the next bar misses the level, there is no entry. Unfilled entry quantity is cancelled at that bar's close. A stop becomes a market order when price reaches it, so in a thin market a contract can fill a tick or more past the level. A limit can fill at its price or better.

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

**Partial fills.** In one Sim101 test, NinjaTrader submitted ATM protection after the final fill, about 461 ms after the first partial fill. Check your working stops in Orders.

**Update from an older beta.** In Control Center, use **Tools > Remove NinjaScript Assembly** to remove the old Hotkey assembly. Import the new ZIP, then fully exit and restart NinjaTrader so the old assembly is unloaded.

**Remove.** Check Orders and Positions first. In the chart's **Indicators** dialog, select the configured hotkey, click **Remove**, and apply. Then open **Control Center → Tools → Remove NinjaScript Assembly**, select the Maestro Hotkey assembly and remove it.

For email support, send a screenshot showing the chart and full Hotkey banner, plus the instrument, interval and replay date/time when applicable.

Support is by e-mail: use the contact form at https://www.maestrocopier.com/contact

Download: [MaestroHotkeyBetaR18.zip](https://github.com/maestrocopier/maestro-copier-updates/raw/main/hotkey/MaestroHotkeyBetaR18.zip) (SHA-256 1AF8DED7885E0E0BC2FA0827D7ADFF69ADB98F2C273DCB3524B166B44CCA954B)
