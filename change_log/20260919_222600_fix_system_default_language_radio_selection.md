# Change Log: Fix System Default Language Radio Selection in Language Dialog

**Plan Reference:** [plans/20260919_222600_fix_system_default_language_radio_selection.md](../plans/20260919_222600_fix_system_default_language_radio_selection.md)

## Summary of Changes

1. **Presentation Layer**:
   - In `lib/screens/settings_screen.dart`, updated `_showLanguageDialog` so that `RadioGroup<String>` and `RadioListTile<String>` use `String` instead of nullable `String?`.
   - Set the System default radio tile value to `LocaleProvider.systemValue` (`'system'`) instead of `null`, matching `localeProvider.languageCode`.
   - Updated the `onChanged` callback to pass the selected string to `localeProvider.setLanguage(val)`.

2. **Test Layer**:
   - In `test/screens/settings_screen_test.dart`, added assertions in `testWidgets('Opens Language dialog on card tap')` to verify that `RadioGroup<String>.groupValue` and the System default `RadioListTile<String>.value` are both `LocaleProvider.systemValue`.

## Verification Results
- Ran `flutter analyze` — 0 issues found.
- Ran `flutter test test/screens/settings_screen_test.dart` — all 8 tests passed.
- Ran `flutter test` — all 349 tests passed.
- Built production release APKs (`flutter build apk --flavor prod --release --split-per-abi`).
- Reinstalled `app-x86_64-prod-release.apk` on `emulator-5554` and restarted the app successfully.
