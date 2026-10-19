# QuishingGuard follow-up: store listing text and translation fixes

Implements plan: `plans/20261018_120933_quishing_store_and_translation_followup.md`.
Follows `change_log/20261018_113937_quishing_guard_honest.md`.

## What changed

### Store listing (private notes, gitignored, not committed)
- `play_store_private/store_listing.md`:
  - Full description: the section **SPOT TAMPERED QR CODES** is now **FAKE STICKER
    CHECK**, and its line no longer says the app looks for signs of a sticker. It now says
    Quishing Guard reminds the user what to check before opening a link or paying.
  - Screenshot 4 is marked **do not upload until retaken**, because it shows the removed
    "Genuine · 21%" score card. Added steps to retake it, and the caption is now "Check
    payment QR codes / Check for fake stickers".
  - Added an "Updated" date line.
- The Play short description needed no change (it never mentioned tamper detection).
- No image files were changed.

### Translation fixes (`lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb`, then `flutter gen-l10n`)
- `bodyStickerCheckIntro` (en, ml, sa): now says the app cannot *spot a sticker in the
  camera picture*, instead of "cannot see a sticker through the camera".
- `labelFeatureQuishingGuardChip2`: ml `സ്വയം പരിശോധന`, sa `स्वयंपरीक्षा`
  ("check it yourself", in place of the odd "hand check").
- `labelFeatureQuishingGuardChip3` (ml): plural `പണമിടപാട് നുറുങ്ങുകൾ`.
- `helpGuideQuishingCvBullet2` (sa): verb fixed, `अन्विष्यति` → `अन्विच्छति`.
- `bodyOnboardingSlide2` (sa): sentence rebuilt as "when you scan …, QuishingGuard
  reminds you …", so the user does the scanning, not QuishingGuard.

## Checks
- Sanskrit Hindi-marker check (`tool/check_sanskrit_hindi_markers.sh`): passes.
- `dart format`: clean. `flutter analyze`: no issues. `flutter test`: all 808 pass.

## Still for you to do
- Retake screenshot 4 on a phone with a **test** UPI QR code, then upload it.
- Paste the new full-description text into the Play Console at the next store update.
- **Native-reader review.** These fixes come from a careful re-read, not from a native
  speaker. Please have a Malayalam reader and a Sanskrit reader check every line below.
  All of them were added or rewritten for QuishingGuard.

## Lines for native review

### `titleStickerCheck`

- en: Fake sticker check
- ml: സ്റ്റിക്കർ പരിശോധന
- sa: कृतकपत्रिका-परीक्षा

### `tooltipStickerCheckExpand`

- en: Show checks
- ml: പരിശോധനകൾ കാണിക്കുക
- sa: परीक्षाः दर्शयतु

### `tooltipStickerCheckCollapse`

- en: Hide checks
- ml: പരിശോധനകൾ മറയ്ക്കുക
- sa: परीक्षाः गोपयतु

### `bodyStickerCheckIntro`

- en: Scammers stick their own QR code over the real one. This app cannot spot a sticker in the camera picture, so please check it yourself:
- ml: തട്ടിപ്പുകാർ യഥാർത്ഥ കോഡിനു മുകളിൽ സ്വന്തം QR കോഡ് ഒട്ടിക്കാറുണ്ട്. ക്യാമറ ചിത്രത്തിൽ നിന്ന് സ്റ്റിക്കർ തിരിച്ചറിയാൻ ഈ ആപ്പിന് കഴിയില്ല, അതിനാൽ നിങ്ങൾ തന്നെ പരിശോധിക്കുക:
- sa: वञ्चकाः यथार्थसङ्केतस्य उपरि स्वकीयं QR-सङ्केतं लिम्पन्ति। अयम् अनुप्रयोगः चित्रग्राहिणः चित्रे पत्रिकाम् अभिज्ञातुं न शक्नोति, अतः भवान् स्वयं परीक्षताम्:

### `bodyStickerCheckEdges`

- en: Look at the code and feel it with your finger. A sticker on top often has raised edges or sits crooked.
- ml: കോഡ് നോക്കുകയും വിരൽ കൊണ്ട് തൊട്ടുനോക്കുകയും ചെയ്യുക. മുകളിൽ ഒട്ടിച്ച സ്റ്റിക്കറിന് പലപ്പോഴും ഉയർന്ന അരികുകൾ ഉണ്ടാകും, അല്ലെങ്കിൽ ചരിഞ്ഞിരിക്കും.
- sa: सङ्केतं पश्यतु, अङ्गुल्या स्पृष्ट्वा अनुभवतु च। उपरि लेपितायाः पत्रिकायाः धाराः प्रायः उन्नताः भवन्ति, सा वक्रा वा तिष्ठति।

### `bodyStickerCheckPayee`

- en: Before you pay, check that the name on the payment screen matches the shop.
- ml: പണം നൽകുന്നതിനു മുൻപ്, പണമിടപാട് സ്ക്രീനിലെ പേര് കടയുടേതു തന്നെയാണോ എന്ന് ഉറപ്പാക്കുക.
- sa: धनप्रदानात् पूर्वं धनप्रेषणपटले नाम आपणस्य नाम्ना समानम् इति निश्चिनोतु।

### `bodyStickerCheckAsk`

- en: If in doubt, ask the staff, or type the website address yourself.
- ml: സംശയമുണ്ടെങ്കിൽ ജീവനക്കാരോടു ചോദിക്കുക, അല്ലെങ്കിൽ വെബ്സൈറ്റ് വിലാസം സ്വയം ടൈപ്പ് ചെയ്യുക.
- sa: संशये सति कर्मचारिणः पृच्छतु, अथवा जालसङ्केतं स्वयं लिखतु।

### `descFeatureQuishingGuard`

- en: Reminds you to check printed QR codes for fake stickers before you open a link or pay. It gives you quick checks to do by hand; it does not examine the picture.
- ml: ലിങ്ക് തുറക്കുന്നതിനോ പണം നൽകുന്നതിനോ മുൻപ്, അച്ചടിച്ച QR കോഡിൽ വ്യാജ സ്റ്റിക്കർ ഉണ്ടോ എന്നു പരിശോധിക്കാൻ ഓർമ്മിപ്പിക്കുന്നു. കൈകൊണ്ടു ചെയ്യാവുന്ന ലളിതമായ പരിശോധനകൾ നൽകുന്നു; ചിത്രം പരിശോധിക്കുന്നില്ല.
- sa: जालबन्धस्य उद्घाटनात् धनप्रदानात् वा पूर्वं मुद्रिते QR-सङ्केते कृतकपत्रिका अस्ति वा इति परीक्षितुं स्मारयति। हस्तेन कर्तव्याः लघुपरीक्षाः ददाति; चित्रं न परीक्षते।

### `labelFeatureQuishingGuardChip1`

- en: Fake stickers
- ml: വ്യാജ സ്റ്റിക്കർ
- sa: कृतकपत्रिकाः

### `labelFeatureQuishingGuardChip2`

- en: Hand checks
- ml: സ്വയം പരിശോധന
- sa: स्वयंपरीक्षा

### `labelFeatureQuishingGuardChip3`

- en: Payment tips
- ml: പണമിടപാട് നുറുങ്ങുകൾ
- sa: धनप्रदान-सूचनाः

### `labelOnboardingSlide2Badge`

- en: Scam stickers
- ml: തട്ടിപ്പ് സ്റ്റിക്കർ
- sa: वञ्चक-पत्रिकाः

### `titleOnboardingSlide2`

- en: Fake sticker check
- ml: സ്റ്റിക്കർ പരിശോധന
- sa: कृतकपत्रिका-परीक्षा

### `bodyOnboardingSlide2`

- en: Scammers paste fake QR stickers over real ones. When you scan a link or a payment code with the camera, QuishingGuard reminds you what to check before you open it or pay.
- ml: തട്ടിപ്പുകാർ യഥാർത്ഥ കോഡുകൾക്കു മുകളിൽ വ്യാജ QR സ്റ്റിക്കറുകൾ ഒട്ടിക്കാറുണ്ട്. ക്യാമറ കൊണ്ട് ലിങ്കോ പണമിടപാട് കോഡോ സ്കാൻ ചെയ്യുമ്പോൾ, തുറക്കുന്നതിനോ പണം നൽകുന്നതിനോ മുൻപ് എന്തു പരിശോധിക്കണമെന്ന് ക്വിഷിംഗ് ഗാർഡ് ഓർമ്മിപ്പിക്കും.
- sa: वञ्चकाः यथार्थसङ्केतानाम् उपरि कृतक-QR-पत्रिकाः लिम्पन्ति। यदा भवान् चित्रग्राहिणा जालबन्धं धनप्रदानसङ्केतं वा संवीक्षते, तदा उद्घाटनात् धनप्रदानात् वा पूर्वं किं परीक्षणीयम् इति क्विशिंग-रक्षकः स्मारयति।

### `bodyOnboardingSlide2Bullet1`

- en: Feel for raised sticker edges
- ml: സ്റ്റിക്കറിന്റെ ഉയർന്ന അരികുകൾ തൊട്ടുനോക്കുക
- sa: पत्रिकायाः उन्नतधाराः स्पृशतु

### `bodyOnboardingSlide2Bullet2`

- en: Check the payee name
- ml: പണം വാങ്ങുന്നയാളുടെ പേര് ഉറപ്പാക്കുക
- sa: धनग्राहकस्य नाम परीक्षताम्

### `bodyOnboardingSlide2Bullet3`

- en: Ask the staff when in doubt
- ml: സംശയമുണ്ടെങ്കിൽ ജീവനക്കാരോടു ചോദിക്കുക
- sa: संशये कर्मचारिणः पृच्छतु

### `helpGuideQuishingCvBullet1`

- en: When you scan a link or a payment code with the camera, the result screen shows a small QuishingGuard card: Fake sticker check.
- ml: ക്യാമറ കൊണ്ട് ലിങ്കോ പണമിടപാട് കോഡോ സ്കാൻ ചെയ്യുമ്പോൾ, ഫല സ്ക്രീനിൽ ‘സ്റ്റിക്കർ പരിശോധന’ എന്ന ചെറിയ ക്വിഷിംഗ് ഗാർഡ് കാർഡ് കാണാം.
- sa: चित्रग्राहिणा जालबन्धस्य धनप्रदानसङ्केतस्य वा संवीक्षानन्तरं परिणाम-पटले "कृतकपत्रिका-परीक्षा" इति लघु क्विशिंग-रक्षक-पत्रं दृश्यते।

### `helpGuideQuishingCvBullet2`

- en: Tap it to open a short list of checks. The app does not look for stickers in the picture and gives no score, so it cannot tell you that a code is safe.
- ml: അതിൽ തൊട്ടാൽ ചെറിയൊരു പരിശോധനാ പട്ടിക തുറക്കും. ആപ്പ് ചിത്രത്തിൽ സ്റ്റിക്കർ തിരയുന്നില്ല, സ്കോറും നൽകുന്നില്ല; അതിനാൽ ഒരു കോഡ് സുരക്ഷിതമാണെന്ന് ഇതിനു പറയാൻ കഴിയില്ല.
- sa: तत् स्पृष्ट्वा परीक्षाणां लघुसूची उद्घाट्यते। अनुप्रयोगः चित्रे पत्रिकां न अन्विच्छति, अङ्कं च न ददाति; अतः सङ्केतः सुरक्षितः इति वक्तुं न शक्नोति।

### `helpGuideQuishingCvBullet3`

- en: The card does not appear for photos, the clipboard, screen scans or plain text, because those codes are not stuck on a wall.
- ml: ഫോട്ടോ, ക്ലിപ്പ്ബോർഡ്, സ്ക്രീൻ സ്കാൻ, സാധാരണ എഴുത്ത് എന്നിവയ്ക്ക് ഈ കാർഡ് കാണിക്കില്ല, കാരണം അവ ചുമരിൽ ഒട്ടിച്ചവയല്ല.
- sa: छायाचित्राणां, फलकस्य, पटल-संवीक्षायाः, सामान्यपाठस्य च कृते इदं पत्रं न दृश्यते, यतः ते सङ्केताः भित्तौ न लिप्ताः।
