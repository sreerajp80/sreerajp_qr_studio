# Revert docs/guidelines submodule to the committed version

**Status:** approval_pending

## Issue

The `docs/guidelines` submodule copy was moved from `eb4b462` to `3f1aa0b` by work in this
project (plan `plans/20260929_215247_update_guidelines_submodule.md`). The new pointer was
never committed. The project rules say the parent project must not change the submodule, so
this move should be undone.

## Files to change

- `docs/guidelines` (submodule checkout only, back to `eb4b462`). No file inside the
  submodule is edited, and nothing is pushed to the submodule's own repository.
- `change_log/<timestamp>_revert_guidelines_submodule.md` (new change log).

## Fix

1. Run `git submodule update docs/guidelines`. This checks out the commit that the parent
   project already has recorded (`eb4b462`).
2. Check that `git status` no longer lists `docs/guidelines` as changed.
3. Write the change log.

## Notes

- The submodule's local `master` branch label stays at `3f1aa0b`. After step 1 the submodule
  is on a "detached HEAD" at `eb4b462`, which is the normal state for a submodule.
- The glossary additions (Contact, Call, Tag, Phone number in §8.5.4) will no longer be in
  this project's copy of the guidelines. They stay in the Flutter_Guidelines repository.
- No app code, build, or test changes.
