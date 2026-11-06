package `in`.sreerajp.qr_studio

/**
 * Holds the one GhostScan capture that is waiting to be handed to Flutter.
 *
 * [MainActivity] is exported, so any app can start it with any extras. The
 * capture service therefore never puts the file path in the intent: it
 * stores the capture here, in this app's own process memory, and the intent
 * only carries the action. No other app can write to this holder
 * (docs/security.md §10.1).
 */
object GhostScanCaptureStore {
    data class Capture(
        val imagePath: String,
        val fromBubble: Boolean,
        val blocked: Boolean
    )

    private var pending: Capture? = null

    /** Stores [capture], replacing any older one that was never taken. */
    @Synchronized
    fun put(capture: Capture) {
        pending = capture
    }

    /** Returns the pending capture once, then clears it. Null if none. */
    @Synchronized
    fun take(): Capture? {
        val capture = pending
        pending = null
        return capture
    }
}
