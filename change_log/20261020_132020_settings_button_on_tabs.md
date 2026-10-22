# Settings button on the CodeForge and History tabs

Implements `plans/20261020_131738_settings_button_on_tabs.md`.

## What changed

- `lib/screens/code_forge_screen.dart` — added a Settings icon button
  (`Icons.settings_outlined`) at the end of the top bar. It opens `/settings`.
- `lib/screens/history_screen.dart` — same Settings icon button at the end of
  the top bar.
- Both buttons use the existing `actionMenuSettings` key as the tooltip. It
  already has real Malayalam and Sanskrit text, so no ARB files changed.
- `test/helpers/test_app.dart` — `buildTestApp` takes an optional `routes`
  map, so tests can check named-route navigation. (Small extra change, not
  listed in the plan; test-only.)
- `test/screens/code_forge_screen_test.dart` and
  `test/screens/history_screen_test.dart` — new test on each screen: tap the
  Settings button and check that the `/settings` route opens.

## Checks

- `dart format` — no changes needed.
- `flutter analyze` — no issues.
- `flutter test` — all 810 tests pass.
