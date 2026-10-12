package `in`.sreerajp.qr_studio

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

/**
 * Starts the Scan bubble after a phone restart, but only when the user turned
 * on "Start after phone restart", the bubble was on before the restart, and
 * the "Display over other apps" permission is still granted.
 */
class ScanBubbleBootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent?) {
        if (intent?.action != Intent.ACTION_BOOT_COMPLETED) return
        if (!ScanBubblePrefs.isStartOnBoot(context)) return
        if (!ScanBubblePrefs.isEnabled(context)) return
        if (!ScanBubbleService.canDrawOverlays(context)) return
        try {
            ScanBubbleService.start(context)
        } catch (_: Exception) {
            // Some phones block service start after boot. The user can still
            // start the bubble from the Quick Settings tile.
        }
    }
}
