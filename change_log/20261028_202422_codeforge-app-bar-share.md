# Share button in the CodeForge top bar

Implements plan: `plans/20261028_202113_codeforge-pinned-share-bar.md`

## What changed

- `lib/screens/code_forge_screen.dart`
  - New share icon (`Icons.share`) in the app bar, placed before Reset, Copy and
    Settings. It opens a small menu with "Share PNG" and "Share SVG".
  - The icon is disabled when the code is not valid or an export is running.
    While exporting, it shows a small spinner.
  - The PNG export call moved into one private method, `_sharePng`, used by the
    new menu and the existing bottom button.
  - The two big share buttons at the end of the page are unchanged.
- `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb`
  - New key `tooltipCodeForgeShare`: "Share" / "പങ്കിടുക" / "विभज्यताम्"
    (the Malayalam and Sanskrit words already used for `actionHistoryShare`).
- `lib/l10n/gen/*` — made again with `flutter gen-l10n`.

## Checks

- `dart format`: done.
- `flutter analyze`: no issues.
- `flutter test`: all 903 tests passed.
- Not yet checked on a device.

## Security impact

None. Layout and one new label only.
