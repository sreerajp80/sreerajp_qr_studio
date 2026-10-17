# Phase 8 — "Delete all data", visible history error, privacy policy row (icons split out)

**Status:** completed

Part of [plans/20261012_191914_guidelines_compliance_roadmap.md](20261012_191914_guidelines_compliance_roadmap.md)
(gap G1, plus two items found in Phases 1 and 6b). The icon work of gap G2 is split into
**Phase 8b** because it needs a design decision from you (see the end).

Target layers: `services/` (data wipe), `widgets/` (app restart scope), `providers/`
(history error state), `screens/` (Settings → Privacy, History, About), `l10n/`, Android
native (`ScanBubblePrefs`, method channel).

## What the issue is

1. **No "Delete all data" (§15.4, MUST).** "Every app that stores user-generated data MUST …
   provide a user-accessible 'Delete all data' action that removes all local app data including
   the database, log files, cached files, and secure storage entries." The app only has "Clear
   history". Data the app keeps today:
   - scan-history SQLite file (`sreeraj_scan_history.db`, plus its WAL/SHM files);
   - secure storage: the history key and the user's API keys;
   - Flutter `SharedPreferences`: language, theme, onboarding flag, scan feedback, privacy and
     URL-safety settings, counters;
   - native `scan_bubble_prefs` (bubble on/off, start on boot, position);
   - cache/temp files: GhostScan captures, clipboard images, CodeForge exports;
   - no log files (console only since Phase 5).
2. **History load errors are invisible (§6.3, §11.4).** `HistoryProvider` stores an English
   sentence with the raw exception in `_errorMessage`, but no screen shows it; a failed load
   (for example, the history key cannot be read — Phase 6b) looks like an empty history. The
   English text also breaks the "services/providers return keys, not text" rule.
3. **No privacy policy row on About (`platform_store_readiness.md` §1).** "Privacy policy … Link
   it from the About screen." The profile lists the URL; `app_config.json` has no
   `privacyPolicy` detail.

## Files to be changed

- `lib/services/data_wipe_service.dart` — new: deletes every store listed above.
- `lib/services/history_database_service.dart` — `closeAndDeleteDatabase()` (close the
  connection, delete the file and its `-wal`/`-shm`/`-journal` files, forget the cached key).
- `lib/services/scan_bubble_service.dart` — `clearNativeData()` calling a new channel method.
- `android/app/src/main/kotlin/in/sreerajp/qr_studio/ScanBubblePrefs.kt` — `clear(context)`.
- `android/app/src/main/kotlin/in/sreerajp/qr_studio/MainActivity.kt` — channel method
  `clearData` (stop the bubble, clear its prefs).
- `lib/widgets/app_restart_scope.dart` — new: rebuilds the whole app (new provider tree) after
  the wipe, so no screen keeps old data in memory.
- `lib/main.dart` — wrap the app in `AppRestartScope`.
- `lib/screens/settings_screen.dart` — Privacy page: "Delete all data" tile, confirmation
  dialog, progress, result.
- `lib/providers/history_provider.dart` — replace the English `_errorMessage` with a typed load
  error (`AppMessage` key), keep the log.
- `lib/screens/history_screen.dart` — show an error state with a "Try again" button.
- `assets/config/app_config.json` — add `details.privacyPolicy` (the URL from
  `docs/PROJECT_PROFILE.md`).
- `lib/screens/about_screen.dart` — `privacyPolicy` row opens the link in the browser; icon.
- `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb` — new keys (below); `flutter gen-l10n`.
- `docs/PROJECT_PROFILE.md` §5 — `privacyPolicy` row added; `docs/security.md` §13 data
  retention and purge (what is stored, how long, what deletes it).
- Tests: `test/services/data_wipe_service_test.dart` (new), `test/screens/settings_screen_test.dart`,
  `test/screens/history_screen_test.dart`, `test/providers/history_provider_test.dart`,
  `test/screens/about_screen_test.dart`, `test/services/history_database_service_test.dart`.
- `change_log/<timestamp>_phase8_delete_all_data_and_about.md` — new.

## Plan for the fix

1. **`DataWipeService.deleteAll()`** — runs every step even if one fails, and returns which
   steps failed (no UI text):
   1. `HistoryDatabaseService.closeAndDeleteDatabase()`;
   2. `FlutterSecureStorage().deleteAll()` (history key + API keys);
   3. `SharedPreferences.clear()`;
   4. `ScanBubbleService.clearNativeData()` → native: stop the bubble service, then
      `ScanBubblePrefs.clear()`;
   5. delete everything inside `getTemporaryDirectory()` (the app cache).
   Each step is logged by name only (`AppLogger`), never with data.
2. **Restart after the wipe** — `AppRestartScope` (small `StatefulWidget` above `MultiProvider`)
   with `AppRestartScope.restart(context)`, which swaps its `Key` so every provider is created
   again. With preferences cleared, the app opens on onboarding in the system language, like a
   fresh install.
3. **UI** — Settings → Privacy: a red "Delete all data" tile at the bottom.
   - Tap → `AlertDialog` (§6.4: destructive confirm uses a destructive label): title "Delete
     all data?", body listing what goes (history, saved API keys, all settings, Scan bubble
     settings, temporary files) and "This cannot be undone.", buttons "Cancel" / "Delete all".
   - While working: a progress dialog (no other actions). Then a heavy haptic (§6.6) and the
     restart. If a step failed: a `SnackBar` "Some data could not be deleted"; the restart
     still happens, so what the app shows matches what is left on the device.
4. **History error state** — `HistoryProvider.loadError` becomes an `AppMessage?`
   (`historyLoadFailed`); `history_screen.dart` shows an error icon, the localized message and a
   "Try again" button that calls `loadRecords()`. The loading and empty states stay as they are.
5. **Privacy policy row** — `app_config.json` → `"privacyPolicy":
   "https://github.com/sreerajp80/sreerajp_qr_studio/blob/main/PRIVACY_POLICY.md"`; About shows
   it with `aboutDetailPrivacyPolicy` and `Icons.privacy_tip_outlined`, opening it with
   `launchUrl(..., mode: LaunchMode.externalApplication)`. A tap only opens the browser; nothing
   is sent.
6. **New ARB keys** (en / ml / sa, each with an `@` description; short keys within the 20/22
   budget; ml and sa marked "needs native-reader review"):
   `labelDeleteAllData` ("Delete all data"), `descDeleteAllData` (tile subtitle),
   `titleDeleteAllDataConfirm` ("Delete all data?"), `bodyDeleteAllDataConfirm` (what goes +
   cannot be undone), `actionDeleteAll` ("Delete all"), `bodyDeletingAllData` ("Deleting…"),
   `errorDeleteAllDataPartial` ("Some data could not be deleted"), `errorHistoryLoadFailed`
   ("History could not be loaded"), `actionTryAgain` (reuse an existing "Try again" key if one
   exists), `aboutDetailPrivacyPolicy` ("Privacy policy"). New keys already use the standard
   prefixes, so the Phase 7 length test covers them.
7. **Tests**
   - `DataWipeService`: with fakes for each store, every store is cleared; one failing step
     does not stop the others and is reported.
   - `HistoryDatabaseService.closeAndDeleteDatabase()`: file and `-wal`/`-shm` gone; a later
     call opens a fresh empty database with a new key.
   - Settings: the tile is shown; Cancel deletes nothing; confirm calls the wipe and restarts
     (fake service); in en, ml, sa without overflow, tooltips checked.
   - History: a load error shows the localized message and "Try again" reloads.
   - About: the privacy row is shown with its localized label; the parity test already checks
     `aboutDetailPrivacyPolicy` exists for the new detail key.
8. **Docs** — `docs/security.md` §13 "Data retention and purge" (stores, retention = until the
   user deletes, triggers = Clear history / Delete all data / uninstall, no cloud copies);
   `docs/PROJECT_PROFILE.md` §5 add `privacyPolicy` to the About rows.
9. **Verify** — `flutter gen-l10n`, format check, `flutter analyze`, `flutter test`, Sanskrit
   gate, `flutter build apk --flavor dev --debug` (Kotlin changed), then `android\gradlew --stop`
   and end leftover `GradleDaemon` / `KotlinCompileDaemon` processes. No install on any device.

## Phase 8b — app icons (needs your decision first; not part of this approval)

While checking G2 I found a bigger gap: the app has **no adaptive launcher icon at all** — only
square `ic_launcher.png` files. §17.5 says Android **MUST** ship an adaptive icon (foreground +
background layers) and SHOULD ship a monochrome layer; the dev flavor SHOULD look different.
The only source image is `assets/app_icon.png` (1024×1024, no transparency). Options:

- **A (best result):** you provide a foreground logo on a transparent background (and,
  if you like, a one-colour monochrome version); I set up `flutter_launcher_icons`
  (dev dependency, MIT) to generate all layers and a "DEV" badge variant.
- **B (no new artwork):** I generate the layers from the current icon — foreground = current
  icon scaled into the adaptive safe zone, background = its edge colour, monochrome = a
  one-colour silhouette made by thresholding — and a "DEV" badge copy for the dev flavor. Quality
  of the monochrome version may be rough.
