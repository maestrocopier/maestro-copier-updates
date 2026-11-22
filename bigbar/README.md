# Maestro Big Bar Checker beta (r16)

Free beta. Download: MaestroBigBarCheckerBetaR16.zip in this folder. Tell us what you see through the Contact page on maestrocopier.com.

Use this when a NinjaTrader Last-trade tick chart shows a huge wrong bar after reloading history.

1. In the Control Center, choose **Tools > Import > NinjaScript Add-On**, then select the beta ZIP.
2. On your chart, open **Indicators**, select **Maestro Big Bar Checker**, add it, and apply the change.
3. After installing a new version, right-click the chart and choose **Reload NinjaScript**. Hover over **Fix** at the bottom left of the chart to check the revision.

Connect to your data provider and press **Fix**. A provider reply can take up to three minutes. A local read can also take time.

Fix asks your data provider to send the last few days again. NinjaTrader replaces its stored trades for those days with what the provider sends.

Read the result. A gap means a suspicious stretch remains in the readback. A trading halt can explain a real gap. If there were no bars the tool could check, it says so. The hover explains any skipped bars and the time zone.

The result hides after about 20 seconds. Hover over **Fix** to read it again.

If the result asks you to redraw, right-click the chart and choose **Reload NinjaScript**. This restarts every indicator on that chart, and any strategy running on it; your settings are kept. Do not reload a chart while a strategy on it is in a trade. A big bar created by the refresh can only be checked in a second Fix after the refreshed bars are visible. Verify the redraw on your chart.

If a minute never had 200 stored trades, the tool does not report it as a large missing stretch. When it keeps a copy, the hover gives its location. Copies are in your local app data under `Maestro\BigBar\before\r14`. You can delete a kept copy when you no longer need it.

This beta checks Last-trade tick charts while connected. It does not work in Playback, put missing trades back or place orders.

To remove it, open the chart's **Indicators** list and remove **Maestro Big Bar Checker**. To uninstall the beta assembly, use **Tools > Remove NinjaScript Assembly** in Control Center.

For email support, use the Contact page on maestrocopier.com.


The tool deletes copies it did not keep. Previously saved r13 copies stay in Maestro\BigBar\before.
