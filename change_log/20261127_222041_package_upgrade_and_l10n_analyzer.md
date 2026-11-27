# Change log: package upgrade and gen-l10n analyzer exclude

Implements `plans/20261127_221440_package_upgrade_and_l10n_analyzer.md`.

## What changed

- `pubspec.lock`: `flutter pub upgrade` (inside current constraints, no `--major-versions`)
  changed 34 packages. No new packages were added and `pubspec.yaml` is unchanged.
  - Direct: `cupertino_ui` 1.1.6 → 1.1.7, `file_picker` 13.3.2 → 13.4.1, `material_ui`
    1.10.0 → 1.11.1, `pdfx` 2.11.0 → 2.11.1, `sqflite` 2.4.5 → 2.4.6.
  - Dev: `sqflite_common_ffi` 2.4.5 → 2.4.7.
  - Transitive: `android_file_picker` 2.2.1, `archive` 4.7.1, `asn1lib` 1.6.9,
    `camera_android_camerax` 0.7.6+2, `camera_platform_interface` 2.15.1, `camera_web` 0.3.6,
    `code_assets` 2.2.0, `file_picker_darwin` 2.5.2, `file_picker_linux` 2.0.5,
    `file_picker_platform_interface` 4.3.0, `file_picker_web` 4.2.2, `image` 4.13.1,
    `image_picker_ios` 0.8.13+16, `jni` 1.2.1, `jni_flutter` 1.1.0, `native_toolchain_c` 0.19.6,
    `objective_c` 9.6.4, `permission_handler_windows` 0.2.4, `shared_preferences_android` 2.5.5,
    `shared_preferences_foundation` 2.6.2, `sqflite_android` 2.4.6, `sqflite_common` 2.5.17,
    `sqflite_darwin` 2.4.6, `sqflite_platform_interface` 2.4.4, `sqlite3` 3.9.2,
    `synchronized` 3.6.1+1, `url_launcher_android` 6.3.35, `windows_file_picker` 2.0.2.
- `analysis_options.yaml`: added `lib/l10n/gen/**` to `analyzer: exclude:`, with a comment.
  Flutter 3.50.1's `gen-l10n` still writes the deprecated `flutter_localizations` delegates
  into that generated file. Remove the exclude once `gen-l10n` writes the `material_ui` names.
- `CHANGELOG.md`: dependency line under `[Unreleased]` → `Changed`.

## Not done (by design)

- `pointycastle` 4.0.0 and `qr` 4.0.1: other packages still need 3.x, so they cannot be
  resolved yet. `pointycastle` is the encryption engine (StegoQR, passphrase cipher, TOTP), so
  its major upgrade needs its own plan and testing.

## Checks

- `flutter analyze`: no issues.
- `flutter test`: all 926 tests pass.
- `dart format --set-exit-if-changed .`: 0 files changed.
- Android build not yet run (see the toolchain change log's open item).
