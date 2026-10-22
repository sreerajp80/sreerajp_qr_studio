# Settings button on the CodeForge and History tabs

**Status:** completed

## What the issue is

The app has three bottom tabs: Scanner, CodeForge and History. Only the
Scanner tab has a way to open Settings (the ⋮ menu → Settings). The top bars
of CodeForge (`lib/screens/code_forge_screen.dart`) and History
(`lib/screens/history_screen.dart`) have no Settings entry. So from these two
tabs the user must first switch back to Scanner to reach Settings.

## Files to change

- `lib/screens/code_forge_screen.dart` — add a Settings icon button to the top bar.
- `lib/screens/history_screen.dart` — add a Settings icon button to the top bar.
- `test/screens/code_forge_screen_test.dart` — test that the button is there
  and opens the `/settings` route.
- `test/screens/history_screen_test.dart` — same test for History.

## Plan for the fix

1. In both screens, add one more `IconButton` at the end of `AppBar.actions`:
   - icon: `Icons.settings_outlined`
   - tooltip: `l10n.actionMenuSettings` (this key already exists with real
     text in English, Malayalam and Sanskrit — no new ARB keys needed)
   - on press: `Navigator.of(context).pushNamed('/settings')` (the same route
     the Scanner menu uses).
2. Show the button always (embedded tab and when opened as its own page from
   the Scanner menu). This keeps the behaviour simple and the same everywhere.
3. Add widget tests: find the button by its tooltip, tap it, check that the
   `/settings` route was pushed.
4. Run `dart format .`, `flutter analyze` and `flutter test`.
5. Write the change log.

No layer change: this is screen-only (navigation from a widget is allowed).
