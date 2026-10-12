# Set targetSdk to 36 and fix stale version in docs

**Status:** completed

## Issue

1. `docs/release_process.md` still says the current version is `2.8.1+21`
   (in two places) and uses `v2.8.1` as the tag example. The real version in
   `pubspec.yaml` and `assets/config/app_config.json` is `4.0.4+33`.
2. Several docs say `targetSdk 35`. The target should be **36**.
3. `android/app/build.gradle` sets `targetSdk = flutter.targetSdkVersion`.
   That means the target is whatever the Flutter SDK picks. Today the installed
   Flutter picks 36, so the build is fine, but a Flutter upgrade or downgrade could
   change it silently. Google Play's target API rule should be checked, not assumed
   (`docs/guidelines/release_process.md`). Pinning the value makes it clear and stable.

`compileSdk` is 37, which is ≥ 36, so no change is needed there.

## Files to change

| File | Change |
| --- | --- |
| `android/app/build.gradle` | `targetSdk = flutter.targetSdkVersion` → `targetSdk = 36` |
| `CLAUDE.md` | Identity table: `targetSdk 35` → `targetSdk 36` |
| `AGENTS.md` | Same change, to keep it in step with `CLAUDE.md` |
| `README.md` | `targetSdk 35` → `targetSdk 36` |
| `docs/architecture.md` | `targetSdk 35` → `targetSdk 36` |
| `docs/security.md` | `targetSdk 35` → `targetSdk 36` |
| `docs/release_process.md` | `targetSdk 35` → `targetSdk 36`; both `2.8.1+21` → `4.0.4+33`; tag example `v2.8.1` → `v4.0.4` |
| `docs/features.md` | "targetSdk follows the Flutter default (`flutter.targetSdkVersion`)" → "targetSdk 36" |

Not changed: `docs/guidelines/` (shared submodule; it only has `<NN>` placeholders).

## Plan for the fix

1. Edit the files above as listed.
2. Run `flutter analyze` and `flutter test` to confirm nothing broke.
3. Do not install or run anything on a phone.
4. Write a change log in `change_log/` and set this plan to `completed`.

## Risk

Low. Target 36 is the same value Flutter already uses today, so app behaviour
does not change. The edit only makes the value fixed and fixes the docs.
