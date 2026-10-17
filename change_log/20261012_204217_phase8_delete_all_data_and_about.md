# Phase 8 — "Delete all data", visible history error, privacy policy row

Plan: [plans/20261012_202937_phase8_delete_all_data_and_about.md](../plans/20261012_202937_phase8_delete_all_data_and_about.md)
Roadmap: [plans/20261012_191914_guidelines_compliance_roadmap.md](../plans/20261012_191914_guidelines_compliance_roadmap.md) (gap G1; icons → Phase 8b, waiting for a decision)

## What changed

### Delete all data (engineering standard §15.4)
- **New `lib/services/data_wipe_service.dart`** — `DataWipeService.deleteAll()` runs five steps
  and returns the set of failed `DataWipeStep`s (no UI text); every step runs even if one
  fails, and each is logged by name only:
  1. close and delete the history database (via `HistoryProvider.closeAndDeleteDatabase`);
  2. `FlutterSecureStorage.deleteAll()` (history key + API keys);
  3. `SharedPreferences.clear()`;
  4. `ScanBubbleService.clearNativeData()` (stops the bubble, clears native prefs);
  5. delete everything inside the app cache folder.
- `lib/services/history_database_service.dart` — `closeAndDeleteDatabase()`: closes the
  connection, deletes the file with its `-wal`/`-shm`/`-journal` files (sqflite
  `deleteDatabase`), forgets the cached key and upgrade flag. The path code moved into
  `_databasePath()` (same paths as before).
- `lib/providers/history_provider.dart` — `closeAndDeleteDatabase()` (also clears the list in
  memory).
- `lib/services/scan_bubble_service.dart` — `clearNativeData()` → channel method `clearData`.
- Android: `MainActivity.kt` handles `clearData` (stop the bubble service, clear prefs);
  `ScanBubblePrefs.kt` gains `clear(context)`.
- **New `lib/widgets/app_restart_scope.dart`** — `AppRestartScope.restart(context)` swaps a key
  so the whole app (all providers) is built again. `lib/main.dart` wraps the app in it.
- `lib/screens/settings_screen.dart` — Settings → Privacy: red **Delete all data** tile below the
  probing card → confirm dialog (Cancel / red "Delete all") → non-dismissable progress dialog →
  heavy haptic → restart. On a partial failure a dialog "Some data could not be deleted" is
  shown first (a snackbar would be lost in the restart — small change from the plan, which
  said snackbar). `PrivacySettingsScreen` takes an optional `dataWipeServiceBuilder` for tests.
  Imports in this file sorted.

### History load error (§6.3, §11.4)
- `HistoryProvider`: the English `_errorMessage` (with the raw exception) is replaced by
  `bool hasLoadError`; the error is still logged. (The plan said an `AppMessage`; a flag is
  enough because the screen has a single message for it, and it keeps text out of the
  provider just the same.)
- `lib/screens/history_screen.dart`: error state with an icon, `errorHistoryLoadFailed` and a
  **Try again** button that reloads.

### Privacy policy on About (`platform_store_readiness.md` §1)
- `assets/config/app_config.json` — `details.privacyPolicy` with the public GitHub link to
  `PRIVACY_POLICY.md`.
- `lib/screens/about_screen.dart` — label `aboutDetailPrivacyPolicy`, privacy icon; any
  `http(s)` detail value opens in the browser (`LaunchMode.externalApplication`); email still
  opens the mail app.

### Strings (en / ml / sa; ml and sa **need native-reader review**)
New keys, with `@` descriptions in `app_en.arb`: `labelDeleteAllData`, `descDeleteAllData`,
`titleDeleteAllDataConfirm`, `bodyDeleteAllDataConfirm`, `actionDeleteAll`,
`bodyDeletingAllData`, `errorDeleteAllDataPartial`, `errorHistoryLoadFailed`,
`actionTryAgain`, `aboutDetailPrivacyPolicy`. Malayalam and Sanskrit use the language-pack
glossary words (Delete ഇല്ലാതാക്കുക / लुप्यताम्, Data വിവരങ്ങൾ / दत्तांशः, History നാൾവഴി /
इतिवृत्तम्, Settings ക്രമീകരണങ്ങൾ / विन्यासाः, Retry വീണ്ടും ശ്രമിക്കുക / पुनः प्रयत्यताम्,
Privacy policy സ്വകാര്യതാ നയം / गोपनीयतानीतिः). All short keys pass the 20/22 length test; the
Sanskrit text passes the Hindi-marker gate.

### Docs
- `docs/security.md` — new §13 "Data Retention And Purge Policy" (what is stored, until when,
  what deletes it, the five wipe steps); two rows added to §11 testing table.
- `docs/PROJECT_PROFILE.md` §5 — `privacyPolicy` in the About rows.
- `docs/project_structure.md` — `data_wipe_service.dart`, `app_restart_scope.dart`.

### Tests (+13)
- `test/services/data_wipe_service_test.dart` (new): every store cleared (secure storage,
  preferences, native channel call, cache contents; folder kept); a failing database, secure
  storage and native step are reported while preferences and cache are still cleared.
- `history_database_service_test.dart`: `closeAndDeleteDatabase` closes the connection and
  removes the file and `-wal`/`-shm`/`-journal`.
- `history_screen_test.dart`: in en, ml, sa a load error shows the message and Try again
  reloads the list.
- `settings_screen_test.dart`: Cancel deletes nothing; Delete all wipes and rebuilds the app;
  a partial failure is shown before the restart; tile and dialog fit in en, ml, sa with
  tooltips checked.
- `about_screen_test.dart`: the privacy policy row shows with its label and link.

## Problem found during testing
The restart did not happen in the widget test because `await HapticFeedback.heavyImpact()`
never completed inside the test zone. The haptic is now fire-and-forget (`unawaited`), which is
also the right choice in the app (a slow haptic must not delay the restart).

## Checks
- `flutter gen-l10n`; `dart format --output=none --set-exit-if-changed .` — no changes.
- `flutter analyze` — no issues.
- `flutter test` — all 654 tests passed.
- Sanskrit Hindi-marker gate — passed.
- `flutter build apk --flavor dev --debug` — built (Kotlin changed); not installed on any
  device.
- Gradle daemon stopped; one leftover Kotlin/Gradle Java process was ended; none left.

## Notes for later
- Existing strings use History terms that differ from the language-pack glossary
  (`tabHistory` ml is the transliteration "ഹിസ്റ്ററി"; other keys use ചരിത്രം / इतिहासः, the
  glossary says നാൾവഴി / इतिवृत्तम्). New strings follow the glossary; aligning the old ones
  fits Phase 10 (key rename, done screen by screen).
- Release item: try "Delete all data" once on a real device (needs the user's approval to
  install).
