# Guidelines compliance roadmap (after the 1f728b9 guidelines update)

**Status:** completed

## What the issue is

The `docs/guidelines` submodule moved to `1f728b9`
([plans/20261012_191456_update_guidelines_submodule.md](20261012_191456_update_guidelines_submodule.md)).
The new guidelines add and tighten many rules. The project was checked against
`AI_AGENT_START_HERE.md`, `DOCS_FOLDER_GUIDELINE.md`, `CLAUDE_MD_GUIDELINE.md`, `guideline.md`,
the engineering standard, the Sanskrit/Malayalam language pack, and `platform_store_readiness.md`.

The guidelines say an existing app should "migrate toward the guidelines in small, separately
approved plans" and "not mix migration with feature work" (`AI_AGENT_START_HERE.md` §4). So this
file is a **roadmap**. Each phase below gets its own detailed plan, its own approval, and its
own change log. Approving this roadmap approves only the order and scope, not the code changes.

## Gaps found

Reference: `ES` = `docs/guidelines/flutter_project_engineering_standard.md`,
`LP` = `docs/guidelines/language_packs/sanskrit_malayalam.md`.

### A. Docs and agent files

| # | Gap | Rule |
|---|---|---|
| A1 | No `docs/PROJECT_PROFILE.md` | ES §1.2.1, DOCS §6 (MUST) |
| A2 | `docs/GUIDELINES_MANIFEST.md` is an old copy; must be the submodule copy, unchanged | DOCS §1 |
| A3 | `CLAUDE.md` / `AGENTS.md` miss workflow rule 4 (read-only submodule) and rule 5 (CI = checks + Dependabot) | CLAUDE_MD §5, §8 |
| A4 | `CLAUDE.md` / `AGENTS.md` docs table misses `PROJECT_PROFILE.md`, `guideline.md`, `platform_store_readiness.md`; identity table misses "Stores / channels"; localization rules still call the three languages a "mandatory standard" and the badge "fixed" (now: declared in the profile; badge optional, on if the profile says so); cite the old `§8.5.x` numbers instead of the language pack; no `material_ui` rule | CLAUDE_MD §4 |
| A5 | Symbols path is `build/symbols/android-prod/`; must be `build/symbols/android-prod-<version>/` (in `CLAUDE.md`, `AGENTS.md`, `README.md`, `docs/release_process.md`) | ES §19.3 |
| A6 | `docs/release_process.md`, `docs/security.md`, `docs/architecture.md` do not follow the new template sections (e.g. security §8 Binary Protections, §12 OWASP, §13 Data retention; release §6 Hardening, §9 Android steps; architecture §5 Init sequence, §17 Logging, §20/§21) | DOCS §2, §6; ES §4.5, §15.4 |
| A7 | No `CHANGELOG.md` (recommended; the upgrade steps write to it) | ES §21.2, §5.3 |
| A8 | `docs/feature_analysis_and_roadmap.md`, `docs/feature_improvements_and_roadmap.md`, `docs/features.md` are not recognized doc types and lack the standard anatomy | DOCS §4, §7, §8 |

### B. CI and repository hygiene

| # | Gap | Rule |
|---|---|---|
| B1 | No `.github/dependabot.yml` (`pub` + `github-actions`) | ES §19.2 (MUST) |
| B2 | `ci.yml` has no `permissions: contents: read` | ES §19.1 |
| B3 | CI does not run the Sanskrit Hindi-marker gate script (the Dart test has an older pattern and does not check `app_config.json` or assets) | LP §4.1, ES §19.1 |
| B4 | `.gitignore` misses `*.apk`, `*.aab`, `*.p12`, `*.pfx`, `*.p8`, and the other listed artifact/signing patterns | ES §20.4 |
| B5 | `analysis_options.yaml` misses `use_decorated_box`, `avoid_bool_literals_in_conditional_expressions`, `noop_primitive_operations`, `use_enums` | ES §16.1 |

### C. Release hardening

| # | Gap | Rule |
|---|---|---|
| C1 | `tool/build_release.sh` builds **without** `--obfuscate --split-debug-info` | ES §15.1, guideline §2.4 (MUST) |

### D. App foundations (code)

| # | Gap | Rule |
|---|---|---|
| D1 | 104 files import `package:flutter/material.dart`; no `material_ui` / `cupertino_ui` dependency | ES §6.1, guideline §4 (MUST) |
| D2 | No `AppFlavorConfig` (two-variable `APP_FLAVOR` / `FLUTTER_APP_FLAVOR`) | ES §5.2 (MUST) |
| D3 | No `AppLogger`; 36 `debugPrint` calls in committed code | ES §14.2, §14.3 |
| D4 | No global error handlers (`FlutterError.onError`, `PlatformDispatcher.instance.onError`, release `ErrorWidget.builder`) | ES §11.1 (MUST) |
| D5 | `main()` does not follow the init order (logging → handlers → … → config + saved language before first frame); `main.dart` holds the route table and theme wiring | ES §3.2, §4.5, §8.4 |
| D6 | Fallback delegates are `Sa*`-only names; the template names `kFrameworkFallbackLanguages`; `supportedLocales` is a hand-written list instead of `AppLocalizations.supportedLocales`; delegates should use `...GlobalMaterialLocalizations.delegates` from `material_ui` | ES §8.1, §8.3.1 |

### E. Database

| # | Gap | Rule |
|---|---|---|
| E1 | History DB has no `onConfigure` with `PRAGMA foreign_keys = ON` and `journal_mode=WAL` | ES §13.2, §13.4 |
| E2 | No versioned migration map (`onCreate` builds the table directly; no `onUpgrade`) and no migration test | ES §13.1, §18.2 |

### F. Localization tests and rules

| # | Gap | Rule |
|---|---|---|
| F1 | Parity test lacks: "no value is a copy of the template", `{heart}` badge marker, `app_config.json` per-language check, content-asset parity | ES §8.7 |
| F2 | No label-length test (≤ 20 en, ≤ 22 ml/sa) | ES §8.6, LP §5 |
| F3 | No tooltip check helper run in screen tests in every locale | ES §7.8 |
| F4 | No widget test that opens a date picker and a dialog under `sa` | ES §8.3.1, LP §1.1 |
| F5 | **1035 of 1213 ARB keys** do not use the standard prefixes (`action…`, `label…`, `title…`, `tab…`, `nav…`, `tooltip…`, `desc…`, `help…`, `empty…`, `error…`, `body…`, `aboutDetail…`) | ES §8.6 |

### G. Security and product

| # | Gap | Rule |
|---|---|---|
| G1 | No user "Delete all data" action (database, logs, cache, secure storage); only "Clear history" | ES §15.4 (MUST) |
| G2 | No Android monochrome icon layer (SHOULD); dev flavor icon not visibly different (SHOULD) | ES §17.5 |
| G3 | History field encryption uses AES-CBC with a fixed IV, falls back to plain text on failure, can lose its key, and has no format version (found in Phase 6, added 2026-10-12) | ES §15.2 (MUST under Sensitive Data) |
| G4 | Screenshot protection (`FLAG_SECURE`) claimed in the UI but not set; UI also claims biometric protection of history; release builds fall back to the debug key; no `proguard-rules.pro` (found in Phase 9, added 2026-10-12) | ES §15.2, release_process §6.2, §7 |

Already met (no work): built-in Kotlin and `newDsl=false`; `kotlin { compilerOptions }`;
`ExecOperations`; `enableSplit = false`; `allowBackup="false"`; localized `@string/app_name`;
font fallback chain for Malayalam and Devanagari; About config with `load()` + `loadAndVerify()`;
in-app language picker; `formattingLocale` test exists.

## Plan for the fix — phases

Each phase = one plan, one approval, one change log. Run `flutter analyze` and `flutter test`
after every code phase. Stop the Gradle daemons after any build.

1. **Phase 1 — Project profile (A1).** Draft `docs/PROJECT_PROFILE.md` from the template using
   what the code shows. Ask the user to confirm the open choices (see questions below).
2. **Phase 2 — Agent files and manifest (A2, A3, A4, A5).** Copy the submodule manifest; update
   `CLAUDE.md` and `AGENTS.md` together (they must stay in step); fix the symbols path in
   `README.md` and `docs/release_process.md`.
3. **Phase 3 — CI, hygiene, release script (B1–B5, C1).** Add `dependabot.yml`; add permissions
   and the Hindi-gate step to `ci.yml`; extend `.gitignore` and lints (fix any new lint hits);
   add `--obfuscate --split-debug-info=build/symbols/android-prod-<version>/` to
   `tool/build_release.sh`.
4. **Phase 4 — `material_ui` migration (D1, D6 imports).** Run
   `dart fix --apply --code=migrate_design_widgets`, set caret constraints, re-run tests.
   Mechanical change, kept on its own.
5. **Phase 5 — Foundations (D2–D6).** `AppFlavorConfig`, `AppLogger` (replace all `debugPrint`),
   global error handlers + `SafeErrorFallback`, init order in a startup service, thin
   `main.dart`, fallback delegates in the template shape.
6. **Phase 6 — Database (E1, E2).** `onConfigure` pragmas, migration map at version 1 (no schema
   change), migration test. Document schema version in `docs/architecture.md`.
6b. **Phase 6b — History encryption upgrade (G3).** AES-256-GCM with a random nonce per field
    and a format version; no plain-text fallback; safe key handling; one-time re-encryption of
    existing rows. Added on 2026-10-12 with the user's approval.
7. **Phase 7 — Localization tests (F1–F4).** Add the missing tests; fix any string they flag
   (new translations listed as "needs native-reader review").
8. **Phase 8 — Delete all data and icons (G1, G2).** New Settings action with confirmation, in
   all three languages; monochrome icon layer; dev icon badge.
9. **Phase 9 — Docs to new templates (A6, A7, A8).** Restructure `architecture.md`,
   `security.md`, `release_process.md`; add `CHANGELOG.md`; decide what to do with the three
   feature/roadmap docs.
9b. **Phase 9b — Sensitive-data and release-build controls (G4).** `FLAG_SECURE`, correct the
    UI claims, fail release builds without `key.properties`, add `proguard-rules.pro`. Added on
    2026-10-12 with the user's approval.
10. **Phase 10 — ARB key prefix rename (F5).** Rename about 1035 keys in all three ARB files and
    every Dart use. Very large; done last, in batches by screen.

## User decisions (2026-10-12)

- Profiles in force: `Core Baseline` + `Production App Extension` + `Sensitive Data Extension`.
- Distribution channels: Google Play (`.aab`) and direct download (split APKs).
- Signature badge: on, with the current text.
- Phase 10 (key rename): do it, last, in batches.
- Still open for Phase 1: the public support contact and the privacy policy URL to list in the
  profile.

## Files to be changed (across all phases)

`docs/PROJECT_PROFILE.md` (new), `docs/GUIDELINES_MANIFEST.md`, `CLAUDE.md`, `AGENTS.md`,
`README.md`, `docs/release_process.md`, `docs/security.md`, `docs/architecture.md`,
`docs/project_structure.md`, `docs/dependencies.md`, `CHANGELOG.md` (new),
`.github/dependabot.yml` (new), `.github/workflows/ci.yml`, `tool/` (new Hindi-gate script),
`tool/build_release.sh`, `.gitignore`, `analysis_options.yaml`, `pubspec.yaml`, `pubspec.lock`,
`lib/main.dart`, `lib/core/` (new flavor, logging, error and startup files), all `lib/**` files
with Material imports, `lib/l10n/*` (fallback delegates, ARB files),
`lib/services/history_database_service.dart`, settings screen/provider/service for "Delete all
data", `android/app/src/main/res/` (icon layers), `test/**` (new and updated tests).

Not changed: anything inside `docs/guidelines/` and `native/zxing-cpp/`.
