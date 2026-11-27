# Package upgrade (within constraints) and the gen-l10n analyzer notes

**Status:** completed

Follows `plans/20261127_220211_toolchain_upgrade_flutter_3_50_1.md` (Flutter 3.50.1).

## What the issue is

1. **Packages are behind.** `flutter pub outdated` shows 34 packages that can move to newer
   versions inside the current `pubspec.yaml` limits (for example `material_ui` 1.10.0 → 1.11.1,
   `file_picker` 13.3.2 → 13.4.1, `sqflite` 2.4.5 → 2.4.6, `pdfx` 2.11.0 → 2.11.1).
2. **Two major versions cannot be taken yet.** `pointycastle` 4.0.0 and `qr` 4.0.1 exist, but
   the "Resolvable" column stays at 3.9.1 / 3.0.3: other packages (for `qr`, likely
   `qr_flutter`) still need 3.x. So they stay as they are for now.
3. **`flutter analyze` is no longer clean (2 info notes).** Flutter 3.50.1 marks
   `GlobalMaterialLocalizations` and `GlobalCupertinoLocalizations` in `flutter_localizations` as
   deprecated, but its own `flutter gen-l10n` still writes them into the generated file
   `lib/l10n/gen/app_localizations.dart`. The file's `// ignore_for_file: type=lint` does not
   cover deprecation notes. Plain `flutter analyze` exits with code 1 on these, so the CI
   "analyze" step would fail.

All 926 tests pass on Flutter 3.50.1 before this change.

## Files to change

1. `pubspec.lock` — updated by `flutter pub upgrade` (not edited by hand).
2. `analysis_options.yaml` — add `lib/l10n/gen/**` to `analyzer: exclude:`.
3. `CHANGELOG.md` — one line under `[Unreleased]` → `Changed`: dependencies updated.

No change to `pubspec.yaml` constraints. No change to `docs/dependencies.md` (it lists
constraints, which stay the same).

## Plan for the fix

1. Run `flutter pub upgrade` (stays inside current constraints; no `--major-versions`).
2. Check the list of changed packages: no new direct dependency, and any new transitive
   package is noted in the change log with its source.
3. Add `lib/l10n/gen/**` to the analyzer exclude list.
4. Run `flutter analyze` (must be zero issues) and `flutter test` (must all pass).
5. Write the change log, also closing the toolchain plan's change log once checks pass.

### Why exclude the generated folder (and the other options)

- **A. Exclude `lib/l10n/gen/**` (recommended).** It is machine-made code that we never edit,
  and `flutter gen-l10n` rewrites it. Compile errors in it are still caught by `flutter test`
  and every build. Downside: any other analyzer note in that folder is also hidden.
- B. Turn off `deprecated_member_use` for the whole project — hides real deprecations in our
  own code. Rejected.
- C. Run CI with `--no-fatal-infos` — weakens the check for all code. Rejected.
- D. Edit the generated file by hand — it is overwritten on the next `gen-l10n`. Rejected.

When a later Flutter release makes `gen-l10n` write the `material_ui` names, the exclude can
be removed.

## Not in this plan

- `pointycastle` 4 and `qr` 4 major upgrades: blocked by other packages today. Revisit when
  `pub outdated` shows them as resolvable. `pointycastle` is used for encryption
  (StegoQR, passphrase cipher, TOTP), so that one needs its own plan and careful testing.
- A device build (`flutter build apk --flavor dev --debug`) is still to be run for the
  toolchain change.

## Security impact

Dependency versions change (patch and minor releases only, same pub.dev source). No new
direct dependency, no permission, network or storage change. The analyzer exclude covers
generated localization code only. Low risk.
