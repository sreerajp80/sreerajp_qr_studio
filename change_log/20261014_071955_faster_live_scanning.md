# Faster live QR / barcode scanning

Implements plan: `plans/20261014_071326_faster_live_scanning.md`

## What changed

- `lib/services/scan_camera/scan_camera_controller.dart`
  - New static `profileForFrame(frameIndex, base)` and `heavyFrameInterval = 3`.
    With the `live` profile, 2 of every 3 camera frames are now decoded with the
    quick `fast` pass (no `tryHarder`, no `tryRotate`), and every 3rd frame with
    the full `live` pass. Other profiles (AirQR `fast`, AR CodeVision) behave as before.
  - Debug builds only: logs the average decode time (ms) every 30 frames
    ("Live decode: … ms average over 30 frames"). No code content is logged.
    Release builds log nothing.
- `lib/models/decode_profile.dart` — doc comments now describe how `fast` and
  `live` are used for live scanning.
- `lib/screens/scanner_screen.dart` — `_processSingleBarcode` now stops the camera
  at the same time as the 380 ms success animation (`Future.wait`), instead of
  after it, so the result screen opens sooner. The animation looks the same.
- `test/services/scan_camera/scan_camera_controller_test.dart` (new) — tests for
  `profileForFrame`.

No native code, zxing-cpp, packages or ARB text were changed.

## Checks

- `dart format` — no changes needed.
- `flutter analyze` — no issues.
- `flutter test` — all 690 tests passed.
- Not yet tested on a real phone. The speed-up should be checked on a device by
  running the dev flavor and watching the "Live decode" debug log.

## Left for later (not in this change)

- Lowering the default camera resolution from Full HD to 720p.
- Lowering `maxSymbols` for single-code scans (multi-code selection needs 8).
