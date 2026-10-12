# Fix unreadable buttons and text in dark theme

Implements plan: `plans/20260928_122214_fix_button_contrast_dark_theme.md`

## What was wrong

In dark theme, some buttons and labels used hand-picked colors that did not match the
theme. The worst case was "Open in Browser" on the result screen: pink text on a pink
background, so the button looked empty.

## What changed

Only colors changed. No strings, packages or logic changed.

- `lib/screens/result_screen.dart`
  - **Open in Browser**: safe URL uses `colorScheme.primary` background with
    `colorScheme.onPrimary` text. Unsafe URL uses `Colors.orange[800]` with white text.
  - **Scan Another Code**: `colorScheme.primary` background with `colorScheme.onPrimary`
    text (was white on pale pink).
  - **Decrypt payload**: text, icon and border use `deepPurple[200]` in dark theme and
    `deepPurple` in light theme.
- `lib/screens/settings_screen.dart`
  - **Delete API key** dialog button: added white text on the red background.
  - **Privacy explainer** text: light shades (`orange[200]` / `blue[200]`) in dark theme,
    unchanged dark shades in light theme.
- `lib/screens/air_qr_transmitter_screen.dart`
  - **Start stream** button: text uses `colorScheme.onPrimary` when the background is
    `primary`. The red "Stop" state keeps white text.
- `lib/screens/widgets/totp_action_card.dart`
  - Issuer title: `deepPurple[200]` in dark theme, `deepPurple[800]` in light theme.
- `lib/screens/widgets/contact_action_card.dart`
  - Card title: `green[300]` in dark theme, `green[800]` in light theme.

## Checks

- `dart format` on changed files.
- `flutter analyze`: no issues.
- `flutter test`: all 433 tests passed.
- Not yet checked on a device.
