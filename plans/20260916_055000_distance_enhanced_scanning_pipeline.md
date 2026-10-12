# Distance-Enhanced Scanning Pipeline Plan

**Status:** completed

## Problem
In `docs/feature_improvements_and_roadmap.md` item 2.1.2:
Scanning QR codes and barcodes that are physically far away (such as posters across a room, high overhead warehouse signs, ceiling signage, or billboard adverts) is difficult because the barcode occupies only a small fraction of the camera sensor frame. The image modules suffer from lens blur, reduced contrast, and insufficient pixel density, causing barcode engines to fail detection.

The current camera implementation supports resolution presets (Full HD/Max 4K), manual contrast boost, and tap-to-focus, but lacks an automated digital zoom-crop-enhance pipeline that detects distant QR codes, crops the region of interest (ROI), and applies unsharp masking and contrast boost before passing the frame to the barcode engine.

## Proposed Fix
Implement a complete Distance-Enhanced Scanning Pipeline:

1. **Domain Models (`lib/models/distance_enhanced_scan_result.dart`)**:
   - `DistanceEnhancedScanResult`: Immutable model capturing pipeline output (`success`, `originalBarcode`, `enhancedBarcode`, `roiBounds`, `zoomFactor`, `unsharpApplied`, `processingDurationMs`).
   - `DistanceScanConfig`: Immutable configuration for digital zoom, crop padding, contrast boost, and unsharp mask strength.
   - `ImagePixelBuffer`: Fast pure-Dart in-memory pixel buffer supporting ROI extraction, bilinear scaling (digital zoom), contrast stretch, Gaussian-approximated unsharp masking, and BMP byte encoding.

2. **Core Service (`lib/services/distance_enhancement_service.dart`)**:
   - Pure-Dart offline image enhancement pipeline:
     - `cropRoi(ImagePixelBuffer source, Rect roi, {double padding = 0.2})`: Extracts candidate region.
     - `applyDigitalZoom(ImagePixelBuffer source, double zoomFactor)`: Upscales cropped region to increase barcode module resolution.
     - `applyContrastBoost(ImagePixelBuffer source, double contrast)`: Increases dynamic contrast between light and dark modules.
     - `applyUnsharpMask(ImagePixelBuffer source, {double amount = 1.5, int radius = 1})`: Separable convolution unsharp masking that sharpens high-frequency module edges.
     - `encodeToBmp(ImagePixelBuffer buffer)`: Fast serialization to standard BMP format compatible with Android's MLKit engine without third-party dependencies.
     - `processImageFile(String imagePath, ...)`: Automated enhancement workflow for distant codes in photo files.
     - `detectDistantCandidateRoi(Size imageSize, {List<Offset>? corners, Offset? tapFocus})`: Computes optimal ROI for distant code scanning.

3. **State Management (`lib/providers/camera_settings_provider.dart`)**:
   - Add Distance-Enhanced Mode state:
     - `isDistanceEnhanceMode` (bool, default `false`).
     - `distanceZoomFactor` (double, default `2.5x`, selectable `2.0x`, `3.0x`, `4.0x`).
     - `unsharpMaskStrength` (double, default `1.5`, range `0.5`–`2.5`).
     - `autoZoomEnabled` (bool, default `true`).
     - Method `toggleDistanceEnhanceMode()`.
     - Method `setDistanceZoomFactor(double factor)`.
     - Method `setUnsharpMaskStrength(double strength)`.
     - Persist preferences to `SharedPreferences`.

4. **Media Scanning Integration (`lib/services/media_scan_service.dart`)**:
   - Update `scanImageFile` and `pickAndScanImage` with a distance-enhanced fallback pipeline:
     - If standard scanning yields no barcode or if distance enhancement is enabled, run the `DistanceEnhancementService` across candidate central and multi-scale ROIs with digital zoom and unsharp masking.
     - Decodes distant poster or overhead sign photos that previously failed detection.

5. **Camera Viewport & Adjustments Sheet (`lib/screens/scanner_screen.dart`, `lib/widgets/camera_adjustments_sheet.dart`)**:
   - In `scanner_screen.dart`:
     - Enable native Android MLKit auto-zoom (`autoZoom: cameraSettings.isDistanceEnhanceMode && cameraSettings.autoZoomEnabled`) on `MobileScannerController`.
     - Add Distance Scan Assist quick toggle in the Viewport top bar overlay.
     - Render a telephoto / distance assist reticle HUD overlay when Distance Mode is active, guiding users to target distant codes.
     - Tap-to-focus on distant codes triggers digital crop enhancement.
   - In `lib/widgets/camera_adjustments_sheet.dart`:
     - Add a "Distance-Enhanced Pipeline" control section:
       - Distance Scan Assist toggle.
       - Digital Zoom factor selector (2x, 3x, 4x).
       - Unsharp Masking sharpness slider.
       - Accessibility explanation for overhead and distant signage.

6. **Tri-Lingual Localization**:
   - Add all distance enhancement keys with descriptive `@key` entries in `lib/l10n/app_en.arb`.
   - Add natural Malayalam translations in `lib/l10n/app_ml.arb`.
   - Add grammatically correct Sanskrit translations in `lib/l10n/app_sa.arb` (zero Hindi markers).
   - Run `flutter gen-l10n`.

7. **Documentation & Roadmap**:
   - Update `docs/feature_improvements_and_roadmap.md` item 2.1.2 status to `✅ Implemented`.
   - Update `docs/features.md` to document the Distance-Enhanced Scanning Pipeline.

8. **Test Suite**:
   - Unit tests for `ImagePixelBuffer` and `DistanceEnhancementService` (`test/services/distance_enhancement_service_test.dart`).
   - Unit tests for `DistanceEnhancedScanResult` model (`test/models/distance_enhanced_scan_result_test.dart`).
   - Unit tests for `CameraSettingsProvider` updates (`test/providers/camera_settings_provider_test.dart`).
   - ARB parity tests and Sanskrit Hindi marker gate verification (`test/l10n/l10n_parity_test.dart`).

## Files to Change
- `lib/models/distance_enhanced_scan_result.dart` (NEW)
- `lib/services/distance_enhancement_service.dart` (NEW)
- `lib/providers/camera_settings_provider.dart` (MODIFY)
- `lib/services/media_scan_service.dart` (MODIFY)
- `lib/screens/scanner_screen.dart` (MODIFY)
- `lib/widgets/camera_adjustments_sheet.dart` (MODIFY)
- `lib/l10n/app_en.arb` (MODIFY)
- `lib/l10n/app_ml.arb` (MODIFY)
- `lib/l10n/app_sa.arb` (MODIFY)
- `docs/feature_improvements_and_roadmap.md` (MODIFY)
- `docs/features.md` (MODIFY)
- `test/models/distance_enhanced_scan_result_test.dart` (NEW)
- `test/services/distance_enhancement_service_test.dart` (NEW)
- `test/providers/camera_settings_provider_test.dart` (MODIFY)

## Verification Plan
1. `flutter gen-l10n` to regenerate localization code.
2. `flutter test` to execute all existing and new unit tests, image pipeline tests, and ARB parity tests.
3. `flutter analyze` to guarantee 0 warnings and clean static analysis.
