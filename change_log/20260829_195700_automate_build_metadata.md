# Change Log: Automate Build Metadata Generation and Display Build Date in About Screen

**Plan Reference:** [plans/20260829_195100_automate_build_metadata.md](../plans/20260829_195100_automate_build_metadata.md)

## Summary of Changes

1. **Build Scripts**:
   - Created `tool/generate_app_version.dart` to read `pubspec.yaml` and generate `lib/core/constants/app_version.g.dart` (`kAppVersion`).
   - Created `tool/generate_build_date.dart` to generate `lib/core/constants/build_date.g.dart` (`kBuildDate`) with current ISO date (`YYYY-MM-DD`).

2. **Android Gradle Automation**:
   - Updated `android/app/build.gradle` to add the `generateBuildMetadata` Gradle task.
   - Connected `generateBuildMetadata` to `preBuild` and `compileFlutterBuild*` tasks so building or running the Android application updates `app_version.g.dart` and `build_date.g.dart` and prints the update status.

3. **Configuration & Localization**:
   - Removed hardcoded `"Last build"` field from `assets/config/app_config.json`.
   - Added `aboutBuildDate` localized string to `lib/l10n/app_en.arb` and regenerated localization classes.

4. **UI**:
   - Updated `lib/screens/about_screen.dart` to display the dynamic build date (`kBuildDate`) in an info card with calendar icon.

5. **Testing**:
   - Added unit test suite `test/core/constants/build_metadata_test.dart` verifying format and non-empty values for `kAppVersion` and `kBuildDate`.

## Verification Results
- Ran `dart run tool/generate_app_version.dart` and `dart run tool/generate_build_date.dart` — passed.
- Ran `flutter gen-l10n` — passed.
- Ran `flutter analyze` — 0 issues found.
- Ran `flutter test` — all 165 tests passed cleanly.
- Ran `gradlew app:generateBuildMetadata` — task executed successfully and updated constants.
