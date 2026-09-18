# Fix CI formatting in distance enhancement service test

## Reference Plan

`plans/20260918_053800_fix_distance_enhancement_service_test_formatting.md`

## Summary of Changes

Applied canonical Dart formatting to `test/services/distance_enhancement_service_test.dart` to resolve the GitHub Actions CI failure on the "Check formatting" step (`dart format --output=none --set-exit-if-changed .`).

## Modified Files

- `test/services/distance_enhancement_service_test.dart`:
  - Condensed `calculateCandidateRoi` call with `corners` argument onto a single line.
  - Condensed `DistanceScanConfig` constructor arguments onto a single line.

## Verification

- `dart format --output=none --set-exit-if-changed .`: Passed (0 files changed, exit code 0).
- `dart analyze`: Passed (No issues found!).
- `flutter test`: Passed (All tests passed, including test/services/distance_enhancement_service_test.dart).
