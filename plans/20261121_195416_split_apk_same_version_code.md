# Split APKs use the same versionCode as the App Bundle

**Status:** completed

## The issue

`flutter build apk --split-per-abi` adds an offset to the build number:
1000 for armeabi-v7a, 2000 for arm64-v8a, 4000 for x86_64. The App Bundle (`.aab`) has no
offset. So the last release (4.1.12+46) gave:

| Artifact | versionCode |
|---|---|
| App Bundle (Play) | 46 |
| armeabi-v7a APK | 1046 |
| arm64-v8a APK | 2046 |
| x86_64 APK | 4046 |

A phone that has a direct split APK (for example 2046) sees every later Play build (47, 48, ...)
as older. Play never updates it. The only way out is to uninstall, which deletes the app's
private data (encrypted history, settings).

## What was checked

- Flutter: `CLAUDE.md` and CI say 3.47.6. The Flutter SDK on this machine (used for local release
  builds) is 3.50.1. The switch `force-version-code-ignoring-abi` exists in both: it was added in
  3.47.0 (`FlutterPluginUtils.kt`, `FlutterPlugin.kt` in `flutter_tools/gradle`).
- `android/app/build.gradle` sets `versionCode` from `flutter.versionCode` in `local.properties`,
  which Flutter writes from `pubspec.yaml`. With the switch on and a `versionCode` set in the DSL,
  the Flutter plugin adds no offset and every split APK keeps that `versionCode`.
- The app does ship split APKs ("Direct APK" channel, `docs/release_process.md` §12).
- A test phone has the prod app installed from a split APK with versionCode 2046 (installer: the
  system package installer). Two other phones have 46 from Play.

## Files to change

1. `android/gradle.properties` — add `force-version-code-ignoring-abi=true` with a short comment.
2. `docs/release_process.md` (the app's own copy, not the guidelines submodule):
   - §6.1 (where `--split-per-abi` is described): all split APKs share the bundle's
     `versionCode`; how to check it with `aapt2 dump badging`.
   - §12 Distribution Channels: explain why (a sideloaded APK with a higher code blocks Play
     updates; uninstalling deletes data). Also note Play App Signing's key must match the
     release keystore, or Play cannot update a sideloaded install anyway.
   - §8 Release Checklist: new item "Split APK versionCode equals the `pubspec.yaml` build
     number — no 1000/2000/4000 added."

No code change. No change in `docs/guidelines/`.

## The fix

The Gradle property turns off the ABI offset for all `--split-per-abi` builds (prod and dev).
After this, 4.1.13+47 gives versionCode 47 in the AAB and in all three APKs.

Phones that already have 1046/2046/4046 are still stuck: 47 is lower than 2046. Two ways out:
- **One-time jump** of the build number above the highest code ever given out (above 4046,
  e.g. `+4047`). Play accepts any higher number. Simple, but the numbers stay large for ever.
- **No jump**: only if no other person has a sideloaded APK. The test phone then needs one
  uninstall/reinstall (its data is lost, it is a test phone).

The choice of the jump is left to the user; it is not part of this plan's file changes. If a jump
is chosen, it is done at the next release, as part of that release's version bump.

## Security impact

Build config only. No permission, network, storage or manifest change. Signing is unchanged.

## Note for the shared guidelines (not edited here)

`docs/guidelines/flutter_build_flavors_guide.md` or the engineering standard (§5.6, split APKs)
could say: "If you ship split APKs and an App Bundle, set `force-version-code-ignoring-abi=true`
in `android/gradle.properties`, so both channels share one versionCode." The user may add this in
the guidelines repository as separate work.

## Testing

No build by Claude. The user builds; Claude then checks each split APK with
`aapt2 dump badging` and the AAB manifest (protobuf) with a small Python script, and checks that
the file names match the version inside.
