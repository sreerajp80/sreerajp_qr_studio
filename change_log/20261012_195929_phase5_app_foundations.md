# Phase 5 — App foundations: flavor config, logger, error handlers, startup order, l10n delegates

Plan: [plans/20261012_194732_phase5_app_foundations.md](../plans/20261012_194732_phase5_app_foundations.md)
Roadmap: [plans/20261012_191914_guidelines_compliance_roadmap.md](../plans/20261012_191914_guidelines_compliance_roadmap.md) (gaps D2–D6)

## What changed

### New files
- `lib/core/config/app_flavor_config.dart` — `AppFlavor` + `AppFlavorConfig` in the §5.2
  two-variable shape (`APP_FLAVOR`, then `FLUTTER_APP_FLAVOR`, default prod); `isDev`, `isProd`,
  `enableVerboseLogging`.
- `lib/core/logging/app_logger.dart` — `AppLogger` (`trace` … `fatal`) on `dart:developer`; no
  new package. `trace`/`debug` only in dev. Outside dev, an error is logged by its type name,
  without a stack trace. Console only, no log file. Logging never throws.
- `lib/core/errors/global_error_handlers.dart` — `FlutterError.onError` (log; console dump
  outside release), `PlatformDispatcher.instance.onError` (log, handled), and in release
  `ErrorWidget.builder` → `SafeErrorFallback`.
- `lib/widgets/safe_error_fallback.dart` — icon only, no text, no theme or l10n lookups.
- `lib/services/app_startup_service.dart` — §4.5 order: binding → error handlers + start log →
  licences → `SharedPreferences` preloaded; each step catches its own failure.
- `lib/l10n/fallback_localizations.dart` — `kFrameworkFallbackLanguages = {'sa'}`,
  `kFrameworkFallbackLocale`, `Fallback{Material,Cupertino,Widgets}LocalizationsDelegate`
  (replaces `sa_material_localizations.dart`; same behaviour).
- `lib/l10n/formatting_locale.dart` — `formattingLocale(Locale)` (§8.3.2; replaces
  `date_format_locale.dart`).
- Tests: `test/core/config/app_flavor_config_test.dart`, `test/core/logging/app_logger_test.dart`,
  `test/core/errors/global_error_handlers_test.dart`, `test/services/app_startup_service_test.dart`,
  `test/widgets/safe_error_fallback_test.dart`, `test/l10n/fallback_localizations_test.dart`,
  `test/l10n/formatting_locale_test.dart`.

### Changed
- `lib/main.dart` — `main()` is now `await AppStartupService.run()` then `runApp(...)`; the app
  widget passes the preloaded preferences to `LocaleProvider` and `OnboardingProvider`, so the
  saved language applies before the first frame. Delegates: `AppLocalizations.delegate`, the
  three fallbacks, `...GlobalMaterialLocalizations.delegates`. `supportedLocales:
  AppLocalizations.supportedLocales`; the resolution callback returns
  `supportedLocales.first` instead of a literal.
- `lib/providers/locale_provider.dart` — `supportedLanguages` comes from
  `AppLocalizations.supportedLocales`.
- **Logging** — all 63 `debugPrint` calls in 18 files (`lib/models`, `lib/providers`,
  `lib/screens`, `lib/services`, `lib/core/config/config_service.dart`) now use `AppLogger`
  with a fixed operation message and the error passed as `error:`; `stackTrace` added where the
  `catch` could give it. Two "retrying" camera messages are `warning`. The config version
  mismatch note is `debug`. No `debugPrint` or `kDebugMode` is left in `lib/`. Unused
  `flutter/foundation.dart` imports removed. No behaviour change.
- `lib/screens/widgets/history_card.dart` — uses `formattingLocale(...)`.
- Tests updated to the new delegate names: `test/helpers/test_app.dart`,
  `test/screens/help/help_screens_test.dart`, `test/screens/result_screen_test.dart`,
  `test/screens/scan_bubble_settings_screen_test.dart`.
- Docs: `CLAUDE.md` and `AGENTS.md` (same edit: new delegate names and file);
  `docs/architecture.md` (new §4a "App Initialization Sequence" with the logging decision; tree
  and localization text updated); `docs/project_structure.md` (new files). Also `README.md`:
  the old `Sa*` delegate names and file in the tree were updated — not listed in the plan, but
  leaving the old names would make the README wrong.

### Removed
- `lib/l10n/sa_material_localizations.dart`, `lib/l10n/date_format_locale.dart`,
  `test/l10n/sa_localizations_test.dart`, `test/l10n/date_format_locale_test.dart` (replaced
  above).

## Problem found and fixed during the work

The first scripted swap of `debugPrint` calls also removed the closing `}` after one-line
`if (kDebugMode) debugPrint(...);` statements. It was caught at once (the files no longer
parsed) and repaired exactly: for each call, the committed version of the file was read to see
which text had been removed, and that text was put back. A line-by-line review of the diff then
showed only the intended logging and import lines changed.

## Checks

- `dart format --output=none --set-exit-if-changed .` — no changes.
- `flutter analyze` — no issues.
- `flutter test` — all 599 tests passed (was 582: +24 new, −7 replaced).
- Sanskrit Hindi-marker gate — passed.
- `grep -rn "debugPrint\|kDebugMode" lib` — nothing found.
- `flutter build apk --flavor dev --debug` — built; not installed on any device.
- Gradle daemon stopped; no `GradleDaemon` or `KotlinCompileDaemon` process left.
