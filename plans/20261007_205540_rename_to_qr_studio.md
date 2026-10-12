# Rename app to "SreerajP QR Studio"

**Status:** completed

## What the issue is

The app started as a QR **reader**. It can now also **create** QR codes, so the name
"SreerajP QR Reader" no longer fits. The app is not on the Play Store yet, so this is the
right time to change everything, including the Android application ID.

## Target names

| Item | Old | New |
| --- | --- | --- |
| Display name (prod) | `SreerajP QR Reader` | `SreerajP QR Studio` |
| Display name (dev) | `QR Reader Dev` | `QR Studio Dev` |
| Android application ID / namespace | `in.sreeraj.qr_reader` | `in.sreerajp.qr_studio` |
| Dev application ID | `in.sreeraj.qr_reader.dev` | `in.sreerajp.qr_studio.dev` |
| Kotlin package | `in.sreeraj.qr_reader` | `in.sreerajp.qr_studio` |
| Kotlin folder | `android/app/src/main/kotlin/in/sreerajp/qr_reader/` | `android/app/src/main/kotlin/in/sreerajp/qr_studio/` |
| Dart package (`pubspec.yaml` `name:`) | `sreeraj_qr_reader` | `sreerajp_qr_studio` |
| Dart imports | `package:sreeraj_qr_reader/...` | `package:sreerajp_qr_studio/...` |
| Native channel names | `in.sreeraj.qr_reader/<name>` | `in.sreerajp.qr_studio/<name>` |
| Ghost scan intent action | `in.sreeraj.qr_reader.ACTION_GHOST_SCAN` | `in.sreerajp.qr_studio.ACTION_GHOST_SCAN` |
| GitHub repo | `sreerajp80/sreeraj_qr_reader` | `sreerajp80/sreerajp_qr_studio` |
| Malayalam name | `ശ്രീരാജ് പി ക്യുആർ റീഡർ` | `ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ` |
| Sanskrit name | `श्रीराज् पि क्यू-आर-पाठकः` | `श्रीराज् पि क्यू-आर-कार्यशाला` (कार्यशाला = workshop / studio) |

## What stays the same (on purpose)

- **Backup and sync file formats:** the `.sreerajqr` file extension, the
  `SREERAJ_QR_BACKUP_V1` header and the `SREERAJ_AIRQR_SYNC_V1` header. Changing them would
  break restoring old backups. They do not say "reader", so they still fit.
- **Native library name** `sreeraj_barcode` (`libsreeraj_barcode.so`). It is a decoder name,
  not the app name. Only its header comments change.
- **Generic examples** that are not the app name, such as `"My QR Reader Security"` in the
  Safe Browsing help text, and the `'Hello Sreeraj QR Reader'` plain-text test input.
- **Old plans and change logs** in `plans/` and `change_log/` are history and are not edited.
- **`docs/guidelines/`** is a shared submodule and is not edited.
- **`native/zxing-cpp/`** is vendored and must never be edited.
- **The local folder name** on disk is not changed in this plan (see "After the change").

## Files to change

### 1. Android (application ID, package, display name)
- `android/app/build.gradle` — `namespace` and `applicationId` → `in.sreerajp.qr_studio`.
- `android/app/src/prod/res/values/strings.xml` — `app_name` → `SreerajP QR Studio`.
- `android/app/src/dev/res/values/strings.xml` — `app_name` → `QR Studio Dev`.
- Move the 9 Kotlin files from `kotlin/in/sreerajp/qr_reader/` to
  `kotlin/in/sreerajp/qr_studio/` with `git mv`, and change the first line in each to
  ``package `in`.sreerajp.qr_studio``:
  `GhostScanActivity.kt`, `GhostScanCaptureService.kt`, `GhostScanTileService.kt`,
  `MainActivity.kt`, `ScanBubbleBootReceiver.kt`, `ScanBubblePrefs.kt`,
  `ScanBubbleService.kt`, `ScanBubbleShortcutActivity.kt`, `ScanBubbleTileService.kt`.
- `MainActivity.kt` — the 5 channel names and the ghost scan intent action.
- `GhostScanCaptureService.kt` — the ghost scan intent action.
- `AndroidManifest.xml` — no change needed (it uses relative names like `.MainActivity`).

### 2. Dart package name and imports
- `pubspec.yaml` — `name: sreerajp_qr_studio`.
- All `package:sreeraj_qr_reader/` imports → `package:sreerajp_qr_studio/`
  (about 98 files in `lib/`, 57 in `test/`, plus any in `integration_test/`).
- `l10n.yaml` and generated code — check for the package name and regenerate.

### 3. Native channel names (must match the Kotlin side exactly)
- `lib/services/clipboard_scan_service.dart`
- `lib/services/ghost_scan_service.dart`
- `lib/services/light_sensor_service.dart`
- `lib/services/payload_action_service.dart`
- `lib/services/scan_bubble_service.dart`
- Tests: `test/services/ghost_scan_service_test.dart`,
  `test/services/payload_action_service_test.dart`, `test/widgets/ghost_scan_sheet_test.dart`.

### 4. Display name in the app
- `assets/config/app_config.json` — app name → `SreerajP QR Studio` (the current
  value `Sreeraj P QR Reader` also has an extra space; fixing it to match).
- `lib/core/config/app_config.dart` — fallback `appName`.
- `lib/models/device_sync_data.dart` — `'app'` field value.
- `lib/services/history_export_service.dart` — `'app'` field value in JSON export.
  (The import code does not check this field, so old exports still import.)
- `lib/screens/features_screen.dart` — doc comment.
- `lib/l10n/app_en.arb` — `appTitle`, `exportShareText`, `exportSharePdfText`,
  `exportShareBackupText`, `reportHeading` (→ `SREERAJP QR STUDIO - SCAN HISTORY`),
  `settingsFeaturesSubtitle`, `featuresHeaderTitle`, `helpCenterHeaderSubtitle`,
  `helpGuideSmartPayloadsIntro`, `helpGuideHistoryIntro`, `helpGuideFaqIntro`,
  `helpGuideFaqCameraBullet3`.
- `lib/l10n/app_ml.arb` — the same keys, using `ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ`
  (and the English app name inside `helpGuideFaqCameraBullet3`, since it names the
  app as Android shows it).
- `lib/l10n/app_sa.arb` — the same keys, using `श्रीराज् पि क्यू-आर-कार्यशाला`
  (checked against the Hindi marker rule; `helpGuideFaqCameraBullet3` updated too).
- Run `flutter gen-l10n` to regenerate `lib/l10n/gen/*.dart`.

### 5. Tests that check the name or package ID
- `test/core/config/app_config_test.dart`, `test/screens/about_screen_test.dart`,
  `test/screens/settings_screen_test.dart`, `test/services/device_sync_service_test.dart`,
  `test/services/history_export_service_test.dart`,
  `test/services/payload_parser_service_test.dart` (the `market://details?id=` example).

### 6. Native comments
- `native/CMakeLists.txt`, `native/sreeraj_barcode/sreeraj_barcode.cpp`,
  `native/sreeraj_barcode/sreeraj_barcode.h` — header comments only.

### 7. Docs and agent rules
- `CLAUDE.md` and `AGENTS.md` — title, identity table (app name, package id), flavor
  table, the `package:` import example. Keep both files in step.
- `README.md` — title, image alt text, text, flavor table, clone URL and `cd` folder
  (→ `sreerajp_qr_studio`).
- `docs/architecture.md`, `docs/dependencies.md`, `docs/features.md`,
  `docs/feature_analysis_and_roadmap.md`, `docs/feature_improvements_and_roadmap.md`,
  `docs/implementation_plan.md`, `docs/implementation_progress.md`,
  `docs/project_structure.md`, `docs/release_process.md`, `docs/security.md`,
  `docs/workflow_rules.md` — app name, package id, channel names, repo folder name.

## How I will do it

1. Do sections 1–7 above with careful, targeted find-and-replace, checking each hit
   (not a blind global replace), so the "stays the same" items are not touched.
2. Run `flutter pub get`, `flutter gen-l10n`, `dart format .`.
3. Run `flutter analyze` (must be clean) and `flutter test` (must pass).
4. Run a build-only check: `flutter build apk --flavor dev --debug`, to prove the Kotlin
   move and new namespace compile. **No install on the phone.**
5. Search again for `qr_reader`, `QR Reader` and `in.sreeraj.` to confirm nothing is left
   except the items kept on purpose.
6. Write the change log and set this plan to `completed`.

## After the change (things only you do)

- **Phone:** the new ID makes it a separate app. The old "QR Reader" app stays installed
  with its own history until you uninstall it. You said this is fine. I will not install
  or uninstall anything on the phone without asking.
- **GitHub:** rename the repo in Settings → General to `sreerajp_qr_studio`. Then run:
  `git remote set-url origin https://github.com/sreerajp80/sreerajp_qr_studio.git`
  (I can run this local command for you after you rename the repo.)
- **Local folder:** optionally rename the project folder later, after committing, in a
  new session.
- **Release keystore:** no change needed. The keystore is not tied to the application ID.

## Noticed but out of scope

- Some build crash logs are tracked by git (`android/.kotlin/errors/*.log`,
  `android/hs_err_pid*.log`). They contain local machine paths. They should be removed
  from git and added to `.gitignore`, as a separate change.
