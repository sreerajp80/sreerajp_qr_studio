package `in`.sreeraj.qr_reader

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.media.projection.MediaProjectionManager
import android.os.Build
import android.os.Bundle

/**
 * Transparent Activity that prompts the user for screen capture consent via MediaProjection.
 * Once consent is granted, starts GhostScanCaptureService to perform a one-time capture and exits.
 */
class GhostScanActivity : Activity() {
    companion object {
        private const val REQUEST_MEDIA_PROJECTION = 1010
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val projectionManager = getSystemService(Context.MEDIA_PROJECTION_SERVICE) as MediaProjectionManager
        startActivityForResult(projectionManager.createScreenCaptureIntent(), REQUEST_MEDIA_PROJECTION)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_MEDIA_PROJECTION) {
            if (resultCode == Activity.RESULT_OK && data != null) {
                val serviceIntent = Intent(this, GhostScanCaptureService::class.java).apply {
                    putExtra("result_code", resultCode)
                    putExtra("data_intent", data)
                }
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    startForegroundService(serviceIntent)
                } else {
                    startService(serviceIntent)
                }
            }
            finish()
        }
    }
}
