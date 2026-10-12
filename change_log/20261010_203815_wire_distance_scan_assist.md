# Change log: make "Distance Scan Assist" and its sliders work

Implements plan: `plans/20261010_202815_wire_distance_scan_assist.md`

## What was wrong

The "Distance Scan Assist" switch, the "Edge Sharpness" slider, and the saved
"distance zoom" value in the camera settings were saved but never used. The live
camera ignored them, and picked images always used fixed default values. Distance
zoom had no slider at all, and "Reset" was not saved.

## What changed

### Picked images (gallery, shared images, GhostScan captures)

- `lib/services/media_scan_service.dart` — `scanImageFile` and
  `pickAndScanImage` take a new optional `distanceConfig`. It is passed to the
  distance fallback as its base config. The default is the old default, so
  other callers behave as before.
- `lib/models/distance_enhanced_scan_result.dart` — new
  `DistanceScanConfig.stronger()`: 1.0x more zoom (max 4.0x), 0.5 more
  sharpening (max 2.5), contrast 1.45. From the defaults this is exactly the old
  fixed pass-3 values (3.5x / 2.0).
- `lib/services/distance_enhancement_service.dart` — pass 3 of
  `runMultiScaleDistanceScan` now uses `baseConfig.stronger()` instead of fixed
  numbers. Doc comments updated.
- The image fallback stays always on, as before. Only the slider values are
  applied to images.

### Live camera

- `lib/services/distance_enhancement_service.dart`:
  - New `processLuminanceFrame(...)`. It copies the centre crop of the grey
    camera frame (before any `await`), then enlarges, boosts contrast, and
    sharpens it in a background isolate (`Isolate.run`), and decodes it.
  - The enlarged crop is capped at `liveAssistMaxSide` = 2048 px on its longest
    side. A crop already that big is not enlarged.
  - New static helper `mapCropPointToUprightFrame(...)` maps code corners from
    the enlarged crop back to the upright frame, for 0/90/180/270 rotation.
    It matches how the native bridge rotates frames.
- `lib/services/scan_camera/scan_camera_controller.dart`:
  - New settable `distanceAssist` field (`null` = off). It can change while the
    camera runs.
  - When a frame has no code and the assist is on, one assist try starts in the
    background. Only one runs at a time, with at least 600 ms
    (`distanceAssistInterval`) between tries. Normal frame decoding keeps going.
  - Codes found go out on the normal `barcodes` stream (with front-camera
    mirroring), so the overlay, multi-code, and scan flow work as usual.
- `lib/screens/scanner_screen.dart`:
  - Creates the controller with `distanceAssist` set from the settings.
  - Updates `controller.distanceAssist` whenever camera settings change, so the
    switch and sliders take effect at once.
  - Passes the user's zoom and sharpness to gallery, shared-image, and
    GhostScan scans.

### Settings and UI

- `lib/providers/camera_settings_provider.dart`:
  - New `distanceScanConfig` getter, built from the saved zoom and sharpness.
  - `resetAdjustments()` is now `Future<void>` and also saves the default zoom,
    sharpness, and multi-code values. Its doc comment now says it does not reset
    the switch.
  - Fixed the `setDistanceZoomFactor` doc comment range (1.5 to 4.0).
- `lib/widgets/camera_adjustments_sheet.dart`:
  - New "Distance Zoom" slider (1.5x to 4.0x), shown when the switch is on.
  - The switch no longer restarts the camera.
- `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb` — new key
  `cameraDistanceZoomLabel` ("Distance Zoom" / "ദൂര സൂം" / "दूरविस्तारः"), with
  an `@` description in English. Files in `lib/l10n/gen/` regenerated.

### Tests

- `test/models/distance_enhanced_scan_result_test.dart` — `stronger()` from
  the defaults, from low values, and capped at the limits.
- `test/services/distance_enhancement_service_test.dart` — corner mapping for
  all four rotations; centre crop + enlarge + corner mapping through
  `processLuminanceFrame`; size cap; too-small buffer returns nothing.
- `test/services/media_scan_decoder_test.dart` — the given config reaches the
  distance fallback; defaults are used when none is given.
- `test/providers/camera_settings_provider_test.dart` — `distanceScanConfig`
  follows the settings; reset is saved and leaves the switch alone.

## Differences from the plan

- The plan said the size cap would be "about 1600 px". It is 2048 px. With
  1600 px, the centre crop of a 1080p frame (864 px wide) could only be
  enlarged about 1.85x, well below the default 2.5x. 2048 px allows about 2.4x.
- The plan said the pass-3 helper might go in the model. It did:
  `DistanceScanConfig.stronger()`.

## Checks

- `flutter gen-l10n` — done.
- `dart format lib test` — done.
- `flutter analyze` — no issues.
- `flutter test` — all 491 tests pass.

## Not done yet

- No on-device test. How well this reads far-away codes, and how much CPU and
  battery it uses on slow phones, still needs a real-phone check.
- Out of scope, still open: the unused ARB key `scanDistanceModeTooltip`, and
  brightness / contrast / invert not being saved across restarts.
