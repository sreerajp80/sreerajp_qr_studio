# Remove the unused "auto zoom" setting

**Status:** completed

## The issue

`CameraSettingsProvider` has an "auto zoom" setting (`autoZoomEnabled` and
`setAutoZoomEnabled`). The model `DistanceScanConfig` also has an `autoZoom` field.
Neither one does anything:

- No camera code reads them. `ScanCameraController` only zooms when the user
  pinches or moves the zoom slider.
- They were added to drive ML Kit's built-in auto zoom
  (`MobileScannerController(autoZoom: ...)`). ML Kit / `mobile_scanner` has since
  been removed and is now a blocked dependency, so there is nothing for them to
  turn on.
- There is no switch for it in the UI, no ARB text, and the value is not saved to
  `SharedPreferences`. Users cannot see or change it.

So it is dead code that suggests a feature the app does not have.

## Decision: remove, do not implement

Building real auto zoom would be a new feature, not a fix:

- The native zxing-cpp bridge would need to report codes it can *see* but cannot
  *read*, with their position, so the app knows when and where to zoom.
- An automatic zoom would fight the user's own pinch zoom and zoom slider.
- It needs on-device tuning and testing.

That is a lot of work and risk for something no one has asked for. If auto zoom
is wanted later, it should get its own feature plan. Removing the dead setting now
keeps the code honest and costs nothing for users.

## Files to change

1. `lib/providers/camera_settings_provider.dart`
   - Remove the `_autoZoomEnabled` field, the `autoZoomEnabled` getter, and the
     `setAutoZoomEnabled` method.
2. `lib/models/distance_enhanced_scan_result.dart`
   - Remove the `autoZoom` field from `DistanceScanConfig`, its constructor
     parameter, and its `copyWith` parameter.
3. `test/providers/camera_settings_provider_test.dart`
   - Remove the three lines that check / set `autoZoomEnabled`.
4. `test/models/distance_enhanced_scan_result_test.dart`
   - Remove the `autoZoom` lines from the default-values and `copyWith` tests.

No UI, ARB, or saved-preference changes are needed, because the setting never
had any.

## Checks

- `dart format .`
- `flutter analyze` — must be clean.
- `flutter test` — all tests must pass.

## Out of scope (noted for later)

While checking this, I saw a similar but bigger problem. The "distance enhance"
switch and the sharpening slider in the camera sheet are saved, but nothing reads
them:

- The live camera scanner does not use `isDistanceEnhanceMode`,
  `distanceZoomFactor`, or `unsharpMaskStrength`.
- Picked images (`MediaScanService.scanImageFile`) always run the distance
  pipeline with fixed default values, whatever the switch and slider say.

That needs its own plan (wire them up, or remove them) and is not changed here.
