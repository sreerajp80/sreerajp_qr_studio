# Change Log — Camera Enhancements: Resolution, Flash Controls & Image Tuning

**Plan:** `plans/20260914_194000_camera_enhancements.md`

## Summary

Enhanced the camera scanning subsystem with Full HD / Maximum resolution configuration, 3-state flash controls (Off, On, Auto) powered by an Android native ambient light sensor, live brightness and contrast adjustment sliders, negative/inverted QR scanning mode, and interactive tap-to-focus with exposure metering.

## Changes Made

### Platform Layer (`android/app/src/main/kotlin/in/sreerajp/qr_reader/MainActivity.kt`)
- Added an Android `EventChannel` (`in.sreeraj.qr_reader/ambient_light`) connected to `SensorManager` and `Sensor.TYPE_LIGHT`.
- Streams ambient light illuminance (lux) to Flutter with zero external dependencies and 100% offline operation.

### Models (`lib/models/camera_settings.dart`)
- Added `CameraFlashMode` enum (`off`, `on`, `auto`).
- Added `CameraResolutionPreset` enum (`fullHd` 1920x1080 default, `max` 3840x2160, `hd` 1280x720).
- Added immutable `CameraSettings` state model.

### Services
- `lib/services/light_sensor_service.dart`: Listens to the native ambient light `EventChannel` and provides a stream of lux readings.
- `lib/services/color_matrix_service.dart`: Calculates 4x5 RGBA color transformation matrices for Skia `ColorFilter.matrix` combining brightness, contrast, and color inversion.

### Providers (`lib/providers/camera_settings_provider.dart`)
- Created `CameraSettingsProvider` managing flash modes, resolution presets, brightness and contrast tuning, inverted color mode, and tap-to-focus coordinates.
- Implemented intelligent auto-flash with threshold hysteresis (< 12 lux turns flash on, > 28 lux turns flash off) to prevent flickering.
- Persists user preferences for flash mode and resolution preset in `SharedPreferences`.

### Widgets
- `lib/widgets/camera_adjustments_sheet.dart`: Modal bottom sheet with sliders for Brightness (-1.0 to 1.0) and Contrast (0.5 to 2.5), an Inverted Colors toggle for negative barcodes, a Resolution preset selector, and a Reset button.
- `lib/widgets/focus_ring_widget.dart`: Animated reticle showing visual feedback when the user taps to focus and meter light.

### Screens
- `lib/screens/scanner_screen.dart`:
  - Configured `MobileScannerController` with `cameraResolution: cameraSettings.targetResolution` and `invertImage: cameraSettings.invertColors`.
  - Wrapped preview in `ColorFiltered` with real-time Skia color matrix.
  - Added tap-to-focus gesture handler invoking `controller.setFocusPoint(...)`.
  - Added 3-state flash button (Off, On, Auto) and ambient lux indicator badge.
  - Added camera tuning toolbar button opening `CameraAdjustmentsSheet`.
- `lib/screens/ar_codevision_screen.dart`: Configured `MobileScannerController` with Full HD resolution (`Size(1920, 1080)`).
- `lib/screens/air_qr_screen.dart`: Configured `MobileScannerController` with Full HD resolution (`Size(1920, 1080)`).

### App Initialization (`lib/main.dart`)
- Registered `CameraSettingsProvider` in `MultiProvider`.

### Localization (`lib/l10n/app_en.arb`)
- Added 16 localized strings with descriptions covering flash modes, tuning controls, resolution options, and focus hints.

### Tests
- `test/services/color_matrix_service_test.dart`: Unit tests for matrix calculations.
- `test/services/light_sensor_service_test.dart`: Unit tests for light sensor stream setup.
- `test/providers/camera_settings_provider_test.dart`: Unit tests for state transitions, auto-flash hysteresis, clamping, and persistence.

## Verification

- `dart format .` — clean, formatted across all files
- `flutter gen-l10n` — successful
- `flutter analyze` — 0 issues found
- `flutter test` — 182 tests passed
