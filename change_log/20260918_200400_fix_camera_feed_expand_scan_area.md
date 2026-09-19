# Fix Camera Feed, Remove Distance Mode Button, and Expand Scan Area

**Plan reference:** `plans/20260918_195000_fix_camera_feed_expand_scan_area.md`

## Summary of Changes
1. **Camera Feed & Lifecycle Fix**:
   - Added `key: ValueKey(controller)` to `MobileScanner` in `lib/screens/scanner_screen.dart`. This ensures Flutter completely re-attaches the camera stream to the active controller whenever the scanner initializes or restarts.
   - Cleaned up `_restartScanner()` to prevent duplicate start calls and deadlocks that previously caused the preview screen to freeze into a solid grey box.
2. **Removed Confusing Distance Mode from Scanner Bar**:
   - Removed the `Icons.center_focus_strong` Distance Scan Assist toggle button from the top control suite bar in `lib/screens/scanner_screen.dart`.
   - Removed the "Distance Mode Active" badge overlay from the live scanner view.
   - Preserved real camera zoom functionality via pinch-to-zoom and the zoom slider (1.0x to 8.0x) that uses the physical camera hardware directly.
3. **Expanded QR & Barcode Placement Area**:
   - Updated `lib/screens/widgets/scan_overlay_widget.dart` to increase the default `scanAreaSize` from 250.0 to 290.0.
   - In `lib/screens/scanner_screen.dart`, calculated a responsive scan target area based on screen width (~74% of screen width, clamped between 280.0 and 330.0), providing ample space for placing wide 1D barcodes and QR codes.
4. **Test Suite**:
   - Added widget tests in `test/widgets/scan_overlay_widget_test.dart` to verify default and custom `scanAreaSize` and confirm all 4 scan overlay styles render without errors.
   - Ran `flutter analyze` (0 issues) and `flutter test` (all 296 tests passed).
