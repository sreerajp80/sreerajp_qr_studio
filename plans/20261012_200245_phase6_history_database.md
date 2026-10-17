# Phase 6 — History database: pragmas, versioned migrations, indexes, constraints, tests

**Status:** completed

Part of [plans/20261012_191914_guidelines_compliance_roadmap.md](20261012_191914_guidelines_compliance_roadmap.md)
(gaps E1, E2). Target layer: `services/` (database schema and service).

## What the issue is

`lib/services/history_database_service.dart` opens the scan-history SQLite database with
`version: 1` and builds the table inside `onCreate`. Against engineering standard §13:

1. **No `onConfigure`.** `PRAGMA foreign_keys = ON` (§13.4) and `journal_mode=WAL` (§13.2) are
   never set.
2. **No versioned migrations (§13.1).** There is no migration map and no `onUpgrade`, so the
   next schema change would have no safe path for existing users.
3. **No indexes (§13.3).** History is read with `WHERE LOWER(category) = ?`, `WHERE
   isFavorite = 1` and `ORDER BY timestamp DESC`. History can grow past ~1,000 rows.
4. **Missing CHECK constraints (§13.4).** `isFavorite` must be 0 or 1 and `safetyScore` must be
   0–100, but the schema does not enforce it.
5. **Schema copied in the test.** `test/services/history_database_service_test.dart` writes its
   own copy of the `CREATE TABLE`, so it does not test the real schema, and there is no
   upgrade-path test (§13.1, §18.2).
6. **Schema version not documented** in `docs/architecture.md` (§13.1, §13.3).

## Files to be changed

- `lib/services/history_database_schema.dart` — new: schema version, `onConfigure`,
  `onCreate`, `onUpgrade`, and the append-only migration map.
- `lib/services/history_database_service.dart` — open the database through the schema.
- `test/services/history_database_schema_test.dart` — new: fresh install, v1 → v2 upgrade with
  data kept, pragmas, constraints, indexes.
- `test/services/history_database_service_test.dart` — use the real schema instead of its copy.
- `docs/architecture.md` — §8 Persistence: schema version, table, indexes, pragmas, migration
  rule. `docs/project_structure.md` — new file.
- `change_log/<timestamp>_phase6_history_database.md` — new.

## Plan for the fix

1. **Schema module** (`HistoryDatabaseSchema`):
   - `version = 2`.
   - `onConfigure`: `PRAGMA foreign_keys = ON` and `PRAGMA journal_mode = WAL`. The WAL pragma
     returns a row, so it is run with `rawQuery` (on Android `execute` rejects statements that
     return rows). Each pragma in its own `try/catch` with an `AppLogger.warning`, so a device
     that refuses WAL still opens the database.
   - `onCreate(db, version)` → run every migration from 0 to `version`.
   - `onUpgrade(db, old, new)` → run migrations `old + 1 … new`.
   - Each migration runs inside `db.transaction` (atomic, §13.1).
   - **v1** — exactly today's `CREATE TABLE scan_records (...)` (frozen; never edited again).
   - **v2** —
     - rebuild the table with `CHECK (isFavorite IN (0, 1))` and
       `CHECK (safetyScore BETWEEN 0 AND 100)` (SQLite cannot add a CHECK to an existing
       table): create `scan_records_v2`, copy every row (clamping any out-of-range
       `safetyScore` into 0–100 and any non-0/1 `isFavorite` to 1 or 0 so the copy cannot fail),
       drop the old table, rename the new one;
     - add indexes: `idx_scan_records_timestamp (timestamp)`,
       `idx_scan_records_category (LOWER(category))` (matches the query), and
       `idx_scan_records_favorite (isFavorite, timestamp)`.
   - `category` gets no CHECK: its values come from the payload classifier and from history
     import, so it is an open set. This choice is written in `docs/architecture.md`.
   - No foreign keys exist yet (one table); the pragma is on so future tables are safe.
2. **Service** — `_initDatabase()` calls `openDatabase(path, version:
   HistoryDatabaseSchema.version, onConfigure: …, onCreate: …, onUpgrade: …)`. Encryption, the
   file path and every query stay as they are. The connection stays open for the app's life
   (§9.3), as now.
3. **Tests** (with `sqflite_common_ffi`, already a dev dependency):
   - fresh install at v2: table, three indexes and both CHECKs exist;
   - **upgrade v1 → v2**: create a v1 database with the frozen v1 SQL, insert rows (including
     one with `safetyScore = 150`), reopen at v2, check every row is kept and the score is 100;
   - constraints: inserting `isFavorite = 2` or `safetyScore = -1` fails;
   - `foreign_keys` reads back as 1 after open;
   - `history_database_service_test.dart` opens its in-memory database through
     `HistoryDatabaseSchema` (no copied SQL); all its current tests keep passing.
4. **Docs** — `docs/architecture.md` §8: current schema version 2, columns, indexes, pragmas,
   "migrations are append-only, never edit a shipped one, every change adds a version and an
   upgrade test". `docs/project_structure.md`: the new file.
5. **Verify** — format check, `flutter analyze`, `flutter test`, Sanskrit gate; one
   `flutter build apk --flavor dev --debug`; then `android\gradlew --stop` and end leftover
   `GradleDaemon` / `KotlinCompileDaemon` processes. No install on any device. (The real
   on-device upgrade from the store build is a release-checklist item, not done here.)

## Out of scope — new gap found while reading this code (needs its own plan)

The field encryption in this service does not meet the Sensitive Data rules (§15.2):

- it uses **AES-CBC with a fixed IV** derived from the key (the same plaintext always gives the
  same ciphertext, and there is no authentication); §15.2 asks for authenticated encryption
  such as AES-GCM and never a fixed IV;
- if encryption fails, the field is **stored as plain text** without notice;
- if writing the new key to secure storage fails, a new key is made on every launch, so old
  rows can no longer be read;
- the stored format has no version marker (§15.2 "versioned formats").

Fixing this needs a data migration of every stored row (decrypt with the old scheme, encrypt
with AES-GCM and a random nonce per field, add a format version). I propose adding it to the
roadmap as **Phase 6b — history encryption upgrade**, planned right after this phase, because
it builds on the migration map added here.
