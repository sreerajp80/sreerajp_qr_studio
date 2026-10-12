# Plan: Use a dummy default value in CodeForge

**Status:** completed

## Issue

When CodeForge opens, the Text and Link fields are pre-filled with the real project
repository URL (`https://github.com/sreerajp80/sreeraj_qr_reader`). This is a real,
working link. A placeholder should be a clearly fake (dummy) value instead.

The same real URL is also used as the fallback QR content when the content box is empty.

## Files to change

- `lib/providers/code_forge_provider.dart`

## Fix

1. Change the starting `rawContent` (line 13) to `https://example.com`.
2. Change the empty-content QR fallback (line 86) to the same `https://example.com`.

`example.com` is a domain reserved for examples (RFC 2606). It never points to a real
site owner, so it is a safe dummy value. It is still a valid URL, so the Link type
and the link safety check keep working.

No tests use the old URL, so no test changes are needed.

## Verify

- `flutter analyze` (must be clean)
- `flutter test`
