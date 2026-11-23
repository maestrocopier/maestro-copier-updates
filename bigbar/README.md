# Maestro Big Bar Checker beta (r35)

Free beta. Download: MaestroBigBarCheckerBetaR35.zip in this folder.

## This is a beta

This was rushed out. It may or may not work on your computer. Every time you use it, it writes a short report that helps us fix it, and that report is what we need from you most.

## What it is for

Sometimes, right after **Reload All Historical Data**, a NinjaTrader tick chart (Last data) shows a huge **solid** bar that was not there before. This tool is for that bar.

A huge bar with a thin **wick** is different: a wick is usually a real print, and this tool leaves it alone.

## What one click does

Press **Fix** once, right after the big bar appears. There is no question. Fix compares the ticks saved before a reload with the stored ticks and puts the saved ticks back for a bar that turned into a solid big bar; then reloads the chart. In more detail:

1. it reads the tick data NinjaTrader has stored on this computer now (the same data the chart is built from). It asks nobody for anything, so it works with or without a connection;
2. it compares the bars built from the ticks this indicator saved before (its 3-day backup) with the bars built from the stored ticks now;
3. a bar that was ordinary before and is a **solid big bar** now is the problem. Only where ticks are **missing** in that bar does it put the saved ticks back into NinjaTrader's own tick data file, and it reads the file back to check it;
4. it trusts the saved ticks only when they check out against the stored ticks around the bar: no extra copies of ticks, times in order, and every minute the same as the stored one, record for record and in the same order, except the minutes that are missing. Only whole missing minutes go back, and only when the repaired bar is no longer a solid big bar. In any doubt it writes nothing;
5. it never removes a stored tick. A wick, a bar that was big before too, or a bar with no saved ticks from before is left exactly as it is, and the result says so in plain words.

The result shows under the button in one short line (and a second line only when you need to do something), for 10 seconds; then it vanishes by itself. Nothing to click. While Fix works you see one short line: "Checking the stored tick data ...". The revision ("Big Bar Checker r35 beta") is shown beside the button. Everything else is in the report.

Examples:
- **Nothing to fix: that bar is a wick (1 tick at 6966.75), so the tick data was left as it is.**
- **Fixed: 5 minutes put back from the tick data NinjaTrader had stored.**

## Seeing the repaired bar

Nothing to do: after a repair the charts of that contract reload by themselves from the repaired tick data, and the line under Fix says "Fixed: the big bar at <time> was rebuilt from your saved ticks." If a strategy is running on that contract, the charts are not reloaded (an order is never risked for a redraw); the line then says the tick data was fixed but the chart did not redraw. If something the reload needs is missing (another NinjaTrader version), nothing on the chart is touched and the line says the chart did not redraw. Once a reload has started it always finishes; if it takes longer than the 10-second line, the line says "the chart is still reloading." Never use "Reload All Historical Data" for this: it downloads the data again.

## The report

Every time you press Fix, and once for each big bar the chart shows (at most 20 at a time), the tool adds an entry to one plain text file:

`Documents\Maestro\BigBar\big-bar-report.txt`

Please email that file to us through maestrocopier.com/contact.

What the report holds:
- date and time with the time zone, the tool's revision and the NinjaTrader version;
- the contract and bar type, for example ES 12-26, 2000 Tick;
- for each big bar: its time, open, high, low, close, body and range in ticks, how many ticks it has and how many sit far beyond the bars before it, the same numbers for the two bars before and after, the same stretch in the saved tick data, and what was decided and why;
- the result line shown under Fix.

What it never holds: no account names or numbers, no user name, no computer name, no paths with your user folder in them. The file is kept under 1 MB (the oldest entries are dropped).

## Install

1. In the Control Center, choose **Tools > Import > NinjaScript Add-On**, then select the beta ZIP.
2. On your chart, open **Indicators**, select **Maestro Big Bar Checker**, add it, and apply the change.
3. Check that the text beside **Fix** says **Big Bar Checker r35 beta**. If it shows an older revision (or no revision), the chart is still running the old indicator: remove the indicator and add it again.

## Leave it on your chart

While it is on your chart and you are connected, it keeps a backup of the last 3 days of tick data for that contract, in your local app data folder under `Maestro\BigBar\backup\<contract>`. A minute goes in about 10 to 20 minutes after it ends, once two reads 10 minutes apart agree. This backup is what Fix compares with after a reload, so the tool can only help with bars that were already on the chart before the reload. A minute already in the backup is never changed by later reads, so a reload cannot overwrite it.

## Undo

Before it changes one of NinjaTrader's tick files, Fix keeps NinjaTrader's own file exactly as it was in `Maestro\BigBar\undo\<contract>\` in your local app data folder, for at least 3 days. The result names each file and where its copy is. To undo by hand: close NinjaTrader, copy the kept file back over the file in `Documents\NinjaTrader 8\db\tick\<contract>\`, and open NinjaTrader again.

## What it leaves alone

- A wick (a few prints far from the bars around it), and any tick in the stored tick data.
- A bar that was already a solid big bar in the saved tick data (a real move).
- A bar with no saved tick data from before: there is nothing to compare.
- The hour NinjaTrader is still writing (the current hour), and today's hour that is not over yet.
- A file NinjaTrader is using at that moment (press Fix again in a minute).
- If Windows stops the swap of a file halfway, Fix puts NinjaTrader's file back at once. If even that is blocked, it says where the file is kept safe; the next Fix puts it back first.
- Any file it cannot prove is NinjaTrader's tick file of that contract and hour.
- A day when the clock changed (daylight saving), a merged contract chart (open the exact contract, for example ES 12-26), and a chart whose time zone is not your computer's.

Reading the stored tick data makes NinjaTrader write its own cache files (in `Documents\NinjaTrader 8\db\cache`), as any chart does. That is NinjaTrader, not this tool.

It works on Last tick charts. It does not work in Playback (Playback charts are built from replay data). It never places orders.

## Dry run (a first-try diagnostic, not part of normal use)

Normal use is one click on **Fix**; there is nothing to switch. For a first test the support team may ask for a dry run. It is on only while a file named `dry-run.txt` exists in `Maestro\BigBar` in your local app data folder (no button, no setting). In a dry run this tool writes nothing (no repair, no backup, no report) and the chart is not reloaded. NinjaTrader still writes its own cache files for the read. The result says what the real Fix would do. Delete the file to go back to normal.

## Remove it

Open the chart's **Indicators** list and remove **Maestro Big Bar Checker**. To uninstall the beta assembly, use **Tools > Remove NinjaScript Assembly** in the Control Center. You can delete the `Maestro\BigBar` folders (in local app data and in Documents) when you no longer need them.

For email support, use the Contact page on maestrocopier.com.
