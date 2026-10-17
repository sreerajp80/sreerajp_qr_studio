# Phase 9b — Sensitive-data and release-build controls

**Status:** completed

Part of [plans/20261012_191914_guidelines_compliance_roadmap.md](20261012_191914_guidelines_compliance_roadmap.md)
(gap G4). Closes the `open` items of the OWASP table in [docs/security.md](../docs/security.md)
§12. User decisions (2026-10-12): `FLAG_SECURE` on **sensitive screens only**; the **backup
format fix and the export warning** are in this phase; add an **optional biometric app lock**.

Work is done in five parts (A–E), in this order, each checked before the next.

## What the issue is

| # | Issue | Rule | OWASP |
|---|---|---|---|
| 1 | No `FLAG_SECURE`, but the Features screen and History help say screen captures are blocked and that history is fingerprint-protected | ES §15.2 (MUST) | M6 |
| 2 | No app lock | ES §15.2 "app lock … MUST be explicit"; §9.2 | M3 |
| 3 | `android/app/build.gradle` signs **release** builds with the **debug key** when `android/key.properties` is missing | guideline.md §2, release_process §7 | M8 |
| 4 | No `android/app/proguard-rules.pro` | release_process §6.2 | M7 |
| 5 | `.sreerajqr` backup: key = SHA-256(passphrase) with no salt, IV = first 16 key bytes, AES-CBC, no tag | ES §15.2 | M10 |
| 6 | Plain-text exports (CSV/JSON/TXT/PDF of history and batch scans) give no warning | ES §15.2 "plaintext export … explicit and user-confirmed" | M9 |

## Files to be changed

- **A (FLAG_SECURE + texts):** `MainActivity.kt` (new `in.sreerajp.qr_studio/window` channel:
  `setSecure`), `lib/services/screen_security_service.dart` (new),
  `lib/widgets/secure_screen.dart` (new), the sensitive screens (below), ARB files (corrected
  texts).
- **B (release build):** `android/app/build.gradle`, `android/app/proguard-rules.pro` (new).
- **C (backup v2):** `lib/services/history_export_service.dart`, `HistoryProvider` (call in a
  background isolate), the export dialog (progress while the key is derived), tests.
- **D (export warning):** `lib/screens/widgets/export_import_dialog.dart`,
  `lib/screens/widgets/batch_review_sheet.dart`, a shared confirm helper in `lib/widgets/`,
  ARB keys, tests.
- **E (app lock):** `lib/providers/app_lock_provider.dart` (new), `lib/widgets/app_lock_gate.dart`
  (new), `lib/main.dart` (provider + gate), Settings → Privacy (switch), `BiometricService`
  (unchanged API), ARB keys, tests.
- Docs: `docs/security.md` (§6.3, §7, §10.1, §12, §14, §17, §18), `docs/architecture.md`
  (§6, §8, §20, §21), `docs/release_process.md` (§6.2, §7, §8), `CHANGELOG.md`, `README.md`
  (feature text if it claims more than the app does), `docs/project_structure.md`.
- `change_log/<timestamp>_phase9b_sensitive_data_controls.md`.

## Plan for the fix

### A. `FLAG_SECURE` on sensitive screens, and honest texts
1. Native: `MainActivity` gets a `window` method channel with `setSecure(bool)` that adds or
   clears `WindowManager.LayoutParams.FLAG_SECURE` on the activity window (on the UI thread).
2. `ScreenSecurityService` (Dart, `services/`) keeps a **counter**: the flag is on while at least
   one secure screen is open, so nested screens and sheets work. Errors are logged, never thrown.
3. `SecureScreen` widget (`widgets/`): turns it on in `initState`, off in `dispose`.
4. Wrapped screens (they show scanned content, secrets or keys):
   - `HistoryScreen` and the history detail sheet;
   - `ResultScreen` (scan result, StegoQR secret, Wi-Fi password, TOTP codes);
   - `UrlSafetyProvidersScreen` (API keys);
   - `AirQrTransmitterScreen` and `AirQrScreen` (data being sent/received);
   - the export/backup dialog and the batch review sheet.
   Scanner, CodeForge, Settings home, Help, About stay capturable (users may want screenshots
   of codes they make or of help pages).
5. Texts (en/ml/sa; ml and sa "needs native-reader review"):
   `featureBiometricGuardDesc` → "Optional app lock with fingerprint, face or screen lock.
   Screens that show scans, history, secrets or API keys block screenshots and screen recording
   (FLAG_SECURE). Hidden StegoQR messages can also ask for biometrics.";
   `helpGuideHistoryBiometricsBullet1` → app lock + StegoQR biometrics;
   `helpGuideHistoryBiometricsBullet2` → "Screenshot guard: history, results, secrets and API
   keys cannot be captured by screenshots or screen recording (FLAG_SECURE)."
   Check `README.md` feature text and fix any claim that goes beyond this.
6. GhostScan is not affected: it captures *other* apps while this app is in the background.

### B. Release signing and R8
1. `buildTypes.release` keeps the release signing config only; if `android/key.properties` is
   missing, a Gradle check makes every **prod** release task (`assembleProdRelease`,
   `bundleProdRelease`) fail with a clear message ("android/key.properties is missing — release
   builds must be signed with the release key"). `dev` release builds may still use the debug
   key (they are never shipped; `docs/release_process.md` §5 uses them for testing). Debug
   builds are unchanged.
2. New `android/app/proguard-rules.pro`, referenced with
   `proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")`.
   Content: comments explaining that Flutter and the plugins ship their own consumer rules, plus
   keep rules for this app's Kotlin classes that Android creates by name (services, tile
   services, activities, receiver — already kept through the manifest, listed for clarity) and
   the method-channel handlers. No `-dontwarn` blanket rules.
3. Check: `flutter build apk --flavor dev --release` (R8 runs; must succeed). A prod release
   build is **not** run here (it needs your keystore); I only check that, without
   `key.properties`, `flutter build apk --flavor prod --release` now **fails with the message**
   instead of producing a debug-signed APK — if `key.properties` exists on this machine I skip
   that check rather than touch it.

### C. Backup format v2
1. `createEncryptedBackup` writes **`SREERAJ_QR_BACKUP_V2`**:
   `{header, kdf: "pbkdf2-hmac-sha256", iterations: 600000, salt, nonce, data}` — 16-byte random
   salt, PBKDF2-HMAC-SHA256 with **600,000** iterations (OWASP 2023 value), AES-256-GCM with a
   random 12-byte nonce, all base64url. The iteration count is stored, so it can rise later.
2. `restoreEncryptedBackup` reads **v2** (tag checked; wrong passphrase or changed file →
   the existing `backupWrongPassphrase` message) and still reads **v1** files (old scheme, read
   only). Unknown header → `backupBadHeader`. Iterations outside a sane range are rejected.
3. Key derivation runs in a background isolate (`compute`), so the UI does not freeze (measured:
   about 1.5 s on a desktop; expect a few seconds on a phone). The dialog shows a progress
   indicator meanwhile.
4. Tests: v2 round trip; same passphrase twice → different files (random salt and nonce); wrong
   passphrase → error; a changed byte → error; a v1 file made with the exact old code still
   restores; unknown header → error. Tests use a lower iteration count through a test-only
   parameter so they stay fast; one test checks the real default is 600,000.

### D. Plain-text export warning
1. Before a CSV, JSON, TXT or PDF export (history and batch review), show an `AlertDialog`:
   "This file is not encrypted. Anyone who gets it can read your scans." with **Cancel**,
   **Export anyway**, and — in the history dialog — a hint to use the encrypted backup instead.
2. Shared helper `confirmPlainTextExport(BuildContext)` in `lib/widgets/`.
3. Tests: Cancel exports nothing; Export anyway exports; dialog fits in en, ml, sa.

### E. Optional biometric app lock
1. `AppLockProvider` (`providers/`): `enabled` (SharedPreferences `app_lock_enabled`, default
   off), `locked` state; uses `BiometricService` (fingerprint, face, or the phone's screen lock
   as fallback — `biometricOnly: false`).
2. Turning it **on** in Settings → Privacy needs one successful authentication first; if the
   phone has no lock or biometrics, the switch explains that and stays off. Turning it off also
   needs authentication.
3. When enabled: the app is **locked at start** and **when it goes to the background**
   (`paused`/`hidden`). `AppLockGate` (in `MaterialApp.builder`) covers the whole app with a lock
   screen (app icon, "Unlock" button) until authentication succeeds; the system prompt opens
   automatically once. While locked, nothing behind is visible or reachable.
4. Interplay: the GhostScan / Scan bubble result and share-sheet input wait behind the lock and
   continue after unlock; "Delete all data" clears the setting (preferences are cleared).
5. Strings (en/ml/sa): `labelAppLock`, `descAppLock`, `titleAppLocked`, `bodyAppLocked`,
   `actionUnlock`, `bodyAppLockReason` (system prompt), `errorAppLockUnavailable`,
   `errorAppLockFailed`.
6. Tests: provider (enable needs auth; failed auth keeps it off; lock on `paused`; unlock);
   gate (locked shows only the lock screen; unlock shows the app); Settings switch; en, ml, sa
   without overflow and with tooltips.

### F. Docs and checks
- `docs/security.md`: §6.3 backup v2, §7 app lock, §10.1 `FLAG_SECURE` screens, §12 statuses
  (M3, M6, M7, M8, M9, M10 → verified, with evidence), §14, §17 (remove fixed items), §18.
  `docs/architecture.md` §6 lifecycle (lock on `paused`), §8 new provider, §21.
  `docs/release_process.md` §6.2, §7 (no more debug fallback for prod). `CHANGELOG.md`
  Unreleased. `docs/project_structure.md`.
- Checks: `flutter gen-l10n`, format, `flutter analyze`, `flutter test`, Sanskrit gate,
  `flutter build apk --flavor dev --debug` and `--flavor dev --release`, then
  `android\gradlew --stop` and end leftover `GradleDaemon` / `KotlinCompileDaemon`. No install on
  any device.
- Release items (need your yes to install on a phone): `FLAG_SECURE` on the listed screens
  (screenshot shows black), app lock on start/background, a v2 backup made and restored on a
  phone, and a prod release build signed with your key that runs (R8).

## Risks
- `FLAG_SECURE` also blanks those screens in the recent-apps preview — intended.
- 600,000 iterations may take several seconds on old phones; the progress indicator covers it.
- App lock + share-sheet / GhostScan: input is kept until unlock; tested in widget tests, real
  device check in the release items.

## Progress (2026-10-12 paused; finished 2026-10-13 — see the change log)

- Part A, steps 1–4 done: `window` channel with `setSecure` in `MainActivity.kt`;
  `lib/services/screen_security_service.dart`; `lib/widgets/secure_screen.dart`; `SecureScreen`
  wraps History, history detail sheet, Result, AirQR transmitter and receiver, export/backup
  dialog, batch review sheet and the API keys screen. `flutter analyze` clean; 654 tests pass.
- Still to do: Part A steps 5–6 (texts, tests for the counter), Parts B–F, change log.

## Amendment C2 — AirQR device sync packages (approved by the user on 2026-10-13)

Found while doing part C: `DeviceSyncService` packages (`SREERAJ_QR_SYNC_V1`, settings + history
sent over AirQR) use the same weak scheme as the old backup (key = SHA-256 of the passphrase,
AES-CBC, fixed IV), and the AirQR receiver only recognises v1 backups.

- New sync package **`SREERAJ_QR_SYNC_V2`**: same container fields and crypto as backup v2
  (PBKDF2-HMAC-SHA256, 600,000 iterations, random salt, AES-256-GCM, random nonce), key derived in
  a background isolate. `SREERAJ_QR_SYNC_V1` and backup v1 are still read.
- `isSyncPackage` / summary / decrypt also accept backup v2 (`SREERAJ_QR_BACKUP_V2`), so a v2
  backup sent over AirQR is recognised.
- Files: `lib/services/device_sync_service.dart`, its callers (AirQR transmitter / receiver,
  settings sync), `test/services/device_sync_service_test.dart`.
