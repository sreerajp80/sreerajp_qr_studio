# Change Plan: Fix Unresolved StatusBarManager Constant in MainActivity.kt

**Status:** completed

## Issue Description
Running `flutter build apk --flavor prod --release --split-per-abi` fails during the `:app:compileProdReleaseKotlin` compilation task:
```
e: .../android/app/src/main/kotlin/in/sreerajp/qr_reader/MainActivity.kt:121:83 Unresolved reference 'STATUS_BAR_SERVICE_ADD_TILE_SUCCESS'.
```

In `android/app/src/main/kotlin/in/sreerajp/qr_reader/MainActivity.kt` at line 121, the code checks the status code returned by `StatusBarManager.requestAddTileService` against `StatusBarManager.STATUS_BAR_SERVICE_ADD_TILE_SUCCESS`.

In the Android SDK (API 33+), `android.app.StatusBarManager` does not define `STATUS_BAR_SERVICE_ADD_TILE_SUCCESS`. Instead, it defines:
- `TILE_ADD_REQUEST_RESULT_TILE_ADDED`: tile was added to Quick Settings
- `TILE_ADD_REQUEST_RESULT_TILE_ALREADY_ADDED`: tile was already present in Quick Settings

## Proposed Fix
In `android/app/src/main/kotlin/in/sreerajp/qr_reader/MainActivity.kt`:
Update the `requestAddTileService` callback to check if `statusCode` is either `StatusBarManager.TILE_ADD_REQUEST_RESULT_TILE_ADDED` or `StatusBarManager.TILE_ADD_REQUEST_RESULT_TILE_ALREADY_ADDED`.

```kotlin
statusBarManager.requestAddTileService(
    componentName,
    getString(R.string.ghost_scan_tile_label),
    Icon.createWithResource(this@MainActivity, R.drawable.ic_ghost_scan_tile),
    mainExecutor
) { statusCode ->
    val success = statusCode == StatusBarManager.TILE_ADD_REQUEST_RESULT_TILE_ADDED ||
        statusCode == StatusBarManager.TILE_ADD_REQUEST_RESULT_TILE_ALREADY_ADDED
    result.success(success)
}
```

## Files to Change

### Android Native Layer
- **[MODIFY]** `android/app/src/main/kotlin/in/sreerajp/qr_reader/MainActivity.kt`: Replace `StatusBarManager.STATUS_BAR_SERVICE_ADD_TILE_SUCCESS` with `StatusBarManager.TILE_ADD_REQUEST_RESULT_TILE_ADDED` and `StatusBarManager.TILE_ADD_REQUEST_RESULT_TILE_ALREADY_ADDED`.

---

## Verification Plan

### Automated Checks
- Run `flutter analyze` to ensure Dart static analysis remains clean.
- Run `flutter test` to ensure unit tests pass.

### Build Verification
- Run `flutter build apk --flavor prod --release --split-per-abi` to ensure Kotlin compilation succeeds and release APKs build without errors.
