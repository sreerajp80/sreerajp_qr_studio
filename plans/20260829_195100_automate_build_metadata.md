# Change Plan: Automate Build Version and Date Generation and Display Build Date in About Screen

**Status:** Completed

## Issue Description
Currently:
1. The build date is hardcoded in `assets/config/app_config.json` under `"Last build"`.
2. Running `flutter build apk` does not automatically update build date or version constants.
3. The build date should be generated automatically during the build process and displayed cleanly in the About screen.

## Proposed Fix
1. Create `tool/generate_app_version.dart` to read `pubspec.yaml` and generate `lib/core/constants/app_version.g.dart` (`kAppVersion`).
2. Create `tool/generate_build_date.dart` to generate `lib/core/constants/build_date.g.dart` (`kBuildDate`) with the current date.
3. Add a Gradle task `generateBuildMetadata` to `android/app/build.gradle` so executing `flutter build` or `flutter run` automatically runs both generation scripts before Flutter compilation.
4. Remove the hardcoded `"Last build"` field from `assets/config/app_config.json`.
5. Add `aboutBuildDate` localization key to `lib/l10n/app_en.arb` and run `flutter gen-l10n`.
6. Update `lib/screens/about_screen.dart` to display the build date from `kBuildDate` using an info card.
7. Add unit tests for `kAppVersion` and `kBuildDate` in `test/core/constants/build_metadata_test.dart`.

## Files to Change

### Tooling Layer
- **[NEW]** `tool/generate_app_version.dart`: Dart script to generate `app_version.g.dart` from `pubspec.yaml`.
- **[NEW]** `tool/generate_build_date.dart`: Dart script to generate `build_date.g.dart` with ISO date.

### Build Configuration Layer
- **[MODIFY]** `android/app/build.gradle`: Register `generateBuildMetadata` Gradle task and hook it to `preBuild` and `compileFlutterBuild*`.

### Constants & Configuration Layer
- **[NEW]** `lib/core/constants/app_version.g.dart`: Generated app version constant (`kAppVersion`).
- **[NEW]** `lib/core/constants/build_date.g.dart`: Generated build date constant (`kBuildDate`).
- **[MODIFY]** `assets/config/app_config.json`: Remove hardcoded `"Last build"` key.

### Localization & UI Layer
- **[MODIFY]** `lib/l10n/app_en.arb`: Add `aboutBuildDate` message and metadata.
- **[MODIFY]** `lib/screens/about_screen.dart`: Import `build_date.g.dart` and render a Build Date card in the About screen details list.

### Testing Layer
- **[NEW]** `test/core/constants/build_metadata_test.dart`: Unit test to verify `kAppVersion` and `kBuildDate` constants.

---

## Verification Plan

### Automated Tests
- Run `dart run tool/generate_app_version.dart` and `dart run tool/generate_build_date.dart` to verify generation and console output.
- Run `flutter gen-l10n` to regenerate localization classes.
- Run `flutter analyze` to confirm static analysis is clean (0 issues).
- Run `flutter test` to verify all unit tests pass.

### Build Verification
- Run a dry-run or Gradle build check (e.g. `gradlew app:generateBuildMetadata` or `flutter build apk --flavor dev --debug`) to verify Gradle task hooks and outputs.
