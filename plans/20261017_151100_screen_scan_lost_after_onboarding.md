# Plan: screen-scan captures are lost after first-run onboarding

**Status:** completed

## The issue

On a fresh install, after the user finishes onboarding, a screen scan (Scan bubble or
Quick Settings tile) shows **nothing**: no "Analyzing…" message, no result, no "no codes
found" message. The captured picture stays in the app cache and is never decoded. It keeps
failing until the app is fully restarted. After a restart it works.

Found while testing the settle-delay fix
([plans/20261017_144006_screen_capture_settle_delay.md](20261017_144006_screen_capture_settle_delay.md))
on a phone:

- Three bubble captures stayed in the cache, never processed. All three decode fine on a
  PC.
- Replaying the same "capture done" message after a cold start of the app: decoded, and
  the result screen opened (`http://ml.wikipedia.org`).
- Replaying it to the running app after the restart: also worked.

Cause:

1. When onboarding finishes, `OnboardingScreen._finishOnboarding()` calls
   `provider.completeOnboarding()`. That makes `MaterialApp.home` in `main.dart` switch to
   `MainShellScreen`. Then it **also** calls
   `Navigator.pushReplacement(... MainShellScreen())`. So two main shells, and two
   `ScannerScreen`s, are built. One of them is thrown away soon after.
2. Each `ScannerScreen` makes its own `GhostScanService`. Its constructor calls
   `MethodChannel.setMethodCallHandler`, and only the **last** caller receives messages.
   If the last one belongs to the shell that is thrown away, its stream is closed, and
   every later capture is dropped silently.

## Files to change

- `lib/services/ghost_scan_service.dart` — one shared instance for the app
  (`GhostScanService.instance`), so the channel handler is set once and never points at a
  disposed screen. Keep the `{MethodChannel? channel}` constructor for tests.
- `lib/screens/scanner_screen.dart` — use `GhostScanService.instance`; in `dispose()` only
  cancel this screen's subscription, do not close the shared service.
- `lib/screens/onboarding_screen.dart` — on first run, stop pushing a second
  `MainShellScreen`. `completeOnboarding()` already makes `home` show the main shell.
  The replay path (`isReplay`) and `onCompleted` are unchanged.
- `test/services/ghost_scan_service_test.dart` — add a test: a capture still reaches a
  listener after another listener has cancelled (the shared instance stays open).
- `test/screens/onboarding_screen_test.dart` — check that finishing onboarding shows
  exactly one `MainShellScreen`, if the test setup allows it.
- `CHANGELOG.md` — one line under `[Unreleased]` → `### Fixed`.
- `change_log/<timestamp>_screen_scan_lost_after_onboarding.md` (new, after the change).

Layers: the service stays in `services/`; the screens only change how they use it. No new
classes, no new dependencies, no Kotlin, ARB or manifest changes.

## The fix

1. `GhostScanService`
   - Add `static final GhostScanService instance = GhostScanService();`.
   - Keep the stream as a broadcast stream. Several listeners can come and go; the
     handler always feeds the same, open controller.
   - `dispose()` stays for tests and for instances made with a test channel, but the screen
     no longer calls it on the shared instance.
2. `ScannerScreen`
   - `_ghostScanService = GhostScanService.instance;`
   - Remove `_ghostScanService.dispose()` from `dispose()`. Cancelling
     `_ghostScanSubscription` stays.
3. `OnboardingScreen._finishOnboarding()`
   - First-run path: after `completeOnboarding()`, do nothing else. The provider change
     rebuilds `home` into `MainShellScreen`, which is the only shell.
   - Check on the phone that the move from onboarding to the main screen still looks right.

## Testing

- `flutter analyze`, `flutter test`.
- On the phone (dev build only, and only with your OK): clear the dev app's data so
  onboarding shows again, finish onboarding, then run a bubble scan without restarting.
  The result should appear.

## Side note (not part of this fix)

In one of my test captures the bubble itself showed in the picture (right edge, away from
the QR code). Your two captures did not show it, so the bubble normally hides. It may
have been caused by my tap from the PC. I will not change anything for it now.
