# Phase 6 — History database: pragmas, versioned migrations, indexes, constraints, tests

Plan: [plans/20261012_200245_phase6_history_database.md](../plans/20261012_200245_phase6_history_database.md)
Roadmap: [plans/20261012_191914_guidelines_compliance_roadmap.md](../plans/20261012_191914_guidelines_compliance_roadmap.md) (gaps E1, E2)

## What changed

- **New `lib/services/history_database_schema.dart`** (`HistoryDatabaseSchema`):
  - `version = 2`; `tableName = 'scan_records'`.
  - `onConfigure`: `PRAGMA foreign_keys = ON` (`execute`) and `PRAGMA journal_mode = WAL`
    (`rawQuery`, because it returns a row). A failure is logged and the database still opens.
  - `onCreate` / `onUpgrade` run an append-only migration map; each migration runs in a
    transaction; a missing migration throws a clear `StateError`.
  - **v1**: the original `CREATE TABLE`, frozen as `v1CreateTableSql`.
  - **v2**: rebuilds the table with `CHECK (safetyScore BETWEEN 0 AND 100)` and
    `CHECK (isFavorite IN (0, 1))` (old values clamped during the copy), then adds
    `idx_scan_records_timestamp`, `idx_scan_records_category (LOWER(category))` and
    `idx_scan_records_favorite (isFavorite, timestamp)`.
- **`lib/services/history_database_service.dart`** — opens the database with the schema's
  version and callbacks. Encryption, file path and queries are unchanged. Its logger import was
  moved into the sorted package imports.
- **Tests**
  - New `test/services/history_database_schema_test.dart`: fresh install (version, 3 indexes),
    `foreign_keys` = 1, WAL on a file database, CHECKs reject bad values, and a **v1 → v2
    upgrade** that keeps all rows and clamps `safetyScore` 150 → 100, −5 → 0 and
    `isFavorite` 7 → 1.
  - `test/services/history_database_service_test.dart` and
    `test/providers/history_provider_test.dart` now open their in-memory database through
    `HistoryDatabaseSchema` instead of their own copy of the SQL. (The plan named only the
    service test; the provider test had the same copy, so it was fixed the same way.) No test
    file contains `CREATE TABLE` any more.
- **Docs**
  - `docs/architecture.md` §8: schema version 2, columns, constraints (and why `category` has no
    CHECK), indexes, pragmas, migration rule. The repository tree listed a
    `database_helper.dart` that does not exist; replaced with the two real files.
  - `docs/project_structure.md`: same tree fix.

## Checks

- `dart format --output=none --set-exit-if-changed .` — no changes.
- `flutter analyze` — no issues.
- `flutter test` — all 604 tests passed (+5 new).
- Sanskrit Hindi-marker gate — passed.
- `flutter build apk --flavor dev --debug` — built; not installed on any device.
- Gradle daemon stopped; no `GradleDaemon` or `KotlinCompileDaemon` process left.

## Notes for later

- On-device check of the v1 → v2 upgrade from the current store build belongs to the release
  checklist (not done here).
- **History encryption does not meet §15.2** (AES-CBC with a fixed IV, silent plain-text
  fallback, key regenerated if saving it fails, no format version). Proposed as roadmap
  Phase 6b; waiting for the user's decision.
- Phase 5's logging script placed the `app_logger.dart` import above the `dart:` imports in 16
  files. Harmless (no lint enforces the order), but untidy; to be sorted in a later phase.
