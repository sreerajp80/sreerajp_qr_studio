# Update docs/guidelines submodule

**Status:** completed

## Issue

The `docs/guidelines` submodule is at `eb4b462`. The upstream `master` branch has two newer commits:

- `5fed66b` Add Contact, Call, Tag and Phone number to the 8.5.4 glossary
- `3f1aa0b` Merge pull request #1 (same change)

Upstream changes (docs only, 76 lines added):

- `flutter_project_engineering_standard.md` — 8 new glossary lines in §8.5.4.
- One new plan file and one new change log file inside the submodule.

## Files to change

- `docs/guidelines` (submodule pointer: `eb4b462` → `3f1aa0b`)

## Plan

1. Fast-forward the submodule to `origin/master` (`3f1aa0b`).
2. Stage the new submodule pointer in the parent repo.
3. Do not commit unless the user asks. The parent repo has many other unrelated uncommitted changes.
4. Write a change log in `change_log/`.

No app code changes. No build or test impact.
