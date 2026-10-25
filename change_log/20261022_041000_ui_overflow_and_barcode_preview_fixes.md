# Change log: CodeForge 1D preview and text overflow fixes

Implements plan: [plans/20261022_035223_ui_overflow_and_barcode_preview_fixes.md](../plans/20261022_035223_ui_overflow_and_barcode_preview_fixes.md)

Fixes the 3 bugs found by the tests added in
[20261022_035000_project_gap_fixes.md](20261022_035000_project_gap_fixes.md).

## Bug 1 — CodeForge 1D barcode preview

`lib/widgets/code_forge_barcode_widget.dart`:

- `barcode.make(...)` now gets `fontHeight: size.height * 0.2` and
  `textPadding: size.height * 0.05`, the same defaults `toSvg` uses. Code 128, EAN-13,
  EAN-8, UPC-A and Code 39 previews now draw their bars and the digits under them, in debug
  and release builds.
- The `catch` no longer hides failures: it logs a warning with `AppLogger`. Only the error
  type is logged, because the error message may quote the user's data.

## Bug 2 — camera adjustments sheet overflow

`lib/widgets/camera_adjustments_sheet.dart`:

- **Header:** now a `Wrap`. The title and the Reset button share one line when they fit;
  otherwise Reset moves under the title. Both texts can use up to 2 lines and end with "…".
  - This differs from the plan's first idea (an `Expanded` title). On a 360-wide screen the
    Reset label alone ("Reset Adjustments", and longer in Malayalam) left no room for the
    title, so shrinking only the title was not enough. The plan file records this.
- **Slider label rows** (Brightness, Contrast, Distance zoom, Sharpen strength): each label
  is now `Flexible` with up to 2 lines, and the value text ("+10%", "1.5x") keeps its size.
  These rows overflowed with large text in the same way. The user approved adding them to
  this plan in chat; the plan file records this.

## Bug 3 — multi-code box label overflow

`lib/screens/widgets/multi_code_bounding_box_widget.dart`: the label in the pill under each
detected code is now `Flexible`, on 1 line, and ends with "…". Short labels look the same as
before.

## Tests

- `test/widgets/code_forge_barcode_widget_test.dart`: every barcode type is drawn with the
  text label on and off. 1D types with the label on must also draw text; with it off, no
  text is drawn.
- `test/widgets/camera_adjustments_sheet_test.dart`: back to a 360-wide phone view in all
  three languages, plus a 2× text case in every language with distance mode on, so all slider
  rows are checked.
- `test/screens/widgets/multi_code_bounding_box_widget_test.dart`: back to a 160-wide box,
  plus a very long label in an 80-wide box.
- The "reported separately" workarounds are removed.

## Other

- `CHANGELOG.md` → Unreleased → Fixed: two new lines.
- No ARB changes (no new text).

## Checks

- `dart format` (0 files changed), `flutter analyze` (no issues), `flutter test` (all 883
  pass).
- No Gradle build was run. Nothing was installed on a phone.
- Not checked on a real phone. The text-size checks use the test font, which is wider than
  real fonts, so real screens have more room than the tests.
