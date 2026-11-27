# Split APKs use the same versionCode as the App Bundle

Plan: [plans/20261121_195416_split_apk_same_version_code.md](../plans/20261121_195416_split_apk_same_version_code.md)

## What changed

- `android/gradle.properties`: added `force-version-code-ignoring-abi=true` with a comment.
  Flutter no longer adds 1000/2000/4000 per ABI to split APKs; every split APK now has the
  `pubspec.yaml` build number as its `versionCode`, the same as the App Bundle. This applies to
  both flavors.
- `docs/release_process.md`:
  - §6.1: all split APKs share the bundle's `versionCode`; how to check with
    `aapt2 dump badging`.
  - §8 Security checklist: new item "Split APK versionCode equals the pubspec.yaml build number".
  - §12 Distribution Channels: why one versionCode is needed for both channels; releases up to
    4.1.12+46 still used the offset, so a phone with one of those APKs needs a build number above
    4046; Play App Signing key must match the release keystore.

## Not done here

- No build was run. The next build must be checked (each split APK and the AAB show the same
  `versionCode`).
- Whether to jump the build number above 4046 at the next release is still the user's choice.
- Suggested text for the shared guidelines is in the plan; the submodule was not touched.

## Security impact

Build config only. No permission, network, storage, manifest or signing change.
