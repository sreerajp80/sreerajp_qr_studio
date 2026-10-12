# Change log: Remove the unused "auto zoom" setting

Implements plan: [plans/20261010_200211_remove_dead_auto_zoom_setting.md](../plans/20261010_200211_remove_dead_auto_zoom_setting.md)

## Why

The "auto zoom" setting did nothing. It was added to switch on ML Kit's built-in
auto zoom, but ML Kit has since been removed from the app. No camera code read
the setting, it had no switch in the UI, and it was never saved. We chose to
remove it rather than build a new auto zoom feature (see the plan for reasons).

## What changed

- `lib/providers/camera_settings_provider.dart`
  - Removed the `_autoZoomEnabled` field, the `autoZoomEnabled` getter, and the
    `setAutoZoomEnabled` method.
- `lib/models/distance_enhanced_scan_result.dart`
  - Removed the `autoZoom` field from `DistanceScanConfig`, along with its
    constructor and `copyWith` parameters.
- `test/providers/camera_settings_provider_test.dart`
  - Removed the checks that read and set `autoZoomEnabled`.
- `test/models/distance_enhanced_scan_result_test.dart`
  - Removed the `autoZoom` checks from the default-values and `copyWith` tests.

No UI, ARB, or saved-preference changes were needed.

## Checks

- `dart format` on the changed files: no changes needed.
- `flutter analyze`: no issues found.
- `flutter test`: all 483 tests passed.

## Still open

The "distance enhance" switch and the sharpening slider in the camera sheet are
saved but not read by the live camera or the picked-image path. This needs its
own plan.
