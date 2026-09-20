# Change log — Update `docs/guidelines` submodule

Implements plan: `plans/20260920_155900_update_guidelines_submodule.md`

## What changed

- `docs/guidelines` submodule pointer moved from `7ed5a36` to `eb4b462` (branch `master`).
- No app source, test, asset, or build configuration file was modified.

## What came in

Upstream commit from `Flutter_Guidelines`:
- `eb4b462` Updates

Notable guideline updates include:
- `guideline.md`: Clarified that `appName`, `author`, `aiUsed`, and `ideUsed` in `app_config.json` must use localized language maps for display values.
- `AGENTS_MD_GUIDELINE.md` and `CLAUDE_MD_GUIDELINE.md`: Re-emphasized explicit tri-lingual localization requirements across English (`en`), Malayalam (`ml`), and Sanskrit (`sa`).

## Verification

- `git submodule status` reports `eb4b4629e4e0c849d5e60176daa8bb3f1509a6cd docs/guidelines (heads/master)`.
- Submodule work tree is clean and up to date with `origin/master`.
- `flutter analyze` completed with 0 warnings/errors.
- `flutter test` passed with all 349 tests passing.
