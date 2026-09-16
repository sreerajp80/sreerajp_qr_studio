# Distance-Enhanced Scanning Pipeline Change Log

**Plan:** `plans/20260916_055000_distance_enhanced_scanning_pipeline.md`

## Summary of Changes

Implemented Roadmap Item 2.1.2: **Distance-Enhanced Scanning Pipeline**, providing an offline digital zoom-crop-enhance pipeline with unsharp masking for physically distant QR codes and barcodes (such as posters, overhead warehouse signs, and billboard adverts).

1. **Domain Models (`lib/models/distance_enhanced_scan_result.dart`)**:
   - Added `DistanceScanConfig`: Immutable configuration model defining digital zoom multiplier, unsharp sharpening strength, dynamic contrast boost factor, crop padding, and auto-zoom toggle.
   - Added `DistanceEnhancedScanResult`: Encapsulates scan outcomes, decoded payload, format, region of interest bounds, applied zoom factor, unsharp masking status, and execution duration.
   - Added `ImagePixelBuffer`: Fast in-memory pure-Dart RGBA buffer supporting ROI cropping, bilinear digital zoom interpolation, dynamic contrast enhancement, high-pass unsharp masking, and 24-bit BMP encoding.

2. **Image Enhancement Pipeline Service (`lib/services/distance_enhancement_service.dart`)**:
   - Created `DistanceEnhancementService` in pure Dart:
     - `calculateCandidateRoi`: Computes candidate crop areas from barcode corner geometry, tap-to-focus coordinates, or central viewport default.
     - `enhancePixelBuffer`: Crops region of interest, upscales via bilinear digital zoom, stretches contrast, and applies unsharp masking.
     - `writeBufferToTempBmp`: Serializes pixel buffer to temporary BMP file for engine consumption.
     - `processImageFile`: High-level processing pipeline invoking barcode analysis on enhanced crops.
     - `runMultiScaleDistanceScan`: Multi-scale fallback scanning center crop, deep zoom, and quadrant analysis for distant poster/sign photos.

3. **State Management (`lib/providers/camera_settings_provider.dart`)**:
   - Added Distance-Enhanced Mode state:
     - `isDistanceEnhanceMode`, `distanceZoomFactor`, `unsharpMaskStrength`, `autoZoomEnabled`.
     - Toggle and setter methods with `notifyListeners()`.
     - Persisted to `SharedPreferences` (`camera_distance_enhance_mode`, `camera_distance_zoom`, `camera_unsharp_strength`).
     - Reset logic in `resetAdjustments()`.

4. **Media Scanning Integration (`lib/services/media_scan_service.dart`)**:
   - Injected `DistanceEnhancementService` into `MediaScanService`.
   - Updated `scanImageFile` and `pickAndScanImage` with automated fallback to `runMultiScaleDistanceScan`, allowing photos of distant codes to decode accurately.

5. **Camera Adjustments & Viewport (`lib/widgets/camera_adjustments_sheet.dart`, `lib/screens/scanner_screen.dart`)**:
   - Configured `MobileScannerController` with `autoZoom: cameraSettings.isDistanceEnhanceMode && cameraSettings.autoZoomEnabled`.
   - Added Distance Scan Assist quick toggle button in the camera viewport controls bar.
   - Added animated Distance-Enhanced Mode active badge in the viewport.
   - Added "Distance-Enhanced Scanning" section in `CameraAdjustmentsSheet` with toggle, edge sharpness slider, and accessibility hint.

6. **Tri-Lingual Localization (`lib/l10n/`)**:
   - Added localization strings in English (`app_en.arb`), Malayalam (`app_ml.arb`), and Sanskrit (`app_sa.arb`).
   - Verified 100% key parity and strict adherence to zero Hindi markers in Sanskrit.
   - Executed `flutter gen-l10n`.

7. **Documentation**:
   - Updated `docs/feature_improvements_and_roadmap.md` item 2.1.2 status to `✅ Implemented`.
   - Updated `docs/features.md` to document the Distance-Enhanced Scanning Pipeline.

8. **Tests**:
   - Created unit tests in `test/models/distance_enhanced_scan_result_test.dart`.
   - Created unit tests in `test/services/distance_enhancement_service_test.dart`.
   - Added distance enhancement state tests to `test/providers/camera_settings_provider_test.dart`.
   - All 293 unit, widget, and ARB parity tests passing with 0 errors and 0 analyzer warnings.
