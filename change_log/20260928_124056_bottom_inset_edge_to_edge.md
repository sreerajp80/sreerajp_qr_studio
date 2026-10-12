# Keep bottom content above the Android navigation bar

Implements plan: `plans/20260928_123413_bottom_inset_edge_to_edge.md`

## What was wrong

On Android 15 (targetSdk 35), apps draw behind the system navigation bar. Scrolling
screens used a fixed bottom padding only, so their last item sat under the bar. On the scan
result screen, the "Scan Another Code" button was half hidden and hard to tap.

## What changed

The scrolling `body` of each affected `Scaffold` is now wrapped in
`SafeArea(top: false, child: ...)`. This adds bottom space equal to the navigation bar's
height. The existing fixed padding stays and becomes the gap above the bar. On screens
shown inside the main shell, whose own bottom bar already takes up this space, nothing
changes.

The wrap was applied to 29 `Scaffold` bodies in these files:

- `lib/screens/result_screen.dart`
- `lib/screens/air_qr_transmitter_screen.dart`
- `lib/screens/code_forge_screen.dart`
- `lib/screens/features_screen.dart`
- `lib/screens/history_screen.dart`
- `lib/screens/about_screen.dart`
- `lib/screens/appearance_screen.dart`
- `lib/screens/appearance/accent_color_settings_screen.dart`
- `lib/screens/appearance/scan_overlay_settings_screen.dart`
- `lib/screens/appearance/theme_mode_settings_screen.dart`
- `lib/screens/appearance/typography_settings_screen.dart`
- `lib/screens/settings_screen.dart` (8 screens in this file)
- `lib/screens/help/*_help_screen.dart` (all 10 help screens)

Most of the diff is re-indentation from `dart format`. No logic, string or package
changes.

Not changed: the camera screens (scanner, Air QR receiver, AR CodeVision), which draw
behind the bars on purpose, and the screens and sheets that already handled the bottom
inset.

## Checks

- `dart format`: 22 files re-formatted.
- `flutter analyze`: no issues.
- `flutter test`: all 433 tests passed.
- Not yet checked on a device.
