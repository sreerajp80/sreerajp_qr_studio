# Add a Share button to the CodeForge top bar

**Status:** completed

## Files to change

- `lib/screens/code_forge_screen.dart`
- `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, `lib/l10n/app_sa.arb`
- `lib/l10n/gen/*` (made again by `flutter gen-l10n`)

## The issue

On the CodeForge screen, the "Share PNG" and "Share SVG" buttons sit at the very
end of a long scrolling page, below the payload form and the whole Design Studio
card (which opens expanded). To share a code, the user must scroll all the way
down every time.

A first idea (pin the buttons in a bar at the bottom) was dropped: the app's own
bottom navigation bar is already there, and two bars would crowd the screen.

## The fix

Add a **Share** icon button to the CodeForge top bar (app bar), next to the
existing Reset, Copy and Settings icons. The top bar is always visible, so
sharing is one tap from anywhere on the page.

1. New `PopupMenuButton` with `Icons.share` in `AppBar.actions`, placed first
   (before Reset), with a localized tooltip.
2. Tapping it opens a small menu with two items, using the existing strings:
   - "Share PNG" (`actionCodeForgeExportPng`) — calls the same PNG export as the
     bottom button.
   - "Share SVG" (`actionCodeForgeExportSvg`) — calls the same SVG export.
3. The button is disabled when the code is not valid or an export is already
   running (same rules as the bottom buttons). While exporting, it shows a
   small spinner instead of the icon.
4. To avoid repeating code, move the PNG export call (with its `paintQr`
   callback) into one small private method, used by both the top menu and the
   bottom button.
5. The two big buttons at the end of the page stay as they are.

## New text

One new key, `tooltipCodeForgeShare` (tooltip of the new icon):

| Language  | Value         |
| --------- | ------------- |
| English   | Share         |
| Malayalam | പങ്കിടുക       |
| Sanskrit  | विभज्यताम्     |

The Malayalam and Sanskrit values are the same words already used for
`actionHistoryShare`. An `@tooltipCodeForgeShare` description goes in
`app_en.arb`. Then run `flutter gen-l10n`.

## Checks

- `dart format`, `flutter gen-l10n`, `flutter analyze`, `flutter test`
  (includes the ARB parity test).

## Security impact

None. Layout and one new label only.
