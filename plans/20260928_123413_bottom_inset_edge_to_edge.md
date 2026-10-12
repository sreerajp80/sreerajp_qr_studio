# Keep bottom content above the Android navigation bar

**Status:** completed

## The issue

The app targets Android 15 (targetSdk 35). On Android 15, every app is drawn
"edge-to-edge": the app draws behind the system navigation bar (the back / home / recents
bar, or the gesture handle) at the bottom of the screen.

Many scrolling screens use a fixed bottom padding (16–40 px) and don't add the height of
the navigation bar. So the last item on the screen sits under the bar. It looks
washed out and is hard or impossible to tap.

Seen on a device: on the scan result screen, the **"Scan Another Code"** button is half
hidden under the 3-button navigation bar, even when scrolled all the way down.

This follows the earlier fix `plans/20260928_122214_fix_button_contrast_dark_theme.md`.
That fix corrected the button's colors, but the button is still covered.

## The fix

Wrap the scrolling `body` of each affected `Scaffold` in `SafeArea(top: false, ...)`.

- `SafeArea` adds padding equal to the system bars' size. With `top: false`, only the
  bottom (and the sides, for landscape or display cut-outs) are protected. The `AppBar`
  already handles the top.
- If a screen is shown inside the main shell, which has its own bottom navigation bar,
  the bottom inset is already used up by that bar. `SafeArea` then adds nothing, so these
  screens don't change.
- The existing fixed padding stays as it is. It becomes the gap above the navigation bar.
- No logic, string or package changes.

Screens that already handle this (`onboarding_screen.dart`, the sheets that use
`useSafeArea` or `viewPadding`) and full-screen camera screens (`scanner_screen.dart`,
`air_qr_screen.dart`, `ar_codevision_screen.dart`, which draw the camera behind the bars
on purpose) are not changed.

## Files to change

- `lib/screens/result_screen.dart` (main issue)
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
- `lib/screens/settings_screen.dart` (the main settings list and its 7 sub-pages in the same
  file)
- `lib/screens/help/help_home_screen.dart`
- `lib/screens/help/air_qr_help_screen.dart`
- `lib/screens/help/ar_codevision_help_screen.dart`
- `lib/screens/help/barcode_scanning_help_screen.dart`
- `lib/screens/help/faq_troubleshooting_help_screen.dart`
- `lib/screens/help/history_privacy_help_screen.dart`
- `lib/screens/help/quishing_guard_help_screen.dart`
- `lib/screens/help/safe_browsing_help_screen.dart`
- `lib/screens/help/smart_payloads_help_screen.dart`
- `lib/screens/help/url_safety_help_screen.dart`
- `change_log/<timestamp>_bottom_inset_edge_to_edge.md` (new)

## Checks

- `dart format` on changed files.
- `flutter analyze` must be clean.
- `flutter test` must pass.
- Device check: scan a URL QR code, scroll to the bottom of the result screen, and check
  that "Scan Another Code" is fully above the navigation bar. Try both 3-button and
  gesture navigation if possible.
