# Change Log: Multi-Code Tappable Selection on Main Scanner

**Date:** 2026-09-19

**Related Plan:** [plans/20260919_140500_multi_code_selection.md](plans/20260919_140500_multi_code_selection.md)

---

## 1. Summary

Implemented **Multi-Code Tappable Selection on Main Scanner** (Roadmap Item 2.1.4). When multiple QR codes or barcodes are visible in the camera viewport simultaneously, the scanner outlines all detected codes with subtle, glowing Material 3 bounding boxes and corner brackets, displays a top instruction banner, and allows the user to tap the exact code they want to inspect.

When only one barcode is in frame, standard snappy auto-scanning continues as normal. In Continuous Batch Scan Mode, users can tap multiple codes one-by-one from the camera viewport without leaving the screen.

---

## 2. Changes Made

### Models
- `lib/models/visible_barcode.dart`:
  - Created immutable model `VisibleBarcode` tracking ID, raw value, format, type, frame corners, bounding box, screen-projected rectangle, last seen timestamp, URL flag, and formatted display label.
- `lib/models/camera_settings.dart`:
  - Added `multiCodeSelectionEnabled` (default `true`) to `CameraSettings` and `copyWith`.

### Services
- `lib/services/multi_code_service.dart`:
  - Created pure Dart service `MultiCodeService` for `BoxFit.cover` coordinate transformations, corner projection, bounding box calculation, minimum 48x48 dp touch target padding, stale target decay, and display label formatting.

### Providers
- `lib/providers/camera_settings_provider.dart`:
  - Added `multiCodeSelectionEnabled` preference with `SharedPreferences` persistence under `camera_multi_code_selection`.
- `lib/providers/multi_code_selection_provider.dart`:
  - Created `MultiCodeSelectionProvider` managing active visible barcodes, multi-code state transitions, target selection feedback, dismissal, and camera pause/resume resets.
- `lib/main.dart`:
  - Registered `MultiCodeSelectionProvider` in `MultiProvider`.

### Widgets
- `lib/screens/widgets/multi_code_bounding_box_widget.dart`:
  - Created interactive bounding box widget with glowing border, corner brackets, floating format badge pill, and touch feedback.
- `lib/screens/widgets/multi_code_hint_banner.dart`:
  - Created floating instruction banner at top of viewfinder prompting user to tap a code, with a dismiss button.
- `lib/widgets/camera_adjustments_sheet.dart`:
  - Added a switch tile for toggling Multi-Code Selection.

### Screens
- `lib/screens/scanner_screen.dart`:
  - Integrated `MultiCodeSelectionProvider`.
  - In `_handleBarcode`: checks if multiple barcodes are visible when feature is enabled, delegates to provider, and pauses auto-scan.
  - In `_buildScanner`: renders bounding box overlays and top hint banner when multi-code is active.
  - Handles tapped code: triggers single scan navigation or batch addition.

### Localization
- `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, `lib/l10n/app_sa.arb`:
  - Added `multiCodeDetectedBanner`, `multiCodeTapToScan`, `multiCodeSelectionTitle`, `multiCodeSelectionSubtitle`, and `multiCodeDismissTooltip` across all three languages with 100% key parity and pure Sanskrit (zero Hindi markers).

### Documentation
- `docs/feature_improvements_and_roadmap.md`:
  - Marked item 2.1.4 as completed (✅ Implemented).

### Tests
- `test/models/visible_barcode_test.dart`:
  - Added model unit tests.
- `test/services/multi_code_service_test.dart`:
  - Added projection, bounding box, decay, and display label tests.
- `test/providers/multi_code_selection_provider_test.dart`:
  - Added provider state transition, activation, and dismissal tests.

---

## 3. Verification

- Ran `flutter gen-l10n`: successfully generated localization classes.
- Ran `flutter test test/models/visible_barcode_test.dart test/services/multi_code_service_test.dart test/providers/multi_code_selection_provider_test.dart`: all 15 tests passed.
- Ran `flutter test test/l10n/l10n_parity_test.dart`: key parity and Sanskrit Hindi marker gate tests passed.
- Ran `flutter test`: all 337 tests in the project passed with zero regressions.
- Ran `flutter analyze`: clean analysis with 0 warnings and 0 errors.
- Ran `dart format .`: all modified files formatted.
