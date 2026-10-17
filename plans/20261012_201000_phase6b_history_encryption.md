# Phase 6b — History encryption upgrade (AES-256-GCM, versioned, no plain-text fallback)

**Status:** completed

Part of [plans/20261012_191914_guidelines_compliance_roadmap.md](20261012_191914_guidelines_compliance_roadmap.md)
(gap G3, found in Phase 6). Target layer: `services/` (history database service and a new
field-cipher service).

## What the issue is

`HistoryDatabaseService` encrypts five fields of every scan record (`rawContent`,
`imageThumbnail`, `locationTag`, `notes`, `metadata`). The app is under the **Sensitive Data
Extension**, and engineering standard §15.2 says: use authenticated encryption such as AES-GCM;
never hard-code or fix IVs; version the crypto format. The project's own `docs/security.md` §6
also says "never use static IVs". Today:

1. **AES-CBC with a fixed IV.** The IV is made from the first 16 key bytes, so the same text
   always gives the same ciphertext (an attacker who reads the file can tell which scans are
   equal), and there is no tag, so changed ciphertext is not detected.
2. **Silent plain-text fallback.** If the encrypter is not ready or encryption throws,
   `_encryptString` returns the **plain text**, and it is saved like that.
3. **Key can be lost.** If reading the key from secure storage throws, or writing a new key
   fails, the code makes a fresh random key and carries on. The next launch then cannot read
   any older row (and a read error even leads to overwriting the stored key).
4. **No format version.** A stored value does not say which scheme made it, so the scheme cannot
   be changed safely.
5. `docs/security.md` does not describe history encryption at all.

## Files to be changed

- `lib/services/history_field_cipher.dart` — new: encrypt/decrypt one field.
- `lib/services/history_database_service.dart` — use the cipher; safe key handling; one-time
  re-encryption of old rows; skip unreadable rows.
- `lib/models/app_exception.dart` *(new, if no typed exception exists yet)* — a small sealed
  `AppException` with `StorageException` (§11.3), used for "history key unavailable" and
  "encryption failed".
- `test/services/history_field_cipher_test.dart` — new.
- `test/services/history_database_service_test.dart` — new cases (old-row upgrade, key errors,
  tampering).
- `docs/security.md` — new "History field encryption" part in §6, and the sensitive-data
  inventory row.
- `docs/architecture.md` §8 — one line pointing to the format.
- `change_log/<timestamp>_phase6b_history_encryption.md` — new.

No schema change (the database stays at version 2). No new package: `encrypt` already supports
`AESMode.gcm`.

## Plan for the fix

1. **Field format v2** (`HistoryFieldCipher`):
   - AES-256-GCM with the existing 32-byte random key from secure storage.
   - A **new random 12-byte nonce for every value** (`Random.secure()`).
   - Stored text: `h2:` + base64url(nonce ‖ ciphertext ‖ 16-byte tag). The `h2:` prefix is the
     format version.
   - `decrypt`: `h2:` → GCM (tag checked; a bad tag throws). Anything else is treated as
     **legacy**: try the old AES-CBC fixed-IV scheme (kept only for reading); if that fails, the
     value was stored as plain text by the old fallback, so return it as is.
   - Empty strings stay empty (as now).
   - Pure Dart, no `BuildContext`; unit-testable with an injected key and random source.
2. **No plain-text fallback.** If encryption fails, `insertRecord` / `updateNotes` /
   `updateLocationTag` throw a `StorageException`. `HistoryProvider` already catches errors on
   these calls and keeps its state, so the user sees the save fail instead of data being stored
   unprotected. (The UI message for this stays as today; checked in the change log.)
3. **Safe key handling.**
   - Key **read throws** → do **not** make a new key; throw `StorageException('history key
     unavailable')`. The database is not opened, nothing is overwritten, and the next launch can
     try again.
   - Key **missing** (first run) → make a new key, write it, **read it back**; only if the
     read-back matches is it used. If writing fails → throw, and nothing is encrypted with an
     unsaved key.
   - The key never appears in logs (the logger already hides error text in prod).
4. **One-time upgrade of old rows.** After the database opens, find rows where any encrypted
   field is not empty and does not start with `h2:`; in one transaction, decrypt each with the
   legacy path and write it back in format v2. It is idempotent (already-upgraded rows are
   skipped), so it is safe if the app is closed half-way (the transaction rolls back) and simply
   runs again next time. Log only the count (`info`).
5. **Unreadable rows.** If a `h2:` value fails its tag check (file damaged or changed), that
   row is skipped from the list and a `warning` is logged with the row count only. The row is
   **not** deleted (the user can still "Clear history").
6. **Tests** (deterministic where possible, §18.2):
   - cipher round trip for normal, empty, Malayalam/Devanagari and long (thumbnail-size) text;
   - the same text twice gives **different** stored values (random nonce);
   - every stored value starts with `h2:`;
   - a changed byte in the ciphertext or tag → decrypt throws;
   - wrong key → decrypt throws;
   - legacy: a value made with the old CBC fixed-IV scheme (fixed test key and text, produced
     in the test with the same `encrypt` calls as the old code) decrypts correctly; a plain-text
     legacy value is returned as is;
   - service: rows written in the old format are upgraded to `h2:` on open and read back the
     same; key read error → `StorageException`, no key written; key write error → insert
     fails, nothing stored in plain text; a tampered row is skipped, others still load.
7. **Docs** — `docs/security.md` §6: history encryption (AES-256-GCM, random 12-byte nonce per
   field, `h2:` version prefix, key in Android Keystore via `flutter_secure_storage`, legacy
   read-only path, no plain-text fallback, upgrade on open); §4 inventory row for scan history.
   `docs/architecture.md` §8: one line pointing there.
8. **Verify** — format check, `flutter analyze`, `flutter test`, Sanskrit gate, one
   `flutter build apk --flavor dev --debug`; then `android\gradlew --stop` and end leftover
   `GradleDaemon` / `KotlinCompileDaemon` processes. No install on any device.

## Risks

- **Old history on users' phones** is upgraded on first open of the new version. The legacy
  path is covered by tests with the exact old scheme. A real-device check of upgrading from the
  current store build must be done before release (added to the change log as a release item;
  not done here, because installing on a device needs your yes).
- If secure storage is broken on a device, history will not open (instead of silently making a
  new key). This is the safer failure: data is kept and can be read once storage works again.

## Out of scope

- Encrypting the whole database file (SQLCipher) — a bigger change with a new native
  dependency; not required by §15.2.
- Moving the history export file to encrypted-by-default (§15.2 "SHOULD") — to be checked
  in Phase 9 with `docs/security.md`.
