# Change log: readable "Online checks" card in dark mode

Implements plan: `plans/20261017_134129_privacy_card_dark_mode_contrast.md`

## What changed

`lib/screens/settings_screen.dart` — Privacy & network checks screen, top card:

- Added a local `isDark` (theme brightness) in `build`, used by the card.
- Card background: light mode is unchanged (`blue[50]` / `orange[50]`). Dark mode now uses
  `blue[900]` / `orange[900]` at 35% opacity, so the light theme text reads clearly.
- Lock / warning icon: `[200]` shade in dark mode, `[700]` in light mode (unchanged).
- Explainer text colour: same colours as before; it now reads `isDark` instead of
  repeating the brightness check.

No strings, layout or behaviour changed.

## Checks

- `dart format`: no changes needed.
- `flutter analyze`: no issues.
- `flutter test`: all 777 tests passed.
- Not yet checked by eye on a device in dark mode.
