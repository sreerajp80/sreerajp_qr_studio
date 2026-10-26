# Multi-code tap boxes stay on screen after the codes leave the view

**Status:** completed

## The issue

On the Scan tab, when the camera sees more than one code, the app shows the banner
"Multiple codes detected. Tap a code to scan." and a tap box over each code.

If the user then points the camera away (so no code is in view), the banner and all
the boxes stay on screen. They only go away when the user switches to another tab and
comes back.

## Why it happens

- `MultiCodeSelectionProvider` removes a box when its code has not been seen for
  1.5 seconds (`MultiCodeService.decayStaleBarcodes`). But this cleanup only runs inside
  `processCapture`, which runs only when a new camera frame arrives.
- The camera controller (`ScanCameraController._emit`) sends a frame to the screen only
  when at least one code was found. A frame with no codes is never sent.
- `ScannerScreen._handleBarcode` also returns early when the frame has no codes.
- So once all codes leave the view, no more frames come in, the cleanup never runs, and
  the boxes stay forever.

## The fix

Make the provider clean up stale boxes on its own clock, not only when a frame arrives.

1. In `MultiCodeSelectionProvider`:
   - Add a small repeating `Timer` (about every 250 ms) that runs only while multi-code
     mode is active (at least one box is shown).
   - Each tick removes boxes not seen for 1.5 s (the same rule as today). When no boxes
     are left, it turns multi-code mode off, stops the timer and notifies listeners, so
     the banner and boxes go away.
   - Start the timer in `processCapture` when multi-code mode turns on. Stop it in
     `dismiss()`, `reset()`, when disabled, and in `dispose()`.
   - It notifies listeners only when something actually changed, so it does not cause
     extra screen rebuilds.
2. Do not change the camera controller. It is shared with AirQR and AR CodeVision, and
   sending empty frames would change their behaviour too.

Result: about 1.5 s after the last code leaves the camera view, the banner and boxes
disappear and normal single-code scanning resumes.

## Files to change

- `lib/providers/multi_code_selection_provider.dart` — add the cleanup timer.
- `test/providers/multi_code_selection_provider_test.dart` — add tests (with `fakeAsync`)
  that boxes and multi-code mode clear on their own after the codes stop arriving, and
  that the timer stops after `reset()` / `dismiss()`.

No text, ARB or layout changes.

## Out of scope

The first screenshot also showed the tap boxes drawn a bit lower than the real codes
(a position/mapping issue). That is a separate problem and is not part of this plan.

## Checks

- `dart format .`, `flutter analyze` (clean), `flutter test`.
- On the phone (only with the user's OK): show 2+ codes, then point away; the boxes
  should clear in about 1.5 s.
