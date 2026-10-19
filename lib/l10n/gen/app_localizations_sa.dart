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
  String get titleQuishingGuard => 'क्विशिंग-रक्षकः™';

  @override
  String get titleStickerCheck => 'कृतकपत्रिका-परीक्षा';

  @override
  String get tooltipStickerCheckExpand => 'परीक्षाः दर्शयतु';

  @override
  String get tooltipStickerCheckCollapse => 'परीक्षाः गोपयतु';

  @override
  String get bodyStickerCheckIntro =>
      'वञ्चकाः यथार्थसङ्केतस्य उपरि स्वकीयं QR-सङ्केतं लिम्पन्ति। अयम् अनुप्रयोगः चित्रग्राहिणः चित्रे पत्रिकाम् अभिज्ञातुं न शक्नोति, अतः भवान् स्वयं परीक्षताम्:';

  @override
  String get bodyStickerCheckEdges =>
      'सङ्केतं पश्यतु, अङ्गुल्या स्पृष्ट्वा अनुभवतु च। उपरि लेपितायाः पत्रिकायाः धाराः प्रायः उन्नताः भवन्ति, सा वक्रा वा तिष्ठति।';

  @override
  String get bodyStickerCheckPayee =>
      'धनप्रदानात् पूर्वं धनप्रेषणपटले नाम आपणस्य नाम्ना समानम् इति निश्चिनोतु।';

  @override
  String get bodyStickerCheckAsk =>
      'संशये सति कर्मचारिणः पृच्छतु, अथवा जालसङ्केतं स्वयं लिखतु।';

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
  String get descSettingsPermissions => 'अनुप्रयोगः किं किमर्थं च उपयुङ्क्ते';

  @override
  String get labelSettingsHelp => 'साहाय्यं वैशिष्ट्यानि च';

  @override
  String get descSettingsHelp => 'सर्वेषां वैशिष्ट्यानां सरला मार्गदर्शिका';

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
  String get helpPermissionsIntro =>
      'चित्रग्राहिसदृशान् दूरवाण्याः भागान् उपयोक्तुम् अनुप्रयोगस्य अनुमतिः आवश्यकी। अयम् अनुप्रयोगः प्रत्येकस्य वैशिष्ट्यस्य आवश्यकम् एव, तस्य उपयोगकाले एव च प्रार्थयते। Android-विन्यासाः > अनुप्रयोगाः > अयम् अनुप्रयोगः > अनुमतयः इत्यत्र एताः कदापि द्रष्टुं परिवर्तयितुं च शक्यन्ते।';

  @override
  String get labelPermGroupAsked => 'आवश्यकतायां प्रार्थिताः';

  @override
  String get helpPermGroupAskedNote =>
      'एतासाम् उपयोगात् पूर्वम् Android भवन्तं पृच्छति। निषेधे कृते अपि अनुप्रयोगस्य अन्ये भागाः कार्यं कुर्वन्ति।';

  @override
  String get labelPermGroupInstall => 'स्वतः प्रदत्ताः';

  @override
  String get helpPermGroupInstallNote =>
      'अनुप्रयोगस्य स्थापनसमये Android एताः अपृष्ट्वा एव ददाति। प्रत्येका अत्र उक्ताय वैशिष्ट्याय एव प्रयुज्यते।';

  @override
  String get labelPermGroupNotUsed => 'अप्रार्थिताः';

  @override
  String get helpPermGroupNotUsedNote =>
      'अनुप्रयोगः एताः न प्रार्थयते, अतः एताः उपयोक्तुं न शक्नोति।';

  @override
  String get labelPermCamera => 'चित्रग्राही';

  @override
  String get helpPermCameraDesc =>
      'QR-सङ्केतानां दण्डसङ्केतानां च अन्वीक्षणाय, ए-आर् दृष्टये, AirQR-प्रेषणस्वीकाराय च प्रयुज्यते। चित्रग्राहिपटलस्य प्रथमोद्घाटने Android पृच्छति। चित्रग्राहिदृश्यानि दूरवाण्याम् एव पठ्यन्ते, न रक्ष्यन्ते न च प्रेष्यन्ते। निषेधे कृते अपि चित्रेभ्यः PDF-सञ्चिकाभ्यः च अन्वीक्षणं शक्यम्।';

  @override
  String get labelPermLocation => 'स्थानम्';

  @override
  String get helpPermLocationDesc =>
      'कोड-सृजने \"मम स्थानम्\" इति कुञ्चके नुन्ने एव, भवतः वर्तमानस्थानं मानचित्र-QR-सङ्केते योजयितुं प्रयुज्यते। स्थानम् एकवारम् एव पठ्यते, न रक्ष्यते, कुत्रापि न प्रेष्यते च। पृष्ठभूमौ कदापि न प्रयुज्यते। निषेधे कृते भवान् स्थानं स्वयं लेखितुं शक्नोति।';

  @override
  String get labelPermBiometric => 'अङ्गुलिमुद्रा मुखं वा';

  @override
  String get helpPermBiometricDesc =>
      'अनुप्रयोग-तालकाय, तालितानां StegoQR-विषयाणाम् अङ्गुलिमुद्रया मुखेन पटलतालकेन वा उद्घाटनाय च प्रयुज्यते। परीक्षणम् Android करोति, सफलं न वा इत्येव अनुप्रयोगाय सूचयति। भवतः अङ्गुलिमुद्रां मुखं वा अनुप्रयोगः कदापि न पश्यति।';

  @override
  String get labelPermNotifications => 'सूचनाः';

  @override
  String get helpPermNotificationsDesc =>
      'वीक्षण-बुद्बुदे सक्रिये एव, सः सक्रियः इति निष्क्रियीकरण-कुञ्चकेन सह दर्शयितुं प्रयुज्यते। बुद्बुदस्य प्रथमसक्रियीकरणे Android पृच्छति। निषेधे कृते अपि बुद्बुदः कार्यं करोति, केवलं सूचना न दृश्यते।';

  @override
  String get labelPermOverlay => 'उपरिप्रदर्शनम्';

  @override
  String get helpPermOverlayDesc =>
      'पटले दृश्यमानं सङ्केतम् अन्वीक्षितुं वीक्षण-बुद्बुदम् अन्यानुप्रयोगाणाम् उपरि दर्शयति। बुद्बुदस्य सक्रियीकरणानन्तरम् एव प्रयुज्यते। अनुप्रयोगः प्रथमम् एतत् विवृणोति, ततः अनुमतिदानाय Android-पृष्ठम् उद्घाटयति। अनुमतिः न दत्ता चेत् बुद्बुदः निष्क्रियः एव तिष्ठति।';

  @override
  String get labelPermScreenCapture => 'पटलग्रहणम्';

  @override
  String get helpPermScreenCaptureDesc =>
      'पटले दृश्यमानं सङ्केतं पठितुं छायावीक्षणं वीक्षण-बुद्बुदः च एतत् प्रयुञ्जाते। प्रतिवारम् Android पृच्छति। अनुप्रयोगः पटलस्य एकम् एव चित्रं गृहीत्वा, सङ्केतं दूरवाण्याम् एव पठित्वा, चित्रं त्यजति। चलचित्रं कदापि न अभिलिखति, चित्रं कुत्रापि न प्रेषयति च।';

  @override
  String get labelPermInternet => 'अन्तर्जालम्';

  @override
  String get helpPermInternetDesc =>
      'अन्वीक्षणं पूर्णतया अन्तर्जालं विना कार्यं करोति। अधः उक्ताभ्याम् ऐच्छिकाभ्यां सम्पर्कपरीक्षणाभ्याम् एव अन्तर्जालं प्रयुज्यते। भवता सक्रियीकरणपर्यन्तम् उभे निष्क्रिये। तयोः निष्क्रिययोः सतोः भवता अन्वीक्षितं किमपि दूरवाणीतः बहिः न गच्छति। सम्पर्कस्य उद्घाटनं भवतः जालदर्शकः करोति, न अयम् अनुप्रयोगः।';

  @override
  String get labelPermProbing => 'सक्रियजालपरीक्षणम्';

  @override
  String get helpPermProbingDesc =>
      'विन्यासाः > गोपनीयता जालपरीक्षणं च इत्यत्र प्रवर्तिते एव। प्रवर्तिते सति, सम्पर्कस्य उद्घाटनात् पूर्वम् अनुप्रयोगः तं सम्पर्कम् उपगम्य तस्य पुनर्निर्देशान् अनुसरति, सुरक्षाप्रमाणपत्रं परीक्षते, जालस्थानस्य वयः च पश्यति।';

  @override
  String get labelPermLinkServices => 'सम्पर्कसुरक्षासेवाः';

  @override
  String get helpPermLinkServicesDesc =>
      'विन्यासाः > URL-सुरक्षा-दाताः इत्यत्र भवता प्रवर्तिताः चेत् एव। प्रवर्तिते सति अन्वीक्षितः सम्पर्कः भवता चिताः सेवाः (यथा Google Safe Browsing, VirusTotal) प्रति प्रेष्यते, ताः तं हानिकरजालस्थानानां सूच्या सह तोलयन्ति। काश्चन सेवाः भवतः स्वकीयाम् API-कुञ्चिकाम् अपेक्षन्ते, सा दूरवाण्याः सुरक्षितसञ्चये रक्ष्यते।';

  @override
  String get labelPermWifi => 'वै-फाई संयोजनम्';

  @override
  String get helpPermWifiDesc =>
      'अन्वीक्षिते वै-फाई-QR-सङ्केते \"संयोज्यताम्\" इति कुञ्चके नुन्ने एव, तत् संजालं दूरवाण्यां योजयितुं प्रयुज्यते। नूतनेषु Android-संस्करणेषु Android प्रथमं भवतः स्थिरीकरणं पृच्छति। भवता रक्षितानि वै-फाई-गूढपदानि अनुप्रयोगः न पठति।';

  @override
  String get labelPermBackground => 'पृष्ठभूमिकार्यम्';

  @override
  String get helpPermBackgroundDesc =>
      'भवति अन्यस्मिन् अनुप्रयोगे स्थिते अपि छायावीक्षणं वीक्षण-बुद्बुदः च कार्यं कर्तुं शक्नुतः। एतत् यावत् प्रचलति तावत् भवतः ज्ञानाय Android सर्वदा एकां सूचनां दर्शयति।';

  @override
  String get labelPermBoot => 'पुनरारम्भानन्तरम्';

  @override
  String get helpPermBootDesc =>
      'दूरवाण्याः पुनरारम्भानन्तरं वीक्षण-बुद्बुदं पुनः आनयति, किन्तु बुद्बुदः सक्रियः आसीत्, \"पुनरारम्भोत्तर-आरम्भः\" च भवता प्रवर्तितः चेत् एव। अन्यथा किमपि न करोति।';

  @override
  String get labelPermStorage => 'चित्राणि सञ्चिकाः च';

  @override
  String get helpPermStorageDesc =>
      'अनुप्रयोगस्य सञ्चयानुमतिः नास्ति। चित्रात् PDF-सञ्चिकायाः वा अन्वीक्षणे Android-स्य स्वकीयः चयनपटलः उद्घाट्यते, भवता चिता सञ्चिका एव अनुप्रयोगेन प्राप्यते।';

  @override
  String get labelPermMicrophone => 'ध्वनिग्राही';

  @override
  String get helpPermMicrophoneDesc =>
      'अनुप्रयोगः ध्वनिग्राहिणं न उपयुङ्क्ते। चित्रग्राही सर्वदा ध्वनिं विना उद्घाट्यते।';

  @override
  String get labelPermVibration => 'कम्पनम्';

  @override
  String get helpPermVibrationDesc =>
      'अन्वीक्षणकम्पनानि Android-स्य अन्तर्निहितां स्पर्शप्रतिक्रियां प्रयुञ्जते, तदर्थम् अनुमतिः न आवश्यकी।';

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
      'जालबन्धस्य उद्घाटनात् धनप्रदानात् वा पूर्वं मुद्रिते QR-सङ्केते कृतकपत्रिका अस्ति वा इति परीक्षितुं स्मारयति। हस्तेन कर्तव्याः लघुपरीक्षाः ददाति; चित्रं न परीक्षते।';

  @override
  String get labelFeatureQuishingGuardChip1 => 'कृतकपत्रिकाः';

  @override
  String get labelFeatureQuishingGuardChip2 => 'स्वयंपरीक्षा';

  @override
  String get labelFeatureQuishingGuardChip3 => 'धनप्रदान-सूचनाः';

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
      'अङ्गुलिमुद्रया मुखेन दूरवाणी-पटल-तालकेन वा ऐच्छिकम् अनुप्रयोग-तालकम्। संवीक्षाः, इतिवृत्तम्, गुप्तविषयाः, API-कुञ्चिकाः च यत्र दृश्यन्ते, तानि पटलानि पटलचित्रं पटल-अभिलेखनं च निवारयन्ति (FLAG_SECURE)। विन्यासाः › गोपनीयता जालपरीक्षणं च इत्यत्र एतत् निष्क्रियं कर्तुं शक्यते। गुप्त-StegoQR-सन्देशाः अपि जैवमापनं याचितुं शक्नुवन्ति।';

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
  String get helpCenterHeaderTitle => 'अनुप्रयोगस्य उपयोगविधिः';

  @override
  String get helpCenterHeaderSubtitle =>
      'अनुप्रयोगस्य प्रत्येकस्य भागस्य सरलाः मार्गदर्शिकाः। कञ्चित् विषयं चित्वा तस्य कार्यम् उपयोगविधिं च पश्यतु।';

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
  String get tooltipSwitchCamera => 'चित्रग्राहीपरिवर्तनम्';

  @override
  String get tooltipBack => 'प्रतिनिवर्तताम्';

  @override
  String get tooltipToggleSecretVisibility => 'गूढप्रदर्शनं परिवर्तयतु';

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
  String get labelOnboardingSlide2Badge => 'वञ्चक-पत्रिकाः';

  @override
  String get titleOnboardingSlide2 => 'कृतकपत्रिका-परीक्षा';

  @override
  String get bodyOnboardingSlide2 =>
      'वञ्चकाः यथार्थसङ्केतानाम् उपरि कृतक-QR-पत्रिकाः लिम्पन्ति। यदा भवान् चित्रग्राहिणा जालबन्धं धनप्रदानसङ्केतं वा संवीक्षते, तदा उद्घाटनात् धनप्रदानात् वा पूर्वं किं परीक्षणीयम् इति क्विशिंग-रक्षकः स्मारयति।';

  @override
  String get bodyOnboardingSlide2Bullet1 => 'पत्रिकायाः उन्नतधाराः स्पृशतु';

  @override
  String get bodyOnboardingSlide2Bullet2 => 'धनग्राहकस्य नाम परीक्षताम्';

  @override
  String get bodyOnboardingSlide2Bullet3 => 'संशये कर्मचारिणः पृच्छतु';

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
  String get helpGuideGroupScanning => 'संवीक्षा';

  @override
  String get helpGuideGroupCreate => 'सङ्केतानां निर्माणं प्रेषणं च';

  @override
  String get helpGuideGroupSecurity => 'सुरक्षा';

  @override
  String get helpGuideGroupPayloads => 'संवीक्षितस्य उपयोगः';

  @override
  String get helpGuideGroupApp => 'अनुप्रयोगः विन्यासाश्च';

  @override
  String get helpGuideBarcodeName => 'सङ्केतानां संवीक्षा';

  @override
  String get helpGuideBarcodeSummary =>
      'चित्रग्राहिणा, चित्रेभ्यः, PDF-सञ्चिकाभ्यः, प्रतिलिखितपाठात् वा संवीक्ष्यताम्। बहवः सङ्केताः क्रमशः संवीक्ष्यन्ताम्।';

  @override
  String get helpGuideBarcodeIntro =>
      'सङ्केतं प्रति चित्रग्राहिणं नयतु, अनुप्रयोगः तं सद्यः पठति। चित्रेभ्यः, PDF-सञ्चिकाभ्यः, प्रतिलिखितपाठात् च अपि सङ्केतान् पठितुं शक्यते। सर्वं पठनं भवतः दूरवाण्याम् एव भवति, अन्तर्जालं न आवश्यकम्।';

  @override
  String get helpGuideBarcodeCameraTitle => 'चित्रग्राहिणा संवीक्षा';

  @override
  String get helpGuideBarcodeCameraBullet1 =>
      'संवीक्षा-विभागम् उद्घाट्य सङ्केतं परिधेः अन्तः धारयतु। अनुप्रयोगः स्वयमेव तं पठति। किमपि स्प्रष्टुं न आवश्यकम्।';

  @override
  String get helpGuideBarcodeCameraBullet2 =>
      'QR-सङ्केतान् (लघून् Micro QR, rMQR इत्येतान् अपि), Data Matrix, Aztec, PDF417, MaxiCode च पठति। आपणेषु प्रेषितवस्तुषु च दृश्यमानान् EAN, UPC, Code 128, Code 39, Code 93, Codabar, ITF, DataBar इति रेखासङ्केतान् अपि पठति।';

  @override
  String get helpGuideBarcodeCameraBullet3 =>
      'दीपः: दीप-चिह्नं स्पृष्ट्वा निष्क्रियः, सक्रियः, स्वयञ्चालितः इति परिवर्तयतु। स्वयञ्चालिते सति अन्धकारे दीपः स्वयमेव प्रज्वलति।';

  @override
  String get helpGuideBarcodeCameraBullet4 =>
      'आवर्धनम्: लघूनां दूरस्थानां वा सङ्केतानां कृते आवर्धन-सर्पकः प्रयुज्यताम्। दूरवाण्याः अतिसमीपनयनात् एतत् श्रेयः।';

  @override
  String get helpGuideBarcodeCameraBullet5 =>
      'चित्रग्राहि-परिवर्तनम्: पृष्ठस्थ-पुरःस्थ-चित्रग्राहिणोः मध्ये परिवर्तयतु।';

  @override
  String get helpGuideBarcodeCameraBullet6 =>
      'स्थगनम्: क्षणं विरन्तुं \"संवीक्षा विरम्यताम्\", पुनः आरब्धुं \"संवीक्षा पुनरारभ्यताम्\" इति स्पृशतु।';

  @override
  String get helpGuideBarcodeGalleryTitle => 'चित्रस्य पटलचित्रस्य वा संवीक्षा';

  @override
  String get helpGuideBarcodeGalleryBullet1 =>
      'संवीक्षा-पटलस्य उपरि वीथिका-चिह्नं स्पृष्ट्वा चित्रं पटलचित्रं वा चिनोतु।';

  @override
  String get helpGuideBarcodeGalleryBullet2 =>
      'Android-तन्त्रस्य स्वकीयं चयनफलकम् उद्घाट्यते। भवता चितम् एकम् एव चित्रम् अनुप्रयोगः पश्यति।';

  @override
  String get helpGuideBarcodeGalleryBullet3 =>
      'चित्रे यदि बहवः सङ्केताः सन्ति, तर्हि अनुप्रयोगः तान् सर्वान् अन्विष्यति।';

  @override
  String get helpGuideBarcodePdfTitle => 'PDF-सञ्चिकायाः संवीक्षा';

  @override
  String get helpGuideBarcodePdfBullet1 =>
      'PDF-चिह्नं स्पृष्ट्वा यात्रापत्रं, देयकपत्रं, विमानप्रवेशपत्रम् इत्यादिकां सञ्चिकां चिनोतु।';

  @override
  String get helpGuideBarcodePdfBullet2 =>
      'अनुप्रयोगः प्रत्येकं पृष्ठं परीक्ष्य प्राप्तान् सर्वान् सङ्केतान् पृष्ठसङ्ख्यया सह दर्शयति।';

  @override
  String get helpGuideBarcodePdfBullet3 =>
      'सर्वान् एकदा इतिवृत्ते रक्षितुं \"सर्वं रक्ष्यताम्\" इति स्पृशतु।';

  @override
  String get helpGuideBarcodePdfBullet4 =>
      'विद्युत्पत्र-सञ्चिकादि-अनुप्रयोगेभ्यः अपि PDF अस्मै अनुप्रयोगाय वितीर्य संवीक्षितुं शक्यते।';

  @override
  String get helpGuideBarcodeClipboardTitle =>
      'प्रतिलिखितस्य पाठस्य चित्रस्य वा संवीक्षा';

  @override
  String get helpGuideBarcodeClipboardBullet1 =>
      'यदि अनुबन्धः, सङ्केतपाठः, चित्रं वा प्रतिलिखितम्, तर्हि तस्य परीक्षणार्थं संवीक्षा-पटलस्य उपरि प्रतिलिपिफलक-चिह्नं स्पृशतु।';

  @override
  String get helpGuideBarcodeClipboardBullet2 =>
      'किञ्चित् प्रतिलिख्य अनुप्रयोगं प्रति प्रत्यागमने लघुपट्टिका तस्य परीक्षणं सूचयेत्। \"स्कैन् क्रियताम्\" इति स्पृशतु, अथवा पट्टिकां पिदधातु।';

  @override
  String get helpGuideBarcodeClipboardBullet3 =>
      'संवीक्षितानुबन्धानाम् इव प्रतिलिखितानुबन्धानाम् अपि सुरक्षापरीक्षणं भवति।';

  @override
  String get helpGuideBarcodeBatchTitle => 'बहूनां सङ्केतानां क्रमिका संवीक्षा';

  @override
  String get helpGuideBarcodeBatchBullet1 =>
      'गणविधिं सक्रियं कर्तुं गण-चिह्नं स्पृशतु। चित्रग्राही निरन्तरं संवीक्षते, प्रत्येकः नूतनः सङ्केतः आवल्यां योज्यते।';

  @override
  String get helpGuideBarcodeBatchBullet2 =>
      'कति सङ्केताः संवीक्षिताः इति गणना दर्शयति। आवलीम् उद्घाटयितुं तां स्पृशतु।';

  @override
  String get helpGuideBarcodeBatchBullet3 =>
      'आवल्यां प्रत्येकं सङ्केतं द्रष्टुं, \"पुनरावृत्तिनिवारणम्\" सक्रियं कर्तुम्, आवलीं CSV, JSON, पाठ, PDF इति रूपेषु निर्यापयितुं च शक्यते।';

  @override
  String get helpGuideBarcodeBatchBullet4 =>
      'सामान्यसंवीक्षां प्रति प्रत्यागन्तुं गण-चिह्नं पुनः स्पृशतु।';

  @override
  String get helpGuideBarcodeTuneTitle => 'यदा सङ्केतः दुष्पठः';

  @override
  String get helpGuideBarcodeTuneBullet1 =>
      '\"चित्रग्राहीसंस्काराः\" इति चिह्नं स्पृशतु। परिवर्तनानि चित्रग्राहि-दृश्ये सद्यः दृश्यन्ते।';

  @override
  String get helpGuideBarcodeTuneBullet2 =>
      'द्युतिः वैषम्यं च: अन्धकारमयं मलिनं वा सङ्केतं स्पष्टतरं कुरुतः।';

  @override
  String get helpGuideBarcodeTuneBullet3 =>
      'वर्णव्युत्क्रमः: कृष्णपृष्ठभूमौ शुक्लसङ्केतस्य कृते, यथा कृष्णपटले धातुफलके वा।';

  @override
  String get helpGuideBarcodeTuneBullet4 =>
      'चित्रग्राहिसङ्कल्पना: अधिकांशदूरवाणीनां कृते 1080p उचितम्। 720p विद्युत्कोशं रक्षति। अतिलघुसङ्केतानां कृते महत्तमम् उपकरोति।';

  @override
  String get helpGuideBarcodeTuneBullet5 =>
      'दूरस्थवीक्षणसहायः: भित्तिपत्रेषु सूचनाफलकेषु च स्थितान् दूरस्थान् सङ्केतान् पठितुं साहाय्यं करोति। \"दूरविस्तारः\", \"धारातीक्ष्णीकरणम्\" इत्याभ्यां तं सूक्ष्मतया संस्करोतु।';

  @override
  String get helpGuideBarcodeTuneBullet6 =>
      'बहु-सङ्केत-चयनम्: यदा बहवः सङ्केताः दृश्यन्ते, तदा प्रत्येकस्य परितः रेखा दृश्यते। इष्टं सङ्केतं स्पृशतु।';

  @override
  String get helpGuideBarcodeTuneBullet7 =>
      '\"संस्कारान् पुनरनुकूलयतु\" इति सर्वं पूर्वस्थितिं नयति।';

  @override
  String get helpGuideBarcodeTip =>
      'सूचना: सङ्केताः भवतः दूरवाण्याम् एव पठ्यन्ते। चित्रग्राहि-दृश्यानि कदापि न रक्ष्यन्ते, न च कुत्रापि प्रेष्यन्ते।';

  @override
  String get helpGuideArCodeVisionName => 'AR सङ्केतदृष्टिः';

  @override
  String get helpGuideArCodeVisionSummary =>
      'बहून् सङ्केतान् युगपत् चित्रग्राहि-दृश्ये एव द्रष्टुम् उपयोक्तुं च शक्यते।';

  @override
  String get helpGuideArCodeVisionIntro =>
      'चित्रग्राहिणा दृश्यमानान् सर्वान् सङ्केतान् AR सङ्केतदृष्टिः युगपत् अन्विष्यति। प्रत्येकस्य सङ्केतस्य उपरि लघु नामपत्रं प्लवते, अतः स्पर्शात् पूर्वम् एव सः कः इति ज्ञातुं शक्यते।';

  @override
  String get helpGuideArCodeVisionOpenTitle => 'उद्घाटनविधिः';

  @override
  String get helpGuideArCodeVisionOpenBullet1 =>
      'संवीक्षा-पटले \"अधिकविकल्पाः\" (बिन्दुत्रयम्) स्पृष्ट्वा \"AR संवीक्षा-फलकम्\" इति चिनोतु।';

  @override
  String get helpGuideArCodeVisionOpenBullet2 =>
      'यदि Android पृच्छति, तर्हि चित्रग्राहिणः उपयोगः अनुमन्यताम्।';

  @override
  String get helpGuideArCodeVisionTrackingTitle => 'विधिद्वयम्';

  @override
  String get helpGuideArCodeVisionTrackingBullet1 =>
      'सुरक्षा: प्रत्येकस्मै अनुबन्धाय वर्णचिह्नं दीयते। हरितं नाम न कोऽपि दोषः प्राप्तः। रक्तं नाम अनुबन्धः असुरक्षितः इव दृश्यते।';

  @override
  String get helpGuideArCodeVisionTrackingBullet2 =>
      'भाण्डागारम्: मूल्यपत्रम् इत्यादीनि वस्तुविवरणानि दर्शयति, सङ्केतान् चेतुं च अनुमन्यते।';

  @override
  String get helpGuideArCodeVisionBatchTitle => 'नामपत्राणाम् उपयोगः';

  @override
  String get helpGuideArCodeVisionBatchBullet1 =>
      'पूर्णं विषयं द्रष्टुं नामपत्रं स्पृशतु। ततः प्रतिलेखनम्, अनुबन्धस्य उद्घाटनं, चयनं वा कर्तुं शक्यते।';

  @override
  String get helpGuideArCodeVisionBatchBullet2 =>
      'भाण्डागार-विधौ बहून् सङ्केतान् चित्वा सर्वान् एकत्र प्रतिलेखितुं \"एकत्र प्रतिलिख्यताम्\" इति स्पृशतु। पुनः आरब्धुं \"प्रमृज्यताम्\" इति स्पृशतु।';

  @override
  String get helpGuideArCodeVisionBatchBullet3 =>
      'अन्धकारे प्रकाशदीप-चिह्नं स्पृशतु।';

  @override
  String get helpGuideArCodeVisionTip =>
      'सूचना: दूरवाणीं शनैः चालयतु। चालने नामपत्राणि सङ्केतान् अनुसरन्ति।';

  @override
  String get helpGuideScanBubbleName => 'अन्यानुप्रयोगेभ्यः संवीक्षा';

  @override
  String get helpGuideScanBubbleSummary =>
      'अन्यस्मिन् अनुप्रयोगे पटले दृश्यमानं सङ्केतं छायावीक्षणेन वीक्षण-बुद्बुदेन वा पठतु।';

  @override
  String get helpGuideScanBubbleIntro =>
      'कदाचित् सङ्केतः भवतः पटले सम्भाषणे, जालपृष्ठे, विद्युत्पत्रे वा दृश्यते। पटलचित्रं विना द्विधा तं पठितुं शक्यते: छायावीक्षणेन वीक्षण-बुद्बुदेन च। उभे अपि अन्तर्जालं विना दूरवाण्याम् एव सङ्केतं पठतः।';

  @override
  String get helpGuideScanBubbleGhostTitle =>
      'छायावीक्षणम्: पटलस्य एकवारं संवीक्षा';

  @override
  String get helpGuideScanBubbleGhostBullet1 =>
      'संवीक्षा-पटले \"अधिकविकल्पाः\" स्पृष्ट्वा \"छायावीक्षणम्\" इति चिनोतु।';

  @override
  String get helpGuideScanBubbleGhostBullet2 =>
      'शीघ्रविन्यासेषु (पटलस्य उपरितः अधः आकृष्यमाणे फलके) छायावीक्षण-चिह्नं स्थापयितुं \"शीघ्रसंयोजन-पट्टिका योज्यताम्\" इति स्पृशतु।';

  @override
  String get helpGuideScanBubbleGhostBullet3 =>
      'ततः कस्मिन्नपि अनुप्रयोगे शीघ्रविन्यासान् अधः आकृष्य छायावीक्षण-पट्टिकां स्पृशतु। अनुप्रयोगः पटलस्थं सङ्केतं पठति।';

  @override
  String get helpGuideScanBubbleUseTitle => 'वीक्षण-बुद्बुदस्य उपयोगविधिः';

  @override
  String get helpGuideScanBubbleUseBullet1 =>
      'विन्यासाः > वीक्षण-बुद्बुदः, शीघ्रविन्यासेषु वीक्षण-बुद्बुद-पट्टिका, अनुप्रयोग-चिह्नस्य दीर्घस्पर्शः वा — एतैः सक्रियं करोतु।';

  @override
  String get helpGuideScanBubbleUseBullet2 =>
      'QR-सङ्केतं रेखा-सङ्केतं वा दर्शयन्तं कञ्चित् अनुप्रयोगम् उद्घाट्य बुद्बुदं स्पृशतु।';

  @override
  String get helpGuideScanBubbleUseBullet3 =>
      'Android पटल-ग्रहणाय अनुमतिं पृच्छति। अनुमते सति परिणामः सामान्य-सुरक्षापरीक्षाभिः सह उद्घाट्यते।';

  @override
  String get helpGuideScanBubbleUseBullet4 =>
      'बुद्बुदं चालयितुं तम् आकर्षतु। निष्क्रियीकर्तुं पटलस्य अधोभागे स्थितं X-चिह्नं प्रति आकर्षतु।';

  @override
  String get helpGuideScanBubbleUseBullet5 =>
      'दूरवाण्याः पुनरारम्भानन्तरम् अपि बुद्बुदः पुनः आगच्छेत् इति इच्छति चेत्, \"पुनरारम्भोत्तर-आरम्भः\" सक्रियं करोतु।';

  @override
  String get helpGuideScanBubblePrivacyTitle => 'गोपनीयता';

  @override
  String get helpGuideScanBubblePrivacyBullet1 =>
      'बुद्बुदस्य छायावीक्षण-पट्टिकायाः वा स्पर्शे एव पटलं गृह्यते, Android च प्रथमं भवन्तं पृच्छति।';

  @override
  String get helpGuideScanBubblePrivacyBullet2 =>
      'सङ्केतः दूरवाण्याम् एव पठ्यते। पठनाय किमपि अन्तर्जालं प्रति न प्रेष्यते।';

  @override
  String get helpGuideScanBubblePrivacyBullet3 =>
      'पटल-चित्रं वीथिकायां न रक्ष्यते, पठनानन्तरं सद्यः अपाक्रियते।';

  @override
  String get helpGuideScanBubbleLimitsTitle => 'ज्ञातव्यम्';

  @override
  String get helpGuideScanBubbleLimitsBullet1 =>
      'Android 14 इत्यस्मिन् नूतनतरेषु च प्रतिस्पर्शं पटल-ग्रहणानुमतिः पृच्छ्यते।';

  @override
  String get helpGuideScanBubbleLimitsBullet2 =>
      'वित्तकोश-धनप्रेषण-अनुप्रयोगाः केचन चलचित्र-अनुप्रयोगाः च पटल-ग्रहणं निरुन्धन्ति। तेषु सङ्केताः पठितुं न शक्यन्ते।';

  @override
  String get helpGuideScanBubbleLimitsBullet3 =>
      'केषुचित् दूरवाणीषु अतिरिक्ताः \"उत्प्लव-गवाक्ष\"-विन्यासाः विद्युत्कोश-विन्यासाः वा सन्ति, ये बुद्बुदं गोपयितुं निवारयितुं वा शक्नुवन्ति।';

  @override
  String get helpGuideScanBubbleTip =>
      'सूचना: वीक्षण-बुद्बुद-पट्टिकां शीघ्रविन्यासेषु योजयतु। ततः कस्मादपि अनुप्रयोगात् एकेन स्पर्शेन बुद्बुदः सक्रियः निष्क्रियः वा भवति।';

  @override
  String get helpGuideCodeForgeName => 'सङ्केतनिर्माणम् (कोड-सृजनम्)';

  @override
  String get helpGuideCodeForgeSummary =>
      'स्वकीयान् QR-सङ्केतान् रेखासङ्केतान् च रचयतु, तेषां रूपं परिवर्तयतु, वितरतु च।';

  @override
  String get helpGuideCodeForgeIntro =>
      'कोड-सृजने स्वकीयं QR-सङ्केतं रेखासङ्केतं वा रचयितुं शक्यते: वै-फाई, सम्पर्कविवरणम्, अनुबन्धः, UPI-धनप्रेषणम् इत्यादीनां कृते। तस्य वर्णान् आकारान् च परिवर्त्य चित्ररूपेण वितरितुं शक्यते।';

  @override
  String get helpGuideCodeForgeTypeTitle => '1. किं स्थापनीयम् इति चिनोतु';

  @override
  String get helpGuideCodeForgeTypeBullet1 =>
      'पटलस्य अधोभागे \"कोड-सृजनम्\" इति विभागम् उद्घाटयतु।';

  @override
  String get helpGuideCodeForgeTypeBullet2 =>
      'सङ्केतप्रकारं चिनोतु: क्यूआर् सङ्केतः, अथवा Code 128, EAN-13, EAN-8, UPC-A, Code 39, PDF417, Data Matrix इत्यादिः रेखासङ्केतः।';

  @override
  String get helpGuideCodeForgeTypeBullet3 =>
      'QR-सङ्केते किं स्यात् इति चिनोतु: पाठ्यम्, जालसङ्केतः, वै-फाई, सम्पर्कः, युपीआई, सन्देशः, विद्युत्पत्रम्, स्थानम् वा।';

  @override
  String get helpGuideCodeForgeTypeBullet4 =>
      'क्षेत्राणि पूरयतु। लेखनेन सह पूर्वावलोकनं परिवर्तते।';

  @override
  String get helpGuideCodeForgeTypeBullet5 =>
      'पाठ्यार्थं सञ्चिकातः पाठम् आनेतुं \"सञ्चिकातः पठतु\" इति अपि स्प्रष्टुं शक्यते (500 अक्षराणि यावत्)।';

  @override
  String get helpGuideCodeForgeTypeBullet6 =>
      'स्थानार्थं वर्तमानस्थानं पूरयितुं \"मम स्थानम्\" इति स्पृशतु। अनुप्रयोगः तस्मिन् क्षणे एव स्थानं पृच्छति, न च तत् रक्षति।';

  @override
  String get helpGuideCodeForgeStyleTitle => '2. रूपं परिवर्तयतु';

  @override
  String get helpGuideCodeForgeStyleBullet1 =>
      'संरचना-विन्यासः: बृहतां कोणचतुरस्राणां, तेषां मध्यभागानां, लघुबिन्दूनां च आकारं चिनोतु।';

  @override
  String get helpGuideCodeForgeStyleBullet2 =>
      'वर्णसंयोजनम्: सङ्केतस्य वर्णं पृष्ठभूमिं च, अथवा \"सूर्यास्तः\", \"सागरः\" इत्यादिकं वर्णमिश्रणं चिनोतु।';

  @override
  String get helpGuideCodeForgeStyleBullet3 =>
      'वर्णयोः दृढं वैषम्यं रक्षतु। शुक्लपृष्ठभूमौ कृष्णसङ्केतः श्रेष्ठतया संवीक्ष्यते।';

  @override
  String get helpGuideCodeForgeStyleBullet4 =>
      'केन्द्र-चिह्नम्: सङ्केतस्य मध्ये लघुचिह्नं स्थापयतु।';

  @override
  String get helpGuideCodeForgeStyleBullet5 =>
      'त्रुटि-शोधनम्: कियत्यां क्षतौ सत्याम् अपि सङ्केतः संवीक्ष्यते इति। L प्रायः 7%, M 15%, Q 25%, H 30% क्षतिं सहते। उच्चतरे स्तरे सङ्केते अधिकाः बिन्दवः भवन्ति। केन्द्र-चिह्ने योजिते H चिनोतु।';

  @override
  String get helpGuideCodeForgeStyleBullet6 =>
      '\"सङ्ख्या दृश्यताम्\" इति रेखासङ्केतस्य अधः तस्य पाठं दर्शयति। \"विन्यासः प्रत्यानयताम्\" इति रूपं पूर्वस्थितिं नयति।';

  @override
  String get helpGuideCodeForgeShareTitle => '3. परीक्ष्य वितरतु';

  @override
  String get helpGuideCodeForgeShareBullet1 =>
      'अनुबन्धः चेत्, वितरणात् पूर्वं तस्य सुरक्षां द्रष्टुं \"परीक्ष्यताम्\" इति स्पृशतु।';

  @override
  String get helpGuideCodeForgeShareBullet2 =>
      'सामान्यचित्ररूपेण वितरितुं \"चित्रांश-भाजनम्\", सर्वेषु परिमाणेषु स्पष्टतया मुद्रणीयाय चित्राय \"सदिश-भाजनम्\" इति स्पृशतु।';

  @override
  String get helpGuideCodeForgeShareBullet3 =>
      'सङ्केतस्य अन्तःस्थं पाठं प्रतिलेखितुं \"प्रतिलिख्यताम्\" इति चिह्नं स्पृशतु।';

  @override
  String get helpGuideCodeForgeTip =>
      'सूचना: बहूनां प्रतीनां मुद्रणात् पूर्वं नूतनः सङ्केतः सम्यक् पठ्यते वा इति अनेन अनुप्रयोगेण एकवारं संवीक्ष्य पश्यतु।';

  @override
  String get helpGuideAirQrName => 'वायु-क्यूआर: जालं विना दत्तांशप्रेषणम्';

  @override
  String get helpGuideAirQrSummary =>
      'चलैः QR-सङ्केतैः पाठं प्रेषयतु, अथवा अनुप्रयोगस्य दत्तांशम् अन्यां दूरवाणीं नयतु। वै-फाई, ब्लूटूथ्, तन्तुः वा न आवश्यकः।';

  @override
  String get helpGuideAirQrIntro =>
      'वायु-क्यूआर पटलं चित्रग्राहिणं च एव उपयुज्य एकस्याः दूरवाण्याः अन्यां प्रति दत्तांशं प्रेषयति। प्रेषिका दूरवाणी शीघ्रं परिवर्तमानान् QR-सङ्केतान् दर्शयति। ग्राहिका दूरवाणी तान् दृष्ट्वा पुनः एकीकरोति। किमपि जालं न उपयुज्यते।';

  @override
  String get helpGuideAirQrStreamingTitle => 'प्रेषणविधिः';

  @override
  String get helpGuideAirQrStreamingBullet1 =>
      'प्रेषिकायां दूरवाण्यां संवीक्षा > अधिकविकल्पाः > वायु-क्यूआर ग्राहकः इति उद्घाट्य उपरि वायु-क्यूआर प्रसारक-चिह्नं स्पृशतु।';

  @override
  String get helpGuideAirQrStreamingBullet2 =>
      'यत् प्रेषणीयं तत् \"प्रसारणीयः विषयः\" इत्यत्र लिखतु स्थापयतु वा।';

  @override
  String get helpGuideAirQrStreamingBullet3 =>
      '\"प्रसारण-गतिः\" (प्रतिक्षणं 5 तः 25 पर्यन्तं चित्राणि) चित्वा \"प्रकाश-प्रसारणं प्रारभ्यताम्\" इति स्पृशतु।';

  @override
  String get helpGuideAirQrStreamingBullet4 =>
      'प्रेषकपटलं दीप्तं स्थिरं च धारयतु।';

  @override
  String get helpGuideAirQrControlsTitle => 'ग्रहणविधिः';

  @override
  String get helpGuideAirQrControlsBullet1 =>
      'अपरस्यां दूरवाण्यां संवीक्षा > अधिकविकल्पाः > वायु-क्यूआर ग्राहकः इति उद्घाट्य चित्रग्राहिणं प्रेषकपटलं प्रति नयतु।';

  @override
  String get helpGuideAirQrControlsBullet2 =>
      'कति भागाः प्राप्ताः, कति अद्यापि अप्राप्ताः इति प्रगतिरेखा दर्शयति।';

  @override
  String get helpGuideAirQrControlsBullet3 =>
      'केचन भागाः अप्राप्ताः चेदपि न चिन्ता। रिक्तस्थानानि पूरयितुं वायु-क्यूआर अतिरिक्तान् संशोधनभागान् अपि प्रेषयति।';

  @override
  String get helpGuideAirQrControlsBullet4 =>
      'सर्वेषु भागेषु प्राप्तेषु अनुप्रयोगः दत्तांशं परीक्ष्य \"हस्तान्तरणं सम्पूर्णम्!\" इति दर्शयति। ततः दत्तांशः प्रतिलेखितुं शक्यते।';

  @override
  String get helpGuideAirQrSyncTitle =>
      'नूतनदूरवाणीं प्रति दत्तांशस्थानान्तरणम्';

  @override
  String get helpGuideAirQrSyncBullet1 =>
      'पुरातन्यां दूरवाण्यां विन्यासाः > एयर्-क्यु-आर् तुल्यकालनम् इति गच्छतु। इतिवृत्तम्, अनुप्रयोगविन्यासान्, उभयं वा चिनोतु।';

  @override
  String get helpGuideAirQrSyncBullet2 =>
      'कूटवाक्यं पिन्-सङ्ख्यां वा लिखतु, अथवा \"पिन्-सङ्ख्यां रचयतु\" इति स्पृशतु। एतत् दत्तांशं ताडयति, पिन्-ज्ञाता एव तम् उद्घाटयितुं शक्नोति।';

  @override
  String get helpGuideAirQrSyncBullet3 =>
      '\"एयर्-क्यु-आर् द्वारा प्रेषयतु\" इति स्पृष्ट्वा नूतनदूरवाण्यां वायु-क्यूआर ग्राहकेण गृह्णातु।';

  @override
  String get helpGuideAirQrSyncBullet4 =>
      'नूतनदूरवाण्यां तदेव कूटवाक्यं पिन्-सङ्ख्यां वा लिखित्वा \"उद्घाट्य तुल्यकालीकरोतु\" इति स्पृशतु।';

  @override
  String get helpGuideAirQrSecurityTitle => 'किमर्थं गोपनीयम्';

  @override
  String get helpGuideAirQrSecurityBullet1 =>
      'न किमपि आकाशवाणीतरङ्गाः उपयुज्यन्ते: न वै-फाई, न ब्लूटूथ्, न चलदूरवाणीजालम्, न अन्तर्जालम्।';

  @override
  String get helpGuideAirQrSecurityBullet2 =>
      'जालमार्गेण कोऽपि दत्तांशम् अपहर्तुं न शक्नोति। पटलं द्रष्टुं समर्थः चित्रग्राही एव तं पठितुं शक्नोति।';

  @override
  String get helpGuideAirQrSecurityBullet3 =>
      'कूटशब्दानां, कुञ्चिकानां, अन्तर्जालेन प्रेषयितुम् अनिष्टस्य अन्यस्य गोपनीयदत्तांशस्य च कृते उपयोगी।';

  @override
  String get helpGuideAirQrTip =>
      'सूचना: प्रेषिकायाः दूरवाण्याः द्युतिं वर्धयतु, ग्राहिकां च स्थिरं धारयतु। यदि भागाः पुनः पुनः अप्राप्ताः, तर्हि गतिं न्यूनीकरोतु।';

  @override
  String get helpGuideUrlSafetyName => 'अनुबन्ध-सुरक्षापरीक्षणम्';

  @override
  String get helpGuideUrlSafetySummary =>
      'उद्घाटनात् पूर्वम् अनुप्रयोगः प्रत्येकम् अनुबन्धं कथं परीक्षते, परिणामस्य अर्थः कः इति।';

  @override
  String get helpGuideUrlSafetyIntro =>
      'वञ्चक-QR-सङ्केताः प्रायः कृतकजालस्थानानि नयन्ति। अतः कस्यापि अनुबन्धस्य उद्घाटनात् पूर्वम् अनुप्रयोगः तं षड्विधं यावत् परीक्षते। प्रथमाः चतस्रः परीक्षाः सर्वदा अन्तर्जालं विना भवतः दूरवाण्याम् एव प्रचलन्ति।';

  @override
  String get helpGuideUrlSafetyLayersTitle => 'षट् परीक्षाः';

  @override
  String get helpGuideUrlSafetyLayersBullet1 =>
      '1. सुरक्षितसंयोगः: अनुबन्धः सुरक्षितं HTTPS उपयुङ्क्ते वा? तस्मिन् विचित्राणि अदृश्यानि वा अक्षराणि गूढानि वा?';

  @override
  String get helpGuideUrlSafetyLayersBullet2 =>
      '2. सदृशाक्षराणि: कानिचित् कृतकस्थानानि अन्यलिपीनां सदृशाक्षराणि उपयुञ्जते, यथा सामान्यस्य \"a\" इत्यस्य स्थाने सिरिलिक्-लिपेः \"а\"।';

  @override
  String get helpGuideUrlSafetyLayersBullet3 =>
      '3. विचित्राः जालसङ्केताः: सङ्कटपूर्णाः अन्त्यभागाः (.xyz, .top इत्यादयः), नाम्नि अत्यधिकाः भागाः, यादृच्छिकाक्षरैः रचितानि नामानि वा।';

  @override
  String get helpGuideUrlSafetyLayersBullet4 =>
      '4. सङ्ख्यासङ्केताः असामान्य-द्वाराणि च: केवलसङ्ख्याम् (IP-सङ्केतम्) असामान्यं द्वारं (port) वा उपयुञ्जानाः अनुबन्धाः; सामान्याः आपणाः वित्तकोशाः च एतानि न उपयुञ्जते।';

  @override
  String get helpGuideUrlSafetyLayersBullet5 =>
      '5. स्थानस्य संयुक्तपरीक्षणम् (वैकल्पिकम्): सङ्क्षिप्तानुबन्धाः (bit.ly इव) वस्तुतः कुत्र नयन्ति इति अनुसरति, स्थानस्य सुरक्षाप्रमाणपत्रं च परीक्षते। \"सक्रियजालपरीक्षणम्\" सक्रियं चेत् एव प्रचलति।';

  @override
  String get helpGuideUrlSafetyLayersBullet6 =>
      '6. ज्ञातदुष्टस्थानानाम् आवल्यः (वैकल्पिकम्): अनुबन्धः ज्ञातं वञ्चनास्थानं विषाणुस्थानं वा इति Google Safe Browsing इत्यादीन् सेवाः पृच्छति। भवता सज्जीकृते एव प्रचलति।';

  @override
  String get helpGuideUrlSafetyVerdictsTitle => 'परिणामस्य पठनम्';

  @override
  String get helpGuideUrlSafetyVerdictsBullet1 =>
      'न कोऽपि दोषः: प्रचलिताः सर्वाः परीक्षाः अनुबन्धः उत्तीर्णवान्। तथापि ज्ञातेषु स्रोतःसु एव विश्वसितु।';

  @override
  String get helpGuideUrlSafetyVerdictsBullet2 =>
      'दोषाः प्राप्ताः: काः परीक्षाः असफलाः इति अनुप्रयोगः दर्शयति। कारणं पठितुं \"विवरणं दृश्यताम्\" इति स्पृशतु।';

  @override
  String get helpGuideUrlSafetyVerdictsBullet3 =>
      'सङ्कटपूर्णम् अनुबन्धम् उद्घाटयितुं प्रयत्ने अनुप्रयोगः प्रथमं पृच्छति। स्रोतसि विश्वासः अस्ति चेत् एव \"तथापि उद्घाटयतु\" इति स्पृशतु।';

  @override
  String get helpGuideUrlSafetyVerdictsBullet4 =>
      'परीक्षाः पुनः चालयितुं \"पुनरीक्षताम्\" इति स्पृशतु, यथा अन्तर्जाल-संयोगानन्तरम्।';

  @override
  String get helpGuideUrlSafetyPrivacyTitle => 'गोपनीयविधिः संयुक्तपरीक्षणं च';

  @override
  String get helpGuideUrlSafetyPrivacyBullet1 =>
      'सामान्यतः अनुप्रयोगः तत् जालस्थानं कदापि न सम्पर्कयति। भवतः दूरवाणीं IP-सङ्केतं (अन्तर्जालसङ्केतम्) वा तत् स्थानं द्रष्टुं न शक्नोति।';

  @override
  String get helpGuideUrlSafetyPrivacyBullet2 =>
      'विन्यासाः > गोपनीयता जालपरीक्षणं च इत्यत्र \"सक्रियजालपरीक्षणम्\" सक्रियं चेत्, सङ्क्षिप्तानुबन्धान् अनुसर्तुं प्रमाणपत्रं परीक्षितुं च अनुप्रयोगः तत् स्थानं गच्छति। एतेन अधिकं ज्ञायते, किन्तु स्थानं भवतः IP-सङ्केतं द्रष्टुं शक्नोति।';

  @override
  String get helpGuideUrlSafetyPrivacyBullet3 =>
      '\"सक्रियजालपरीक्षणम्\" सक्रियं चेत्, परिणामे पृष्ठस्य सुरक्षितं पूर्वावलोकनम् अपि दृश्यते। लिपिकाः अनुसारकाः च प्रथमम् एव अपनीयन्ते, अतः पृष्ठस्थं किमपि न प्रचलति। \"पूर्वावलोकनं दर्शयतु\" \"पृष्ठं परीक्ष्यताम्\" वा इति स्पृशतु।';

  @override
  String get helpGuideUrlSafetyProvidersTitle => 'अतिरिक्ताः संयुक्तपरीक्षकाः';

  @override
  String get helpGuideUrlSafetyProvidersBullet1 =>
      'विन्यासाः > URL-सुरक्षा-दाताः इत्यत्र अधिकान् परीक्षकान् सक्रियान् कर्तुं शक्यते। PhishTank, OpenPhish इत्येतयोः कृते उपयोक्तृविवरणं न आवश्यकम्।';

  @override
  String get helpGuideUrlSafetyProvidersBullet2 =>
      'Google Safe Browsing, VirusTotal, URLhaus इत्येतेषां कृते भवतः स्वकीया निःशुल्का कुञ्चिका आवश्यकी। \"संयुक्तपरीक्षकाणां सज्जीकरणम्\" इति मार्गदर्शिकां पश्यतु।';

  @override
  String get helpGuideUrlSafetyProvidersBullet3 =>
      'एते परीक्षकाः भवता संवीक्षितम् अनुबन्धम् एव प्राप्नुवन्ति। OpenPhish भिन्नरीत्या कार्यं करोति: अनुप्रयोगः तस्य आवलीम् अवतार्य दूरवाण्याम् एव परीक्षते। भवता सक्रियीकरणपर्यन्तं सर्वे निष्क्रियाः तिष्ठन्ति।';

  @override
  String get helpGuideUrlSafetyTip =>
      'सूचना: शुभः परिणामः प्रतिज्ञा न। वञ्चकाः प्रतिदिनं नूतनानि स्थानानि रचयन्ति। यदि धनप्रेषण-पृष्ठं प्रवेश-पृष्ठं वा विचित्रं दृश्यते, तर्हि तत् पिदधातु।';

  @override
  String get helpGuideQuishingName => 'क्विशिंग-रक्षकः: कृतक-लेपित-सङ्केताः';

  @override
  String get helpGuideQuishingSummary =>
      'यथार्थसङ्केतस्य उपरि लेपिताः कृतकपत्रिकाः स्युः इति QR-सङ्केतान् अभिजानातु।';

  @override
  String get helpGuideQuishingIntro =>
      '\"क्विशिङ्\" नाम QR-द्वारा वञ्चना। वाहनस्थानमापकेषु, भोज्यसूचीषु, आपणफलकेषु, भित्तिपत्रेषु च यथार्थसङ्केतस्य उपरि वञ्चकाः स्वकीयं QR-सङ्केतं लिम्पन्ति, येन भवतः धनं प्रवेशविवरणं वा तान् प्राप्नोति।';

  @override
  String get helpGuideQuishingCvTitle => 'क्विशिंग-रक्षकः किं दर्शयति';

  @override
  String get helpGuideQuishingCvBullet1 =>
      'चित्रग्राहिणा जालबन्धस्य धनप्रदानसङ्केतस्य वा संवीक्षानन्तरं परिणाम-पटले \"कृतकपत्रिका-परीक्षा\" इति लघु क्विशिंग-रक्षक-पत्रं दृश्यते।';

  @override
  String get helpGuideQuishingCvBullet2 =>
      'तत् स्पृष्ट्वा परीक्षाणां लघुसूची उद्घाट्यते। अनुप्रयोगः चित्रे पत्रिकां न अन्विच्छति, अङ्कं च न ददाति; अतः सङ्केतः सुरक्षितः इति वक्तुं न शक्नोति।';

  @override
  String get helpGuideQuishingCvBullet3 =>
      'छायाचित्राणां, फलकस्य, पटल-संवीक्षायाः, सामान्यपाठस्य च कृते इदं पत्रं न दृश्यते, यतः ते सङ्केताः भित्तौ न लिप्ताः।';

  @override
  String get helpGuideQuishingForensicTitle => 'भवता किं करणीयम्';

  @override
  String get helpGuideQuishingForensicBullet1 =>
      'सङ्केतं पश्यतु, अङ्गुल्या स्पृष्ट्वा अनुभवतु च। उपरि लेपितायाः पत्रिकायाः धाराः प्रायः उन्नताः भवन्ति, सा वक्रा वा तिष्ठति।';

  @override
  String get helpGuideQuishingForensicBullet2 =>
      'धनप्रदानात् पूर्वं धनप्रेषणपटले नाम आपणस्य नाम्ना समानम् इति निश्चिनोतु।';

  @override
  String get helpGuideQuishingForensicBullet3 =>
      'संशये सति कर्मचारिणः पृच्छतु, अथवा जालसङ्केतं स्वयं लिखतु।';

  @override
  String get helpGuideQuishingTip =>
      'सूचना: क्विशिंग-रक्षकः सहायकः एव, न प्रतिज्ञा। भवतः नेत्रे अङ्गुलयः च श्रेष्ठं परीक्षणम्।';

  @override
  String get helpGuideSafeBrowsingName => 'संयुक्तपरीक्षकाणां सज्जीकरणम्';

  @override
  String get helpGuideSafeBrowsingSummary =>
      'अतिरिक्ताः अनुबन्धपरीक्षाः सक्रियाः करोतु, Google Safe Browsing इत्यस्य निःशुल्कां कुञ्चिकां च प्राप्नोतु।';

  @override
  String get helpGuideSafeBrowsingIntro =>
      'संयुक्तपरीक्षकाः संवीक्षितम् अनुबन्धं ज्ञातवञ्चनास्थानानां विषाणुस्थानानां च आवलीभिः सह तोलयन्ति। एते वैकल्पिकाः। एतैः विना अपि अनुप्रयोगस्य स्वकीयाः परीक्षाः प्रचलन्ति।';

  @override
  String get helpGuideSafeBrowsingBuiltInTitle => 'उपयोक्तृविवरणं न आवश्यकम्';

  @override
  String get helpGuideSafeBrowsingBuiltInBullet1 =>
      'विन्यासाः > URL-सुरक्षा-दाताः इति उद्घाटयतु।';

  @override
  String get helpGuideSafeBrowsingBuiltInBullet2 =>
      'PhishTank इत्यस्य वञ्चनास्थानावल्या सह अनुबन्धान् तोलयितुं \"PhishTank सक्रियीकरणम्\" सक्रियं करोतु।';

  @override
  String get helpGuideSafeBrowsingBuiltInBullet3 =>
      '\"OpenPhish-सूचिः उपयुज्यताम्\" सक्रियं करोतु। अनुप्रयोगः OpenPhish इत्यस्य आवलीम् अवतार्य दूरवाण्याम् एव अनुबन्धान् परीक्षते। नूतनाम् आवलीं प्राप्तुं \"सूचिं नवीकरोतु\" इति स्पृशतु।';

  @override
  String get helpGuideSafeBrowsingKeyTitle =>
      'Google Safe Browsing इत्यस्य निःशुल्ककुञ्चिकाप्राप्तिः';

  @override
  String get helpGuideSafeBrowsingKeyStep1 =>
      '1. जालगवेषके console.cloud.google.com इति उद्घाट्य Google-उपयोक्तृविवरणेन प्रविशतु।';

  @override
  String get helpGuideSafeBrowsingKeyStep2 =>
      '2. नूतनां परियोजनां रचयतु। किमपि नाम उचितम्, यथा \"QR safety\"।';

  @override
  String get helpGuideSafeBrowsingKeyStep3 =>
      '3. APIs & Services > Library इति गत्वा \"Safe Browsing API\" अन्विष्य Enable इति स्पृशतु।';

  @override
  String get helpGuideSafeBrowsingKeyStep4 =>
      '4. APIs & Services > Credentials इति गत्वा Create credentials स्पृष्ट्वा API key इति चिनोतु।';

  @override
  String get helpGuideSafeBrowsingKeyStep5 =>
      '5. कुञ्चिकां प्रतिलिखतु। अनुप्रयोगे विन्यासाः > URL-सुरक्षा-दाताः इति उद्घाट्य Google Safe Browsing-क्षेत्रे स्थापयित्वा \"कुञ्चिकां रक्षतु\" इति स्पृशतु।';

  @override
  String get helpGuideSafeBrowsingOtherTitle =>
      'कुञ्चिकापेक्षिण्यः अन्याः सेवाः';

  @override
  String get helpGuideSafeBrowsingOtherBullet1 =>
      'VirusTotal, URLhaus इत्येते अपि तथैव। तेषां जालस्थाने निःशुल्कम् उपयोक्तृविवरणं रचयित्वा कुञ्चिकां प्रतिलिख्य \"भवतः API कुञ्चिकाः\" इत्यत्र स्थापयतु। प्रत्येका कुञ्चिका कुत्र लभ्यते इति अनुप्रयोगः दर्शयति।';

  @override
  String get helpGuideSafeBrowsingOtherBullet2 =>
      'एताः निःशुल्ककुञ्चिकाः वैयक्तिकाय अवाणिज्याय उपयोगाय एव।';

  @override
  String get helpGuideSafeBrowsingOtherBullet3 =>
      'प्रत्येकस्याः सेवायाः दैनिकी सीमा अस्ति, अद्य कति परीक्षाः उपयुक्ताः इति अनुप्रयोगः दर्शयति। अस्मिन् अनुप्रयोगे Safe Browsing प्रतिदिनं 10,000 यावत्, VirusTotal 500 यावत् अनुमन्यते।';

  @override
  String get helpGuideSafeBrowsingPrivacyTitle => 'भवतः कुञ्चिकाः सुरक्षिताः';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet1 =>
      'भवतः कुञ्चिकाः अस्यां दूरवाण्याम् Android-तन्त्रस्य सुरक्षिते ताडिते कोशे रक्ष्यन्ते, कदापि न वितीर्यन्ते।';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet2 =>
      'भवता संवीक्षितः अनुबन्धः एव सेवां प्रति प्रेष्यते। भवतः विषये अन्यत् किमपि न प्रेष्यते।';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet3 =>
      'कदापि कुञ्चिकां लोप्तुं शक्यते। ततः अनुप्रयोगः तां परीक्षां त्यजति।';

  @override
  String get helpGuideSafeBrowsingTip =>
      'सूचना: सुरक्षायै कापि कुञ्चिका न आवश्यकी। अन्तर्जालं विना अपि अनुप्रयोगस्य स्वकीयाः परीक्षाः सर्वदा प्रचलन्ति।';

  @override
  String get helpGuideSmartPayloadsName => 'कुशल-क्रियाः';

  @override
  String get helpGuideSmartPayloadsSummary =>
      'वै-फाई, धनप्रेषणम्, सम्पर्काः, कार्यक्रमाः, दूरभाषसङ्ख्याः, उत्पादाः इत्यादीनां कृते एकस्पर्श-चिह्नानि।';

  @override
  String get helpGuideSmartPayloadsIntro =>
      'सङ्केते किम् अस्ति इति अनुप्रयोगः अवगत्य उचितचिह्नैः युक्तं पत्रं दर्शयति। यथा वै-फाई-सङ्केताय संयोजन-चिह्नम्, दूरभाषसङ्ख्यायै आह्वान-चिह्नं च।';

  @override
  String get helpGuideSmartPayloadsWifiTitle => 'वै-फाई-जालम्';

  @override
  String get helpGuideSmartPayloadsWifiBullet1 =>
      'जालस्य नाम सुरक्षाप्रकारं च दर्शयति। कूटशब्दं दर्शयितुं गोपयितुं वा नेत्र-चिह्नं स्पृशतु, प्रतिलेखितुम् अपि शक्यते।';

  @override
  String get helpGuideSmartPayloadsWifiBullet2 =>
      '\"संयोज्यताम्\" इति स्पृशतु। Android स्थिरीकरणं पृच्छेत्। यदि दूरवाणी साक्षात् संयोगं न अनुमन्यते, तर्हि कूटशब्दः प्रतिलिख्यते, वै-फाई-विन्यासेषु तं स्थापयितुं शक्यते।';

  @override
  String get helpGuideSmartPayloadsPaymentsTitle => 'धनप्रेषणानि';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet1 =>
      'UPI-सङ्केताः कस्मै धनं दीयते, कियत् इति च दर्शयन्ति। पूरितविवरणैः सह भवतः UPI-अनुप्रयोगम् (Google Pay, PhonePe, Paytm, BHIM इत्यादिकम्) उद्घाटयितुं \"UPI-अनुप्रयोगेन दीयताम्\" इति स्पृशतु।';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet2 =>
      'यदि सङ्केते राशिः नास्ति, तर्हि अनुप्रयोगः प्रथमं तं लेखितुं पृच्छति।';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet3 =>
      'अयम् अनुप्रयोगः स्वयं कदापि धनं न गृह्णाति न प्रेषयति। प्रत्येकं धनप्रेषणं भवान् एव स्वकीये UPI-अनुप्रयोगे स्थिरीकरोति।';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet4 =>
      'गूढमुद्रा-कोशसङ्केताः (Bitcoin, Ethereum, Solana) SEPA-वित्तकोशप्रेषणसङ्केताः च सङ्केतम् (address) दर्शयन्ति, तत् प्रतिलेखितुं शक्यते।';

  @override
  String get helpGuideSmartPayloadsTotpTitle => 'द्विपद-प्रवेशसङ्केताः (2FA)';

  @override
  String get helpGuideSmartPayloadsTotpBullet1 =>
      'द्विपद-प्रवेशस्य सक्रियीकरणे जालस्थानानि प्रायः QR-सङ्केतं दर्शयन्ति। तस्य संवीक्षया प्रति 30 क्षणान् परिवर्तमानः षडङ्कसङ्केतः कालमापकेन सह दृश्यते।';

  @override
  String get helpGuideSmartPayloadsTotpBullet2 =>
      'Google Authenticator, Microsoft Authenticator इत्यादौ भवतः प्रमाणीकरण-अनुप्रयोगे रक्षितुं \"प्रमाणीकरणे योज्यताम्\" इति स्पृशतु।';

  @override
  String get helpGuideSmartPayloadsTotpBullet3 =>
      'एतादृशं सङ्केतं गोपनीयं रक्षतु। यः कोऽपि तं संवीक्षते, सः भवतः प्रवेशसङ्केतान् रचयितुं शक्नोति।';

  @override
  String get helpGuideSmartPayloadsContactsTitle => 'सम्पर्काः कार्यक्रमाश्च';

  @override
  String get helpGuideSmartPayloadsContactsBullet1 =>
      'सम्पर्कसङ्केताः (vCard, MeCard) नाम, दूरभाषं, विद्युत्पत्रं, संस्थां च दर्शयन्ति। \"सम्पर्केषु रक्ष्यताम्\" इति स्पृशतु, अथवा साक्षात् आह्वयतु विद्युत्पत्रं प्रेषयतु वा।';

  @override
  String get helpGuideSmartPayloadsContactsBullet2 =>
      'कार्यक्रमसङ्केताः शीर्षकं, समयं, स्थानं च दर्शयन्ति। \"दिनदर्शिकायां योज्यताम्\" इति स्पृशतु।';

  @override
  String get helpGuideSmartPayloadsOtherTitle =>
      'दूरभाषः, सन्देशः, मानचित्रम् इत्यादि';

  @override
  String get helpGuideSmartPayloadsOtherBullet1 =>
      'दूरभाषसङ्ख्या: \"आहूयताम्\" इति स्पृशतु। लघुसन्देशः: \"सन्देशः प्रेष्यताम्\" इति स्पृशतु, सन्देशः पूर्वमेव पूरितः भवति। विद्युत्पत्रम्: \"विद्युत्पत्रं प्रेष्यताम्\" इति स्पृशतु।';

  @override
  String get helpGuideSmartPayloadsOtherBullet2 =>
      'स्थानम्: स्थानं द्रष्टुं मार्गं ज्ञातुं वा \"मानचित्रे पश्यतु\" इति स्पृशतु।';

  @override
  String get helpGuideSmartPayloadsOtherBullet3 =>
      'अनुप्रयोगानुबन्धः: सम्बद्धः अनुप्रयोगः स्थापितः चेत् तम् उद्घाटयितुं \"अनुप्रयोगाभ्यन्तरे उद्घाटयतु\" इति स्पृशतु।';

  @override
  String get helpGuideSmartPayloadsOtherBullet4 =>
      'उत्पाद-रेखासङ्केतः: खाद्यविवरणं ज्ञातुं \"खाद्यविवरणम्\", अथवा \"जालेऽन्विष्यताम्\" इति स्पृशतु।';

  @override
  String get helpGuideSmartPayloadsOtherBullet5 =>
      'पुस्तक (ISBN) रेखासङ्केतः: पुस्तकं गूगल-पुस्तकेषु मुक्त-ग्रन्थालये वा अन्विष्यताम्।';

  @override
  String get helpGuideSmartPayloadsOtherBullet6 =>
      'जालानुबन्धाः सुरक्षापरीक्षणानन्तरम् एव जालगवेषके उद्घाट्यन्ते।';

  @override
  String get helpGuideSmartPayloadsTip =>
      'सूचना: UPI-सङ्केतेन धनप्रदानात् पूर्वं पत्रे नाम यस्मै आपणाय जनाय वा दातुम् इच्छति तस्य एव इति निश्चिनोतु।';

  @override
  String get helpGuideHiddenName => 'गूढाः ताडिताः च सङ्केताः';

  @override
  String get helpGuideHiddenSummary =>
      'गूढसन्देशं ताडितदत्तांशं वा वहतः QR-सङ्केतान् उद्घाटयतु।';

  @override
  String get helpGuideHiddenIntro =>
      'केचन QR-सङ्केताः कूटवाक्येन ताडितं गोपनीयदत्तांशं वहन्ति। अनुप्रयोगः तादृशान् सङ्केतान् अभिजानाति, भवतः दूरवाण्याम् एव तान् उद्घाटयितुं च साहाय्यं करोति।';

  @override
  String get helpGuideHiddenStegoTitle => 'StegoQR: गूढसन्देशयुक्तः सङ्केतः';

  @override
  String get helpGuideHiddenStegoBullet1 =>
      'StegoQR-सङ्केतः सर्वेभ्यः सामान्यं सार्वजनिकं पाठं दर्शयति, अन्तः च द्वितीयं गूढसन्देशं गोपयति।';

  @override
  String get helpGuideHiddenStegoBullet2 =>
      'तादृशस्य संवीक्षायां परिणामे \"StegoQR-विषयः प्राप्तः\" इति दृश्यते। सार्वजनिकपाठः यथापूर्वं दृश्यते।';

  @override
  String get helpGuideHiddenStegoBullet3 =>
      'गूढं द्रष्टुं कूटवाक्यं लिखित्वा \"उद्घाट्यताम्\" इति स्पृशतु। सङ्केतस्य रचयिता एव भवते कूटवाक्यं दद्यात्।';

  @override
  String get helpGuideHiddenStegoBullet4 =>
      '\"जैविक-प्रवेशः\" कूटवाक्येन सह भवतः अङ्गुलिमुद्रां मुखं वा अपि पृच्छति।';

  @override
  String get helpGuideHiddenStegoBullet5 =>
      'उद्घाटनानन्तरं गूढं प्रतिलेखितुं वितरितुं वा शक्यते।';

  @override
  String get helpGuideHiddenOtherTitle => 'अन्ये ताडितसङ्केताः';

  @override
  String get helpGuideHiddenOtherBullet1 =>
      'वायु-क्यूआर-हस्तान्तरणसङ्केताः: प्रेषिकायां दूरवाण्यां दर्शितं सत्र-सङ्केतं लिखतु।';

  @override
  String get helpGuideHiddenOtherBullet2 =>
      'गूढ-JSON-सङ्केताः अन्ये ताडितपाठाः च: \"उद्घाट्यताम्\" इति स्पृष्ट्वा कूटवाक्यं लिखतु।';

  @override
  String get helpGuideHiddenOtherBullet3 =>
      '\"विस्तृतम् (Salt / IV)\" अतिरिक्तविन्यासापेक्षिणां अन्यसाधनैः रचितानां सङ्केतानां कृते एव। बहवः जनाः कदापि तत् न अपेक्षन्ते।';

  @override
  String get helpGuideHiddenSafetyTitle => 'ज्ञातव्यम्';

  @override
  String get helpGuideHiddenSafetyBullet1 =>
      'उद्घाटनं भवतः दूरवाण्याम् एव भवति। कूटवाक्यं गूढं च कदापि कुत्रापि न प्रेष्येते।';

  @override
  String get helpGuideHiddenSafetyBullet2 =>
      'अशुद्धं कूटवाक्यं केवलं दोषं दर्शयति। वर्णविन्यासं, बृहदक्षराणि, रिक्तस्थानानि च परीक्ष्य पुनः प्रयततु।';

  @override
  String get helpGuideHiddenSafetyBullet3 =>
      'अयम् अनुप्रयोगः एतान् सङ्केतान् उद्घाटयितुं शक्नोति, किन्तु तान् न रचयति।';

  @override
  String get helpGuideHiddenTip =>
      'सूचना: कूटवाक्यं सङ्केतात् भिन्नेन मार्गेण, यथा दूरभाषाह्वानेन, वितरतु। सङ्केतस्य समीपे तत् कदापि न लिखतु।';

  @override
  String get helpGuideHistoryName => 'इतिवृत्तं, सञ्चयः, गोपनीयता च';

  @override
  String get helpGuideHistorySummary =>
      'पुरातनसंवीक्षाः अन्विष्यताम्, टिप्पणीः योज्यन्ताम्, इतिवृत्तं निर्याप्यतां सञ्चीयतां वा, अनुप्रयोगः ताड्यतां च।';

  @override
  String get helpGuideHistoryIntro =>
      'प्रत्येका संवीक्षा भवतः दूरवाण्याम् इतिवृत्त-विभागे ताडिते (गूढीकृते) कोशे रक्ष्यते। किमपि न आरोप्यते।';

  @override
  String get helpGuideHistoryManageTitle =>
      'संवीक्षाणाम् अन्वेषणं व्यवस्थापनं च';

  @override
  String get helpGuideHistoryManageBullet1 =>
      'विषयेण, प्रकारेण, टिप्पणीभिः वा संवीक्षाः अन्वेष्टुम् अन्वेषणक्षेत्रे लिखतु।';

  @override
  String get helpGuideHistoryManageBullet2 =>
      'अनुबन्धान्, वै-फाई, सम्पर्कान्, उत्पादान् इत्यादीन् एव द्रष्टुं परिशोधन-पट्टिकाः उपयुज्यन्ताम्। संवीक्षां \"तारकाङ्कितानि\" इत्यत्र योजयितुं तस्याः तारकं स्पृशतु।';

  @override
  String get helpGuideHistoryManageBullet3 =>
      'संवीक्षायाः सर्वाणि विवरणानि (पूर्णविषयः, सुरक्षाङ्कः, समयः) द्रष्टुं तां स्पृशतु। टिप्पणीं स्थानं च योजयितुं, प्रतिलेखितुं, वितरितुं, लोप्तुं वा शक्यते।';

  @override
  String get helpGuideHistoryManageBullet4 =>
      '\"सर्वं प्रमृज्यताम्\" इति सम्पूर्णम् इतिवृत्तं लुम्पति। एतत् प्रत्यावर्तयितुं न शक्यते, अतः प्रथमं सञ्चयं करोतु।';

  @override
  String get helpGuideHistoryBackupTitle => 'निर्यातः सञ्चयश्च';

  @override
  String get helpGuideHistoryBackupBullet1 =>
      'इतिवृत्त-विभागस्य उपरि \"निर्यातः / सञ्चयः\" इति चिह्नं स्पृशतु।';

  @override
  String get helpGuideHistoryBackupBullet2 =>
      '\"अभिलेखान् निर्यापयतु\" इति प्रतिलिपिं CSV (Excel, Sheets इत्येतयोः कृते), JSON, पाठ, PDF इति रूपेषु रक्षति। एताः सञ्चिकाः अताडिताः: सञ्चिकां प्राप्तः कोऽपि भवतः संवीक्षाः पठितुं शक्नोति, अतः अनुप्रयोगः प्रथमं पृच्छति।';

  @override
  String get helpGuideHistoryBackupBullet3 =>
      'प्रतिलिपिरक्षणस्य सुरक्षितः मार्गः \"गूढ-सञ्चयः\"। कूटवाक्यं लिखित्वा \"सञ्चयः निर्मीयताम्\" इति स्पृशतु, ततः सञ्चिकां रक्षतु वितरतु वा।';

  @override
  String get helpGuideHistoryBackupBullet4 =>
      'पुनःस्थापनाय \"सञ्चयं पुनःस्थापयतु\" इति उद्घाट्य सञ्चयसञ्चिकायाः पाठं स्थापयित्वा तदेव कूटवाक्यं लिखित्वा \"इतिवृत्तं पुनःस्थाप्यताम्\" इति स्पृशतु।';

  @override
  String get helpGuideHistoryBiometricsTitle =>
      'अनुप्रयोग-तालकं पटलचित्र-रक्षणं च';

  @override
  String get helpGuideHistoryBiometricsBullet1 =>
      'अनुप्रयोग-तालकम्: विन्यासाः > गोपनीयता जालपरीक्षणं च इत्यत्र सक्रियं करोतु। ततः उद्घाटने, 30 क्षणानां अनुपस्थितेः अनन्तरं च अनुप्रयोगः अङ्गुलिमुद्रां, मुखं, पटल-तालकं वा पृच्छति।';

  @override
  String get helpGuideHistoryBiometricsBullet2 =>
      'पटलचित्र-रक्षणम्: संवीक्षाः, इतिवृत्तं, गूढानि, कुञ्चिकाः वा दर्शयत्सु पटलेषु पटलचित्रं पटलध्वनिमुद्रणं च निवारयति। अद्यतनानुप्रयोगावल्याम् एते पटलाः रिक्ताः दृश्यन्ते। विन्यासाः > गोपनीयता जालपरीक्षणं च इत्यत्र सक्रियं निष्क्रियं वा करोतु।';

  @override
  String get helpGuideHistoryBiometricsBullet3 =>
      'इतिवृत्तं नूतनदूरवाणीं नेतुं \"एयर्-क्यु-आर् तुल्यकालनम्\" उपयुज्यताम्। वायु-क्यूआर-मार्गदर्शिकां पश्यतु।';

  @override
  String get helpGuideHistoryTip =>
      'सूचना: दूरवाण्याः पुनःसज्जीकरणात् परिवर्तनात् वा पूर्वं गूढ-सञ्चयं करोतु। कूटवाक्यं सुरक्षितस्थाने रक्षतु, तेन विना सञ्चयः उद्घाटयितुं न शक्यते।';

  @override
  String get helpGuideSettingsName => 'विन्यासाः स्वरुचिश्च';

  @override
  String get helpGuideSettingsSummary =>
      'रूपं, भाषां, ध्वनिं च परिवर्तयतु, अनुमतीः पश्यतु, विद्युत्कोशं रक्षतु, स्वदत्तांशं लुम्पतु च।';

  @override
  String get helpGuideSettingsIntro =>
      'विन्यासान् उद्घाटयितुं संवीक्षा-पटले \"अधिकविकल्पाः\" स्पृष्ट्वा \"विन्यासाः\" इति चिनोतु। प्रत्येकः भागः किं करोति इति अधः।';

  @override
  String get helpGuideSettingsLookTitle => 'रूपं भाषा च';

  @override
  String get helpGuideSettingsLookBullet1 =>
      'दृश्यरूपम् > रूपविधा: तन्त्रम्, प्रकाशः, तिमिरम्, कृष्णम् (OLED) वा। OLED पूर्णकृष्णं, OLED-पटलेषु विद्युत्कोशं च रक्षति।';

  @override
  String get helpGuideSettingsLookBullet2 =>
      'प्रधानवर्णाः गतिकवर्णाश्च: प्रधानवर्णं चिनोतु, अथवा भित्तिचित्रानुरूपाय गतिकवर्णान् सक्रियान् करोतु (Android 12 तथा नूतनतराणि)।';

  @override
  String get helpGuideSettingsLookBullet3 =>
      'अक्षरशैली परिमाणं च: अक्षरशैलीं चिनोतु। दूरवाण्यां भवता स्थापितम् अक्षरपरिमाणम् अनुप्रयोगः अनुसरति।';

  @override
  String get helpGuideSettingsLookBullet4 =>
      'अन्वीक्षणसंस्तरशैली: संवीक्षा-परिधिः कथं दृश्येत इति चिनोतु।';

  @override
  String get helpGuideSettingsLookBullet5 =>
      'भाषा: तन्त्रमानकम्, English, मलयालम् (മലയാളം), संस्कृतम् वा चिनोतु। पुनरारम्भं विना अनुप्रयोगः सद्यः परिवर्तते।';

  @override
  String get helpGuideSettingsFeedbackTitle => 'संवीक्षा-प्रतिसादः';

  @override
  String get helpGuideSettingsFeedbackBullet1 =>
      'सङ्केतपठने दूरवाणी कम्पेत वा, ध्वनिं कुर्यात् वा, लघुसञ्चलनं दर्शयेत् वा इति चिनोतु।';

  @override
  String get helpGuideSettingsPrivacyTitle => 'गोपनीयता जालपरीक्षणं च';

  @override
  String get helpGuideSettingsPrivacyBullet1 =>
      'सक्रियजालपरीक्षणम्: भवता सक्रियीकरणं विना निष्क्रियम्। अनुबन्ध-सुरक्षा-मार्गदर्शिकां पश्यतु।';

  @override
  String get helpGuideSettingsPrivacyBullet2 =>
      'अनुप्रयोग-तालकं पटलचित्र-रक्षणं च: इतिवृत्त-सञ्चय-गोपनीयता-मार्गदर्शिकां पश्यतु।';

  @override
  String get helpGuideSettingsPrivacyBullet3 =>
      'सर्वदत्तांशलोपः: संवीक्षेतिवृत्तं, रक्षिताः कुञ्चिकाः, सर्वान् विन्यासान् च अस्याः दूरवाण्याः अपनयति। एतत् प्रत्यावर्तयितुं न शक्यते।';

  @override
  String get helpGuideSettingsOtherTitle => 'अन्ये विन्यासाः';

  @override
  String get helpGuideSettingsOtherBullet1 =>
      'URL-सुरक्षा-दाताः: अतिरिक्तान् संयुक्त-अनुबन्धपरीक्षकान् सक्रियान् करोतु।';

  @override
  String get helpGuideSettingsOtherBullet2 =>
      'एयर्-क्यु-आर् तुल्यकालनम्: इतिवृत्तं विन्यासान् च अन्यां दूरवाणीं नयतु।';

  @override
  String get helpGuideSettingsOtherBullet3 =>
      'वीक्षण-बुद्बुदः: अन्यानुप्रयोगेषु सङ्केतान् संवीक्षितुं प्लवमानं चिह्नम्।';

  @override
  String get helpGuideSettingsOtherBullet4 =>
      'अनुमतयः: अनुप्रयोगः किं किम् उपयोक्तुं शक्नोति, किमर्थं च इति सरला आवली। वैशिष्ट्यस्य आवश्यकतायाम् एव अनुप्रयोगः प्रत्येकां पृच्छति।';

  @override
  String get helpGuideSettingsOtherBullet5 =>
      '\"वैशिष्ट्यानि\" अनुप्रयोगस्य सर्वाणि कार्याणि दर्शयति। \"स्वागत-परिचय-प्रवासः\" प्रथमारम्भस्य परिचयं पुनः दर्शयति। \"विषये\" अनुप्रयोगस्य संस्करणम् अनुज्ञाः च दर्शयति।';

  @override
  String get helpGuideSettingsBatteryTitle => 'विद्युत्कोशरक्षणम्';

  @override
  String get helpGuideSettingsBatteryBullet1 =>
      'संवीक्षा-पटलात् अनुप्रयोगात् वा निर्गमनमात्रेण चित्रग्राही निष्क्रियः भवति।';

  @override
  String get helpGuideSettingsBatteryBullet2 =>
      'अल्पशक्त्युपयोगाय चित्रग्राहीसंस्कारेषु 720p चिनोतु।';

  @override
  String get helpGuideSettingsBatteryBullet3 =>
      'अनावश्यके सति वीक्षण-बुद्बुदं निष्क्रियं करोतु।';

  @override
  String get helpGuideSettingsBatteryBullet4 =>
      'OLED-पटलयुक्तासु दूरवाणीषु OLED-रूपविधिम् उपयुङ्क्ताम्।';

  @override
  String get helpGuideSettingsTip =>
      'सूचना: किञ्चित् कुत्र अस्ति इति न निश्चितम्? अत्र प्रत्येका मार्गदर्शिका स्पर्शनीयस्य चिह्नस्य नाम वदति।';

  @override
  String get helpGuideFaqName => 'प्रायिकप्रश्नाः समस्याश्च';

  @override
  String get helpGuideFaqSummary =>
      'सामान्यप्रश्नानाम् उत्तराणि, किञ्चित् न प्रचलति चेत् समाधानानि च।';

  @override
  String get helpGuideFaqIntro =>
      'सामान्यप्रश्नानां सङ्क्षिप्तानि उत्तराणि, किञ्चित् न प्रचलति चेत् किं करणीयम् इति च।';

  @override
  String get helpGuideFaqQuestionsTitle => 'सामान्यप्रश्नाः';

  @override
  String get helpGuideFaqQuestion1 =>
      'अन्तर्जालं विना अनुप्रयोगः प्रचलति वा?\nआम्। सङ्केतपठनं, प्रथमाः चतस्रः अनुबन्धपरीक्षाः, क्विशिंग-रक्षकः च सर्वं असंयुक्तम् अपि प्रचलति। वैकल्पिकाः संयुक्तपरीक्षाः एव अन्तर्जालम् अपेक्षन्ते।';

  @override
  String get helpGuideFaqQuestion2 =>
      'मम चित्रग्राहि-दृश्यानि कुत्रापि प्रेष्यन्ते वा?\nन। दृश्यानि भवतः दूरवाण्याम् एव पठ्यन्ते, कदापि न रक्ष्यन्ते न आरोप्यन्ते।';

  @override
  String get helpGuideFaqQuestion3 =>
      'अनुप्रयोगः मम विषये दत्तांशं सङ्गृह्णाति वा?\nन। न विज्ञापनानि, न अनुसरणं, न विश्लेषणम्। भवतः इतिवृत्तं भवतः दूरवाण्याम् एव तिष्ठति।';

  @override
  String get helpGuideFaqQuestion4 =>
      'अनुप्रयोगः किमर्थम् अनुमतिं पृच्छति?\nतदपेक्षिणः वैशिष्ट्यस्य उपयोगे एव, यथा संवीक्षायै चित्रग्राही। पूर्णावल्यै विन्यासाः > अनुमतयः इति पश्यतु।';

  @override
  String get helpGuideFaqQuestion5 =>
      'भाषां कथं परिवर्तयामि?\nविन्यासाः > भाषा इति गच्छतु। अनुप्रयोगः सद्यः परिवर्तते।';

  @override
  String get helpGuideFaqQuestion6 =>
      'सर्वं कथं लुम्पामि?\nविन्यासाः > गोपनीयता जालपरीक्षणं च > सर्वदत्तांशलोपः इति गच्छतु। इतिवृत्ते एकैकां संवीक्षाम् अपि लोप्तुं शक्यते।';

  @override
  String get helpGuideFaqQuestion7 =>
      'मया विश्वस्तः अनुबन्धः असुरक्षितः इति दर्शितः। किमर्थम्?\nपरीक्षाः सावधानलक्षणानि अन्विष्यन्ति, केषुचित् यथार्थस्थानेषु अपि तानि भवन्ति। स्रोतसि निश्चयः अस्ति चेत् तथापि उद्घाटयितुं शक्यते।';

  @override
  String get helpGuideFaqQuestion8 =>
      'अनुप्रयोगः बहु विद्युत्कोशशक्तिम् उपयुङ्क्ते वा?\nन। संवीक्षा-पटलत्यागमात्रेण चित्रग्राही विरमति। अधिकविद्युत्कोशसूचनाभ्यः विन्यास-मार्गदर्शिकां पश्यतु।';

  @override
  String get helpGuideFaqCameraTitle => 'यदि सङ्केतः न संवीक्ष्यते';

  @override
  String get helpGuideFaqCameraBullet1 =>
      'चित्रग्राहि-काचं शोधयित्वा दूरवाणीं सङ्केतात् प्रायः 15 तः 20 से.मी. (6 तः 8 अङ्गुलयः) दूरे धारयतु।';

  @override
  String get helpGuideFaqCameraBullet2 =>
      'अन्धकारमये स्थाने दीपं सक्रियं करोतु। दीप्यमानसङ्केते प्रतिफलननिवारणाय दूरवाणीं किञ्चित् नमयतु।';

  @override
  String get helpGuideFaqCameraBullet3 =>
      'लघोः दूरस्थस्य वा सङ्केतस्य कृते अतिसमीपगमनस्य स्थाने आवर्धन-सर्पकः \"दूरस्थवीक्षणसहायः\" वा उपयुज्यताम्।';

  @override
  String get helpGuideFaqCameraBullet4 =>
      'कृष्णपृष्ठभूमौ शुक्लसङ्केतस्य कृते चित्रग्राहीसंस्कारेषु \"वर्णव्युत्क्रमः\" सक्रियं करोतु।';

  @override
  String get helpGuideFaqCameraBullet5 =>
      'क्षतस्य मलिनस्य वा सङ्केतस्य कृते चित्रग्राहीसंस्कारेषु द्युतिं वैषम्यं च प्रयततु, अथवा चित्रं गृहीत्वा वीथिकातः संवीक्षताम्।';

  @override
  String get helpGuideFaqFixTitle => 'अन्याः समस्याः';

  @override
  String get helpGuideFaqFixBullet1 =>
      'चित्रग्राही न उद्घाट्यते: यदि चित्रग्राहिणे अनुमतिः निषिद्धा, तर्हि Android-विन्यासाः > अनुप्रयोगाः > SreerajP QR Studio > अनुमतयः > चित्रग्राही इति गत्वा \"अनुमन्यताम्\" इति चिनोतु।';

  @override
  String get helpGuideFaqFixBullet2 =>
      'वै-फाई न संयुज्यते: कूटशब्दं प्रतिलिख्य दूरवाण्याः वै-फाई-विन्यासेषु जालं प्रविशतु।';

  @override
  String get helpGuideFaqFixBullet3 =>
      'धनप्रेषण-अनुप्रयोगः न उद्घाट्यते: UPI-अनुप्रयोगः स्थापितः इति निश्चिनोतु। UPI-परिचयम् अपि प्रतिलेखितुं शक्यते।';

  @override
  String get helpGuideFaqFixBullet4 =>
      'वीक्षण-बुद्बुदः पुनः पुनः अन्तर्धीयते: काश्चन दूरवाण्यः पृष्ठभूमौ अनुप्रयोगान् विरमयन्ति। दूरवाण्याः विद्युत्कोश-विन्यासेषु अस्मै अनुप्रयोगाय अनुमतिं ददातु।';

  @override
  String get helpGuideFaqFixBullet5 =>
      'संयुक्तपरीक्षा त्यक्ता इति दृश्यते: सः परीक्षकः निष्क्रियः, अथवा कुञ्चिका नास्ति। समाधानाय परिणामे \"विन्यासेषु सज्जीकरोतु\" इति स्पृशतु।';

  @override
  String get helpGuideFaqTip =>
      'सूचना: अद्यापि समस्या? सङ्केतस्य स्पष्टं चित्रं गृहीत्वा वीथिकातः संवीक्षताम्।';

  @override
  String get titleHelpBarcode => 'सङ्केत-संवीक्षा';

  @override
  String get titleHelpArCodeVision => 'ए-आर् दृष्टिः';

  @override
  String get titleHelpAirQr => 'वायु-क्यूआर-मार्गदर्शिका';

  @override
  String get titleHelpUrlSafety => 'अनुबन्ध-सुरक्षा';

  @override
  String get titleHelpQuishing => 'क्विशिंग-रक्षकः';

  @override
  String get titleHelpSafeBrowsing => 'संयुक्तपरीक्षकाः';

  @override
  String get titleHelpSmartPayloads => 'कुशल-क्रियाः';

  @override
  String get titleHelpHistory => 'इतिवृत्तं गोपनीयता च';

  @override
  String get titleHelpFaq => 'प्रायिकप्रश्नाः';

  @override
  String get titleHelpScanBubble => 'अन्यानुप्रयोगेभ्यः';

  @override
  String get titleHelpCodeForge => 'सङ्केतनिर्माणम्';

  @override
  String get titleHelpHiddenCodes => 'ताडितसङ्केताः';

  @override
  String get titleHelpSettings => 'विन्यास-मार्गदर्शिका';

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
  String get labelScreenshotGuard => 'पटलचित्र-रक्षणम्';

  @override
  String get descScreenshotGuard =>
      'संवीक्षाः, इतिवृत्तम्, गुप्तविषयाः, API-कुञ्चिकाः च यत्र दृश्यन्ते, तेषु पटलेषु पटलचित्रं पटल-अभिलेखनं च निवारयतु। अद्यतन-अनुप्रयोग-सूच्याम् अपि एतानि पटलानि रिक्तानि दृश्यन्ते।';

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
