# Fix CI Flutter version

Implements plan: `plans/20261012_122742_ci_flutter_version.md`

## What changed

- `.github/workflows/ci.yml`: changed `flutter-version` from `'3.44.9'` to `'3.47.6'`.

## Why

CI failed at `flutter pub get`. Flutter 3.44.9 ships Dart 3.12.2, but `pubspec.yaml` needs
Dart `>=3.13.5`. Flutter 3.47.6 ships Dart 3.13.5 and matches the project's documented SDK.

## Checks run locally (Flutter 3.47.6)

- `flutter pub get` — passed
- `dart format --output=none --set-exit-if-changed .` — passed (0 files changed)
- `flutter analyze` — no issues
- `flutter test` — all 582 tests passed
