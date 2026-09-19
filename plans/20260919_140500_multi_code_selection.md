# Plan: Multi-Code Tappable Selection on Main Scanner

**Status:** Completed

**Date:** 2026-09-19

---

## 1. Issue & Context

In the main scanner screen (`ScannerScreen`), when multiple QR codes or barcodes are visible in the camera frame simultaneously (such as shipping labels, packaging with product barcodes and URL QR codes, or multiple QR codes printed close together), the scanner currently picks `capture.barcodes.first` and immediately navigates to the result screen or adds it to the batch.

Because `barcodes.first` is arbitrary, users cannot choose which code to scan without physically covering up adjacent codes or repositioning the camera at awkward angles.

Feature roadmap item 2.1.4 requires:
> "Outline all visible barcodes in the main camera view with subtle bounding boxes and let the user tap which specific code to inspect. Medium — eliminates scan errors when multiple QR codes are printed close together."

---

## 2. Proposed Changes

### Domain Models
- `lib/models/visible_barcode.dart`:
  - Create immutable model `VisibleBarcode`:
    - `id`: unique string identifier based on rawValue and format.
    - `rawValue`: string payload.
    - `format`: `BarcodeFormat`.
    - `type`: `BarcodeType`.
    - `corners`: `List<Offset>` in camera frame coordinates.
    - `boundingBox`: `Rect` in camera frame coordinates.
    - `screenRect`: `Rect` projected into screen logical coordinates.
    - `lastSeen`: `DateTime` timestamp.
    - `isUrl`: boolean flag.
    - `displayLabel`: formatted user-facing short label (e.g. "URL", "Wi-Fi", "EAN-13").
  - `toBarcode()`: converts back to `Barcode` object for downstream handlers.

### Services
- `lib/services/multi_code_service.dart`:
  - Create pure Dart service `MultiCodeService`:
    - `projectFrameToScreenRect({required Rect frameRect, required Size frameSize, required Size screenSize, BoxFit fit = BoxFit.cover})`:
      - Accurately projects frame coordinates to screen logical pixels taking `BoxFit.cover` aspect-ratio scaling and cropping offsets into account.
      - Enforces minimum tap-target size (at least 48x48 logical pixels) for accessibility and easy touch.
    - `projectCornersToScreen({required List<Offset> corners, required Size frameSize, required Size screenSize, BoxFit fit = BoxFit.cover})`:
      - Projects list of frame corners to screen logical offsets.
    - `computeBoundingBox(List<Offset> corners)`:
      - Computes enclosing `Rect` from corners.
    - `decayStaleBarcodes(List<VisibleBarcode> items, {Duration decayDuration = const Duration(milliseconds: 1500)})`:
      - Prunes barcodes not refreshed within decay window.
    - `getDisplayLabel(BarcodeType type, String rawValue)`:
      - Returns format/payload indicator.

### Providers
- `lib/models/camera_settings.dart`:
  - Add `multiCodeSelectionEnabled` (default: `true`) to `CameraSettings` and `copyWith`.
- `lib/providers/camera_settings_provider.dart`:
  - Add `multiCodeSelectionEnabled` preference, getter, and `setMultiCodeSelectionEnabled(bool)` with SharedPreferences persistence (`camera_multi_code_selection`).
- `lib/providers/multi_code_selection_provider.dart`:
  - Create `MultiCodeSelectionProvider` (`ChangeNotifier`):
    - State:
      - `enabled`: boolean (synced with settings).
      - `isMultiCodeActive`: boolean indicating whether multiple codes are currently detected in view.
      - `visibleBarcodes`: list of `VisibleBarcode`s.
      - `selectedBarcodeId`: string id of currently tapped barcode for confirmation animation.
    - Methods:
      - `processCapture({required BarcodeCapture capture, required Size screenSize, required Size frameSize})`:
        - When `capture.barcodes.length > 1`: updates active barcodes, projects screen coordinates, and activates multi-code mode.
        - When `isMultiCodeActive`: continues tracking visible barcodes until user selects one or decay timeout clears them.
      - `selectBarcode(String id)`: records selected id for tap feedback.
      - `dismiss()`: user explicitly cancels multi-code selection mode.
      - `reset()`: resets all state on navigation/pause.

### Widgets
- `lib/screens/widgets/multi_code_bounding_box_widget.dart`:
  - Interactive Material 3 bounding box overlaid on screen viewport:
    - Subtle glowing accent border with rounded corner brackets.
    - Floating pill badge displaying format icon, short label, and tap icon.
    - Full bounding box is wrapped in `GestureDetector` / `InkWell` for instant responsive tapping.
    - Selected state shows brief green reticle confirmation pulse.
- `lib/screens/widgets/multi_code_hint_banner.dart`:
  - Floating top banner:
    - Icon: `Icons.touch_app`
    - Text: `l10n.multiCodeDetectedBanner`
    - Dismiss button to clear multi-code mode.

### UI & Scanner Screen Integration
- `lib/screens/scanner_screen.dart`:
  - Connect `MultiCodeSelectionProvider`.
  - In `_handleBarcode(BarcodeCapture capture)`:
    - If `multiCodeProvider.enabled`:
      - If `capture.barcodes.length > 1` or `multiCodeProvider.isMultiCodeActive`:
        - Delegate to `multiCodeProvider.processCapture(...)`.
        - Stay in camera view without automatically picking `barcodes.first`.
      - Else (single barcode and not in multi-code mode):
        - Immediate snappy auto-scan as before.
    - If `!multiCodeProvider.enabled`:
      - Legacy behavior (immediately auto-scans `barcodes.first`).
  - In `_buildScanner`:
    - When `multiCodeProvider.isMultiCodeActive && multiCodeProvider.visibleBarcodes.isNotEmpty`:
      - Render `MultiCodeBoundingBoxWidget` for each visible barcode.
      - Render `MultiCodeHintBanner` below top suite bar.
    - When user taps a barcode:
      - Haptic feedback & click sound.
      - If batch mode: `_processBatchBarcode(selected.toBarcode())`.
      - If single mode: `_processSingleBarcode(selected.rawValue, selected.type, corners: selected.corners)`.
- `lib/widgets/camera_adjustments_sheet.dart`:
  - Add switch tile for Multi-Code Selection.
- `lib/main.dart`:
  - Register `MultiCodeSelectionProvider` in `MultiProvider`.

### Localization
- `lib/l10n/app_en.arb`:
  - `multiCodeDetectedBanner`: "Multiple codes detected. Tap a code to scan."
  - `multiCodeTapToScan`: "Tap to scan"
  - `multiCodeSelectionTitle`: "Multi-Code Selection"
  - `multiCodeSelectionSubtitle`: "Outline visible codes and tap to choose when multiple are present"
  - `multiCodeDismissTooltip`: "Dismiss selection"
- `lib/l10n/app_ml.arb`:
  - Add Malayalam translations with 100% key parity.
- `lib/l10n/app_sa.arb`:
  - Add authentic Sanskrit translations with 100% key parity (zero Hindi markers).

### Documentation
- `docs/feature_improvements_and_roadmap.md`:
  - Update row 2.1.4 to mark "Multi-Code Tappable Selection on Main Scanner" as completed (✅ Implemented).

### Testing
- `test/models/visible_barcode_test.dart`:
  - Model unit tests.
- `test/services/multi_code_service_test.dart`:
  - Projection, bounding box calculation, decay, and display label unit tests.
- `test/providers/multi_code_selection_provider_test.dart`:
  - State transitions, multi-code activation, decay, and dismissal tests.

---

## 3. Verification

1. `flutter gen-l10n` to generate localization code from ARB files.
2. `flutter test test/models/visible_barcode_test.dart`
3. `flutter test test/services/multi_code_service_test.dart`
4. `flutter test test/providers/multi_code_selection_provider_test.dart`
5. `flutter test test/l10n/l10n_parity_test.dart` to verify key parity and Sanskrit purity.
6. `flutter test` to verify zero regressions across the whole test suite.
7. `flutter analyze` to ensure zero static analysis warnings.
8. `dart format .` to maintain code formatting.
