# Change Log: Fix Unresolved GradleException in android/app/build.gradle

**Plan Reference:** [plans/20260914_205300_fix_gradle_exception_unresolved_class.md](../plans/20260914_205300_fix_gradle_exception_unresolved_class.md)

## Summary of Changes

1. **Android Build Configuration**:
   - Updated `android/app/build.gradle` inside the `generateBuildMetadata` Gradle task `doLast` block.
   - Replaced `throw new GradleException(...)` with `throw new RuntimeException(...)` when the Dart executable is not found.
   - This aligns with the exception pattern used on line 25 of `android/app/build.gradle` and resolves the IDE diagnostic error (`unable to resolve class GradleException`).

## Verification Results
- Ran `flutter analyze` — 0 issues found.
- Ran `flutter test` — all 227 tests passed cleanly.
