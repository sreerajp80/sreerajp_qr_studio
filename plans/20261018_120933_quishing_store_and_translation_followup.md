# QuishingGuard follow-up: store listing text and translation review

**Status:** completed

Follows `plans/20261018_112550_quishing_guard_honest.md` (completed).

## What the issue is

Two open items were left after the QuishingGuard change:

1. **Store listing.** The private store listing notes still describe the old
   fake score:
   - The full description says Quishing Guard "looks for signs that a fake QR
     sticker was pasted over a real one". The app no longer does that.
   - **Screenshot 4** ("Check payment QR codes / Spot fake stickers") shows the
     old card: "QuishingGuard™ · Genuine · 21%" with a green tick. That card is
     gone, and the picture would show users a feature that does not exist.
     The raw capture has the same old card.
   - Correction to my last report: the Play **short description** in the
     listing ("QR & barcode scanner that checks links for scams…") never
     mentioned tamper detection, so it needs **no** change. The line in
     `docs/PROJECT_PROFILE.md` is the app's profile line, not the Play field.
2. **Translations.** The new Malayalam and Sanskrit lines need a native-reader
   check. I cannot do a true native review. What I can do is a careful second
   pass for grammar and natural wording. That pass found these problems:
   - Sanskrit `helpGuideQuishingCvBullet2`: `अन्विष्यति` is the wrong verb
     form. "Searches" is `अन्विच्छति`.
   - Sanskrit `bodyOnboardingSlide2`: the sentence starts with "having scanned"
     (`संवीक्ष्य`) but its subject is QuishingGuard, so it reads as if
     QuishingGuard did the scanning. It should say "when you scan…, QuishingGuard
     reminds you…".
   - Malayalam chip `കൈ പരിശോധന` ("hand check") sounds odd. `സ്വയം പരിശോധന`
     ("check it yourself") is more natural. The same applies to Sanskrit
     `हस्तपरीक्षाः`, which becomes `स्वयंपरीक्षा`.
   - Malayalam chip `പണമിടപാട് നുറുങ്ങ്` should be plural:
     `പണമിടപാട് നുറുങ്ങുകൾ` (20 characters, within the 22 limit).
   - The card intro says the app "cannot see a sticker through the camera"
     (en and ml). That is a little wrong, because the app does use the camera.
     It should say the app "cannot spot a sticker in the camera picture".

## The plan for the fix

### A. Store listing (`play_store_private/store_listing.md`, private, gitignored)

1. Rename the heading **SPOT TAMPERED QR CODES** to **FAKE STICKER CHECK**, and
   change the line to:
   > • Scammers sometimes paste a fake QR sticker over a real one, on parking
   > meters, posters or payment stands. When you scan a link or payment code,
   > Quishing Guard reminds you what to check before you open it or pay.
2. Screenshot 4: in the screenshot table, mark it **do not upload** until it is
   retaken. Add a short note on how to retake it: scan a **test** UPI QR code
   with the camera so the new "Fake sticker check" card shows. Change the
   caption to "Check payment QR codes / Check for fake stickers".
   I will **not** take the new screenshot. That needs your phone, and I will
   not use it without asking you first.
3. Update the "Prepared" date line to 18 October 2026.

This file is gitignored, so it will not be committed. I will not copy any of
its private content into the plan or change log.

### B. Translation fixes (`lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb`)

4. `bodyStickerCheckIntro`:
   - en: "Scammers stick their own QR code over the real one. This app cannot
     spot a sticker in the camera picture, so please check it yourself:"
   - ml: "…ക്യാമറ ചിത്രത്തിൽ നിന്ന് സ്റ്റിക്കർ തിരിച്ചറിയാൻ ഈ ആപ്പിന് കഴിയില്ല,
     അതിനാൽ നിങ്ങൾ തന്നെ പരിശോധിക്കുക:"
   - sa: "…अयम् अनुप्रयोगः चित्रग्राहिणः चित्रे पत्रिकाम् अभिज्ञातुं न शक्नोति,
     अतः भवान् स्वयं परीक्षताम्:"
5. `labelFeatureQuishingGuardChip2`: ml `സ്വയം പരിശോധന`, sa `स्वयंपरीक्षा`
   (en stays "Hand checks").
6. `labelFeatureQuishingGuardChip3`: ml `പണമിടപാട് നുറുങ്ങുകൾ`.
7. sa `helpGuideQuishingCvBullet2`: `न अन्विष्यति` → `न अन्विच्छति`.
8. sa `bodyOnboardingSlide2`: "वञ्चकाः यथार्थसङ्केतानाम् उपरि कृतक-QR-पत्रिकाः
   लिम्पन्ति। यदा भवान् चित्रग्राहिणा जालबन्धं धनप्रदानसङ्केतं वा संवीक्षते,
   तदा उद्घाटनात् धनप्रदानात् वा पूर्वं किं परीक्षणीयम् इति क्विशिंग-रक्षकः
   स्मारयति।"
9. Run `flutter gen-l10n`, the Sanskrit Hindi-marker check, `dart format`,
   `flutter analyze`, `flutter test`.

### C. What stays with you

- **Native review:** this pass does not replace a real native reader. The
  change log will list every new or changed ml/sa line again, so a reader can
  check them in one go.
- **Play Console:** paste the new full-description text, and upload the retaken
  screenshot 4, at your next store update. I will not publish anything.

## Files to be changed

- `play_store_private/store_listing.md` (private, gitignored, not committed)
- `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, `lib/l10n/app_sa.arb`
- `lib/l10n/gen/*` (generated)
- `change_log/<timestamp>_quishing_store_and_translation_followup.md` (new)
- Not touched: screenshot image files, `docs/guidelines/`, any code.
