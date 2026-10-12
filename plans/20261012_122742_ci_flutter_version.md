# Fix CI Flutter version

**Status:** completed

## Files to change

- `.github/workflows/ci.yml`

## What the issue is

The GitHub CI job fails at `flutter pub get` with:

> Because sreerajp_qr_studio requires SDK version >=3.13.5 <4.0.0, version solving failed.

The workflow pins `flutter-version: '3.44.9'`. That Flutter ships Dart 3.12.2.
The project (`pubspec.yaml`) needs Dart `>=3.13.5`, which comes with Flutter 3.47.6.
The local machine already uses Flutter 3.47.6 (Dart 3.13.5), so builds work locally but not in CI.

## Plan for the fix

1. In `.github/workflows/ci.yml`, change `flutter-version: '3.44.9'` to `flutter-version: '3.47.6'`
   (keep `channel: 'stable'`). This matches the project's documented Flutter SDK (`>=3.47.6`)
   and the local toolchain.
2. Run `flutter pub get`, `dart format --output=none --set-exit-if-changed .`,
   `flutter analyze` and `flutter test` locally to confirm the later CI steps also pass.
3. Write a change log in `change_log/`.

No app code changes. No commit or push unless asked.
