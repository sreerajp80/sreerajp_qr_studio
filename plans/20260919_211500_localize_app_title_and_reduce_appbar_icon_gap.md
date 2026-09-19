# Localize App Title Bar and Reduce Gap Between Title Bar Icons

**Status:** completed

## The issue

1. **App title bar is always in English**:
   In `lib/l10n/app_ml.arb` and `lib/l10n/app_sa.arb`, the `appTitle` string was set to `"SreerajP QR Reader"` (English text) instead of localized text. When the user changes the app language to Malayalam or Sanskrit, the title bar remains in English.

2. **Gap between title bar icons is too large**:
   In `lib/screens/scanner_screen.dart`, the top `AppBar` contains 5 action items (Gallery, PDF, Clipboard, Batch mode, and More options). By default in Material 3, each `IconButton` and `PopupMenuButton` has a 48x48 dp minimum touch box and 8 dp padding. This creates a wide gap (around 24 dp) between icons, crowding the title and making the bar look spaced out.

## Files to change

### Localization
| File | Change |
|------|--------|
| `lib/l10n/app_ml.arb` | Set `appTitle` to `"ശ്രീരാജ് പി ക്യുആർ റീഡർ"` (matching `assets/config/app_config.json`) |
| `lib/l10n/app_sa.arb` | Set `appTitle` to `"श्रीराज् पि क्यू-आर-पाठकः"` (matching `assets/config/app_config.json`) |
| `lib/l10n/gen/*` | Rebuild generated localization files via `flutter gen-l10n` |

### Scanner Screen
| File | Change |
|------|--------|
| `lib/screens/scanner_screen.dart` | Apply compact visual density, tighter padding (`EdgeInsets.symmetric(horizontal: 4)`), and constraints (`BoxConstraints(minWidth: 36, minHeight: 36)`) to action icons and the popup menu button. Add `maxLines: 1` and `overflow: TextOverflow.ellipsis` to the title text. Set `actionsPadding: const EdgeInsets.only(right: 4)` on the `AppBar`. |

## The fix

1. Update `lib/l10n/app_ml.arb` line 3: `"appTitle": "ശ്രീരാജ് പി ക്യുആർ റീഡർ"`.
2. Update `lib/l10n/app_sa.arb` line 3: `"appTitle": "श्रीराज् पि क्यू-आर-पाठकः"`.
3. Run `flutter gen-l10n` to update generated localizations.
4. In `lib/screens/scanner_screen.dart`:
   - Set `constraints: const BoxConstraints(minWidth: 36, minHeight: 36)`, `visualDensity: VisualDensity.compact`, and `padding: const EdgeInsets.symmetric(horizontal: 4)` on the action `IconButton`s.
   - Set `constraints: const BoxConstraints(minWidth: 36, minHeight: 36)` and `padding: const EdgeInsets.symmetric(horizontal: 4)` on `PopupMenuButton`.
   - Add `actionsPadding: const EdgeInsets.only(right: 4)` to the `AppBar`.
   - Add `maxLines: 1, overflow: TextOverflow.ellipsis` to `Text(l10n.appTitle)`.
5. Run `dart format .`, `flutter analyze`, and `flutter test`.
6. Write the change log to `change_log/`.

## Risk

Low. The changes only affect the localized title string for Malayalam and Sanskrit, and adjust the spacing/padding of the top bar action icons.
