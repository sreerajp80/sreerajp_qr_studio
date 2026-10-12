package `in`.sreerajp.qr_studio

import android.annotation.SuppressLint
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.graphics.PixelFormat
import android.graphics.drawable.GradientDrawable
import android.net.Uri
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.provider.Settings
import android.service.quicksettings.TileService
import android.util.TypedValue
import android.view.Gravity
import android.view.MotionEvent
import android.view.View
import android.view.WindowManager
import android.widget.FrameLayout
import android.widget.ImageView
import androidx.core.app.NotificationCompat
import kotlin.math.abs
import kotlin.math.hypot

/**
 * Foreground service that draws the floating "Scan bubble" over other apps.
 *
 * - Tap: hides the bubble and starts the existing one-frame GhostScan capture
 *   (Android shows its own screen capture consent prompt every time).
 * - Drag: moves the bubble; on release it snaps to the nearest side edge.
 * - Drag onto the close target at the bottom: turns the bubble off.
 *
 * The service never captures the screen by itself. It only starts
 * [GhostScanActivity] after a user tap.
 */
class ScanBubbleService : Service() {
    companion object {
        const val ACTION_START = "in.sreerajp.qr_studio.SCAN_BUBBLE_START"
        const val ACTION_STOP = "in.sreerajp.qr_studio.SCAN_BUBBLE_STOP"
        const val ACTION_SHOW = "in.sreerajp.qr_studio.SCAN_BUBBLE_SHOW"

        private const val NOTIFICATION_ID = 4402
        private const val CHANNEL_ID = "scan_bubble_channel"
        private const val BUBBLE_SIZE_DP = 56
        private const val CLOSE_TARGET_SIZE_DP = 64
        private const val CLOSE_TARGET_MARGIN_DP = 48
        private const val TOUCH_SLOP_DP = 8
        private const val CAPTURE_FALLBACK_MS = 15000L

        @Volatile
        var isRunning: Boolean = false
            private set

        fun canDrawOverlays(context: Context): Boolean =
            Build.VERSION.SDK_INT < Build.VERSION_CODES.M || Settings.canDrawOverlays(context)

        /** Intent that opens the system "Display over other apps" page for this app. */
        fun overlayPermissionIntent(context: Context): Intent =
            Intent(
                Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                Uri.parse("package:${context.packageName}")
            ).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

        /** Starts the bubble. Returns false if the overlay permission is missing. */
        fun start(context: Context): Boolean {
            if (!canDrawOverlays(context)) return false
            val intent = Intent(context, ScanBubbleService::class.java).setAction(ACTION_START)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
            ScanBubblePrefs.setEnabled(context, true)
            return true
        }

        fun stop(context: Context) {
            ScanBubblePrefs.setEnabled(context, false)
            if (isRunning) {
                try {
                    context.startService(
                        Intent(context, ScanBubbleService::class.java).setAction(ACTION_STOP)
                    )
                } catch (_: Exception) {
                    // Fallback: stopping the service directly also removes the bubble.
                    context.stopService(Intent(context, ScanBubbleService::class.java))
                }
            }
        }

        /** Asks a running bubble to show itself again (after a capture or a cancelled prompt). */
        fun showAgain(context: Context) {
            if (!isRunning) return
            try {
                context.startService(
                    Intent(context, ScanBubbleService::class.java).setAction(ACTION_SHOW)
                )
            } catch (_: Exception) {
                // Service could not be reached; the fallback timer re-shows the bubble.
            }
        }
    }

    private lateinit var windowManager: WindowManager
    private val handler = Handler(Looper.getMainLooper())
    private var bubbleView: View? = null
    private var bubbleParams: WindowManager.LayoutParams? = null
    private var closeTargetView: View? = null
    private val showRunnable = Runnable { setBubbleVisible(true) }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onCreate() {
        super.onCreate()
        windowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_STOP -> {
                stopBubble()
                return START_NOT_STICKY
            }
            ACTION_SHOW -> {
                handler.removeCallbacks(showRunnable)
                setBubbleVisible(true)
                return START_NOT_STICKY
            }
        }

        startForegroundNotification()
        if (!canDrawOverlays(this)) {
            stopBubble()
            return START_NOT_STICKY
        }
        if (bubbleView == null) {
            addBubble()
        }
        isRunning = true
        requestTileRefresh()
        return START_NOT_STICKY
    }

    private fun startForegroundNotification() {
        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                getString(R.string.scan_bubble_channel_name),
                NotificationManager.IMPORTANCE_LOW
            ).apply {
                description = getString(R.string.scan_bubble_channel_description)
                setShowBadge(false)
            }
            notificationManager.createNotificationChannel(channel)
        }

        val stopIntent = PendingIntent.getService(
            this,
            1,
            Intent(this, ScanBubbleService::class.java).setAction(ACTION_STOP),
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )
        val openIntent = PendingIntent.getActivity(
            this,
            2,
            Intent(this, MainActivity::class.java).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP),
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )

        val notification: Notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle(getString(R.string.scan_bubble_notification_title))
            .setContentText(getString(R.string.scan_bubble_notification_text))
            .setSmallIcon(R.drawable.ic_scan_bubble)
            .setContentIntent(openIntent)
            .addAction(0, getString(R.string.scan_bubble_notification_turn_off), stopIntent)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .setCategory(NotificationCompat.CATEGORY_SERVICE)
            .setOngoing(true)
            .build()

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            startForeground(
                NOTIFICATION_ID,
                notification,
                ServiceInfo.FOREGROUND_SERVICE_TYPE_SPECIAL_USE
            )
        } else {
            startForeground(NOTIFICATION_ID, notification)
        }
    }

    private fun overlayType(): Int =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
        } else {
            @Suppress("DEPRECATION")
            WindowManager.LayoutParams.TYPE_PHONE
        }

    private fun dp(value: Int): Int =
        TypedValue.applyDimension(
            TypedValue.COMPLEX_UNIT_DIP,
            value.toFloat(),
            resources.displayMetrics
        ).toInt()

    private fun screenWidth(): Int =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            windowManager.currentWindowMetrics.bounds.width()
        } else {
            resources.displayMetrics.widthPixels
        }

    private fun screenHeight(): Int =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            windowManager.currentWindowMetrics.bounds.height()
        } else {
            resources.displayMetrics.heightPixels
        }

    private fun circleBackground(color: Int): GradientDrawable =
        GradientDrawable().apply {
            shape = GradientDrawable.OVAL
            setColor(color)
        }

    @SuppressLint("ClickableViewAccessibility")
    private fun addBubble() {
        val size = dp(BUBBLE_SIZE_DP)
        val icon = ImageView(this).apply {
            setImageResource(R.drawable.ic_scan_bubble)
            val pad = dp(14)
            setPadding(pad, pad, pad, pad)
            background = circleBackground(0xEE1565C0.toInt())
            elevation = dp(6).toFloat()
            contentDescription = getString(R.string.scan_bubble_content_description)
        }
        val container = FrameLayout(this).apply {
            addView(icon, FrameLayout.LayoutParams(size, size))
        }

        val params = WindowManager.LayoutParams(
            size,
            size,
            overlayType(),
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
                WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
            PixelFormat.TRANSLUCENT
        ).apply {
            gravity = Gravity.TOP or Gravity.START
            val savedX = ScanBubblePrefs.getX(this@ScanBubbleService)
            val savedY = ScanBubblePrefs.getY(this@ScanBubbleService)
            x = if (savedX >= 0) savedX else screenWidth() - size
            y = if (savedY >= 0) savedY else screenHeight() / 3
        }

        container.setOnTouchListener(BubbleTouchListener())

        try {
            windowManager.addView(container, params)
            bubbleView = container
            bubbleParams = params
        } catch (_: Exception) {
            stopBubble()
        }
    }

    private fun showCloseTarget() {
        if (closeTargetView != null) return
        val size = dp(CLOSE_TARGET_SIZE_DP)
        val target = ImageView(this).apply {
            setImageResource(R.drawable.ic_bubble_close_target)
            val pad = dp(18)
            setPadding(pad, pad, pad, pad)
            background = circleBackground(0xCC000000.toInt())
        }
        val params = WindowManager.LayoutParams(
            size,
            size,
            overlayType(),
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
                WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE,
            PixelFormat.TRANSLUCENT
        ).apply {
            gravity = Gravity.BOTTOM or Gravity.CENTER_HORIZONTAL
            y = dp(CLOSE_TARGET_MARGIN_DP)
        }
        try {
            windowManager.addView(target, params)
            closeTargetView = target
        } catch (_: Exception) {
            closeTargetView = null
        }
    }

    private fun hideCloseTarget() {
        closeTargetView?.let {
            try {
                windowManager.removeView(it)
            } catch (_: Exception) {
            }
        }
        closeTargetView = null
    }

    /** True when the bubble centre is close to the close target centre. */
    private fun isOverCloseTarget(params: WindowManager.LayoutParams): Boolean {
        val bubbleSize = dp(BUBBLE_SIZE_DP)
        val targetSize = dp(CLOSE_TARGET_SIZE_DP)
        val bubbleCx = params.x + bubbleSize / 2f
        val bubbleCy = params.y + bubbleSize / 2f
        val targetCx = screenWidth() / 2f
        val targetCy = screenHeight() - dp(CLOSE_TARGET_MARGIN_DP) - targetSize / 2f
        return hypot(bubbleCx - targetCx, bubbleCy - targetCy) < targetSize
    }

    private fun snapToEdge(params: WindowManager.LayoutParams) {
        val size = dp(BUBBLE_SIZE_DP)
        val width = screenWidth()
        params.x = if (params.x + size / 2 < width / 2) 0 else width - size
        params.y = params.y.coerceIn(0, (screenHeight() - size).coerceAtLeast(0))
        updateBubbleLayout(params)
        ScanBubblePrefs.setPosition(this, params.x, params.y)
    }

    private fun updateBubbleLayout(params: WindowManager.LayoutParams) {
        val view = bubbleView ?: return
        try {
            windowManager.updateViewLayout(view, params)
        } catch (_: Exception) {
        }
    }

    private fun setBubbleVisible(visible: Boolean) {
        bubbleView?.visibility = if (visible) View.VISIBLE else View.GONE
    }

    private fun onBubbleTapped() {
        setBubbleVisible(false)
        // Safety net: show the bubble again even if no callback arrives.
        handler.removeCallbacks(showRunnable)
        handler.postDelayed(showRunnable, CAPTURE_FALLBACK_MS)
        // Give the window manager a moment to remove the bubble from the screen.
        handler.postDelayed({
            try {
                val intent = Intent(this, GhostScanActivity::class.java).apply {
                    putExtra(GhostScanActivity.EXTRA_FROM_BUBBLE, true)
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
                }
                startActivity(intent)
            } catch (_: Exception) {
                handler.removeCallbacks(showRunnable)
                setBubbleVisible(true)
            }
        }, 150)
    }

    private inner class BubbleTouchListener : View.OnTouchListener {
        private var startX = 0
        private var startY = 0
        private var touchX = 0f
        private var touchY = 0f
        private var dragging = false

        override fun onTouch(view: View, event: MotionEvent): Boolean {
            val params = bubbleParams ?: return false
            when (event.action) {
                MotionEvent.ACTION_DOWN -> {
                    startX = params.x
                    startY = params.y
                    touchX = event.rawX
                    touchY = event.rawY
                    dragging = false
                    return true
                }
                MotionEvent.ACTION_MOVE -> {
                    val dx = event.rawX - touchX
                    val dy = event.rawY - touchY
                    if (!dragging && (abs(dx) > dp(TOUCH_SLOP_DP) || abs(dy) > dp(TOUCH_SLOP_DP))) {
                        dragging = true
                        showCloseTarget()
                    }
                    if (dragging) {
                        params.x = startX + dx.toInt()
                        params.y = startY + dy.toInt()
                        updateBubbleLayout(params)
                        closeTargetView?.scaleX = if (isOverCloseTarget(params)) 1.25f else 1f
                        closeTargetView?.scaleY = closeTargetView?.scaleX ?: 1f
                    }
                    return true
                }
                MotionEvent.ACTION_UP -> {
                    if (dragging) {
                        val close = isOverCloseTarget(params)
                        hideCloseTarget()
                        if (close) {
                            ScanBubblePrefs.setEnabled(this@ScanBubbleService, false)
                            stopBubble()
                        } else {
                            snapToEdge(params)
                        }
                    } else {
                        view.performClick()
                        onBubbleTapped()
                    }
                    dragging = false
                    return true
                }
                MotionEvent.ACTION_CANCEL -> {
                    if (dragging) {
                        hideCloseTarget()
                        snapToEdge(params)
                    }
                    dragging = false
                    return true
                }
            }
            return false
        }
    }

    private fun removeBubble() {
        hideCloseTarget()
        bubbleView?.let {
            try {
                windowManager.removeView(it)
            } catch (_: Exception) {
            }
        }
        bubbleView = null
        bubbleParams = null
    }

    private fun stopBubble() {
        ScanBubblePrefs.setEnabled(this, false)
        handler.removeCallbacksAndMessages(null)
        removeBubble()
        isRunning = false
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            stopForeground(STOP_FOREGROUND_REMOVE)
        } else {
            @Suppress("DEPRECATION")
            stopForeground(true)
        }
        stopSelf()
        requestTileRefresh()
    }

    private fun requestTileRefresh() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            try {
                TileService.requestListeningState(
                    this,
                    ComponentName(this, ScanBubbleTileService::class.java)
                )
            } catch (_: Exception) {
            }
        }
    }

    override fun onDestroy() {
        handler.removeCallbacksAndMessages(null)
        removeBubble()
        isRunning = false
        requestTileRefresh()
        super.onDestroy()
    }
}
