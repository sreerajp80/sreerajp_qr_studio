# Change log: CodeForge chip rows wrap, link safety banner reworked

Implements plan: [plans/20261010_214723_codeforge_chip_row_wrap.md](../plans/20261010_214723_codeforge_chip_row_wrap.md)

Follows: [change_log/20261010_214644_gaps_10_12_fixes.md](20261010_214644_gaps_10_12_fixes.md)

## Result

- `flutter analyze`: no issues. `dart format`: clean.
- `flutter test`: all 582 tests pass.
- CodeForge has no overflow on a 360 dp phone in English, Malayalam or
  Sanskrit. The test no longer ignores overflow errors.

## Chip rows

- `lib/screens/code_forge_screen.dart` (`_buildDesignStudio`): the four chip
  groups — eye shape, eye ball shape, error correction, center badge — are
  now `Wrap` (`spacing: 6`, `runSpacing: 6`) instead of `Row`. The spacer
  boxes between chips were removed. Labels, order and behaviour are
  unchanged. The sideways-scrolling groups (pattern shape, gradients, colour
  palettes) were not changed.

## Link safety banner (added to the plan after approval, option A)

- Found by the new 360 dp test: the banner overflowed by 68 px (Malayalam)
  and 82 px (Sanskrit) because one long label was used for both the text and
  the button. When a check found problems, the banner also went back to its
  "not checked" look, so the user was never told.
- `_buildSafetyBanner` now has four states:
  - Not checked: shield icon, "Check this link before you share it", button
    "Check".
  - Checking: same text, small spinner.
  - Safe: green tick, "Verified Safe by 6-Layer Security Engine"
    (unchanged), no button.
  - Problems found: orange warning icon, "N problems found in this link",
    button "Check again".
- The button has a maximum width (120 dp), so a long label wraps inside it
  instead of pushing the row off screen. The banner text keeps the rest of
  the row. This was needed for the Malayalam "Check again"
  (വീണ്ടും പരിശോധിക്കുക), which overflowed by 40 px in the test.
- `lib/providers/code_forge_provider.dart`: new `safetyIssueCount` (checks
  that did not pass; skipped checks count as passed, as before).
- Translations: added `codeForgeSafetyPrompt`, `codeForgeSafetyCheckButton`,
  `codeForgeSafetyProblems` (plural), `codeForgeSafetyCheckAgain` in all
  three languages, with the wording approved in the plan. Removed the old
  shared key `codeForgeVerifySafety`. Parity kept (1213 keys each).

## Tests

- `test/screens/code_forge_screen_test.dart`:
  - `ignoreOverflowErrors()` removed; `pumpScreen` takes a screen size and
    an optional fake `CodeForgeService`.
  - New 360 dp test in all three languages: finds the 4 chip groups, taps
    all 15 chips, and checks there is no error.
  - New banner tests: not checked (prompt and "Check"), safe (verified text,
    no button), and problems found (count and "Check again") at 360 dp in
    all three languages.
- `test/providers/code_forge_provider_test.dart`: 3 new `safetyIssueCount`
  cases.
- `test/helpers/test_app.dart`: removed `ignoreOverflowErrors()`.

## Docs

- `docs/features.md`: CodeForge entry mentions the banner states and that
  style chips wrap on narrow screens.
- `plans/20261010_210523_gap_analysis_fixes.md`: the chip-row note now
  points to this plan.

## Not done

- No check on a real phone; nothing was installed on the device.
