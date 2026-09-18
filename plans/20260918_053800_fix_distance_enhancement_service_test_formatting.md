# Fix CI formatting in distance enhancement service test

**Status:** Completed

## Issue

The GitHub Actions CI workflow failed at the "Check formatting" step (`dart format --output=none --set-exit-if-changed .`).
The file `test/services/distance_enhancement_service_test.dart` has formatting discrepancies:
- Trailing commas causing unnecessary multi-line argument formatting in `calculateCandidateRoi` and `DistanceScanConfig`.
- `dart format` requires condensing these short invocations to single lines.

## Files to change

- `test/services/distance_enhancement_service_test.dart` — format with `dart format`.

## Proposed changes

Run `dart format test/services/distance_enhancement_service_test.dart` to apply canonical Dart formatting.

Specific lines affected:
- Line 53-56: condense `service.calculateCandidateRoi(size, corners: corners)` call into one line.
- Line 80-83: condense `DistanceScanConfig(zoomFactor: 2.0, cropPadding: 0.0)` call into one line.

## Verification plan

### Automated Tests
1. Run `dart format --output=none --set-exit-if-changed .` to verify all 165 files pass cleanly (exit code 0).
2. Run `flutter analyze` to verify 0 errors, 0 warnings, and 0 lints.
3. Run `flutter test` to ensure all 293 tests continue to pass.
