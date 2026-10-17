package `in`.sreerajp.qr_studio

import android.app.Activity
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.graphics.Bitmap
import android.graphics.PixelFormat
import android.hardware.display.DisplayManager
import android.hardware.display.VirtualDisplay
import android.media.Image
import android.media.ImageReader
import android.media.projection.MediaProjection
import android.media.projection.MediaProjectionManager
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.util.DisplayMetrics
import android.view.WindowManager
import androidx.core.app.NotificationCompat
import java.io.File
import java.io.FileOutputStream

/**
 * Short-lived foreground service (active for under a second) that captures a single screen
 * frame using Android's MediaProjection API and passes it to the QR scanner engine.
 *
 * The frame is taken [SETTLE_DELAY_MS] after capture starts, not the first frame, so the
 * fading "Start recording?" dialog and its dimmed layer are not in the picture.
 *
 * Adheres strictly to Google Play policies:
 * - Initiated solely on-demand by user action.
 * - Releases all projection and display resources immediately after single frame capture.
 * - Zero background surveillance or continuous recording.
 */
class GhostScanCaptureService : Service() {
    companion object {
        private const val NOTIFICATION_ID = 4401
        private const val CHANNEL_ID = "ghost_scan_channel"
        private const val CHANNEL_NAME = "GhostScan Screen Detector"

        /** Set when the captured frame is almost all black (app blocks capture). */
        const val EXTRA_BLOCKED = "blocked"

        /** Wait for the consent dialog to fade out before keeping a frame. */
        private const val SETTLE_DELAY_MS = 500L
    }

    private var mediaProjection: MediaProjection? = null
    private var virtualDisplay: VirtualDisplay? = null
    private var imageReader: ImageReader? = null
    private val handler = Handler(Looper.getMainLooper())
    private var hasCaptured = false
    private var settled = false

    /** Newest frame so far; older frames are closed as soon as a newer one arrives. */
    private var heldImage: Image? = null
    private val settleRunnable = Runnable {
        settled = true
        useHeldImage()
    }
    private var captureWidth = 0
    private var captureHeight = 0
    private val timeoutRunnable = Runnable {
        if (!hasCaptured) {
            cleanup()
            stopForegroundAndSelf()
        }
    }
    private var fromBubble = false

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val resultCode = intent?.getIntExtra("result_code", Activity.RESULT_CANCELED) ?: Activity.RESULT_CANCELED
        @Suppress("DEPRECATION")
        val dataIntent = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            intent?.getParcelableExtra("data_intent", Intent::class.java)
        } else {
            intent?.getParcelableExtra("data_intent")
        }

        fromBubble = intent?.getBooleanExtra(GhostScanActivity.EXTRA_FROM_BUBBLE, false) ?: false

        if (resultCode != Activity.RESULT_OK || dataIntent == null) {
            ScanBubbleService.showAgain(this)
            stopSelf()
            return START_NOT_STICKY
        }

        startForegroundNotification()
        startCapture(resultCode, dataIntent)
        return START_NOT_STICKY
    }

    private fun startForegroundNotification() {
        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                CHANNEL_NAME,
                NotificationManager.IMPORTANCE_LOW
            ).apply {
                description = "Captures on-demand screen content for QR code analysis"
                setShowBadge(false)
            }
            notificationManager.createNotificationChannel(channel)
        }

        val notification: Notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("GhostScan")
            .setContentText("Scanning screen for QR codes...")
            .setSmallIcon(R.drawable.ic_ghost_scan_tile)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .setCategory(NotificationCompat.CATEGORY_SERVICE)
            .setOngoing(true)
            .build()

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            startForeground(
                NOTIFICATION_ID,
                notification,
                ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PROJECTION
            )
        } else {
            startForeground(NOTIFICATION_ID, notification)
        }
    }

    private fun startCapture(resultCode: Int, dataIntent: Intent) {
        val projectionManager = getSystemService(Context.MEDIA_PROJECTION_SERVICE) as MediaProjectionManager
        mediaProjection = projectionManager.getMediaProjection(resultCode, dataIntent)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            mediaProjection?.registerCallback(object : MediaProjection.Callback() {
                override fun onStop() {
                    cleanup()
                }
            }, handler)
        }

        val windowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val width: Int
        val height: Int
        val densityDpi: Int

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            val bounds = windowManager.currentWindowMetrics.bounds
            width = bounds.width()
            height = bounds.height()
            densityDpi = resources.configuration.densityDpi
        } else {
            val metrics = DisplayMetrics()
            @Suppress("DEPRECATION")
            windowManager.defaultDisplay.getRealMetrics(metrics)
            width = metrics.widthPixels
            height = metrics.heightPixels
            densityDpi = metrics.densityDpi
        }

        captureWidth = width
        captureHeight = height
        // One held frame plus room for acquireLatestImage() to swap in a newer one.
        val maxImages = 3
        imageReader = ImageReader.newInstance(width, height, PixelFormat.RGBA_8888, maxImages)
        virtualDisplay = mediaProjection?.createVirtualDisplay(
            "GhostScanDisplay",
            width,
            height,
            densityDpi,
            DisplayManager.VIRTUAL_DISPLAY_FLAG_AUTO_MIRROR,
            imageReader!!.surface,
            null,
            handler
        )

        handler.postDelayed(timeoutRunnable, 3500)
        handler.postDelayed(settleRunnable, SETTLE_DELAY_MS)

        // Runs on the main handler. Keeps only the newest frame; once the screen has
        // settled, the held frame (or the next one to arrive) is used.
        imageReader?.setOnImageAvailableListener({ reader ->
            if (hasCaptured) return@setOnImageAvailableListener
            val image = try {
                reader.acquireLatestImage()
            } catch (_: IllegalStateException) {
                null
            } ?: return@setOnImageAvailableListener
            heldImage?.close()
            heldImage = image
            if (settled) useHeldImage()
        }, handler)
    }

    private fun useHeldImage() {
        if (hasCaptured) return
        val image = heldImage ?: return
        heldImage = null
        hasCaptured = true
        handler.removeCallbacks(timeoutRunnable)
        val width = captureWidth
        val height = captureHeight

        Thread {
            try {
                val planes = image.planes
                val buffer = planes[0].buffer
                val pixelStride = planes[0].pixelStride
                val rowStride = planes[0].rowStride
                val rowPadding = rowStride - pixelStride * width

                val bitmap = Bitmap.createBitmap(
                    width + rowPadding / pixelStride,
                    height,
                    Bitmap.Config.ARGB_8888
                )
                bitmap.copyPixelsFromBuffer(buffer)
                image.close()

                val finalBitmap = if (rowPadding > 0) {
                    Bitmap.createBitmap(bitmap, 0, 0, width, height)
                } else {
                    bitmap
                }

                val blocked = isAlmostAllBlack(finalBitmap)

                val cacheFile = File(cacheDir, "ghost_scan_${System.currentTimeMillis()}.jpg")
                FileOutputStream(cacheFile).use { out ->
                    finalBitmap.compress(Bitmap.CompressFormat.JPEG, 92, out)
                }

                val launchIntent = Intent(this@GhostScanCaptureService, MainActivity::class.java).apply {
                    action = "in.sreerajp.qr_studio.ACTION_GHOST_SCAN"
                    putExtra("image_path", cacheFile.absolutePath)
                    putExtra(GhostScanActivity.EXTRA_FROM_BUBBLE, fromBubble)
                    putExtra(EXTRA_BLOCKED, blocked)
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_CLEAR_TOP)
                }
                startActivity(launchIntent)
            } catch (e: Exception) {
                e.printStackTrace()
            } finally {
                cleanup()
                stopForegroundAndSelf()
            }
        }.start()
    }

    /**
     * Apps that block screen capture (FLAG_SECURE) come back as a black frame.
     * Samples a grid of pixels; true when nearly all of them are very dark.
     */
    private fun isAlmostAllBlack(bitmap: Bitmap): Boolean {
        val steps = 24
        var dark = 0
        var total = 0
        for (i in 1 until steps) {
            for (j in 1 until steps) {
                val x = bitmap.width * i / steps
                val y = bitmap.height * j / steps
                val pixel = bitmap.getPixel(x, y)
                val r = (pixel shr 16) and 0xFF
                val g = (pixel shr 8) and 0xFF
                val b = pixel and 0xFF
                if (r < 12 && g < 12 && b < 12) dark++
                total++
            }
        }
        return total > 0 && dark * 100 / total >= 98
    }

    private fun cleanup() {
        handler.removeCallbacks(settleRunnable)
        try {
            heldImage?.close()
            heldImage = null
            virtualDisplay?.release()
            virtualDisplay = null
            imageReader?.close()
            imageReader = null
            mediaProjection?.stop()
            mediaProjection = null
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun stopForegroundAndSelf() {
        handler.post {
            if (fromBubble) ScanBubbleService.showAgain(this)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                stopForeground(STOP_FOREGROUND_REMOVE)
            } else {
                @Suppress("DEPRECATION")
                stopForeground(true)
            }
            stopSelf()
        }
    }

    override fun onDestroy() {
        cleanup()
        super.onDestroy()
    }
}
