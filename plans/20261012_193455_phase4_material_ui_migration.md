# Phase 4 — Move Material and Cupertino imports to material_ui / cupertino_ui

**Status:** completed

Part of [plans/20261012_191914_guidelines_compliance_roadmap.md](20261012_191914_guidelines_compliance_roadmap.md)
(gap D1, and the import part of D6).

## What the issue is

Since Flutter 3.47, Material and Cupertino ship as separate pub.dev packages, `material_ui` and
`cupertino_ui`. The SDK copies (`package:flutter/material.dart`,
`package:flutter/cupertino.dart`) are due to be deprecated in the next stable release. Every app
MUST depend on `material_ui` (and `cupertino_ui` when it uses Cupertino widgets or the Cupertino
localization delegate) with a caret constraint, and MUST NOT import the SDK copies (engineering
standard §6.1, §8.1; `guideline.md` §4).

Today:
- 104 files import `package:flutter/material.dart` (66 in `lib/`, 38 in `test/`).
- 2 files import `package:flutter/cupertino.dart` (`lib/l10n/sa_material_localizations.dart`
  and `test/l10n/sa_localizations_test.dart`); the app uses the Cupertino localization delegate.
- `pubspec.yaml` has neither package.

A dry run of `dart fix --dry-run --code=migrate_design_widgets` proposes 107 fixes in 105 files.
`dart pub add --dry-run` resolves `material_ui 1.6.0` and `cupertino_ui 1.1.2` against the
current lock file with no other version changes.

## Files to be changed

- `pubspec.yaml`, `pubspec.lock` — add `material_ui: ^1.6.0` and `cupertino_ui: ^1.1.2`.
- About 105 Dart files in `lib/` and `test/` — import lines only, written by the Flutter tool.
- `lib/main.dart` and `lib/l10n/sa_material_localizations.dart` — if needed, narrow the
  `flutter_localizations` import (`show GlobalWidgetsLocalizations`) so the Material and
  Cupertino delegates come from the new packages without a name clash (§8.1, §8.3.1).
- `docs/dependencies.md` — list the two new packages (BSD-3-Clause, from the Flutter team).
- `change_log/<timestamp>_phase4_material_ui_migration.md` — new.

Not changed: generated files in `lib/l10n/gen/` (they import only `flutter/widgets.dart`),
`native/`, `docs/guidelines/`.

## Plan for the fix

1. **License check** — read the `LICENSE` of `material_ui` and `cupertino_ui` in the pub cache
   after `pub get`; confirm BSD-3-Clause and no network or build-hook code (`hook/`), as the
   dependency rules require. Stop and report if not.
2. **Add the packages** — `flutter pub add material_ui:^1.6.0 cupertino_ui:^1.1.2`. Make sure
   the constraints in `pubspec.yaml` are carets, never `any`. No other dependency is changed.
3. **Run the migration** — `dart fix --apply --code=migrate_design_widgets`. Then check that no
   `package:flutter/material.dart` or `package:flutter/cupertino.dart` import is left (grep).
   If the tool added `material_ui: any`, change it back to the caret.
4. **Clean up** — run `flutter analyze`. Fix only what the migration causes (for example a
   duplicate `GlobalMaterialLocalizations` coming from both `material_ui` and
   `flutter_localizations`: keep the `material_ui` one and narrow the other import). Keep the
   current delegate list and fallback delegates as they are; their reshaping is Phase 5.
5. **Format** — `dart format .`.
6. **Verify** — `dart format --output=none --set-exit-if-changed .`, `flutter analyze` (0
   issues), `flutter test` (all pass), the Sanskrit gate script. Then one dev debug build
   (`flutter build apk --flavor dev --debug`) to confirm the app still compiles for Android,
   because this touches a dependency (§23.1). After the build: `android\gradlew --stop` and end
   any leftover `GradleDaemon` / `KotlinCompileDaemon` Java process. No install on any device.
7. **Docs** — add both packages to `docs/dependencies.md`.

## Risk and rollback

The change is mechanical and made by the Flutter tool. If tests or the build fail for a reason
that is not a simple import fix, stop, report the error, and roll back with `git checkout` of the
changed files and `pubspec.*`.

## Amendment (found during implementation, needs approval)

After the migration, `flutter analyze` shows two kinds of errors:

1. **Simple (inside the plan):** `GlobalMaterialLocalizations` is now defined by both
   `material_ui` and `flutter_localizations` in `lib/main.dart` and 4 test files. Fix: narrow
   the `flutter_localizations` import to `show GlobalWidgetsLocalizations`.
2. **Not a simple import fix:** `dynamic_color 1.9.0` still uses the SDK's
   `package:flutter/material.dart` types, so its `ColorScheme` is a different type from the
   `material_ui` one (3 errors in `lib/main.dart`, 3 in `lib/providers/theme_provider.dart`).

`dynamic_color 2.0.0` (2026-08-20) "migrates to `material_ui`", and `2.0.2` makes its Kotlin
plugin conditional for AGP 9 (fits our built-in Kotlin setup). The latest is `2.1.0`
(Apache-2.0, depends only on `flutter`, `material_color_utilities`, `material_ui`; no build
hooks). The API the app uses (`DynamicColorBuilder`, `ColorScheme.harmonized()`) is the same.

**Approved by the user (2026-10-12):** upgrade `dynamic_color` from `^1.9.0` to `^2.1.0` in `pubspec.yaml`
(this is a major-version update, so it is reviewed on its own here, §16.6), update
`docs/dependencies.md`, then continue with steps 4–7 unchanged.

**Alternative:** roll back all Phase 4 changes and wait.

## Out of scope

- Reshaping the fallback delegates and `supportedLocales` (Phase 5).
- Any other dependency upgrade.
