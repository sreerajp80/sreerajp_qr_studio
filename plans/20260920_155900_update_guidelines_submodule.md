# Update `docs/guidelines` submodule

**Status:** completed

## Files to be changed

- `docs/guidelines` (submodule pointer recorded in the parent repository)

No application source code, test, or documentation file in this repository is modified.

## What the issue is

The `docs/guidelines` submodule (`Flutter_Guidelines`) is currently pointing to commit `7ed5a36`.
The upstream remote `origin/master` has advanced with 1 new commit:
- `eb4b462` — Updates (guidelines update for localized app metadata and Sanskrit language rules)

Because the local pointer is behind, this repository is referencing an older guidelines commit.

## Plan for the fix

1. Fast-forward the `docs/guidelines` submodule to `origin/master` (`eb4b4629e4e0c849d5e60176daa8bb3f1509a6cd`).
2. Verify that the submodule working tree is clean.
3. Verify that `flutter analyze` and `flutter test` still pass cleanly.
4. Stage the submodule pointer update in the parent repository (`git add docs/guidelines`).
5. Create the corresponding change log file in `change_log/`.

## Risk

Very low. Only the git submodule reference pointer is updated.
