# Fix 3 UI bugs found by the new tests

**Status:** completed

## Background

The tests added in [20261022_033000_project_gap_fixes.md](20261022_033000_project_gap_fixes.md)
found 3 small UI bugs (listed in
[change_log/20261022_035000_project_gap_fixes.md](../change_log/20261022_035000_project_gap_fixes.md)).
For now those tests avoid the broken cases. This plan fixes the bugs and makes the tests
check the real cases again.

Nothing in `docs/guidelines/` or `native/zxing-cpp/` is changed. No new text, so no ARB
changes.

## Bug 1 — CodeForge 1D barcode preview is blank, or its digits are invisible

**Issue:** `CodeForgeBarcodePainter.paint` calls
`barcode.make(data, width, height, drawText: config.includeTextLabel)` without a
`fontHeight`. `package:barcode` needs `fontHeight` when `drawText` is true:

- In debug and dev builds an assert fails. The painter's `catch (_)` hides it, so Code 128,
  EAN-13, EAN-8, UPC-A and Code 39 previews are **blank** when "text label" is on (the
  default).
- In release builds `fontHeight` becomes 0. The bars draw, but the digits under them get
  font size 0 and **cannot be seen**.

QR, PDF417 and Data Matrix are not affected. The SVG export is not affected either, because
`toSvg` fills in its own defaults.

**Fix** (`lib/widgets/code_forge_barcode_widget.dart`):

1. Pass `fontHeight: size.height * 0.2` and `textPadding: size.height * 0.05` to
   `barcode.make(...)` when the label is on. These are the same defaults `toSvg` uses, so
   the preview matches the exported SVG.
2. Keep the `try/catch`, but log a warning with `AppLogger` (no barcode data in the log), so
   a failure like this is no longer silent.

**Tests** (`test/widgets/code_forge_barcode_widget_test.dart`):

- Every barcode type paints bars **with the text label on** (the default).
- 1D types with the label on also paint the digits (the counting canvas counts text draws).
- Keep the label-off case and the "bad data paints only the background" case.
- Remove the "reported separately" comment.

## Bug 2 — camera adjustments sheet header can overflow

**Issue:** In `lib/widgets/camera_adjustments_sheet.dart`, the header is a `Row` holding
(icon + title) and the Reset button, with nothing allowed to shrink. A long title (Malayalam
or Sanskrit, a large system font size, or a narrow phone) overflows to the right and shows
the yellow-black overflow stripe.

**Fix:** Wrap the inner (icon + title) `Row` in `Expanded`, and the title `Text` in
`Flexible` with `maxLines: 2` and `overflow: TextOverflow.ellipsis`. The Reset button keeps
its size. Nothing changes on screens where it already fits.

**Change during work (approved by the user in chat):** on a 360-wide screen the Reset
button's label alone leaves no room for the title, so the header uses a `Wrap` instead:
title and Reset share one line when they fit, and Reset moves under the title when they
don't. With 2× text, the slider label rows (Brightness, Contrast, Distance zoom, Sharpen)
overflow the same way. These are fixed too, in the same file: each label `Text` is in
`Flexible` with up to 2 lines, and the value text keeps its size.

**Tests** (`test/widgets/camera_adjustments_sheet_test.dart`):

- Go back to a phone-sized view (360 wide) in all three languages, with no overflow.
- Add one case with a large text scale (2.0) in Malayalam, with no overflow.
- Remove the "reported separately" comment.

## Bug 3 — multi-code box label can overflow

**Issue:** In `lib/screens/widgets/multi_code_bounding_box_widget.dart`, the label pill under
each detected code is a `Row` (icon, label `Text`, icon) with nothing allowed to shrink. On a
small box (a far-away code) or with a long label, it overflows.

**Fix:** Wrap the label `Text` in `Flexible` with `maxLines: 1` and
`overflow: TextOverflow.ellipsis`. The pill keeps `mainAxisSize: MainAxisSize.min`, so short
labels look the same as now, and long ones end with "…". The pill is still centred under the
box and limited to the box's width.

**Tests** (`test/screens/widgets/multi_code_bounding_box_widget_test.dart`):

- Go back to a small box (160 wide), with no overflow in all three languages, selected and
  not selected.
- Add a case with a very long label in an 80-wide box: no overflow, and the label is still
  in the tree.
- Remove the "reported separately" comment.

## Files to be changed

- `lib/widgets/code_forge_barcode_widget.dart`
- `lib/widgets/camera_adjustments_sheet.dart`
- `lib/screens/widgets/multi_code_bounding_box_widget.dart`
- `test/widgets/code_forge_barcode_widget_test.dart`
- `test/widgets/camera_adjustments_sheet_test.dart`
- `test/screens/widgets/multi_code_bounding_box_widget_test.dart`
- `CHANGELOG.md` (one line under Unreleased → Fixed: barcode preview digits; text that no
  longer runs off the screen)
- `change_log/20261022_041000_ui_overflow_and_barcode_preview_fixes.md`

## Checks at the end

- `dart format`, `flutter analyze` (0 issues), `flutter test` (all pass).
- No Gradle build, and nothing is installed on a phone.
- Today's earlier gap-fix changes are still not committed. This plan does not commit
  anything unless you ask.
