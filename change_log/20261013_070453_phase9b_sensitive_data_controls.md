# Phase 9b — Sensitive-data and release-build controls

Plan: [plans/20261012_210703_phase9b_sensitive_data_controls.md](../plans/20261012_210703_phase9b_sensitive_data_controls.md)
(including amendment C2, approved 2026-10-13)
Roadmap: [plans/20261012_191914_guidelines_compliance_roadmap.md](../plans/20261012_191914_guidelines_compliance_roadmap.md) (gap G4)

User decisions: `FLAG_SECURE` on sensitive screens only; backup fix and export warning in this
phase; optional biometric app lock; AirQR sync packages fixed too.

## What changed

### A. Screenshot protection and honest texts
- `MainActivity.kt`: new `in.sreerajp.qr_studio/window` channel, `setSecure(bool)` adds or
  clears `FLAG_SECURE` on the UI thread.
- New `lib/services/screen_security_service.dart` (counter, so nested screens and sheets work;
  errors logged, never thrown) and `lib/widgets/secure_screen.dart`.
- `SecureScreen` wraps: History, history detail sheet, Result, AirQR transmitter and receiver,
  export/backup dialog, batch review sheet, API keys screen (`UrlSafetyProvidersScreen`).
- Texts rewritten in en/ml/sa so they say what the app does: `featureBiometricGuardDesc`,
  `helpGuideHistoryBiometricsBullet1`, `helpGuideHistoryBiometricsBullet2` (they claimed
  screenshots were always blocked and that history was fingerprint-protected).

### B. Release build
- `android/app/build.gradle`: release build type references `proguard-rules.pro`; a task-graph
  check makes `assembleProdRelease` / `bundleProdRelease` / `packageProdRelease` **fail** when
  `android/key.properties` is missing. `dev` release builds may still use the debug key.
- New `android/app/proguard-rules.pro` (comments on plugin consumer rules and FFI; keep rules for
  the app's own activities, services and receiver).

### C. Backup format v2, and C2 AirQR sync packages v2
- New `lib/services/passphrase_cipher.dart` (`PassphraseCipher`): PBKDF2-HMAC-SHA256,
  **600,000 iterations**, random 16-byte salt, AES-256-GCM with a random 12-byte nonce, fields
  `kdf`/`iterations`/`salt`/`nonce`/`data`; key derivation in a background isolate
  (`Isolate.run`); iteration range check; `openLegacyV1` reads the old scheme only.
- `HistoryExportService`: writes `SREERAJ_QR_BACKUP_V2`; restores v2 and v1; shared
  `recordsFromJson`. Now async; `HistoryProvider.createEncryptedBackup` returns a `Future`.
- `DeviceSyncService`: writes `SREERAJ_AIRQR_SYNC_V2` (summary fields stay readable); reads sync
  v1/v2 and backup v1/v2, so a v2 backup sent over AirQR is recognised. Now async.
- Export dialog and AirQR transmitter show a progress dialog while the key is derived (new keys
  `bodyEncryptingBackup`, `bodyOpeningBackup`, `bodyEncryptingSync`).
- Restore no longer shows raw exception text for an unexpected error; it shows the localized
  "invalid format" message (engineering standard §11.2).

### D. Plain-text export warning
- New `lib/widgets/plain_text_export_confirm.dart` (`confirmPlainTextExport`): Cancel / Export
  anyway; the history dialog also points to the encrypted backup. Used before CSV, JSON, TXT and
  PDF exports of history and of batch scans. New keys `titlePlainExport`, `bodyPlainExport`,
  `bodyPlainExportBackupHint`, `actionExportAnyway`.

### E. Optional app lock
- New `lib/providers/app_lock_provider.dart`: on/off (`app_lock_enabled`), locked state;
  enabling and disabling need one successful authentication; unavailable when the phone has no
  screen lock or biometrics.
- New `lib/widgets/app_lock_gate.dart`, in `MaterialApp.builder`: full lock screen above every
  route while locked (child offstage and hidden from screen readers), opens the system prompt
  once per lock, shows a retry message on failure.
- **Lock rule:** at start, and after **30 seconds or more** in the background. The plan said
  "when it goes to the background"; a 30-second grace was added so the gallery, file picker,
  share sheet and permission screens (which all send the app to the background briefly) keep
  working. Recorded as an accepted risk in `docs/security.md` §17.
- Settings → Privacy: **App lock** switch. `lib/main.dart`: provider + gate.
- New keys `labelAppLock`, `descAppLock`, `titleAppLocked`, `bodyAppLocked`, `actionUnlock`,
  `bodyAppLockReason`, `errorAppLockUnavailable`, `errorAppLockFailed`.

### Translations (ml and sa — **needs native-reader review**)
All new and rewritten Malayalam and Sanskrit strings listed above (A, C, D, E). They use the
language-pack glossary words; all short keys pass the 20/22 length test; Sanskrit passes the
Hindi-marker gate.

### F. Docs
- `docs/security.md`: §4, §6.3 (passphrase formats v2), §7 (app lock), §8.2 (R8), §10.1
  (`FLAG_SECURE` screens), **§12 OWASP — every item now `verified`**, §14, §15 test rows, §17
  (only accepted / watch / release items left), §18.
- `docs/architecture.md` (13 providers, lifecycle, window channel, decisions, risks),
  `docs/release_process.md` (§6.2, §7, §8 device checks), `CHANGELOG.md` (Unreleased),
  `docs/project_structure.md` (new files).

### Tests (+33 → 687)
`screen_security_service_test.dart`, `passphrase_cipher_test.dart`, updated
`history_export_service_test.dart` (v2 round trip, 600,000 default, random salt/nonce, wrong
passphrase, tampering, broken fields, v1 restore) and `device_sync_service_test.dart` (v2 sync,
v1 sync, v1 and v2 backups over AirQR), `plain_text_export_confirm_test.dart`,
`app_lock_provider_test.dart`, `app_lock_gate_test.dart`, `settings_screen_test.dart` (App lock
switch). New helper `test/helpers/fake_biometric_service.dart`.

## Checks
- `dart format --output=none --set-exit-if-changed .` — no changes; `flutter analyze` — no
  issues; `flutter test` — all 687 passed; Sanskrit gate — passed.
- `flutter build apk --flavor dev --debug` and `--flavor dev --release` (R8 with the new rules)
  — both built; not installed on any device.
- The "prod release fails without `key.properties`" path was **not** exercised: the file exists
  on this machine, and the plan says not to touch it.
- Gradle daemon stopped; one leftover daemon process ended; none left.

## Release items (each needs the user's approval to install on a phone)
- Screenshots of the protected screens are blocked; the recent-apps preview is blank.
- App lock: locks at start and after 30 s away; a quick gallery pick does not lock.
- A v2 backup made and restored; an AirQR sync sent and received between two phones.
- A prod release build signed with the release key runs end to end (R8).
- Flutter warned that the `pdfx` plugin applies the Kotlin Gradle Plugin; future Flutter
  versions will reject that (watch item in `docs/security.md` §17).
