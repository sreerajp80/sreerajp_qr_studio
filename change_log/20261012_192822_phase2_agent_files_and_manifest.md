# Phase 2 — Update CLAUDE.md, AGENTS.md, the manifest and the symbols path

Plan: [plans/20261012_192518_phase2_agent_files_and_manifest.md](../plans/20261012_192518_phase2_agent_files_and_manifest.md)
Roadmap: [plans/20261012_191914_guidelines_compliance_roadmap.md](../plans/20261012_191914_guidelines_compliance_roadmap.md) (gaps A2–A5)

## What changed

- **`docs/GUIDELINES_MANIFEST.md`** — replaced with an exact copy of
  `docs/guidelines/GUIDELINES_MANIFEST.md` (checked byte for byte). Nothing inside the submodule
  changed.
- **`CLAUDE.md` and `AGENTS.md`** (same content; only the tool-name lines differ):
  - Identity table: new "Stores / channels" row; `compileSdk 37`; pinned Flutter 3.47.6 and
    Dart 3.13.5; languages and platforms point to `docs/PROJECT_PROFILE.md`.
  - Docs table: added `docs/PROJECT_PROFILE.md`, `AI_AGENT_START_HERE.md`, `guideline.md`, the
    Sanskrit/Malayalam language pack, and `platform_store_readiness.md`; added the
    template-vs-reference note.
  - Architecture: the About badge is "on, per the profile" instead of "fixed".
  - Build commands: symbols path `build/symbols/android-prod-<version>/`; full `appbundle`
    command with `--obfuscate --split-debug-info`; notes on bare `flutter run`, `<version>`,
    store gates, and local-only release builds.
  - Flavors note: never pass `FLUTTER_APP_FLAVOR` with `--dart-define`.
  - Signing: `.gitignore` line, offline backup, link to `guideline.md` §2.
  - Localization rules rewritten to the new template: declared languages from the profile; real
    translations in every file; language pack rules (Hindi-marker gate, Malayalam quality,
    native-reader review); `supportedLocales`, fallback delegates, `formattingLocale(...)`;
    picker with endonyms; label budget (20 en / 22 ml, sa) by key prefix; tooltips;
    `material_ui` / `cupertino_ui` rule (existing imports move in Phase 4); About badge.
  - Workflow rules 4 (read-only guidelines submodule) and 5 (CI = checks + Dependabot only).
  - Always/never: read the profile; never change `docs/guidelines/`; never add release work or
    secrets to CI.
- **`README.md`** — symbols path with `<version>`; the AAB command now has
  `--obfuscate --split-debug-info` too (it had none); `<version>` explained.
- **`docs/release_process.md`** — symbols path with `<version>` in the flavor table, the
  hardening note (with the `<version>` explanation) and the checklist.

## Checks

- `CLAUDE.md` vs `AGENTS.md`: only the 7 tool-name spots differ.
- Every `docs/...` link in both files points to a file that exists.
- Self-check lists of `CLAUDE_MD_GUIDELINE.md` §8 and `AGENTS_MD_GUIDELINE.md` §9 walked; all
  items now present.
- No code changed, so no build, analyze or test run was needed.
