# Keep bottom panels above the system navigation bar

Plan: `plans/20261026_094500_bottom_panels_above_nav_bar.md`

## What changed

The app is drawn under the Android navigation bar (edge-to-edge, targetSdk 36). Panels pinned
to a fixed distance from the screen bottom were partly hidden by the bar. Each one now adds the
navigation bar height (`MediaQuery.viewPaddingOf(context).bottom`) to its fixed gap. The camera
preview still fills the whole screen.

- `lib/screens/air_qr_screen.dart` — AirQR receiver progress panel: `bottom: 24` →
  `24 + bottom inset`.
- `lib/screens/ar_codevision_screen.dart` — warehouse batch-selection footer: `bottom: 16` →
  `16 + bottom inset`.
- `lib/screens/widgets/ar_action_sheet.dart` — tapped-item action sheet: `bottom: 20` →
  `20 + bottom inset`.

No text, ARB or logic changes.

## Checks

- `dart format` — no changes needed.
- `flutter analyze` — no issues.
- `flutter test` — all 888 tests passed.
- Not yet checked on a device.
