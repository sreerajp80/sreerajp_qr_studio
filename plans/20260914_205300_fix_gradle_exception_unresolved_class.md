# Change Plan: Fix Unresolved GradleException in android/app/build.gradle

**Status:** completed

## Issue Description
The IDE static analyzer reports a build script error in `android/app/build.gradle` at line 58:
`unable to resolve class GradleException @ line 58, column 23.`

This happens inside the custom `generateBuildMetadata` Gradle task:
```groovy
        if (!dartExecutable.exists()) {
            throw new GradleException(
                "Could not find Dart executable at ${dartExecutable.absolutePath}. " +
                "Check android\\local.properties flutter.sdk or FLUTTER_ROOT."
            )
        }
```
In Groovy build scripts evaluated without Gradle IDE classpath bindings, unqualified `GradleException` cannot be resolved. Earlier in the same file (line 25), `RuntimeException` is already used for the missing Flutter SDK error condition:
```groovy
def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new RuntimeException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}
```

## Proposed Fix
Replace `throw new GradleException(...)` with `throw new RuntimeException(...)` at line 58 in `android/app/build.gradle`.
This aligns line 58 with line 25, resolves the IDE error diagnostic cleanly without external class resolution requirements, and properly halts the Gradle task if the Dart executable is not found.

## Files to Change

### Build Configuration Layer
- **[MODIFY]** `android/app/build.gradle`: Replace `throw new GradleException` with `throw new RuntimeException` inside `generateBuildMetadata`.

---

## Verification Plan

### Automated Checks
- Verify `flutter analyze` runs clean with 0 issues.
- Verify `flutter test` passes all tests.

### Build / IDE Verification
- Check that the IDE diagnostic `unable to resolve class GradleException` is eliminated in `android/app/build.gradle`.
