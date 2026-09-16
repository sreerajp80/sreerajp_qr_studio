# Change Log — Wi-Fi Direct Connect

**Plan:** `plans/20260914_203600_wifi_direct_connect.md`

## Summary
Upgraded the Wi-Fi action button from a "Copy password & open settings" shortcut to true 1-tap direct connection. The app now connects to scanned Wi-Fi networks directly using Android's native Wi-Fi suggestion and network connection APIs via a dedicated platform channel.

## Changes Made

### Android Native Layer
- **`android/app/src/main/AndroidManifest.xml`**:
  - Added normal Wi-Fi and network permissions: `ACCESS_WIFI_STATE`, `CHANGE_WIFI_STATE`, `ACCESS_NETWORK_STATE`, and `CHANGE_NETWORK_STATE`.
- **`android/app/src/main/kotlin/in/sreerajp/qr_reader/MainActivity.kt`**:
  - Registered `MethodChannel("in.sreeraj.qr_reader/wifi")`.
  - Implemented `connectWifi` handling SSID, password, security type (WPA/WPA2/WPA3/WEP/Open), and hidden network flag:
    - Android 11+ (API 30+): Launches `Settings.ACTION_WIFI_ADD_NETWORKS` intent with `WifiNetworkSuggestion` extras list, showing Android's native system dialog to save and connect.
    - Android 10 (API 29): Calls `WifiManager.addNetworkSuggestions()`.
    - Android 9 and lower (API 24–28): Connects using `WifiManager.addNetwork()` and `WifiManager.enableNetwork()`.

### Flutter Services Layer
- **`lib/services/payload_action_service.dart`**:
  - Updated `connectToWifi(WifiPayload wifi)` to invoke the native `in.sreeraj.qr_reader/wifi` MethodChannel before falling back to settings.
  - Wrapped `openWifiSettings()` in try-catch to safeguard against platform exceptions.

### Flutter UI Layer
- **`lib/screens/widgets/wifi_action_card.dart`**:
  - Removed automatic clipboard copying of the password on connect button press.
  - Shows localized confirmation feedback (`wifiConnectSuccess`) when connection is requested.
  - Copies password and displays settings hint only if native connection is unsupported or fails.

### Localization
- **`lib/l10n/app_en.arb`**, **`lib/l10n/app_ml.arb`**, **`lib/l10n/app_sa.arb`**:
  - Added tri-lingual key `wifiConnectSuccess` with full key parity:
    - English: `"Connection requested for {ssid}"`
    - Malayalam: `"{ssid} ശൃംഖലയിലേക്ക് ബന്ധിപ്പിക്കാനുള്ള അഭ്യർത്ഥന നൽകി."`
    - Sanskrit: `"{ssid} संजालाय संयोजनानुरोधः प्रेषितः।"`
  - Ran `flutter gen-l10n`.

### Documentation
- **`docs/feature_improvements_and_roadmap.md`**:
  - Updated item 2.4.1 to mark direct Wi-Fi suggestion as implemented.

### Verification
- **`test/services/payload_action_service_test.dart`**:
  - Added unit tests for `PayloadActionService.connectToWifi` verifying parameter mapping and graceful exception handling.
- Ran `flutter analyze` — 0 issues found.
- Ran `flutter test` — All 201 tests passed.
