# Fix stale ML Kit reference in the roadmap doc

**Status:** completed

## Files to change

- `docs/feature_improvements_and_roadmap.md` (line 53 only)

## What the issue is

Row 2.1.2 ("Distance-Enhanced Scanning Pipeline") in the roadmap table says the feature
"leverages MLKit autoZoom". It also lists "camera autoZoom" as part of what is implemented.

This is out of date:

- Google ML Kit was removed from the app. Barcodes are now decoded by the app's own engine
  (vendored zxing-cpp called through dart:ffi). See `docs/dependencies.md` and the change log
  `change_log/20260928_120846_replace_mlkit_with_own_zxing_decoder.md`.
- Camera zoom is now set by the app itself through the `camera` plugin
  (`ScanCameraController.setZoomScale` in `lib/services/scan_camera/scan_camera_controller.dart`).
- The "auto zoom" setting still exists (`CameraSettingsProvider.autoZoomEnabled`), but nothing
  in the camera code reads it now. So the camera does not zoom by itself.

## Plan for the fix

Edit only row 2.1.2 in `docs/feature_improvements_and_roadmap.md`:

1. In the status column, change "camera autoZoom & Viewport controls" to
   "camera zoom & Viewport controls".
2. In the description column, change "leverages MLKit autoZoom" to
   "uses the app's own camera zoom control (`camera` plugin)".

No other text, rows, or files change. No code changes.

## Out of scope (noted only)

- The unused "auto zoom" setting in `CameraSettingsProvider`. Making it work again, or
  removing it, is a code change and needs its own plan.

## Checks

- Search the `docs/` folder again for `MLKit`, `ML Kit` and `mlkit`. Only the notes that say
  ML Kit was removed or is blocked should remain (plus the unrelated translation-model note in
  the same roadmap file).
- No code changes, so `flutter analyze` and `flutter test` are not affected.
