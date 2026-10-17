# Phase 4 — Move Material and Cupertino imports to material_ui / cupertino_ui

Plan: [plans/20261012_193455_phase4_material_ui_migration.md](../plans/20261012_193455_phase4_material_ui_migration.md)
(including its approved amendment)
Roadmap: [plans/20261012_191914_guidelines_compliance_roadmap.md](../plans/20261012_191914_guidelines_compliance_roadmap.md) (gap D1, import part of D6)

## What changed

- **`pubspec.yaml` / `pubspec.lock`**
  - Added `material_ui: ^1.6.0` and `cupertino_ui: ^1.1.2` (Flutter team, BSD-3-Clause; no
    build hooks, no network dependencies). `pub add` wrote exact versions; changed to carets.
  - **Amendment:** `dynamic_color` `^1.9.0` → `^2.1.0` (major update, reviewed on its own).
    1.9.0 used the SDK Material types, so its `ColorScheme` no longer matched the `material_ui`
    one. 2.x is migrated to `material_ui` and makes its Kotlin plugin conditional for AGP 9.
    Apache-2.0. Same API (`DynamicColorBuilder`, `ColorScheme.harmonized()`).
  - No other package version changed in the lock file.
- **Migration** — `dart fix --apply --code=migrate_design_widgets`: 106 fixes in 104 files in
  `lib/` and `test/`. No `package:flutter/material.dart` or `package:flutter/cupertino.dart`
  import is left.
- **Name-clash fixes** — `GlobalMaterialLocalizations` came from both `material_ui` and
  `flutter_localizations`. In `lib/main.dart`, `lib/l10n/sa_material_localizations.dart`,
  `test/helpers/test_app.dart`, `test/screens/help/help_screens_test.dart`,
  `test/screens/scan_bubble_settings_screen_test.dart` and
  `test/screens/widgets/batch_review_sheet_test.dart`, `flutter_localizations` is now imported
  with `show GlobalWidgetsLocalizations`, and `GlobalCupertinoLocalizations` comes from
  `cupertino_ui` (§8.1, §8.3.1). `test/l10n/date_format_locale_test.dart` now takes
  `GlobalMaterialLocalizations` from `material_ui`.
- **Test delegate lists** — 10 widget tests used the generated
  `AppLocalizations.localizationsDelegates`. That list comes from `flutter gen-l10n` and still
  holds the SDK Material/Cupertino delegates, which `material_ui` widgets do not see. Under `ml`
  and `sa` this made 2 `ResultScreen` layout tests fail. The tests now use
  `[AppLocalizations.delegate, ...GlobalMaterialLocalizations.delegates]` (the shape in §8.1);
  `result_screen_test.dart` keeps the Sanskrit fallback delegates before the global ones. The
  app itself (`lib/main.dart`) never used the generated list.
- **`docs/dependencies.md`** — added `material_ui` and `cupertino_ui`; `dynamic_color` now
  `^2.1.0`; `flutter_localizations` purpose updated.

## Checks

- `dart format --output=none --set-exit-if-changed .` — no changes.
- `flutter analyze` — no issues.
- `flutter test` — all 582 tests passed.
- Sanskrit Hindi-marker gate — passed.
- `flutter build apk --flavor dev --debug` — built. The build printed Flutter's general notice
  asking plugin authors to move to built-in Kotlin (from a third-party plugin; no action for the
  app). Not installed on any device.
- Gradle daemon stopped (`gradlew --stop`); no `GradleDaemon` or `KotlinCompileDaemon` process
  left.
- Generated files in `lib/l10n/gen/` have no content changes.

## Notes for later phases

- Phase 5 reshapes the fallback delegates to the template (`kFrameworkFallbackLanguages`) and
  uses `AppLocalizations.supportedLocales` in `MaterialApp`.
