package `in`.sreeraj.qr_reader

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

class MainActivity: FlutterFragmentActivity() {
    private val lightChannel = "in.sreeraj.qr_reader/ambient_light"
    private val wifiChannel = "in.sreeraj.qr_reader/wifi"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
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

