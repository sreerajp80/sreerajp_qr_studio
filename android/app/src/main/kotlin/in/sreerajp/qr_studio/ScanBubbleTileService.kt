package `in`.sreerajp.qr_studio

import android.app.PendingIntent
import android.content.Intent
import android.os.Build
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService

/**
 * Quick Settings tile that turns the Scan bubble on or off from any app.
 *
 * If the "Display over other apps" permission is missing, tapping the tile
 * opens the system permission page for this app instead.
 */
class ScanBubbleTileService : TileService() {
    override fun onStartListening() {
        super.onStartListening()
        refreshTile()
    }

    private fun refreshTile() {
        qsTile?.apply {
            state = if (ScanBubbleService.isRunning) Tile.STATE_ACTIVE else Tile.STATE_INACTIVE
            updateTile()
        }
    }

    override fun onClick() {
        super.onClick()
        if (ScanBubbleService.isRunning) {
            ScanBubbleService.stop(this)
            qsTile?.apply {
                state = Tile.STATE_INACTIVE
                updateTile()
            }
            return
        }

        // Start through a short-lived visible activity: newer Android versions
        // do not allow a foreground service to start from the tile directly.
        // That activity also opens the overlay permission page when needed.
        val intent = Intent(this, ScanBubbleShortcutActivity::class.java)
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        if (isLocked) {
            unlockAndRun { openActivityAndCollapse(intent) }
        } else {
            openActivityAndCollapse(intent)
        }
    }

    private fun openActivityAndCollapse(intent: Intent) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            val pendingIntent = PendingIntent.getActivity(
                this,
                0,
                intent,
                PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
            )
            startActivityAndCollapse(pendingIntent)
        } else {
            @Suppress("DEPRECATION")
            startActivityAndCollapse(intent)
        }
    }
}
