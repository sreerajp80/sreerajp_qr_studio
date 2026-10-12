# Fix .gitignore, untrack build junk, track zxing-cpp

**Status:** completed

## What the issue is

1. **`.gitignore` is missing entries.** These build outputs are not ignored:
   - `android/app/.cxx/`: the native (C++) build cache, 776 files containing local build paths.
   - `android/.kotlin/`: Kotlin compiler error logs.
   - `android/hs_err_pid*.log`, `android/replay_pid*.log`: Java crash dumps.
   - Other standard Flutter and Windows entries: `*.log`, `.pub-cache/`, `.pub/`,
     `migrate_working_dir/`, `app.*.symbols`, `app.*.map.json`, `Thumbs.db`,
     and Flutter's generated `GeneratedPluginRegistrant.java`.
2. **Junk files are already tracked** (pushed in the first commit):
   - 18 files in `android/.kotlin/errors/`.
   - `android/hs_err_pid24944.log`, `android/hs_err_pid28620.log`, `android/replay_pid24944.log`.
     The two `hs_err` crash dumps contain **local system details** (user name, `PATH`,
     temp folder, Java folder). They should not be in a public repo.
   - `android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java`.
     Flutter regenerates it on every build, so tracking it only causes noise in diffs.
3. **`native/zxing-cpp/` is not tracked at all** (222 files, about 2.6 MB, no nested
   `.git`). The app's barcode decoder is built from it, so a fresh clone from GitHub
   cannot build. It must be committed.

## Files to change

- `.gitignore`: add the new entries (below).
- `android/.kotlin/errors/*.log` (18 files): remove from git with `git rm --cached`.
- `android/hs_err_pid24944.log`, `android/hs_err_pid28620.log`, `android/replay_pid24944.log`:
  remove from git with `git rm --cached`.
- `android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java`:
  remove from git with `git rm --cached`.
- `native/zxing-cpp/`: add to git with `git add` (no file content is edited, as the rules require).

`git rm --cached` only stops tracking. **The files stay on your disk.**

## The fix

### New `.gitignore` entries

```gitignore
# Flutter / Dart (additions)
.pub-cache/
.pub/
migrate_working_dir/
app.*.symbols
app.*.map.json
**/android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java

# Android (additions)
android/.kotlin/
android/app/.cxx/
android/captures/
android/hs_err_pid*.log
android/replay_pid*.log

# Logs
*.log

# Windows
Thumbs.db
desktop.ini
```

`gradle-wrapper.jar` stays tracked (Gradle recommends this).

### Steps

1. Edit `.gitignore`.
2. Run `git rm --cached` for the 22 files listed above.
3. Run `git add native/zxing-cpp/`.
4. Check: `git status` no longer shows `.cxx` or log files, `git check-ignore` confirms
   the new rules, and `git ls-files native/zxing-cpp | wc -l` shows 222.
5. Run `flutter analyze` and `flutter test`. A Flutter build recreates
   `GeneratedPluginRegistrant.java`, so the app still builds.
6. Write the change log and set this plan to `completed`.

**This plan does not commit or push.** The changes are only staged. You decide when to commit.

## Not in this plan: git history

Even after this change, the crash dumps stay in the **git history** on GitHub (first commit),
including the local system details. Removing them fully needs a history rewrite
(for example with `git filter-repo`) and a force-push to `main`. That is risky and
changes every commit ID, so it is a **separate decision for you**. Tell me if you
want a separate plan for it. Doing it before renaming the GitHub repo is cleanest.

## Notes

- New source files that are still untracked (for example the ScanBubble Kotlin files,
  `res/values-ml`, `res/values-sa` and some new tests) are not junk. They should simply be
  included in your next commit. This plan does not stage them.
