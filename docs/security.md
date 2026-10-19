# Security — SreerajP QR Studio

This document holds the security design of SreerajP QR Studio: scope, threat model, data
inventory, storage, cryptography, platform controls, permissions, the OWASP Mobile Top 10
sign-off, data retention, and the open risks. Read it before touching permissions, logging,
storage, cryptography, exports, or the Android manifest.

The `Sensitive Data Extension` is in force (`docs/PROJECT_PROFILE.md` §2), so every section is
filled in.

**Read first:**
- [CLAUDE.md](../CLAUDE.md) / [AGENTS.md](../AGENTS.md)
- [PROJECT_PROFILE.md](PROJECT_PROFILE.md)
- [architecture.md](architecture.md)
- [release_process.md](release_process.md)
- [guidelines/security.md](guidelines/security.md) (template) and
  [guidelines/flutter_project_engineering_standard.md](guidelines/flutter_project_engineering_standard.md) §15

---

## 1. Security Scope

- App: SreerajP QR Studio (`in.sreerajp.qr_studio`)
- Data sensitivity level: **moderate** — scanned content can hold personal data, Wi-Fi
  passwords, payment links and one-time-password seeds; StegoQR secrets; user API keys.
- Engineering standard profiles in force:
  - `Core Baseline`
  - `Production App Extension`
  - `Sensitive Data Extension` (encrypted scan history, StegoQR encryption, biometric reveal, API
    keys in secure storage)
- Platforms in scope: **Android only** (minSdk 24, targetSdk 36, compileSdk 37).

---

## 2. Security Objectives

- Protect users against malicious QR phishing ("quishing"), fraudulent redirects and homograph
  impersonation, with checks that work offline.
- Let users inspect untrusted web pages in an isolated DOM sandbox before opening them.
- Protect StegoQR secrets with AES-256-GCM and optional biometric verification (`local_auth`).
- Protect stored scan history from casual extraction on a lost or stolen device (field
  encryption, key in Android KeyStore, no backups).
- Keep user API keys only in the Android KeyStore (`flutter_secure_storage`).
- Prevent accidental disclosure through logs, backups and exports.
- Work offline by default: no tracking, no telemetry, no scan data leaves the phone unless the
  user turns on an online check or shares something.
- Meet the OWASP Mobile Top 10 controls (§12).

---

## 3. Threat Model Summary

### In Scope Threats
- **Phishing and quishing:** QR codes with deceptive URLs, homographs, raw IP hosts, URL
  shorteners, or malicious redirect chains.
- **Physical QR sticker tampering:** a malicious sticker placed over a real printed code.
- **StegoQR decryption by unauthorized people.**
- **Lost or stolen device:** reading the history database or keys from app storage.
- **Device backup exposure:** history, settings or keys leaking through Android Auto Backup or
  `adb backup`.
- **Credential or content leakage in logs.**
- **Shoulder-surfing and screenshots** of sensitive screens (`FLAG_SECURE`, §10.1; app lock, §7).
- **Reverse engineering** of the release binary (raised cost through obfuscation, §8).
- **Malformed or hostile barcode images** reaching the native C++ decoder (§10.3).

### Out Of Scope Threats
- Fully compromised or rooted devices with kernel-level debuggers attached.
- Physical memory-dump hardware attacks.
- Attacks that break the Android OS, KeyStore or BiometricPrompt hardware.
- Nation-state adversaries.

---

## 4. Sensitive Data Inventory

| Data Type | Example | Where It Exists | Protection Required |
|---|---|---|---|
| User API keys (Google Safe Browsing, VirusTotal, …) | `AIzaSy...` | `flutter_secure_storage`; briefly in memory during an online check | Android KeyStore; never logged, never in `SharedPreferences`; deleted by the user or "Delete all data" |
| StegoQR passphrase / secret text | User passphrase | Memory only while decrypting | Never written to disk; dropped when the user leaves the screen |
| Scan history | Scanned payloads, notes, location tags, thumbnails, metadata | SQLite `sreeraj_scan_history.db` | Content fields encrypted with AES-256-GCM (§6); key in Android KeyStore; app-private storage; no backups |
| History encryption key | 32 random bytes | `flutter_secure_storage` (`db_encryption_key_v1`) | Android KeyStore; never logged |
| History exports and AirQR sync packages | CSV / JSON / TXT / PDF files, `.sreerajqr` backups, AirQR sync packages | Created on demand, then shared, saved or sent over AirQR by the user | Backups and sync packages: PBKDF2 + AES-256-GCM (§6.3); plain-text formats only after a warning (§14) |
| Biometric data | Fingerprint / face | Android BiometricPrompt hardware | Never reaches the app; only success/failure |
| Settings and counters | Theme, language, daily request counter | `SharedPreferences` | Not sensitive; plain local storage |
| Screen capture frames | One GhostScan frame | App cache, then deleted | Taken only after the user's action and Android's consent; never saved to the gallery |

---

## 5. Storage Model

### At Rest
- Primary local storage: SQLite (`sqflite`), app-private documents directory; field-encrypted
  (§6). Schema and migrations: [architecture.md](architecture.md) §14.
- Secure key storage: `flutter_secure_storage` backed by the Android KeyStore.
- Preferences: `SharedPreferences` for non-sensitive settings only.
- Native preferences: `scan_bubble_prefs` (bubble on/off, start on boot, position) — not
  sensitive.
- Temporary files: the app cache (GhostScan frames, clipboard images, CodeForge exports).
- Backup behavior: **disabled** — `android:allowBackup="false"` keeps all of the above out of
  Google Drive and `adb` backups.

### In Memory
- Decrypted StegoQR messages and API keys are kept in short-lived screen or provider state and
  dropped when the user leaves the screen.
- Decrypted history records are held by `HistoryProvider` while the History screen is used; they
  are cleared by "Delete all data".

### In Transit
- Network use: optional and opt-in only — Google Safe Browsing, VirusTotal, URLhaus, PhishTank
  and OpenPhish checks, redirect resolution ("active probing"), and the sandboxed page preview.
- Transport protection: HTTPS/TLS only; cleartext HTTP is not allowed (no
  `usesCleartextTraffic`, no network security config, targetSdk 36 default). No certificate
  pinning.
- AirQR transfers data screen-to-camera only — no radio or network.

---

## 6. Cryptography Design

Only the design is written here, never key material.

### 6.1 StegoQR payload protection
- **Cipher:** AES-256-GCM via `encrypt` / `pointycastle`; the GCM tag checks that neither the
  payload nor the secret was changed.
- **Key derivation:** PBKDF2-HMAC-SHA256 with a random salt stored in the payload header —
  10,000 iterations for the StegoQR payload format, 200,000 for AirQR encrypted transfers. The
  10,000 count is kept so existing StegoQR codes still open (see §17).
- **Fingerprinting:** SHA-256 (`crypto`) gives a checksum of a scanned code for history
  de-duplication; it is not used as a key.

### 6.2 Scan history field encryption
- **Code:** `lib/services/history_field_cipher.dart`, used by `HistoryDatabaseService`.
- **Fields:** `rawContent`, `imageThumbnail`, `locationTag`, `notes`, `metadata`. Other columns
  (id, time, format, category, score, favorite flag) stay plain so the list can be sorted and
  filtered.
- **Cipher:** AES-256-GCM with a **new random 12-byte nonce for every value**; the 16-byte tag
  is checked on every read.
- **Format versioning:** stored as `h2:` + base64url(nonce ‖ ciphertext ‖ tag); the `h2:`
  prefix is the version.
- **Key:** 32 random bytes from `Random.secure()`, stored in Android KeyStore through
  `flutter_secure_storage` (`db_encryption_key_v1`). A new key is used only after it was saved
  and read back. If the key cannot be read, history does not open and the stored key is never
  overwritten.
- **No plain-text fallback:** if encryption fails, the save fails (`StorageException`).
- **Legacy support:** values written before v2 (AES-CBC with a key-derived fixed IV, or plain
  text from the old fallback) are only read, and are re-encrypted to v2 in one transaction the
  first time the database opens. The upgrade is idempotent.
- **Tampering:** a v2 value whose tag fails is not shown; the row is skipped, logged by count
  only, and kept on disk.

### 6.3 Passphrase-protected backups and AirQR sync packages
- **Code:** `lib/services/passphrase_cipher.dart` (`PassphraseCipher`), used by
  `HistoryExportService` (`.sreerajqr` backups) and `DeviceSyncService` (AirQR sync packages).
- **Format v2** — headers `SREERAJ_QR_BACKUP_V2` and `SREERAJ_AIRQR_SYNC_V2`; fields `kdf`
  (`pbkdf2-hmac-sha256`), `iterations`, `salt`, `nonce`, `data`, all base64url:
  - key: PBKDF2-HMAC-SHA256, **600,000 iterations** (OWASP 2023), random 16-byte salt;
  - cipher: AES-256-GCM with a random 12-byte nonce; the tag is checked on open;
  - the iteration count is stored, so it can be raised later; values outside 10,000–10,000,000
    are rejected;
  - key derivation runs in a background isolate with a progress dialog (a few seconds on a
    phone).
- Sync packages also keep `recordsCount`, `hasSettings` and `timestamp` readable, so the
  receiver can show a summary before the passphrase is entered.
- **Legacy v1** (`SREERAJ_QR_BACKUP_V1`, `SREERAJ_AIRQR_SYNC_V1`: key = SHA-256 of the
  passphrase, IV = first 16 key bytes, AES-CBC, no tag) is **read only**, so old files still
  restore. New files are always v2.
- A wrong passphrase and a changed file both give the localized "wrong passphrase" message;
  broken fields give "invalid format". Nothing is written on failure.

### Rules
- Keys, IVs, salts and passwords are never hard-coded (checked: no API key or secret literal in
  `lib/` or `android/`).
- Randomness uses `Random.secure()`.
- Encrypted formats are versioned (`h2:` for history; `SREERAJ_QR_BACKUP_V1` for backups).
- Never use ECB mode or static IVs for new formats.
- Plaintexts and passphrases never appear in logs (§9).

---

## 7. Authentication And Access Control

- App-lock strategy: **optional app lock**, off by default — Settings → Privacy → **App lock**
  (`AppLockProvider`, `AppLockGate`). Unlock with fingerprint, face or the phone's screen lock
  (`BiometricService`, `local_auth` with device-credential fallback).
- Turning it on needs one successful authentication; if the phone has no screen lock or
  biometrics, it explains that and stays off. Turning it off also needs authentication.
- Lock rule: locked at app start, and when the app comes back after **30 seconds or more** in
  the background (`paused`/`hidden`). Shorter trips (gallery, file picker, share sheet,
  permission screens, the unlock prompt itself) do not lock, so those flows keep working.
- Lock screen: `lib/widgets/app_lock_gate.dart`, placed in `MaterialApp.builder` above every
  route, dialog and sheet; while locked the app behind it is not painted, not reachable by
  touch and hidden from screen readers. The system prompt opens once by itself; an Unlock button
  retries.
- StegoQR biometric gating: revealing a StegoQR secret can require fingerprint or face, with a
  passphrase fallback; an unlocked secret is hidden again when the user leaves `ResultScreen`.
- "Delete all data" turns the app lock off (its setting is a preference).

---

## 8. Binary Protections

### 8.1 Obfuscation
- Every production release build uses
  `--obfuscate --split-debug-info=build/symbols/android-prod-<version>/`
  (`tool/build_release.sh`, [release_process.md](release_process.md) §6.1).
- Obfuscation raises the cost of casual inspection; it is not a security boundary on its own.
- Debug symbols are archived securely for the life of each released version, never committed
  (`build/` is ignored), and used only for crash symbolication.

### 8.2 R8 / ProGuard
- R8 full mode is on by default for release builds (AGP 9).
- `android/app/proguard-rules.pro` is referenced by the release build type. Flutter and every
  plugin ship their own consumer rules; the file keeps this app's own Android components
  explicitly. Barcode decoding uses dart:ffi, which needs no keep rules.
- Test the release build end to end after adding a dependency; R8 problems only show in release
  builds.

### 8.3 Debuggable flag
- `android:debuggable` is not set in the manifest, so Gradle sets it to `false` for release
  builds. Verify in the merged release manifest before every production release
  ([release_process.md](release_process.md) §6.4).

---

## 9. Logging And Telemetry Policy

### Never Log
- API key values, the history key, passphrases.
- Scanned content, decrypted StegoQR text, notes, location tags.
- Raw exception messages in production (they can contain scanned content).

### Allowed Diagnostic Context
- Operation names (`'Inserting scan record failed'`), step names (`'Delete all data:
  preferences cleared'`), counts (`'Upgraded 3 history rows to format v2'`), error type names.

### Logging Controls
- Logger: `AppLogger` (`lib/core/logging/app_logger.dart`, engineering standard §14). `print`
  and `debugPrint` are not used in `lib/`.
- Verbose gate: `trace`/`debug` only when `AppFlavorConfig.enableVerboseLogging` (dev flavor).
- Production: `info` and above; an error is logged by its **type name only**, with no stack
  trace.
- Output: console (`dart:developer`) only; no log files are written.
- `ScannedCode.toString()` never includes the decoded content.

### No Third-Party Telemetry
- Barcode decoding uses the vendored zxing-cpp engine (`native/`) through dart:ffi; it has no
  network code.
- Google ML Kit (and its `com.google.android.datatransport` usage metrics) was removed. A release
  APK must contain no `com.google.mlkit`, `com.google.android.datatransport` or
  `com.google.firebase` classes — check with `dexdump` before a release.
- No analytics, crash reporting or ads SDKs (blocked in `CLAUDE.md`).

---

## 10. Platform Security Controls

### 10.1 Android manifest and window
- `android:allowBackup="false"` — required under the Sensitive Data Extension; no
  `fullBackupContent` is needed because nothing is backed up.
- Cleartext traffic: not allowed (no `usesCleartextTraffic`, no network security config).
- `android:debuggable`: `false` in release (§8.3).
- Exported components: only `MainActivity` (launcher) and the two Quick Settings tile services
  (`GhostScanTileService`, `ScanBubbleTileService`, protected by
  `BIND_QUICK_SETTINGS_TILE`). All other services, activities and the boot receiver are
  `exported="false"`.
- **Screenshot protection (`FLAG_SECURE`) on sensitive screens:** History and its detail sheet,
  Result (scan content, StegoQR secrets, Wi-Fi passwords, TOTP codes), the API keys screen, both
  AirQR screens, the export/backup dialog and the batch review sheet. `SecureScreen`
  (`lib/widgets/secure_screen.dart`) turns the flag on through the
  `in.sreerajp.qr_studio/window` channel (`ScreenSecurityService`, with a counter for nested
  screens). Screenshots and screen recording of those screens are blocked and the recent-apps
  preview is blank. Scanner, CodeForge, Help, About and the main Settings page stay capturable.
  The guard is **on by default**. The user can turn it off with the **Screenshot guard** switch
  in Settings → Privacy (`ScreenSecurityProvider`, preference `screen_security_enabled`). When it
  is off, the counter keeps running but the flag is never set; turning it back on applies at once
  to any open sensitive screen. "Delete all data" clears preferences, so the guard is on again
  after a wipe.
- Root / integrity detection: none (out of scope, §3).

### 10.2 Screen capture rules (GhostScan and Scan bubble)
- The screen is captured only after a user action (tile tap, menu tap, or bubble tap), and only
  after Android's own consent prompt.
- Exactly one frame is taken. The projection, virtual display and image reader are released
  right after.
- The frame is saved only in the app cache, decoded on the device, and then deleted. It is never
  written to the gallery or sent online.
- The floating bubble hides itself before the capture so it is not in the picture.
- An almost all-black frame (an app that blocks capture) is reported to the user instead of
  being treated as "no code found".
- The bubble service only draws a button. It never captures the screen by itself. Its native
  preferences hold only on/off flags and the bubble position.

### 10.3 Native code safety
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

### 10.4 Other platforms
iOS, Windows, macOS and Linux are not declared platforms; their controls do not apply.

---

## 11. Permissions

| Permission | Why It Is Needed | Requested When | Denial Handling |
|---|---|---|---|
| `CAMERA` | Live camera preview and barcode scanning | When the Scanner, AR CodeVision or AirQR receiver screen opens (point of use) | Friendly permission-denied message with a button to ask again |
| `USE_BIOMETRIC` | Biometric authentication for StegoQR reveal | When the user taps "Unlock with Biometrics" | Falls back to manual passphrase entry |
| `INTERNET` | Optional online link checks and the sandboxed page preview | When an online check is turned on and used | Offline checks keep working |
| `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION` | CodeForge "Use my location" fills a map-location QR code with the current position (one reading, through `LocationService`; never stored or sent anywhere) | Only when the user taps "Use my location" | A friendly message; the user can type the coordinates |
| `ACCESS_WIFI_STATE`, `CHANGE_WIFI_STATE`, `ACCESS_NETWORK_STATE`, `CHANGE_NETWORK_STATE` | "Connect to Wi-Fi" on a scanned Wi-Fi QR code asks Android to add that network (Android 11+ system prompt, Android 10 network suggestion, older versions direct add) | Install-time (normal permissions); used only when the user taps "Connect to Wi-Fi" | If adding fails, the Android Wi-Fi settings screen opens |
| `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_MEDIA_PROJECTION` | GhostScan one-frame screen capture service | When the user taps the GhostScan tile, menu item, or Scan bubble | Android shows its own consent prompt every time; if cancelled, nothing is captured |
| `SYSTEM_ALERT_WINDOW` ("Display over other apps") | Draws the floating Scan bubble over other apps | Only when the user turns the Scan bubble on; the app explains it first, then opens the system page | Bubble stays off; the rest of the app works |
| `FOREGROUND_SERVICE_SPECIAL_USE` | Keeps the Scan bubble service alive while the bubble is on (Android requires a visible notification) | When the bubble is turned on | Bubble cannot start; a friendly error is shown |
| `POST_NOTIFICATIONS` | Shows "Scan bubble is on" with a Turn off button | When the bubble is first turned on (Android 13+) | Bubble still works; the notification is hidden |
| `RECEIVE_BOOT_COMPLETED` | Brings the Scan bubble back after a phone restart | Only acts if the user turned on "Start after restart" and the bubble was on | Bubble stays off after restart |

| `USE_FINGERPRINT` | Added by the `local_auth` plugin; the older-Android form of `USE_BIOMETRIC` | Same as `USE_BIOMETRIC` | Same as `USE_BIOMETRIC` |

Scan vibration uses Flutter's `HapticFeedback` (system haptics), so the app does not declare
the `VIBRATE` permission.

The `camera` plugin adds `RECORD_AUDIO` and `WRITE_EXTERNAL_STORAGE` (which also implies
`READ_EXTERNAL_STORAGE`). The app never records audio (the camera opens with
`enableAudio: false`) and never saves camera files, so `AndroidManifest.xml` removes all three
with `tools:node="remove"`.

The in-app Permissions screen (Settings → Permissions, `kPermissionGroups` in
`lib/screens/settings_screen.dart`) explains every permission in this table in plain words.
`test/screens/permissions_manifest_parity_test.dart` fails if the manifest gains a permission
that the screen does not explain.

Permission review rules: request only what is used; ask dangerous permissions at the point of
use; the app keeps working in a safe, reduced way when a non-critical permission is denied.
Check the merged release manifest for unexpected permissions before every release.

---

## 12. OWASP Mobile Top 10 Compliance

A MUST sign-off before every production release (engineering standard §15.3). Status as of
**2026-10-13**; owner: app maintainer.

| ID | Risk | Control in this app | Status |
|---|---|---|---|
| M1 | Improper Credential Usage | No hard-coded secrets; user API keys and the history key only in Android KeyStore | verified |
| M2 | Inadequate Supply Chain Security | `pubspec.lock` committed; Dependabot (`pub`, `github-actions`); open-source-only rule; vendored zxing-cpp with `UPSTREAM.md`; licences checked per release ([release_process.md](release_process.md) §8) | verified |
| M3 | Insecure Authentication | No accounts; optional app lock (start + 30 s background) with biometrics or screen lock; biometrics gate StegoQR reveal (§7) | verified |
| M4 | Insufficient Input/Output Validation | Parsers never crash on bad input (hard rule 4); parameterized SQL only (`sqflite` query/insert/update); native decoder bounds-checks every buffer (§10.3) | verified |
| M5 | Insecure Communication | HTTPS-only online checks; cleartext not allowed; online checks are opt-in | verified |
| M6 | Inadequate Privacy Controls | Data inventory (§4); no content in logs (§9); no backups; `FLAG_SECURE` on sensitive screens (§10.1); "Delete all data" (§13) | verified |
| M7 | Insufficient Binary Protections | `--obfuscate` + split debug info in release builds; `debuggable=false` in release; R8 with `proguard-rules.pro` | verified |
| M8 | Security Misconfiguration | Minimal permissions (§11); explicit `allowBackup=false`; only needed components exported; prod release builds fail without the release key | verified |
| M9 | Insecure Data Storage | History fields AES-256-GCM; nothing sensitive in `SharedPreferences`; plain-text exports only after a warning (§14) | verified |
| M10 | Insufficient Cryptography | Versioned GCM formats with random nonces (history, backups, sync); PBKDF2 600,000 iterations with random salt; no hard-coded keys | verified (StegoQR payload KDF count: see §17) |

Phase 9b (2026-10-13) closed the items that were `open`. A production release must not ship
with an item `open`; any `risk-accepted` item needs its reason and owner here.

---

## 13. Data Retention And Purge Policy

### Retention schedule

| Data | Where | Kept until |
|---|---|---|
| Scan history (content fields encrypted) | SQLite `sreeraj_scan_history.db` (+ WAL/SHM files) | The user deletes a record, uses "Clear All", uses "Delete all data", or uninstalls |
| History encryption key, user API keys | Android KeyStore via `flutter_secure_storage` | "Delete all data", deleting the API key in Settings, or uninstall |
| Settings (language, theme, onboarding flag, feedback, privacy, counters) | Flutter `SharedPreferences` | "Delete all data" or uninstall |
| Scan bubble settings (on/off, start on boot, position) | Native `scan_bubble_prefs` | "Delete all data" or uninstall |
| Temporary files (GhostScan captures, clipboard images, CodeForge exports) | App cache folder | Removed by Android when space is low, by "Delete all data", or on uninstall |
| Logs | Console only | Not stored (no log files) |

Nothing is copied to a cloud service; `android:allowBackup="false"` keeps data out of Android
backups, so uninstalling removes everything.

### "Delete all data"

Settings → Privacy → **Delete all data** (`DataWipeService`) asks for confirmation, then:

1. closes the history database and deletes the file with its `-wal`, `-shm`, `-journal` files;
2. deletes every secure-storage entry (history key and API keys);
3. clears all `SharedPreferences`;
4. stops the Scan bubble and clears its native settings;
5. deletes everything in the app cache folder.

Every step runs even if an earlier one fails; failures are logged by step name and the user is
told "Some data could not be deleted". The app then restarts its widget tree, so it opens like a
fresh install (onboarding, system language).

---

## 14. Backup, Import, Export, And Recovery

- Backup supported: yes — an encrypted `.sreerajqr` backup of the history with a passphrase
  (`HistoryExportService`), format v2 (§6.3).
- Import supported: yes — `.sreerajqr` restore (v2 and old v1). A bad file or wrong passphrase
  gives a localized error (`BackupException` with a message key); nothing is written on failure;
  raw exception text is never shown.
- Device sync: AirQR sync packages (settings + history) use the same v2 format; the receiver also
  recognises v1/v2 backups sent over AirQR.
- Plain-text export: CSV, JSON, TXT and PDF (history and batch scans) are made only after a
  warning — "This file is not encrypted…" with Cancel / Export anyway; the history dialog also
  points to the encrypted backup (`confirmPlainTextExport`).
- Recovery: there is no cloud copy; a lost backup passphrase cannot be recovered.
- Android system backup: disabled (`allowBackup="false"`).

---

## 15. Security Testing Strategy

| Area | Test Type | Notes |
|---|---|---|
| URL pattern and homograph detection | Unit | Deterministic string checks; `url_safety_service_test.dart` |
| StegoQR encryption / decryption | Unit | `encrypted_payload_service_test.dart` |
| Online checks | Unit | `MockClient` from `package:http/testing.dart`; no real network calls |
| Secure storage | Unit / Widget | In-memory fakes |
| History field encryption | Unit | `history_field_cipher_test.dart`, `history_database_service_test.dart` (tamper, wrong key, legacy upgrade, key errors) |
| Database migrations | Unit | `history_database_schema_test.dart` (v1 → v2 keeps every row) |
| Delete all data | Unit / Widget | `data_wipe_service_test.dart`, `settings_screen_test.dart` (every store cleared, partial failure, restart) |
| Logging | Unit | `app_logger_test.dart` (prod hides error text and stack traces) |
| Backups and sync packages | Unit | `passphrase_cipher_test.dart`, `history_export_service_test.dart`, `device_sync_service_test.dart` (v2 round trip, random salt/nonce, wrong passphrase, tampering, v1 still read) |
| Screenshot protection | Unit / Widget | `screen_security_service_test.dart` (counter, on/off, `SecureScreen`), `screen_security_provider_test.dart` (default on, saved choice), `settings_screen_test.dart` (switch) |
| App lock | Unit / Widget | `app_lock_provider_test.dart`, `app_lock_gate_test.dart`, `settings_screen_test.dart` |
| Plain-text export warning | Widget | `plain_text_export_confirm_test.dart` |
| Native decoder | Integration (device) | `integration_test/barcode_decoder_test.dart` (noise, short buffers, corrupt images) |
| Obfuscation, debuggable, permissions | Release build check | [release_process.md](release_process.md) §6, §8 |

Deterministic vectors: the legacy history format is tested with a fixed key and text produced
by the exact old scheme; migrations are tested from the frozen v1 SQL.

---

## 16. Incident Response Notes

- Triage owner: app maintainer.
- Severity model: **critical** — user data or keys exposed, or a remote attack path;
  **high** — a security control missing or broken; **medium/low** — hardening gaps.
- Immediate containment:
  - halt or pause the staged rollout in Google Play Console; stop sharing the direct APK;
  - prepare a hotfix build ([release_process.md](release_process.md) §13).
- User communication trigger: any critical incident, or a high one that touched stored user
  data — through the store listing's "What's new" text and the GitHub repository.
- Patch release process: [release_process.md](release_process.md) §13.

---

## 17. Open Risks And Future Hardening

| Risk | Hardening option | Plan |
|---|---|---|
| StegoQR payload format uses 10,000 PBKDF2 iterations | A new payload version with a higher count; keep reading the old one | Future |
| A legacy history value that is really plain text but looks like valid CBC ciphertext would be misread | Very unlikely; disappears once all rows are v2 | Accepted |
| No certificate pinning for online checks | Pinning would break when providers rotate certificates; online checks are optional | Accepted |
| App lock waits 30 s before locking after a trip to the background | Needed so pickers and the share sheet keep working; sensitive screens are already hidden from recents by `FLAG_SECURE` (unless the user turned the screenshot guard off) | Accepted |
| The user can turn the screenshot guard off; then sensitive screens can be captured and show in recents | The user's own choice (for example, to screenshot a result). On by default; no authentication is asked to turn it off | Accepted |
| `pdfx` plugin applies the Kotlin Gradle Plugin; future Flutter versions will reject this | Update `pdfx` when a built-in-Kotlin release exists, or replace it | Watch |
| Device checks not yet done: `FLAG_SECURE`, app lock, v2 backup restore, prod R8 build signed with the release key | Do them on a real phone before release ([release_process.md](release_process.md) §8) | Release item |

---

## 18. Security Review Checklist

Complete before every production release.

- [ ] Threat model reviewed and current (§3).
- [ ] Sensitive data inventory updated (§4).
- [ ] Logging reviewed — no new log statement prints user data (§9).
- [ ] Storage and backup behavior reviewed; `allowBackup="false"` still set (§5, §10).
- [ ] Permissions reviewed in the merged release manifest (§11).
- [ ] `--obfuscate --split-debug-info` used for every release artifact (§8.1).
- [ ] Debug symbols archived for this version.
- [ ] `android:debuggable=false` verified in the merged release manifest (§8.3).
- [ ] ProGuard / R8 rules verified (§8.2).
- [ ] No ML Kit / Firebase / datatransport classes in the APK (`dexdump`, §9).
- [ ] OWASP Mobile Top 10 table (§12) reviewed; no item left `open`.
- [ ] Data retention reviewed; "Delete all data" tried on a device (§13).
- [ ] Backup restore, import, export and migration paths tested (§14).
- [ ] `FLAG_SECURE` verified on a device: screenshots of the sensitive screens are blocked, and allowed after turning the Screenshot guard switch off (§10.1).
- [ ] App lock verified on a device: locks at start and after 30 s away; unlock works (§7).
- [ ] A v2 backup made and restored on a device; an AirQR sync sent and received (§6.3).
- [ ] Tests cover the highest-risk failure modes (§15).
