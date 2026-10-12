package `in`.sreerajp.qr_studio

import android.app.Activity
import android.os.Bundle

/**
 * Invisible activity behind the "Start scan bubble" app icon shortcut.
 * Starts the bubble, or opens the overlay permission page if it is missing.
 */
class ScanBubbleShortcutActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            if (!ScanBubbleService.start(this)) {
                startActivity(ScanBubbleService.overlayPermissionIntent(this))
            }
        } catch (_: Exception) {
            // Never crash from a shortcut tap.
        }
        finish()
    }
}
