# Update the docs/guidelines submodule to 1f728b9

**Status:** completed

## What the issue is

The `docs/guidelines` submodule (the shared Flutter Guidelines repository) is pinned to
`3f1aa0b`. The guidelines repository now has 5 newer commits:

| Commit    | Summary                                                              |
| --------- | -------------------------------------------------------------------- |
| `d3e5041` | Flutter 3.47 / Dart 3.13 / AGP 9 toolchain; "latest stable" wording; generic, multi-platform guidelines |
| `519e7f3` | Critical review: fixes errors, contradictions and unclear wording    |
| `bf8ab85` | Built-in Kotlin notes for Flutter 3.47+ / AGP 9+                     |
| `0607386` | Make the guidelines submodule strictly read-only for projects        |
| `1f728b9` | GitHub CI does only analyze/test checks, plus Dependabot             |

The user asked for the pointer to be moved to the newest commit, as a one-time exception to
the "read-only submodule" rule (the user normally does this themselves).

## Files to be changed

- `docs/guidelines` — submodule pointer only (`3f1aa0b` → `1f728b9`). No file inside the
  submodule is edited.
- `change_log/20261012_<time>_update_guidelines_submodule.md` — new change log.
- `plans/20261012_191456_update_guidelines_submodule.md` — this plan (status updates only).

## Plan for the fix

1. Check out `1f728b9` inside `docs/guidelines` (`git submodule update --remote docs/guidelines`
   or `git -C docs/guidelines checkout 1f728b9`).
2. Check that every `docs/guidelines/...` link in `CLAUDE.md` and `AGENTS.md` still points to
   a file that exists. (A first look shows they all still exist.)
3. Quick check of the new rules against this project. Report any gaps to the user; **do not
   fix them in this change** — each gap gets its own plan later. Already checked:
   - Built-in Kotlin: `android/gradle.properties` already has `android.builtInKotlin=true`
     and `android.newDsl=false`, so it matches `bf8ab85`.
   Still to check: the read-only submodule wording in the new CLAUDE.md / AGENTS.md
   templates, the CI rule from `1f728b9` (analyze/test + Dependabot only), and the new
   files (`AI_AGENT_START_HERE.md`, `platform_store_readiness.md`, `PROJECT_PROFILE_TEMPLATE.md`,
   `language_packs/`, `profiles/`).
4. Stage only the `docs/guidelines` pointer, the change log and this plan. Commit only if the
   user asks.
5. Write the change log and set this plan to `completed`.

No code changes, so no build, `flutter analyze` or `flutter test` run is needed.

## Out of scope

- Any edit to files inside `docs/guidelines`.
- Changes to `CLAUDE.md`, `AGENTS.md`, CI files or app code to follow the new guidelines.
  These come as separate plans, if needed.
