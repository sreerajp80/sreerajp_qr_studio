# Change log: fix build break after local_auth 3.x upgrade

Implements plan: `plans/20261106_074830_local_auth_3_migration.md`

## What changed

- `lib/services/biometric_service.dart`: in `authenticate()`, replaced
  `options: const AuthenticationOptions(stickyAuth: true)` with
  `persistAcrossBackgrounding: true`. local_auth 3.0.0 removed `AuthenticationOptions` from
  `authenticate()`; its changelog names `persistAcrossBackgrounding` as the replacement for
  `stickyAuth`.
- Error handling was not changed. The general `catch (_)` already catches the new
  `LocalAuthException`, so every failure still returns `false` and the app stays locked.

## Behaviour change

local_auth 3.x removed `useErrorDialogs`, so the plugin no longer shows its own native error
dialogs (for example, when no biometric is enrolled). The call now just returns `false`.
A friendly in-app message for specific `LocalAuthExceptionCode` values could be a separate
later change.

## Checks

- `dart format`: no changes.
- `flutter analyze`: no issues found.
- `flutter test`: all 926 tests passed.
- Release build and on-device app-lock test: not run in this change.
