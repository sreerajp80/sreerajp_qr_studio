# Migrate the Android build to Built-in Kotlin

**Status:** completed

## What the issue is

With AGP 9, Android has "Built-in Kotlin": AGP compiles Kotlin by itself, and the
separate Kotlin Gradle Plugin (`kotlin-android`) should no longer be applied. Every
Android build now warns:

- the app (`android/app/build.gradle`) applies the Kotlin Gradle Plugin, and
- five plugins also apply it: `dynamic_color`, `package_info_plus`, `pdfx`,
  `share_plus`, `shared_preferences_android`.

Flutter says future versions will **fail to build** until this is fixed. Flutter's guide
(`docs.flutter.dev/release/breaking-changes/migrate-to-built-in-kotlin/for-app-developers`)
says, for an app:

1. remove the `kotlin-android` plugin,
2. remove `kotlinOptions { }` and use `kotlin { compilerOptions { } }`,
3. set `android.builtInKotlin=true` in `android/gradle.properties`.

Step 2 is already done (in the AGP 9.4.1 upgrade).

### The five plugins

I checked the Android build file of the newest version of each plugin:

| Plugin | Now | Change to | Built-in Kotlin support in that version |
| ------ | --- | --------- | --------------------------------------- |
| `share_plus` | `^12.0.1` | `^13.3.1` | Applies KGP only when Built-in Kotlin is off |
| `package_info_plus` | `^9.0.0` | `^10.2.2` | Applies KGP only when Built-in Kotlin is off |
| `pdfx` | `^2.7.0` | `^2.11.0` | Applies KGP only when Built-in Kotlin is off |
| `shared_preferences` (pulls `shared_preferences_android`) | `^2.5.5` (android 2.4.23) | `^2.5.6` (android 2.4.28) | No KGP in its build file |
| `dynamic_color` | `^1.7.0` (1.8.1 locked) | `^1.9.0` | Does not apply KGP |

Notes:

- `share_plus` 13 and `package_info_plus` 10 are major versions. Their only breaking
  change is a `win32` update with Windows/iOS/macOS minimums. This app is Android only,
  so it is not affected. The APIs the app uses (`SharePlus.instance.share`, the older
  `Share.shareXFiles`, `PackageInfo.fromPlatform`) still exist. (`Share.shareXFiles` is
  deprecated in both 12 and 13. Moving off it is out of scope.)
- **`dynamic_color` stays on 1.x on purpose.** Version 2.x moved to the new
  `material_ui` package, which has its **own `ColorScheme` class**, different from the
  `ColorScheme` in `package:flutter/material.dart` that the whole app uses. Using 2.x
  would break `lib/main.dart` and `lib/providers/theme_provider.dart` and would need a
  full app migration to `material_ui`. Version 1.9.0 still uses `flutter/material.dart`
  and does not apply KGP, so it solves the warning without that risk.
- No new direct packages are added.

### Revision 2: also upgrade `file_picker` (chosen by the user)

The first try failed (see "Blocker" below): `share_plus` 13 and `package_info_plus` 10
need `win32` 6, and `file_picker` below 12 needs `win32` 5. The user chose to also
upgrade `file_picker`:

| Plugin | Now | Change to |
| ------ | --- | --------- |
| `file_picker` | `^8.1.7` | `^13.1.0` |

- `file_picker` 12 split the package into parts (`file_picker_platform_interface`,
  `android_file_picker`, and parts for other platforms) and changed the API.
  `android_file_picker` 2.x applies KGP only when Built-in Kotlin is off. These new
  sub-packages come in as transitive dependencies. They are from the same author, under
  the same MIT license, plus `cross_file` (Flutter team, BSD-3) and `win32` 6 (BSD-3).
  None of them use the network.
- API change: `FilePicker.platform.pickFiles(...)` returning `FilePickerResult?` is gone.
  The new call is the static `FilePicker.pickFile(type:, allowedExtensions:)`, which
  returns `PlatformFile?` (`null` = user cancelled).
- On Android, by default, the picker still copies the chosen file into the app's cache
  folder and returns a normal file path (the same as 8.x), so `PlatformFile.path` works
  as before.

Code change in the two **services** (target layer: `services`; no new classes):

```dart
// before
final result = await FilePicker.platform.pickFiles(type: ..., allowedExtensions: ...);
if (result == null || result.files.isEmpty || result.files.single.path == null) {
  return <empty result>;
}
return await readOrScan(result.files.single.path!, ...);

// after
final picked = await FilePicker.pickFile(type: ..., allowedExtensions: ...);
final path = picked?.path;
if (path == null) return <empty result>;
return await readOrScan(path, ...);
```

The same allowed file extensions, the same empty results, and the same error handling
are kept.

## Files to be changed

- `android/gradle.properties` — `android.builtInKotlin=false` → `true` (and update its
  comment). `android.newDsl=false` stays.
- `android/app/build.gradle` — remove `id "kotlin-android"` from `plugins { }`. The
  existing `kotlin { compilerOptions { jvmTarget = JVM_17 } }` block stays.
- `android/settings.gradle` — **no change**. The
  `org.jetbrains.kotlin.android version "2.4.0" apply false` line stays, the same as
  the Flutter 3.47.6 template. It keeps Kotlin 2.4.0 on the build classpath for AGP
  and for any plugin that still applies KGP.
- `pubspec.yaml` — the five constraint changes in the table above, plus `file_picker`
  `^8.1.7` → `^13.1.0`.
- `lib/services/code_forge_service.dart` — `pickAndReadTextFile()` uses the new
  `FilePicker.pickFile` API.
- `lib/services/media_scan_service.dart` — `pickAndScanPdf()` uses the new
  `FilePicker.pickFile` API.
- `pubspec.lock` — updated by `flutter pub get`.
- `docs/dependencies.md` — the version column for these six packages.
- `change_log/<timestamp>_migrate_builtin_kotlin.md` — new change log.

## Plan for the fix

1. Update `pubspec.yaml` constraints, run `flutter pub get`, and check the lock file
   picked the expected versions (including `shared_preferences_android` 2.4.28,
   `dynamic_color` 1.9.0 and `file_picker` 13.1.0).
   Then update the two services to the new `file_picker` API.
2. Edit `android/gradle.properties` and `android/app/build.gradle`.
3. Update `docs/dependencies.md`.
4. Verify:
   - `flutter analyze` (must be clean),
   - `flutter test`,
   - `flutter build apk --flavor dev --debug` — check that the Kotlin Gradle Plugin
     warnings are gone and the app's Kotlin code (`MainActivity`, `GhostScanActivity`,
     `GhostScanCaptureService`) still compiles,
   - `flutter build apk --flavor prod --release`.
   - Nothing is installed on a device.
5. If a plugin still breaks the build with Built-in Kotlin, stop and report. Do not
   patch plugin code.
6. Write the change log and set this plan to `completed`.

## Testing note

Share, app-version (About screen), PDF scanning (pick a PDF), Code Forge "open text
file", and dynamic color run through native plugin code, which unit tests do not cover.
After this change it is worth a quick manual check of those five features on a test
device. I will not install anything on your
phone unless you say yes.

## Blocker found during implementation

`flutter pub get` failed. `package_info_plus` 10.x and `share_plus` 13.x need `win32`
6, but the app's `file_picker` `^8.1.7` (all versions below 12) needs `win32` 5. The
latest 9.x / 12.x of those two plugins still always apply KGP, so they do not help.
`file_picker` 12+ is a large API rewrite (for example `FilePickerResult` was removed and
`pickFiles()` returns `List<PlatformFile>`), which would need code changes in
`lib/services/code_forge_service.dart` and `lib/services/media_scan_service.dart`.

The `pubspec.yaml` and `docs/dependencies.md` edits were reverted. No Gradle files were
changed yet. The user chose to also upgrade `file_picker` (Revision 2 above).
