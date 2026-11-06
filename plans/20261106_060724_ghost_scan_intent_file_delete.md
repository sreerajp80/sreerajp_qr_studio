# Plan: Stop other apps from making the app delete its own files (GhostScan hand-off)

**Status:** completed

**Security impact:** Yes. Closes a hole in an exported activity (platform folder `android/`).
After the fix, an intent from another app can no longer choose which file the app scans and
deletes. No new permissions, no network change, no new dependencies.

---

## 1. The issue

`MainActivity` is exported (it must be: it is the launcher activity and the share target).
Any app on the phone can start it with an explicit intent.

`MainActivity.handleGhostScanIntent` reacts to the action
`in.sreerajp.qr_studio.ACTION_GHOST_SCAN` and reads the file path from the `image_path`
extra. It does not check who sent the intent or where the path points. The path goes to
Dart, where `ScannerScreen._handleGhostScanCapture` tries to decode the file and then calls
`GhostScanService.deleteCapture(path)`. That deletes the file, whether the decode worked or not.

So another installed app can send:

- action `in.sreerajp.qr_studio.ACTION_GHOST_SCAN`
- `image_path` = a file inside this app's private folder (the history database, the shared
  preferences file, the secure-storage file)

The app then deletes its own scan history, settings or saved API keys. No permission is
needed. The user only sees the app come to the front.

Only our own `GhostScanCaptureService` should ever hand a capture to `MainActivity`.

## 2. The fix

Two layers.

### Layer 1 (main fix, native): the intent no longer carries a path

- Add a small in-process holder, `GhostScanCaptureStore` (Kotlin `object`), with:
  - `put(path, fromBubble, blocked)`, called by `GhostScanCaptureService` after it writes the JPEG;
  - `take(): Capture?`, which returns the pending capture once and then clears it.
- `GhostScanCaptureService` stores the capture in the holder. It then starts `MainActivity`
  with the same action but **no** `image_path`, `fromBubble` or `blocked` extras.
- `MainActivity.handleGhostScanIntent` reads nothing from the intent except the action. It
  takes the capture from the holder. If the holder is empty, it does nothing.

Why this works: the holder lives in the app's own process memory, so no other app can write
to it. An intent from another app can at most deliver a real capture early, and that
capture is harmless (it is our own cache file). The service and the activity run in the
same process, so the holder is shared.

Option I considered and dropped: a random one-time token in the intent. It adds code and
gives no extra protection, because the intent no longer carries anything that can be abused.

### Layer 2 (backup check, Dart): only our own capture files are scanned or deleted

- `GhostScanService` gets `isOwnCapture(String path)`. It returns true only when:
  - after resolving `..` and symlinks, the file is directly inside the app cache folder
    (`getTemporaryDirectory()`, which is `cacheDir` on Android); and
  - the file name matches `ghost_scan_<digits>.jpg`.
- The cache folder comes from an injectable function (default `getTemporaryDirectory`), so
  tests can pass a temp folder.
- `deleteCapture` deletes only when `isOwnCapture` is true. Otherwise it logs a short warning
  (no path in the log) and returns.
- `ScannerScreen._handleGhostScanCapture` checks `isOwnCapture` first. If it is false, it
  ignores the capture: no decode, no delete, no message.

This keeps us safe even if a future change sends a path again.

## 3. Files to change

| File | Change |
|------|--------|
| `android/app/src/main/kotlin/in/sreerajp/qr_studio/GhostScanCaptureStore.kt` | **New.** In-process holder for the pending capture |
| `android/app/src/main/kotlin/in/sreerajp/qr_studio/GhostScanCaptureService.kt` | Put the capture in the holder; send the intent with no path or flag extras |
| `android/app/src/main/kotlin/in/sreerajp/qr_studio/MainActivity.kt` | `handleGhostScanIntent` takes the capture from the holder and ignores intent extras |
| `lib/services/ghost_scan_service.dart` | Add `isOwnCapture`; injectable cache-folder function; `deleteCapture` only deletes own captures |
| `lib/screens/scanner_screen.dart` | Ignore captures that fail `isOwnCapture` |
| `test/services/ghost_scan_service_test.dart` | Update the `deleteCapture` test to use an injected cache folder and a `ghost_scan_<n>.jpg` name; add tests (see §4) |
| `docs/security.md` | §10.1: note that the GhostScan hand-off to the exported `MainActivity` carries no data, and why. §3.1 input table: the platform-intent row |
| `CHANGELOG.md` | `[Unreleased]` → `### Security`: one user-facing line |

No ARB / localization changes: nothing new is shown to the user.

## 4. Tests

New or updated unit tests in `test/services/ghost_scan_service_test.dart`:

- `isOwnCapture` is true for `<cache>/ghost_scan_123.jpg`.
- It is false for a file outside the cache folder (for example `<other>/ghost_scan_1.jpg`).
- It is false for `<cache>/../databases/history.db` (the `..` trick).
- It is false for a wrong name inside the cache (`<cache>/clipboard_image_1.png`, `<cache>/history.db`).
- `deleteCapture` does **not** delete a file outside the cache folder.
- `deleteCapture` still deletes a real `ghost_scan_<n>.jpg` in the cache folder.

The Kotlin holder has no unit-test setup in this project, so it is checked by hand (§5).

Then run `flutter analyze`, `flutter test` and `dart format .`.

## 5. Manual check (user runs it, on an emulator or the dev build only)

1. Build and install the **dev** flavor on an emulator.
2. Scan with GhostScan from the tile and from the Scan bubble. The scan still works and the
   cache file is removed.
3. Try the attack with adb. Expected: nothing is deleted and history is still there.
   ```
   adb shell am start -n in.sreerajp.qr_studio.dev/in.sreerajp.qr_studio.MainActivity -a in.sreerajp.qr_studio.ACTION_GHOST_SCAN --es image_path /data/data/in.sreerajp.qr_studio.dev/shared_prefs/FlutterSharedPreferences.xml
   ```
4. After the build, run `android\gradlew --stop` and make sure no Gradle or Kotlin daemon is left.

## 6. Out of scope

The other findings from the security review (redirect check, sandbox body limit, AR open
button, passphrase length, old StegoQR format) each get their own plan.
