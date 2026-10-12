# Change log — Fix .gitignore, untrack build junk, track zxing-cpp

Implements plan: [plans/20261007_210912_gitignore_cleanup.md](../plans/20261007_210912_gitignore_cleanup.md)

## What changed

### `.gitignore`
Added:
- Flutter / Dart: `.pub-cache/`, `.pub/`, `migrate_working_dir/`, `app.*.symbols`,
  `app.*.map.json`, `**/android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java`.
- Android: `android/.kotlin/`, `android/app/.cxx/`, `android/captures/`,
  `android/hs_err_pid*.log`, `android/replay_pid*.log`.
- Logs: `*.log`.
- Windows: `Thumbs.db`, `desktop.ini`.

### Stopped tracking (`git rm --cached`, files kept on disk)
- 18 Kotlin compiler error logs in `android/.kotlin/errors/`.
- `android/hs_err_pid24944.log`, `android/hs_err_pid28620.log`, `android/replay_pid24944.log`
  (Java crash dumps that held local system details).
- `android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java`
  (Flutter regenerates it on every build).

### Started tracking
- `native/zxing-cpp/` (222 files, vendored, unchanged). A fresh clone can now build
  the native barcode decoder.

## Checks
- `git check-ignore` confirms the new rules match `.cxx`, `.kotlin`, crash logs and
  `GeneratedPluginRegistrant.java`.
- `git ls-files -ci --exclude-standard` is empty, so no tracked file is ignored.
- No untracked `.cxx`, `.kotlin` or `.log` files remain in `git status`.
- `flutter analyze`: no issues. `flutter test`: all 483 tests passed.

## Not done
- Nothing was committed or pushed. The changes are staged only.
- The crash dumps are still in git history (first commit, already on GitHub).
  Removing them needs a history rewrite and force-push, which is a separate decision.
