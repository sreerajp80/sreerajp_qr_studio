# Phase 2 — Update CLAUDE.md, AGENTS.md, the manifest and the symbols path

**Status:** completed

Part of [plans/20261012_191914_guidelines_compliance_roadmap.md](20261012_191914_guidelines_compliance_roadmap.md)
(gaps A2, A3, A4, A5).

## What the issue is

1. `docs/GUIDELINES_MANIFEST.md` is an old copy. `DOCS_FOLDER_GUIDELINE.md` §1 says it is copied
   in **unchanged** from the guideline set; the new copy adds the read-only submodule rule,
   `AI_AGENT_START_HERE.md`, the project profile, store readiness and language packs.
2. `CLAUDE.md` and `AGENTS.md` do not match the new `CLAUDE_MD_GUIDELINE.md` /
   `AGENTS_MD_GUIDELINE.md` templates and self-checks:
   - Workflow rule 4 (the `docs/guidelines/` submodule is read-only) is missing.
   - Workflow rule 5 (CI = checks + Dependabot only; release builds are local) is missing.
   - The docs table has no `docs/PROJECT_PROFILE.md`, `docs/guidelines/guideline.md`,
     `docs/guidelines/platform_store_readiness.md`, the language pack, or
     `docs/guidelines/AI_AGENT_START_HERE.md`.
   - The identity table has no "Stores / channels" row; Flutter/Dart show `>=` ranges instead of
     the pinned versions from `flutter --version`.
   - Localization rules call the three languages a "tri-lingual mandatory standard" and cite
     old section numbers (`§8.5`, `§8.5.2`, `guideline.md §3`). The new rule: languages are
     declared in `docs/PROJECT_PROFILE.md`; Sanskrit/Malayalam rules come from the language pack.
     Missing rules: `supportedLocales` equals the declared languages; dates/numbers use
     `formattingLocale(...)`; the short-label budget by key prefix (Latin ≤ 20, ml/sa ≤ 22); the
     `material_ui` / `cupertino_ui` import rule; the About badge stated as "on, per the profile".
   - The signing section misses the `.gitignore` line and the pointer to `guideline.md` §2.
   - Production build commands have no `<version>` in the symbols folder, and there is no
     pointer to the store readiness gates.
3. The debug symbols folder must be `build/symbols/<platform>-<flavor>-<version>/` (engineering
   standard §19.3). `README.md` and `docs/release_process.md` use `build/symbols/android-prod/`.

## Files to be changed

- `docs/GUIDELINES_MANIFEST.md` — replace with an exact copy of
  `docs/guidelines/GUIDELINES_MANIFEST.md` (read only from the submodule; nothing inside the
  submodule changes).
- `CLAUDE.md` and `AGENTS.md` — same edits in both; only the tool name wording differs, as now.
- `README.md` — symbols path in the release build command.
- `docs/release_process.md` — symbols path in §5 table, the hardening note and the checklist.
- `change_log/<timestamp>_phase2_agent_files_and_manifest.md` — new.

## Plan for the fix

### 1. Manifest
Copy the submodule's `GUIDELINES_MANIFEST.md` over `docs/GUIDELINES_MANIFEST.md`, byte for byte.

### 2. `CLAUDE.md` and `AGENTS.md` (Thin style, canonical section order kept)

- **Identity table**: add `Stores / channels` = Google Play (`.aab`), direct download (split
  APKs); `Platforms` adds `compileSdk 37`; `Flutter SDK` = `3.47.6 (stable)`, `Dart SDK` =
  `3.13.5` (from `flutter --version`; `pubspec.yaml` constraints stay as they are); `Languages`
  = "en (template), ml, sa — declared in `docs/PROJECT_PROFILE.md`".
- **Docs table**: add rows for `docs/PROJECT_PROFILE.md` (always),
  `docs/guidelines/AI_AGENT_START_HERE.md`, `docs/guidelines/guideline.md`,
  `docs/guidelines/platform_store_readiness.md`,
  `docs/guidelines/language_packs/sanskrit_malayalam.md`; add the template note
  (`docs/<file>` = this app's copy; `docs/guidelines/<file>` = shared reference).
- **Architecture rules**: keep; change the About metadata line to say the badge is on per
  `docs/PROJECT_PROFILE.md` (`guideline.md` §1.7) instead of "fixed".
- **Build commands**: symbols path → `build/symbols/android-prod-<version>/` for both APK and
  AAB; show the full `appbundle` command with `--obfuscate --split-debug-info`; note that a bare
  `flutter run` fails because flavors are defined; point to
  `docs/guidelines/platform_store_readiness.md` §1–§2 before any release.
- **Signing**: add "`.gitignore` must include `android/key.properties`, `*.jks`, `*.keystore`
  and `build/`" and a link to `docs/guidelines/guideline.md` §2.
- **Localization rules**: rewrite to the template wording: declared languages from the profile;
  ARB via `AppLocalizations`; one ARB per declared language with real translations; `@key`
  descriptions; language pack in force (Sanskrit = pure Sanskrit, Hindi-marker gate; Malayalam =
  natural vocabulary and verb forms); flag unsure translations as "needs native-reader review";
  `supportedLocales` = declared languages, fallback delegate for `sa`; `formattingLocale(...)`;
  picker (System default + endonyms, `app_language`, no restart); short-label budget by key
  prefix; tooltips; `material_ui` / `cupertino_ui` with a caret constraint (existing imports are
  migrated in Phase 4); data-driven About with the badge on; allowed literals (keep the current
  project list).
- **Workflow rules**: add rule 4 (read-only submodule) and rule 5 (CI checks + Dependabot only),
  worded as in the template.
- **Always / never**: add "never change `docs/guidelines/`" and "never add release builds,
  signing or secrets to CI".
- Keep everything else (hard rules, security, testing, dependencies, tree) as it is, apart from
  adding `docs/PROJECT_PROFILE.md` to the tree comment line where useful.

### 3. Symbols path
Replace `build/symbols/android-prod/` with `build/symbols/android-prod-<version>/` in
`README.md` and `docs/release_process.md`, and say `<version>` is the full `pubspec.yaml`
version (e.g. `4.1.0+34`).

### 4. Checks
- Run a diff of `CLAUDE.md` vs `AGENTS.md`: only the tool-name lines may differ.
- Walk the §8 / §9 self-check lists of both guidelines.
- Check all links in the two files point to files that exist.
- No code changes, so no build, analyze or test run.

## Out of scope

- `tool/build_release.sh` flags — Phase 3.
- Restructuring `docs/release_process.md` to the new template — Phase 9.
