# Security — SreerajP QR Reader

This document defines the security rules, threat model, sensitive data handling, cryptography design, and permissions for SreerajP QR Reader. Read this before touching permissions, logging, storage, cryptography, or the Android manifest.

**Read first:**
- [CLAUDE.md](../CLAUDE.md)
- [AGENTS.md](../AGENTS.md)
- [architecture.md](architecture.md)
- [guidelines/security.md](guidelines/security.md)
- [guidelines/flutter_project_engineering_standard.md](guidelines/flutter_project_engineering_standard.md)

---

## 1. Security Scope

- App: SreerajP QR Reader
- Engineering standard profiles in force:
  - `Core Baseline`
  - `Sensitive Data Extension` (StegoQR encryption, biometric authentication, encrypted history database, API key protection)
- Platforms in scope:
  - Android only (minSdk 24, targetSdk 35, compileSdk 37)

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

---

## 9. Platform Security Controls

### Android Manifest (`android/app/src/main/AndroidManifest.xml`)
- `android:allowBackup="false"` — blocks automated backup exfiltration.
- Cleartext HTTP traffic is disabled by default.

---

## 10. Permissions

| Permission | Why It Is Needed | Requested When | Denial Handling |
|---|---|---|---|
| `CAMERA` | Live camera preview and barcode scanning | First scan attempt on `ScannerScreen` | Friendly permission-denied UI shown with button to open Android Settings |
| `USE_BIOMETRIC` | Biometric authentication for StegoQR reveal | When user taps "Unlock with Biometrics" | Falls back to manual passphrase entry |
| `INTERNET` | Optional Safe Browsing checks & sandboxed page preview | When online checks are triggered | Gracefully degrades; offline checks continue to function |
| `VIBRATE` | Tactile haptic feedback on successful scan | At scan time | Silently skipped if permission or hardware missing |

---

## 11. Security Testing Strategy

| Area | Test Type | Notes |
|---|---|---|
| URL Pattern & Homograph Detection | Unit | Deterministic string checks; `url_safety_service_test.dart` |
| StegoQR Encryption / Decryption | Unit | Tested in `encrypted_payload_service_test.dart` |
| Safe Browsing Client Mocking | Unit | Tested using `MockClient` without real network calls |
| Keystore & Secure Storage | Unit / Widget | Verified using in-memory mocks |
