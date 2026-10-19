# Scanner "more options" menu: pale icons in light mode

**Status:** completed

> Part 1 (scanner menu) is done. Part 2 (history card menu) was added after the user
> asked to check every menu item in light mode. Part 2 was approved and is done.

## The issue

On the scanner screen, the three-dot ("more options") menu in light mode shows its
icons in a pale grey, while the labels next to them are near-black. The icons look
faded, almost like disabled items, and are hard to see on the light menu background.

The menu items in `lib/screens/scanner_screen.dart` use plain `Icon(...)` widgets with
no colour. In Material 3 the popup menu gives icons a muted colour by default, so they
come out much lighter than the text.

## Files to change

- `lib/screens/scanner_screen.dart` — the `PopupMenuButton` items (about lines 1007–1085).

No ARB, theme or dependency changes.

## The fix

1. Add a small private helper in the scanner screen state, for example
   `PopupMenuItem<String> _buildMenuItem(BuildContext context, {required String value, required IconData icon, required String label})`.
   It builds the same `Row(Icon, SizedBox(width: 12), Text)` as today, but gives the
   icon the colour `Theme.of(context).colorScheme.onSurface` — the same colour as the
   label text. This works in light, dark and OLED themes, and with dynamic colour.
2. Replace the seven repeated `PopupMenuItem` blocks with calls to this helper. The
   values, icons, labels and order stay exactly the same.
3. Run `dart format .`, `flutter analyze` and `flutter test`.

## Part 2 — history card menu (added)

A check of every menu in `lib/` found:

- `lib/screens/widgets/history_card.dart` — the three-dot menu on each history card.
  Edit, Copy and Share have the same pale grey icons. Delete uses a fixed
  `Colors.red` for its icon and text instead of the theme colour.
- The two dropdowns (`code_forge_screen.dart`, `result_screen.dart`) show text only,
  so they have no icon problem. No change.

Fix:

1. Give the Edit, Copy and Share icons `Theme.of(context).colorScheme.onSurface`.
2. Give the Delete icon and text `Theme.of(context).colorScheme.error` instead of
   `Colors.red`. It stays red, but follows the theme in light, dark and OLED.
3. Run `dart format .`, `flutter analyze` and `flutter test`.

## Not in scope

- The app bar title being cut short ("SreerajP …") — a separate issue.

## Check

- Open the menu in light, dark and OLED themes: icons should be as clear as the text.
- Every menu item still opens the same screen.
