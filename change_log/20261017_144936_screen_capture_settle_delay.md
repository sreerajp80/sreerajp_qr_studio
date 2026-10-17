# Change log: wait for the screen to settle before the screen-scan capture

Implements plan: [plans/20261017_144006_screen_capture_settle_delay.md](../plans/20261017_144006_screen_capture_settle_delay.md)

## Why

A screen scan (Scan bubble or the GhostScan Quick Settings tile) sometimes said "No codes
were found in the image" for a QR code that was clearly on screen. A normal screenshot of
the same screen, scanned from the gallery, worked. So the decoder was fine. The capture
kept the very first frame, which can still show the fading "Start recording?" dialog and
its dimmed layer.

## What changed

### `android/app/src/main/kotlin/in/sreerajp/qr_studio/GhostScanCaptureService.kt`

- New constant `SETTLE_DELAY_MS = 500L`.
- The image listener no longer uses the first frame. It keeps only the newest frame
  (`heldImage`) and closes the older one it replaces.
- `settleRunnable` runs 500 ms after the virtual display is created. It uses the held frame,
  or, if none has arrived yet, the next frame that arrives. This matters because a still
  screen sends no new frames.
- The frame processing (black-frame check, JPEG save, opening the app) moved unchanged into
  a new `useHeldImage()` method. Width and height are kept in `captureWidth` /
  `captureHeight`.
- The timeout runnable moved to a field so `useHeldImage()` can cancel it. The 3.5 s
  timeout is unchanged.
- `ImageReader` `maxImages` went from 2 to 3, so one frame can be held while
  `acquireLatestImage()` swaps in a newer one. `acquireLatestImage()` is wrapped in a
  `try`/`catch` for `IllegalStateException`.
- `cleanup()` now cancels the settle timer and closes any held frame.
- The class comment is updated (the service is now active for under a second, not ~200 ms).

### `CHANGELOG.md`

- One line under `[Unreleased]` → `### Fixed`.

## Checks

- `flutter analyze`: no issues.
- `flutter test`: all 777 tests passed.
- `flutter build apk --flavor dev --debug`: built (the Kotlin compiles). Gradle and Kotlin
  daemons stopped afterwards.

## Not yet verified

- On-device test (dev build): the bubble capture of the Wikipedia QR page was clean (no
  dimmed dialog) and decoded to the right link, and the result screen opened. The
  "blocked" message for apps that block screen capture was not re-checked.
- The test also found a separate bug: after first-run onboarding, captures were never
  processed until the app was restarted. See
  [plans/20261017_151100_screen_scan_lost_after_onboarding.md](../plans/20261017_151100_screen_scan_lost_after_onboarding.md).
- On a very slow phone the dialog may take longer than 500 ms to fade. If misses still
  happen, raise `SETTLE_DELAY_MS`.
