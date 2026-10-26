# Plan — Record the Play Console fixes done on 26 October 2026

**Status:** completed

## The issue

The maintainer has finished three Play Console fixes on 26 October 2026:

1. Foreground service form: the Special use "Describe permission use" box now holds the
   Scan bubble text (`foreground_service_declaration.md` §2), not the GhostScan text.
2. Store listing text: new short description and the current full description from
   `store_listing.md` §3 were pasted into the Default store listing (en-IN).
3. Screenshots: the 4 old phone screenshots were deleted and the 6 new ones
   (`store_listing.md` §4) were uploaded.

`play_store_private/SUBMISSION_RECORD.md` still says these are "not fixed yet". The record
must match what was actually done in Play Console.

## Files to be changed

| File | Change |
| --- | --- |
| `play_store_private/SUBMISSION_RECORD.md` (git-ignored, local only) | Mark the three items as done |

No app code, ARB, or committed doc changes.

## Plan for the fix

1. Submission 1 → "App content answers" table, Foreground service row: say the Special use
   box now holds the §2 Scan bubble text (fixed 26 October 2026).
2. Submission 1 → "Store listing" table: update the Short description, Full description and
   Screenshots rows to the new state (new short description, full description from
   `store_listing.md` §3, 6 new screenshots in the §4 order).
3. Submission 1 → "Differences from the guide":
   - item 3 (Special use text): Status → **fixed 26 October 2026**, sent for review.
   - item 4 (store listing out of date): Status → **fixed 26 October 2026** (description,
     short description and screenshots done), sent for review.
4. Add a new block "Store listing and App content change — 26 October 2026 (no new version)"
   after the existing 26 October App content block, listing the three changes. Result and
   date of result: "not recorded yet". Note to check after approval: the "may not be
   promoted" warning is gone.
5. Leave the earlier Target audience / Data safety review result as "not recorded yet"
   unless the maintainer gives the result.
6. Write a change log in `change_log/`.
