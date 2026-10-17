// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Sanskrit (`sa`).
class AppLocalizationsSa extends AppLocalizations {
  AppLocalizationsSa([String locale = 'sa']) : super(locale);

  @override
  String get titleApp => 'श्रीराज् पि क्यू-आर-कार्यशाला';

  @override
  String get titleWifiCard => 'वै-फाई संजालम्';

  @override
  String get tooltipWifiShowPassword => 'कूटशब्दः दृश्यताम्';

  @override
  String get tooltipWifiHidePassword => 'कूटशब्दः गोप्यताम्';

  @override
  String get tooltipWifiCopyPassword => 'कूटशब्दः प्रतिलिख्यताम्';

  @override
  String get actionWifiConnect => 'संयोज्यताम्';

  @override
  String get bodyWifiPasswordCopied => 'कूटशब्दः फलके प्रतिलेखितः';

  @override
  String get bodyWifiOpenSettings =>
      'कूटशब्दः प्रतिलेखितः। संयोजनाय विन्यासः उद्घाट्यताम्।';

  @override
  String bodyWifiConnectSuccess(String ssid) {
    return '$ssid संजालाय संयोजनानुरोधः प्रेषितः।';
  }

  @override
  String bodyGeoLatLng(String latitude, String longitude) {
    return 'अक्षांशः: $latitude, रेखांशः: $longitude';
  }

  @override
  String bodyGeoQuery(String query) {
    return 'अन्वेषणम्: $query';
  }

  @override
  String get actionGeoNavigate => 'मानचित्रे पश्यतु';

  @override
  String get errorGeoLaunchFailed => 'मानचित्र-अनुप्रयोगः न उद्घाटितः';

  @override
  String get titleCalendarCard => 'दिनदर्शिका-घटना';

  @override
  String get labelCalendarNoDate => 'अनुपलब्धम्';

  @override
  String labelCalendarStart(String dateTime) {
    return 'प्रारम्भः: $dateTime';
  }

  @override
  String labelCalendarEnd(String dateTime) {
    return 'समाप्तिः: $dateTime';
  }

  @override
  String get actionCalendarAdd => 'दिनदर्शिकायां योज्यताम्';

  @override
  String get errorCalendarLaunchFailed => 'दिनदर्शिका-अनुप्रयोगः न उद्घाटितः';

  @override
  String get titleContactCard => 'सम्पर्कपत्रम्';

  @override
  String get labelContactInitialFallback => 'स';

  @override
  String get actionContactSave => 'सम्पर्केषु रक्ष्यताम्';

  @override
  String get errorContactLaunchFailed => 'सम्पर्क-अनुप्रयोगः न उद्घाटितः';

  @override
  String errorContactCallFailed(String number) {
    return '$number अङ्के आह्वानं न जातम्';
  }

  @override
  String errorContactEmailFailed(String email) {
    return '$email सङ्केताय विद्युत्पत्रं न उद्घाटितम्';
  }

  @override
  String titlePdfResults(int count) {
    return 'पि-डि-एफ्-सङ्केताः ($count)';
  }

  @override
  String labelPdfPageBadge(int page) {
    return 'पृ $page';
  }

  @override
  String labelPdfPage(int page) {
    return 'पृष्ठम् $page';
  }

  @override
  String actionPdfSaveAll(int count) {
    return 'सर्वं रक्ष्यताम् ($count)';
  }

  @override
  String bodyPdfScanNote(int page) {
    return 'पि-डि-एफ् सञ्चिकातः संवीक्षितम् (पृष्ठम् $page)';
  }

  @override
  String bodyPdfSavedToHistory(int count) {
    return '$count सङ्केताः इतिवृत्ते रक्षिताः।';
  }

  @override
  String get labelTotpDefaultIssuer => 'द्विघटक-प्रमाणीकरणम्';

  @override
  String bodyTotpLivePasscode(int period) {
    return 'प्रत्यक्ष-सङ्केतः ($periodपलं TOTP)';
  }

  @override
  String labelTotpSecondsLeft(int seconds) {
    return '$secondsपलानि';
  }

  @override
  String get tooltipTotpCopyToken => 'टोकनं प्रतिलिख्यताम्';

  @override
  String get labelTotpSecret => 'गूढ-कुञ्चिका: ';

  @override
  String get actionTotpImport => 'प्रमाणीकरणे योज्यताम्';

  @override
  String get errorTotpLaunchFailed => 'प्रमाणीकरण-अनुप्रयोगः न उद्घाटितः';

  @override
  String get bodyTotpTokenCopied => 'टोकनं फलके प्रतिलेखितम्';

  @override
  String get bodyTotpSecretCopied => 'गूढ-कुञ्चिका फलके प्रतिलेखिता';

  @override
  String get labelPaymentSchemeUpi => 'यु-पि-आई धनप्रेषणम्';

  @override
  String get labelPaymentSchemeSepa => 'सेपा प्रेषणम्';

  @override
  String get labelPaymentSchemeCrypto => 'क्रिप्टो धनप्रेषणम्';

  @override
  String get labelPaymentPayeeFallback => 'प्राप्तिकर्ता';

  @override
  String get labelPaymentAddressUpi => 'यु-पि-आई अभिज्ञानम्:';

  @override
  String get labelPaymentAddressSepa => 'आई-बान् (IBAN):';

  @override
  String get labelPaymentAddressCrypto => 'कोश-सङ्केतः:';

  @override
  String get actionPaymentCopy => 'प्रतिलिख्यताम्';

  @override
  String get bodyPaymentUpiIdCopied => 'यु-पि-आई अभिज्ञानं फलके प्रतिलेखितम्';

  @override
  String get bodyPaymentAddressCopied => 'सङ्केतः फलके प्रतिलेखितः';

  @override
  String bodyPaymentNote(String note) {
    return 'सूचना: $note';
  }

  @override
  String get actionPaymentPayUpi => 'UPI-अनुप्रयोगेन दीयताम्';

  @override
  String get actionPaymentPay => 'अनुप्रयोगेन दीयताम्';

  @override
  String get errorPaymentUpiLaunchFailed => 'यु-पि-आई अनुप्रयोगः न उद्घाटितः।';

  @override
  String get errorPaymentLaunchFailed => 'धनप्रेषण-अनुप्रयोगः न उद्घाटितः।';

  @override
  String get actionPaymentCopyId => 'अभिज्ञानं प्रतिलिख्यताम्';

  @override
  String get titlePaymentAmountDialog => 'धनराशिः लिख्यताम्';

  @override
  String bodyPaymentAmountDialog(String payee) {
    return 'अस्मिन् QR-सङ्केते धनराशिः नास्ति। $payee इत्यस्मै देया धनराशिः लिख्यताम्।';
  }

  @override
  String get labelPaymentAmountField => 'धनराशिः';

  @override
  String get errorPaymentAmountInvalid => '₹1 अथवा अधिकं लिख्यताम्';

  @override
  String get actionPaymentAmountPay => 'दीयताम्';

  @override
  String labelPercentValue(String value) {
    return '$value%';
  }

  @override
  String get titleQuishingGuard => 'क्विशिंग-रक्षकः™';

  @override
  String get labelQuishingTamperBadge => 'भौतिक-विकृति-ज्ञानम्';

  @override
  String get labelQuishingRiskScore => 'विकृति-सम्भावना-मानाङ्कः:';

  @override
  String get actionQuishingViewSignals => 'संकेताः दृश्यन्ताम्';

  @override
  String get actionQuishingHideSignals => 'संकेताः गोप्यन्ताम्';

  @override
  String get labelQuishingMetricEdge => 'धार-विच्छेदः';

  @override
  String get descQuishingMetricEdge => 'द्विगुण-धाराः छाया-रेखाः च';

  @override
  String get labelQuishingMetricGrain => 'मुद्रण-कणाः DPI च';

  @override
  String get descQuishingMetricGrain => 'बिन्दु-घनत्वं वर्ण-ध्वनिः च';

  @override
  String get titleQuishingSignals => 'दृष्टाः संकेताः:';

  @override
  String get tooltipArCloseSheet => 'पिधीयताम्';

  @override
  String bodyArItemPriceTag(String price) {
    return 'मूल्य-पत्रम्: $price';
  }

  @override
  String get bodyArContentCopied => 'विषयः फलके प्रतिलेखितः';

  @override
  String get actionArCopy => 'प्रतिलिख्यताम्';

  @override
  String get actionArOpenUrl => 'सङ्केतः उद्घाट्यताम्';

  @override
  String get actionArSelect => 'चीयताम्';

  @override
  String get actionArDeselect => 'त्यज्यताम्';

  @override
  String get bodyArSafetyStatusSafe => 'सुरक्षा-स्थितिः: सुरक्षिता';

  @override
  String get bodyArSafetyStatusWarning =>
      'सुरक्षा-स्थितिः: पूर्वसूचना / कपट-सम्भावना';

  @override
  String get bodyArSafetyStatusUnknown =>
      'सुरक्षा-स्थितिः: परीक्षणं क्रियते...';

  @override
  String get bodyCopiedToClipboard => 'फलके प्रतिलिखितम्';

  @override
  String bodyHistoryTimestamp(String date, String time) {
    return '$date • $time';
  }

  @override
  String get tooltipHistoryStar => 'तारकम् योज्यताम्';

  @override
  String get tooltipHistoryUnstar => 'तारकम् अपनीयताम्';

  @override
  String get actionHistoryEditNotes => 'टिप्पणी संशोध्यताम्';

  @override
  String get tooltipHistoryCopyString => 'वाक्यं प्रतिलिख्यताम्';

  @override
  String get actionHistoryShare => 'विभज्यताम्';

  @override
  String get actionHistoryDelete => 'लुप्यताम्';

  @override
  String get titleHistoryDetail => 'संवीक्षा-विवरणम्';

  @override
  String labelHistorySafetyBadge(int score) {
    return '🛡️ $score% सुरक्षितम्';
  }

  @override
  String labelHistoryScoreBadge(int score) {
    return '🛡️ $score%';
  }

  @override
  String get labelHistoryScannedContent => 'संवीक्षित-विषयः:';

  @override
  String get actionHistoryCopy => 'प्रतिलिख्यताम्';

  @override
  String get labelHistoryNotes => 'स्वनिर्मिता टिप्पणी';

  @override
  String get helpHistoryNotes => 'अत्र स्वटिप्पणीं लिखन्तु...';

  @override
  String get labelHistoryLocation => 'स्थानम् (ऐच्छिकम्)';

  @override
  String get helpHistoryLocation => 'यथा कार्यक्षेत्रम्, आपणम्';

  @override
  String get actionHistorySaveChanges => 'परिवर्तनानि रक्ष्यन्ताम्';

  @override
  String get actionClose => 'पिदधातु';

  @override
  String get titleExportDialog => 'निर्यातः सञ्चयश्च';

  @override
  String get titleRestoreDialog => 'सञ्चय-पुनःस्थापनम्';

  @override
  String get tabExportRecords => 'अभिलेखान् निर्यापयतु';

  @override
  String get tabRestoreBackup => 'सञ्चयं पुनःस्थापयतु';

  @override
  String get titleExportFormat => 'निर्यात-प्रकारः:';

  @override
  String get labelExportCsv => 'CSV प्रकारः (.csv)';

  @override
  String get descExportCsv => 'Excel, Sheets अनुगुणम्';

  @override
  String get labelExportJson => 'JSON दत्तांशः (.json)';

  @override
  String get descExportJson => 'सङ्गणक-प्रकारः';

  @override
  String get labelExportTxt => 'TXT विवरणम् (.txt)';

  @override
  String get descExportTxt => 'सरल-वाच्य-पत्रम्';

  @override
  String get labelExportPdf => 'PDF विवरणम् (.pdf)';

  @override
  String get descExportPdf => 'मुद्रण-योग्यं पत्रम्';

  @override
  String get titleExportBackup => 'गूढ-सञ्चयः';

  @override
  String get labelExportPassphrase => 'सञ्चयस्य कूटवाक्यम्';

  @override
  String get helpExportPassphrase => 'कूटवाक्यं लिखन्तु...';

  @override
  String get errorExportPassphraseRequired =>
      'सञ्चय-रक्षणाय कूटवाक्यम् आवश्यकमस्ति।';

  @override
  String get actionExportCreateBackup => 'सञ्चयः निर्मीयताम्';

  @override
  String get bodyExportShare => 'श्रीराज्-क्यू-आर-संवीक्षा-इतिवृत्त-निर्यातः';

  @override
  String get bodyExportSharePdf =>
      'श्रीराज्-क्यू-आर-संवीक्षा-इतिवृत्त-पत्रम् (PDF)';

  @override
  String get bodyExportShareBackup => 'श्रीराज्-क्यू-आर-गूढ-सञ्चय-सञ्चिका';

  @override
  String get titleRestore => 'सञ्चयात् पुनःस्थापनम्:';

  @override
  String get labelRestorePassphrase => 'सञ्चयस्य कूटवाक्यम्';

  @override
  String get labelRestorePayload => 'सञ्चय-विषयः';

  @override
  String get helpRestorePayload => 'अत्र सञ्चय-JSON लिखन्तु...';

  @override
  String get errorRestoreFieldsRequired => 'कूटवाक्यं सञ्चय-विषयश्च दातव्यौ।';

  @override
  String get actionRestore => 'इतिवृत्तं पुनःस्थाप्यताम्';

  @override
  String bodyRestoreSuccess(int count) {
    return '$count संवीक्षा-अभिलेखानि सफलतया पुनःस्थापितानि!';
  }

  @override
  String errorRestoreFailed(String reason) {
    return 'पुनःस्थापनं विफलम्: $reason';
  }

  @override
  String get labelDomSandboxedBadge => 'सुरक्षित-कक्षे';

  @override
  String get labelDomTitleInitialFallback => 'जा';

  @override
  String get labelDomUntitledPage => 'अनाम-जालपृष्ठम्';

  @override
  String get bodyDomThumbnailCaption =>
      'दृश्य-पूर्वदर्शनम् (आज्ञावलिः निरुद्धा)';

  @override
  String bodyDomBlockedBadge(int scripts, int trackers) {
    return 'निरुद्धाः: $scripts आज्ञावलयः, $trackers अनुवेधकाः';
  }

  @override
  String bodyDomNewlyRegistered(int days) {
    return 'नूतनं पञ्जीकृतम् ($daysदिनानि)';
  }

  @override
  String bodyDomDomainAge(int days) {
    return 'क्षेत्र-आयुः: $days दिनानि';
  }

  @override
  String get bodyDomOpenRedirectFound => 'अनावृत-पुनर्निर्देशन-पाशः!';

  @override
  String get bodyDomNoOpenRedirect => 'न कोऽपि पुनर्निर्देशन-दोषः';

  @override
  String get actionDomInspect => 'पृष्ठं परीक्ष्यताम्';

  @override
  String get titleDomInspect => 'पृष्ठ-संरचना';

  @override
  String get labelDomDetailPageTitle => 'पृष्ठ-शीर्षकम्';

  @override
  String get labelDomDetailNotSpecified => 'न निर्दिष्टम्';

  @override
  String get labelDomDetailMetaDescription => 'मूल-विवरणम्';

  @override
  String get labelDomDetailNoneFound => 'न किमपि प्राप्तम्';

  @override
  String get labelDomDetailHeadingsCount => 'शीर्षक-सङ्ख्या';

  @override
  String bodyDomDetailHeadingsValue(int count) {
    return '$count शीर्षकाणि निष्कासितानि';
  }

  @override
  String get labelDomDetailLinksFound => 'प्राप्ताः सेतवः';

  @override
  String bodyDomDetailLinksValue(int count) {
    return '$count सङ्केताः निष्कासिताः';
  }

  @override
  String get labelDomDetailBlockedScripts => 'निरुद्धाः आज्ञावलयः';

  @override
  String bodyDomDetailBlockedScriptsValue(int count) {
    return '$count आज्ञावलयः विलोपिताः';
  }

  @override
  String get labelDomDetailBlockedTrackers => 'निरुद्धाः अनुवेधकाः';

  @override
  String bodyDomDetailBlockedTrackersValue(int count) {
    return '$count अनुवेधकाः विलोपिताः';
  }

  @override
  String get labelDomDetailBlockedIframes => 'निरुद्धाः अन्तःपत्राणि';

  @override
  String bodyDomDetailBlockedIframesValue(int count) {
    return '$count अन्तःपत्राणि विलोपितानि';
  }

  @override
  String get titleDomSanitizedSnippet => 'शुद्ध-HTML पूर्वदर्शनम्:';

  @override
  String get titleAbout => 'विषये';

  @override
  String bodyAboutVersion(String version, String build) {
    return 'संस्करणम् $version+$build';
  }

  @override
  String get labelAboutBuildDate => 'निर्माणदिनाङ्कः';

  @override
  String get labelAboutOpenSourceLicenses => 'मुक्तस्रोत-अनुज्ञाः';

  @override
  String get descAboutOpenSourceLicenses =>
      'दण्डलेखा-विकोडकः zxing-cpp (Apache-2.0) अत्र अन्तर्भवति। सर्वाः अनुज्ञाः द्रष्टुं स्पृशतु।';

  @override
  String get aboutDetailAuthor => 'विधाता';

  @override
  String get aboutDetailEmail => 'विद्युत्पत्रम्';

  @override
  String get aboutDetailLicense => 'अनुज्ञापत्रम्';

  @override
  String get aboutDetailAiUsed => 'उपयुक्त-AI';

  @override
  String get aboutDetailIdeUsed => 'उपयुक्ता IDE';

  @override
  String madeWithLove(String heart) {
    return '$heart भारततः निर्मितम्';
  }

  @override
  String get madeWithLoveA11y => 'स्नेहेन भारततः निर्मितम्';

  @override
  String get titleAirQrTransmitter => 'वायु-क्यूआर प्रसारकः';

  @override
  String get bodyAirQrSamplePayload =>
      'वायु-क्यूआर शीघ्र-प्रकाश-हस्तान्तरण-परीक्षण-विषयः।';

  @override
  String get labelAirQrPayload => 'प्रसारणीयः विषयः';

  @override
  String get helpAirQrPayload => 'लेखं सन्देशं वा लिखन्तु...';

  @override
  String get labelAirQrStreamSpeed => 'प्रसारण-गतिः:';

  @override
  String labelAirQrFps(int fps) {
    return '$fps FPS';
  }

  @override
  String get actionAirQrStartStream => 'प्रकाश-प्रसारणं प्रारभ्यताम्';

  @override
  String get actionAirQrStopStream => 'प्रकाश-प्रसारणं स्थग्यताम्';

  @override
  String bodyAirQrFrameParity(int current, int total) {
    return 'चित्रम् $current/$total [समता]';
  }

  @override
  String bodyAirQrFrameBlock(int current, int total, int block) {
    return 'चित्रम् $current/$total [खण्डः $block]';
  }

  @override
  String bodyAirQrTotalFrames(int total, int source, int parity) {
    return 'कुल-चित्राणि: $total ($source मूलानि + $parity समता)';
  }

  @override
  String get tooltipToggleFlashlight => 'प्रकाशदीपं परिवर्तयतु';

  @override
  String get actionGrantCameraPermission => 'चित्रग्राह्यनुमतिं ददातु';

  @override
  String get titleArScreen => 'AR संवीक्षा-फलकम्';

  @override
  String get bodyArInitializing => 'AR फलकम् आरभ्यते...';

  @override
  String get actionArClearSelection => 'प्रमृज्यताम्';

  @override
  String get actionArBatchCopy => 'एकत्र प्रतिलिख्यताम्';

  @override
  String bodyArBatchCopied(int count) {
    return '$count दण्डलेखाः फलके प्रतिलेखिताः';
  }

  @override
  String get bodyArCameraPermission =>
      'AR संवीक्षणाय छायाचित्रक-अनुमतिः आवश्यकी';

  @override
  String get actionDone => 'कृतम्';

  @override
  String get titleAirQrReceiver => 'वायु-क्यूआर ग्राहकः';

  @override
  String get tooltipAirQrTransmitter => 'वायु-क्यूआर प्रसारकः';

  @override
  String get tooltipAirQrResetStream => 'पुनःस्थाप्यताम्';

  @override
  String get bodyAirQrInitializing => 'वायु-क्यूआर ग्राहकः आरभ्यते...';

  @override
  String get bodyAirQrStatusReassembled => 'विषयः पुनः संयोजितः';

  @override
  String get bodyAirQrStatusCapturing => 'प्रकाश-प्रवाहः गृह्यते...';

  @override
  String get bodyAirQrStatusIdle => 'चल-क्यूआर प्रति पश्यतु';

  @override
  String bodyAirQrCaptured(int received, int total) {
    return 'सङ्गृहीतम्: $received / $total खण्डाः';
  }

  @override
  String bodyAirQrMissing(int count) {
    return 'अवशिष्टम्: $count';
  }

  @override
  String get titleAirQrTransferComplete => 'हस्तान्तरणं सम्पूर्णम्!';

  @override
  String get bodyAirQrTransferComplete => 'दत्तांशः पुनः संयोजितः प्रमाणितश्च।';

  @override
  String get bodyAirQrPayloadCopied => 'विषयः फलके प्रतिलेखितः';

  @override
  String get actionCancel => 'निरस्यतु';

  @override
  String get titleHistoryScreen => 'संवीक्षा-इतिवृत्तम्';

  @override
  String get tooltipHistoryExport => 'निर्यातः / सञ्चयः';

  @override
  String get actionHistoryClearAll => 'सर्वं प्रमृज्यताम्';

  @override
  String get titleHistoryClear => 'इतिवृत्तं प्रमृज्यतां वा?';

  @override
  String get bodyHistoryClear =>
      'किं सर्वं संवीक्षा-इतिवृत्तं विलोपनीयम्? विना सञ्चयं कृत्वा पुनः न लभ्यते।';

  @override
  String get helpHistorySearch => 'इतिवृत्तेऽन्विष्यताम्...';

  @override
  String get labelHistoryFilterAll => 'सर्वम्';

  @override
  String get labelHistoryFilterStarred => 'तारकाङ्कितानि';

  @override
  String get labelHistoryFilterUrls => 'सङ्केताः';

  @override
  String get labelHistoryFilterWifi => 'वै-फाई';

  @override
  String get labelHistoryFilterContacts => 'सम्पर्काः';

  @override
  String get labelHistoryFilterText => 'लेखः';

  @override
  String get labelHistoryFilterBarcodes => 'दण्डलेखाः';

  @override
  String get emptyHistoryTitle => 'न कोऽपि संवीक्षा-अभिलेखः प्राप्तः';

  @override
  String get emptyHistoryMessage =>
      'संवीक्षिताः सङ्केताः अत्र स्वयमेव आगमिष्यन्ति।';

  @override
  String emptyHistoryNoMatches(String query) {
    return '\"$query\" कृते न किमपि प्राप्तम्';
  }

  @override
  String get tooltipMoreOptions => 'अधिकविकल्पाः';

  @override
  String get actionMenuHistory => 'इतिवृत्तम्';

  @override
  String get actionMenuSettings => 'विन्यासाः';

  @override
  String get actionGrantPermission => 'अनुज्ञां ददातु';

  @override
  String get tooltipScanFromGallery => 'वीथिकायाः चित्रपरीक्षणम्';

  @override
  String get tooltipScanPdfDocument => 'PDF-प्रलेखपरीक्षणम्';

  @override
  String get bodyScanPdfProgress => 'PDF-पृष्ठानि विविच्य परीक्ष्यन्ते...';

  @override
  String get bodyScanSharedPdfProgress => 'सम्भक्त-PDF-प्रलेखस्य परीक्षणम्...';

  @override
  String get bodyScanInitializingCamera => 'चित्रग्राही सज्जक्रियते...';

  @override
  String get bodyScanInitializingFeed => 'चित्रग्राहीप्रवाहः सज्जक्रियते...';

  @override
  String get tooltipScanZoom => 'विस्तारसर्पकम्';

  @override
  String get tooltipScanFlipCamera => 'चित्रग्राहीपरिवर्तनम् (पुरतः/पृष्ठतः)';

  @override
  String labelScanZoomValue(String value) {
    return '${value}x';
  }

  @override
  String get helpScanViewfinder => 'सङ्केतं कोष्ठे स्थापयतु';

  @override
  String get bodyScanCameraPermissionRequired => 'चित्रग्राह्यनुमतिः आवश्यकी';

  @override
  String get labelCopied => 'प्रतिलिखितम्!';

  @override
  String get actionHide => 'गूढयतु';

  @override
  String get actionReveal => 'दर्शयतु';

  @override
  String get actionOpenAnyway => 'तथापि उद्घाटयतु';

  @override
  String get titleResultScreen => 'अन्वीक्षणफलम्';

  @override
  String get bodyResultNoResult => 'फलं न लब्धम्';

  @override
  String get labelResultContent => 'विषयः:';

  @override
  String get labelResultDecoyContent => 'सार्वजनिकविषयः:';

  @override
  String get labelResultDetectedType => 'लब्धप्रकारः:';

  @override
  String get labelResultTypeStego => 'STEGO-QR (गूढद्विस्तरम्)';

  @override
  String get actionResultRecheck => 'पुनरीक्षताम्';

  @override
  String get actionResultOpenInBrowser => 'जालगवेषके उद्घाटयतु';

  @override
  String get actionResultCopyText => 'पाठं प्रतिलिखतु';

  @override
  String get actionResultCopyDecoyText => 'सार्वजनिकपाठं प्रतिलिखतु';

  @override
  String get actionResultShareText => 'पाठं विभजतु';

  @override
  String get actionResultShareDecoyText => 'सार्वजनिकपाठं विभजतु';

  @override
  String get actionResultScanAnother => 'अन्यसङ्केतं परीक्षताम्';

  @override
  String get errorResultLaunchFailed => 'जालसङ्केतं उद्घाटयितुं न शक्तम्';

  @override
  String get bodyStegoUnlocked => 'गूढ-AES-256-विषयः सफलतया उद्घाटितः।';

  @override
  String get bodyStegoLocked =>
      'अस्मिन् सङ्केते गूढं विषयमस्ति। दर्शनाय प्रमाणीकरणं कुरुत।';

  @override
  String get actionStegoBiometricUnlock => 'जैविक-प्रवेशः';

  @override
  String get labelStegoPassphrase => 'कूटवाक्यम्';

  @override
  String get labelStegoSecretPayload => 'गूढ-विषयः:';

  @override
  String get actionStegoCopySecret => 'गूढं प्रतिलिख्यताम्';

  @override
  String get actionStegoShareSecret => 'गूढं विभज्यताम्';

  @override
  String get bodyStegoSecretCopied => 'गूढं फलके प्रतिलेखितम्';

  @override
  String get titleStegoDialogBiometric => 'जैविक-उद्घाटनम्';

  @override
  String get titleStegoDialogPassphrase => 'कूटवाक्यं दीयताम्';

  @override
  String get bodyStegoDialogBiometric =>
      'प्रमाणीकरणाय कूटवाक्यं दृढीक्रियताम्।';

  @override
  String get bodyStegoDialogPassphrase =>
      'गूढ-रक्षणाय प्रयुक्तं कूटवाक्यं लिख्यताम्।';

  @override
  String get actionStegoUnlock => 'उद्घाट्यताम्';

  @override
  String get titleSafetyCheckInProgress => 'सुरक्षा-परीक्षणं प्रचलति';

  @override
  String get titleSafetyAnalysis => 'सङ्केत-सुरक्षा-विश्लेषणम्';

  @override
  String get bodySafetyAnalyzing => 'सुरक्षा-विश्लेषणं क्रियते...';

  @override
  String bodySafetyIssuesDetected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सुरक्षा-दोषाः प्राप्ताः',
      one: '1 सुरक्षा-दोषः प्राप्तः',
    );
    return '$_temp0';
  }

  @override
  String get bodySafetyNoIssues => 'न कोऽपि दोषः प्राप्तः';

  @override
  String get helpSafetyTrustSource =>
      'यदि स्रोतः विश्वस्तः तर्हि एव उद्घाट्यताम्';

  @override
  String get titleSafetyResults => 'सुरक्षा-विश्लेषण-फलानि:';

  @override
  String get bodyProbingBannerActive =>
      'सक्रिय-परीक्षणं प्रवृत्तम्: अनेन जालेन सह साक्षात् सम्पर्कः जातः।';

  @override
  String get bodyProbingBannerPrivate =>
      'एकान्त-विधिः: जालस्थानेन सह साक्षात् सम्पर्कः न जातः, अतः भवतः IP-सङ्केतः तेन न ज्ञातः। स्थानीय-नियमाः भवता सक्रियीकृताः सुरक्षा-सेवाः च एव प्रयुक्ताः।';

  @override
  String get titleWarningDialog => 'सुरक्षाचेतावनी';

  @override
  String get bodyWarningDialog =>
      'अस्मिन् जाले सुरक्षादोषाः सन्ति। अस्योद्घाटनेन यन्त्रस्य हानिः सम्भवेत्।\n\nकिं भवन्तः अग्रे गन्तुम् इच्छन्ति?';

  @override
  String get titleCautionDialog => 'सावधानता';

  @override
  String get bodyCautionDialog =>
      'क्यूआर्-सङ्केतोद्घाटनात् पूर्वं मूलं सत्यापयतु।\n\nकिम् इदम् उद्घाटनीयम्?';

  @override
  String get labelOverlayLaserLine => 'दीप्तिरेखा';

  @override
  String get labelOverlayPulsingCorners => 'स्फुरन्तौ कोणाः';

  @override
  String get labelOverlayCyberneticGrid => 'तन्त्रजालिका';

  @override
  String get labelOverlaySubtleDotMatrix => 'बिन्दुमात्रिका';

  @override
  String get descOverlayLaserLine =>
      'उज्ज्वलदीप्तिरेखायुक्तम् अन्वीक्षणकोष्ठम्';

  @override
  String get descOverlayPulsingCorners => 'दीप्तियुक्ताः चलन्तश्च कोणाः';

  @override
  String get descOverlayCyberneticGrid => 'वैज्ञानिकजालिकायुक्तः संस्तरः';

  @override
  String get descOverlaySubtleDotMatrix => 'सूक्ष्मबिन्दुमात्रिकायुक्ता शैली';

  @override
  String get labelThemeSystemDefault => 'तन्त्रमानकम्';

  @override
  String get labelThemeLight => 'प्रकाशरूपम्';

  @override
  String get labelThemeDark => 'तिमिररूपम्';

  @override
  String get labelThemeOled => 'शुद्धकृष्णम्';

  @override
  String get titleThemeMode => 'रूपविधा';

  @override
  String get labelThemeChipSystem => 'तन्त्रम्';

  @override
  String get labelThemeChipLight => 'प्रकाशः';

  @override
  String get labelThemeChipDark => 'तिमिरम्';

  @override
  String get labelThemeChipOled => 'कृष्णम्';

  @override
  String get labelThemeDynamicColors => 'मटीरियलयू गतिकवर्णाः';

  @override
  String get descThemeDynamicColors =>
      'एण्ड्रायड् १२+ भित्तिचित्रवर्णानाम् उपयोगः';

  @override
  String get descThemeSystem => 'तन्त्रविन्यासम् अनुसरतु';

  @override
  String get descThemeLight => 'मानकप्रकाशविधा';

  @override
  String get descThemeDark => 'मानकतिमिरविधा';

  @override
  String get descThemeOled => 'शुद्धकृष्णम् (ऊर्जासंरक्षणम्)';

  @override
  String get titleSettings => 'विन्यासाः';

  @override
  String get labelSettingsFeedback => 'प्रतिसादः सूचनाश्च';

  @override
  String get labelSettingsPrivacy => 'गोपनीयता जालपरीक्षणं च';

  @override
  String get labelSettingsPermissions => 'अनुमतयः';

  @override
  String get descSettingsPermissions => 'प्रत्यक्षाः अन्तर्निहिताश्च अनुमतयः';

  @override
  String get labelSettingsHelp => 'साहाय्यं वैशिष्ट्यानि च';

  @override
  String get descSettingsHelp => 'ए-आर् दृष्टिः, वायु-क्यूआर्, जालसुरक्षा च';

  @override
  String get descSettingsAbout => 'संस्करणं, विधाता, अनुज्ञापत्रविवरणं च';

  @override
  String get labelFeedbackVibration => 'कम्पनप्रतिसादः';

  @override
  String get descFeedbackVibration => 'सङ्केतान्वीक्षणे दूरवाणीं कम्पयतु';

  @override
  String get labelFeedbackSound => 'ध्वनिप्रतिसादः';

  @override
  String get descFeedbackSound => 'सङ्केतान्वीक्षणे ध्वनिं जनयतु';

  @override
  String get labelFeedbackAnimation => 'पुष्टीकरणसञ्चलनम्';

  @override
  String get descFeedbackAnimation =>
      'सङ्केतान्वीक्षणे जालकस्पन्दनं सम्यक्-चिह्नं च दर्शयतु';

  @override
  String get titlePrivacyScreen => 'गोपनीयता जालपरीक्षणं च';

  @override
  String get labelPrivacyActiveChecks => 'सक्रियजालपरीक्षणम्';

  @override
  String get descPrivacySummaryOn => 'सक्रियजालपरीक्षणं प्रवर्तितम्';

  @override
  String get descPrivacySummaryOff => 'केवलम् अन्तस्थगोप्यपरीक्षणम्';

  @override
  String get labelApiKeyConfigured => 'विन्यस्तम्';

  @override
  String get labelApiKeyNotConfigured => 'न विन्यस्तम्';

  @override
  String get titleApiKeyDelete => 'API-कुञ्चिकां विलोपयतु';

  @override
  String get actionDelete => 'विलोपयतु';

  @override
  String get actionApiKeySave => 'कुञ्चिकां रक्षतु';

  @override
  String get titlePermissionsScreen => 'अनुमतिविवरणम्';

  @override
  String get helpPermissionsExplicitHeading => 'प्रत्यक्षसञ्चालनानुमतयः';

  @override
  String get helpPermissionCameraTitle =>
      'चित्रग्राही अनुमतिः (android.permission.CAMERA)';

  @override
  String get helpPermissionCameraDesc =>
      'अन्वीक्षणकाले एव प्रार्थ्यते। सजीवपरीक्षणाय ए-आर् पटलाय च आवश्यकी।';

  @override
  String get helpPermissionBiometricTitle =>
      'जैविकप्रमाणीकरणम् (android.permission.USE_BIOMETRIC)';

  @override
  String get helpPermissionBiometricDesc =>
      'गूढभाण्डाराणां गूढसङ्केतानां च उद्घाटनाय प्रयुज्यते।';

  @override
  String get helpPermissionsImplicitHeading => 'अन्तर्निहिततन्त्रानुमतयः';

  @override
  String get helpPermissionInternetTitle =>
      'अन्तर्जालप्रवेशः (android.permission.INTERNET)';

  @override
  String get helpPermissionInternetDesc =>
      'सक्रियपरीक्षणे गूगल-सुरक्षापरीक्षणे वा प्रयुज्यते।';

  @override
  String get helpPermissionVibrateTitle =>
      'कम्पननियन्त्रणम् (android.permission.VIBRATE)';

  @override
  String get helpPermissionVibrateDesc =>
      'अन्वीक्षणसूचनासु कुञ्चकस्पर्शनेषु च कम्पनं जनयति।';

  @override
  String get helpPermissionPhotoPickerTitle => 'चित्रचयनकम्';

  @override
  String get helpPermissionPhotoPickerDesc =>
      'सञ्चयप्रवेशं विना वीथिकायाः चित्राणि चिनोतु।';

  @override
  String get helpPermissionsSettingHeading => 'विन्यासाधारितानुमतयः';

  @override
  String get helpPermissionProbingTitle => 'सक्रियजालपरीक्षणम्';

  @override
  String get helpPermissionProbingDesc =>
      'प्रवर्तिते सति जालरूपान्तरणं परीक्षते। अन्यदा पूर्णतया अन्तस्थम्।';

  @override
  String get helpPermissionSafeBrowsingTitle => 'गूगल-सुरक्षितसञ्चार-API';

  @override
  String get helpPermissionSafeBrowsingDesc =>
      'कुञ्चिकाविन्यासे गूगल-सुरक्षाकोषे दुष्टसङ्केतान् परीक्षते।';

  @override
  String get helpPermissionFeedbackTitle => 'अन्वीक्षणकम्पनम्';

  @override
  String get helpPermissionFeedbackDesc =>
      'विन्यासे कम्पनप्रवर्तने एव प्रयुज्यते।';

  @override
  String get labelOn => 'सक्रियम्';

  @override
  String get labelOff => 'निष्क्रियम्';

  @override
  String get descPrivacyActiveChecks =>
      'निष्क्रियम्: सङ्केताः गोप्यतया परीक्ष्यन्ते — गन्तव्यजालकं न सम्पृच्यते।';

  @override
  String get bodyPrivacyExplainerOn =>
      'प्रवर्तिते सति जालस्थानं साक्षात् सम्पृच्यते। अनेन भवतः IP-सङ्केतः तत्र दृश्यते।';

  @override
  String get bodyPrivacyExplainerOff =>
      'अन्तस्थनियमैः एव सुरक्षितपरीक्षणं भवति। सङ्केताः कुत्रचिदपि न प्रेष्यन्ते।';

  @override
  String get bodyApiKeyDelete =>
      'किं भवन्तः Google Safe Browsing API-कुञ्चिकां विलोपयितुम् इच्छन्ति? अनेन जालसुरक्षापरीक्षणं निष्क्रिये भविष्यति।';

  @override
  String descFeedbackSummary(String vibration, String sound) {
    return 'कम्पनम्: $vibration • ध्वनिः: $sound';
  }

  @override
  String get labelResultTypeTextFallback => 'पाठः';

  @override
  String get labelCheckNameHttps => 'HTTPS संयोजनम्';

  @override
  String get labelCheckNameSsl => 'SSL/TLS प्रमाणत्रम्';

  @override
  String get labelCheckNameRedirect => 'पुनर्निर्देशन-विश्लेषणम्';

  @override
  String get labelCheckNamePattern => 'स्वरूप-ज्ञानम्';

  @override
  String get labelCheckNameShortener => 'ह्रस्व-सङ्केत-परीक्षणम्';

  @override
  String get labelCheckNameHomograph => 'समरूप-कपट-परीक्षणम्';

  @override
  String get labelCheckNameMalicious => 'अनिष्ट-विषय-परीक्षणम्';

  @override
  String get bodyHttpsNotUsed => 'अरक्षितं HTTP संयोजनं प्रयुक्तम्';

  @override
  String get bodySslPrivateModeOk =>
      'HTTPS प्रयुक्तम् (एकान्त-विधौ न परीक्षितम्)';

  @override
  String get bodySslValid => 'प्रमाणपत्रं प्रामाणिकम्';

  @override
  String get bodySslExpired => 'प्रमाणपत्रस्य कालः समाप्तः';

  @override
  String get bodySslNotYetValid => 'प्रमाणपत्रं न अद्यापि वैधम्';

  @override
  String get bodySslUnverifiable => 'प्रमाणपत्र-सत्यापनं न जातम्';

  @override
  String get bodySslCheckFailed => 'प्रमाणपत्र-परीक्षणं विफलम्';

  @override
  String get bodyRedirectSkippedPrivate => 'एकान्त-विधौ त्यक्तम्';

  @override
  String get bodyRedirectLoop => 'पुनर्निर्देशन-चक्रं प्राप्तम्';

  @override
  String get bodyRedirectNone => 'न कोऽपि पुनर्निर्देशः';

  @override
  String get bodyRedirectUnavailable => 'परीक्षणम् अशक्यम्';

  @override
  String get bodyPatternNone => 'न कोऽपि सन्दिग्ध-दोषः';

  @override
  String get bodyPatternUnavailable => 'विश्लेषणम् अशक्यम्';

  @override
  String get bodyShortenerOfflineHeuristics =>
      'पूर्ण-परीक्षणं न जातम् (अनुपलब्ध-जालम्)';

  @override
  String get bodyShortenerNone => 'न ह्रस्व-सङ्केतः';

  @override
  String get bodyShortenerUnavailable => 'परीक्षणम् अशक्यम्';

  @override
  String get bodyHomographMixedScripts => 'मिश्रित-लिपयः प्राप्ताः';

  @override
  String get bodyHomographNone => 'न कोऽपि समरूप-कपट-वर्णः';

  @override
  String get bodyHomographUnavailable => 'परीक्षणम् अशक्यम्';

  @override
  String get bodyMaliciousSkippedNoKey => 'त्यक्तम् (API कुञ्चिका न न्यस्ता)';

  @override
  String get bodyMaliciousDailyLimit => 'दैनिक-सीमा समाप्ता';

  @override
  String get bodyMaliciousNone => 'न कोऽपि ज्ञात-दोषः';

  @override
  String get bodyMaliciousInvalidKey => 'दोषयुक्ता API कुञ्चिका';

  @override
  String get bodyMaliciousRateLimited => 'गति-सीमा अतीता';

  @override
  String get bodyMaliciousUnavailable => 'परीक्षणम् अशक्यम्';

  @override
  String get errorStegoWrongPassphrase =>
      'उद्घाटनं विफलम्। अशुद्धं कूटवाक्यम्।';

  @override
  String get errorAirQrChecksumFailed => 'सङ्ख्या-परीक्षणं विफलम्।';

  @override
  String bodyRedirectSuspiciousChain(String count) {
    return 'सन्दिग्धा पुनर्निर्देशन-शृङ्खला ($count पुनर्निर्देशाः)';
  }

  @override
  String bodyRedirectWithinRange(String count) {
    return '$count पुनर्निर्देशाः - सामान्य-सीमायाम्';
  }

  @override
  String bodyPatternDetected(String patterns) {
    return 'प्राप्तम्: $patterns';
  }

  @override
  String bodyShortenerKnown(String shortener) {
    return 'ज्ञातः ह्रस्व-सङ्केतः प्राप्तः ($shortener)';
  }

  @override
  String bodyShortenerRedirect(String host) {
    return 'ह्रस्व-सङ्केतः ($host प्रति गच्छति)';
  }

  @override
  String bodyHomographLookalikes(String characters) {
    return 'समरूप-वर्णाः प्राप्ताः: $characters';
  }

  @override
  String bodyMaliciousThreats(String threats) {
    return 'दोषाः प्राप्ताः: $threats';
  }

  @override
  String bodyMaliciousApiError(String status) {
    return 'API दोषः (स्थितिः: $status)';
  }

  @override
  String get labelCheckNameVirusTotal => 'वायरसटोटल';

  @override
  String get bodyVirusTotalSkippedNoKey => 'त्यक्तम् (API कुञ्चिका न न्यस्ता)';

  @override
  String get bodyVirusTotalDailyLimit => 'दैनिक-सीमा समाप्ता (५००/दिनम्)';

  @override
  String bodyVirusTotalThreats(String engines) {
    return '$engines यन्त्रेण दोषाः प्राप्ताः';
  }

  @override
  String get bodyVirusTotalNone => 'न कोऽपि दोषः (वायरसटोटल)';

  @override
  String get bodyVirusTotalInvalidKey => 'दोषयुक्ता API कुञ्चिका (वायरसटोटल)';

  @override
  String get bodyVirusTotalRateLimited => 'गति-सीमा अतीता (वायरसटोटल)';

  @override
  String bodyVirusTotalApiError(String status) {
    return 'API दोषः (स्थितिः: $status)';
  }

  @override
  String get bodyVirusTotalUnavailable => 'परीक्षणम् अशक्यम् (वायरसटोटल)';

  @override
  String get labelCheckNameUrlhaus => 'URLhaus';

  @override
  String get bodyUrlhausSkippedNoKey => 'त्यक्तम् (API कुञ्चिका न न्यस्ता)';

  @override
  String bodyUrlhausMalware(String tags) {
    return 'दुष्टसङ्केतस्थानं प्राप्तम्: $tags';
  }

  @override
  String get bodyUrlhausClean => 'न कोऽपि दुष्ट-आतिथ्यम् (URLhaus)';

  @override
  String get bodyUrlhausNotFound => 'URLhaus-कोषे न विद्यते';

  @override
  String get bodyUrlhausInvalidKey => 'दोषयुक्ता API कुञ्चिका (URLhaus)';

  @override
  String bodyUrlhausApiError(String status) {
    return 'API दोषः (स्थितिः: $status)';
  }

  @override
  String get bodyUrlhausUnavailable => 'परीक्षणम् अशक्यम् (URLhaus)';

  @override
  String get labelCheckNamePhishTank => 'PhishTank';

  @override
  String get bodyPhishTankSkippedDisabled => 'त्यक्तम् (PhishTank निष्क्रियम्)';

  @override
  String get bodyPhishTankPhishing => 'ज्ञात-प्रलोभन-स्थानम् (PhishTank)';

  @override
  String get bodyPhishTankClean => 'प्रलोभन-स्थानं नास्ति (PhishTank)';

  @override
  String get bodyPhishTankNotInDatabase => 'PhishTank-कोषे न विद्यते';

  @override
  String bodyPhishTankApiError(String status) {
    return 'API दोषः (स्थितिः: $status)';
  }

  @override
  String get bodyPhishTankUnavailable => 'परीक्षणम् अशक्यम् (PhishTank)';

  @override
  String get labelCheckNameOpenPhish => 'OpenPhish';

  @override
  String get bodyOpenPhishSkippedDisabled => 'त्यक्तम् (OpenPhish निष्क्रियम्)';

  @override
  String get bodyOpenPhishPhishing => 'ज्ञात-प्रलोभन-स्थानम् (OpenPhish)';

  @override
  String get bodyOpenPhishClean => 'प्रलोभन-सूचौ न विद्यते (OpenPhish)';

  @override
  String get bodyOpenPhishFeedStale =>
      'सूचिः अनुपलब्धा — स्वस्थानीय-परीक्षणं त्यक्तम्';

  @override
  String get bodyOpenPhishUnavailable => 'परीक्षणम् अशक्यम् (OpenPhish)';

  @override
  String get labelSettingsUrlSafetyProviders => 'URL-सुरक्षा-दाताः';

  @override
  String descSettingsUrlSafetyProviders(String count) {
    return '$count दाता सक्रियाः';
  }

  @override
  String get helpUrlSafetyProviders =>
      'ऐच्छिकान् URL-सुरक्षा-परीक्षणान् संयोजयतु। प्रतिदाता स्वतन्त्रः। अव्यावसायिक-उपयोगिनः स्वकीयां कुञ्चिकां नयन्तु।';

  @override
  String get titleUrlSafetyUserSupplied => 'भवतः API कुञ्चिकाः';

  @override
  String get descUrlSafetyUserSupplied => 'केवलम् अव्यावसायिक-उपयोगः';

  @override
  String get titleUrlSafetyBuiltIn => 'अन्तर्निहित-दाताः';

  @override
  String get descUrlSafetyBuiltIn => 'खाता-रहितम् — केवलं सक्रियीकरणम्';

  @override
  String get labelProviderEndpoint => 'API-समाप्ति-सङ्केतः';

  @override
  String get labelProviderApiKey => 'API कुञ्चिकां योजयतु';

  @override
  String get bodyProviderGetKeyAt => 'निःशुल्क-कुञ्चिकार्थम्:';

  @override
  String bodyProviderDailyUsage(String used, String max) {
    return 'अद्य $used / $max अनुरोधाः';
  }

  @override
  String bodyOpenPhishLastUpdated(String datetime) {
    return 'अन्तिम-नवीकरणम्: $datetime';
  }

  @override
  String get actionOpenPhishRefresh => 'सूचिं नवीकरोतु';

  @override
  String bodyOpenPhishFeedRefreshed(String count) {
    return 'सूचिः नवीकृता ($count सङ्केताः)';
  }

  @override
  String get errorOpenPhishFeedFailed => 'सूचि-नवीकरणं विफलम्';

  @override
  String get labelPhishTankToggle => 'PhishTank सक्रियीकरणम्';

  @override
  String get labelOpenPhishToggle => 'OpenPhish-सूचिः उपयुज्यताम्';

  @override
  String get bodyQuishingSummaryAuthentic =>
      'प्रामाणिकः मुद्रित-सङ्केतः। न काऽपि विकृतिः।';

  @override
  String get bodyQuishingSummaryWearAndTear => 'घर्षण-विकृतिः प्राप्ता।';

  @override
  String get bodyQuishingSummaryHighWarning =>
      'उच्च-सावधानता: उपरि लेपित-पत्रं दृष्टम्!';

  @override
  String get bodyQuishingStatusAuthentic => '🟢 प्रामाणिकः मुद्रित-सङ्केतः';

  @override
  String get bodyQuishingStatusWearAndTear => '🟡 घर्षण-विकृतिः दृष्टा';

  @override
  String get bodyQuishingStatusHighWarning =>
      '🔴 उच्च-सावधानता: लेपित-पत्रं दृष्टम्!';

  @override
  String get bodyQuishingSignalMicroShadowPerimeter =>
      'सीमायां सूक्ष्म-छाया-रेखा दृष्टा';

  @override
  String get bodyQuishingSignalGrainAberration => 'मुद्रण-कण-विषमता प्राप्ता';

  @override
  String get bodyQuishingSignalUniformReflection => 'समान-प्रतिफलनं सत्यापितम्';

  @override
  String get bodyQuishingSignalConsistentDotsQrMatrix =>
      'सङ्केते बिन्दु-घनत्वं समानम्';

  @override
  String get bodyQuishingSignalReflectionVerified => 'प्रतिफलनं सत्यापितम्';

  @override
  String get bodyQuishingSignalHalftoneConsistentQrMatrix =>
      'सीमायां बिन्दु-घनत्वं समानम्';

  @override
  String get bodyQuishingSignalHalftoneConsistentMatrix =>
      'सर्वत्र बिन्दु-घनत्वं समानम्';

  @override
  String get bodyQuishingSignalDoubleEdgeAroundMatrix => 'द्विगुण-धारा दृष्टा';

  @override
  String get bodyQuishingSignalMicroShadowStickerBorder =>
      'पत्र-सीमायां सूक्ष्म-छाया दृष्टा';

  @override
  String get bodyQuishingSignalGrainMismatchBase =>
      'मुद्रण-कणानां विषमता प्राप्ता';

  @override
  String get bodyQuishingSignalMinorScratch => 'अल्पं घर्षणं दृष्टम्';

  @override
  String get bodyQuishingSignalSlightDotIrregularity => 'धारासु अल्प-विषमता';

  @override
  String get bodyQuishingSignalConsistentDotsMatrixPerimeter =>
      'सीमायां समान-घनत्वम्';

  @override
  String bodyQuishingSignalPerimeterDoubleEdge(String zones) {
    return 'द्विगुण-धारा-प्रतिफलनं दृष्टम् ($zones मण्डलानि)';
  }

  @override
  String bodyQuishingSignalDotDensityVariance(String variance) {
    return 'घनत्व-विषमता दृष्टा ($variance% भेदः)';
  }

  @override
  String get bodyDomSslInvalidScheme => 'अमान्य-विधिः';

  @override
  String get bodyDomSslHttps => 'सुरक्षितं HTTPS प्रयुक्तम्';

  @override
  String get bodyDomSslHttp => 'असुरक्षितं HTTP संयोजनम् (उच्च-सङ्कटम्)';

  @override
  String get bodyDomStatusInvalidUrl => 'अमान्यः सङ्केत-प्रकारः।';

  @override
  String get bodyDomStatusHttpCaution =>
      '⚠️ सावधानता: अरक्षितं HTTP जालस्थानम्';

  @override
  String get bodyDomStatusSafe =>
      '✅ सुरक्षित-कक्षा: HTML पूर्वदर्शनं शुद्धीकृतम्।';

  @override
  String bodyDomStatusOpenRedirect(String target) {
    return '⚠️ पूर्वसूचना: $target प्रति गच्छन् अनावृत-पुनर्निर्देशः प्राप्तः';
  }

  @override
  String bodyDomStatusNewDomain(String days) {
    return '⚠️ पूर्वसूचना: नूतन-पञ्जीकृतं क्षेत्रम् ($days दिनानि)';
  }

  @override
  String get errorStegoPassphraseEmpty => 'कूटवाक्यं रिक्तं न भवेत्';

  @override
  String get bodyStegoBiometricReason =>
      'गूढ-विषय-दर्शनाय प्रमाणीकरणं क्रियताम्';

  @override
  String get errorMediaNoCodeInImage => 'चित्रे सङ्केताः न दृष्टाः।';

  @override
  String get errorMediaNoCodeInPdf => 'PDF-प्रलेखे सङ्केताः न लब्धाः।';

  @override
  String errorMediaImagePickFailed(String error) {
    return 'चित्रपरीक्षणे दोषः: $error';
  }

  @override
  String errorMediaImageAnalyzeFailed(String error) {
    return 'चित्रविश्लेषणे दोषः: $error';
  }

  @override
  String errorMediaPdfPickFailed(String error) {
    return 'PDF-उद्घाटने दोषः: $error';
  }

  @override
  String errorMediaPdfScanFailed(String error) {
    return 'PDF-परीक्षणे दोषः: $error';
  }

  @override
  String get errorStegoBiometricCanceled =>
      'जैविक-प्रमाणीकरणं निरस्तं विफलम् वा।';

  @override
  String get labelFormatQrUrl => 'क्यूआर् (जालसङ्केतः)';

  @override
  String get labelFormatQrEmail => 'क्यूआर् (विद्युत्पत्रम्)';

  @override
  String get labelFormatQrPhone => 'क्यूआर् (दूरवाणी)';

  @override
  String get labelFormatQrSms => 'क्यूआर् (SMS)';

  @override
  String get labelFormatQrWifi => 'क्यूआर् (वै-फै)';

  @override
  String get labelFormatQrLocation => 'क्यूआर् (स्थानम्)';

  @override
  String get labelFormatQrContact => 'क्यूआर् (सम्पर्कः)';

  @override
  String get labelFormatIsbn => 'ISBN';

  @override
  String get labelFormatEanUpc => 'EAN/UPC';

  @override
  String get labelFormatQrCode => 'क्यूआर् सङ्केतः';

  @override
  String get labelFormatEanUpcProduct => 'EAN/UPC उत्पादः';

  @override
  String get labelFormatBarcode => 'दण्डसङ्केतः';

  @override
  String get labelWifiHiddenNetwork => 'गूढ-जालम्';

  @override
  String get labelTotpDefaultAccount => 'विवरणम्';

  @override
  String get errorBackupInvalidFormat => 'अमान्य-सञ्चिका-प्रकारः।';

  @override
  String get errorBackupBadHeader => 'दोषयुक्तः सञ्चिका-शीर्षभागः।';

  @override
  String get errorBackupWrongPassphrase =>
      'अशुद्धं कूटवाक्यं दोषयुक्तो विषयो वा।';

  @override
  String get bodyReportHeading =>
      'श्रीराज् पि क्यू-आर-कार्यशाला - संवीक्षा-इतिवृत्तम्';

  @override
  String get bodyReportTitle => 'इतिवृत्त-निर्यातः';

  @override
  String get labelReportExportDate => 'निर्यात-दिनाङ्कः';

  @override
  String get labelReportTotalScans => 'कुल-संवीक्षाः';

  @override
  String get labelReportScanNumber => 'सङ्ख्या #';

  @override
  String get labelReportId => 'अभिज्ञानम्     ';

  @override
  String get labelReportTimestamp => 'दिनाङ्कः समयश्च ';

  @override
  String get labelReportFormat => 'प्रकारः        ';

  @override
  String get labelReportCategory => 'वर्गः          ';

  @override
  String get labelReportSafetyScore => 'सुरक्षा-मानाङ्कः';

  @override
  String get labelReportStarred => 'तारकाङ्कितम्   ';

  @override
  String get labelReportStarredYes => '⭐ आम्';

  @override
  String get labelReportStarredNo => 'न';

  @override
  String get labelReportLocation => 'स्थानम्        ';

  @override
  String get labelReportNotes => 'टिप्पणी        ';

  @override
  String get labelReportContent => 'विषयः          ';

  @override
  String get labelReportColumnDateTime => 'दिनाङ्कः समयश्च';

  @override
  String get labelReportColumnFormat => 'प्रकारः';

  @override
  String get labelReportColumnCategory => 'वर्गः';

  @override
  String get labelReportColumnSafety => 'सुरक्षा';

  @override
  String get labelReportColumnContent => 'विषय-भागः';

  @override
  String get labelReportColumnNotes => 'टिप्पणी';

  @override
  String get labelPatternIpAddress => 'IP सङ्केतः';

  @override
  String get labelPatternLongNumbers => 'दीर्घा सङ्ख्या-शृङ्खला';

  @override
  String get labelPatternManyDashes => 'बहवः रेखाः';

  @override
  String get labelPatternPhishingKeywords => 'कपट-पदानि';

  @override
  String get labelPatternDataUri => 'दत्तांश-URI';

  @override
  String get labelPatternManySubdomains => 'बहूनि उपक्षेत्राणि';

  @override
  String get bodyShortenerPossibleShortDomain =>
      'ह्रस्व-सङ्केत-सम्भावना: लघु-क्षेत्रम्';

  @override
  String get bodyShortenerPossibleRandomPath =>
      'ह्रस्व-सङ्केत-सम्भावना: अनियता वर्णाः';

  @override
  String bodyShortenerPossibleTld(String tld) {
    return 'ह्रस्व-सङ्केत-सम्भावना ($tld)';
  }

  @override
  String get titleSettingsFeatures => 'वैशिष्ट्यानि';

  @override
  String get descSettingsFeatures => 'अनुप्रयोगस्य सर्वाणि वैशिष्ट्यानि पश्यतु';

  @override
  String get titleAppearanceHub => 'दृश्यरूपम्';

  @override
  String get labelAppearanceThemeModeCard => 'रूपविधा';

  @override
  String get descAppearanceThemeModeCard =>
      'तन्त्रं, प्रकाशः, तिमिरं, शुद्धकृष्णं वा चिनोतु';

  @override
  String get labelAppearanceOverlayCard => 'अन्वीक्षणसंस्तरशैली';

  @override
  String get descAppearanceOverlayCard =>
      'दीप्तिरेखा, कोणाः, जालिका, बिन्दुमात्रिका वा';

  @override
  String get labelAppearanceAccentCard => 'प्रधानवर्णाः गतिकवर्णाश्च';

  @override
  String get descAppearanceAccentCard => 'मटीरियलयू वर्णाः रुचिरवर्णाश्च';

  @override
  String get labelAppearanceTypographyCard => 'अक्षरशैली परिमाणं च';

  @override
  String get descAppearanceTypographyCard => 'वर्णलिपिः अक्षरपरिमाणविन्यासाश्च';

  @override
  String get titleFeaturesHeader => 'सर्वाणि वैशिष्ट्यानि';

  @override
  String get descFeaturesHeader =>
      'बुद्धिमदन्वीक्षणसाधनानि, षट्स्तरीयां जालसुरक्षां, ए-आर् दृष्टिं च पश्यतु।';

  @override
  String get titleFeaturesCatScanning => 'अन्वीक्षणम्';

  @override
  String get descFeaturesCatScanning =>
      'बहुस्रोत-माध्यम-समर्थम् अतिशीघ्रं 1D/2D दण्डलेखा-यन्त्रम्';

  @override
  String get titleFeaturesCatSafety => 'षट्स्तरीया सुरक्षा';

  @override
  String get descFeaturesCatSafety =>
      'दुष्ट-QR-प्रलोभनात् वञ्चनाभ्यः च भवन्तं रक्षति शून्यविश्वास-परीक्षणम्';

  @override
  String get titleFeaturesCatVision => 'दृष्टि-साधनानि';

  @override
  String get descFeaturesCatVision =>
      'यन्त्रे एव सङ्गणक-दृष्टिः प्रकाशमार्गेण विच्छिन्न-दत्तांश-प्रवाहः च';

  @override
  String get titleFeaturesCatPayloads => 'चतुर-क्रियाः';

  @override
  String get descFeaturesCatPayloads =>
      'दैनिक-दण्डलेखानां सद्यः विश्लेषणं सन्दर्भोचिताः क्रियाः च';

  @override
  String get titleFeaturesCatHistory => 'इतिवृत्तं गोपनीयता च';

  @override
  String get descFeaturesCatHistory =>
      'जैविक-सुरक्षया स्थानीय-सञ्चयेन च रक्षितं भवतः अन्वीक्षण-इतिवृत्तम्';

  @override
  String get titleFeatureBarcodeEngine => 'दण्डलेखा-यन्त्रम्';

  @override
  String get descFeatureBarcodeEngine =>
      '1D-दण्डलेखाः (EAN-13, UPC-A, Code 128, Code 39, Codabar, ITF) 2D-सङ्केतान् (QR, Data Matrix, Aztec, PDF417) च क्षणमात्रेण विकोडयति।';

  @override
  String get labelFeatureBarcodeEngineChip1 => 'QR, Data Matrix';

  @override
  String get labelFeatureBarcodeEngineChip2 => 'Aztec, PDF417';

  @override
  String get labelFeatureBarcodeEngineChip3 => 'EAN, Code 128';

  @override
  String get titleFeatureMediaSources => 'चित्राणि PDF च';

  @override
  String get descFeatureMediaSources =>
      'सजीव-छायाग्राहकात्, चित्रवीथ्याः चित्रेभ्यः, बहुपृष्ठ-PDF-लेखेभ्यः वा दण्डलेखाः अन्वीक्षताम्।';

  @override
  String get labelFeatureMediaSourcesChip1 => 'चित्रवीथी';

  @override
  String get labelFeatureMediaSourcesChip2 => 'बहुपृष्ठ-PDF';

  @override
  String get labelFeatureMediaSourcesChip3 => 'सजीव-दृश्यम्';

  @override
  String get titleFeatureGhostScan => 'छायावीक्षणम्';

  @override
  String get descFeatureGhostScan =>
      'सन्देश-अनुप्रयोगेषु, सामाजिक-पटलेषु, जालदर्शकेषु च पटले दृश्यमानान् QR-सङ्केतान् शीघ्रविन्यास-खण्डेन, प्लवमान-वीक्षण-बुद्बुदेन, इच्छया वा अन्विष्य विकोडयति। पटलचित्राणि न रक्ष्यन्ते।';

  @override
  String get labelFeatureGhostScanChip1 => 'शीघ्रविन्यास-खण्डः';

  @override
  String get labelFeatureGhostScanChip2 => 'वीक्षण-बुद्बुदः';

  @override
  String get labelFeatureGhostScanChip3 => 'पटलचित्रं न';

  @override
  String get titleFeatureCameraControls => 'छायाग्राहक-नियमनम्';

  @override
  String get descFeatureCameraControls =>
      'सुगमं विस्तारसर्पकम्, प्रकाशदीप-परिवर्तकम्, अग्र-पृष्ठ-छायाग्राहक-परिवर्तनम्, अल्पप्रकाशे अन्वीक्षणाय निरन्तरं स्वनाभीकरणं च।';

  @override
  String get labelFeatureCameraControlsChip1 => 'प्रकाशदीपः';

  @override
  String get labelFeatureCameraControlsChip2 => 'विस्तार-नियन्त्रणम्';

  @override
  String get labelFeatureCameraControlsChip3 => 'अग्र/पृष्ठ-परिवर्तनम्';

  @override
  String get titleFeatureScanOverlays => 'अन्वीक्षण-संस्तराः';

  @override
  String get descFeatureScanOverlays =>
      'दीप्तिरेखा, स्पन्दमान-कोणाः, सङ्गणक-जालकम्, सूक्ष्म-बिन्दु-जालं वा — एतेषु अन्वीक्षण-संस्तरेषु एकं चिनोतु।';

  @override
  String get labelFeatureScanOverlaysChip1 => '4 संस्तर-शैल्यः';

  @override
  String get labelFeatureScanOverlaysChip2 => 'सजीव-चलनम्';

  @override
  String get labelFeatureScanOverlaysChip3 => 'OLED-अनुकूलम्';

  @override
  String get titleFeatureFeedback => 'कम्पनं ध्वनिः च';

  @override
  String get descFeatureFeedback =>
      'परिवर्तनीयं कम्पनं बीप्-ध्वनिः च कोलाहलयुक्ते स्थाने अपि सफलम् अभिज्ञानं सूचयतः।';

  @override
  String get labelFeatureFeedbackChip1 => 'कम्पनम्';

  @override
  String get labelFeatureFeedbackChip2 => 'बीप्-ध्वनिः';

  @override
  String get labelFeatureFeedbackChip3 => 'पृथक्-नियन्त्रणानि';

  @override
  String get titleFeatureProtocolGuard => '1. नियमाचार-रक्षकः';

  @override
  String get descFeatureProtocolGuard =>
      'योजना-प्रामाण्यं गूढ-HTTPS-सम्बन्धं च परीक्षते। साधारण-HTTP अथवा असमर्थित-योजनाः सूचयति।';

  @override
  String get labelFeatureProtocolGuardChip1 => 'HTTPS-परीक्षा';

  @override
  String get labelFeatureProtocolGuardChip2 => 'योजना-परीक्षा';

  @override
  String get labelFeatureProtocolGuardChip3 => 'अदृश्याक्षर-पाशः';

  @override
  String get titleFeatureHomographShield => '2. समरूप-कवचम्';

  @override
  String get descFeatureHomographShield =>
      'कपट-क्षेत्रनामानि आच्छादयितुं प्रयुक्तानि सिरिलिक्-ग्रीक्-यूनिकोड-समरूपाक्षराणि अभिजानाति (IDN punycode-रक्षा)।';

  @override
  String get labelFeatureHomographShieldChip1 => 'Punycode-रक्षा';

  @override
  String get labelFeatureHomographShieldChip2 => 'सिरिलिक्-समरूपाणि';

  @override
  String get labelFeatureHomographShieldChip3 => 'मिश्रलिपि-पाशः';

  @override
  String get titleFeatureTldEntropy => '3. TLD-अव्यवस्था';

  @override
  String get descFeatureTldEntropy =>
      'उच्चसङ्कट-TLD-नामानि अतिमात्र-उपक्षेत्राणि च सूचयति। यन्त्रनिर्मित-क्षेत्राणि ज्ञातुं नाम्नः अक्षर-अव्यवस्थां मिनोति।';

  @override
  String get labelFeatureTldEntropyChip1 => 'सङ्कट-TLD';

  @override
  String get labelFeatureTldEntropyChip2 => 'अव्यवस्था-अङ्कः';

  @override
  String get labelFeatureTldEntropyChip3 => 'उपक्षेत्र-गभीरता';

  @override
  String get titleFeatureIpPort => '4. IP-द्वार-परीक्षा';

  @override
  String get descFeatureIpPort =>
      'साक्षात् IP-सङ्केतं प्रति अथवा अग्निभित्ति-लङ्घनाय असामान्य-HTTP/HTTPS-द्वाराणि प्रति गच्छन्तः सम्बन्धाः सूच्यन्ते।';

  @override
  String get labelFeatureIpPortChip1 => 'IP-पाशः';

  @override
  String get labelFeatureIpPortChip2 => 'असामान्य-द्वाराणि';

  @override
  String get labelFeatureIpPortChip3 => 'उपयोक्तृ-सूचना';

  @override
  String get titleFeatureHeadProbe => '5. जाल-परीक्षणम्';

  @override
  String get descFeatureHeadProbe =>
      'भवता अनुमते एव: लघु-HTTP-HEAD-परीक्षणेन लघु-URL-विस्तारणं, गुप्त-पुनर्निर्देशन-शृङ्खला-प्रकाशनं, TLS-प्रमाणपत्र-सत्यापनं च।';

  @override
  String get labelFeatureHeadProbeChip1 => 'पुनर्निर्देशन-शृङ्खला';

  @override
  String get labelFeatureHeadProbeChip2 => 'लघु-URL-विस्तारः';

  @override
  String get labelFeatureHeadProbeChip3 => 'ऐच्छिक-गोपनीयता';

  @override
  String get titleFeatureSafeBrowsing => '6. सुरक्षित-विचरणम्';

  @override
  String get descFeatureSafeBrowsing =>
      'कोटिशः ज्ञातानां दुष्ट-URL-नाम्नां, दुष्टतन्त्रांश-केन्द्राणां, सामाजिक-वञ्चना-स्थानानां च विरुद्धम् ऐच्छिकं मेघ-सङ्कट-ज्ञानम्।';

  @override
  String get labelFeatureSafeBrowsingChip1 => 'Google-सङ्कट-कोशः';

  @override
  String get labelFeatureSafeBrowsingChip2 => 'स्थानीय-कुञ्चिका';

  @override
  String get labelFeatureSafeBrowsingChip3 => 'दैनिक-सीमा-मापकः';

  @override
  String get titleFeatureQuishingGuard => 'क्विशिंग-रक्षकः™';

  @override
  String get descFeatureQuishingGuard =>
      'QR-उपरि लग्नानि आवरण-पत्राणि, प्रान्त-विच्छेदान्, सूक्ष्म-छायाः, मुद्रण-कणान् च अभिजानाति सङ्गणक-दृष्टिः।';

  @override
  String get labelFeatureQuishingGuardChip1 => 'लग्न-पत्राणि';

  @override
  String get labelFeatureQuishingGuardChip2 => 'प्रान्त-विच्छेदः';

  @override
  String get labelFeatureQuishingGuardChip3 => 'मुद्रणकण-विश्लेषणम्';

  @override
  String get titleFeatureArCodeVision => 'AR-सङ्केतदृष्टिः™';

  @override
  String get descFeatureArCodeVision =>
      'AR-बहुदण्डलेखा-अन्वीक्षकः — सर्वेषां लब्ध-सङ्केतानाम् उपरि सजीव-सुरक्षा-चिह्नैः युक्तानि चिप्-पत्राणि दर्शयति। समूहचयनम् अपि शक्यम्।';

  @override
  String get labelFeatureArCodeVisionChip1 => 'स्थानिकानुसरणम्';

  @override
  String get labelFeatureArCodeVisionChip2 => 'बहुसङ्केत-HUD';

  @override
  String get labelFeatureArCodeVisionChip3 => 'समूहचयनम्';

  @override
  String get titleFeatureAirQr => 'वायु-क्यूआर™ प्रवाहः';

  @override
  String get descFeatureAirQr =>
      'Wi-Fi Bluetooth वा विना, पूर्णतया जालरहितं, गूढ-पाठं सञ्चिकाः कुञ्चिकाः च चलत्-QR-द्वारा शीघ्रं प्रेषयति गृह्णाति च।';

  @override
  String get labelFeatureAirQrChip1 => 'चलत्-QR';

  @override
  String get labelFeatureAirQrChip2 => 'Reed-Solomon FEC';

  @override
  String get labelFeatureAirQrChip3 => '100% जालरहितम्';

  @override
  String get titleFeatureStegoQr => 'स्टेगो-क्यूआर™';

  @override
  String get descFeatureStegoQr =>
      'विशिष्ट-QR-सङ्केतेषु अदृश्यरूपेण निहितं गूढ-विषयं जलचिह्नित-दत्तांशं च अन्विष्य बहिः आनयति।';

  @override
  String get labelFeatureStegoQrChip1 => 'छद्म-QR-पठनम्';

  @override
  String get labelFeatureStegoQrChip2 => 'AES-विगूहनम्';

  @override
  String get labelFeatureStegoQrChip3 => 'जैविक-प्रवेशः';

  @override
  String get titleFeatureWifi => 'Wi-Fi सद्यः सम्बन्धः';

  @override
  String get descFeatureWifi =>
      'WPA/WPA2/WPA3 जाल-प्रमाणानि पठित्वा जाल-सूचनां दर्शयति, कूटशब्दं प्रतिलिखति, एकस्पर्शेन Wi-Fi-विन्यासम् उद्घाटयति।';

  @override
  String get labelFeatureWifiChip1 => 'WPA3, WPA2';

  @override
  String get labelFeatureWifiChip2 => 'एकस्पर्श-सम्बन्धः';

  @override
  String get labelFeatureWifiChip3 => 'कूटशब्द-दर्शनम्';

  @override
  String get titleFeaturePayments => 'UPI-गूढमुद्रा-प्रेषणम्';

  @override
  String get descFeaturePayments =>
      'भारतीय-UPI-QR-सङ्केतान् (GPay, PhonePe, Paytm प्रति प्रेषयति) Bitcoin/Ethereum/Solana-गूढमुद्रा-सङ्केतान् च धनराशिना सह पठति।';

  @override
  String get labelFeaturePaymentsChip1 => 'UPI-अनुप्रयोगः';

  @override
  String get labelFeaturePaymentsChip2 => 'गूढमुद्रा-कोशाः';

  @override
  String get labelFeaturePaymentsChip3 => 'SEPA-प्रेषणम्';

  @override
  String get titleFeatureTotp => 'TOTP-प्रमाणीकरणम्';

  @override
  String get descFeatureTotp =>
      '2FA-सज्जीकरण-सङ्केतान् अन्वीक्ष्य वृत्ताकार-गणनया सह सजीव-षडङ्क-OTP दर्शयति। प्रमाणीकरण-अनुप्रयोगेषु योजयितुं शक्यते।';

  @override
  String get labelFeatureTotpChip1 => 'सजीव-सङ्केताः';

  @override
  String get labelFeatureTotpChip2 => 'दृश्य-गणना';

  @override
  String get labelFeatureTotpChip3 => 'अनुप्रयोगे योजनम्';

  @override
  String get titleFeatureContacts => 'सम्पर्क-vCard-आयातः';

  @override
  String get descFeatureContacts =>
      'vCard 2.1/3.0/4.0 MeCard-सम्पर्क-सङ्केतान् च पठति। एकस्पर्शेन दूरवाणी-आह्वानं, विद्युत्पत्र-लेखनं, सम्पर्कसूच्यां रक्षणं च।';

  @override
  String get labelFeatureContactsChip1 => 'vCard 4.0';

  @override
  String get labelFeatureContactsChip2 => 'एकस्पर्श-रक्षणम्';

  @override
  String get labelFeatureContactsChip3 => 'आह्वानं विद्युत्पत्रम्';

  @override
  String get titleFeatureCalendar => 'दिनदर्शिका-घटनाः';

  @override
  String get descFeatureCalendar =>
      'आरम्भ-अन्त-समयैः, स्थानैः, विवरणैः च युक्तान् iCalendar VEVENT पठित्वा साक्षात् यन्त्रस्य दिनदर्शिकायां योजयति।';

  @override
  String get labelFeatureCalendarChip1 => 'iCal-पठनम्';

  @override
  String get labelFeatureCalendarChip2 => 'आरम्भ/अन्त-समयः';

  @override
  String get labelFeatureCalendarChip3 => 'दिनदर्शिकायां योजनम्';

  @override
  String get titleFeatureGeo => 'स्थानं मानचित्रं च';

  @override
  String get descFeatureGeo =>
      'geo: निर्देशाङ्कान् अन्वेषण-पदानि च पठित्वा Google Maps द्वारा सद्यः मार्गं दर्शयति।';

  @override
  String get labelFeatureGeoChip1 => 'अक्षांश/रेखांशौ';

  @override
  String get labelFeatureGeoChip2 => 'Google Maps-सम्बन्धः';

  @override
  String get labelFeatureGeoChip3 => 'अन्वेषण-पदानि';

  @override
  String get titleFeatureScanHistory => 'स्थानीय-इतिवृत्तम्';

  @override
  String get descFeatureScanHistory =>
      'प्रत्येकम् अन्वीक्षणं वर्गेण, सुरक्षा-अङ्केन, समयेन, तारकेण च सह यन्त्रे एव रक्षति। सजीव-पूर्णपाठ-अन्वेषणम् अपि।';

  @override
  String get labelFeatureScanHistoryChip1 => 'पूर्णपाठ-अन्वेषणम्';

  @override
  String get labelFeatureScanHistoryChip2 => 'वर्ग-छालनी';

  @override
  String get labelFeatureScanHistoryChip3 => 'प्रिय-तारकाः';

  @override
  String get titleFeatureBackups => 'JSON-CSV-सञ्चयाः';

  @override
  String get descFeatureBackups =>
      'सम्पूर्णम् अन्वीक्षण-इतिवृत्तं CSV-सारणीरूपेण गूढ-JSON-सञ्चयरूपेण वा निर्यातयतु। एकस्पर्शेन पुनःस्थापनम्।';

  @override
  String get labelFeatureBackupsChip1 => 'CSV-सारणी';

  @override
  String get labelFeatureBackupsChip2 => 'JSON-सञ्चयः';

  @override
  String get labelFeatureBackupsChip3 => 'एकस्पर्श-पुनःस्थापनम्';

  @override
  String get titleFeatureBiometricGuard => 'जैविक-पटल-सुरक्षा';

  @override
  String get descFeatureBiometricGuard =>
      'अङ्गुलिमुद्रया मुखेन दूरवाणी-पटल-तालकेन वा ऐच्छिकम् अनुप्रयोग-तालकम्। संवीक्षाः, इतिवृत्तम्, गुप्तविषयाः, API-कुञ्चिकाः च यत्र दृश्यन्ते, तानि पटलानि पटलचित्रं पटल-अभिलेखनं च निवारयन्ति (FLAG_SECURE)। गुप्त-StegoQR-सन्देशाः अपि जैवमापनं याचितुं शक्नुवन्ति।';

  @override
  String get labelFeatureBiometricGuardChip1 => 'जैविक-प्रमाणम्';

  @override
  String get labelFeatureBiometricGuardChip2 => 'पटलचित्र-निरोधः';

  @override
  String get labelFeatureBiometricGuardChip3 => 'गूढ-सङ्ग्रहः';

  @override
  String get titleFeatureOfflinePrivacy => '100% स्थानीय-गोपनीयता';

  @override
  String get descFeatureOfflinePrivacy =>
      'दण्डलेखानाम् अन्वीक्षणं विकोडनं विश्लेषणं च पूर्णतया भवतः दूरवाण्याम् एव। स्वतः कोऽपि दत्तांशः बहिः न प्रेष्यते।';

  @override
  String get labelFeatureOfflinePrivacyChip1 => 'दूरमापनं नास्ति';

  @override
  String get labelFeatureOfflinePrivacyChip2 => 'विज्ञापनानि न';

  @override
  String get labelFeatureOfflinePrivacyChip3 => 'मुक्त-स्रोतः';

  @override
  String get helpCenterHeaderTitle => 'साहाय्यकेन्द्रं मार्गदर्शिका च';

  @override
  String get helpCenterHeaderSubtitle =>
      'अनुप्रयोगस्य सर्वेषां वैशिष्ट्यानां विवरणात्मकानि सूत्राणि पठतु।';

  @override
  String get actionDecryptPayload => 'उद्घाट्यताम्';

  @override
  String get titleDecryptPayload => 'विषयः उद्घाट्यताम्';

  @override
  String get descDecryptPayload => 'गूढ-विषयस्य उद्घाटनाय कूटवाक्यं लिख्यताम्।';

  @override
  String get labelCipherMode => 'गूढ-प्रकारः';

  @override
  String get labelCipherModeAuto => 'स्वचालितम् / सामान्यम्';

  @override
  String get labelCipherModeAesGcm => 'AES-256-GCM (PBKDF2)';

  @override
  String get labelCipherModeAesCbc => 'AES-256-CBC';

  @override
  String get labelAirQrCode => 'सत्र-सङ्केतः';

  @override
  String get helpAirQrCode => 'यथा ABC-DEF';

  @override
  String get titleAirQrDetected => 'वायु-क्यूआर हस्तान्तरणम्';

  @override
  String get bodyAirQrDetected =>
      'अत्र गूढ-प्रकाश-हस्तान्तरणमस्ति। उद्घाटनाय प्रेषक-यन्त्रे दृष्टं सत्र-सङ्केतं लिखन्तु।';

  @override
  String get titleJsonEnvelopeDetected => 'गूढसञ्चिकाभाण्डारम्';

  @override
  String get bodyJsonEnvelopeDetected =>
      'अस्मिन् सङ्केते गूढदत्तांशः वर्तते। उद्घाटनाय कूटशब्दं ददातु।';

  @override
  String get labelDecryptedContent => 'उद्घाटित-विषयः:';

  @override
  String get errorManualDecryptionFailed =>
      'गूढोद्घाटने दोषः। कूटशब्दं सत्यापयतु।';

  @override
  String get titleEmailCard => 'विद्युत्पत्र-सङ्केतः';

  @override
  String get actionEmailSend => 'विद्युत्पत्रं प्रेष्यताम्';

  @override
  String get actionEmailCopy => 'प्रतिलिख्यताम्';

  @override
  String get errorEmailLaunchFailed => 'विद्युत्पत्र-अनुप्रयोगः न उद्घाटितः।';

  @override
  String get labelEmailSubject => 'विषयः';

  @override
  String get labelEmailBody => 'सन्देशः';

  @override
  String get titlePhoneCard => 'दूरवाणी-सङ्ख्या';

  @override
  String get actionPhoneCall => 'आहूयताम्';

  @override
  String get actionPhoneCopy => 'प्रतिलिख्यताम्';

  @override
  String get errorPhoneLaunchFailed => 'दूरवाणी न उद्घाटिता।';

  @override
  String get titleSmsCard => 'लघुसन्देशः';

  @override
  String get actionSmsSend => 'सन्देशः प्रेष्यताम्';

  @override
  String get actionSmsCopy => 'प्रतिलिख्यताम्';

  @override
  String get errorSmsLaunchFailed => 'सन्देश-अनुप्रयोगः न उद्घाटितः।';

  @override
  String get labelSmsBody => 'सन्देशः';

  @override
  String get titleAppLinkCard => 'अनुप्रयोगसम्पर्कः';

  @override
  String get actionAppLinkOpen => 'अनुप्रयोगाभ्यन्तरे उद्घाटयतु';

  @override
  String get errorAppLinkLaunchFailed =>
      'इदम् उद्घाटयितुं न शक्तम्। अनुप्रयोगः स्थापितः वा इति परीक्षताम्।';

  @override
  String get titleProductBarcodeCard => 'उत्पाद-दण्डलेखा';

  @override
  String get actionProductSearchFood => 'खाद्यविवरणम्';

  @override
  String get actionProductSearchWeb => 'जालेऽन्विष्यताम्';

  @override
  String get actionProductCopy => 'दण्डलेखा प्रतिलिख्यताम्';

  @override
  String get errorProductLaunchFailed => 'उत्पाद-अन्वेषणं न उद्घाटितम्।';

  @override
  String get titleIsbnCard => 'पुस्तकम् (ISBN)';

  @override
  String get actionIsbnGoogleBooks => 'गूगल-पुस्तकानि';

  @override
  String get actionIsbnOpenLibrary => 'मुक्त-ग्रन्थालयः';

  @override
  String get actionIsbnCopy => 'ISBN प्रतिलिख्यताम्';

  @override
  String get errorIsbnLaunchFailed => 'पुस्तक-अन्वेषणं न उद्घाटितम्।';

  @override
  String get labelHistoryFilterEmail => 'विद्युत्पत्रम्';

  @override
  String get labelHistoryFilterPhone => 'दूरवाणी';

  @override
  String get labelHistoryFilterSms => 'सन्देशः';

  @override
  String get labelHistoryFilterAppLink => 'सेतुः';

  @override
  String get labelHistoryFilterProductBarcode => 'उत्पादः';

  @override
  String get labelHistoryFilterIsbn => 'पुस्तकम्';

  @override
  String get tooltipScanFlashOff => 'दीपः: निष्क्रियः';

  @override
  String get tooltipScanFlashOn => 'दीपः: सक्रियः';

  @override
  String get tooltipScanFlashAuto => 'दीपः: स्वयञ्चालितः';

  @override
  String bodyScanFlashAutoActive(String lux) {
    return 'स्वयञ्चालितदीपः सक्रियः ($lux lux)';
  }

  @override
  String get tooltipCameraTune => 'चित्रग्राहीसंस्काराः';

  @override
  String get titleCameraTune => 'चित्रग्राहीसंस्काराः';

  @override
  String get labelCameraBrightness => 'द्युतिः';

  @override
  String get labelCameraContrast => 'वैषम्यम्';

  @override
  String get labelCameraInvert => 'वर्णव्युत्क्रमः (प्रतिलोमान्वीक्षणम्)';

  @override
  String get descCameraInvert => 'कृष्णपृष्ठे श्वेतसङ्केतानाम् अन्वीक्षणाय';

  @override
  String get labelCameraResolution => 'चित्रग्राहिसङ्कल्पना';

  @override
  String get tooltipCameraResolutionFullHd => '१०८०p, संस्तुतम्';

  @override
  String get tooltipCameraResolutionMax => 'महत्तमम् (४K UHD)';

  @override
  String get tooltipCameraResolutionHd => '७२०p, मन्दशक्तिः';

  @override
  String get actionCameraReset => 'संस्कारान् पुनरनुकूलयतु';

  @override
  String get labelSettingsLanguage => 'भाषा';

  @override
  String get labelLanguageSystemDefault => 'तन्त्रमानकम्';

  @override
  String get labelLanguageEnglish => 'English';

  @override
  String get labelLanguageMalayalam => 'മലയാളം';

  @override
  String get labelLanguageSanskrit => 'संस्कृतम्';

  @override
  String bodyAboutCopyright(String year) {
    return '© $year Sreeraj P. सर्वे अधिकाराः सुरक्षिताः।';
  }

  @override
  String get tooltipToggleFlash => 'द्योतकं परिवर्तयतु';

  @override
  String get tooltipCameraAdjustments => 'चित्रग्राहीसंस्काराः';

  @override
  String get tooltipZoomControls => 'विस्तारनियन्त्रणम्';

  @override
  String get tooltipSwitchCamera => 'चित्रग्राहीपरिवर्तनम्';

  @override
  String get tooltipBack => 'प्रतिनिवर्तताम्';

  @override
  String get tooltipToggleSecretVisibility => 'गूढप्रदर्शनं परिवर्तयतु';

  @override
  String get tooltipResetStream => 'प्रवाहं पुनरारभताम्';

  @override
  String get labelAirQrModeText => 'स्वेच्छापाठः';

  @override
  String get labelAirQrModeSync => 'उपकरणतुल्यकालिकता';

  @override
  String labelAirQrSyncIncludeHistory(int count) {
    return 'इतिवृत्तम् ($count)';
  }

  @override
  String get labelAirQrSyncIncludeSettings => 'अनुप्रयोगसंविधानानि योजयतु';

  @override
  String get labelAirQrSyncPassphrase => 'तुल्यकालनगुप्तपदम् / पिन्';

  @override
  String get helpAirQrSyncPassphrase => 'गूढपदं लिखतु';

  @override
  String get tooltipAirQrSyncGeneratePin => 'पिन्-सङ्ख्यां रचयतु';

  @override
  String get errorAirQrSyncNoData => 'वृत्तं संविधानानि वा चिनोतु।';

  @override
  String get titleAirQrSyncPackage => 'एयर्-क्यु-आर् संवृतसञ्चिका';

  @override
  String bodyAirQrSyncPackageSummary(int records) {
    return '$records अवलोकनवृत्तानि संविधानानि च सन्ति';
  }

  @override
  String get labelAirQrSyncEnterPassphrase => 'समन्वय-गुप्तपदम्';

  @override
  String get labelAirQrSyncRestoreHistory => 'इतिवृत्तं पुनःस्थापयतु';

  @override
  String get labelAirQrSyncApplySettings => 'संविधानानि प्रयोजयतु';

  @override
  String get actionAirQrSyncDecrypt => 'उद्घाट्य तुल्यकालीकरोतु';

  @override
  String bodyAirQrSyncSuccess(int count) {
    return '$count वृत्तानि संविधानानि च तुल्यकालीकृतानि!';
  }

  @override
  String get actionAirQrSyncBeam => 'एयर्-क्यु-आर् द्वारा प्रेषयतु';

  @override
  String get titleAirQrSyncSettings => 'एयर्-क्यु-आर् तुल्यकालनम्';

  @override
  String get descAirQrSyncSettings =>
      'सञ्जालं विना अन्योपकरणाय वृत्तं प्रेषयतु';

  @override
  String get tabScan => 'संवीक्षा';

  @override
  String get tabCodeForge => 'कोड-सृजनम्';

  @override
  String get tabHistory => 'इतिवृत्तम्';

  @override
  String get titleCodeForge => 'कोड-सृजनम्';

  @override
  String get labelCodeForgeSubtitle => 'सङ्केत-सृजन-शाला';

  @override
  String get labelCodeForgePresetText => 'पाठ्यम्';

  @override
  String get helpCodeForgeText =>
      'स्पष्टाय सुकराय च क्रमवीक्षणाय पाठ्यं ५०० वर्णेभ्यः न्यूनं स्थापयतु';

  @override
  String get actionCodeForgeLoadFromFile => 'सञ्चिकातः पठतु';

  @override
  String get tooltipCodeForgeLoadFromFile => 'सञ्चिकातः पठ्यताम्';

  @override
  String get errorCodeForgeFileEmpty => 'चितसञ्चिका रिक्ता अस्ति।';

  @override
  String get bodyCodeForgeFileTruncated =>
      'एकस्मिन् त्वरित-स्कैन-QR-संकेते समावेशनाय पाठः ५०० वर्णेभ्यः सीमितः कृतः।';

  @override
  String get bodyCodeForgeFileLoaded => 'सञ्चिकायाः पाठः सफलतया स्वीकृतः।';

  @override
  String get errorCodeForgeFileReadError => 'चितसञ्चिकायाः पठने असमर्थः।';

  @override
  String get labelCodeForgePresetUrl => 'जालसङ्केतः';

  @override
  String get labelCodeForgePresetWifi => 'वै-फाई';

  @override
  String get labelCodeForgePresetContact => 'सम्पर्कः';

  @override
  String get labelCodeForgePresetUpi => 'युपीआई';

  @override
  String get labelCodeForgePresetSms => 'सन्देशः';

  @override
  String get labelCodeForgePresetEmail => 'विद्युत्पत्रम्';

  @override
  String get labelCodeForgePresetGeo => 'स्थानम्';

  @override
  String get labelCodeForgeWifiSsid => 'संजालनाम (SSID)';

  @override
  String get labelCodeForgeWifiPassword => 'कूटशब्दः';

  @override
  String get labelCodeForgeWifiSecurity => 'सुरक्षा';

  @override
  String get labelCodeForgeWifiHidden => 'गूढसंजालम्';

  @override
  String get labelCodeForgeContactName => 'पूर्णनाम';

  @override
  String get labelCodeForgeContactPhone => 'दूरवाणी-सङ्ख्या';

  @override
  String get labelCodeForgeContactEmail => 'विद्युत्पत्र-सङ्केतः';

  @override
  String get labelCodeForgeContactOrg => 'संस्था';

  @override
  String get labelCodeForgeUpiVpa => 'युपीआई-सङ्केतः';

  @override
  String get labelCodeForgeUpiName => 'प्राप्तुर्नाम';

  @override
  String get labelCodeForgeUpiAmount => 'राशिः (रूप्यकम्)';

  @override
  String get labelCodeForgeUpiNote => 'टिप्पणी';

  @override
  String get labelCodeForgeSmsPhone => 'दूरवाणी-सङ्ख्या';

  @override
  String get labelCodeForgeSmsMessage => 'सन्देशः';

  @override
  String get labelCodeForgeEmailTo => 'विद्युत्पत्र-सङ्केतः';

  @override
  String get labelCodeForgeEmailSubject => 'विषयः';

  @override
  String get labelCodeForgeEmailBody => 'सन्देशः';

  @override
  String get labelCodeForgeGeoLat => 'अक्षांशः';

  @override
  String get labelCodeForgeGeoLng => 'रेखांशः';

  @override
  String get actionCodeForgeGeoUseMyLocation => 'मम स्थानम्';

  @override
  String get labelCodeForgeGeoFetching => 'स्थानं प्राप्यते…';

  @override
  String get errorCodeForgeGeoFailed => 'स्थानं न प्राप्तम्';

  @override
  String get errorCodeForgeGeoPermissionDenied => 'स्थान-अनुज्ञा निराकृता';

  @override
  String get titleCodeForgeDesignStudio => 'संरचना-विन्यासः';

  @override
  String get titleCodeForgeEyeShape => 'नेत्राकारः';

  @override
  String get titleCodeForgeEyeBallShape => 'तारकाकारः';

  @override
  String get titleCodeForgePatternShape => 'बिन्दुरुपाणि';

  @override
  String get labelCodeForgeShapeSquare => 'चतुरस्रम्';

  @override
  String get labelCodeForgeShapeDots => 'बिन्दवः';

  @override
  String get labelCodeForgeShapeRounded => 'वर्तुलाकारम्';

  @override
  String get labelCodeForgeShapeClassy => 'चारुरुपम्';

  @override
  String get labelCodeForgeShapeDiamond => 'वज्राकारम्';

  @override
  String get labelCodeForgeShapeLeaf => 'पर्णाकारम्';

  @override
  String get labelCodeForgeShapeCircle => 'मण्डलाकारम्';

  @override
  String get titleCodeForgeColorStudio => 'वर्णसंयोजनम्';

  @override
  String get titleCodeForgeFgColor => 'अग्रवर्णः';

  @override
  String get titleCodeForgeBgColor => 'पृष्ठवर्णः';

  @override
  String get labelCodeForgeGradientNone => 'एकवर्णः';

  @override
  String get labelCodeForgeGradientSunset => 'सूर्यास्तः';

  @override
  String get labelCodeForgeGradientOcean => 'सागरः';

  @override
  String get labelCodeForgeGradientNeon => 'प्रभा';

  @override
  String get labelCodeForgeGradientGold => 'राजस्वर्णम्';

  @override
  String get titleCodeForgeErrorCorrection => 'त्रुटि-शोधनम्';

  @override
  String get titleCodeForgeCenterBadge => 'केन्द्र-चिह्नम्';

  @override
  String get labelCodeForgeBadgeNone => 'किमपि न';

  @override
  String get labelCodeForgeBadgeIcon => 'विषय-चिह्नम्';

  @override
  String get labelCodeForgeBadgeShield => 'सुरक्षा-फलकम्';

  @override
  String get actionCodeForgeExportPng => 'चित्रांश-भाजनम्';

  @override
  String get actionCodeForgeExportSvg => 'सदिश-भाजनम्';

  @override
  String get tooltipCodeForgeCopyPayload => 'प्रतिलिख्यताम्';

  @override
  String get bodyCodeForgeCopied => 'विषयः फलके प्रतिलेखितः';

  @override
  String get bodyCodeForgeSafeVerified =>
      'षड्विध-सुरक्षा-तन्त्रेण प्रमाणीकृतम्';

  @override
  String get tooltipCodeForgeResetStyle => 'विन्यासः प्रत्यानयताम्';

  @override
  String get labelCodeForgeIncludeText => 'सङ्ख्या दृश्यताम्';

  @override
  String get titleCodeForgePreview => 'प्रत्यक्ष-प्रदर्शनम्';

  @override
  String get actionOnboardingSkip => 'त्यजतु';

  @override
  String get actionOnboardingNext => 'अग्रिमम्';

  @override
  String get actionOnboardingGetStarted => 'स्कैन आरभताम्';

  @override
  String get labelOnboardingSlide1Badge => 'षट्स्तरीयरक्षा';

  @override
  String get titleOnboardingSlide1 => 'षट्स्तरीया सुरक्षा';

  @override
  String get bodyOnboardingSlide1 =>
      'उद्घाटनात् पूर्वं प्रत्येकः सम्पर्कतन्तुः षण्णां रक्षास्तराणां द्वारा परीक्ष्यते। एतत् कपटजालात्, वञ्चकपुनर्निर्देशनात्, कूटडोमेनात् च रक्षति।';

  @override
  String get bodyOnboardingSlide1Bullet1 => 'प्रोटोकॉल-कूटडोमेन-कवचम्';

  @override
  String get bodyOnboardingSlide1Bullet2 => 'टीएलडी-एन्ट्रोपी-पोर्ट-परीक्षणम्';

  @override
  String get bodyOnboardingSlide1Bullet3 => 'गोप्यपरीक्षणं सुरक्षितअन्वेषणं च';

  @override
  String get labelOnboardingSlide2Badge => 'सङ्गणकदृष्टिः';

  @override
  String get titleOnboardingSlide2 => 'विकृति-शोधनम्';

  @override
  String get bodyOnboardingSlide2 =>
      'वास्तविकसङ्केतानाम् उपरि आरोपितान् कपट-क्यूआर-पत्रकान् क्विशिङ्गगार्ड-यन्त्रं परीक्षते। स्कैनकरणात् पूर्वं भित्तीः, छायाः, पत्राकारांश्च अवलोकयति।';

  @override
  String get bodyOnboardingSlide2Bullet1 => 'आरोपितपत्रकस्य शोधनम्';

  @override
  String get bodyOnboardingSlide2Bullet2 =>
      'छिन्नधाराणां छायासीम्नां च परीक्षणम्';

  @override
  String get bodyOnboardingSlide2Bullet3 => 'प्रत्यक्ष-दृश्यचक्र-परीक्षणम्';

  @override
  String get labelOnboardingSlide3Badge => 'अनुवर्तन-शून्यम्';

  @override
  String get titleOnboardingSlide3 => '100% स्थानीय-गोपनीयता';

  @override
  String get bodyOnboardingSlide3 =>
      'भवतः सङ्केतलेखाः वैयक्तिकविवरणानि च कदापि दूरभाषं न त्यजन्ति। अत्र न विश्लेषणानि, न विज्ञापनं, न च अनुवर्तकाः।';

  @override
  String get bodyOnboardingSlide3Bullet1 => 'गूढलिखितं स्थानिक-दत्तांशस्थानम्';

  @override
  String get bodyOnboardingSlide3Bullet2 => 'एयर्-क्यूआर-दृश्यक-स्थानान्तरणम्';

  @override
  String get bodyOnboardingSlide3Bullet3 => 'विश्लेषण-रहितं सुरक्षित-रचना';

  @override
  String get labelSettingsOnboardingTour => 'स्वागत-परिचय-प्रवासः';

  @override
  String get descSettingsOnboardingTour =>
      'सुरक्षा-गोपनीयता-वैशिष्ट्यानां त्रिफलक-परिचयं पुनः पश्यतु';

  @override
  String get tooltipBatchMode => 'संतत-गणस्कैनिङ्ग्';

  @override
  String get bodyBatchModeEnabled => 'संतत-गणस्कैनिङ्ग् सक्रियम्';

  @override
  String get bodyBatchModeDisabled => 'संतत-गणस्कैनिङ्ग् निष्क्रियम्';

  @override
  String labelBatchCounter(int count) {
    return '$count स्कानिनानि';
  }

  @override
  String get labelBatchReview => 'गणस्कैन्-सूची';

  @override
  String get descBatchReview => 'संततस्कैनिङ्ग्-पङ्क्तिः';

  @override
  String get emptyBatchTitle => 'गणे कोडाः अविद्यमानाः';

  @override
  String get emptyBatchBody =>
      'कॅमरां विना त्यक्त्वा संतततया कोडान् स्कैन् कुरु।';

  @override
  String get titleBatchExport => 'गणनिर्यातयतु';

  @override
  String get actionBatchClear => 'गणं रिक्तीकुरु';

  @override
  String get titleBatchClearConfirm => 'गणं रिक्तीकरोतु वा?';

  @override
  String get bodyBatchClearConfirm =>
      'किं भवान् अस्य गणस्य सर्वान् कोडान् निष्कासयितुम् इच्छति?';

  @override
  String get labelBatchPreventDuplicates => 'पुनरावृत्तिनिवारणम्';

  @override
  String bodyBatchScanned(int count, String content) {
    return 'स्कानितम् #$count: $content';
  }

  @override
  String get bodyBatchAnalyzingUrl => 'सम्पर्कविश्लेषणं प्रचलति...';

  @override
  String bodyBatchUrlSafetySummary(
    int safeCount,
    int warningCount,
    int totalUrls,
  ) {
    return '$totalUrls सम्पर्कैः $safeCount सुरक्षिताः, $warningCount संदिग्धाः';
  }

  @override
  String get titleBatchItemDetails => 'स्कानितकोडविवरणम्';

  @override
  String get labelCameraDistanceEnhance => 'दूरस्थवीक्षणसहायः';

  @override
  String get descCameraDistanceEnhance =>
      'दूरस्थचित्रपट्टानां कृते विस्तारकर्तनं तीक्ष्णीकरणं च';

  @override
  String get labelCameraUnsharp => 'धारातीक्ष्णीकरणम्';

  @override
  String get labelCameraDistanceZoom => 'दूरविस्तारः';

  @override
  String get tooltipScanFromClipboard => 'फलकात् स्कैन् कुर्वन्तु';

  @override
  String get bodyClipboardBanner => 'फलके सामग्री प्राप्ता';

  @override
  String get actionClipboardScan => 'स्कैन् क्रियताम्';

  @override
  String get tooltipClipboardDismiss => 'निरस्यतु';

  @override
  String get errorClipboardNoValidContent =>
      'फलके कोऽपि स्कैन्-योग्यः सङ्केतः न प्राप्तः';

  @override
  String get labelClipboardTypeUrl => 'सम्पर्कतन्तुः';

  @override
  String get labelClipboardTypeBarcode => 'बारकोड-दत्तांशः';

  @override
  String get labelClipboardTypeImage => 'चित्रम्';

  @override
  String get labelClipboardTypeText => 'पाठः';

  @override
  String get bodyMultiCodeDetected =>
      'बहवः सङ्केताः दृष्टाः। स्कैनाय सङ्केतं स्पृशतु।';

  @override
  String get tooltipMultiCodeTapToScan => 'स्कैनाय स्पृशतु';

  @override
  String get labelMultiCodeSelection => 'बहु-सङ्केत-चयनम्';

  @override
  String get descMultiCodeSelection =>
      'यदा बहवः स्युः तदा दृश्यसङ्केतान् रूपरेखयित्वा चयनार्थं स्पृशतु';

  @override
  String get tooltipMultiCodeDismiss => 'चयनं निराकरोतु';

  @override
  String get labelGhostScan => 'छायावीक्षणम्';

  @override
  String get descGhostScan => 'पटपुटस्थ-क्यु-आर्-अन्वेषकम्';

  @override
  String get bodyGhostScan =>
      'कस्यामपि प्रयुक्तौ पटपुटे दृश्यमानान् क्यु-आर्-सङ्केतान् छायाचित्रणं विना अभिजानातु।';

  @override
  String get actionGhostScanNow => 'अधुना पटपुटं वीक्षताम्';

  @override
  String get actionGhostScanAddTile => 'शीघ्रसंयोजन-पट्टिका योज्यताम्';

  @override
  String get bodyGhostScanTileAdded => 'शीघ्रसंयोजन-पट्टिकानुरोधः प्रेषितः';

  @override
  String get titleGhostScanHowItWorks => 'छायावीक्षणस्य उपयोगविधिः';

  @override
  String get helpGhostScanStep1 =>
      'कस्यामपि प्रयुक्तौ शीघ्रसंयोजन-छादनम् अधः आकर्षतु।';

  @override
  String get helpGhostScanStep2 =>
      'पटपुटस्य क्यु-आर्-सङ्केतं पठितुं छायावीक्षण-पट्टिकां स्पृशतु।';

  @override
  String get helpGhostScanStep3 =>
      'चित्रागारे रक्षणं विना एव सङ्केतः सद्यः पठ्यते।';

  @override
  String get bodyGhostScanAnalyzing => 'पटपुटविषयस्य विश्लेषणं क्रियते...';

  @override
  String get helpGuideGroupScanning => 'संवीक्षा-मार्गदर्शिकाः';

  @override
  String get helpGuideGroupSecurity => 'सुरक्षा सङ्कटनिवारणं च';

  @override
  String get helpGuideGroupPayloads => 'विषयः, सङ्ग्रहः, गोपनीयता च';

  @override
  String get titleHelpBarcode => 'सङ्केत-संवीक्षा';

  @override
  String get helpGuideBarcodeName => 'सङ्केत-माध्यम-संवीक्षा';

  @override
  String get helpGuideBarcodeSummary =>
      'सजीव-चित्रग्राहि-नियन्त्रणानि, चित्रसङ्ग्रहस्य चित्राणि, बहुपृष्ठ-PDF-लेखानां संवीक्षा च।';

  @override
  String get helpGuideBarcodeIntro =>
      'अतिसूक्ष्मया सङ्गणक-दृष्ट्या सजीव-चित्रग्राहिणा, चित्रसङ्ग्रहस्य चित्रैः, बहुपृष्ठ-PDF-लेखैः वा यत्किमपि 1D अथवा 2D सङ्केतं सद्यः संवीक्षताम्।';

  @override
  String get helpGuideBarcodeCameraTitle => 'सजीव-चित्रग्राहि-दृश्यम्';

  @override
  String get helpGuideBarcodeCameraBullet1 =>
      'QR, Data Matrix, Aztec, PDF417, EAN-13, UPC-A, Code 128, Codabar इत्येतेषु यत्किमपि चिह्नं प्रति चित्रग्राहिणं नयतु।';

  @override
  String get helpGuideBarcodeCameraBullet2 =>
      'दीपः आवर्धनं च: अल्पप्रकाशे दीप-चिह्नं स्पृशतु। दूरात् सघन-सूक्ष्म-QR-सङ्केतान् पठितुम् आवर्धन-सर्पकः प्रयुज्यताम्।';

  @override
  String get helpGuideBarcodeCameraBullet3 =>
      'दर्शक-आवरणानि: विन्यासाः -> दृश्यरूपं वर्णाश्च इत्यत्र संवीक्षा-परिधेः रूपं स्वरुच्यनुसारं परिवर्तयतु।';

  @override
  String get helpGuideBarcodeGalleryTitle =>
      'चित्रसङ्ग्रहस्य चित्राणां संवीक्षा';

  @override
  String get helpGuideBarcodeGalleryBullet1 =>
      'यन्त्रे रक्षितं यत्किमपि चित्रं पटलचित्रं वा चेतुं संवीक्षक-पटले चित्रसङ्ग्रह-चिह्नं स्पृशतु।';

  @override
  String get helpGuideBarcodeGalleryBullet2 =>
      'विस्तृत-सङ्ग्रह-अनुमतिं विना गोपनीयता-रक्षकं Android-चित्रचयनकं प्रयुङ्क्ते।';

  @override
  String get helpGuideBarcodeGalleryBullet3 =>
      'संवीक्षकः पूर्ण-विभेदन-चित्रं विश्लेष्य सहस्रांश-क्षणेषु बहून् सङ्केतान् अन्विष्य पठति।';

  @override
  String get helpGuideBarcodePdfTitle => 'बहुपृष्ठ-PDF-संवीक्षा';

  @override
  String get helpGuideBarcodePdfBullet1 =>
      'सञ्चिका-चयनकेन साक्षात् PDF-लेखं (यथा देयक-पत्रं, प्रवेशपत्रं, विमानारोहण-पत्रं वा) चिनोतु।';

  @override
  String get helpGuideBarcodePdfBullet2 =>
      'प्रत्येकं पृष्ठं स्मृतौ एव निष्कास्य प्रदर्शयति, प्रतिपृष्ठं लब्धानां सर्वेषां सङ्केतानां सूचीं च रचयति।';

  @override
  String get helpGuideBarcodePdfBullet3 =>
      'लब्धान् सर्वान् सङ्केतान् विशिष्टे अधःपत्रे परीक्ष्य एकेन स्पर्शेन संवीक्षा-इतिवृत्ते रक्षतु।';

  @override
  String get helpGuideBarcodeTip =>
      'सूचना: सङ्केताभिज्ञानं शतप्रतिशतं (100%) भवतः यन्त्रे एव प्रचलति। चित्रग्राहि-दृश्यानि चित्राणि वा मेघसङ्गणके (cloud) न आरोप्यन्ते।';

  @override
  String get titleHelpArCodeVision => 'ए-आर् दृष्टिः';

  @override
  String get helpGuideArCodeVisionName => 'AR CodeVision™ देशिक-HUD';

  @override
  String get helpGuideArCodeVisionSummary =>
      'बहुसङ्केतानां तात्कालिकम् अनुसरणम्, प्लवमान-चिह्नानि, सामूहिक-क्रियाः च।';

  @override
  String get helpGuideArCodeVisionIntro =>
      'AR CodeVision™ भवतः चित्रग्राहि-दृश्यं संवर्धितवास्तविकतायुक्ते देशिक-प्रदर्शके (HUD) परिणमयति, यत् बहून् सङ्केतान् युगपत् तत्क्षणम् अन्विष्यति, अनुसरति, विश्लेषयति च।';

  @override
  String get helpGuideArCodeVisionTrackingTitle =>
      'तात्कालिकं देशिकम् अनुसरणम्';

  @override
  String get helpGuideArCodeVisionTrackingBullet1 =>
      'दृश्यक्षेत्रे विद्यमानान् सर्वान् सङ्केतान् युगपत् अभिजानाति, प्रत्येकस्मिन् सङ्केते 2D/3D-अनुसरण-नङ्गरं स्थापयति च।';

  @override
  String get helpGuideArCodeVisionTrackingBullet2 =>
      'चित्रग्राहिणि चाल्यमाने अपि पटले प्रत्येकस्य सङ्केतस्य उपरि प्लवमानानि स्पर्श्य-चिह्नानि प्रदर्शयति।';

  @override
  String get helpGuideArCodeVisionTrackingBullet3 =>
      'वर्णाङ्कितानि तात्कालिक-सुरक्षा-चिह्नानि सम्पर्कः सत्यापित-सुरक्षितः (हरितः) उत कपट-शङ्कितः (रक्तः) इति सद्यः सूचयन्ति।';

  @override
  String get helpGuideArCodeVisionBatchTitle => 'बहुचयनं सामूहिक-क्रियाः च';

  @override
  String get helpGuideArCodeVisionBatchBullet1 =>
      'यत्किमपि प्लवमान-चिह्नं स्पृशतु — तस्य विषयं परीक्षितुं, प्रसङ्गोचिताः क्रियाः कर्तुं, विस्तृतम् AR-क्रियापत्रं वा उद्घाटयितुम्।';

  @override
  String get helpGuideArCodeVisionBatchBullet2 =>
      'भाण्डागार-फलकेषु, उत्पाद-सूचीषु, उत्सव-परिचयपत्रेषु वा विद्यमानान् बहून् सङ्केतान् चित्वा सामूहिकं संसाधयतु।';

  @override
  String get helpGuideArCodeVisionBatchBullet3 =>
      'चितानां सर्वेषां विषयम् एकेन स्पर्शेन प्रतिलिखतु, इतिवृत्ते वा निर्यातयतु।';

  @override
  String get helpGuideArCodeVisionHudTitle => 'HUD-नियन्त्रणानि कार्यक्षमता च';

  @override
  String get helpGuideArCodeVisionHudBullet1 =>
      'HUD-क्रियापट्टिका: चित्रग्राहि-दीपः, आवर्धन-स्तरः, अग्र/पृष्ठ-चित्रग्राहि-परिवर्तनं, लक्ष्य-मार्जनं च इत्येतेषां द्रुत-नियन्त्रणानि।';

  @override
  String get helpGuideArCodeVisionHudBullet2 =>
      'चित्रगतेः सुसंस्कृत-संसाधनेन दीर्घ-संवीक्षाकाले अपि यन्त्रम् अतितप्तं न भवति, विद्युत्कोशः च रक्ष्यते।';

  @override
  String get helpGuideArCodeVisionTip =>
      'सूचना: बहुसङ्केत-सङ्कुलेषु स्थानेषु इष्टान् सङ्केत-समूहान् सूक्ष्मतया पृथक्कर्तुम् आवर्धन-सर्पकः प्रयुज्यताम्।';

  @override
  String get titleHelpAirQr => 'वायु-क्यूआर-मार्गदर्शिका';

  @override
  String get helpGuideAirQrName => 'AirQR™ प्रकाशीय-वायुविच्छेद-प्रवाहः';

  @override
  String get helpGuideAirQrSummary =>
      'वितन्तु-तरङ्गान् विना चल-QR-सङ्केतैः अन्तर्जालरहितं दत्तांश-प्रेषणं ग्रहणं च।';

  @override
  String get helpGuideAirQrIntro =>
      'AirQR™ यन्त्रयोः मध्ये पूर्णतया अन्तर्जालरहितं द्विदिशं प्रकाशीयं दत्तांश-मार्गं रचयति। अत्र द्रुतगतिभिः चल-QR-चित्रैः कार्यं सिध्यति; Wi-Fi, ब्लूटूथ्, चलदूरवाणी-दत्तांशः, भौतिक-तन्त्रिका वा न अपेक्ष्यन्ते।';

  @override
  String get helpGuideAirQrStreamingTitle => 'प्रकाशीय-प्रवाहस्य कार्यपद्धतिः';

  @override
  String get helpGuideAirQrStreamingBullet1 =>
      'बृहत्सञ्चिकाः, गूढलेखन-कुञ्चिकाः, दीर्घलेखाः वा लघु-दत्तांश-खण्डेषु विभज्यन्ते। तैः सह अतिरिक्ताः निर्झर-सङ्केत-(fountain code)-पुनर्निर्माण-खण्डाः अपि प्रेष्यन्ते, यैः ग्राहकः लुप्तखण्डान् पुनः रचयितुं शक्नोति।';

  @override
  String get helpGuideAirQrStreamingBullet2 =>
      'प्रेषक-यन्त्रं चल-QR-प्रवाहं स्वेच्छया नियोज्यया चित्रगत्या (5 तः 25 FPS पर्यन्तम्) प्रदर्शयति।';

  @override
  String get helpGuideAirQrStreamingBullet3 =>
      'ग्राहक-यन्त्रं चित्रक्रमं निरन्तरं गृह्णाति; सम्पूर्णः विषयः यावत् पुनः संयुज्यते तावत् लुप्तखण्डान् तत्क्षणमेव पुनः रचयति च।';

  @override
  String get helpGuideAirQrSecurityTitle => 'वायुविच्छेद-सुरक्षा गोपनीयता च';

  @override
  String get helpGuideAirQrSecurityBullet1 =>
      'पूर्णं वितन्तु-मौनम्: विद्युच्चुम्बकीय-तरङ्गाणां लेशः अपि न उत्सृज्यते (न RF-प्रसारणम्, न युग्मन-याचना, न जाल-अभिलेखः)।';

  @override
  String get helpGuideAirQrSecurityBullet2 =>
      'दूरस्थ-जालापहरणम्, मध्यस्थाक्रमणानि (man-in-the-middle), ब्लूटूथ्-गुप्तश्रवणं च अत्र न प्रभवन्ति।';

  @override
  String get helpGuideAirQrSecurityBullet3 =>
      'वायुविच्छिन्न-गूढमुद्रा-कोशानां (cold wallets), गोपनीय-प्रमाणानां, सुरक्षित-अन्तर्जालरहित-दत्तांश-विनिमयस्य च कृते सर्वथा उचितम्।';

  @override
  String get helpGuideAirQrControlsTitle => 'प्रेषक-ग्राहक-नियन्त्रणानि';

  @override
  String get helpGuideAirQrControlsBullet1 =>
      'प्रेषक-पटलम्: चित्रगतिं (FPS) चिनोतु, प्रवाहे विद्यमानानां चित्राणां सम्पूर्ण-सङ्ख्यां च पश्यतु।';

  @override
  String get helpGuideAirQrControlsBullet2 =>
      'ग्राहक-पटलम्: तात्कालिक-प्रगति-रेखा, गृहीत-चित्र-गणकः, लुप्त-चित्र-क्रमाङ्काः, चेक्सम्-सत्यापनं च।';

  @override
  String get helpGuideAirQrTip =>
      'सूचना: AirQR-प्रवाहं गृह्णन् दूरवाणीं स्थिरं धारयतु। चित्राणां द्रुततम-ग्रहणाय प्रेषक-पटलस्य दीप्तिः उच्चा भवतु।';

  @override
  String get titleHelpUrlSafety => 'जालसङ्केत-सुरक्षा';

  @override
  String get helpGuideUrlSafetyName => 'षट्स्तरीयं URL-सुरक्षा-यन्त्रम्';

  @override
  String get helpGuideUrlSafetySummary =>
      'समरूपलिपि-आक्रमणानि, punycode-रक्षा, शङ्कास्पद-TLD, द्वार-पाशाः च।';

  @override
  String get helpGuideUrlSafetyIntro =>
      'संवीक्षितं यत्किमपि जालसम्पर्कम् उद्घाटयितुं पूर्वम्, अस्माकं षट्स्तरीयं सूक्ष्म-सुरक्षा-यन्त्रं URL-सङ्केतम् आधुनिक-कपटजाल-लक्षणानां, समरूपलिपि-वञ्चना-आक्रमणानां, दुष्ट-पुनर्निर्देशन-पाशानां च विरुद्धं परीक्षते।';

  @override
  String get helpGuideUrlSafetyLayersTitle => 'षट् सुरक्षास्तराः सविस्तरम्';

  @override
  String get helpGuideUrlSafetyLayersBullet1 =>
      'स्तरः 1: नियमावली-योजना-रक्षकः - HTTPS-गूढलेखनम् आग्रहयति, मानक-नियमावली-रूपं सत्यापयति, विकृत-रूपाणि शून्य-विस्तार-वर्ण-पाशान् (zero-width) च निरुणद्धि।';

  @override
  String get helpGuideUrlSafetyLayersBullet2 =>
      'स्तरः 2: समरूपलिपि-Unicode-आक्रमण-कवचम् - विश्वस्त-जालस्थानानाम् अनुकरणाय वञ्चकैः प्रयुक्तान् Cyrillic-Greek-मिश्रलिपि-समरूप-वर्णान् (यथा \"a\" इत्यस्य स्थाने \"а\") अभिजानाति।';

  @override
  String get helpGuideUrlSafetyLayersBullet3 =>
      'स्तरः 3: शङ्कास्पद-TLD-अव्यवस्था-विश्लेषणम् - उच्च-सङ्कट-क्षेत्रान्तान् (.xyz, .top, .work), अत्यधिक-उपक्षेत्र-स्तरान्, यन्त्रेण यादृच्छिकतया रचितानि क्षेत्र-नामानि च सूचयति।';

  @override
  String get helpGuideUrlSafetyLayersBullet4 =>
      'स्तरः 4: IP-असामान्यद्वार-पाशः - botnet-दुष्टतन्त्रांश-सेवकैः प्रायः प्रयुक्तान् सङ्ख्यात्मक-IP-सङ्केतान् असामान्य-द्वारसङ्ख्याः वा प्रति साक्षात् संयुज्यमानान् सम्पर्कान् अन्विष्यति।';

  @override
  String get helpGuideUrlSafetyLayersBullet5 =>
      'स्तरः 5: गोपनीयता-रक्षकं सजाल-HEAD-परीक्षणम् - वैकल्पिकतया सङ्क्षिप्त-URL-पुनर्निर्देशान् (bit.ly, tinyurl) अनुसरति, दुष्ट-JavaScript अनिष्पाद्य SSL-प्रमाणपत्र-विश्वास-शृङ्खलाः च परीक्षते।';

  @override
  String get helpGuideUrlSafetyLayersBullet6 =>
      'स्तरः 6: Google Safe Browsing API-संयोजनम् - कपटजालस्थानेभ्यः दुष्टतन्त्रांश-वितरण-जालेभ्यः च रक्षन्ती वैकल्पिकी मेघाधारिता तात्कालिकी सङ्कट-सूचना।';

  @override
  String get helpGuideUrlSafetyVerdictsTitle =>
      'सुरक्षा-निर्णयाः क्रिया-मार्गदर्शनं च';

  @override
  String get helpGuideUrlSafetyVerdictsBullet1 =>
      'सत्यापितं सुरक्षितम् (हरितम्): URL-सङ्केतः किमपि शङ्कास्पद-लक्षणम् अनुत्थाप्य सर्वासु संरचना-सङ्कट-परीक्षासु उत्तीर्णः।';

  @override
  String get helpGuideUrlSafetyVerdictsBullet2 =>
      'सावधानता / सङ्कट-सूचना (नारङ्ग/रक्त): उच्च-सङ्कट-कारणानि लब्धानि। अनुप्रयोगः असङ्क्षिप्तं पूर्णं गन्तव्यं दर्शयति, कैः नियमैः सूचना उत्थिता इति स्पष्टं निर्दिशति च।';

  @override
  String get helpGuideUrlSafetyTip =>
      'सूचना: स्तराः 1 तः 4 पर्यन्तं यन्त्रस्थ-परीक्षाभिः पूर्णतया अन्तर्जालं विना प्रचलन्ति; भवान् यत्र कुत्रापि तिष्ठतु, भवतः गोपनीयतां रक्षन्ति।';

  @override
  String get titleHelpQuishing => 'क्विशिंग-रक्षकः';

  @override
  String get helpGuideQuishingName => 'QuishingGuard™ कपट-परिवर्तन-अन्वेषणम्';

  @override
  String get helpGuideQuishingSummary =>
      'यन्त्रे एव सङ्गणक-दृष्ट्या लेपित-QR-पत्राणां प्रान्तच्छेदानां च विश्लेषणम्।';

  @override
  String get helpGuideQuishingIntro =>
      'क्विशिंग् (QR-कपटम्) नाम — यदा वञ्चकाः वाहनस्थान-मापकेषु, भोजनालय-सूचीषु, शुल्क-पटलेषु, यात्रा-फलकेषु वा यथार्थ-QR-सङ्केतानाम् उपरि कपट-QR-पत्राणि लेपयन्ति।';

  @override
  String get helpGuideQuishingCvTitle => 'यन्त्रस्थं सङ्गणक-दृष्टि-विश्लेषणम्';

  @override
  String get helpGuideQuishingCvBullet1 =>
      'प्रान्त-विच्छेद-मापकम्: लेपित-पत्राणां सीमायां द्विगुण-प्रान्तान्, विषम-च्छेदान्, सूक्ष्म-छायाः च अन्विष्यति।';

  @override
  String get helpGuideQuishingCvBullet2 =>
      'मुद्रणकण-अर्धवर्ण-मापकम्: सङ्केतस्य परितः स्थितस्य भित्तिपत्रस्य च मध्ये बिन्दु-अन्तरे, वर्ण-कोलाहले, मुद्रण-विभेदने च विसङ्गतीः अभिजानाति।';

  @override
  String get helpGuideQuishingCvBullet3 =>
      '0% (यथार्थम्) तः 100% (उच्च-कपट-सम्भावना) पर्यन्तं संयुक्तं कपट-सङ्कटाङ्कं गणयति।';

  @override
  String get helpGuideQuishingForensicTitle => 'सूक्ष्म-लक्षण-परीक्षणम्';

  @override
  String get helpGuideQuishingForensicBullet1 =>
      'तात्कालिक-CV-विश्वास-स्तरान्, सीमा-प्रान्त-मापनानि, वर्ण-कोलाहल-चित्राणि च द्रष्टुं संवीक्षिते यस्मिन्कस्मिंश्चित् सङ्केते \"सूक्ष्म-विश्लेषणं दृश्यताम्\" इति स्पृशतु।';

  @override
  String get helpGuideQuishingForensicBullet2 =>
      'धनप्रेषणात् प्रमाण-लेखनात् वा पूर्वं सार्वजनिक-स्थानेषु शङ्कास्पदान् देय-QR-सङ्केतान् अभिज्ञातुं साहाय्यं करोति।';

  @override
  String get helpGuideQuishingTip =>
      'सूचना: वाहनस्थान-मापकेषु सार्वजनिक-यन्त्रकुटीषु वा QR-सङ्केतान् संवीक्षमाणः, QuishingGuard प्रान्त-विच्छेद-सूचनां ददाति चेत्, अङ्गुलीभिः स्पृष्ट्वा सङ्केतं परीक्षताम्।';

  @override
  String get titleHelpSafeBrowsing => 'सुरक्षित-जालभ्रमणम्';

  @override
  String get helpGuideSafeBrowsingName => 'Google Safe Browsing-सज्जीकरणम्';

  @override
  String get helpGuideSafeBrowsingSummary =>
      'Google Cloud API-कुञ्चिका-प्राप्तिः, यन्त्रांश-कुञ्चिकाकोशे सङ्ग्रहः, अन्वेषण-सीमाः च।';

  @override
  String get helpGuideSafeBrowsingIntro =>
      'Google Safe Browsing षष्ठस्तरीयां मेघ-सङ्कट-सूचनां सक्रियां करोति, यया संवीक्षिताः URL-सङ्केताः निरन्तरं नवीक्रियमाणैः कोटिशः ज्ञात-दुष्टतन्त्रांश-सामाजिकवञ्चना-कपटजाल-अभिलेखैः सह तुल्यन्ते।';

  @override
  String get helpGuideSafeBrowsingKeyTitle =>
      'निःशुल्क-API-कुञ्चिकायाः प्राप्ति-विधिः';

  @override
  String get helpGuideSafeBrowsingKeyStep1 =>
      '1. सङ्गणके चल-जालदर्शके वा Google Cloud Console (console.cloud.google.com) उद्घाटयतु।';

  @override
  String get helpGuideSafeBrowsingKeyStep2 =>
      '2. नूतनं Google Cloud Project रचयतु (यथा \"My QR Reader Security\")।';

  @override
  String get helpGuideSafeBrowsingKeyStep3 =>
      '3. \"APIs & Services\" -> \"Library\" इति गत्वा \"Web Risk API\" अथवा \"Safe Browsing API\" अन्विष्य \"Enable\" इति नुदतु।';

  @override
  String get helpGuideSafeBrowsingKeyStep4 =>
      '4. \"APIs & Services\" -> \"Credentials\" इति गत्वा \"+ CREATE CREDENTIALS\" -> \"API key\" इति नुदतु।';

  @override
  String get helpGuideSafeBrowsingKeyStep5 =>
      '5. नूतनाम् API-कुञ्चिकां प्रतिलिख्य विन्यासेषु Google Safe Browsing-क्षेत्रे निवेशयतु।';

  @override
  String get helpGuideSafeBrowsingPrivacyTitle =>
      'गोपनीयता सुरक्षित-कुञ्चिकाकोश-सङ्ग्रहः च';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet1 =>
      'भवतः API-कुञ्चिका Android Keystore इत्यस्य यन्त्रांशाधारिते सुरक्षित-सङ्ग्रह-स्थाने (FlutterSecureStorage) गूढीकृत्य रक्ष्यते; न कदापि निर्यात्यते, न वा अन्यैः सह विभज्यते।';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet2 =>
      'Google Safe Browsing पूर्णतया वैकल्पिकम्। कुञ्चिका न दत्ता चेदपि अनुप्रयोगः व्यापकाः अन्तर्जालरहित-परीक्षाः करोति एव।';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet3 =>
      'निःशुल्क-सीमा: Google प्रतिदिनं 10,000 पर्यन्तं निःशुल्क-याचनाः अनुमन्यते; अनुप्रयोगः च प्रत्येकं 24 होरानन्तरं स्वकीयं स्थानीयम् उपयोग-गणकं पुनः आरभते।';

  @override
  String get helpGuideSafeBrowsingTip =>
      'सूचना: अन्तर्जालरहित-परीक्षासु उत्तीर्णासु एव Safe Browsing-परीक्षा प्रचलति, येन दैनिक-अन्वेषण-सीमा रक्ष्यते।';

  @override
  String get titleHelpSmartPayloads => 'कुशल-क्रियाः';

  @override
  String get helpGuideSmartPayloadsName => 'कुशल-क्रियाः देयानि च';

  @override
  String get helpGuideSmartPayloadsSummary =>
      'Wi-Fi-संयोजनम्, UPI-गूढमुद्रा-देयानि, सजीव-TOTP-2FA-चिह्नकाः, vCard-पत्राणि, उत्सवाः च।';

  @override
  String get helpGuideSmartPayloadsIntro =>
      'श्रीराज् पि क्यू-आर-कार्यशाला प्रत्येकस्य सङ्केतस्य अर्थ-प्रकारं स्वयम् अभिजानाति, Wi-Fi-जालानां, UPI-गूढमुद्रा-देयानां, 2FA-चिह्नकानां, सम्पर्काणां, दिनदर्शिका-उत्सवानां च कृते एकस्पर्श-क्रियापत्राणि प्रदर्शयति।';

  @override
  String get helpGuideSmartPayloadsWifiTitle => 'Wi-Fi-जाल-स्वसंयोजनम्';

  @override
  String get helpGuideSmartPayloadsWifiBullet1 =>
      'SSID, गूढलेखन-प्रकारः (WPA, WPA2, WPA3, WEP, किमपि न), जाल-गुप्तशब्दः च येषु सन्ति, तान् WIFI:-प्रारूप-सङ्केतान् संवीक्षते।';

  @override
  String get helpGuideSmartPayloadsWifiBullet2 =>
      'गुप्तशब्दं दर्शयितुं गोपयितुं च साधनम्, एकस्पर्शेन फलके प्रतिलेखनं च अत्र विद्यते।';

  @override
  String get helpGuideSmartPayloadsWifiBullet3 =>
      'साक्षात् संयोजनाय, प्रणाल्याः Wi-Fi-विन्यासान् उद्घाटयितुं वा \"संयोज्यताम्\" इति स्पृशतु।';

  @override
  String get helpGuideSmartPayloadsPaymentsTitle => 'UPI-गूढमुद्रा-देयानि';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet1 =>
      'भारतीय-UPI-QR-सङ्केताः: आभासी-देय-सङ्केतं (VPA), वणिजः नाम, व्यवहार-सन्दर्भं, यथार्थ-राशिं च विश्लेषयति।';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet2 =>
      'एकस्पर्श-प्रेषणम्: पूर्वपूरित-व्यवहार-विवरणैः सह भवतः स्थापितानि देय-अनुप्रयोगाणि (Google Pay, PhonePe, Paytm, BHIM वा) उद्घाटयति।';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet3 =>
      'गूढमुद्रा-QR-सङ्केताः: Bitcoin, Ethereum, Solana इत्येषां कोश-सङ्केतान् अभिजानाति, एकस्पर्श-प्रतिलेखनं स्पष्ट-प्रदर्शनं च ददाति।';

  @override
  String get helpGuideSmartPayloadsTotpTitle => 'TOTP-2FA-प्रमाणकः चिह्नकाः च';

  @override
  String get helpGuideSmartPayloadsTotpBullet1 =>
      'Google Authenticator, Microsoft Authenticator इत्याभ्यां प्रयुक्तान् otpauth://-मानक-द्विघटक-प्रमाणीकरण-सज्जीकरण-सङ्केतान् संवीक्षते।';

  @override
  String get helpGuideSmartPayloadsTotpBullet2 =>
      '30-पलात्मकेन वृत्ताकारेण अवरोह-गणकेन सह परिवर्तमानं षडङ्कीयम् एकवारीय-गुप्ताङ्कं यन्त्रे सजीवं प्रदर्शयति।';

  @override
  String get helpGuideSmartPayloadsTotpBullet3 =>
      'इष्टे 2FA-अनुप्रयोगे कुञ्चिकां पञ्जीकर्तुं \"प्रमाणीकरणे योज्यताम्\" इति स्पृशतु।';

  @override
  String get helpGuideSmartPayloadsContactsTitle =>
      'सम्पर्काः दिनदर्शिका-उत्सवाः च';

  @override
  String get helpGuideSmartPayloadsContactsBullet1 =>
      'vCard, MeCard: पूर्णनाम, दूरवाणी-सङ्ख्याः, ई-पत्र-सङ्केताः, संस्था, पदनाम च विश्लेष्य एकस्पर्शेन सम्पर्क-सूच्यां योजयति।';

  @override
  String get helpGuideSmartPayloadsContactsBullet2 =>
      'iCalendar (VEVENT): उत्सवस्य शीर्षकम्, आरम्भ-समाप्ति-दिनाङ्क-समयौ, स्थानं, विवरणं च विश्लेष्य एकस्पर्शेन Google/यन्त्र-दिनदर्शिकायां योजनं ददाति।';

  @override
  String get helpGuideSmartPayloadsTip =>
      'सूचना: UPI-QR-सङ्केतेन देयं ददन्, पत्रे दर्शितं वणिङ्नाम आपण-पटले लिखितेन नाम्ना सह सङ्गच्छते इति सर्वदा निश्चिनोतु।';

  @override
  String get titleHelpHistory => 'इतिवृत्तं गोपनीयता च';

  @override
  String get helpGuideHistoryName => 'इतिवृत्तम्, प्रतिलिपिः, गोपनीयता च';

  @override
  String get helpGuideHistorySummary =>
      'अन्तर्जालरहितः SQLite-दत्तांशकोशः, JSON/CSV-प्रतिलिपयः, जैवमापन-प्रमाणीकरणं, पटलचित्र-रक्षणं च।';

  @override
  String get helpGuideHistoryIntro =>
      'भवतः संवीक्षा-अभिलेखाः केवलं भवतः एव। श्रीराज् पि क्यू-आर-कार्यशाला सर्वान् इतिवृत्त-अभिलेखान् भवतः यन्त्रे स्थानीये SQLite-दत्तांशकोशे रक्षति, जैवमापन-प्रमाणीकरण-रक्षया सुव्यवस्थित-निर्यात-प्रारूपैः च सह।';

  @override
  String get helpGuideHistoryManageTitle => 'संवीक्षा-इतिवृत्त-प्रबन्धनम्';

  @override
  String get helpGuideHistoryManageBullet1 =>
      'अन्वेषणं पृथक्करणं च: पाठेन संवीक्षा-इतिवृत्तं तत्क्षणम् अन्विष्यतु, विषय-प्रकारानुसारं (URL, Wi-Fi, सम्पर्काः, देयानि, TOTP) वा पृथक् करोतु।';

  @override
  String get helpGuideHistoryManageBullet2 =>
      'प्रियाः: महत्त्वपूर्णान् Wi-Fi-प्रमाणान् निष्ठा-सङ्केतान् वा शीघ्र-प्राप्त्यर्थं प्रियत्वेन चिह्नयतु।';

  @override
  String get helpGuideHistoryManageBullet3 =>
      'विस्तृत-परीक्षापत्रम्: यथावत् पठितान् मूल-दत्तांशान्, सुरक्षाङ्क-विवरणं, समयमुद्रां च पश्यतु; स्वकीयाः टिप्पणीः अपि योजयतु।';

  @override
  String get helpGuideHistoryBackupTitle =>
      'प्रतिलिपिः पुनःस्थापनं च (JSON / CSV)';

  @override
  String get helpGuideHistoryBackupBullet1 =>
      'JSON-पूर्णप्रतिलिपिः: स्वकीय-अङ्कनानि, प्रियाः, सुरक्षा-परिणामाः च इत्येतैः सहितं सम्पूर्णम् इतिवृत्तं सुवहनीयायां .json-सञ्चिकायां निर्यातयति।';

  @override
  String get helpGuideHistoryBackupBullet2 =>
      'CSV-सारणी: Microsoft Excel, Google Sheets इत्याभ्यां सङ्गतां स्वच्छाम् अल्पविराम-विभक्त-मूल्य-सञ्चिकां रचयति।';

  @override
  String get helpGuideHistoryBackupBullet3 =>
      'एकस्पर्श-पुनःस्थापनम्: पूर्वं निर्यातिताः JSON-प्रतिलिपि-सञ्चिकाः यदाकदापि आयात्य संवीक्षा-अभिलेखं पुनः स्थापयतु।';

  @override
  String get helpGuideHistoryBiometricsTitle => 'जैवमापनं पटलचित्र-रक्षणं च';

  @override
  String get helpGuideHistoryBiometricsBullet1 =>
      'अनुप्रयोग-तालकं जैवमापनं च: ऐच्छिकम् अनुप्रयोग-तालकम् अनुप्रयोगस्य उद्घाटने भवतः अङ्गुलिमुद्रां मुखं पटल-तालकं वा याचते। गुप्त-StegoQR-सन्देशाः अपि जैवमापनं याचितुं शक्नुवन्ति।';

  @override
  String get helpGuideHistoryBiometricsBullet2 =>
      'पटलचित्र-रक्षणम्: संवीक्षाः, इतिवृत्तम्, गुप्तविषयाः, API-कुञ्चिकाः च यत्र दृश्यन्ते, तेषां पटलानां चित्रम् अभिलेखनं वा कर्तुं न शक्यते (FLAG_SECURE)।';

  @override
  String get helpGuideHistoryTip =>
      'सूचना: दूरवाणी-परिवर्तनात् पुनःस्थापनात् वा पूर्वं रक्षितानां संवीक्षाणां रक्षणाय इतिवृत्तस्य JSON-प्रतिलिपिं रचयतु।';

  @override
  String get titleHelpFaq => 'प्रायिकप्रश्नाः';

  @override
  String get helpGuideFaqName => 'प्रायिकप्रश्नाः समस्यापरिहारः च';

  @override
  String get helpGuideFaqSummary =>
      'सामान्यप्रश्नाः, चित्रग्राहि-केन्द्रीकरण-सूचनाः, अनुमति-पुनःप्राप्तिः, अन्तर्जालरहित-प्रत्याभूतयः च।';

  @override
  String get helpGuideFaqIntro =>
      'श्रीराज् पि क्यू-आर-कार्यशाला इत्यस्य विषये सामान्यप्रश्नानाम् उत्तराणि, चित्रग्राहि-समस्यानां परिहाराः, गोपनीयता-स्पष्टीकरणानि च।';

  @override
  String get helpGuideFaqQuestionsTitle => 'प्रायिकप्रश्नाः';

  @override
  String get helpGuideFaqQuestion1 =>
      'प्रश्नः: अन्तर्जालं विना अनुप्रयोगः प्रचलति वा?\nआम्! सङ्केत-पठनं, QuishingGuard-CV-परीक्षाः, URL-सुरक्षा-परीक्षाः (स्तराः 1-4) च सर्वाणि पूर्णतया अन्तर्जालं विना प्रचलन्ति।';

  @override
  String get helpGuideFaqQuestion2 =>
      'प्रश्नः: मम चित्रग्राहि-दृश्यं कस्मिंश्चित् सेवकयन्त्रे (server) प्रेष्यते वा?\nन। चित्रग्राहि-चित्राणि केवलं यन्त्रस्य अस्थायि-स्मृतौ संसाध्यन्ते; न कदापि अभिलिख्यन्ते, न रक्ष्यन्ते, न आरोप्यन्ते च।';

  @override
  String get helpGuideFaqQuestion3 =>
      'प्रश्नः: Google Safe Browsing किमर्थं वैकल्पिकम्?\nवयं स्वतः-गोपनीयतायां विश्वसिमः। अन्तर्जालरहिताः सुरक्षास्तराः सद्यः एव भवन्तं रक्षन्ति। Google Safe Browsing तु Google Cloud API-कुञ्चिकायुक्तानाम् उपयोक्तॄणां कृते स्वेच्छया सक्रियीकरणीयः विकल्पः।';

  @override
  String get helpGuideFaqCameraTitle => 'चित्रग्राहि-समस्यापरिहारः';

  @override
  String get helpGuideFaqCameraBullet1 =>
      'चित्रग्राही केन्द्रीकरणं न करोति चेत्: काचः स्वच्छः इति निश्चित्य यन्त्रं 15-20 से.मी. दूरे धारयतु। अल्पप्रकाशे दीप-चिह्नं स्पृशतु।';

  @override
  String get helpGuideFaqCameraBullet2 =>
      'अतिलघुः सघनः वा QR-सङ्केतः: दूरवाणीम् अतिसमीपं न नयतु; तस्य स्थाने आवर्धन-सर्पकेण सङ्केतं विवर्धयतु।';

  @override
  String get helpGuideFaqCameraBullet3 =>
      'अनुमतिः निरस्ता: चित्रग्राहि-अनुमतिः प्रत्याहृता चेत्, Android-यन्त्रस्य Settings -> Apps -> SreerajP QR Studio -> Permissions -> Camera -> Allow इति गच्छतु।';

  @override
  String get helpGuideFaqTip =>
      'सूचना: असामान्यः सङ्केत-प्रकारः दृश्यते चेत्, तस्य चित्रं गृहीत्वा चित्रसङ्ग्रह-संवीक्षया पूर्ण-विभेदने संसाधयतु।';

  @override
  String get tooltipResultMoreActions => 'अधिकाः क्रियाः';

  @override
  String get bodyVerdictChecking => 'सम्पर्कसूत्र-सुरक्षा परीक्ष्यते…';

  @override
  String get bodyVerdictNoIssues => 'न कोऽपि दोषः';

  @override
  String bodyVerdictIssuesFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दोषाः प्राप्ताः',
      one: '1 दोषः प्राप्तः',
    );
    return '$_temp0';
  }

  @override
  String bodyVerdictChecksPassed(int passed, int total) {
    return '$total परीक्षासु $passed सफलाः';
  }

  @override
  String get actionVerdictSeeDetails => 'विवरणं दृश्यताम्';

  @override
  String get labelVerdictModePrivate => 'एकान्त-विधिः';

  @override
  String get labelVerdictModeActive => 'सक्रिय-परीक्षणम्';

  @override
  String actionSafetyShowPassed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सफल-परीक्षाः दृश्यन्ताम्',
      one: '1 सफल-परीक्षा दृश्यताम्',
    );
    return '$_temp0';
  }

  @override
  String get actionSafetyHidePassed => 'सफल-परीक्षाः गोपयतु';

  @override
  String actionSafetySkippedGroup(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count परीक्षाः त्यक्ताः',
      one: '1 परीक्षा त्यक्ता',
    );
    return '$_temp0';
  }

  @override
  String get actionSafetySkippedSetup => 'विन्यासेषु सज्जीकरोतु';

  @override
  String bodyOpenRiskDialogIssues(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'अस्मिन् सूत्रे $count दोषाः सन्ति। तथापि उद्घाटयितुम् इच्छसि वा?',
      one: 'अस्मिन् सूत्रे 1 दोषः अस्ति। तथापि उद्घाटयितुम् इच्छसि वा?',
    );
    return '$_temp0';
  }

  @override
  String get tooltipSandboxShowPreview => 'पूर्वावलोकनं दर्शयतु';

  @override
  String get tooltipSandboxHidePreview => 'पूर्वावलोकनं गोपयतु';

  @override
  String labelQuishingCompactGenuine(String percent) {
    return 'यथार्थम् · $percent%';
  }

  @override
  String get labelScanBubble => 'वीक्षण-बुद्बुदः';

  @override
  String get descScanBubbleSettings =>
      'अन्यानुप्रयोगेषु दृश्यमानानां सङ्केतानां वीक्षणम्';

  @override
  String get labelScanBubbleSwitch => 'बुद्बुद-प्रदर्शनम्';

  @override
  String get descScanBubbleSwitch =>
      'अन्यानुप्रयोगाणाम् उपरि प्लवमानः लघुः बुद्बुदः। पटपुटस्थं सङ्केतं वीक्षितुं तं स्पृशतु।';

  @override
  String get descScanBubblePermissionGranted => 'अनुमतम्';

  @override
  String get descScanBubblePermissionMissing =>
      'अद्यापि न अनुमतम्। बुद्बुदाय आवश्यकम्।';

  @override
  String get actionScanBubbleAllow => 'अनुमन्यताम्';

  @override
  String get labelScanBubbleStartOnBoot => 'पुनरारम्भोत्तर-आरम्भः';

  @override
  String get descScanBubbleStartOnBoot =>
      'यदि बुद्बुदः सक्रियः आसीत्, दूरवाण्याः पुनरारम्भानन्तरं सः पुनः दृश्यते। केचन दूरवाण्यः एतत् निरुन्धन्ति।';

  @override
  String get actionScanBubbleAddTile => 'शीघ्रसंयोजने योज्यताम्';

  @override
  String get bodyScanBubbleTileAdded => 'शीघ्रसंयोजन-पट्टिकानुरोधः प्रेषितः';

  @override
  String get bodyScanBubbleTileManual =>
      'शीघ्रसंयोजन-छादनम् अधः आकर्षतु, सम्पादन-चिह्नं स्पृशतु, ततः वीक्षण-बुद्बुद-पट्टिकां तत्र आनयतु।';

  @override
  String get titleScanBubblePermissionDialog => 'बुद्बुदस्य अनुमतिः';

  @override
  String get bodyScanBubblePermissionDialog =>
      'अन्यानुप्रयोगाणाम् उपरि प्लवितुं बुद्बुदाय \"अन्यानुप्रयोगाणाम् उपरि प्रदर्शनम्\" इति अनुमतिः आवश्यकी। अग्रिमे पृष्ठे अस्मै अनुप्रयोगाय तां सक्रियां कृत्वा प्रत्यागच्छतु।';

  @override
  String get actionScanBubbleOpenSettings => 'विन्यासः उद्घाट्यताम्';

  @override
  String get errorScanBubbleStartFailed =>
      'बुद्बुदः आरब्धुं न अशक्यत। पुनः प्रयत्यताम्।';

  @override
  String get errorScanBubbleBlockedCapture =>
      'अयम् अनुप्रयोगः पटपुट-ग्रहणं निरुणद्धि, अतः तस्य सङ्केताः पठितुं न शक्यन्ते।';

  @override
  String get labelHistorySourceScreen => 'पटपुटात्';

  @override
  String get helpPermissionOverlayTitle => 'अन्यानुप्रयोगाणाम् उपरि प्रदर्शनम्';

  @override
  String get helpPermissionOverlayDesc =>
      'केवलं वीक्षण-बुद्बुदेन, तस्य सक्रियीकरणानन्तरम् एव प्रयुज्यते। बुद्बुदम् अन्यानुप्रयोगाणाम् उपरि स्थापयति।';

  @override
  String get helpPermissionNotificationTitle => 'सूचनाः';

  @override
  String get helpPermissionNotificationDesc =>
      'बुद्बुदे सक्रिये \"वीक्षण-बुद्बुदः सक्रियः\" इति सूचनां निष्क्रियीकरण-विकल्पेन सह दर्शयति।';

  @override
  String get helpGuideScanBubbleName => 'वीक्षण-बुद्बुदः';

  @override
  String get helpGuideScanBubbleSummary =>
      'अन्यानुप्रयोगेषु दृश्यमानान् QR-सङ्केतान् रेखा-सङ्केतान् च वीक्षितुं प्लवमानः बुद्बुदः।';

  @override
  String get helpGuideScanBubbleIntro =>
      'वीक्षण-बुद्बुदः अन्यानुप्रयोगाणाम् उपरि प्लवमानः लघुः वर्तुलः बुद्बुदः। यदा पटपुटे QR-सङ्केतः रेखा-सङ्केतः वा दृश्यते, तदा बुद्बुदं स्पृशतु; अनुप्रयोगः तं दूरवाण्याम् एव अन्तर्जालं विना पठति।';

  @override
  String get helpGuideScanBubbleUseTitle => 'उपयोगविधिः';

  @override
  String get helpGuideScanBubbleUseBullet1 =>
      'विन्यासः > वीक्षण-बुद्बुदः, शीघ्रसंयोजने वीक्षण-बुद्बुद-पट्टिका, अनुप्रयोग-चिह्नस्य दीर्घस्पर्शः वा — एतैः सक्रियं करोतु।';

  @override
  String get helpGuideScanBubbleUseBullet2 =>
      'QR-सङ्केतं रेखा-सङ्केतं वा दर्शयन्तं कञ्चित् अनुप्रयोगम् उद्घाट्य बुद्बुदं स्पृशतु।';

  @override
  String get helpGuideScanBubbleUseBullet3 =>
      'Android पटपुट-ग्रहणाय अनुमतिं पृच्छति। अनुमते सति परिणामः सामान्य-सुरक्षापरीक्षाभिः सह उद्घाट्यते।';

  @override
  String get helpGuideScanBubbleUseBullet4 =>
      'बुद्बुदं चालयितुं तम् आकर्षतु। निष्क्रियीकर्तुं पटपुटस्य अधोभागे स्थितं X-चिह्नं प्रति आकर्षतु।';

  @override
  String get helpGuideScanBubblePrivacyTitle => 'गोपनीयता';

  @override
  String get helpGuideScanBubblePrivacyBullet1 =>
      'बुद्बुद-स्पर्शे एव पटपुटं गृह्यते, Android च सर्वदा प्रथमं पृच्छति।';

  @override
  String get helpGuideScanBubblePrivacyBullet2 =>
      'सङ्केतः दूरवाण्याम् एव पठ्यते। पठनाय किमपि अन्तर्जालं प्रति न प्रेष्यते।';

  @override
  String get helpGuideScanBubblePrivacyBullet3 =>
      'पटपुट-चित्रं वीथिकायां न रक्ष्यते, पठनानन्तरं सद्यः अपाक्रियते।';

  @override
  String get helpGuideScanBubbleLimitsTitle => 'ज्ञातव्यम्';

  @override
  String get helpGuideScanBubbleLimitsBullet1 =>
      'Android 14 इत्यस्मिन् नूतनतरेषु च प्रतिस्पर्शं पटपुट-ग्रहणानुमतिः पृच्छ्यते।';

  @override
  String get helpGuideScanBubbleLimitsBullet2 =>
      'वित्तकोश-धनप्रेषण-अनुप्रयोगाः केचन चलचित्र-अनुप्रयोगाः च पटपुट-ग्रहणं निरुन्धन्ति। तेषु सङ्केताः पठितुं न शक्यन्ते।';

  @override
  String get helpGuideScanBubbleLimitsBullet3 =>
      'केषुचित् दूरवाणीषु अतिरिक्ताः \"उत्प्लव-गवाक्ष\" विद्युत्कोश-विन्यासाः वा सन्ति, ये बुद्बुदं गोपयितुं निवारयितुं वा शक्नुवन्ति।';

  @override
  String get helpGuideScanBubbleTip =>
      'सूचना: वीक्षण-बुद्बुद-पट्टिकां शीघ्रसंयोजने योजयतु। ततः कस्मात् अपि अनुप्रयोगात् एकेन स्पर्शेन बुद्बुदः सक्रियः निष्क्रियः वा भवति।';

  @override
  String get labelCodeForgeBarcodeContent => 'दण्डलेखा-विषयः';

  @override
  String get helpCodeForgeBarcodeContent =>
      'दण्डलेखा-सङ्ख्यां सङ्केतं वा लिखतु';

  @override
  String get labelCodeForgeWifiSecurityNone => 'न किमपि (मुक्तम्)';

  @override
  String get helpCodeForgeUpiVpa => 'यथा merchant@upi';

  @override
  String get labelOptionalField => 'ऐच्छिकम्';

  @override
  String get errorCodeForgeContentEmpty => 'विषयः रिक्तः न भवेत्';

  @override
  String errorCodeForgeTextTooLong(String max) {
    return 'पाठः $max वर्णेभ्यः अधिकः न भवेत्';
  }

  @override
  String get errorCodeForgeWifiSsidRequired =>
      'वाइ-फाइ संजालनाम (SSID) आवश्यकम्';

  @override
  String get errorCodeForgeUpiVpaRequired => 'युपीआई-सङ्केतः आवश्यकः';

  @override
  String errorCodeForgeBarcodeInvalid(String detail) {
    return 'अस्य दण्डलेखा-प्रकारस्य कृते अयोग्यम् ($detail)';
  }

  @override
  String get titleAirQrUnlocked => 'वायु-क्यूआर विषयः उद्घाटितः';

  @override
  String get titleJsonEnvelopeUnlocked => 'JSON-विषयः उद्घाटितः';

  @override
  String get titleStegoUnlocked => 'StegoQR-विषयः उद्घाटितः';

  @override
  String get titleStegoDetected => 'StegoQR-विषयः प्राप्तः';

  @override
  String get actionDecryptShowAdvanced => 'विस्तृतम् (Salt / IV)';

  @override
  String get actionDecryptHideAdvanced => 'विस्तृतं गोप्यताम्';

  @override
  String get labelDecryptSalt => 'साल्ट् (Base64)';

  @override
  String get labelDecryptIv => 'IV / नोन्स् (Base64)';

  @override
  String bodyHistoryRecordCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count संवीक्षा-अभिलेखाः प्राप्ताः',
      one: '1 संवीक्षा-अभिलेखः प्राप्तः',
    );
    return '$_temp0';
  }

  @override
  String bodyArItemsSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count वस्तूनि चितानि',
      one: '1 वस्तु चितम्',
    );
    return '$_temp0';
  }

  @override
  String descSettingsAppearanceSummary(String themeMode) {
    return '$themeMode • गतिकवर्णाः';
  }

  @override
  String get bodyOpenPhishFeedNotDownloaded => 'सूचिः अद्यापि न अवतारिता';

  @override
  String get helpAccentDynamicColor =>
      'गतिकवर्णाः भवतः एण्ड्रायड्-भित्तिचित्रात् अनुरूपां वर्णावलीं रचयन्ति (एण्ड्रायड् १२+)। निष्क्रिये सति मानक-उच्चविरोध-सुरक्षावर्णावली प्रयुज्यते।';

  @override
  String get bodyTypographySample =>
      '6-स्तरीय URL-सुरक्षापरीक्षा • 100% अन्तस्थ QuishingGuard™ CV यन्त्रम्';

  @override
  String get labelTypographyScale => 'अक्षरपरिमाणम्';

  @override
  String get helpTypographyScale =>
      'अनुप्रयोगः भवतः एण्ड्रायड्-सुगम्यता-अक्षरपरिमाणम् अनुसरति, संवीक्षाचौकटं पटल-नामपत्राणि च सुपाठ्यानि रक्षति।';

  @override
  String bodyDomFetchFailed(String host) {
    return '$host (असंयुक्तम् अथवा संजालम् अवरुद्धम्)';
  }

  @override
  String get tooltipScanPause => 'संवीक्षा विरम्यताम्';

  @override
  String get tooltipScanResume => 'संवीक्षा पुनरारभ्यताम्';

  @override
  String get labelArModeWarehouse => 'भाण्डागारम्';

  @override
  String get labelArModeSafety => 'सुरक्षा';

  @override
  String get tooltipArModeWarehouse => 'वस्तु-विवरणं चयनं च';

  @override
  String get tooltipArModeSafety => 'सेतु-सुरक्षा-चिह्नानि';

  @override
  String get errorCameraStartFailed => 'चित्रग्राही आरब्धुं न शक्तः';

  @override
  String get errorCameraNotFound => 'अस्मिन् दूरवाणौ चित्रग्राही न प्राप्तः';

  @override
  String get actionCameraRetry => 'पुनः प्रयत्यताम्';

  @override
  String get bodyCodeForgeSafetyPrompt =>
      'वितरणात् पूर्वं सम्बन्धः परीक्ष्यताम्';

  @override
  String get actionCodeForgeSafetyCheck => 'परीक्ष्यताम्';

  @override
  String bodyCodeForgeSafetyProblems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'अस्मिन् सम्बन्धे $count दोषाः प्राप्ताः',
      one: 'अस्मिन् सम्बन्धे 1 दोषः प्राप्तः',
    );
    return '$_temp0';
  }

  @override
  String get actionCodeForgeSafetyCheckAgain => 'पुनः परीक्ष्यताम्';

  @override
  String get labelDeleteAllData => 'सर्वदत्तांशलोपः';

  @override
  String get descDeleteAllData =>
      'संवीक्षा-इतिवृत्तम्, रक्षिताः API-कुञ्चिकाः, सर्वे विन्यासाः च अस्मात् दूरवाणीतः लुप्यन्ते।';

  @override
  String get titleDeleteAllDataConfirm => 'किं सर्वं लुप्यताम्?';

  @override
  String get bodyDeleteAllDataConfirm =>
      'अनेन भवतः संवीक्षा-इतिवृत्तम्, रक्षिताः API-कुञ्चिकाः, सर्वे विन्यासाः, वीक्षण-बुद्बुदस्य विन्यासाः, तात्कालिकसञ्चिकाः च लुप्यन्ते। एतत् पुनः प्रत्यानेतुं न शक्यते।';

  @override
  String get actionDeleteAll => 'सर्वं लुप्यताम्';

  @override
  String get bodyDeletingAllData => 'सर्वदत्तांशः लुप्यते…';

  @override
  String get errorDeleteAllDataPartial => 'केचन दत्तांशाः लोप्तुं न शक्ताः।';

  @override
  String get errorHistoryLoadFailed => 'इतिवृत्तम् उद्घाटयितुं न शक्तम्।';

  @override
  String get actionTryAgain => 'पुनः प्रयत्यताम्';

  @override
  String get aboutDetailPrivacyPolicy => 'गोपनीयतानीतिः';

  @override
  String get bodyEncryptingBackup => 'भवतः प्रतिलिपिः रक्ष्यते…';

  @override
  String get bodyOpeningBackup => 'प्रतिलिपिः उद्घाट्यते…';

  @override
  String get bodyEncryptingSync => 'समन्वय-सङ्ग्रहः रक्ष्यते…';

  @override
  String get titlePlainExport => 'अगुप्तं निर्यातयतु?';

  @override
  String get bodyPlainExport =>
      'इयं सञ्चिका गुप्ता न कृता। यः कश्चित् एतां प्राप्नोति सः भवतः संवीक्षाः पठितुं शक्नोति।';

  @override
  String get bodyPlainExportBackupHint =>
      'गोपनीयतायै तस्य स्थाने गुप्तां प्रतिलिपिम् उपयुङ्क्ताम्।';

  @override
  String get actionExportAnyway => 'तथापि निर्यातयतु';

  @override
  String get labelAppLock => 'अनुप्रयोग-तालकम्';

  @override
  String get descAppLock =>
      'अनुप्रयोगस्य उद्घाटने, त्रिंशत्-क्षणेभ्यः अधिकं बहिः स्थित्वा च अङ्गुलिमुद्रां मुखं पटल-तालकं वा याचताम्।';

  @override
  String get titleAppLocked => 'अनुप्रयोगः तालितः';

  @override
  String get bodyAppLocked =>
      'अग्रे गन्तुम् अङ्गुलिमुद्रया मुखेन पटल-तालकेन वा उद्घाटयतु।';

  @override
  String get actionUnlock => 'उद्घाटयतु';

  @override
  String get bodyAppLockReason => 'SreerajP QR Studio उद्घाटयतु';

  @override
  String get errorAppLockUnavailable =>
      'प्रथमम् अस्मिन् दूरवाणीयन्त्रे पटल-तालकम् अङ्गुलिमुद्रां वा सज्जीकरोतु।';

  @override
  String get errorAppLockFailed =>
      'भवान् एव इति निश्चेतुं न शक्यम्। पुनः प्रयत्यताम्।';
}
