# Change log — Update `docs/guidelines` submodule

Implements plan: `plans/20260913_204500_update-guidelines-submodule.md`

## What changed

- `docs/guidelines` submodule pointer moved from `2b381be` to `7ed5a36` (branch `master`).
- The updated pointer was staged in this repository.
- No app source, test, asset, or build configuration file was modified.

## What came in

Three upstream commits from `Flutter_Guidelines`:
- `7e664ba` Updates
- `8c4861a` Updates
- `7ed5a36` Updates

Notable guideline updates include:
- `flutter_project_engineering_standard.md`: Expanded engineering standards.
- `guideline.md`: General guideline improvements and clarifications.
- `release_process.md`: Expanded release procedure guidelines.
- `AGENTS_MD_GUIDELINE.md` and `CLAUDE_MD_GUIDELINE.md`: Updated assistant guidelines.
- Added recent plans and change logs in `docs/guidelines/`.

## Verification

- `git submodule status` reports `7ed5a367d7feee4abfa60cf3bc4b0c4f79262d35 docs/guidelines (heads/master)`.
- Submodule work tree is clean and up to date with `origin/master`.
- No extraneous files were touched.
