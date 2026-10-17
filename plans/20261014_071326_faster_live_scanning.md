# Faster live QR / barcode scanning

**Status:** completed

## The issue

Scanning with the camera is slow, even for clean printed codes.

I read the scan path (camera → decoder isolate → zxing-cpp → scanner screen).
The native build is already optimised (`-O3` even in debug), so the slowness is
in how much work we ask the decoder to do on **every** camera frame:

1. **Every frame uses the heaviest live settings.** `DecodeProfile.live` turns on
   `tryHarder` + `tryRotate` + `tryDownscale` (`native_barcode_reader.dart`).
   `tryHarder` makes zxing-cpp scan many more rows and try more detector paths.
   `tryRotate` runs every 1D barcode reader a second time on a turned image.
2. **Frames are Full HD by default.** The default resolution is `fullHd`
   (1920×1080) (`camera_settings_provider.dart`). So the heavy pass runs on
   about 2 million pixels per frame.
3. **The decoder never stops early.** Multi-code selection is on by default, so
   the frame is decoded with `maxSymbols = 8`. zxing-cpp only stops early when it
   has found that many codes. With one code in view, it still runs the full
   image **and** the downscaled image(s) before it returns
   (`zxing-cpp/core/src/ReadBarcode.cpp`, the `pyramid.layers` loop). The result
   only comes back after all of that.
4. **10 formats are searched each frame** (QR, Data Matrix, PDF417 and 7 kinds of
   1D barcode).

Because newer frames are dropped while one frame is being decoded, a slow
decode means few frames are tried each second. If one of those frames is a bit
blurred, the user waits for the next slow decode, and so on. That is the "it
takes too long" feeling.

5. **After a code is found** the screen waits for the success animation (380 ms)
   and *then* waits for the camera to stop, before it opens the result screen
   (`scanner_screen.dart`, `_processSingleBarcode`). These two waits run one
   after the other.

## The fix

### A. Quick pass on most frames, heavy pass now and then (main fix)

In `ScanCameraController`, when the controller's profile is `live`:

- 2 frames out of every 3 use a **quick** pass: `DecodeProfile.fast`
  (`tryDownscale` only — no `tryHarder`, no `tryRotate`). This is the normal
  real-time setting for zxing-cpp and reads clean printed codes very fast.
- Every 3rd frame uses the current **heavy** `live` pass, so hard codes
  (small, damaged, turned 1D barcodes) are still found, just a little later.

Other profiles (AirQR uses `fast`; still images use `thorough`) are not changed.
The choice is a small pure static method (`profileForFrame`) so it can be unit
tested.

### B. Overlap the "after success" waits

In `_processSingleBarcode`, start stopping the camera at the same time as the
380 ms success animation, and wait for both together, instead of one after the
other. The visible animation stays the same; the result screen opens sooner.

### C. Debug-only timing log

In debug builds only (`kDebugMode`), log the average decode time once every 30
frames (just a number in ms — no code content, nothing sensitive). This lets us
check the speed-up on a real phone. Release builds log nothing.

### Not changed (options for later, tell me if you want them)

- Lowering the default resolution from Full HD to HD (720p). This would make
  every pass ~2× faster, but changes a user setting default, so I left it out.
- Lowering `maxSymbols` for single-code scanning. Multi-code selection needs
  more than one code per frame, so it stays at 8.

## Files to change

| File | Change |
| ---- | ------ |
| `lib/services/scan_camera/scan_camera_controller.dart` | Frame counter, `profileForFrame`, quick/heavy pass choice, debug-only timing log |
| `lib/models/decode_profile.dart` | Update the doc comments of `fast` and `live` to say how they are used now |
| `lib/screens/scanner_screen.dart` | Run camera stop and success animation wait together |
| `test/services/scan_camera/scan_camera_controller_test.dart` (new) | Unit tests for `profileForFrame` |
| `change_log/<timestamp>_faster_live_scanning.md` (new) | Change log |

No native code, no zxing-cpp files, no new packages, no user-visible text (no ARB changes).

## Checks

- `dart format .`, `flutter analyze` (0 issues), `flutter test`.
- A real-phone test is needed to feel the speed-up. I will **not** install on
  your phone unless you say yes; otherwise you can run
  `flutter run --flavor dev` yourself and watch the debug timing log.
- Stop Gradle daemons after any build.
