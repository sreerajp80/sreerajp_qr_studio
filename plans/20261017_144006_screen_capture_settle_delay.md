# Plan: wait for the screen to settle before the screen-scan capture

**Status:** completed

## The issue

A QR code that is on screen is sometimes not found when you scan the screen with the
Scan bubble (or the GhostScan Quick Settings tile). The app says "No codes were found in
the image". Example: a normal-sized QR code on a Wikipedia page.

What we found:

- A normal phone screenshot of the same page, scanned from the gallery, **works**. So
  the decoder and its settings are fine.
- The same screenshot also decodes on a PC with the same engine (zxing-cpp v3.1.1) and
  the same options.
- Zooming the page in before the bubble scan also works.

So the problem is the picture that the screen scan captures, not the decoder.

`GhostScanCaptureService.startCapture()` keeps the **very first frame** that the virtual
display sends. That frame arrives right after the system "Start recording or casting?"
dialog closes. At that moment the screen can still show the dialog fading out and the
dimmed layer behind it. A dimmed, partly covered small QR code cannot be read. A zoomed-in
(bigger) code can still be read, which matches what we saw.

## Files to change

- `android/app/src/main/kotlin/in/sreerajp/qr_studio/GhostScanCaptureService.kt`
- `CHANGELOG.md` (one line under `[Unreleased]` → `### Fixed`)
- `change_log/<timestamp>_screen_capture_settle_delay.md` (new, after the change)

No Dart, ARB or manifest changes. No new permissions. No new dependencies.

## The fix

In `GhostScanCaptureService.startCapture()`:

1. Note the time when the virtual display is created.
2. In the image listener, do not use frames at once. Always keep only the **newest**
   frame (`acquireLatestImage()`), and close the older one it replaces. This keeps the
   reader's small queue from filling up and stalling.
3. Add a **settle delay** of about 500 ms after the display is created (a named constant,
   `SETTLE_DELAY_MS`). When the delay ends:
   - if a frame is held, use it (this is the screen after the dialog has gone);
   - if no frame has arrived yet, use the next frame that arrives.
   A static screen sends no new frames, so we must use the held frame rather than wait for
   a new one.
4. The rest stays the same: the black-frame check (`isAlmostAllBlack`), saving the JPEG,
   opening the app, `cleanup()`, the 3.5 s timeout, and bringing the bubble back.
5. Close any held frame in `cleanup()` so nothing leaks if the scan is stopped early.
6. Fix the class comment (it says the service is active for "~200ms"); it is now about
   half a second longer.

Effect for the user: a screen scan takes about half a second longer, but captures the
real page instead of the fading dialog. The same fix covers the Scan bubble and the
Quick Settings tile, because both use this service.

## Testing

- `flutter analyze` and `flutter test` (no Dart code changes, so this only confirms nothing
  else broke).
- Build the `dev` flavor to make sure the Kotlin compiles, then stop the Gradle daemons.
- On-device check by you (I will not install on your phone without asking): open the same
  Wikipedia page without zooming, tap the bubble, and confirm the QR code is found. Also
  check that a black/blocked app still shows the "blocked" message.

## Risks

- On a very slow phone the dialog might take longer than 500 ms to fade. If the problem
  still shows up, we can raise the delay. The 3.5 s timeout is still well above it.
