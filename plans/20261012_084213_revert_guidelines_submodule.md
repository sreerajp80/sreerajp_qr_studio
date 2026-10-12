# Save the new docs/guidelines submodule version in this project

**Status:** completed

## Issue

The `docs/guidelines` folder on disk is at Flutter_Guidelines commit `3f1aa0b`, the latest
version on GitHub. This project still has the older commit `eb4b462` saved as its submodule
version. Because the two differ, GitHub Desktop shows "Submodule changes".

(An earlier version of this plan would have reverted the folder. The user chose to keep the
new version instead.)

## Files to change

- `docs/guidelines` (submodule version saved in this project: `eb4b462` → `3f1aa0b`).
  No file inside the submodule is edited, and nothing is pushed to Flutter_Guidelines.
- `change_log/<timestamp>_commit_guidelines_submodule.md` (new change log).

## Fix

1. Stage the new submodule version: `git add docs/guidelines`.
2. Write the change log and stage it, together with this plan.
3. Commit in this project with a message like "Update docs/guidelines submodule to 3f1aa0b".
   Do not push.
4. Check that `git status` no longer lists `docs/guidelines` as changed.

## Notes

- After this, this project uses the new glossary words (Contact, Call, Tag, Phone number in
  §8.5.4).
- No app code, build, or test changes.
