# Keep bottom panels above the system navigation bar

**Status:** completed

## Issue

On the AirQR receiver screen, the progress panel at the bottom ("Captured: 0 / 0 Blocks",
"Missing: 0") is partly hidden behind the Android navigation bar (back / home / recents).

Cause: the app targets Android SDK 36, so Android draws the app edge-to-edge (the app runs
under the navigation bar). The screen body is a `Stack` with no `SafeArea`, and the panel is
placed at a fixed `bottom: 24`. That 24 px is measured from the very bottom of the screen, not
from the top of the navigation bar, so the bar covers the panel.

The AR CodeVision screen has the same layout (a `Stack` with no `SafeArea`) and two panels
pinned with fixed bottom values, so they can be covered in the same way:
- the warehouse batch-selection footer (`bottom: 16`),
- the tapped-item action sheet (`bottom: 20`).

## Files to change

- `lib/screens/air_qr_screen.dart`
- `lib/screens/ar_codevision_screen.dart`
- `lib/screens/widgets/ar_action_sheet.dart`

## Fix

Keep the camera preview full-screen (it looks right running under the bar), and only lift the
panels. For each panel, add the bottom system inset to its fixed offset:

```dart
bottom: 24 + MediaQuery.viewPaddingOf(context).bottom,
```

(`16 + …` and `20 + …` for the two AR panels.) `viewPaddingOf(context).bottom` is the height of
the navigation bar (0 on devices with no bar), so the gap above the bar stays the same as the
design intended.

No text, ARB, or logic changes.

## Checks

- `dart format .`, `flutter analyze` (clean), `flutter test`.
- Visual check on a device with 3-button navigation and with gesture navigation (only with the
  user's go-ahead to install on a phone).
