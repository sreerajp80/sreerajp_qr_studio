# Change Plan: Fix System Default Language Radio Selection in Language Dialog

**Status:** Completed

## Issue Description
In `SettingsScreen`, tapping the "Language" card opens a dialog allowing users to pick the app language:
- System default
- English
- മലയാളം
- സംസ്കൃതം

When the current language is "System default" (`localeProvider.locale == null`), `localeProvider.languageCode` returns `'system'` (defined as `LocaleProvider.systemValue`).

However, in `_showLanguageDialog` in `lib/screens/settings_screen.dart`, the radio group was configured as:
```dart
RadioGroup<String?>(
  groupValue: localeProvider.languageCode, // returns 'system'
  ...
  child: Column(
    children: [
      RadioListTile<String?>(
        title: Text(l10n.languageSystemDefault),
        value: null, // Mismatch: null != 'system'
      ),
      ...
    ],
  ),
)
```
Because the tile's `value` is `null` while `groupValue` is `'system'`, the "System default" radio button is never selected when the app is in System default language mode.

## Proposed Fix
1. In `lib/screens/settings_screen.dart`:
   - Change `RadioGroup<String?>` to `RadioGroup<String>`.
   - Update `RadioListTile<String?>` to `RadioListTile<String>`.
   - Set `value: LocaleProvider.systemValue` (i.e. `'system'`) for the "System default" `RadioListTile`.
   - In `onChanged`, verify `val != null` and call `localeProvider.setLanguage(val)`.

2. In `test/screens/settings_screen_test.dart`:
   - Enhance the language dialog test to verify that the "System default" radio option is selected by default.

## Files to Change

### Presentation Layer
- **[MODIFY]** `lib/screens/settings_screen.dart`: Update `_showLanguageDialog` so the System default radio tile uses `LocaleProvider.systemValue` instead of `null`.

### Test Layer
- **[MODIFY]** `test/screens/settings_screen_test.dart`: Assert that the "System default" radio list tile is checked when opening the language dialog.

---

## Verification Plan

### Automated Checks
- Run `flutter analyze` to ensure 0 static analysis errors/warnings.
- Run `flutter test test/screens/settings_screen_test.dart` to verify dialog rendering and radio selection.
- Run `flutter test` to ensure all tests pass.

### Manual Verification
- Build and reinstall the app on the emulator (`emulator-5554`).
- Open the Language dialog in Settings.
- Verify that the "System default" radio button is selected.
