# Let the CodeForge style-editor chip rows wrap, and rework the link safety banner

**Status:** completed

Follows the open note in
[20261010_210523_gap_analysis_fixes.md](20261010_210523_gap_analysis_fixes.md)
and [change_log/20261010_214644_gaps_10_12_fixes.md](../change_log/20261010_214644_gaps_10_12_fixes.md).

## Issue

In the CodeForge style editor (`_buildDesignStudio` in
`lib/screens/code_forge_screen.dart`), four groups of choice chips sit in a
plain `Row`. A `Row` never moves items to a second line, so when the chips
are wider than the card they spill past the right edge. Flutter then shows
a yellow-and-black overflow stripe and the last chip is cut off or cannot be
tapped.

| Group (section header) | Chips |
| ---------------------- | ----- |
| Eye shape (`codeForgeEyeShape`) | 4 |
| Eye ball shape (`codeForgeEyeBallShape`) | 4 |
| Error correction (`codeForgeErrorCorrection`) | 4 — "L (7%)", "M (15%)", "Q (25%)", "H (30%)" |
| Center badge (`codeForgeCenterBadge`) | 3 |

This is most likely on narrow phones (about 360 dp wide), with a large
system font size, and in Malayalam or Sanskrit, where the labels are longer.
The widget test already showed these four rows overflowing, so today
`test/screens/code_forge_screen_test.dart` has to ignore overflow errors
(`ignoreOverflowErrors()` in `test/helpers/test_app.dart`).

The other chip groups in the same section (pattern shape, colour studio
gradients, colour palettes) are inside a sideways-scrolling
`SingleChildScrollView`, so they cannot overflow. They are not changed.

## Fix

- In `_buildDesignStudio`, replace each of the four `Row`s with a `Wrap`
  (`spacing: 6`, `runSpacing: 6`) and remove the `SizedBox(width: 6)`
  spacers between chips. When the chips fit, they look the same as today in
  one line; when they do not fit, the extra chips move to a second line.
- No change to chip labels, order, selection logic, or the provider.
- No new translation keys.

## Tests

- `test/screens/code_forge_screen_test.dart`:
  - Remove the `ignoreOverflowErrors()` call, so any overflow fails the test
    again.
  - New test at phone size (360 × 800 dp) in English, Malayalam and
    Sanskrit: open CodeForge, scroll through the whole style editor, and
    check that there is no exception (no overflow), and that every chip in
    the four groups can be found and tapped.
- `test/helpers/test_app.dart`: remove `ignoreOverflowErrors()`; nothing
  else uses it.
- If the phone-size test shows an overflow somewhere **other** than these
  four chip rows, I will stop, list it, and ask before changing it.

## Added after approval: link safety banner (user chose option A)

**What was found.** While the chip-row change was being tested at phone
width (360 dp), English passed, but Malayalam and Sanskrit failed on a
different row: the CodeForge **link safety banner** (`_buildSafetyBanner`,
shown when the QR code holds a web link). It overflows by 68 px
(Malayalam) and 82 px (Sanskrit). The four chip rows themselves no longer
overflow in any language.

**Why.** One key, `codeForgeVerifySafety` ("Link Safety Check"), is used for
both the banner text and the button, so the same long words appear twice
side by side. The button keeps its full width and pushes the row off the
screen. Also, when a check finds problems, the banner goes back to the
"not checked" look, so the user is never told the link failed.

**Fix — new wording and four clear states.**

| State | Icon | Banner text | Button |
| ----- | ---- | ----------- | ------ |
| Not checked | shield | `codeForgeSafetyPrompt` | `codeForgeSafetyCheckButton` |
| Checking | shield | `codeForgeSafetyPrompt` | small spinner |
| Safe | green tick | `codeForgeSafeVerified` (existing) | none |
| Problems found | orange warning | `codeForgeSafetyProblems(count)` | `codeForgeSafetyCheckAgain` |

New keys (and their `@key` descriptions in `app_en.arb`):

| Key | English | Malayalam | Sanskrit |
| --- | ------- | --------- | -------- |
| `codeForgeSafetyPrompt` | Check this link before you share it | പങ്കിടുന്നതിന് മുമ്പ് ഈ ലിങ്ക് പരിശോധിക്കുക | वितरणात् पूर्वं सम्बन्धः परीक्ष्यताम् |
| `codeForgeSafetyCheckButton` | Check | പരിശോധിക്കുക | परीक्ष्यताम् |
| `codeForgeSafetyProblems` | {count, plural, =1{1 problem found in this link} other{{count} problems found in this link}} | {count, plural, =1{ഈ ലിങ്കിൽ 1 പ്രശ്നം കണ്ടെത്തി} other{ഈ ലിങ്കിൽ {count} പ്രശ്നങ്ങൾ കണ്ടെത്തി}} | {count, plural, =1{अस्मिन् सम्बन्धे 1 दोषः प्राप्तः} other{अस्मिन् सम्बन्धे {count} दोषाः प्राप्ताः}} |
| `codeForgeSafetyCheckAgain` | Check again | വീണ്ടും പരിശോധിക്കുക | पुनः परीक्ष्यताम् |

- `codeForgeVerifySafety` is then unused and is removed from all three ARB
  files. `codeForgeSafeVerified` stays as it is.
- Button labels stay within 22 characters; the Sanskrit check must pass.
- `CodeForgeProvider` gets `safetyIssueCount` (number of checks that did not
  pass; skipped checks count as passed, as today). No change to how the
  checks run.
- Tests:
  - `test/providers/code_forge_provider_test.dart`: `safetyIssueCount` with a
    fake service (0 when all pass, 2 when two fail).
  - `test/screens/code_forge_screen_test.dart`: the banner shows the right
    text and button in each state (not checked, safe, problems found), using
    a fake `CodeForgeService`; and the 360 dp test passes in all three
    languages with no overflow anywhere.

Extra files for this part: `lib/providers/code_forge_provider.dart`,
`lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, `lib/l10n/app_sa.arb`,
`lib/l10n/gen/*`, `test/providers/code_forge_provider_test.dart`.

## Files to be changed

- `lib/screens/code_forge_screen.dart`
- `test/screens/code_forge_screen_test.dart`
- `test/helpers/test_app.dart`
- `plans/20261010_210523_gap_analysis_fixes.md` (mark the chip-row note as
  handled by this plan)
- New change log in `change_log/`

## How it will be checked

- `dart format .`, `flutter analyze` (must be clean), `flutter test` (all
  must pass).
- A visual check on a real phone is still a good idea, but nothing will be
  installed on the phone without asking.
