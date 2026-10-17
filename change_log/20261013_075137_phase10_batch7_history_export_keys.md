# Phase 10 batch 7 — history, export and backup keys

Implements batch 7 (history, export, restore, report and backup keys) of `plans/20261013_071846_phase10_arb_key_prefixes.md`.

## What changed

- Renamed the `history*`, `export*`, `restore*`, `report*` and `backup*` ARB keys to the
  standard prefixes in all three ARB files and in the Dart code. Regenerated `lib/l10n/gen/`.
  Field hints became `help…`; empty-list texts `empty…`; backup errors `error…`; the TXT/PDF
  report column names `label…`. The padded report labels (for the aligned TXT report) keep
  their trailing spaces.
- Fields of `HistoryReportLabels` that share names with keys (`reportHeading` and others) were
  not renamed.
- Shortened titles, buttons and field labels that were over the label budget, in all three
  languages (see "Changed values"). "Export & Cloud Backup" became "Export & backup",
  because the app has no cloud backup.
- History glossary alignment (language pack glossary: History = ml നാൾവഴി, sa इतिवृत्तम्).
  Every ml value with ചരിത്രം / ഹിസ്റ്ററി and every sa value with इतिहासः now uses the
  glossary term, including `tabHistory`. In Sanskrit the noun changes from masculine to
  neuter, so the words that agree with it changed too (for example सर्वः → सर्वं,
  विलोपनीयः → विलोपनीयम्). The full list is below. Keys from later batches (feature, help,
  airQr) are listed under their current names.

## Checks

`flutter analyze` clean, all 687 tests pass, `dart format` applied, Sanskrit Hindi-marker
gate passes.

## Native-reader review

- All glossary changes below (ml and sa), especially the sa gender agreement.
- `titleRestore` ml "ബാക്കപ്പിൽ നിന്ന്:" (short form; it means "From backup:").
- `titleRestoreDialog` ml "ബാക്കപ്പ് പുനഃസ്ഥാപിക്കൽ", sa "सञ्चय-पुनःस्थापनम्".

## History glossary changes (53)

| Key | Language | Before | After |
|---|---|---|---|
| `bodyPdfSavedToHistory` | ml | {count} കോഡുകൾ ചരിത്രത്തിൽ സൂക്ഷിച്ചു. | {count} കോഡുകൾ നാൾവഴിയിൽ സൂക്ഷിച്ചു. |
| `exportShareText` | ml | ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ സ്കാൻ ചരിത്ര കയറ്റുമതി | ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ സ്കാൻ നാൾവഴി കയറ്റുമതി |
| `exportSharePdfText` | ml | ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ സ്കാൻ ചരിത്ര റിപ്പോർട്ട് (PDF) | ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ സ്കാൻ നാൾവഴി റിപ്പോർട്ട് (PDF) |
| `restoreHeading` | ml | ബാക്കപ്പ് ഫയലിൽ നിന്ന് ചരിത്രം പുനഃസ്ഥാപിക്കുക: | ബാക്കപ്പ് ഫയലിൽ നിന്ന് നാൾവഴി പുനഃസ്ഥാപിക്കുക: |
| `historyScreenTitle` | ml | സ്കാൻ ചരിത്രം | സ്കാൻ നാൾവഴി |
| `historyClearTitle` | ml | ചരിത്രം മുഴുവൻ മായ്ക്കണമോ? | നാൾവഴി മുഴുവൻ മായ്ക്കണമോ? |
| `historyClearMessage` | ml | സ്കാൻ ചരിത്രം മുഴുവൻ ഇല്ലാതാക്കണമെന്ന് ഉറപ്പാണോ? ബാക്കപ്പ് എടുത്തിട്ടില്ലെങ്കിൽ ഇത് തിരിച്ചെടുക്കാനാവില്ല. | സ്കാൻ നാൾവഴി മുഴുവൻ ഇല്ലാതാക്കണമെന്ന് ഉറപ്പാണോ? ബാക്കപ്പ് എടുത്തിട്ടില്ലെങ്കിൽ ഇത് തിരിച്ചെടുക്കാനാവില്ല. |
| `historySearchHint` | ml | ചരിത്രത്തിൽ തിരയുക... | നാൾവഴിയിൽ തിരയുക... |
| `actionMenuHistory` | ml | ചരിത്രം | നാൾവഴി |
| `reportHeading` | ml | ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ - സ്കാൻ ചരിത്രം | ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ - സ്കാൻ നാൾവഴി |
| `reportTitle` | ml | സ്കാൻ ചരിത്ര കയറ്റുമതി | സ്കാൻ നാൾവഴി കയറ്റുമതി |
| `featuresCatHistoryName` | ml | ചരിത്രം, ബാക്കപ്പ്, സ്വകാര്യതാ നിലവറ | നാൾവഴി, ബാക്കപ്പ്, സ്വകാര്യതാ നിലവറ |
| `featuresCatHistorySubtitle` | ml | ബയോമെട്രിക് സുരക്ഷയും ഓഫ്‌ലൈൻ സംഭരണവും കൊണ്ട് സംരക്ഷിക്കുന്ന നിങ്ങളുടെ സ്കാൻ ചരിത്രം | ബയോമെട്രിക് സുരക്ഷയും ഓഫ്‌ലൈൻ സംഭരണവും കൊണ്ട് സംരക്ഷിക്കുന്ന നിങ്ങളുടെ സ്കാൻ നാൾവഴി |
| `featureScanHistoryTitle` | ml | സമ്പൂർണ്ണ ഓഫ്‌ലൈൻ സ്കാൻ ചരിത്രം | സമ്പൂർണ്ണ ഓഫ്‌ലൈൻ സ്കാൻ നാൾവഴി |
| `featureBackupsDesc` | ml | മുഴുവൻ സ്കാൻ ചരിത്രവും CSV സ്പ്രെഡ്ഷീറ്റായോ എൻക്രിപ്റ്റ് ചെയ്ത JSON ബാക്കപ്പായോ കയറ്റുമതി ചെയ്യാം. ഒറ്റ ടാപ്പിൽ പുനഃസ്ഥാപിക്കാം. | മുഴുവൻ സ്കാൻ നാൾവഴിയും CSV സ്പ്രെഡ്ഷീറ്റായോ എൻക്രിപ്റ്റ് ചെയ്ത JSON ബാക്കപ്പായോ കയറ്റുമതി ചെയ്യാം. ഒറ്റ ടാപ്പിൽ പുനഃസ്ഥാപിക്കാം. |
| `airQrSyncIncludeHistory` | ml | സ്കാൻ ഹിസ്റ്ററി ഉൾപ്പെടുത്തുക ({count}) | സ്കാൻ നാൾവഴി ഉൾപ്പെടുത്തുക ({count}) |
| `airQrSyncNoDataWarning` | ml | ഹിസ്റ്ററിയോ ക്രമീകരണങ്ങളോ തിരഞ്ഞെടുക്കുക. | നാൾവഴിയോ ക്രമീകരണങ്ങളോ തിരഞ്ഞെടുക്കുക. |
| `airQrSyncRestoreHistory` | ml | സ്കാൻ ഹിസ്റ്ററി പുനഃസ്ഥാപിക്കുക | സ്കാൻ നാൾവഴി പുനഃസ്ഥാപിക്കുക |
| `tabHistory` | ml | ഹിസ്റ്ററി | നാൾവഴി |
| `helpGuideBarcodePdfBullet3` | ml | കണ്ടെത്തിയ എല്ലാ കോഡുകളും പ്രത്യേക ബോട്ടം ഷീറ്റിൽ പരിശോധിച്ച്, ഒറ്റ ടാപ്പിൽ സ്കാൻ ചരിത്രത്തിൽ സേവ് ചെയ്യാം. | കണ്ടെത്തിയ എല്ലാ കോഡുകളും പ്രത്യേക ബോട്ടം ഷീറ്റിൽ പരിശോധിച്ച്, ഒറ്റ ടാപ്പിൽ സ്കാൻ നാൾവഴിയിൽ സേവ് ചെയ്യാം. |
| `helpGuideArCodeVisionBatchBullet3` | ml | തിരഞ്ഞെടുത്ത എല്ലാ ഉള്ളടക്കവും ഒറ്റ ടാപ്പിൽ പകർത്താം, അല്ലെങ്കിൽ ചരിത്രത്തിലേക്ക് മാറ്റാം. | തിരഞ്ഞെടുത്ത എല്ലാ ഉള്ളടക്കവും ഒറ്റ ടാപ്പിൽ പകർത്താം, അല്ലെങ്കിൽ നാൾവഴിയിലേക്ക് മാറ്റാം. |
| `titleHelpHistory` | ml | ചരിത്രവും സ്വകാര്യതയും | നാൾവഴിയും സ്വകാര്യതയും |
| `helpGuideHistoryName` | ml | ചരിത്രം, ബാക്കപ്പ്, സ്വകാര്യത | നാൾവഴി, ബാക്കപ്പ്, സ്വകാര്യത |
| `helpGuideHistoryIntro` | ml | നിങ്ങളുടെ സ്കാൻ രേഖകൾ നിങ്ങളുടേത് മാത്രമാണ്. ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ എല്ലാ ചരിത്ര വിവരങ്ങളും നിങ്ങളുടെ ഉപകരണത്തിലെ ഒരു ലോക്കൽ SQLite ഡാറ്റാബേസിൽ സൂക്ഷിക്കുന്നു. ബയോമെട്രിക് സംരക്ഷണവും ക്രമീകൃത എക്സ്പോർട്ട് ഫോർമാറ്റുകളും ഇതിനൊപ്പമുണ്ട്. | നിങ്ങളുടെ സ്കാൻ രേഖകൾ നിങ്ങളുടേത് മാത്രമാണ്. ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ എല്ലാ നാൾവഴി വിവരങ്ങളും നിങ്ങളുടെ ഉപകരണത്തിലെ ഒരു ലോക്കൽ SQLite ഡാറ്റാബേസിൽ സൂക്ഷിക്കുന്നു. ബയോമെട്രിക് സംരക്ഷണവും ക്രമീകൃത എക്സ്പോർട്ട് ഫോർമാറ്റുകളും ഇതിനൊപ്പമുണ്ട്. |
| `helpGuideHistoryManageTitle` | ml | സ്കാൻ ചരിത്രം കൈകാര്യം ചെയ്യൽ | സ്കാൻ നാൾവഴി കൈകാര്യം ചെയ്യൽ |
| `helpGuideHistoryManageBullet1` | ml | തിരയലും ഫിൽട്ടറും: വാക്കുകൾ ഉപയോഗിച്ച് സ്കാൻ ചരിത്രം തത്സമയം തിരയാം, അല്ലെങ്കിൽ ഉള്ളടക്ക തരം (URL, Wi-Fi, കോൺടാക്റ്റുകൾ, പേയ്‌മെന്റുകൾ, TOTP) അനുസരിച്ച് ഫിൽട്ടർ ചെയ്യാം. | തിരയലും ഫിൽട്ടറും: വാക്കുകൾ ഉപയോഗിച്ച് സ്കാൻ നാൾവഴി തത്സമയം തിരയാം, അല്ലെങ്കിൽ ഉള്ളടക്ക തരം (URL, Wi-Fi, കോൺടാക്റ്റുകൾ, പേയ്‌മെന്റുകൾ, TOTP) അനുസരിച്ച് ഫിൽട്ടർ ചെയ്യാം. |
| `helpGuideHistoryBackupBullet1` | ml | JSON പൂർണ്ണ ബാക്കപ്പ്: ടാഗുകൾ, പ്രിയപ്പെട്ടവ, സുരക്ഷാ ഫലങ്ങൾ എന്നിവ ഉൾപ്പെടെ മുഴുവൻ ചരിത്രവും എവിടെയും കൊണ്ടുപോകാവുന്ന ഒരു .json ഫയലിലേക്ക് എക്സ്പോർട്ട് ചെയ്യുന്നു. | JSON പൂർണ്ണ ബാക്കപ്പ്: ടാഗുകൾ, പ്രിയപ്പെട്ടവ, സുരക്ഷാ ഫലങ്ങൾ എന്നിവ ഉൾപ്പെടെ മുഴുവൻ നാൾവഴിയും എവിടെയും കൊണ്ടുപോകാവുന്ന ഒരു .json ഫയലിലേക്ക് എക്സ്പോർട്ട് ചെയ്യുന്നു. |
| `helpGuideHistoryTip` | ml | നുറുങ്ങ്: ഫോൺ മാറ്റുന്നതിനോ റീസെറ്റ് ചെയ്യുന്നതിനോ മുമ്പ്, സേവ് ചെയ്ത സ്കാനുകൾ നഷ്ടപ്പെടാതിരിക്കാൻ ചരിത്രം ഒരു JSON ഫയലിലേക്ക് ബാക്കപ്പ് ചെയ്യുക. | നുറുങ്ങ്: ഫോൺ മാറ്റുന്നതിനോ റീസെറ്റ് ചെയ്യുന്നതിനോ മുമ്പ്, സേവ് ചെയ്ത സ്കാനുകൾ നഷ്ടപ്പെടാതിരിക്കാൻ നാൾവഴി ഒരു JSON ഫയലിലേക്ക് ബാക്കപ്പ് ചെയ്യുക. |
| `bodyPdfSavedToHistory` | sa | {count} सङ्केताः इतिहासे रक्षिताः। | {count} सङ्केताः इतिवृत्ते रक्षिताः। |
| `exportShareText` | sa | श्रीराज्-क्यू-आर-संवीक्षा-इतिहास-निर्यातः | श्रीराज्-क्यू-आर-संवीक्षा-इतिवृत्त-निर्यातः |
| `exportSharePdfText` | sa | श्रीराज्-क्यू-आर-संवीक्षा-इतिहास-पत्रम् (PDF) | श्रीराज्-क्यू-आर-संवीक्षा-इतिवृत्त-पत्रम् (PDF) |
| `restoreHeading` | sa | गूढ-सञ्चयात् इतिहासः पुनःस्थाप्यताम्: | गूढ-सञ्चयात् इतिवृत्तं पुनःस्थाप्यताम्: |
| `historyScreenTitle` | sa | संवीक्षा-इतिहासः | संवीक्षा-इतिवृत्तम् |
| `historyClearTitle` | sa | इतिहासः प्रमृज्यतां वा? | इतिवृत्तं प्रमृज्यतां वा? |
| `historyClearMessage` | sa | किं सर्वः संवीक्षा-इतिहासः विलोपनीयः? विना सञ्चयं कृत्वा पुनः न लभ्यते। | किं सर्वं संवीक्षा-इतिवृत्तं विलोपनीयम्? विना सञ्चयं कृत्वा पुनः न लभ्यते। |
| `historySearchHint` | sa | इतिहासेऽन्विष्यताम्... | इतिवृत्तेऽन्विष्यताम्... |
| `actionMenuHistory` | sa | इतिहासः | इतिवृत्तम् |
| `reportHeading` | sa | श्रीराज् पि क्यू-आर-कार्यशाला - संवीक्षा-इतिहासः | श्रीराज् पि क्यू-आर-कार्यशाला - संवीक्षा-इतिवृत्तम् |
| `reportTitle` | sa | इतिहास-निर्यातः | इतिवृत्त-निर्यातः |
| `featuresCatHistoryName` | sa | इतिहासः, सञ्चयः, गोपनीयता-कोशः च | इतिवृत्तम्, सञ्चयः, गोपनीयता-कोशः च |
| `featuresCatHistorySubtitle` | sa | जैविक-सुरक्षया स्थानीय-सञ्चयेन च रक्षितः भवतः अन्वीक्षण-इतिहासः | जैविक-सुरक्षया स्थानीय-सञ्चयेन च रक्षितं भवतः अन्वीक्षण-इतिवृत्तम् |
| `featureScanHistoryTitle` | sa | सम्पूर्णः स्थानीय-अन्वीक्षण-इतिहासः | सम्पूर्णं स्थानीय-अन्वीक्षण-इतिवृत्तम् |
| `featureBackupsDesc` | sa | सम्पूर्णम् अन्वीक्षण-इतिहासं CSV-सारणीरूपेण गूढ-JSON-सञ्चयरूपेण वा निर्यातयतु। एकस्पर्शेन पुनःस्थापनम्। | सम्पूर्णम् अन्वीक्षण-इतिवृत्तं CSV-सारणीरूपेण गूढ-JSON-सञ्चयरूपेण वा निर्यातयतु। एकस्पर्शेन पुनःस्थापनम्। |
| `tabHistory` | sa | इतिहासः | इतिवृत्तम् |
| `helpGuideBarcodePdfBullet3` | sa | लब्धान् सर्वान् सङ्केतान् विशिष्टे अधःपत्रे परीक्ष्य एकेन स्पर्शेन संवीक्षा-इतिहासे रक्षतु। | लब्धान् सर्वान् सङ्केतान् विशिष्टे अधःपत्रे परीक्ष्य एकेन स्पर्शेन संवीक्षा-इतिवृत्ते रक्षतु। |
| `helpGuideArCodeVisionBatchBullet3` | sa | चितानां सर्वेषां विषयम् एकेन स्पर्शेन प्रतिलिखतु, इतिहासे वा निर्यातयतु। | चितानां सर्वेषां विषयम् एकेन स्पर्शेन प्रतिलिखतु, इतिवृत्ते वा निर्यातयतु। |
| `titleHelpHistory` | sa | इतिहासः गोपनीयता च | इतिवृत्तं गोपनीयता च |
| `helpGuideHistoryName` | sa | इतिहासः, प्रतिलिपिः, गोपनीयता च | इतिवृत्तम्, प्रतिलिपिः, गोपनीयता च |
| `helpGuideHistoryIntro` | sa | भवतः संवीक्षा-अभिलेखाः केवलं भवतः एव। श्रीराज् पि क्यू-आर-कार्यशाला सर्वान् इतिहास-अभिलेखान् भवतः यन्त्रे स्थानीये SQLite-दत्तांशकोशे रक्षति, जैवमापन-प्रमाणीकरण-रक्षया सुव्यवस्थित-निर्यात-प्रारूपैः च सह। | भवतः संवीक्षा-अभिलेखाः केवलं भवतः एव। श्रीराज् पि क्यू-आर-कार्यशाला सर्वान् इतिवृत्त-अभिलेखान् भवतः यन्त्रे स्थानीये SQLite-दत्तांशकोशे रक्षति, जैवमापन-प्रमाणीकरण-रक्षया सुव्यवस्थित-निर्यात-प्रारूपैः च सह। |
| `helpGuideHistoryManageTitle` | sa | संवीक्षा-इतिहास-प्रबन्धनम् | संवीक्षा-इतिवृत्त-प्रबन्धनम् |
| `helpGuideHistoryManageBullet1` | sa | अन्वेषणं पृथक्करणं च: पाठेन संवीक्षा-इतिहासं तत्क्षणम् अन्विष्यतु, विषय-प्रकारानुसारं (URL, Wi-Fi, सम्पर्काः, देयानि, TOTP) वा पृथक् करोतु। | अन्वेषणं पृथक्करणं च: पाठेन संवीक्षा-इतिवृत्तं तत्क्षणम् अन्विष्यतु, विषय-प्रकारानुसारं (URL, Wi-Fi, सम्पर्काः, देयानि, TOTP) वा पृथक् करोतु। |
| `helpGuideHistoryBackupBullet1` | sa | JSON-पूर्णप्रतिलिपिः: स्वकीय-अङ्कनानि, प्रियाः, सुरक्षा-परिणामाः च इत्येतैः सहितं सम्पूर्णम् इतिहासं सुवहनीयायां .json-सञ्चिकायां निर्यातयति। | JSON-पूर्णप्रतिलिपिः: स्वकीय-अङ्कनानि, प्रियाः, सुरक्षा-परिणामाः च इत्येतैः सहितं सम्पूर्णम् इतिवृत्तं सुवहनीयायां .json-सञ्चिकायां निर्यातयति। |
| `helpGuideHistoryTip` | sa | सूचना: दूरवाणी-परिवर्तनात् पुनःस्थापनात् वा पूर्वं रक्षितानां संवीक्षाणां रक्षणाय इतिहासस्य JSON-प्रतिलिपिं रचयतु। | सूचना: दूरवाणी-परिवर्तनात् पुनःस्थापनात् वा पूर्वं रक्षितानां संवीक्षाणां रक्षणाय इतिवृत्तस्य JSON-प्रतिलिपिं रचयतु। |

## Renamed keys (95)

| Old key | New key |
|---|---|
| `historyTimestamp` | `bodyHistoryTimestamp` |
| `historyStar` | `tooltipHistoryStar` |
| `historyUnstar` | `tooltipHistoryUnstar` |
| `historyEditNotes` | `actionHistoryEditNotes` |
| `historyCopyString` | `tooltipHistoryCopyString` |
| `historyShare` | `actionHistoryShare` |
| `historyDelete` | `actionHistoryDelete` |
| `historyDetailTitle` | `titleHistoryDetail` |
| `historySafetyBadge` | `labelHistorySafetyBadge` |
| `historyScoreBadge` | `labelHistoryScoreBadge` |
| `historyScannedContent` | `labelHistoryScannedContent` |
| `historyCopyButton` | `actionHistoryCopy` |
| `historyNotesLabel` | `labelHistoryNotes` |
| `historyNotesHint` | `helpHistoryNotes` |
| `historyLocationLabel` | `labelHistoryLocation` |
| `historyLocationHint` | `helpHistoryLocation` |
| `historySaveChanges` | `actionHistorySaveChanges` |
| `exportDialogTitle` | `titleExportDialog` |
| `restoreDialogTitle` | `titleRestoreDialog` |
| `exportRecordsTab` | `tabExportRecords` |
| `restoreBackupTab` | `tabRestoreBackup` |
| `exportFormatHeading` | `titleExportFormat` |
| `exportCsvTitle` | `labelExportCsv` |
| `exportCsvSubtitle` | `descExportCsv` |
| `exportJsonTitle` | `labelExportJson` |
| `exportJsonSubtitle` | `descExportJson` |
| `exportTxtTitle` | `labelExportTxt` |
| `exportTxtSubtitle` | `descExportTxt` |
| `exportPdfTitle` | `labelExportPdf` |
| `exportPdfSubtitle` | `descExportPdf` |
| `exportBackupHeading` | `titleExportBackup` |
| `exportPassphraseLabel` | `labelExportPassphrase` |
| `exportPassphraseHint` | `helpExportPassphrase` |
| `exportPassphraseRequired` | `errorExportPassphraseRequired` |
| `exportCreateBackupButton` | `actionExportCreateBackup` |
| `exportShareText` | `bodyExportShare` |
| `exportSharePdfText` | `bodyExportSharePdf` |
| `exportShareBackupText` | `bodyExportShareBackup` |
| `restoreHeading` | `titleRestore` |
| `restorePassphraseLabel` | `labelRestorePassphrase` |
| `restorePayloadLabel` | `labelRestorePayload` |
| `restorePayloadHint` | `helpRestorePayload` |
| `restoreFieldsRequired` | `errorRestoreFieldsRequired` |
| `restoreButton` | `actionRestore` |
| `restoreSuccess` | `bodyRestoreSuccess` |
| `restoreFailed` | `errorRestoreFailed` |
| `historyScreenTitle` | `titleHistoryScreen` |
| `historyExportTooltip` | `tooltipHistoryExport` |
| `historyClearAll` | `actionHistoryClearAll` |
| `historyClearTitle` | `titleHistoryClear` |
| `historyClearMessage` | `bodyHistoryClear` |
| `historySearchHint` | `helpHistorySearch` |
| `historyFilterAll` | `labelHistoryFilterAll` |
| `historyFilterStarred` | `labelHistoryFilterStarred` |
| `historyFilterUrls` | `labelHistoryFilterUrls` |
| `historyFilterWifi` | `labelHistoryFilterWifi` |
| `historyFilterContacts` | `labelHistoryFilterContacts` |
| `historyFilterText` | `labelHistoryFilterText` |
| `historyFilterBarcodes` | `labelHistoryFilterBarcodes` |
| `historyEmptyTitle` | `emptyHistoryTitle` |
| `historyEmptyMessage` | `emptyHistoryMessage` |
| `historyNoMatches` | `emptyHistoryNoMatches` |
| `backupInvalidFormat` | `errorBackupInvalidFormat` |
| `backupBadHeader` | `errorBackupBadHeader` |
| `backupWrongPassphrase` | `errorBackupWrongPassphrase` |
| `reportHeading` | `bodyReportHeading` |
| `reportTitle` | `bodyReportTitle` |
| `reportExportDate` | `labelReportExportDate` |
| `reportTotalScans` | `labelReportTotalScans` |
| `reportScanNumber` | `labelReportScanNumber` |
| `reportId` | `labelReportId` |
| `reportTimestamp` | `labelReportTimestamp` |
| `reportFormat` | `labelReportFormat` |
| `reportCategory` | `labelReportCategory` |
| `reportSafetyScore` | `labelReportSafetyScore` |
| `reportStarred` | `labelReportStarred` |
| `reportStarredYes` | `labelReportStarredYes` |
| `reportStarredNo` | `labelReportStarredNo` |
| `reportLocation` | `labelReportLocation` |
| `reportNotes` | `labelReportNotes` |
| `reportContent` | `labelReportContent` |
| `reportColumnDateTime` | `labelReportColumnDateTime` |
| `reportColumnFormat` | `labelReportColumnFormat` |
| `reportColumnCategory` | `labelReportColumnCategory` |
| `reportColumnSafety` | `labelReportColumnSafety` |
| `reportColumnContent` | `labelReportColumnContent` |
| `reportColumnNotes` | `labelReportColumnNotes` |
| `historyFilterEmail` | `labelHistoryFilterEmail` |
| `historyFilterPhone` | `labelHistoryFilterPhone` |
| `historyFilterSms` | `labelHistoryFilterSms` |
| `historyFilterAppLink` | `labelHistoryFilterAppLink` |
| `historyFilterProductBarcode` | `labelHistoryFilterProductBarcode` |
| `historyFilterIsbn` | `labelHistoryFilterIsbn` |
| `historySourceScreen` | `labelHistorySourceScreen` |
| `historyRecordCount` | `bodyHistoryRecordCount` |

## Changed values

| Key | Language | Before | After |
|---|---|---|---|
| `labelHistoryLocation` | en | Location Tag (Optional) | Location (optional) |
| `actionHistorySaveChanges` | en | Save Metadata Changes | Save changes |
| `titleExportDialog` | en | Export & Cloud Backup | Export & backup |
| `titleRestoreDialog` | en | Restore Encrypted Backup | Restore backup |
| `titleExportFormat` | en | Select Export Format: | Export format: |
| `labelExportTxt` | en | Formatted TXT Report (.txt) | Text report (.txt) |
| `labelExportPdf` | en | PDF Document Report (.pdf) | PDF report (.pdf) |
| `titleExportBackup` | en | Encrypted Local Backup File (.sreerajqr) | Encrypted backup |
| `labelExportPassphrase` | en | Backup Encryption Passphrase | Backup passphrase |
| `actionExportCreateBackup` | en | Create Encrypted Backup File | Create backup |
| `titleRestore` | en | Restore History from Encrypted Backup File: | Restore from backup: |
| `labelRestorePassphrase` | en | Backup Decryption Passphrase | Backup passphrase |
| `labelRestorePayload` | en | Encrypted Backup Payload (.sreerajqr) | Backup data |
| `actionRestore` | en | Decrypt & Restore History | Restore history |
| `labelHistoryLocation` | en | Location Tag (Optional) | Location (optional) |
| `labelHistoryLocation` | ml | സ്ഥല ടാഗ് (ഐച്ഛികം) | സ്ഥലം (ഐച്ഛികം) |
| `labelHistoryLocation` | sa | स्थान-चिह्नम् (ऐच्छिकम्) | स्थानम् (ऐच्छिकम्) |
| `titleRestoreDialog` | en | Restore Encrypted Backup | Restore backup |
| `titleRestoreDialog` | ml | എൻക്രിപ്റ്റ് ചെയ്ത ബാക്കപ്പ് പുനഃസ്ഥാപിക്കുക | ബാക്കപ്പ് പുനഃസ്ഥാപിക്കൽ |
| `titleRestoreDialog` | sa | गूढ-सञ्चयः पुनःस्थाप्यताम् | सञ्चय-पुनःस्थापनम् |
| `titleExportFormat` | en | Select Export Format: | Export format: |
| `titleExportFormat` | ml | കയറ്റുമതി ഫോർമാറ്റ് തിരഞ്ഞെടുക്കുക: | കയറ്റുമതി ഫോർമാറ്റ്: |
| `titleExportFormat` | sa | निर्यात-प्रकारं वृणुताम्: | निर्यात-प्रकारः: |
| `labelExportTxt` | en | Formatted TXT Report (.txt) | Text report (.txt) |
| `labelExportTxt` | ml | ഫോർമാറ്റ് ചെയ്ത TXT റിപ്പോർട്ട് (.txt) | TXT റിപ്പോർട്ട് (.txt) |
| `labelExportTxt` | sa | TXT विवरणम् (.txt) | TXT विवरणम् (.txt) |
| `titleExportBackup` | en | Encrypted Local Backup File (.sreerajqr) | Encrypted backup |
| `titleExportBackup` | ml | പ്രാദേശിക ബാക്കപ്പ് ഫയൽ (.sreerajqr) | എൻക്രിപ്റ്റ് ചെയ്ത ബാക്കപ്പ് |
| `titleExportBackup` | sa | गूढ-सञ्चय-सञ्चिका (.sreerajqr) | गूढ-सञ्चयः |
| `labelExportPassphrase` | en | Backup Encryption Passphrase | Backup passphrase |
| `labelExportPassphrase` | ml | ബാക്കപ്പ് എൻക്രിപ്ഷൻ രഹസ്യവാക്ക് | ബാക്കപ്പ് രഹസ്യവാക്ക് |
| `labelExportPassphrase` | sa | सञ्चयस्य कूटवाक्यम् | सञ्चयस्य कूटवाक्यम् |
| `actionExportCreateBackup` | en | Create Encrypted Backup File | Create backup |
| `actionExportCreateBackup` | ml | എൻക്രിപ്റ്റ് ചെയ്ത ബാക്കപ്പ് ഫയൽ നിർമ്മിക്കുക | ബാക്കപ്പ് നിർമ്മിക്കുക |
| `actionExportCreateBackup` | sa | गूढ-सञ्चय-सञ्चिका निर्मीयताम् | सञ्चयः निर्मीयताम् |
| `titleRestore` | en | Restore History from Encrypted Backup File: | Restore from backup: |
| `titleRestore` | ml | ബാക്കപ്പ് ഫയലിൽ നിന്ന് ചരിത്രം പുനഃസ്ഥാപിക്കുക: | ബാക്കപ്പിൽ നിന്ന്: |
| `titleRestore` | sa | गूढ-सञ्चयात् इतिहासः पुनःस्थाप्यताम्: | सञ्चयात् पुनःस्थापनम्: |
| `labelRestorePassphrase` | en | Backup Decryption Passphrase | Backup passphrase |
| `labelRestorePassphrase` | ml | ബാക്കപ്പ് ഡീക്രിപ്ഷൻ രഹസ്യവാക്ക് | ബാക്കപ്പ് രഹസ്യവാക്ക് |
| `labelRestorePassphrase` | sa | सञ्चय-कूटवाक्यम् | सञ्चयस्य कूटवाक्यम् |
| `labelRestorePayload` | en | Encrypted Backup Payload (.sreerajqr) | Backup data |
| `labelRestorePayload` | ml | ബാക്കപ്പ് വിവരങ്ങൾ (.sreerajqr) | ബാക്കപ്പ് വിവരങ്ങൾ |
| `labelRestorePayload` | sa | सञ्चय-विषयः (.sreerajqr) | सञ्चय-विषयः |
| `actionRestore` | en | Decrypt & Restore History | Restore history |
| `actionRestore` | ml | ഡീക്രിപ്റ്റ് ചെയ്ത് പുനഃസ്ഥാപിക്കുക | നാൾവഴി പുനഃസ്ഥാപിക്കുക |
| `actionRestore` | sa | उद्घाट्य पुनःस्थाप्यताम् | इतिवृत्तं पुनःस्थाप्यताम् |
