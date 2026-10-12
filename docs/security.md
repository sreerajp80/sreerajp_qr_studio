# Security — SreerajP QR Studio

This document defines the security rules, threat model, sensitive data handling, cryptography design, and permissions for SreerajP QR Studio. Read this before touching permissions, logging, storage, cryptography, or the Android manifest.

**Read first:**
- [CLAUDE.md](../CLAUDE.md)
- [AGENTS.md](../AGENTS.md)
- [architecture.md](architecture.md)
- [guidelines/security.md](guidelines/security.md)
- [guidelines/flutter_project_engineering_standard.md](guidelines/flutter_project_engineering_standard.md)

---

## 1. Security Scope

- App: SreerajP QR Studio
- Engineering standard profiles in force:
  - `Core Baseline`
  - `Sensitive Data Extension` (StegoQR encryption, biometric authentication, encrypted history database, API key protection)
- Platforms in scope:
  - Android only (minSdk 24, targetSdk 36, compileSdk 37)

---

## 2. Security Objectives

- Protect users against malicious QR phishing ("quishing"), fraudulent redirects, and homograph impersonation attacks.
- Provide a safe, isolated DOM sandbox to inspect untrusted web destinations before launching in an external browser.
- Protect confidential StegoQR content using military-grade symmetric encryption (AES-256) and optional biometric verification (`local_auth`).
- Isolate the Google Safe Browsing API key behind the Android KeyStore (`flutter_secure_storage`) and prevent device backup leakage.
- Ensure the app operates strictly offline by default, preventing tracking and scan data exfiltration.

---

## 3. Threat Model Summary

### In Scope Threats
- **Phishing & Quishing:** QR codes containing deceptive URLs, homograph attacks, IP addresses, URL shorteners, or malicious redirect chains.
- **Physical QR Sticker Tampering:** Malicious QR code stickers placed over legitimate printed QR codes.
- **StegoQR Decryption by Unauthorized Parties:** Attempted extraction of secret messages embedded in StegoQR codes.
- **Device Backup Exposure:** Extraction of stored scan history or developer API keys via Android Auto Backup or `adb backup`.
- **Credential Leakage in Logs:** Accidental output of sensitive URLs, StegoQR plaintexts, or API keys in debug/release logs.

### Out Of Scope Threats
- Fully compromised or rooted devices with kernel-level debuggers attached.
- Physical memory-dump hardware extraction attacks.
- Attacks subverting the Android OS biometric hardware HAL.

---

## 4. Sensitive Data Inventory

| Data Type | Example | Where It Exists | Protection Required |
|---|---|---|---|
| Google Safe Browsing API key | `AIzaSy...` | `flutter_secure_storage`, briefly in memory during HTTP check | Android KeyStore; never logged, never in `SharedPreferences` |
| StegoQR Passphrase / Secret Text | User passphrase | Memory only during decrypt; not persisted | Never persisted to disk; wiped from memory on dismiss |
| Scan History Database | Scanned QR payloads | Local SQLite database (`sqflite`) | Sandboxed app data directory; excluded from cloud backups |
| Biometric Credentials | Fingerprint / Face | Android OS BiometricPrompt hardware enclave | Never accessible to app; boolean success/failure only |
| Daily Request Counters | Integer | `SharedPreferences` | Plaintext local preferences (non-sensitive) |

---

## 5. Storage Model

### At Rest
- **Secure Key Storage:** `flutter_secure_storage` backed by the Android KeyStore.
- **Scan History Database:** Local SQLite database at app-private storage (`path_provider`).
- **User Preferences:** `shared_preferences` for non-sensitive UI settings (theme, language selection, sound toggles).
- **Backup Policy:** `android:allowBackup="false"` in `AndroidManifest.xml` prevents all local databases, preferences, and keys from being backed up via Google Drive or ADB.

### In Memory
- Sensitive plaintexts (such as decrypted StegoQR messages or Safe Browsing API keys) are held strictly in ephemeral local state and discarded when the user leaves the screen.

### In Transit
- Google Safe Browsing and redirect verification requests use HTTPS with TLS.
- AirQR optical transmission uses pure optical sequences (screen-to-camera) with zero RF, Bluetooth, or network transit.

---

## 6. Cryptography Design

### StegoQR Payload Protection
- **Cipher:** AES-GCM (256-bit key) via `encrypt` and `pointycastle`.
- **Key Derivation:** PBKDF2 with SHA-256, 10,000 iterations, and a unique cryptographic salt embedded in the payload header.
- **Integrity & Authenticity:** AES-GCM authentication tag verifies that neither the payload nor the encrypted secret has been tampered with.
- **Fingerprinting:** SHA-256 hashing (`crypto`) produces deterministic checksums of scanned codes for history deduplication.

### Rules
- Never use ECB mode or static initialization vectors (IVs).
- API keys must never be hardcoded into source code.
- Plaintexts and passphrases must never appear in `debugPrint` or log statements.

---

## 7. Authentication And Access Control

- **StegoQR Biometric Gating:** Users can configure fingerprint or facial recognition via `local_auth` to protect secret decryption.
- **Biometric Fallback:** If biometric hardware is unavailable or fails, fallback to passphrase prompt is provided.
- **Session Timeout:** Unlocked StegoQR contents lock immediately upon navigating away from `ResultScreen`.

---

## 8. Logging And Telemetry Policy

### Never Log
- API key values.
- Scanned barcode contents that contain tokens, credentials, or personal messages.
- Decrypted StegoQR contents or entered passphrases.

### Allowed Diagnostic Context
- Operation descriptions (`'Google Safe Browsing check completed'`).
- Error categories without user data payloads.

### Logging Implementation
- `debugPrint` is used for non-production diagnostic messages.
- All diagnostic logs are gated behind Flutter's `kDebugMode`.

### No Third-Party Telemetry In The Scanner
- Barcode decoding uses the vendored zxing-cpp engine (`native/`) through dart:ffi. It has no
  network code.
- Google ML Kit (and its `com.google.android.datatransport` usage metrics) was removed. A release
  APK must contain no `com.google.mlkit`, `com.google.android.datatransport` or `com.google.firebase`
  classes. Check with `dexdump` on the built APK before a release.
- `ScannedCode.toString()` never includes the decoded content, so codes cannot leak into logs.

---

## 9. Platform Security Controls

### Android Manifest (`android/app/src/main/AndroidManifest.xml`)
- `android:allowBackup="false"` — blocks automated backup exfiltration.
- Cleartext HTTP traffic is disabled by default.

---

## 10. Permissions

| Permission | Why It Is Needed | Requested When | Denial Handling |
|---|---|---|---|
| `CAMERA` | Live camera preview and barcode scanning | When the Scanner, AR CodeVision or AirQR receiver screen opens (point of use) | Friendly permission-denied message with a button to ask again |
| `USE_BIOMETRIC` | Biometric authentication for StegoQR reveal | When user taps "Unlock with Biometrics" | Falls back to manual passphrase entry |
| `INTERNET` | Optional Safe Browsing checks & sandboxed page preview | When online checks are triggered | Gracefully degrades; offline checks continue to function |
| `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION` | CodeForge "Use my location" fills a map-location QR code with the current position (one reading, through `LocationService`; never stored or sent anywhere) | Only when the user taps "Use my location" | A friendly message is shown; the user can type the coordinates by hand |
| `ACCESS_WIFI_STATE`, `CHANGE_WIFI_STATE`, `ACCESS_NETWORK_STATE`, `CHANGE_NETWORK_STATE` | "Connect to Wi-Fi" on a scanned Wi-Fi QR code asks Android to add that network (Android 11+ system prompt, Android 10 network suggestion, older versions direct add) | Install-time (normal permissions); used only when the user taps "Connect to Wi-Fi" | If adding fails, the Android Wi-Fi settings screen opens instead |

Scan vibration uses Flutter's `HapticFeedback` (system haptics), so the app does
not declare the `VIBRATE` permission.
| `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_MEDIA_PROJECTION` | GhostScan one-frame screen capture service | When the user taps the GhostScan tile, menu item, or Scan bubble | Android shows its own screen capture consent prompt every time; if cancelled, nothing is captured |
| `SYSTEM_ALERT_WINDOW` ("Display over other apps") | Draws the floating Scan bubble over other apps | Only when the user turns the Scan bubble on; the app explains it first, then opens the system page | Bubble stays off; the rest of the app works normally |
| `FOREGROUND_SERVICE_SPECIAL_USE` | Keeps the Scan bubble service alive while the bubble is on (Android requires a visible notification) | When the bubble is turned on | Bubble cannot start; a friendly error is shown |
| `POST_NOTIFICATIONS` | Shows "Scan bubble is on" with a Turn off button | When the bubble is first turned on (Android 13+) | Bubble still works; the notification is just hidden |
| `RECEIVE_BOOT_COMPLETED` | Brings the Scan bubble back after a phone restart | Only acts if the user turned on "Start after restart" and the bubble was on | Bubble stays off after restart; the user can start it from the tile |

### Screen capture rules (GhostScan and Scan bubble)
- The screen is captured only after a user action (tile tap, menu tap, or bubble tap), and only after Android's own consent prompt.
- Exactly one frame is taken. The projection, virtual display, and image reader are released right after.
- The frame is saved only in the app cache, decoded on the device, and then deleted. It is never written to the gallery or sent online.
- The floating bubble hides itself before the capture so it is not in the picture.
- An almost all-black frame (an app that blocks capture) is reported to the user instead of being treated as "no code found".
- The bubble service only draws a button. It never captures the screen by itself. Its native preferences hold only on/off flags and the bubble position.

---

## 10a. Native Code Safety

Scanned codes are attacker-controlled input, and the decoder is C++. So:

- `srb_read` checks width, height, row stride, rotation, format mask and the real buffer length
  before reading. A short or malformed buffer returns an error, never an over-read.
- Every C++ exception is caught inside the bridge; nothing crosses into Dart.
- At most 32 codes per image and a 16384-pixel side limit bound memory use.
- Decoding runs on a background isolate; a failure returns an empty list (hard rule 4).
- Upstream zxing-cpp runs sanitizers (ASan, UBSan, TSan), CodeQL and fuzzing in its CI. Check
  upstream release notes for security fixes when updating (`native/zxing-cpp/UPSTREAM.md`).
- `integration_test/barcode_decoder_test.dart` feeds noise, short buffers, bad arguments and
  corrupt images to the real native library on a device.

---

## 11. Security Testing Strategy

| Area | Test Type | Notes |
|---|---|---|
| URL Pattern & Homograph Detection | Unit | Deterministic string checks; `url_safety_service_test.dart` |
| StegoQR Encryption / Decryption | Unit | Tested in `encrypted_payload_service_test.dart` |
| Safe Browsing Client Mocking | Unit | Tested using `MockClient` without real network calls |
| Keystore & Secure Storage | Unit / Widget | Verified using in-memory mocks |
