# Change log: Stop other apps from making the app delete its own files (GhostScan hand-off)

Implements plan: [plans/20261106_060724_ghost_scan_intent_file_delete.md](../plans/20261106_060724_ghost_scan_intent_file_delete.md)

## What was wrong

`MainActivity` is exported. It read a file path from the `image_path` extra of any
`ACTION_GHOST_SCAN` intent. The Dart side then scanned that file and deleted it. Any installed
app could use this to make the app delete its own private files, such as the history database,
the settings file or the secure-storage file.

## What changed

### Native (main fix)
- **New** `android/app/src/main/kotlin/in/sreerajp/qr_studio/GhostScanCaptureStore.kt`: an
  in-process holder (`put` / `take`) for the one capture waiting to go to Flutter.
- `GhostScanCaptureService.kt`: stores the capture (path, from-bubble flag, blocked flag) in the
  holder. The intent to `MainActivity` now carries only the action. The unused `EXTRA_BLOCKED`
  constant was removed.
- `MainActivity.kt`: new `ACTION_GHOST_SCAN` constant. `handleGhostScanIntent` reads no extras;
  it takes the capture from the holder and does nothing if the holder is empty.

### Dart (backup check)
- `lib/services/ghost_scan_service.dart`: new `isOwnCapture(path)`. It is true only for an
  existing `ghost_scan_<digits>.jpg` directly in the app cache folder, after `..` and symbolic
  links are resolved. The cache folder comes from an injectable function (default
  `getTemporaryDirectory`). `deleteCapture` now deletes only files that pass this check, and
  logs a short warning (with no path) when it refuses.
- `lib/screens/scanner_screen.dart`: `_handleGhostScanCapture` ignores any capture that fails
  `isOwnCapture`, so there is no decode and no delete.

### Tests
- `test/services/ghost_scan_service_test.dart`: the old `deleteCapture` test was replaced by a
  new group with 7 tests:
  - accepts a real capture in the cache;
  - rejects a file outside the cache;
  - rejects the `..` trick;
  - rejects other file names and a missing file;
  - still deletes a real capture;
  - never deletes a file outside the cache.

### Docs
- `docs/security.md`: §3.1 has a new row for intents to the exported `MainActivity`. §10.1
  describes the new hand-off and the backup check.
- `CHANGELOG.md`: `[Unreleased]` → new `### Security` entry.

No ARB / localization changes. Nothing new is shown to the user.

## Checks

- `dart format`: clean.
- `flutter analyze`: no issues.
- `flutter test`: all 909 tests pass.

## Manual check (plan §5)

- The dev flavor builds with the new Kotlin code.
- GhostScan from the Quick Settings tile and from the Scan bubble still works.
- The adb attack intent (`ACTION_GHOST_SCAN` with an `image_path` pointing at the app's
  settings file) deleted nothing. Settings stayed in place.
