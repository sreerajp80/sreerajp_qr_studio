# Prepare Google Play foreground service declaration answers

**Status:** completed

## Issue

The app declares two foreground service types:

- `FOREGROUND_SERVICE_MEDIA_PROJECTION` — GhostScan (`GhostScanCaptureService`), a one-frame screen capture after the user agrees.
- `FOREGROUND_SERVICE_SPECIAL_USE` — Scan bubble (`ScanBubbleService`), a floating button the user turns on.

Because of this, Google Play asks us to fill in the form under
**Play Console → App content → Foreground service permissions** before release
(see `docs/release_process.md`, "Google Play Declarations"). The form needs, for each
type: the feature/task it is used for, a short description, what happens to the user
if the task is stopped or delayed, and a video link.

We have no ready text for this form yet. The video will be made later.

## Plan for the fix

1. Check Google's current help page for the exact questions in the form, so the
   answers match the real fields.
2. Write the answers in a new file `play_store_private/foreground_service_declaration.md`,
   next to the existing `data_safety_answers.md`. This folder is gitignored, so it is
   never committed.
3. The file will have, for each of the two types:
   - the task/use-case choice to pick in the form,
   - the description text (ready to paste, within any length limit),
   - the "impact if deferred or interrupted" text,
   - a placeholder for the video link (to fill in later),
   - facts the answers rest on (user turns it on, user consent prompt, notification
     shown, stops by itself / user can stop it, optional start after phone restart).
4. Add a short shot list for the demo video, so it is easy to record later.
5. In `docs/release_process.md`, point the two checklist items to the new private
   file (one short note). No other change to the checklist.

No app code, manifest, or ARB change.

## Files to be changed

- `play_store_private/foreground_service_declaration.md` — new (gitignored, not committed)
- `docs/release_process.md` — small note pointing to the answers file
- `change_log/<time>_play_fgs_declaration.md` — new change log
