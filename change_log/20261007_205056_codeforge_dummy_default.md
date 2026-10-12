# Change log: Use a dummy default value in CodeForge

Plan: [plans/20261007_204851_codeforge_dummy_default.md](../plans/20261007_204851_codeforge_dummy_default.md)

## What changed

- `lib/providers/code_forge_provider.dart`
  - The starting CodeForge content is now `https://example.com` instead of the real
    project repository URL. The Text and Link tabs both show this dummy value.
  - The QR fallback content used when the content box is empty is now also
    `https://example.com`.

`example.com` is reserved for examples (RFC 2606), so it is a safe dummy value and
still a valid URL for the Link type and link safety check.

## Verification

- `flutter analyze`: no issues.
- `flutter test`: all 483 tests passed.
