# Fix unreadable "Online checks" card in dark mode

**Status:** completed

## Files to change

- `lib/screens/settings_screen.dart` (Privacy & network checks screen, the top card)
- `change_log/<timestamp>_privacy_card_dark_mode_contrast.md` (new, after the fix)

## The issue

On the "Privacy & network checks" screen, the top card (the "Online checks" switch and
its explainer) is very hard to read in dark mode.

- The card background is always a light colour: `Colors.blue[50]` (switch off) or
  `Colors.orange[50]` (switch on). It does not change in dark mode.
- The switch title and subtitle use the theme text colour. In dark mode this is a light
  colour, so it is light text on a light background.
- The explainer text already picks `Colors.blue[200]` / `Colors.orange[200]` in dark mode,
  which is also light on light.
- The lock / warning icon uses the `[700]` shade in both modes.

So in dark mode almost nothing on the card has enough contrast.

## The fix

Make the card background follow the theme brightness, so all the existing text colours
work again:

1. Card `color`:
   - light mode: keep `Colors.blue[50]` / `Colors.orange[50]` (no change).
   - dark mode: use a dark tint — `Colors.blue[900]` / `Colors.orange[900]` with
     reduced opacity (about 35%) over the dark surface.
2. Title and subtitle: no change (theme text colour is light, and reads well on the dark tint).
3. Explainer text: no change (already `[200]` in dark mode, `[900]` in light mode).
4. Icon: use `[200]` in dark mode and keep `[700]` in light mode, to match the text.
5. Read `Theme.of(context).brightness` once into a local `isDark` and reuse it, instead of
   repeating the check.

No new strings, so no ARB changes. No layout change.

## Checks

- `dart format .`, `flutter analyze` (clean), `flutter test` (all pass).
- Look at the screen in light and dark mode, switch off and on, in Malayalam.
