# Change log: Migrate the Android build to Built-in Kotlin

Implements plan: [plans/20261007_075652_migrate_builtin_kotlin.md](../plans/20261007_075652_migrate_builtin_kotlin.md) (Revision 2)

## What changed

### Gradle

- `android/gradle.properties` — `android.builtInKotlin=true` (was `false`), with a new
  comment. `android.newDsl=false` is unchanged.
- `android/app/build.gradle` — removed `id "kotlin-android"`. AGP now compiles the app's
  Kotlin code itself. The `kotlin { compilerOptions { jvmTarget = JVM_17 } }` block stays.
- `android/settings.gradle` — not changed (Kotlin 2.4.0 stays declared with
  `apply false`, the same as the Flutter 3.47.6 template).

### Packages (`pubspec.yaml`, `pubspec.lock`, `docs/dependencies.md`)

| Package | Before | After |
| ------- | ------ | ----- |
| `share_plus` | `^12.0.1` (12.0.1) | `^13.3.1` (13.3.1) |
| `package_info_plus` | `^9.0.0` (9.0.0) | `^10.2.2` (10.2.2) |
| `pdfx` | `^2.7.0` (2.9.2) | `^2.11.0` (2.11.0) |
| `shared_preferences` | `^2.5.5` (android 2.4.23) | `^2.5.6` (android 2.4.28) |
| `dynamic_color` | `^1.7.0` (1.8.1) | `^1.9.0` (1.9.0) |
| `file_picker` | `^8.1.7` | `^13.1.0` (13.1.0, with `android_file_picker` 2.0.1) |

- `file_picker` had to move to 13.x because `share_plus` 13 and `package_info_plus` 10
  need `win32` 6, and `file_picker` below 12 needs `win32` 5. `win32` is now 6.4.0.
- `dynamic_color` stays on 1.x on purpose: 2.x uses the new `material_ui` package with
  its own `ColorScheme` class, which does not match the app's `flutter/material.dart`
  `ColorScheme`.
- New transitive packages come from the `file_picker` split (same author, MIT) and
  `cross_file` (Flutter team, BSD-3). No new direct packages.

### App code (layer: `services`)

- `lib/services/code_forge_service.dart` — `pickAndReadTextFile()` now calls
  `FilePicker.pickFile(...)` (returns `PlatformFile?`) instead of
  `FilePicker.platform.pickFiles(...)` (`FilePickerResult?`, removed in `file_picker`
  12). Same allowed extensions, same empty result on cancel, same error handling.
- `lib/services/media_scan_service.dart` — `pickAndScanPdf()` changed the same way.

## Verification

- `flutter analyze` — no issues.
- `flutter test` — all 472 tests passed.
- `flutter build apk --flavor dev --debug` — built. The app's own Kotlin code compiled
  with Built-in Kotlin.
- `flutter build apk --flavor prod --release` — built.
- Nothing was installed on a device.

## Remaining warning (false positive)

Flutter still lists `pdfx` as a plugin that applies the Kotlin Gradle Plugin. Flutter
finds this by searching the plugin's build-file text for
`apply plugin: 'kotlin-android'`. In `pdfx` 2.11.0 that line is inside
`if (!builtInKotlinEnabled) { ... }`, and Built-in Kotlin is now on, so the plugin is not
really applied. The warning is from the text search only. It should go away when `pdfx`
or Flutter changes how this is written or detected.

The warnings for the app itself and for `dynamic_color`, `package_info_plus`,
`share_plus` and `shared_preferences_android` are gone.

## Manual check still needed

Not covered by unit tests: sharing, app version on the About screen, picking a PDF to
scan, Code Forge "open text file", and dynamic color.
