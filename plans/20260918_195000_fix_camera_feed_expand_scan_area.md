# Fix Camera Feed, Remove Buggy Distance Mode, and Expand Scan Area Plan

**Status:** completed

## Problem
1. **Broken Distance Mode & Frozen Grey Camera**:
   - In the live scanner top bar, the third button activated "Distance Mode" ("ദൂര മോഡ് സജീവം").
   - When tapped, it tried to recreate the camera controller via `_restartScanner()`.
   - In Flutter, `MobileScanner` caches its controller in widget state without updating when the controller instance changes. Because the widget had no dynamic key, it remained bound to a disposed controller.
   - This killed the camera feed, turned the screen completely grey, and made it impossible to scan anything. Tapping the button again tried to restart a dead camera, trapping the user until they force-killed the app.
   - In live scanning, this mode provides no benefit because the app already has a real zoom button and slider (1.0x to 8.0x) and pinch-to-zoom using the device's native camera lenses. Distance image enhancement is only meant for still gallery photo processing.
2. **Scan Area is Too Small**:
   - The scan viewfinder frame (`ScanOverlayWidget`) is currently hard-coded to 250px by 250px.
   - This small square makes it difficult to aim and fit wide barcodes (like 1D UPC and Code 128) and large QR codes.
3. **Camera Device Integration**:
   - When the camera preview crashed into a grey box, it looked like the device camera was not being used.
   - The camera controller lifecycle needs to be reliable, attaching directly to the device camera with a dedicated key and fast scanning mode.

## Proposed Fix
1. **Remove Confusing Distance Mode Toggle from Scanner Bar (`lib/screens/scanner_screen.dart`)**:
   - Remove the `Icons.center_focus_strong` Distance Scan Assist button from the live scanner top bar.
   - Remove the "Distance Mode Active" (`scanDistanceModeActive`) badge from the scanner screen.
   - Keep the clean, essential live camera controls: Flash mode (Off / On / Auto), Camera adjustments / tuning, Zoom toggle & slider (1.0x - 8.0x), and Camera flip (back / front).
2. **Fix Camera Lifecycle & Feed (`lib/screens/scanner_screen.dart`)**:
   - Add `key: ValueKey(controller)` to `MobileScanner` so Flutter completely re-binds the view if the controller is ever restarted.
   - Clean up `_restartScanner()` to prevent double-start race conditions.
3. **Expand the Scan Frame Area (`lib/screens/scanner_screen.dart`, `lib/screens/widgets/scan_overlay_widget.dart`)**:
   - Increase default `scanAreaSize` in `ScanOverlayWidget` from 250.0 to 290.0.
   - In `scanner_screen.dart`, calculate a responsive scan area size based on screen width (~74% to 76% of width, ~290px to 320px) so users have plenty of space to position both 1D barcodes and QR codes.
4. **Verification**:
   - Run `flutter analyze` to ensure 0 warnings.
   - Run `flutter test` to ensure all tests pass.

## Files to Change
- `lib/screens/scanner_screen.dart` (MODIFY)
- `lib/screens/widgets/scan_overlay_widget.dart` (MODIFY)
- `test/widgets/scan_overlay_widget_test.dart` (NEW or MODIFY)
