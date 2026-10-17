# Change log: screen-scan captures lost after first-run onboarding

Implements plan: [plans/20261017_151100_screen_scan_lost_after_onboarding.md](../plans/20261017_151100_screen_scan_lost_after_onboarding.md)

## Why

On a fresh install, after onboarding, a screen scan (Scan bubble or Quick Settings tile)
showed nothing, and the captured picture was never decoded until the app was restarted.
Finishing onboarding built two main shells, so two `ScannerScreen`s. Each made its own
`GhostScanService`, and each one set the method channel's single handler. The handler ended
up on the service of the shell that was then disposed, so its stream was closed and every
capture was dropped.

## What changed

### `lib/services/ghost_scan_service.dart`

- New `static final GhostScanService instance`: one shared service for the app, so the
  channel handler is set once.
- Doc comments explain why there is only one, and that `dispose()` is only for services
  made with a test channel.

### `lib/screens/scanner_screen.dart`

- Uses `GhostScanService.instance`.
- `dispose()` no longer disposes the service; it only cancels this screen's subscription
  (as before).

### `lib/screens/onboarding_screen.dart`

- First-run finish no longer calls `Navigator.pushReplacement(... MainShellScreen())`.
  `completeOnboarding()` already makes `MaterialApp.home` show the main shell.
- Removed the now-unused `main_shell_screen.dart` import.
- Replay (`isReplay`) and `onCompleted` paths are unchanged.

### Tests

- `test/services/ghost_scan_service_test.dart`: `instance` is one shared object; a capture
  still reaches a new listener after an earlier listener cancelled.
- `test/screens/onboarding_screen_test.dart`: finishing (Start Scanning and Skip) no
  longer pushes a `MainShellScreen` from the onboarding screen.

### `CHANGELOG.md`

- One line under `[Unreleased]` → `### Fixed`.

## Checks

- `dart format` on the changed files.
- `flutter analyze`: no issues.
- `flutter test`: all 779 tests passed.

## On-device check (dev build)

- Cleared the dev app's data, finished onboarding, turned on the Scan bubble, and did a
  bubble scan of the Wikipedia QR page **without restarting the app** (same process
  throughout). The result screen opened with `http://ml.wikipedia.org`, and the captured
  picture was removed from the cache.

## Not yet verified

- That the move from onboarding to the main screen still looks smooth now that it comes
  from the `home` rebuild instead of a page transition (onboarding was finished on the
  phone by hand, not watched).
