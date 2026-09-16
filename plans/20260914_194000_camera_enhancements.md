# Comprehensive Camera Enhancements: Resolution, Flash Controls & Image Tuning

**Status:** Approved

## Problem

Currently, the camera scanning experience has several limitations:
1. **Low Default Resolution:** `MobileScannerController` does not specify `cameraResolution`, causing Android CameraX to fall back to a low 640x480 (VGA) resolution. This produces blurry frames and degrades decoding performance for high-density, tiny, or distant QR codes.
2. **Limited Flash Controls:** Flash can only be toggled between on and off. There is no automatic flash mode that illuminates dark environments when ambient light is low.
3. **No Image Tuning:** There is no way to adjust brightness or contrast for difficult scanning environments (such as reading QR codes from glossy/reflective computer screens, dim displays, or faded thermal paper receipts), nor is there an inverted color mode for scanning white-on-black QR codes.
4. **No Tap-to-Focus / Metering:** Tapping on the camera view does not focus the lens or meter exposure on challenging targets.

## Scope

1. **Resolution Optimization:**
   - Configure `MobileScannerController` with optimal Full HD (`1920x1080`) resolution by default (or user-selectable Maximum / 4K UHD / 720p).
   - CameraX's fallback strategy picks the highest supported resolution on the physical sensor without frame drops.
   - Apply resolution enhancement across all camera viewports (`scanner_screen.dart`, `ar_codevision_screen.dart`, `air_qr_screen.dart`).

2. **3-State Flash Control (Off / On / Auto):**
   - Add native Android ambient light sensor integration (`Sensor.TYPE_LIGHT`) via Flutter `EventChannel` with zero third-party dependencies, zero permissions required, and 100% offline reliability.
   - In **Auto Flash** mode, ambient lux is continuously monitored:
     - When ambient light falls below ~12 lux, flash turns on automatically.
     - When ambient light rises above ~28 lux, flash turns off automatically.
     - Uses hysteresis thresholds and debouncing to prevent flickering.
   - Flash toggle button in the scanner toolbar cycles through Off -> On -> Auto, with real-time status and lux indicator.

3. **Live Brightness & Contrast Tuning:**
   - Wrap the scanner viewport in a Skia `ColorFiltered` widget with real-time 4x5 color matrix transformations.
   - **Brightness:** Slider adjustment from `-1.0` (darker) to `+1.0` (brighter), default `0.0`.
   - **Contrast:** Slider adjustment from `0.5` (softer) to `2.5` (sharp/punchy), default `1.0`.
   - **Inverted Colors Mode:** Toggle for white-on-black barcodes (dark mode displays, industrial tags). Configures both visual inversion and native MLKit analyzer frame inversion (`invertImage: true`).
   - Quick "Reset" button to return all adjustments to standard defaults.

4. **Interactive Tap-to-Focus & Exposure Metering:**
   - Tapping anywhere in the scanner viewfinder invokes `controller.setFocusPoint(point)` to focus and meter exposure at that coordinate.
   - Shows an animated visual focus ring at the tapped position.

5. **State Management & Persistence:**
   - Implement `CameraSettingsProvider` adhering to Tier 1 layer-first architecture.
   - Persist user choices (flash mode preference, resolution preset, auto-zoom) using `SharedPreferences`.

---

## Proposed Changes

### Platform Layer (Android Kotlin)

#### [MODIFY] `android/app/src/main/kotlin/in/sreerajp/qr_reader/MainActivity.kt`
- Implement `configureFlutterEngine(flutterEngine: FlutterEngine)`.
- Register an `EventChannel("in.sreeraj.qr_reader/ambient_light")` connected to Android's `SensorManager` and `Sensor.TYPE_LIGHT`.
- Streams ambient illuminance (lux) to Flutter. Cleans up listener on cancel.

---

### Services Layer

#### [NEW] `lib/services/light_sensor_service.dart`
- Listens to `EventChannel('in.sreeraj.qr_reader/ambient_light')`.
- Exposes `Stream<double> get luxStream` and checks sensor availability.
- Pure Dart service with no UI dependencies.

#### [NEW] `lib/services/color_matrix_service.dart`
- Generates 4x5 color matrices for Skia `ColorFilter.matrix`.
- Computes combined matrices for brightness offset, contrast scaling, and color inversion.

---

### Models Layer

#### [NEW] `lib/models/camera_settings.dart`
- `CameraFlashMode` enum: `off`, `on`, `auto`.
- `CameraResolutionPreset` enum: `fullHd` (1920x1080, default), `max` (3840x2160), `hd` (1280x720).
- Immutable configuration objects with `const` constructors.

---

### Providers Layer

#### [NEW] `lib/providers/camera_settings_provider.dart`
- Manages:
  - `CameraFlashMode flashMode` (`off`, `on`, `auto`).
  - `double brightness` (`-1.0` to `1.0`).
  - `double contrast` (`0.5` to `2.5`).
  - `bool invertColors` (default `false`).
  - `CameraResolutionPreset resolutionPreset`.
  - `double? currentLux` (ambient light readout).
  - `bool isLightSensorAvailable`.
  - `Offset? focusPoint` with timestamp for animation.
- Handles auto-torch trigger logic based on ambient lux stream.
- Persists resolution preset and flash mode preference to `SharedPreferences`.

---

### Widgets Layer

#### [NEW] `lib/widgets/camera_adjustments_sheet.dart`
- Bottom sheet or floating panel allowing users to adjust:
  - Brightness slider with numerical readout.
  - Contrast slider with numerical readout.
  - Inverted Colors toggle (Negative scan mode).
  - Resolution preset dropdown/choice chips (Full HD 1080p, 4K UHD, HD 720p).
  - "Reset All" button.

#### [NEW] `lib/widgets/focus_ring_widget.dart`
- Animated focus box / ring that appears at the tap coordinate when the user taps to focus, pulsing and fading out over 1 second.

---

### Screens Layer

#### [MODIFY] `lib/screens/scanner_screen.dart`
- Update `MobileScannerController` initialization to use `cameraResolution: cameraSettingsProvider.targetResolution`.
- Pass `invertImage: cameraSettingsProvider.invertColors` to controller.
- Wrap `MobileScanner` in `ColorFiltered` with `ColorMatrixService.getMatrix(...)`.
- Add tap-to-focus gesture handler invoking `controller?.setFocusPoint(point)`.
- Replace single torch icon button with 3-state flash mode button (Off, On, Auto) and ambient lux badge.
- Add "Camera Adjustments" toolbar button opening `CameraAdjustmentsSheet`.
- Integrate focus ring animation overlay.

#### [MODIFY] `lib/screens/ar_codevision_screen.dart`
- Update `MobileScannerController` initialization to use Full HD `Size(1920, 1080)` instead of default 640x480.

#### [MODIFY] `lib/screens/air_qr_screen.dart`
- Update `MobileScannerController` initialization to use Full HD `Size(1920, 1080)` instead of default 640x480.

---

### App Setup Layer

#### [MODIFY] `lib/main.dart`
- Register `CameraSettingsProvider` inside `MultiProvider`.

---

### Localization Layer

#### [MODIFY] `lib/l10n/app_en.arb`
- Add localized strings with `@key` descriptions for:
  - Flash modes: `scanFlashOff`, `scanFlashOn`, `scanFlashAuto`, `scanFlashAutoActive`, `scanFlashAutoLux`.
  - Tuning controls: `cameraTuneTooltip`, `cameraTuneTitle`, `cameraBrightness`, `cameraContrast`, `cameraInvertColors`, `cameraInvertColorsHint`, `cameraResolutionTitle`, `cameraResolutionFullHd`, `cameraResolutionMax`, `cameraResolutionHd`, `cameraResetAdjustments`.
  - Focus feedback: `cameraFocusPointSet`.

---

## Verification Plan

### Automated Tests
- Unit test for `ColorMatrixService`: verify matrix calculation for default, bright, contrast, and inverted values.
- Unit test for `CameraSettingsProvider`: verify flash mode cycling, auto-flash thresholds with hysteresis, brightness/contrast clamp limits, and persistence.
- Run `flutter analyze` to ensure 0 errors and 0 warnings.
- Run `flutter test` to ensure all existing and new unit tests pass.

### Manual Verification
- Verify camera starts in crisp Full HD resolution without blurriness.
- Test cycling through flash modes: Off, On, and Auto.
- In Auto Flash mode, cover ambient light sensor to verify flash turns on automatically; expose to light to verify flash turns off.
- Open Camera Adjustments panel, tweak brightness and contrast sliders, and observe real-time visual changes in camera preview.
- Test Inverted Colors mode on a white-on-black QR code.
- Tap different areas of the viewfinder to verify tap-to-focus ring animation and CameraX exposure metering.
- Restart app to verify user camera preferences remain saved.
