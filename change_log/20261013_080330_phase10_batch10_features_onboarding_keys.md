# Phase 10 batch 10 — features and onboarding keys (Phase 10 complete)

Implements batch 10 (features, onboarding and leftover keys) of `plans/20261013_071846_phase10_arb_key_prefixes.md`,
and closes Phase 10.

## What changed

- Renamed the `feature*`, `features*`, `onboarding*` and `manualDecryptionFailed` ARB keys
  to the standard prefixes in all three ARB files and in the Dart code. Feature card and
  category titles became `title…`, descriptions `desc…`, chips `label…`; onboarding buttons
  `action…`, badges `label…`, slide titles `title…`, slide text and bullets `body…`.
  Regenerated `lib/l10n/gen/`.
- `madeWithLove` and `madeWithLoveA11y` keep their names: they are the fixed signature-badge
  pair (`docs/guidelines/guideline.md` §1.7), and a test checks `madeWithLove` by name.
- Shortened all feature, category and onboarding titles that were over the label budget, in
  all three languages (see "Changed values"). The six safety-layer cards now use a numbered
  short title ("1. Protocol guard" … "6. Safe Browsing"); the category heading says
  "6-layer link safety".
- Updated the screen tests that matched the old English titles
  (`test/screens/onboarding_screen_test.dart`, `test/screens/settings_screen_test.dart`).
- New test in `test/l10n/l10n_parity_test.dart`: every ARB key must start with a standard
  prefix (only the two badge keys are exempt). Every key now passes, so the label-length test
  covers the whole UI.
- `docs/architecture.md` §21: removed the two Phase 10 risks (unprefixed keys and History
  glossary; logger import order, sorted in batch 1). The test table lists the new checks.
- `CHANGELOG.md` (Unreleased → Changed): shorter UI texts and the single History term.
- Plan status: Phase 10 plan and the compliance roadmap are now `completed`.

## Checks

`flutter analyze` clean, all 688 tests pass (one new), `dart format` clean, Sanskrit
Hindi-marker gate passes.

## Native-reader review

All new ml/sa titles in the "Changed values" table, especially:
- `titleFeatureSafeBrowsing` sa "6. सुरक्षित-विचरणम्" (a translation of "Safe Browsing"; the
  old title kept the English product name).
- `titleFeaturesCatVision` ml "ദൃഷ്ടി ഉപകരണങ്ങൾ", sa "दृष्टि-साधनानि".
- `titleOnboardingSlide2` sa "विकृति-शोधनम्" and `labelOnboardingSlide3Badge` sa "अनुवर्तन-शून्यम्".

## Renamed keys (164)

| Old key | New key |
|---|---|
| `featuresHeaderTitle` | `titleFeaturesHeader` |
| `featuresHeaderSubtitle` | `descFeaturesHeader` |
| `featuresCatScanningName` | `titleFeaturesCatScanning` |
| `featuresCatScanningSubtitle` | `descFeaturesCatScanning` |
| `featuresCatSafetyName` | `titleFeaturesCatSafety` |
| `featuresCatSafetySubtitle` | `descFeaturesCatSafety` |
| `featuresCatVisionName` | `titleFeaturesCatVision` |
| `featuresCatVisionSubtitle` | `descFeaturesCatVision` |
| `featuresCatPayloadsName` | `titleFeaturesCatPayloads` |
| `featuresCatPayloadsSubtitle` | `descFeaturesCatPayloads` |
| `featuresCatHistoryName` | `titleFeaturesCatHistory` |
| `featuresCatHistorySubtitle` | `descFeaturesCatHistory` |
| `featureBarcodeEngineTitle` | `titleFeatureBarcodeEngine` |
| `featureBarcodeEngineDesc` | `descFeatureBarcodeEngine` |
| `featureBarcodeEngineChip1` | `labelFeatureBarcodeEngineChip1` |
| `featureBarcodeEngineChip2` | `labelFeatureBarcodeEngineChip2` |
| `featureBarcodeEngineChip3` | `labelFeatureBarcodeEngineChip3` |
| `featureMediaSourcesTitle` | `titleFeatureMediaSources` |
| `featureMediaSourcesDesc` | `descFeatureMediaSources` |
| `featureMediaSourcesChip1` | `labelFeatureMediaSourcesChip1` |
| `featureMediaSourcesChip2` | `labelFeatureMediaSourcesChip2` |
| `featureMediaSourcesChip3` | `labelFeatureMediaSourcesChip3` |
| `featureGhostScanTitle` | `titleFeatureGhostScan` |
| `featureGhostScanDesc` | `descFeatureGhostScan` |
| `featureGhostScanChip1` | `labelFeatureGhostScanChip1` |
| `featureGhostScanChip2` | `labelFeatureGhostScanChip2` |
| `featureGhostScanChip3` | `labelFeatureGhostScanChip3` |
| `featureCameraControlsTitle` | `titleFeatureCameraControls` |
| `featureCameraControlsDesc` | `descFeatureCameraControls` |
| `featureCameraControlsChip1` | `labelFeatureCameraControlsChip1` |
| `featureCameraControlsChip2` | `labelFeatureCameraControlsChip2` |
| `featureCameraControlsChip3` | `labelFeatureCameraControlsChip3` |
| `featureScanOverlaysTitle` | `titleFeatureScanOverlays` |
| `featureScanOverlaysDesc` | `descFeatureScanOverlays` |
| `featureScanOverlaysChip1` | `labelFeatureScanOverlaysChip1` |
| `featureScanOverlaysChip2` | `labelFeatureScanOverlaysChip2` |
| `featureScanOverlaysChip3` | `labelFeatureScanOverlaysChip3` |
| `featureFeedbackTitle` | `titleFeatureFeedback` |
| `featureFeedbackDesc` | `descFeatureFeedback` |
| `featureFeedbackChip1` | `labelFeatureFeedbackChip1` |
| `featureFeedbackChip2` | `labelFeatureFeedbackChip2` |
| `featureFeedbackChip3` | `labelFeatureFeedbackChip3` |
| `featureProtocolGuardTitle` | `titleFeatureProtocolGuard` |
| `featureProtocolGuardDesc` | `descFeatureProtocolGuard` |
| `featureProtocolGuardChip1` | `labelFeatureProtocolGuardChip1` |
| `featureProtocolGuardChip2` | `labelFeatureProtocolGuardChip2` |
| `featureProtocolGuardChip3` | `labelFeatureProtocolGuardChip3` |
| `featureHomographShieldTitle` | `titleFeatureHomographShield` |
| `featureHomographShieldDesc` | `descFeatureHomographShield` |
| `featureHomographShieldChip1` | `labelFeatureHomographShieldChip1` |
| `featureHomographShieldChip2` | `labelFeatureHomographShieldChip2` |
| `featureHomographShieldChip3` | `labelFeatureHomographShieldChip3` |
| `featureTldEntropyTitle` | `titleFeatureTldEntropy` |
| `featureTldEntropyDesc` | `descFeatureTldEntropy` |
| `featureTldEntropyChip1` | `labelFeatureTldEntropyChip1` |
| `featureTldEntropyChip2` | `labelFeatureTldEntropyChip2` |
| `featureTldEntropyChip3` | `labelFeatureTldEntropyChip3` |
| `featureIpPortTitle` | `titleFeatureIpPort` |
| `featureIpPortDesc` | `descFeatureIpPort` |
| `featureIpPortChip1` | `labelFeatureIpPortChip1` |
| `featureIpPortChip2` | `labelFeatureIpPortChip2` |
| `featureIpPortChip3` | `labelFeatureIpPortChip3` |
| `featureHeadProbeTitle` | `titleFeatureHeadProbe` |
| `featureHeadProbeDesc` | `descFeatureHeadProbe` |
| `featureHeadProbeChip1` | `labelFeatureHeadProbeChip1` |
| `featureHeadProbeChip2` | `labelFeatureHeadProbeChip2` |
| `featureHeadProbeChip3` | `labelFeatureHeadProbeChip3` |
| `featureSafeBrowsingTitle` | `titleFeatureSafeBrowsing` |
| `featureSafeBrowsingDesc` | `descFeatureSafeBrowsing` |
| `featureSafeBrowsingChip1` | `labelFeatureSafeBrowsingChip1` |
| `featureSafeBrowsingChip2` | `labelFeatureSafeBrowsingChip2` |
| `featureSafeBrowsingChip3` | `labelFeatureSafeBrowsingChip3` |
| `featureQuishingGuardTitle` | `titleFeatureQuishingGuard` |
| `featureQuishingGuardDesc` | `descFeatureQuishingGuard` |
| `featureQuishingGuardChip1` | `labelFeatureQuishingGuardChip1` |
| `featureQuishingGuardChip2` | `labelFeatureQuishingGuardChip2` |
| `featureQuishingGuardChip3` | `labelFeatureQuishingGuardChip3` |
| `featureArCodeVisionTitle` | `titleFeatureArCodeVision` |
| `featureArCodeVisionDesc` | `descFeatureArCodeVision` |
| `featureArCodeVisionChip1` | `labelFeatureArCodeVisionChip1` |
| `featureArCodeVisionChip2` | `labelFeatureArCodeVisionChip2` |
| `featureArCodeVisionChip3` | `labelFeatureArCodeVisionChip3` |
| `featureAirQrTitle` | `titleFeatureAirQr` |
| `featureAirQrDesc` | `descFeatureAirQr` |
| `featureAirQrChip1` | `labelFeatureAirQrChip1` |
| `featureAirQrChip2` | `labelFeatureAirQrChip2` |
| `featureAirQrChip3` | `labelFeatureAirQrChip3` |
| `featureStegoQrTitle` | `titleFeatureStegoQr` |
| `featureStegoQrDesc` | `descFeatureStegoQr` |
| `featureStegoQrChip1` | `labelFeatureStegoQrChip1` |
| `featureStegoQrChip2` | `labelFeatureStegoQrChip2` |
| `featureStegoQrChip3` | `labelFeatureStegoQrChip3` |
| `featureWifiTitle` | `titleFeatureWifi` |
| `featureWifiDesc` | `descFeatureWifi` |
| `featureWifiChip1` | `labelFeatureWifiChip1` |
| `featureWifiChip2` | `labelFeatureWifiChip2` |
| `featureWifiChip3` | `labelFeatureWifiChip3` |
| `featurePaymentsTitle` | `titleFeaturePayments` |
| `featurePaymentsDesc` | `descFeaturePayments` |
| `featurePaymentsChip1` | `labelFeaturePaymentsChip1` |
| `featurePaymentsChip2` | `labelFeaturePaymentsChip2` |
| `featurePaymentsChip3` | `labelFeaturePaymentsChip3` |
| `featureTotpTitle` | `titleFeatureTotp` |
| `featureTotpDesc` | `descFeatureTotp` |
| `featureTotpChip1` | `labelFeatureTotpChip1` |
| `featureTotpChip2` | `labelFeatureTotpChip2` |
| `featureTotpChip3` | `labelFeatureTotpChip3` |
| `featureContactsTitle` | `titleFeatureContacts` |
| `featureContactsDesc` | `descFeatureContacts` |
| `featureContactsChip1` | `labelFeatureContactsChip1` |
| `featureContactsChip2` | `labelFeatureContactsChip2` |
| `featureContactsChip3` | `labelFeatureContactsChip3` |
| `featureCalendarTitle` | `titleFeatureCalendar` |
| `featureCalendarDesc` | `descFeatureCalendar` |
| `featureCalendarChip1` | `labelFeatureCalendarChip1` |
| `featureCalendarChip2` | `labelFeatureCalendarChip2` |
| `featureCalendarChip3` | `labelFeatureCalendarChip3` |
| `featureGeoTitle` | `titleFeatureGeo` |
| `featureGeoDesc` | `descFeatureGeo` |
| `featureGeoChip1` | `labelFeatureGeoChip1` |
| `featureGeoChip2` | `labelFeatureGeoChip2` |
| `featureGeoChip3` | `labelFeatureGeoChip3` |
| `featureScanHistoryTitle` | `titleFeatureScanHistory` |
| `featureScanHistoryDesc` | `descFeatureScanHistory` |
| `featureScanHistoryChip1` | `labelFeatureScanHistoryChip1` |
| `featureScanHistoryChip2` | `labelFeatureScanHistoryChip2` |
| `featureScanHistoryChip3` | `labelFeatureScanHistoryChip3` |
| `featureBackupsTitle` | `titleFeatureBackups` |
| `featureBackupsDesc` | `descFeatureBackups` |
| `featureBackupsChip1` | `labelFeatureBackupsChip1` |
| `featureBackupsChip2` | `labelFeatureBackupsChip2` |
| `featureBackupsChip3` | `labelFeatureBackupsChip3` |
| `featureBiometricGuardTitle` | `titleFeatureBiometricGuard` |
| `featureBiometricGuardDesc` | `descFeatureBiometricGuard` |
| `featureBiometricGuardChip1` | `labelFeatureBiometricGuardChip1` |
| `featureBiometricGuardChip2` | `labelFeatureBiometricGuardChip2` |
| `featureBiometricGuardChip3` | `labelFeatureBiometricGuardChip3` |
| `featureOfflinePrivacyTitle` | `titleFeatureOfflinePrivacy` |
| `featureOfflinePrivacyDesc` | `descFeatureOfflinePrivacy` |
| `featureOfflinePrivacyChip1` | `labelFeatureOfflinePrivacyChip1` |
| `featureOfflinePrivacyChip2` | `labelFeatureOfflinePrivacyChip2` |
| `featureOfflinePrivacyChip3` | `labelFeatureOfflinePrivacyChip3` |
| `manualDecryptionFailed` | `errorManualDecryptionFailed` |
| `onboardingSkip` | `actionOnboardingSkip` |
| `onboardingNext` | `actionOnboardingNext` |
| `onboardingGetStarted` | `actionOnboardingGetStarted` |
| `onboardingSlide1Badge` | `labelOnboardingSlide1Badge` |
| `onboardingSlide1Title` | `titleOnboardingSlide1` |
| `onboardingSlide1Description` | `bodyOnboardingSlide1` |
| `onboardingSlide1Bullet1` | `bodyOnboardingSlide1Bullet1` |
| `onboardingSlide1Bullet2` | `bodyOnboardingSlide1Bullet2` |
| `onboardingSlide1Bullet3` | `bodyOnboardingSlide1Bullet3` |
| `onboardingSlide2Badge` | `labelOnboardingSlide2Badge` |
| `onboardingSlide2Title` | `titleOnboardingSlide2` |
| `onboardingSlide2Description` | `bodyOnboardingSlide2` |
| `onboardingSlide2Bullet1` | `bodyOnboardingSlide2Bullet1` |
| `onboardingSlide2Bullet2` | `bodyOnboardingSlide2Bullet2` |
| `onboardingSlide2Bullet3` | `bodyOnboardingSlide2Bullet3` |
| `onboardingSlide3Badge` | `labelOnboardingSlide3Badge` |
| `onboardingSlide3Title` | `titleOnboardingSlide3` |
| `onboardingSlide3Description` | `bodyOnboardingSlide3` |
| `onboardingSlide3Bullet1` | `bodyOnboardingSlide3Bullet1` |
| `onboardingSlide3Bullet2` | `bodyOnboardingSlide3Bullet2` |
| `onboardingSlide3Bullet3` | `bodyOnboardingSlide3Bullet3` |

## Changed values

| Key | Language | Before | After |
|---|---|---|---|
| `titleFeaturesHeader` | en | SreerajP QR Studio Features | All features |
| `titleFeaturesHeader` | ml | ആപ്പ് സവിശേഷതകൾ | എല്ലാ സവിശേഷതകളും |
| `titleFeaturesHeader` | sa | अनुप्रयोगस्य वैशिष्ट्यानि | सर्वाणि वैशिष्ट्यानि |
| `titleFeaturesCatScanning` | en | Core Scanning & Ingestion | Scanning |
| `titleFeaturesCatScanning` | ml | പ്രധാന സ്കാനിംഗും ഇൻപുട്ടും | സ്കാനിംഗ് |
| `titleFeaturesCatScanning` | sa | मूल-अन्वीक्षणं ग्रहणं च | अन्वीक्षणम् |
| `titleFeaturesCatSafety` | en | 6-Layer URL Safety & Forensic Engine | 6-layer link safety |
| `titleFeaturesCatSafety` | ml | 6-തല URL സുരക്ഷയും ഫോറൻസിക് എഞ്ചിനും | 6-തല ലിങ്ക് സുരക്ഷ |
| `titleFeaturesCatSafety` | sa | षट्स्तरीयं URL-सुरक्षा-परीक्षायन्त्रम् | षट्स्तरीया सुरक्षा |
| `titleFeaturesCatVision` | en | QuishingGuard™ & Advanced AI Vision | Vision tools |
| `titleFeaturesCatVision` | ml | ക്വിഷിംഗ് ഗാർഡ്™, നൂതന AI ദൃഷ്ടി | ദൃഷ്ടി ഉപകരണങ്ങൾ |
| `titleFeaturesCatVision` | sa | क्विशिंग-रक्षकः™ उन्नत-AI-दृष्टिः च | दृष्टि-साधनानि |
| `titleFeaturesCatPayloads` | en | Smart Payloads & 1-Tap Integrations | Smart actions |
| `titleFeaturesCatPayloads` | ml | സ്മാർട്ട് ഉള്ളടക്കവും 1-ടാപ്പ് പ്രവർത്തനങ്ങളും | സ്മാർട്ട് പ്രവർത്തനങ്ങൾ |
| `titleFeaturesCatPayloads` | sa | चतुर-विषयाः एकस्पर्श-क्रियाः च | चतुर-क्रियाः |
| `titleFeaturesCatHistory` | en | History, Backup & Privacy Vault | History & privacy |
| `titleFeaturesCatHistory` | ml | ചരിത്രം, ബാക്കപ്പ്, സ്വകാര്യതാ നിലവറ | നാൾവഴിയും സ്വകാര്യതയും |
| `titleFeaturesCatHistory` | sa | इतिहासः, सञ्चयः, गोपनीयता-कोशः च | इतिवृत्तं गोपनीयता च |
| `titleFeatureBarcodeEngine` | en | Multi-Format Barcode Engine | Barcode engine |
| `titleFeatureBarcodeEngine` | ml | ബഹു-ഫോർമാറ്റ് ബാർകോഡ് എഞ്ചിൻ | ബാർകോഡ് എഞ്ചിൻ |
| `titleFeatureBarcodeEngine` | sa | बहुरूप-दण्डलेखा-यन्त्रम् | दण्डलेखा-यन्त्रम् |
| `titleFeatureMediaSources` | en | Multi-Source Media & PDF Ingestion | Images & PDF |
| `titleFeatureMediaSources` | ml | ചിത്രങ്ങളിൽ നിന്നും PDF-ൽ നിന്നും സ്കാൻ | ചിത്രങ്ങളും PDF-ഉം |
| `titleFeatureMediaSources` | sa | बहुस्रोत-माध्यमं PDF-ग्रहणं च | चित्राणि PDF च |
| `titleFeatureGhostScan` | en | GhostScan Screen Content Detector | GhostScan |
| `titleFeatureGhostScan` | ml | ഗോസ്റ്റ്സ്കാൻ: സ്ക്രീനിലെ കോഡ് സ്കാനർ | ഗോസ്റ്റ്സ്കാൻ |
| `titleFeatureGhostScan` | sa | छायावीक्षणम्: पटलस्थ-सङ्केत-अन्वेषकः | छायावीक्षणम् |
| `titleFeatureCameraControls` | en | Precision Camera Controls | Camera controls |
| `titleFeatureCameraControls` | ml | കൃത്യമായ ക്യാമറ നിയന്ത്രണങ്ങൾ | ക്യാമറ നിയന്ത്രണങ്ങൾ |
| `titleFeatureCameraControls` | sa | सूक्ष्म-छायाग्राहक-नियन्त्रणानि | छायाग्राहक-नियमनम् |
| `titleFeatureScanOverlays` | en | Customizable Scan Overlays | Scan overlays |
| `titleFeatureScanOverlays` | ml | മാറ്റാവുന്ന സ്കാൻ ഓവർലേകൾ | സ്കാൻ ഓവർലേകൾ |
| `titleFeatureScanOverlays` | sa | परिवर्तनीयाः अन्वीक्षण-संस्तराः | अन्वीक्षण-संस्तराः |
| `titleFeatureFeedback` | en | Tactile Haptic & Audio Feedback | Haptic & sound |
| `titleFeatureFeedback` | ml | വൈബ്രേഷനും ശബ്ദ പ്രതികരണവും | വൈബ്രേഷനും ശബ്ദവും |
| `titleFeatureFeedback` | sa | कम्पन-ध्वनि-प्रतिसादः | कम्पनं ध्वनिः च |
| `titleFeatureProtocolGuard` | en | Protocol & Syntax Guard (Layer 1) | 1. Protocol guard |
| `titleFeatureProtocolGuard` | ml | പ്രോട്ടോക്കോൾ, ഘടനാ കാവൽ (തലം 1) | 1. പ്രോട്ടോക്കോൾ കാവൽ |
| `titleFeatureProtocolGuard` | sa | नियमाचार-रचना-रक्षकः (स्तरः 1) | 1. नियमाचार-रक्षकः |
| `titleFeatureHomographShield` | en | Homograph & Unicode Shield (Layer 2) | 2. Homograph shield |
| `titleFeatureHomographShield` | ml | ഹോമോഗ്രാഫ്, യൂണികോഡ് കവചം (തലം 2) | 2. ഹോമോഗ്രാഫ് കവചം |
| `titleFeatureHomographShield` | sa | समरूप-यूनिकोड-कवचम् (स्तरः 2) | 2. समरूप-कवचम् |
| `titleFeatureTldEntropy` | en | Suspicious TLD & Entropy Analysis (Layer 3) | 3. TLD & entropy |
| `titleFeatureTldEntropy` | ml | സംശയാസ്പദ TLD, എൻട്രോപ്പി വിശകലനം (തലം 3) | 3. TLD, എൻട്രോപ്പി |
| `titleFeatureTldEntropy` | sa | शङ्कास्पद-TLD-अव्यवस्था-विश्लेषणम् (स्तरः 3) | 3. TLD-अव्यवस्था |
| `titleFeatureIpPort` | en | Heuristic IP & Port Flagging (Layer 4) | 4. IP & port check |
| `titleFeatureIpPort` | ml | IP, പോർട്ട് പരിശോധന (തലം 4) | 4. IP, പോർട്ട് |
| `titleFeatureIpPort` | sa | IP-द्वार-परीक्षा (स्तरः 4) | 4. IP-द्वार-परीक्षा |
| `titleFeatureHeadProbe` | en | Privacy-Safe Online Head Probing (Layer 5) | 5. Online probe |
| `titleFeatureHeadProbe` | ml | സ്വകാര്യത മാനിക്കുന്ന ഓൺലൈൻ പരിശോധന (തലം 5) | 5. ഓൺലൈൻ പരിശോധന |
| `titleFeatureHeadProbe` | sa | गोपनीयता-सुरक्षितं जाल-परीक्षणम् (स्तरः 5) | 5. जाल-परीक्षणम् |
| `titleFeatureSafeBrowsing` | en | Google Safe Browsing API (Layer 6) | 6. Safe Browsing |
| `titleFeatureSafeBrowsing` | ml | Google Safe Browsing API (തലം 6) | 6. സേഫ് ബ്രൗസിംഗ് |
| `titleFeatureSafeBrowsing` | sa | Google Safe Browsing API (स्तरः 6) | 6. सुरक्षित-विचरणम् |
| `titleFeatureQuishingGuard` | en | QuishingGuard™ Physical Tamper Detection | QuishingGuard™ |
| `titleFeatureQuishingGuard` | ml | ക്വിഷിംഗ് ഗാർഡ്™: ഭൗതിക കൃത്രിമം കണ്ടെത്തൽ | ക്വിഷിംഗ് ഗാർഡ്™ |
| `titleFeatureQuishingGuard` | sa | क्विशिंग-रक्षकः™: भौतिक-विकृति-ज्ञानम् | क्विशिंग-रक्षकः™ |
| `titleFeatureArCodeVision` | en | AR CodeVision™ Spatial HUD | AR CodeVision™ |
| `titleFeatureArCodeVision` | ml | AR കോഡ്‌വിഷൻ™ സ്പേഷ്യൽ HUD | AR കോഡ്‌വിഷൻ™ |
| `titleFeatureArCodeVision` | sa | AR-सङ्केतदृष्टिः™ स्थानिक-HUD | AR-सङ्केतदृष्टिः™ |
| `titleFeatureAirQr` | en | AirQR™ Optical Air-Gap Data Stream | AirQR™ transfer |
| `titleFeatureAirQr` | ml | എയർ ക്യുആർ™ ഓപ്റ്റിക്കൽ ഡാറ്റാ കൈമാറ്റം | എയർ ക്യുആർ™ കൈമാറ്റം |
| `titleFeatureAirQr` | sa | वायु-क्यूआर™ प्रकाश-दत्तांश-प्रवाहः | वायु-क्यूआर™ प्रवाहः |
| `titleFeatureStegoQr` | en | StegoQR™ Steganographic Scanner | StegoQR™ scanner |
| `titleFeatureStegoQr` | ml | സ്റ്റെഗോ ക്യുആർ™ രഹസ്യ സന്ദേശ സ്കാനർ | സ്റ്റെഗോ ക്യുആർ™ |
| `titleFeatureStegoQr` | sa | स्टेगो-क्यूआर™ गुप्तलेख-अन्वीक्षकः | स्टेगो-क्यूआर™ |
| `titleFeatureWifi` | en | Wi-Fi Instant Auto Connect | Wi-Fi auto connect |
| `titleFeatureWifi` | ml | Wi-Fi ഉടൻ കണക്റ്റ് | Wi-Fi ഉടൻ കണക്റ്റ് |
| `titleFeatureWifi` | sa | Wi-Fi सद्यः सम्बन्धः | Wi-Fi सद्यः सम्बन्धः |
| `titleFeaturePayments` | en | UPI & Global Crypto Payments | UPI & crypto pay |
| `titleFeaturePayments` | ml | UPI, ക്രിപ്റ്റോ പണമിടപാടുകൾ | UPI, ക്രിപ്റ്റോ പണമിടപാട് |
| `titleFeaturePayments` | sa | UPI-गूढमुद्रा-धनप्रेषणम् | UPI-गूढमुद्रा-प्रेषणम् |
| `titleFeatureTotp` | en | TOTP 2FA Authenticator & Token Generator | TOTP authenticator |
| `titleFeatureTotp` | ml | TOTP 2FA ഓതന്റിക്കേറ്റർ | TOTP ഓതന്റിക്കേറ്റർ |
| `titleFeatureTotp` | sa | TOTP द्विघटक-प्रमाणीकरणम् | TOTP-प्रमाणीकरणम् |
| `titleFeatureContacts` | en | Contacts & vCard Importer | Contacts & vCard |
| `titleFeatureContacts` | ml | കോൺടാക്റ്റ്, vCard ഇറക്കുമതി | കോൺടാക്റ്റ്, vCard ഇറക്കുമതി |
| `titleFeatureContacts` | sa | सम्पर्क-vCard-आयातः | सम्पर्क-vCard-आयातः |
| `titleFeatureCalendar` | en | Calendar Events & Scheduling | Calendar events |
| `titleFeatureCalendar` | ml | കലണ്ടർ ഇവന്റുകൾ | കലണ്ടർ ഇവന്റുകൾ |
| `titleFeatureCalendar` | sa | दिनदर्शिका-घटनाः | दिनदर्शिका-घटनाः |
| `titleFeatureGeo` | en | Geographic Location & Navigation | Location & maps |
| `titleFeatureGeo` | ml | സ്ഥാനവും വഴികാട്ടലും | സ്ഥാനവും മാപ്പും |
| `titleFeatureGeo` | sa | भौगोलिक-स्थानं मार्गदर्शनं च | स्थानं मानचित्रं च |
| `titleFeatureScanHistory` | en | Comprehensive Offline Scan History | Offline scan history |
| `titleFeatureScanHistory` | ml | സമ്പൂർണ്ണ ഓഫ്‌ലൈൻ സ്കാൻ ചരിത്രം | ഓഫ്‌ലൈൻ സ്കാൻ നാൾവഴി |
| `titleFeatureScanHistory` | sa | सम्पूर्णः स्थानीय-अन्वीक्षण-इतिहासः | स्थानीय-इतिवृत्तम् |
| `titleFeatureBackups` | en | Flexible JSON & CSV Backups | JSON & CSV backups |
| `titleFeatureBackups` | ml | JSON, CSV ബാക്കപ്പുകൾ | JSON, CSV ബാക്കപ്പുകൾ |
| `titleFeatureBackups` | sa | JSON-CSV-सञ्चयाः | JSON-CSV-सञ्चयाः |
| `titleFeatureBiometricGuard` | en | Biometric & Screen Security Guard | App & screen lock |
| `titleFeatureBiometricGuard` | ml | ബയോമെട്രിക്, സ്ക്രീൻ സുരക്ഷ | ബയോമെട്രിക്, സ്ക്രീൻ സുരക്ഷ |
| `titleFeatureBiometricGuard` | sa | जैविक-पटल-सुरक्षा | जैविक-पटल-सुरक्षा |
| `titleFeatureOfflinePrivacy` | en | 100% Offline-First Privacy | 100% offline privacy |
| `titleFeatureOfflinePrivacy` | ml | 100% ഓഫ്‌ലൈൻ സ്വകാര്യത | 100% ഓഫ്‌ലൈൻ സ്വകാര്യത |
| `titleFeatureOfflinePrivacy` | sa | 100% स्थानीय-गोपनीयता | 100% स्थानीय-गोपनीयता |
| `titleOnboardingSlide1` | en | 6-Layer URL Safety Engine | 6-layer link safety |
| `titleOnboardingSlide1` | ml | 6-തല യുആർഎൽ സുരക്ഷാ എഞ്ചിൻ | 6-തല ലിങ്ക് സുരക്ഷ |
| `titleOnboardingSlide1` | sa | षट्स्तरीय-यूआरएल-सुरक्षा-यन्त्रम् | षट्स्तरीया सुरक्षा |
| `titleOnboardingSlide2` | en | QuishingGuard™ Tamper Detection | Tamper detection |
| `titleOnboardingSlide2` | ml | ക്വിഷിംഗ്ഗാർഡ് വ്യാജ സ്റ്റിക്കർ കണ്ടെത്തൽ | വ്യാജ സ്റ്റിക്കർ കണ്ടെത്തൽ |
| `titleOnboardingSlide2` | sa | क्विशिङ्गगार्ड-विकृति-शोधनम् | विकृति-शोधनम् |
| `titleOnboardingSlide3` | en | 100% Offline Privacy Model | 100% offline privacy |
| `titleOnboardingSlide3` | ml | 100% ഓഫ്ലൈൻ സ്വകാര്യത | 100% ഓഫ്‌ലൈൻ സ്വകാര്യത |
| `titleOnboardingSlide3` | sa | शतप्रतिशतम् अफलाइन-गोपनीयता | 100% स्थानीय-गोपनीयता |
| `labelOnboardingSlide3Badge` | en | Zero Cloud • Zero Tracking | Zero tracking |
| `labelOnboardingSlide3Badge` | ml | ക്ലൗഡ് രഹിതം • ട്രാക്കിംഗ് ഇല്ല | ട്രാക്കിംഗ് ഇല്ല |
| `labelOnboardingSlide3Badge` | sa | क्लाउड-रहितम् • अनुवर्तन-शून्यम् | अनुवर्तन-शून्यम् |
