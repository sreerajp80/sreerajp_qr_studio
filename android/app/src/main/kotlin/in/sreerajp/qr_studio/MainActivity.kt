package `in`.sreerajp.qr_studio

import android.content.Context
import android.content.Intent
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.net.wifi.WifiConfiguration
import android.net.wifi.WifiManager
import android.net.wifi.WifiNetworkSuggestion
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.io.File
import android.content.ClipboardManager
import android.app.StatusBarManager
import android.content.ComponentName
import android.graphics.drawable.Icon
import android.content.pm.ShortcutInfo
import android.content.pm.ShortcutManager
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.WindowManager

class MainActivity: FlutterFragmentActivity() {
    private val lightChannel = "in.sreerajp.qr_studio/ambient_light"
    private val wifiChannel = "in.sreerajp.qr_studio/wifi"
    private val clipboardChannel = "in.sreerajp.qr_studio/clipboard"
    private val ghostScanChannel = "in.sreerajp.qr_studio/ghost_scan"
    private val scanBubbleChannel = "in.sreerajp.qr_studio/scan_bubble"
    private val windowChannel = "in.sreerajp.qr_studio/window"
    private var pendingGhostScanCapture: Map<String, Any>? = null
    private var ghostScanMethodChannel: MethodChannel? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        publishScanBubbleShortcut()
    }

    /**
     * Publishes the "Start scan bubble" app icon shortcut from code, so it
     * points at the right package for every build flavor.
     */
    private fun publishScanBubbleShortcut() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.N_MR1) return
        try {
            val shortcutManager = getSystemService(ShortcutManager::class.java) ?: return
            val intent = Intent(this, ScanBubbleShortcutActivity::class.java)
                .setAction(Intent.ACTION_VIEW)
            val shortcut = ShortcutInfo.Builder(this, "start_scan_bubble")
                .setShortLabel(getString(R.string.scan_bubble_shortcut_short))
                .setLongLabel(getString(R.string.scan_bubble_shortcut_long))
                .setIcon(Icon.createWithResource(this, R.drawable.ic_shortcut_scan_bubble))
                .setIntent(intent)
                .build()
            shortcutManager.dynamicShortcuts = listOf(shortcut)
        } catch (_: Exception) {
            // Shortcuts are optional; never fail app start because of them.
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Screenshot / screen-recording protection for sensitive screens
        // (FLAG_SECURE). Dart turns it on while such a screen is open.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, windowChannel).setMethodCallHandler { call, result ->
            when (call.method) {
                "setSecure" -> {
                    val secure = call.argument<Boolean>("secure") ?: false
                    runOnUiThread {
                        if (secure) {
                            window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        } else {
                            window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        }
                        result.success(true)
                    }
                }
                else -> result.notImplemented()
            }
        }

        val sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        val lightSensor = sensorManager.getDefaultSensor(Sensor.TYPE_LIGHT)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, lightChannel).setStreamHandler(
            object : EventChannel.StreamHandler {
                private var listener: SensorEventListener? = null

                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    if (lightSensor == null) {
                        events?.error("UNAVAILABLE", "Ambient light sensor not available on this device", null)
                        return
                    }
                    listener = object : SensorEventListener {
                        override fun onSensorChanged(event: SensorEvent?) {
                            if (event != null && event.values.isNotEmpty()) {
                                events?.success(event.values[0].toDouble())
                            }
                        }

                        override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
                            // Accuracy changes are not needed for ambient lux tracking
                        }
                    }
                    sensorManager.registerListener(listener, lightSensor, SensorManager.SENSOR_DELAY_NORMAL)
                }

                override fun onCancel(arguments: Any?) {
                    listener?.let { sensorManager.unregisterListener(it) }
                    listener = null
                }
            }
        )

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, wifiChannel).setMethodCallHandler { call, result ->
            if (call.method == "connectWifi") {
                val ssid = call.argument<String>("ssid") ?: ""
                val password = call.argument<String>("password") ?: ""
                val securityType = (call.argument<String>("securityType") ?: "WPA").uppercase()
                val isHidden = call.argument<Boolean>("isHidden") ?: false

                try {
                    val success = connectToWifi(ssid, password, securityType, isHidden)
                    result.success(success)
                } catch (e: Exception) {
                    result.error("WIFI_CONNECT_ERROR", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, clipboardChannel).setMethodCallHandler { call, result ->
            if (call.method == "getClipboardImage") {
                try {
                    val imagePath = getClipboardImagePath()
                    result.success(imagePath)
                } catch (e: Exception) {
                    result.error("CLIPBOARD_IMAGE_ERROR", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        }

        ghostScanMethodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ghostScanChannel).apply {
            setMethodCallHandler { call, result ->
                when (call.method) {
                    "isSupported" -> {
                        result.success(true)
                    }
                    "isTileRequestSupported" -> {
                        val supported = Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU
                        result.success(supported)
                    }
                    "requestAddTile" -> {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                            try {
                                val statusBarManager = getSystemService(Context.STATUS_BAR_SERVICE) as StatusBarManager
                                val componentName = ComponentName(this@MainActivity, GhostScanTileService::class.java)
                                statusBarManager.requestAddTileService(
                                    componentName,
                                    getString(R.string.ghost_scan_tile_label),
                                    Icon.createWithResource(this@MainActivity, R.drawable.ic_ghost_scan_tile),
                                    mainExecutor
                                ) { statusCode ->
                                    val success = statusCode == StatusBarManager.TILE_ADD_REQUEST_RESULT_TILE_ADDED ||
                                        statusCode == StatusBarManager.TILE_ADD_REQUEST_RESULT_TILE_ALREADY_ADDED
                                    result.success(success)
                                }
                            } catch (e: Exception) {
                                result.error("TILE_REQUEST_ERROR", e.message, null)
                            }
                        } else {
                            result.success(false)
                        }
                    }
                    "startGhostScan" -> {
                        try {
                            moveTaskToBack(true)
                            Handler(Looper.getMainLooper()).postDelayed({
                                val intent = Intent(this@MainActivity, GhostScanActivity::class.java).apply {
                                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
                                }
                                startActivity(intent)
                            }, 350)
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("GHOST_SCAN_START_ERROR", e.message, null)
                        }
                    }
                    "getInitialGhostScanImage" -> {
                        val capture = pendingGhostScanCapture
                        pendingGhostScanCapture = null
                        result.success(capture)
                    }
                    else -> result.notImplemented()
                }
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, scanBubbleChannel).setMethodCallHandler { call, result ->
            try {
                when (call.method) {
                    "canDrawOverlays" -> result.success(ScanBubbleService.canDrawOverlays(this))
                    "openOverlayPermissionSettings" -> {
                        startActivity(ScanBubbleService.overlayPermissionIntent(this))
                        result.success(true)
                    }
                    "startBubble" -> result.success(ScanBubbleService.start(this))
                    "stopBubble" -> {
                        ScanBubbleService.stop(this)
                        result.success(true)
                    }
                    "isBubbleRunning" -> result.success(ScanBubbleService.isRunning)
                    "clearData" -> {
                        ScanBubbleService.stop(this)
                        ScanBubblePrefs.clear(this)
                        result.success(true)
                    }
                    "isStartOnBoot" -> result.success(ScanBubblePrefs.isStartOnBoot(this))
                    "setStartOnBoot" -> {
                        ScanBubblePrefs.setStartOnBoot(this, call.argument<Boolean>("value") ?: false)
                        result.success(true)
                    }
                    "isTileRequestSupported" -> {
                        result.success(Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)
                    }
                    "requestAddTile" -> {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                            val statusBarManager = getSystemService(Context.STATUS_BAR_SERVICE) as StatusBarManager
                            statusBarManager.requestAddTileService(
                                ComponentName(this@MainActivity, ScanBubbleTileService::class.java),
                                getString(R.string.scan_bubble_tile_label),
                                Icon.createWithResource(this@MainActivity, R.drawable.ic_scan_bubble),
                                mainExecutor
                            ) { statusCode ->
                                result.success(
                                    statusCode == StatusBarManager.TILE_ADD_REQUEST_RESULT_TILE_ADDED ||
                                        statusCode == StatusBarManager.TILE_ADD_REQUEST_RESULT_TILE_ALREADY_ADDED
                                )
                            }
                        } else {
                            result.success(false)
                        }
                    }
                    else -> result.notImplemented()
                }
            } catch (e: Exception) {
                result.error("SCAN_BUBBLE_ERROR", e.message, null)
            }
        }

        handleGhostScanIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        handleGhostScanIntent(intent)
    }

    private fun handleGhostScanIntent(intent: Intent?) {
        if (intent?.action == "in.sreerajp.qr_studio.ACTION_GHOST_SCAN") {
            val imagePath = intent.getStringExtra("image_path")
            if (imagePath != null) {
                val capture = mapOf<String, Any>(
                    "imagePath" to imagePath,
                    "fromBubble" to intent.getBooleanExtra(GhostScanActivity.EXTRA_FROM_BUBBLE, false),
                    "blocked" to intent.getBooleanExtra(GhostScanCaptureService.EXTRA_BLOCKED, false)
                )
                if (ghostScanMethodChannel != null) {
                    ghostScanMethodChannel?.invokeMethod("onGhostScanImage", capture)
                } else {
                    pendingGhostScanCapture = capture
                }
            }
        }
    }


    private fun getClipboardImagePath(): String? {
        val clipboard = getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
        if (!clipboard.hasPrimaryClip()) return null
        val clip = clipboard.primaryClip ?: return null
        if (clip.itemCount == 0) return null

        val item = clip.getItemAt(0)
        val uri = item.uri
        val mimeType = clip.description?.getMimeType(0)

        val isImageMime = clip.description?.hasMimeType("image/*") == true
        val isImageUri = uri != null && (contentResolver.getType(uri)?.startsWith("image/") == true ||
                uri.toString().lowercase().endsWith(".png") ||
                uri.toString().lowercase().endsWith(".jpg") ||
                uri.toString().lowercase().endsWith(".jpeg") ||
                uri.toString().lowercase().endsWith(".webp"))

        if (uri != null && (isImageMime || isImageUri)) {
            try {
                val inputStream = contentResolver.openInputStream(uri) ?: return null
                val resolvedMime = contentResolver.getType(uri) ?: mimeType
                val ext = when {
                    resolvedMime?.contains("png") == true -> ".png"
                    resolvedMime?.contains("webp") == true -> ".webp"
                    else -> ".jpg"
                }
                val tempFile = File(cacheDir, "clipboard_image_${System.currentTimeMillis()}$ext")
                tempFile.outputStream().use { output ->
                    inputStream.copyTo(output)
                }
                inputStream.close()
                return tempFile.absolutePath
            } catch (e: Exception) {
                return null
            }
        }
        return null
    }

    private fun connectToWifi(ssid: String, password: String, securityType: String, isHidden: Boolean): Boolean {
        if (ssid.isEmpty()) return false

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            // Android 10+ (API 29+)
            val suggestionBuilder = WifiNetworkSuggestion.Builder()
                .setSsid(ssid)
                .setIsHiddenSsid(isHidden)

            if (securityType.contains("WPA3") || securityType.contains("SAE")) {
                if (password.isNotEmpty()) {
                    suggestionBuilder.setWpa3Passphrase(password)
                }
            } else if (securityType.contains("WPA") || securityType.contains("WEP")) {
                if (password.isNotEmpty()) {
                    suggestionBuilder.setWpa2Passphrase(password)
                }
            }

            val suggestion = suggestionBuilder.build()
            val suggestionsList = arrayListOf(suggestion)

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                // Android 11+ (API 30+): System Add Networks dialog
                val intent = Intent(Settings.ACTION_WIFI_ADD_NETWORKS).apply {
                    putParcelableArrayListExtra(Settings.EXTRA_WIFI_NETWORK_LIST, suggestionsList)
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                }
                startActivity(intent)
                return true
            } else {
                // Android 10 (API 29)
                val wifiManager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
                val status = wifiManager.addNetworkSuggestions(suggestionsList)
                return status == WifiManager.STATUS_NETWORK_SUGGESTIONS_SUCCESS
            }
        } else {
            // Android 9 and lower (API 24-28)
            @Suppress("DEPRECATION")
            val wifiConfig = WifiConfiguration().apply {
                SSID = "\"$ssid\""
                hiddenSSID = isHidden
                if (securityType.contains("WEP")) {
                    wepKeys[0] = "\"$password\""
                    wepTxKeyIndex = 0
                    allowedKeyManagement.set(WifiConfiguration.KeyMgmt.NONE)
                    allowedGroupCiphers.set(WifiConfiguration.GroupCipher.WEP40)
                } else if (securityType.contains("WPA")) {
                    preSharedKey = "\"$password\""
                } else {
                    allowedKeyManagement.set(WifiConfiguration.KeyMgmt.NONE)
                }
            }
            val wifiManager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
            if (!wifiManager.isWifiEnabled) {
                @Suppress("DEPRECATION")
                wifiManager.isWifiEnabled = true
            }
            @Suppress("DEPRECATION")
            val netId = wifiManager.addNetwork(wifiConfig)
            if (netId != -1) {
                @Suppress("DEPRECATION")
                wifiManager.disconnect()
                @Suppress("DEPRECATION")
                wifiManager.enableNetwork(netId, true)
                @Suppress("DEPRECATION")
                wifiManager.reconnect()
                return true
            }
            return false
        }
    }
}

