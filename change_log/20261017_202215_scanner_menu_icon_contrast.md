# Change log: clear menu icons in light mode

Implements plan: `plans/20261017_201204_scanner_menu_icon_contrast.md` (Part 1 and Part 2).

## What was wrong

In light mode, popup menu icons were drawn in the pale Material 3 default colour,
while their labels were near-black. The icons looked faded, almost disabled.

## What changed

### `lib/screens/scanner_screen.dart` (Part 1)

- Added a private helper `_buildMenuItem(context, value:, icon:, label:)`. It builds
  the menu row and gives the icon `colorScheme.onSurface`, the same colour as the label.
- The seven "more options" entries (GhostScan, Scan bubble, CodeForge, AR CodeVision
  HUD, AirQR receiver, History, Settings) now use this helper. Values, icons, labels
  and order are unchanged.

### `lib/screens/widgets/history_card.dart` (Part 2)

- Edit, Copy and Share icons now use `colorScheme.onSurface`.
- Delete icon and text now use `colorScheme.error` instead of a fixed `Colors.red`,
  so they follow the light, dark and OLED themes.

### Checked, no change

- The dropdowns in `lib/screens/code_forge_screen.dart` and
  `lib/screens/result_screen.dart` show text only.

## Checks

- `dart format` — no changes needed.
- `flutter analyze` — no issues.
- `flutter test` — all 779 tests pass.
- Not yet checked on a device.

No ARB, theme or dependency changes. No new translations.
