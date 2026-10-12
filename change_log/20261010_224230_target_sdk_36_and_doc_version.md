# Change log: Set targetSdk to 36 and fix stale version in docs

Implements plan: `plans/20261010_223654_target_sdk_36_and_doc_version.md`

## What changed

- `android/app/build.gradle`: `targetSdk = flutter.targetSdkVersion` → `targetSdk = 36`.
  The target API level no longer depends on which Flutter SDK is installed.
  `compileSdk` stays at 37, which is high enough.
- `CLAUDE.md` and `AGENTS.md`: identity table now says `targetSdk 36` (kept in step).
- `README.md`, `docs/architecture.md`, `docs/security.md`: `targetSdk 35` → `targetSdk 36`.
- `docs/release_process.md`: `targetSdk 35` → `targetSdk 36`; current version
  `2.8.1+21` → `4.0.4+33` (two places); tag example `v2.8.1` → `v4.0.4`.
- `docs/features.md`: SDK row now says `targetSdk 36` instead of "follows the Flutter default".

## Not changed

- `docs/guidelines/` (shared submodule, only placeholders).
- No app code or behaviour changes. The installed Flutter SDK already used 36 by default.

## Checks

- `flutter analyze`: no issues.
- `flutter test`: all 582 tests passed.
- Nothing was installed or run on a phone.
