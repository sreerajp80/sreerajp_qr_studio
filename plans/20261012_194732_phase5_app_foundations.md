# Phase 5 — App foundations: flavor config, logger, error handlers, startup order, l10n delegates

**Status:** completed

Part of [plans/20261012_191914_guidelines_compliance_roadmap.md](20261012_191914_guidelines_compliance_roadmap.md)
(gaps D2–D6).

Target layers (CLAUDE.md "state the target layer"): `core/config/` (flavor config),
`core/logging/` (logger, new folder), `core/errors/` (error handlers, folder listed in
`guideline.md` §3), `services/` (startup service), `widgets/` (safe error fallback),
`l10n/` (fallback delegates and formatting helper).

## What the issue is

1. **No `AppFlavorConfig` (§5.2, MUST).** The app has dev and prod flavors but no Dart class that
   reads the flavor. Code uses `kDebugMode` instead, which §22.2 forbids as a substitute for the
   flavor.
2. **No `AppLogger` (§14).** There are 63 `debugPrint` calls in 18 files in `lib/` (§14.3: banned in
   committed code). Most print the raw exception (`$e`), which may hold user data (scanned
   content, file names) — §14.3 says log the operation and error category, not raw messages.
3. **No global error handlers (§11.1, MUST).** No `FlutterError.onError`, no
   `PlatformDispatcher.instance.onError`, no release `ErrorWidget.builder`.
4. **Startup order (§3.2, §4.5, §8.4).** `main()` only registers licenses and calls `runApp`.
   `LocaleProvider` and `OnboardingProvider` read `SharedPreferences` *after* the first frame, so
   the saved language is not applied before the first frame (§8.4 MUST).
5. **Localization shape (§8.1, §8.3.1, §8.3.2).**
   - Fallback delegates are `Sa*` classes with a hard-coded `'sa'`; the standard shape is one set
     `kFrameworkFallbackLanguages` (from the profile) and `Fallback*` delegates.
   - `MaterialApp.supportedLocales` is a hand-written list; it should be
     `AppLocalizations.supportedLocales` (equals the declared languages).
   - The delegate list should be `AppLocalizations.delegate`, the fallbacks, then
     `...GlobalMaterialLocalizations.delegates`.
   - The formatting helper is `dateFormatLocale(String)`; the standard (and the new CLAUDE.md /
     AGENTS.md rule) names it `formattingLocale(Locale)`.
   - `LocaleProvider.supportedLanguages` is a second hand-written list; it should come from
     `AppLocalizations.supportedLocales`.

## Files to be changed

New:
- `lib/core/config/app_flavor_config.dart` — `AppFlavor` enum + `AppFlavorConfig` exactly in the
  §5.2 two-variable shape (`APP_FLAVOR`, then `FLUTTER_APP_FLAVOR`, default `prod`), with
  `isDev`, `isProd`, `enableVerboseLogging`.
- `lib/core/logging/app_logger.dart` — `AppLogger` with `trace/debug/info/warning/error/fatal`.
- `lib/core/errors/global_error_handlers.dart` — installs the three handlers.
- `lib/widgets/safe_error_fallback.dart` — minimal, context-free release fallback widget.
- `lib/services/app_startup_service.dart` — runs the startup steps in order.
- `lib/l10n/fallback_localizations.dart` — replaces `sa_material_localizations.dart`.
- `lib/l10n/formatting_locale.dart` — replaces `date_format_locale.dart`.
- Tests: `test/core/config/app_flavor_config_test.dart`,
  `test/core/logging/app_logger_test.dart`, `test/core/errors/global_error_handlers_test.dart`,
  `test/services/app_startup_service_test.dart`, `test/widgets/safe_error_fallback_test.dart`,
  `test/l10n/fallback_localizations_test.dart` (moved from `sa_localizations_test.dart`),
  `test/l10n/formatting_locale_test.dart` (moved from `date_format_locale_test.dart`).

Changed:
- `lib/main.dart` — thin `main()`; delegate list and `supportedLocales` as above.
- `lib/providers/locale_provider.dart`, `lib/providers/onboarding_provider.dart` — take the
  preloaded `SharedPreferences` (they already accept it); `supportedLanguages` from
  `AppLocalizations.supportedLocales`.
- The 18 `lib/` files with `debugPrint` / `kDebugMode` logging — switch to `AppLogger`.
- `lib/screens/widgets/history_card.dart` — use `formattingLocale(...)`.
- Tests that import the old delegate or helper names (`test/helpers/test_app.dart`,
  `test/screens/help/help_screens_test.dart`, `test/screens/result_screen_test.dart`,
  `test/screens/scan_bubble_settings_screen_test.dart`, `test/providers/locale_provider_test.dart`
  if needed).
- `CLAUDE.md`, `AGENTS.md` — the fallback delegate names in the localization rules (both files).
- `docs/architecture.md` — new short section "App initialization sequence" (§4.5 asks for it);
  `docs/project_structure.md` — new files in the tree.

Deleted (replaced): `lib/l10n/sa_material_localizations.dart`, `lib/l10n/date_format_locale.dart`,
`test/l10n/sa_localizations_test.dart`, `test/l10n/date_format_locale_test.dart`.

## Plan for the fix

1. **`AppFlavorConfig`** — copy the §5.2 class (names adapted: no app-name/banner getters, since
   the display name comes from Android resources; keep `isDev`, `isProd`,
   `enableVerboseLogging`). Test: default is prod; parse is case-insensitive; unknown → prod.
2. **`AppLogger`** — no new package; built on `dart:developer` `log()` (keeps the dependency list
   unchanged, §16.5). Rules:
   - `trace`/`debug` print only when `AppFlavorConfig.instance.enableVerboseLogging` (dev).
   - `info`/`warning`/`error`/`fatal` always go out. `error`/`fatal` take `error` and
     `stackTrace` (§14.3). In **prod**, the error is reduced to its type name
     (`error.runtimeType`) and the message stays the fixed operation text, so no raw exception
     text (which can contain scanned content) is logged. In dev, the full error is logged.
   - Console only — **no log file**. So there is nothing to rotate (§14.4) and nothing extra to
     purge (§15.4). This is written down in `docs/architecture.md`.
   - Tests use an injectable sink so output can be checked.
3. **Replace logging calls** — every `debugPrint` and `if (kDebugMode) debugPrint(...)` in
   `lib/` becomes an `AppLogger` call with a fixed operation message and the error passed as
   `error:` (for example `AppLogger.error('Inserting scan record failed', error: e,
   stackTrace: st)`). Add `stackTrace` to the `catch` where it is cheap. No behaviour change.
   After this, `grep debugPrint lib` must be empty.
4. **Global error handlers** — `GlobalErrorHandlers.install()` sets, per §11.1:
   `FlutterError.onError` (log; in non-release also `dumpErrorToConsole`),
   `PlatformDispatcher.instance.onError` (log, return `true`), and in release
   `ErrorWidget.builder = (_) => const SafeErrorFallback()`. No `runZonedGuarded`.
5. **`SafeErrorFallback`** — a plain centered icon (`Icons.error_outline`) on the surface color,
   no text and no controls, so it needs no context, localization or theme lookup that could
   fail the same way. Wrapped in `Semantics` without a hard-coded string (excluded from
   semantics) — the screen around it still has its own labels.
6. **Startup service** — `AppStartupService.run()` does, in order (§4.5):
   1. `WidgetsFlutterBinding.ensureInitialized()`;
   2. `AppLogger` ready + `GlobalErrorHandlers.install()`; log start, flavor and version;
   3. (no FFI init needed on Android — the barcode decoder loads lazily);
   4. (secure storage, 5. database: stay lazy, as now — §10.6 "defer non-critical init");
   6. register open-source licenses; load `SharedPreferences` once (for the saved language
      and onboarding flag) — each step in `try/catch`, so a failure logs and falls back to
      defaults instead of crashing;
   7. (lifecycle observers stay in the screens that use the camera, as now);
   8. return the loaded values to `main()`.
   `main()` becomes: `final startup = await AppStartupService.run(); runApp(SreerajQRReaderApp(
   prefs: startup.prefs));`. The app widget passes `prefs` to `LocaleProvider` and
   `OnboardingProvider`, so the language is set before the first frame. If `prefs` is `null`
   (load failed), the providers keep their current async fallback.
7. **Localization**
   - `lib/l10n/fallback_localizations.dart`: `kFrameworkFallbackLanguages = {'sa'}`,
     `kFrameworkFallbackLocale = Locale('en')`, and `FallbackMaterialLocalizationsDelegate`,
     `FallbackCupertinoLocalizationsDelegate`, `FallbackWidgetsLocalizationsDelegate` (§8.3.1
     code). Same behaviour as today for `sa`.
   - `main.dart`: `localizationsDelegates: [AppLocalizations.delegate, Fallback…×3,
     ...GlobalMaterialLocalizations.delegates]`, `supportedLocales:
     AppLocalizations.supportedLocales`; keep the current `localeResolutionCallback`, but
     return `supportedLocales.first` instead of a literal `Locale('en')`.
   - `lib/l10n/formatting_locale.dart`: `String formattingLocale(Locale locale)` as in §8.3.2;
     `history_card.dart` passes `Localizations.localeOf(context)`.
   - `LocaleProvider.supportedLanguages` built from `AppLocalizations.supportedLocales`.
8. **Docs** — `docs/architecture.md`: add "App initialization sequence" listing the real order
   and the logging decision (console only, prod hides raw errors). `docs/project_structure.md`:
   new files. `CLAUDE.md` / `AGENTS.md`: new delegate names (same edit in both).
9. **Verify** — `dart format` check, `flutter analyze` (0 issues), `flutter test` (all pass,
   plus the new tests), Sanskrit gate, `grep -rn "debugPrint\|kDebugMode" lib` (only allowed
   leftover: none expected), one `flutter build apk --flavor dev --debug`, then
   `android\gradlew --stop` and end leftover `GradleDaemon` / `KotlinCompileDaemon` processes. No
   install on any device.

## Out of scope

- Moving the route table / theme wiring out of `main.dart` (CLAUDE.md allows routes there).
- Lifecycle behaviours of §9.2 (app lock, blur on `inactive`) — a separate security item, to be
  checked in Phase 9 with `docs/security.md`.
- Log export UI (§14.4 applies only to apps that write log files).
