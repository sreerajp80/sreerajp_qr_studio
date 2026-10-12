# Change log: Upgrade Flutter to 3.47.6, AGP to 9.4.1 and Gradle to 9.8.0

Implements plan: [plans/20261007_070053_upgrade_flutter_agp_gradle.md](../plans/20261007_070053_upgrade_flutter_agp_gradle.md) (Revision 2)

## Versions

| Tool | Before | After |
| ---- | ------ | ----- |
| Flutter (pubspec floor) | `>=3.44.8` | `>=3.47.6` |
| Dart (pubspec floor) | `>=3.12.2 <4.0.0` | `>=3.13.5 <4.0.0` |
| Android Gradle Plugin | 8.13.0 | 9.4.1 |
| Gradle wrapper | 8.14 (`-bin`) | 9.8.0 (`-all`) |

The first target (AGP 9.2.1 + Gradle 9.3.1) did not build, because AGP 9.2 needs Gradle
9.4.1 or newer. The user then chose AGP 9.4.1 + Gradle 9.8.0.

## What changed

- `pubspec.yaml` — raised the Flutter and Dart SDK floors.
- `android/settings.gradle` — AGP plugin version set to 9.4.1.
- `android/gradle/wrapper/gradle-wrapper.properties` — Gradle 9.8.0. The `-all`
  package is used instead of `-bin`. It is the same Gradle version, plus the source code
  and docs, and is the package the Flutter tools write. The `-bin` download kept timing out on the
  build machine, while `-all` was already cached.
- `android/build.gradle`
  - Removed the old `buildscript { classpath ... }` block. AGP and Kotlin are now set
    only in `settings.gradle`.
  - Replaced the deprecated `buildDir` with `layout.buildDirectory` (same output folder:
    project-root `build/`).
- `android/app/build.gradle`
  - `project.exec` (removed in Gradle 9) replaced with Gradle's `ExecOperations` service
    in the `generateBuildMetadata` task.
  - `lintOptions { }` (removed in AGP 9) replaced with `lint { }`.
  - `flavorDimensions "environment"` changed to `flavorDimensions = ["environment"]`.
  - `kotlinOptions { jvmTarget }` replaced with a top-level
    `kotlin { compilerOptions { jvmTarget = JvmTarget.JVM_17 } }` block.
  - Removed the `kotlin-stdlib-jdk8` dependency (the Kotlin plugin adds the standard
    library itself; it relied on the removed `buildscript` block).
- `lib/services/barcode_decoder/barcode_decoder_service.dart` — added a missing
  `await` in `decodeImageFile`, so a decode error is caught by the `catch` block instead
  of escaping. Found by the new Dart 3.13 lint `unawaited_return_in_try_block`.
- `analysis_options.yaml` — `analyzer.exclude` block (`build/**`, `android/**`) added
  automatically by Flutter 3.47.6 during `flutter pub get`; kept.
- `CLAUDE.md`, `AGENTS.md`, `README.md`, `docs/features.md` — Flutter/Dart version text.

Not changed: `docs/guidelines/` (shared submodule). It still says to stay on AGP 8.x;
that rule should be updated in the guidelines repository.

## Verification

- `flutter analyze` — no issues.
- `flutter test` — all 472 tests passed.
- `flutter build apk --flavor dev --debug` — built (includes native decoder CMake build
  and build-metadata generation).
- `flutter build apk --flavor prod --release` — built.
- Nothing was installed on a device.

## Follow-up warnings (not fixed here)

- Flutter warns that Kotlin 2.2.21 support will soon be dropped; it asks for Kotlin
  2.3.20 or newer.
- Flutter warns that the app applies the Kotlin Gradle Plugin and asks to migrate to
  AGP "Built-in Kotlin" (`android.builtInKotlin=true`). These plugins also still apply
  it: `dynamic_color`, `package_info_plus`, `pdfx`, `share_plus`,
  `shared_preferences_android`. Future Flutter versions will fail to build until
  these are migrated.
- Flutter 3.47.6's tools officially know AGP only up to 9.2 and Gradle only up to 9.3.1.
  The builds above work, but this pair is newer than what Flutter 3.47.6 was tested with.
