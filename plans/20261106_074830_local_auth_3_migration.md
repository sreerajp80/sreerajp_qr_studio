# Fix build break after local_auth 3.x upgrade

**Status:** completed

## What the issue is

`pubspec.yaml` moved `local_auth` from `^2.3.0` to `^3.0.2` (resolved 3.0.2). Version 3.0.0
has breaking changes:

- `authenticate()` no longer takes an `options: AuthenticationOptions(...)` argument. Each
  option is now a plain named parameter. `stickyAuth` became `persistAcrossBackgrounding`.
- `useErrorDialogs` was removed with no replacement. The plugin no longer shows its own
  native error dialogs.
- Most failures now throw `LocalAuthException` instead of `PlatformException`.

Because of the first point, `lib/services/biometric_service.dart` does not compile, and both
`flutter analyze` and the prod release build fail.

## Files to change

- `lib/services/biometric_service.dart`

## Plan for the fix

1. In `authenticate()`, replace
   `options: const AuthenticationOptions(stickyAuth: true)` with
   `persistAcrossBackgrounding: true`. This keeps the old behaviour: the prompt stays
   active if the app goes to the background.
2. Keep the existing `catch` blocks. The `on PlatformException` block stays for the few
   cases that still throw it; the general `catch (_)` already catches the new
   `LocalAuthException`, so all failures still return `false` and never crash (hard rule 4).
   No new error UI is added in this change.
3. Run `dart format`, `flutter analyze` and `flutter test`.

## Behaviour change to note

With 2.x the default `useErrorDialogs: true` could show a native dialog (for example, "no
fingerprint enrolled, go to settings"). In 3.x that dialog no longer appears; the call just
returns `false`. Showing a friendly in-app message for specific `LocalAuthExceptionCode`
values could be a later, separate change.

## Security impact

Dependency upgrade in the biometric app-lock path. The lock still fails closed: any error
returns `false`, so the app stays locked. No permissions, storage or network changes.
