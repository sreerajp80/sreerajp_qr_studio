# Upgrade Flutter to 3.47.6, AGP to 9.4.1 and Gradle to 9.8.0

**Status:** completed

## What the issue is

The project is on older build tools:

| Tool | Now | Target |
| ---- | --- | ------ |
| Flutter (pubspec floor) | `>=3.44.8` | `>=3.47.6` |
| Dart (pubspec floor) | `>=3.12.2 <4.0.0` | `>=3.13.5 <4.0.0` (the Dart that ships with Flutter 3.47.6) |
| Android Gradle Plugin (AGP) | 8.13.0 | 9.4.1 |
| Gradle wrapper | 8.14 | 9.8.0 |

Flutter 3.47.6 is already installed locally. Both AGP 9.4.1 and Gradle 9.8.0 are
published stable releases.

**Revision 2 (target changed by the user).** The first target (AGP 9.2 + Gradle 9.3.1)
could not build: AGP 9.2 needs Gradle 9.4.1 or newer. The user then chose AGP 9.4.1 +
Gradle 9.8.0.

**Risk:** Flutter 3.47.6's tools were written knowing AGP only up to 9.2 and Gradle only
up to 9.3.1. Flutter's Gradle plugin checks only *minimum* versions, so it will not block
newer ones, but it has not been tested by the Flutter team with AGP 9.4. The build in
step 4 is the real test. If AGP 9.4.1 needs an even newer Gradle than 9.8.0, or the
Flutter Gradle plugin breaks, we stop and report.

AGP 9 and Gradle 9 removed some old build-script features that this project still
uses. Those must be fixed or the Android build will fail:

1. `lintOptions { ... }` was removed in AGP 9. The new block is `lint { ... }`.
2. `flavorDimensions "environment"` (old method call form) is removed. The new form is
   `flavorDimensions = ["environment"]`.
3. `project.exec { ... }` inside a task was removed in Gradle 9. It is used by the
   `generateBuildMetadata` task (runs the two `tool/generate_*.dart` scripts). We will
   use Gradle's `ExecOperations` service instead, which is the official replacement.
4. `kotlinOptions { jvmTarget = '17' }` is deprecated. The new form is a top-level
   `kotlin { compilerOptions { jvmTarget = JvmTarget.JVM_17 } }` block (same as the
   Flutter 3.47 template).
5. `rootProject.buildDir` / `project.buildDir` are deprecated. We switch to
   `layout.buildDirectory`, the same way the Flutter 3.47 template does. The build output
   still goes to the project-root `build/` folder, so Flutter finds the APKs as before.
6. The root `build.gradle` still has an old `buildscript { classpath ... }` block that
   declares AGP and Kotlin a second time (they are also declared in `settings.gradle`).
   We remove this old block so the version is set in one place only. The
   `kotlin-stdlib-jdk8` dependency in `app/build.gradle` (which needs `$kotlin_version`
   from that block) is also removed — the Kotlin plugin adds the standard library by
   itself.

7. **Fix the new Dart 3.13 warning** `unawaited_return_in_try_block` at
   `lib/services/barcode_decoder/barcode_decoder_service.dart:152`: add `await` before
   `decodeEncodedImage(...)` so a decode error is caught by the `catch` block (hard
   rule 4: never crash on bad input). This keeps `flutter analyze` clean.
8. **Keep** the `analyzer.exclude` block (`build/**`, `android/**`) that Flutter 3.47.6
   added to `analysis_options.yaml` by itself during `flutter pub get`.

We keep `android.builtInKotlin=false` and `android.newDsl=false` in
`gradle.properties`. The Flutter 3.47 template keeps them too, and Flutter plugins still
need them. Kotlin stays on 2.2.21 (not part of this request).

## Important: conflict with the shared guidelines

The shared guidelines submodule (`docs/guidelines/`) still says **"AGP must remain on
8.x. Do NOT upgrade to AGP 9"** (written for Flutter 3.41/3.44). You have asked for AGP
9.4.1, so this plan goes ahead with AGP 9.4.1. The
submodule is shared and will **not** be edited in this change. You may want to update
the guideline in its own repository later.

## Files to be changed

- `pubspec.yaml` — raise `environment.sdk` and `environment.flutter` floors.
- `pubspec.lock` — refreshed by `flutter pub get` (only if it changes).
- `android/gradle/wrapper/gradle-wrapper.properties` — Gradle 8.14 (bin) → 9.8.0 (all; see change log).
- `analysis_options.yaml` — `analyzer.exclude` block (added by Flutter tool; keep).
- `lib/services/barcode_decoder/barcode_decoder_service.dart` — add one `await` (fix 7).
- `android/settings.gradle` — AGP plugin version 8.13.0 → 9.4.1.
- `android/build.gradle` — remove old `buildscript` block; use `layout.buildDirectory`.
- `android/app/build.gradle` — fixes 1–4 and 6 above.
- `CLAUDE.md`, `AGENTS.md` — Flutter/Dart version rows in the identity table (kept in step).
- `README.md` — Flutter/Dart badges and the SDK requirement lines.
- `docs/features.md` — Framework row.
- `change_log/<timestamp>_upgrade_flutter_agp_gradle.md` — new change log.

Not changed: anything under `docs/guidelines/` (shared submodule) and `native/zxing-cpp/`.

## Plan for the fix

1. Edit the Gradle files as listed above.
2. Edit `pubspec.yaml` floors, then run `flutter pub get`.
3. Update version text in `CLAUDE.md`, `AGENTS.md`, `README.md`, `docs/features.md`.
4. Verify:
   - `flutter analyze` (must be clean),
   - `flutter test`,
   - `flutter build apk --flavor dev --debug` (proves AGP 9.4.1 + Gradle 9.8.0 build works,
     including the native decoder CMake build and the metadata task),
   - `flutter build apk --flavor prod --release` without installing anything on a phone.
5. If a third-party Flutter plugin or the Flutter Gradle plugin fails to build with AGP 9.4.1, stop and report it
   rather than patching plugin code.
6. Write the change log and set this plan to `completed`.

## Blocker found during implementation

- The first dev build failed: AGP 9.2.x needs **Gradle 9.4.1 or newer**, so AGP 9.2
  with Gradle 9.3.1 cannot build. Waiting for the user to choose between
  AGP 9.2.1 + Gradle 9.4.1, or AGP 9.1.1 + Gradle 9.3.1.
- Resolved by Revision 2 (new target AGP 9.4.1 + Gradle 9.8.0).
- Side effects so far: `flutter pub get` (Flutter 3.47.6) added an `analyzer.exclude`
  block to `analysis_options.yaml` by itself. Dart 3.13 reports one new warning
  (`unawaited_return_in_try_block`) in
  `lib/services/barcode_decoder/barcode_decoder_service.dart:152`, not yet fixed.
