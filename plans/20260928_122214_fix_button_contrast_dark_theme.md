# Fix unreadable buttons and text in dark theme

**Status:** completed

## The issue

On the scan result screen in dark theme, two main buttons are hard or impossible to read:

1. **"Open in Browser"** — the text is invisible. The button background is
   `Theme.of(context).primaryColor` (pale pink in dark theme), but no text color is set.
   The theme's default text color for `ElevatedButton` is also `primary`, so the text is
   pink on pink. Users cannot find the button that opens the URL.
2. **"Scan Another Code"** — the background is pale pink and the text is forced to white.
   White on pale pink is very low contrast.

The cause is the same in both: colors are set by hand and don't use the matching
"on" color from the theme's `ColorScheme`.

A search of the other screens found some more places with the same kind of problem.

## Findings

### A. Buttons that cannot be read (must fix)

| File | Line | Control | Problem |
| --- | --- | --- | --- |
| `lib/screens/result_screen.dart` | ~1011 | Open in Browser | Pink text on pink background (invisible). Orange "unsafe" variant also has pink text. |
| `lib/screens/result_screen.dart` | ~1096 | Scan Another Code | White text on pale pink background. |
| `lib/screens/result_screen.dart` | ~1074 | Decrypt payload | `Colors.deepPurple` text and icon on a dark background. Dim and hard to read. |
| `lib/screens/settings_screen.dart` | ~898 | Delete API key (dialog) | Red background, no text color set, so text is pink on red. |

### B. Text with poor contrast in dark theme (should fix)

These use dark shades (`[800]`, `[900]`) as text color on a normal card. The card is dark
in dark theme, so the text is dark on dark.

| File | Line | Text |
| --- | --- | --- |
| `lib/screens/widgets/totp_action_card.dart` | ~101 | TOTP issuer title (`deepPurple[800]`) |
| `lib/screens/settings_screen.dart` | ~715 | Privacy explainer text (`orange[900]` / `blue[900]`) |
| `lib/screens/widgets/contact_action_card.dart` | ~61 | Contact card title (`green[800]`) |

### Checked and OK (no change)

- The StegoQR card in `result_screen.dart` uses dark purple text, but the card itself always
  has a light purple background, so it is readable in both themes.
- Action card buttons (Wi-Fi, SMS, phone, email, geo, ISBN, product, calendar, TOTP,
  payment, app link) use a fixed dark shade (`[700]`/`[800]`) with white text. This is
  readable in both themes.
- Air QR "Start stream" uses `colorScheme.primary` with white text. Readable enough; it will
  be switched to `onPrimary` as part of this fix for consistency.
- Calendar, geo and email cards already pick colors based on `isDark`.

## The fix

1. **Open in Browser** (`result_screen.dart`):
   - Safe URL: background `colorScheme.primary`, text `colorScheme.onPrimary`.
   - Unsafe URL: background `Colors.orange[800]`, text `Colors.white`
     (or `Colors.black` on a lighter orange — pick the one with better contrast).
2. **Scan Another Code** (`result_screen.dart`): background `colorScheme.primary`, text
   `colorScheme.onPrimary`.
3. **Decrypt payload** (`result_screen.dart`): use a purple shade that depends on
   brightness — `Colors.deepPurple[200]` in dark theme, `Colors.deepPurple` in light theme —
   for the text, icon and border.
4. **Delete API key** (`settings_screen.dart`): add `foregroundColor: Colors.white`.
5. **Air QR Start stream** (`air_qr_transmitter_screen.dart`): use `colorScheme.onPrimary`
   instead of `Colors.white` when the background is `primary`.
6. **Section B text**: pick the text color by brightness — the light shade (`[200]`/`[300]`)
   in dark theme, the current dark shade in light theme. This matches how the calendar and
   geo cards already do it.

No new strings, no new packages, no change to logic. Only colors change.

## Files to change

- `lib/screens/result_screen.dart`
- `lib/screens/settings_screen.dart`
- `lib/screens/air_qr_transmitter_screen.dart`
- `lib/screens/widgets/totp_action_card.dart`
- `lib/screens/widgets/contact_action_card.dart`
- `change_log/<timestamp>_fix_button_contrast_dark_theme.md` (new)

## Checks

- `dart format` on changed files.
- `flutter analyze` must be clean.
- `flutter test` must pass.
- Visual check in light, dark and OLED themes on the result screen (URL scan) and the
  Settings API key delete dialog. I will not install anything on your phone without asking.
