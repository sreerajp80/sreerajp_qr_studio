# Phase 3 — CI, Dependabot, repository hygiene and the release script

**Status:** completed

Part of [plans/20261012_191914_guidelines_compliance_roadmap.md](20261012_191914_guidelines_compliance_roadmap.md)
(gaps B1–B5, C1).

## What the issue is

1. **No Dependabot.** Every repository MUST commit `.github/dependabot.yml` with `pub` and
   `github-actions` (engineering standard §19.2).
2. **CI permissions.** `.github/workflows/ci.yml` has no `permissions: contents: read`
   (§19.1: least permissions, no secrets).
3. **Sanskrit Hindi-marker gate is incomplete.** The language pack (§4.1) gives a CI script that
   checks `app_sa.arb`, `assets/config/app_config.json` and any `assets/**/*_sa.*` file. The
   project only has a Dart test that checks `app_sa.arb`, and its word list misses
   `आपका`, `आपकी`, `आपके`, `हमारा`, `मेरा`.
4. **`.gitignore`** misses the build-artifact and signing patterns of §20.4: `*.apk`, `*.aab`,
   `*.ipa`, `*.msix`, `*.msixbundle`, `*.dmg`, `*.pkg`, `*.snap`, `*.AppImage`, `*.deb`,
   `*.rpm`, `*.flatpak`, `*.p12`, `*.pfx`, `*.p8`, `*.mobileprovision`, `*.provisionprofile`.
5. **Lints.** `analysis_options.yaml` misses four rules from the §16.1 baseline:
   `use_decorated_box`, `avoid_bool_literals_in_conditional_expressions`,
   `noop_primitive_operations`, `use_enums`.
6. **Release script is not hardened.** `tool/build_release.sh` runs
   `flutter build <target> --flavor prod --release` with **no** `--obfuscate` and
   `--split-debug-info`. Every production build MUST use both (§15.1, `guideline.md` §2.4), with
   symbols in `build/symbols/android-prod-<version>/` (§19.3).

## Files to be changed

- `.github/dependabot.yml` — new.
- `.github/workflows/ci.yml` — add permissions and the Sanskrit gate step.
- `tool/check_sanskrit_hindi_markers.sh` — new; the language pack §4.1 script, unchanged in
  logic.
- `test/l10n/l10n_parity_test.dart` — make the Dart gate use the same word list as the pack.
- `.gitignore` — add the missing patterns.
- `analysis_options.yaml` — add the four lint rules.
- Any `lib/` or `test/` file the new lints flag — fix only what the lints report.
- `app_sa.arb` / `assets/config/app_config.json` — only if the full gate finds a Hindi marker.
- `tool/build_release.sh` — add the hardening flags.
- `change_log/<timestamp>_phase3_ci_hygiene_release_script.md` — new.

## Plan for the fix

1. **Dependabot** — `.github/dependabot.yml`:
   ```yaml
   version: 2
   updates:
     - package-ecosystem: "pub"
       directory: "/"
       schedule:
         interval: "weekly"
     - package-ecosystem: "github-actions"
       directory: "/"
       schedule:
         interval: "weekly"
   ```
   (`gradle` is optional; left out — Android toolchain versions come from the Flutter migrator,
   §5.3.)
2. **CI** — in `ci.yml` add, at the top level, `permissions: contents: read`, and a step after
   "Run tests": `bash tool/check_sanskrit_hindi_markers.sh`. Keep the existing steps (checkout,
   Flutter 3.47.6 pinned, pub get, format check, analyze, test). Nothing else is added.
3. **Gate script** — `tool/check_sanskrit_hindi_markers.sh` with the pack's pattern, file search,
   self-test and exit codes. Run it locally (Git Bash) to check it passes. If it finds a marker,
   fix the Sanskrit text and list it in the change log as "needs native-reader review".
4. **Dart gate test** — update the regex in `l10n_parity_test.dart` to the pack's full word list,
   so the local `flutter test` and CI give the same answer. Rename the test reason to cite the
   language pack §4.1 instead of the old "§8.5.1".
5. **`.gitignore`** — add the §20.4 patterns under a "Build output" and a "Signing material"
   heading. Keep all existing lines.
6. **Lints** — add the four rules; run `flutter analyze`; fix every new hit (expected to be small,
   mechanical changes such as `Container(decoration:)` → `DecoratedBox`). If the number of hits
   is large (more than about 30 files), stop and report before fixing.
7. **Release script** — read the version from `pubspec.yaml` and build with the flags:
   ```bash
   VERSION=$(grep -E '^version:' pubspec.yaml | awk '{print $2}')
   SYMBOLS_DIR="build/symbols/android-prod-${VERSION}/"
   flutter build "$TARGET" --flavor prod --release \
     --obfuscate --split-debug-info="$SYMBOLS_DIR" \
     --dart-define=BUILD_DATE="$BUILD_DATE"
   ```
   For `apk`, also pass `--split-per-abi` (§5.6: no universal release APK). Print the symbols
   folder at the end and remind to archive it. The script is not run in this phase (no release
   build); it is checked with `bash -n`.
8. **Verify** — `dart format --output=none --set-exit-if-changed .`, `flutter analyze`,
   `flutter test`, and the gate script. No Gradle build is run in this phase.

## Out of scope

- Any other CI job (release builds, signing, uploads) — not allowed (§19.3).
- Gradle Dependabot entry.
