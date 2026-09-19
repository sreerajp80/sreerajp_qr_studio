# Localize App Title Bar and Reduce Gap Between Title Bar Icons

Reference: `plans/20260919_211500_localize_app_title_and_reduce_appbar_icon_gap.md`

## Summary of Changes

1. **Localize App Title Bar**:
   - Updated `lib/l10n/app_ml.arb` to use `"appTitle": "ശ്രീരാജ് പി ക്യുആർ റീഡർ"` instead of the English string.
   - Updated `lib/l10n/app_sa.arb` to use `"appTitle": "श्रीराज् पि क्यू-आर-पाठकः"` instead of the English string.
   - Rebuilt generated localization files using `flutter gen-l10n`.
   - Now, switching the app language to Malayalam or Sanskrit properly displays the localized app title in the top title bar.

2. **Reduce Spacing Between Title Bar Icons**:
   - In `lib/screens/scanner_screen.dart`, updated the `AppBar`:
     - Added `actionsPadding: const EdgeInsets.only(right: 4)` for balanced margins.
     - Added `maxLines: 1, overflow: TextOverflow.ellipsis` to the title text.
     - Applied `visualDensity: VisualDensity.compact`, `padding: const EdgeInsets.symmetric(horizontal: 4)`, and `constraints: const BoxConstraints(minWidth: 36, minHeight: 36)` to the action `IconButton` widgets.
     - Applied `padding: const EdgeInsets.symmetric(horizontal: 4)` and `constraints: const BoxConstraints(minWidth: 36, minHeight: 36)` to the `PopupMenuButton`.
   - Reduced visual spacing between icons from ~24 dp to ~12 dp, giving more room to the title and creating a clean, compact appearance.

## Verification

- `flutter gen-l10n`: Completed cleanly.
- `dart format .`: Formatted cleanly.
- `flutter analyze`: Completed with no issues found.
- `flutter test`: All 349 unit and widget tests passed, including `test/l10n/l10n_parity_test.dart`.
