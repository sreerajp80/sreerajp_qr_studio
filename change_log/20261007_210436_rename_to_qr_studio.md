# Change log — Rename app to "SreerajP QR Studio"

Implements plan: [plans/20261007_205540_rename_to_qr_studio.md](../plans/20261007_205540_rename_to_qr_studio.md)

## Why

The app can now create QR codes as well as read them, so "QR Reader" no longer fit.
The app is not on the Play Store yet, so the Android application ID was changed too.

## What changed

### Android
- `android/app/build.gradle`: `namespace` and `applicationId` are now `in.sreerajp.qr_studio`
  (dev flavor: `in.sreerajp.qr_studio.dev`).
- Moved the 9 Kotlin files (with `git mv`) from `kotlin/in/sreerajp/qr_reader/` to
  `kotlin/in/sreerajp/qr_studio/`. Their package is now `` `in`.sreerajp.qr_studio ``.
- `MainActivity.kt`, `GhostScanCaptureService.kt`, `ScanBubbleService.kt`: method channel
  names and intent action strings now start with `in.sreerajp.qr_studio`.
- `android/app/src/prod/res/values/strings.xml`: `app_name` = `SreerajP QR Studio`.
- `android/app/src/dev/res/values/strings.xml`: `app_name` = `QR Studio Dev`.

### Dart
- `pubspec.yaml`: package name is now `sreerajp_qr_studio`.
- All `package:sreeraj_qr_reader/` imports in `lib/`, `test/` and `integration_test/`
  now use `package:sreerajp_qr_studio/`.
- Method channel names in `clipboard_scan_service.dart`, `ghost_scan_service.dart`,
  `light_sensor_service.dart`, `payload_action_service.dart` and `scan_bubble_service.dart`
  now match the new Kotlin names.
- App name updated in `lib/core/config/app_config.dart` (fallback),
  `lib/models/device_sync_data.dart`, `lib/services/history_export_service.dart`
  and a doc comment in `lib/screens/features_screen.dart`.

### Text in three languages
- `lib/l10n/app_en.arb`: app name → `SreerajP QR Studio` (title, export share texts,
  report heading `SREERAJP QR STUDIO - SCAN HISTORY`, features and help texts).
- `lib/l10n/app_ml.arb`: `ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ` (grammar fixed for
  `സ്റ്റുഡിയോയെക്കുറിച്ചുള്ള`). The export share texts now include "പി" like the title.
- `lib/l10n/app_sa.arb`: `श्रीराज् पि क्यू-आर-कार्यशाला` (title, report heading, help texts).
- `assets/config/app_config.json`: app name in all three languages. The extra space in
  "Sreeraj P" in the English name was also fixed.
- Regenerated `lib/l10n/gen/*.dart` with `flutter gen-l10n`.

### Tests, native comments, docs
- Tests updated for the new name, package ID and channel names.
- Header comments in `native/CMakeLists.txt` and `native/sreeraj_barcode/`.
- `CLAUDE.md`, `AGENTS.md` (kept in step), `README.md` (also the clone URL and folder name)
  and the files in `docs/` now use the new name, package ID and repo name.
- `dart format .` re-wrapped 44 files, mainly lines that grew because the package name
  is one character longer.

## Kept on purpose
- Backup and sync formats: `.sreerajqr`, `SREERAJ_QR_BACKUP_V1`, `SREERAJ_AIRQR_SYNC_V1`.
  Old backups still restore.
- Native library name `sreeraj_barcode`.
- Feature name "StegoQR Reader" in the roadmap doc, the example `"My QR Reader Security"`
  in the help text, and a plain-text test input.
- Old plans and change logs, `docs/guidelines/` and `native/zxing-cpp/`.

## Checks
- `flutter analyze`: no issues.
- `flutter test`: all 483 tests passed.
- `flutter build apk --flavor dev --debug`: built. The merged manifest shows
  package `in.sreerajp.qr_studio.dev`. Nothing was installed on any device.

## Follow-ups (not done here)
- Rename the GitHub repo to `sreerajp_qr_studio`, then update the local `origin` URL.
- The old app (old ID) stays on the phone as a separate app until it is uninstalled.
- Build crash logs (`android/.kotlin/errors/`, `android/hs_err_pid*.log`) are tracked by git,
  and the native build cache folder `android/app/.cxx/` is not ignored. These should be
  cleaned up in a separate change.
- The app description in `assets/config/app_config.json` still says "scanner" only.
  It could mention QR creation too.
