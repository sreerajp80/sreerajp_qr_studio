# Change log — Rename the app to "QR Forge"

Implements plan: [plans/20261107_220156_rename_app_qr_forge.md](../plans/20261107_220156_rename_app_qr_forge.md)

## What changed

The display name changed from "SreerajP QR Studio" to **QR Forge** (dev flavor: **QR Forge Dev**).
Malayalam: **ക്യുആർ ഫോർജ്**, Sanskrit: **क्यू-आर-फोर्ज्**. The Play Store title in the local
store listing is now **QR Forge - Safe QR Scanner** (26 / 30 characters).

### App
- `assets/config/app_config.json`: `appName` in en, ml and sa.
- `lib/core/config/app_config.dart`: built-in fallback name.
- `android/app/src/{dev,prod}/res/values{,-ml,-sa}/strings.xml`: launcher name (6 files), so
  it still matches `appName` (guideline.md §1.8).
- `lib/l10n/app_en.arb`: 6 texts that named the app (`bodyExportShare`, `bodyExportSharePdf`,
  `bodyExportShareBackup`, `descSettingsFeatures`, `helpGuideFaqFixBullet1`,
  `bodyAppLockReason`).
- `lib/l10n/app_ml.arb`, `lib/l10n/app_sa.arb`: `helpGuideFaqFixBullet1` and
  `bodyAppLockReason` now use the Malayalam / Sanskrit name (the name Android Settings shows in
  that language). `lib/l10n/gen/` regenerated.
- `lib/services/history_export_service.dart`, `lib/models/device_sync_data.dart`: the `'app'`
  field in exported files is now `QR Forge`. Import never reads this field, so older files still
  import. The two matching tests were updated.
- Header comments: `lib/screens/features_screen.dart`, `android/app/proguard-rules.pro`,
  `native/CMakeLists.txt`, `native/sreeraj_barcode/sreeraj_barcode.{h,cpp}`.

### Docs
- `CLAUDE.md` and `AGENTS.md` (kept in step), `README.md`, `PRIVACY_POLICY.md`,
  `docs/PROJECT_PROFILE.md`, `docs/architecture.md`, `docs/security.md`,
  `docs/release_process.md`, `docs/workflow_rules.md`, `docs/project_structure.md`,
  `docs/dependencies.md`, `docs/implementation_progress.md`.
- `CHANGELOG.md`: title, plus an "Unreleased → Changed" entry for the rename.
- Local store listing (gitignored folder): title and description.

### Not changed (on purpose)
- Package ids `in.sreerajp.qr_studio` / `.dev` and the Dart package name.
- The "CodeForge" feature name and its subtitle "Barcode & QR Studio" (user's choice).
- History: older `CHANGELOG.md` entries, `docs/implementation_plan.md`, older plans and logs,
  and the local submission record.

## Checks

- `flutter gen-l10n`: done.
- `dart format .`: 0 files changed.
- `flutter analyze`: no issues.
- `flutter test`: all 926 tests passed.
- Not yet checked on a device (launcher name under the icon).

## Left over (outside this plan)

Other local Play Console notes in the gitignored folder still use the old name: the titles of
the data safety answers and the publishing guide, and step 1 of the reviewer instructions in the
foreground service declaration ("Open SreerajP QR Studio → Settings → Scan bubble"). Update that
step before the next submission so reviewers can find the app.

## Native-reader review needed

- Malayalam ക്യുആർ ഫോർജ് and Sanskrit क्यू-आर-फोर्ज् are sound-outs of an English brand name.
  Please have a native reader check both, including the Sanskrit app-lock prompt
  "क्यू-आर-फोर्ज् उद्घाटयतु".
