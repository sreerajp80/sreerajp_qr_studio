# Update the docs/guidelines submodule to 1f728b9

Plan: [plans/20261012_191456_update_guidelines_submodule.md](../plans/20261012_191456_update_guidelines_submodule.md)

This was a one-time exception to the read-only submodule rule. The user asked for it and
approved it.

## What changed

- `docs/guidelines` pointer moved from `3f1aa0b` to `1f728b9` (5 new upstream commits:
  `d3e5041`, `519e7f3`, `bf8ab85`, `0607386`, `1f728b9`). No file inside the submodule was
  edited.

## Checks done

- Every `docs/guidelines/...` link in `CLAUDE.md` and `AGENTS.md` still points to a file that
  exists.
- Built-in Kotlin (`bf8ab85`): already met. `android/gradle.properties` has
  `android.builtInKotlin=true` and `android.newDsl=false`.

## Gaps found (not fixed here — each needs its own plan)

1. **No `.github/dependabot.yml`.** Engineering standard §19.2 says every repository MUST have
   one, with `pub` and `github-actions` entries (`gradle` is optional).
2. **CI has no `permissions: contents: read`.** §19.1 asks for the least permissions. The steps
   in `.github/workflows/ci.yml` (format, analyze, test) are all allowed.
3. **`CLAUDE.md` / `AGENTS.md` lack the read-only submodule rule.** `CLAUDE_MD_GUIDELINE.md` now
   wants it written inline as workflow rule 4, with a checklist item for it.
4. **`CLAUDE.md` / `AGENTS.md` docs table does not list `platform_store_readiness.md`.** The new
   template lists it ("Before any release; when touching permissions…").

No code changed, so no build, analyze or test run was needed.
