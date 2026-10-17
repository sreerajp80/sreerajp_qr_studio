# Phase 3 — CI, Dependabot, repository hygiene and the release script

Plan: [plans/20261012_192931_phase3_ci_hygiene_release_script.md](../plans/20261012_192931_phase3_ci_hygiene_release_script.md)
Roadmap: [plans/20261012_191914_guidelines_compliance_roadmap.md](../plans/20261012_191914_guidelines_compliance_roadmap.md) (gaps B1–B5, C1)

## What changed

- **`.github/dependabot.yml`** (new) — weekly updates for `pub` and `github-actions`
  (engineering standard §19.2).
- **`.github/workflows/ci.yml`** — top-level `permissions: contents: read`; new last step
  "Sanskrit Hindi-marker gate" that runs `tool/check_sanskrit_hindi_markers.sh`. Existing steps
  unchanged. No release, signing or upload steps.
- **`tool/check_sanskrit_hindi_markers.sh`** (new) — the language pack §4.1 script, copied as
  is, with a short header. It checks `app_sa.arb`, `assets/config/app_config.json` and any
  `assets/**/*_sa.*` file, and runs its own self-test first.
- **`test/l10n/l10n_parity_test.dart`** — the Dart Hindi-marker regex now has the pack's full
  word list (added `आपका`, `आपकी`, `आपके`, `हमारा`, `मेरा`); the test name cites the language
  pack §4.1.
- **`.gitignore`** — added build-artifact patterns (`*.apk`, `*.aab`, `*.ipa`, `*.msix`,
  `*.msixbundle`, `*.dmg`, `*.pkg`, `*.snap`, `*.AppImage`, `*.deb`, `*.rpm`, `*.flatpak`) and
  signing-material patterns (`*.p12`, `*.pfx`, `*.p8`, `*.mobileprovision`,
  `*.provisionprofile`). No tracked file matches them.
- **`analysis_options.yaml`** — added `use_decorated_box`,
  `avoid_bool_literals_in_conditional_expressions`, `noop_primitive_operations`, `use_enums`.
- **Lint fixes (8 hits, no behaviour change)**:
  - `lib/models/distance_enhanced_scan_result.dart` — removed 2 needless `.toDouble()` after
    `double.clamp`.
  - `lib/providers/camera_settings_provider.dart` — removed 2 needless `.toDouble()`;
    `savedInvert is bool ? savedInvert : false` → `savedInvert is bool && savedInvert`.
  - `lib/services/scan_camera/scan_camera_controller.dart` — removed 3 needless `.toDouble()`.
- **`tool/build_release.sh`** — reads the version from `pubspec.yaml` and builds with
  `--obfuscate --split-debug-info=build/symbols/android-prod-<version>/`; APK builds add
  `--split-per-abi`; prints where the symbols went. Not run (no release build in this phase).

## Checks

- `tool/check_sanskrit_hindi_markers.sh` — self-test passed; no Hindi markers found. No Sanskrit
  text changed.
- `bash -n tool/build_release.sh` — syntax OK.
- `dart format --output=none --set-exit-if-changed .` — no changes needed.
- `flutter analyze` — no issues.
- `flutter test` — all 582 tests passed.
- No Gradle build was run; no Gradle or Kotlin daemon was left running.
