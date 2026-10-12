# Wi-Fi Direct Connect Action Plan

**Status:** completed

## Problem
When a user scans a Wi-Fi QR code and taps "Connect to Wi-Fi", the app currently copies the Wi-Fi password to the clipboard and redirects the user to the Android Wi-Fi settings page. It does not connect to the network directly. The user expected the action button to connect directly to the Wi-Fi network instead of opening the settings screen.

## Proposed Fix
Implement a native Android platform channel that connects directly to the scanned Wi-Fi network using Android's native Wi-Fi connection and network suggestion APIs, with zero settings detour.

### 1. Android Manifest Permissions
File: `android/app/src/main/AndroidManifest.xml`
- Add normal Wi-Fi and network permissions:
  - `android.permission.ACCESS_WIFI_STATE`
  - `android.permission.CHANGE_WIFI_STATE`
  - `android.permission.ACCESS_NETWORK_STATE`
  - `android.permission.CHANGE_NETWORK_STATE`
- These are normal install-time permissions that do not require runtime permission popups.

### 2. Native Android Platform Channel
File: `android/app/src/main/kotlin/in/sreerajp/qr_reader/MainActivity.kt`
- Register `MethodChannel("in.sreeraj.qr_reader/wifi")`.
- Implement `connectWifi` method handling SSID, password, security type (WPA/WPA2/WPA3/WEP/Open), and hidden network flag:
  - On Android 11+ (API 30+): Create `WifiNetworkSuggestion` and start `Settings.ACTION_WIFI_ADD_NETWORKS` intent. This opens the native Android system dialog allowing the user to save and connect to the network with 1 tap.
  - On Android 10 (API 29): Call `WifiManager.addNetworkSuggestions()`.
  - On Android 9 and lower (API 24–28): Use `WifiManager.addNetwork()` and `WifiManager.enableNetwork()`.

### 3. Flutter Service Layer
File: `lib/services/payload_action_service.dart`
- In `connectToWifi(WifiPayload wifi)`, invoke the native `in.sreeraj.qr_reader/wifi` MethodChannel.
- Return `true` when the native connection request is triggered.
- Fall back to opening Wi-Fi settings only if the platform channel fails or is unsupported.

### 4. Wi-Fi Action Card UI
File: `lib/screens/widgets/wifi_action_card.dart`
- In the "Connect to Wi-Fi" button handler, remove the automatic password clipboard copy.
- Call `PayloadActionService.connectToWifi(wifi)`.
- If connection request succeeds, show a success snackbar ("Connection requested for [SSID]").
- Only copy password and show settings hint if the native connection fails and falls back to settings.

### 5. Localization (Tri-lingual key parity)
Files:
- `lib/l10n/app_en.arb`
- `lib/l10n/app_ml.arb`
- `lib/l10n/app_sa.arb`
- Add `wifiConnectSuccess` key with `{ssid}` placeholder across all 3 ARB files.
- Run `flutter gen-l10n`.

### 6. Automated Testing & Verification
File: `test/services/payload_action_service_test.dart`
- Add unit tests verifying `PayloadActionService.connectToWifi` handles MethodChannel invocations correctly.
- Run `flutter analyze` (must be 0 errors, 0 warnings).
- Run `flutter test` (all tests must pass).
