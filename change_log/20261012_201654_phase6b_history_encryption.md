# Phase 6b — History encryption upgrade (AES-256-GCM, versioned, no plain-text fallback)

Plan: [plans/20261012_201000_phase6b_history_encryption.md](../plans/20261012_201000_phase6b_history_encryption.md)
Roadmap: [plans/20261012_191914_guidelines_compliance_roadmap.md](../plans/20261012_191914_guidelines_compliance_roadmap.md) (gap G3, Phase 6b added to the roadmap on 2026-10-12)

## What changed

- **New `lib/services/history_field_cipher.dart`** (`HistoryFieldCipher`):
  - AES-256-GCM, a new random 12-byte nonce per value, 16-byte tag.
  - Stored as `h2:` + base64url(nonce ‖ ciphertext ‖ tag); `h2:` is the format version.
  - `encrypt` throws on failure and never returns plain text.
  - `decrypt`: `h2:` values are tag-checked (a bad tag, wrong key or too-short value throws);
    other values go to `decryptLegacy`, which reads the old AES-CBC fixed-IV format, or
    returns the value unchanged if it was plain text from the old fallback.
  - Refuses a key shorter than 32 bytes.
- **New `lib/models/app_exception.dart`** — sealed `AppException` with `StorageException`
  (engineering standard §11.3). Messages are technical, for logs only.
- **`lib/services/history_database_service.dart`**
  - Key handling: a key **read error** throws `StorageException` and never makes or writes a
    new key; a missing key is created, written, **read back and compared** before use; a
    write or read-back failure throws. An invalid stored key throws.
  - `_encryptString` uses the cipher and throws `StorageException` on failure (the old
    plain-text fallback is gone).
  - The `database` getter now loads the key first, opens the database, and once per service
    runs `_upgradeLegacyRows`: it finds rows where any encrypted column is not empty and not
    `h2:`, and re-encrypts those fields to v2 in one transaction. Idempotent. Logs only the row
    count. This also runs for an injected database (tests).
  - `getRecords` skips a row that cannot be decrypted (for example a failed tag), logs the
    count as a warning, and keeps the row on disk. Metadata decryption is no longer inside the
    JSON `try`, so a changed metadata value also counts as unreadable.
  - Removed the direct `encrypt` package and unused `foundation` imports.
- **Tests**
  - New `test/services/history_field_cipher_test.dart` (10 tests): round trip for normal,
    Malayalam, Devanagari and 200,000-character text; empty text; random nonce (same text →
    different values); size = nonce + text + tag; changed ciphertext byte and changed tag byte
    rejected; wrong key rejected; too-short value rejected; short key refused; an exact copy of
    the old CBC fixed-IV scheme decrypts; old plain text returned as is.
  - `test/services/history_database_service_test.dart` (+5 tests): fields stored as `h2:` and
    not as plain text; old-format rows (CBC and plain) upgraded on open and read back the same;
    key read error → `StorageException` and no key written; key write error → insert fails and
    nothing stored; a changed row is skipped while others load, and stays on disk.
- **Docs**
  - `docs/security.md` §4: the scan-history row now names the encrypted fields and the
    protection. §6: new "Scan History Field Encryption" part (fields, cipher, format, key
    handling, no fallback, legacy upgrade, tampering).
  - `docs/architecture.md` §8: points to the format and to `security.md` §6.
  - `docs/project_structure.md`: `history_field_cipher.dart` and `app_exception.dart`.

No schema change (still version 2). No new package.

## Checks

- `dart format --output=none --set-exit-if-changed .` — no changes.
- `flutter analyze` — no issues.
- `flutter test` — all 619 tests passed (+15 new).
- Sanskrit Hindi-marker gate — passed.
- `flutter build apk --flavor dev --debug` — built; not installed on any device.
- Gradle daemon stopped; no `GradleDaemon` or `KotlinCompileDaemon` process left.

## Notes

- **Release item:** before release, test on a real device that history saved by the current
  store build is upgraded and still readable after installing the new build. Not done here,
  because installing on a phone needs the user's approval.
- Behaviour seen while testing: `HistoryProvider` stores an English `_errorMessage` when
  loading fails, but no screen shows it; the history list simply stays empty. Unchanged here;
  worth a look in Phase 7 or 8 (user-visible error state, localized).
- A legacy value that is really plain text but happens to be valid CBC ciphertext with valid
  padding would be decrypted wrongly. This was already true in the old code, and the chance is
  very small (random text rarely is valid base64 of the right length with valid padding).
