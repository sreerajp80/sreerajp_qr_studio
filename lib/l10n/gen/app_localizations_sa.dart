// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Sanskrit (`sa`).
class AppLocalizationsSa extends AppLocalizations {
  AppLocalizationsSa([String locale = 'sa']) : super(locale);

  @override
  String get appTitle => 'श्रीराज् पि क्यू-आर-कार्यशाला';

  @override
  String get wifiCardTitle => 'वै-फाई संजालम्';

  @override
  String get wifiShowPassword => 'कूटशब्दः दृश्यताम्';

  @override
  String get wifiHidePassword => 'कूटशब्दः गोप्यताम्';

  @override
  String get wifiCopyPassword => 'कूटशब्दः प्रतिलिख्यताम्';

  @override
  String get wifiConnectButton => 'संयोज्यताम्';

  @override
  String get wifiPasswordCopied => 'कूटशब्दः फलके प्रतिलेखितः';

  @override
  String get wifiOpenSettingsHint =>
      'कूटशब्दः प्रतिलेखितः। संयोजनाय विन्यासः उद्घाट्यताम्।';

  @override
  String wifiConnectSuccess(String ssid) {
    return '$ssid संजालाय संयोजनानुरोधः प्रेषितः।';
  }

  @override
  String geoLatLng(String latitude, String longitude) {
    return 'अक्षांशः: $latitude, रेखांशः: $longitude';
  }

  @override
  String geoQuery(String query) {
    return 'अन्वेषणम्: $query';
  }

  @override
  String get geoNavigateButton => 'मानचित्रे पश्यतु';

  @override
  String get geoLaunchFailed => 'मानचित्र-अनुप्रयोगः न उद्घाटितः';

  @override
  String get calendarCardTitle => 'दिनदर्शिका-घटना';

  @override
  String get calendarNoDate => 'अनुपलब्धम्';

  @override
  String calendarStart(String dateTime) {
    return 'प्रारम्भः: $dateTime';
  }

  @override
  String calendarEnd(String dateTime) {
    return 'समाप्तिः: $dateTime';
  }

  @override
  String get calendarAddButton => 'दिनदर्शिकायां योज्यताम्';

  @override
  String get calendarLaunchFailed => 'दिनदर्शिका-अनुप्रयोगः न उद्घाटितः';

  @override
  String get contactCardTitle => 'सम्पर्कपत्रम्';

  @override
  String get contactInitialFallback => 'स';

  @override
  String get contactSaveButton => 'सम्पर्केषु रक्ष्यताम्';

  @override
  String get contactLaunchFailed => 'सम्पर्क-अनुप्रयोगः न उद्घाटितः';

  @override
  String contactCallFailed(String number) {
    return '$number अङ्के आह्वानं न जातम्';
  }

  @override
  String contactEmailFailed(String email) {
    return '$email सङ्केताय विद्युत्पत्रं न उद्घाटितम्';
  }

  @override
  String pdfResultsTitle(int count) {
    return 'पि-डि-एफ् संवीक्षा-फलानि ($count)';
  }

  @override
  String pdfPageBadge(int page) {
    return 'पृ $page';
  }

  @override
  String pdfPageLabel(int page) {
    return 'पृष्ठम् $page';
  }

  @override
  String pdfSaveAllButton(int count) {
    return 'सर्वाणि इतिहासे रक्ष्यताम् ($count)';
  }

  @override
  String pdfScanNote(int page) {
    return 'पि-डि-एफ् सञ्चिकातः संवीक्षितम् (पृष्ठम् $page)';
  }

  @override
  String pdfSavedToHistory(int count) {
    return '$count सङ्केताः इतिहासे रक्षिताः।';
  }

  @override
  String get totpDefaultIssuer => 'द्विघटक-प्रमाणीकरणम्';

  @override
  String totpLivePasscode(int period) {
    return 'प्रत्यक्ष-सङ्केतः ($periodपलं TOTP)';
  }

  @override
  String totpSecondsLeft(int seconds) {
    return '$secondsपलानि';
  }

  @override
  String get totpCopyToken => 'टोकनं प्रतिलिख्यताम्';

  @override
  String get totpSecretLabel => 'गूढ-कुञ्चिका: ';

  @override
  String get totpImportButton => 'प्रमाणीकरणे योज्यताम्';

  @override
  String get totpLaunchFailed => 'प्रमाणीकरण-अनुप्रयोगः न उद्घाटितः';

  @override
  String get totpTokenCopied => 'टोकनं फलके प्रतिलेखितम्';

  @override
  String get totpSecretCopied => 'गूढ-कुञ्चिका फलके प्रतिलेखिता';

  @override
  String get paymentSchemeUpi => 'यु-पि-आई धनप्रेषणम्';

  @override
  String get paymentSchemeSepa => 'सेपा प्रेषणम्';

  @override
  String get paymentSchemeCrypto => 'क्रिप्टो धनप्रेषणम्';

  @override
  String get paymentPayeeFallback => 'प्राप्तिकर्ता';

  @override
  String get paymentAddressLabelUpi => 'यु-पि-आई अभिज्ञानम्:';

  @override
  String get paymentAddressLabelSepa => 'आई-बान् (IBAN):';

  @override
  String get paymentAddressLabelCrypto => 'कोश-सङ्केतः:';

  @override
  String get paymentCopyAction => 'प्रतिलिख्यताम्';

  @override
  String get paymentUpiIdCopied => 'यु-पि-आई अभिज्ञानं फलके प्रतिलेखितम्';

  @override
  String get paymentAddressCopied => 'सङ्केतः फलके प्रतिलेखितः';

  @override
  String paymentNote(String note) {
    return 'सूचना: $note';
  }

  @override
  String get paymentPayButtonUpi =>
      'अनुप्रयोगेन दीयताम् (GPay / PhonePe / Paytm)';

  @override
  String get paymentPayButton => 'अनुप्रयोगेन दीयताम्';

  @override
  String get paymentUpiLaunchFailed => 'यु-पि-आई अनुप्रयोगः न उद्घाटितः।';

  @override
  String get paymentLaunchFailed => 'धनप्रेषण-अनुप्रयोगः न उद्घाटितः।';

  @override
  String get paymentCopyIdAction => 'अभिज्ञानं प्रतिलिख्यताम्';

  @override
  String get paymentAmountDialogTitle => 'धनराशिः लिख्यताम्';

  @override
  String paymentAmountDialogBody(String payee) {
    return 'अस्मिन् QR-सङ्केते धनराशिः नास्ति। $payee इत्यस्मै देया धनराशिः लिख्यताम्।';
  }

  @override
  String get paymentAmountFieldLabel => 'धनराशिः';

  @override
  String get paymentAmountInvalid => '₹1 अथवा अधिकं लिख्यताम्';

  @override
  String get paymentAmountPayButton => 'दीयताम्';

  @override
  String percentValue(String value) {
    return '$value%';
  }

  @override
  String get quishingGuardTitle => 'क्विशिंग-रक्षकः™';

  @override
  String get quishingTamperBadge => 'भौतिक-विकृति-ज्ञानम्';

  @override
  String get quishingRiskScoreLabel => 'विकृति-सम्भावना-मानाङ्कः:';

  @override
  String get quishingViewSignals => 'सूक्ष्म-विश्लेषणं दृश्यताम्';

  @override
  String get quishingHideSignals => 'संकेताः गोप्यन्ताम्';

  @override
  String get quishingMetricEdgeLabel => 'धार-विच्छेदः';

  @override
  String get quishingMetricEdgeDescription => 'द्विगुण-धाराः छाया-रेखाः च';

  @override
  String get quishingMetricGrainLabel => 'मुद्रण-कणाः DPI च';

  @override
  String get quishingMetricGrainDescription => 'बिन्दु-घनत्वं वर्ण-ध्वनिः च';

  @override
  String get quishingSignalsHeading => 'दृष्टाः सङ्गणक-दृष्टि-संकेताः:';

  @override
  String get arCloseSheet => 'पिधीयताम्';

  @override
  String arItemPriceTag(String price) {
    return 'मूल्य-पत्रम्: $price';
  }

  @override
  String get arContentCopied => 'विषयः फलके प्रतिलेखितः';

  @override
  String get arCopyButton => 'प्रतिलिख्यताम्';

  @override
  String get arOpenUrlButton => 'सङ्केतः उद्घाट्यताम्';

  @override
  String get arSelectButton => 'चीयताम्';

  @override
  String get arDeselectButton => 'त्यज्यताम्';

  @override
  String get arSafetyStatusSafe => 'सुरक्षा-स्थितिः: सुरक्षिता';

  @override
  String get arSafetyStatusWarning =>
      'सुरक्षा-स्थितिः: पूर्वसूचना / कपट-सम्भावना';

  @override
  String get arSafetyStatusUnknown => 'सुरक्षा-स्थितिः: परीक्षणं क्रियते...';

  @override
  String get copiedToClipboard => 'फलके प्रतिलिखितम्';

  @override
  String historyTimestamp(String date, String time) {
    return '$date • $time';
  }

  @override
  String get historyStar => 'तारकम् योज्यताम्';

  @override
  String get historyUnstar => 'तारकम् अपनीयताम्';

  @override
  String get historyEditNotes => 'टिप्पणी संशोध्यताम्';

  @override
  String get historyCopyString => 'वाक्यं प्रतिलिख्यताम्';

  @override
  String get historyShare => 'विभज्यताम्';

  @override
  String get historyDelete => 'लुप्यताम्';

  @override
  String get historyDetailTitle => 'संवीक्षा-विवरणम्';

  @override
  String historySafetyBadge(int score) {
    return '🛡️ $score% सुरक्षितम्';
  }

  @override
  String historyScoreBadge(int score) {
    return '🛡️ $score%';
  }

  @override
  String get historyScannedContent => 'संवीक्षित-विषयः:';

  @override
  String get historyCopyButton => 'प्रतिलिख्यताम्';

  @override
  String get historyNotesLabel => 'स्वनिर्मिता टिप्पणी';

  @override
  String get historyNotesHint => 'अत्र स्वटिप्पणीं लिखन्तु...';

  @override
  String get historyLocationLabel => 'स्थान-चिह्नम् (ऐच्छिकम्)';

  @override
  String get historyLocationHint => 'यथा कार्यक्षेत्रम्, आपणम्';

  @override
  String get historySaveChanges => 'परिवर्तनानि रक्ष्यन्ताम्';

  @override
  String get closeButton => 'पिदधातु';

  @override
  String get exportDialogTitle => 'निर्यातः सञ्चयश्च';

  @override
  String get restoreDialogTitle => 'गूढ-सञ्चयः पुनःस्थाप्यताम्';

  @override
  String get exportRecordsTab => 'अभिलेखान् निर्यापयतु';

  @override
  String get restoreBackupTab => 'सञ्चयं पुनःस्थापयतु';

  @override
  String get exportFormatHeading => 'निर्यात-प्रकारं वृणुताम्:';

  @override
  String get exportCsvTitle => 'CSV प्रकारः (.csv)';

  @override
  String get exportCsvSubtitle => 'Excel, Sheets अनुगुणम्';

  @override
  String get exportJsonTitle => 'JSON दत्तांशः (.json)';

  @override
  String get exportJsonSubtitle => 'सङ्गणक-प्रकारः';

  @override
  String get exportTxtTitle => 'TXT विवरणम् (.txt)';

  @override
  String get exportTxtSubtitle => 'सरल-वाच्य-पत्रम्';

  @override
  String get exportPdfTitle => 'PDF विवरणम् (.pdf)';

  @override
  String get exportPdfSubtitle => 'मुद्रण-योग्यं पत्रम्';

  @override
  String get exportBackupHeading => 'गूढ-सञ्चय-सञ्चिका (.sreerajqr)';

  @override
  String get exportPassphraseLabel => 'सञ्चयस्य कूटवाक्यम्';

  @override
  String get exportPassphraseHint => 'कूटवाक्यं लिखन्तु...';

  @override
  String get exportPassphraseRequired =>
      'सञ्चय-रक्षणाय कूटवाक्यम् आवश्यकमस्ति।';

  @override
  String get exportCreateBackupButton => 'गूढ-सञ्चय-सञ्चिका निर्मीयताम्';

  @override
  String get exportShareText => 'श्रीराज्-क्यू-आर-संवीक्षा-इतिहास-निर्यातः';

  @override
  String get exportSharePdfText =>
      'श्रीराज्-क्यू-आर-संवीक्षा-इतिहास-पत्रम् (PDF)';

  @override
  String get exportShareBackupText => 'श्रीराज्-क्यू-आर-गूढ-सञ्चय-सञ्चिका';

  @override
  String get restoreHeading => 'गूढ-सञ्चयात् इतिहासः पुनःस्थाप्यताम्:';

  @override
  String get restorePassphraseLabel => 'सञ्चय-कूटवाक्यम्';

  @override
  String get restorePayloadLabel => 'सञ्चय-विषयः (.sreerajqr)';

  @override
  String get restorePayloadHint => 'अत्र सञ्चय-JSON लिखन्तु...';

  @override
  String get restoreFieldsRequired => 'कूटवाक्यं सञ्चय-विषयश्च दातव्यौ।';

  @override
  String get restoreButton => 'उद्घाट्य पुनःस्थाप्यताम्';

  @override
  String restoreSuccess(int count) {
    return '$count संवीक्षा-अभिलेखानि सफलतया पुनःस्थापितानि!';
  }

  @override
  String restoreFailed(String reason) {
    return 'पुनःस्थापनं विफलम्: $reason';
  }

  @override
  String get domSandboxedBadge => 'सुरक्षित-कक्षे';

  @override
  String get domTitleInitialFallback => 'जा';

  @override
  String get domUntitledPage => 'अनाम-जालपृष्ठम्';

  @override
  String get domThumbnailCaption => 'दृश्य-पूर्वदर्शनम् (आज्ञावलिः निरुद्धा)';

  @override
  String domBlockedBadge(int scripts, int trackers) {
    return 'निरुद्धाः: $scripts आज्ञावलयः, $trackers अनुवेधकाः';
  }

  @override
  String domNewlyRegistered(int days) {
    return 'नूतनं पञ्जीकृतम् ($daysदिनानि)';
  }

  @override
  String domDomainAge(int days) {
    return 'क्षेत्र-आयुः: $days दिनानि';
  }

  @override
  String get domOpenRedirectFound => 'अनावृत-पुनर्निर्देशन-पाशः!';

  @override
  String get domNoOpenRedirect => 'न कोऽपि पुनर्निर्देशन-दोषः';

  @override
  String get domInspectButton => 'कक्षा-संरचना परीक्ष्यताम्';

  @override
  String get domInspectTitle => 'विश्वस्त-कक्षा-संरचना';

  @override
  String get domDetailPageTitle => 'पृष्ठ-शीर्षकम्';

  @override
  String get domDetailNotSpecified => 'न निर्दिष्टम्';

  @override
  String get domDetailMetaDescription => 'मूल-विवरणम्';

  @override
  String get domDetailNoneFound => 'न किमपि प्राप्तम्';

  @override
  String get domDetailHeadingsCount => 'शीर्षक-सङ्ख्या';

  @override
  String domDetailHeadingsValue(int count) {
    return '$count शीर्षकाणि निष्कासितानि';
  }

  @override
  String get domDetailLinksFound => 'प्राप्ताः सेतवः';

  @override
  String domDetailLinksValue(int count) {
    return '$count सङ्केताः निष्कासिताः';
  }

  @override
  String get domDetailBlockedScripts => 'निरुद्धाः आज्ञावलयः';

  @override
  String domDetailBlockedScriptsValue(int count) {
    return '$count आज्ञावलयः विलोपिताः';
  }

  @override
  String get domDetailBlockedTrackers => 'निरुद्धाः अनुवेधकाः';

  @override
  String domDetailBlockedTrackersValue(int count) {
    return '$count अनुवेधकाः विलोपिताः';
  }

  @override
  String get domDetailBlockedIframes => 'निरुद्धाः अन्तःपत्राणि';

  @override
  String domDetailBlockedIframesValue(int count) {
    return '$count अन्तःपत्राणि विलोपितानि';
  }

  @override
  String get domSanitizedSnippetHeading => 'शुद्ध-HTML पूर्वदर्शनम्:';

  @override
  String get aboutTitle => 'विषये';

  @override
  String aboutVersion(String version, String build) {
    return 'संस्करणम् $version+$build';
  }

  @override
  String get aboutBuildDate => 'निर्माणदिनाङ्कः';

  @override
  String get aboutOpenSourceLicenses => 'मुक्तस्रोत-अनुज्ञाः';

  @override
  String get aboutOpenSourceLicensesDetail =>
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
  String get aboutMadeWithLove => 'Made with ❤️ from India';

  @override
  String get airQrTransmitterTitle => 'वायु-क्यूआर प्रसारकः';

  @override
  String get airQrSamplePayload =>
      'वायु-क्यूआर शीघ्र-प्रकाश-हस्तान्तरण-परीक्षण-विषयः।';

  @override
  String get airQrPayloadLabel => 'प्रसारणीयः विषयः';

  @override
  String get airQrPayloadHint => 'लेखं सन्देशं वा लिखन्तु...';

  @override
  String get airQrStreamSpeed => 'प्रसारण-गतिः:';

  @override
  String airQrFps(int fps) {
    return '$fps FPS';
  }

  @override
  String get airQrStartStream => 'प्रकाश-प्रसारणं प्रारभ्यताम्';

  @override
  String get airQrStopStream => 'प्रकाश-प्रसारणं स्थग्यताम्';

  @override
  String airQrFrameParity(int current, int total) {
    return 'चित्रम् $current/$total [समता]';
  }

  @override
  String airQrFrameBlock(int current, int total, int block) {
    return 'चित्रम् $current/$total [खण्डः $block]';
  }

  @override
  String airQrTotalFrames(int total, int source, int parity) {
    return 'कुल-चित्राणि: $total ($source मूलानि + $parity समता)';
  }

  @override
  String get toggleFlashlight => 'प्रकाशदीपं परिवर्तयतु';

  @override
  String get grantCameraPermission => 'चित्रग्राह्यनुमतिं ददातु';

  @override
  String get arScreenTitle => 'AR संवीक्षा-फलकम्';

  @override
  String get arInitializing => 'AR फलकम् आरभ्यते...';

  @override
  String get arClearSelection => 'प्रमृज्यताम्';

  @override
  String get arBatchCopy => 'एकत्र प्रतिलिख्यताम्';

  @override
  String arBatchCopied(int count) {
    return '$count दण्डलेखाः फलके प्रतिलेखिताः';
  }

  @override
  String get arCameraPermissionMessage =>
      'AR संवीक्षणाय छायाचित्रक-अनुमतिः आवश्यकी';

  @override
  String get doneButton => 'कृतम्';

  @override
  String get airQrReceiverTitle => 'वायु-क्यूआर ग्राहकः';

  @override
  String get airQrTransmitterTooltip => 'वायु-क्यूआर प्रसारकः';

  @override
  String get airQrResetStream => 'पुनःस्थाप्यताम्';

  @override
  String get airQrInitializing => 'वायु-क्यूआर ग्राहकः आरभ्यते...';

  @override
  String get airQrStatusReassembled => 'विषयः पुनः संयोजितः';

  @override
  String get airQrStatusCapturing => 'प्रकाश-प्रवाहः गृह्यते...';

  @override
  String get airQrStatusIdle => 'चल-क्यूआर प्रति पश्यतु';

  @override
  String airQrCaptured(int received, int total) {
    return 'सङ्गृहीतम्: $received / $total खण्डाः';
  }

  @override
  String airQrMissing(int count) {
    return 'अवशिष्टम्: $count';
  }

  @override
  String get airQrTransferComplete => 'हस्तान्तरणं सम्पूर्णम्!';

  @override
  String get airQrTransferCompleteDetail =>
      'दत्तांशः पुनः संयोजितः प्रमाणितश्च।';

  @override
  String get airQrPayloadCopied => 'विषयः फलके प्रतिलेखितः';

  @override
  String get cancelButton => 'निरस्यतु';

  @override
  String get historyScreenTitle => 'संवीक्षा-इतिहासः';

  @override
  String get historyExportTooltip => 'निर्यातः / सञ्चयः';

  @override
  String get historyClearAll => 'सर्वं प्रमृज्यताम्';

  @override
  String get historyClearTitle => 'इतिहासः प्रमृज्यतां वा?';

  @override
  String get historyClearMessage =>
      'किं सर्वः संवीक्षा-इतिहासः विलोपनीयः? विना सञ्चयं कृत्वा पुनः न लभ्यते।';

  @override
  String get historySearchHint => 'इतिहासेऽन्विष्यताम्...';

  @override
  String get historyFilterAll => 'सर्वम्';

  @override
  String get historyFilterStarred => 'तारकाङ्कितानि';

  @override
  String get historyFilterUrls => 'सङ्केताः';

  @override
  String get historyFilterWifi => 'वै-फाई';

  @override
  String get historyFilterContacts => 'सम्पर्काः';

  @override
  String get historyFilterText => 'लेखः';

  @override
  String get historyFilterBarcodes => 'दण्डलेखाः';

  @override
  String get historyEmptyTitle => 'न कोऽपि संवीक्षा-अभिलेखः प्राप्तः';

  @override
  String get historyEmptyMessage =>
      'संवीक्षिताः सङ्केताः अत्र स्वयमेव आगमिष्यन्ति।';

  @override
  String historyNoMatches(String query) {
    return '\"$query\" कृते न किमपि प्राप्तम्';
  }

  @override
  String get moreOptions => 'अधिकविकल्पाः';

  @override
  String get menuHistory => 'इतिहासः';

  @override
  String get menuSettings => 'विन्यासाः';

  @override
  String get grantPermission => 'अनुज्ञां ददातु';

  @override
  String get scanFromGallery => 'वीथिकायाः चित्रपरीक्षणम्';

  @override
  String get scanPdfDocument => 'PDF-प्रलेखपरीक्षणम्';

  @override
  String get scanPdfProgress => 'PDF-पृष्ठानि विविच्य परीक्ष्यन्ते...';

  @override
  String get scanSharedPdfProgress => 'सम्भक्त-PDF-प्रलेखस्य परीक्षणम्...';

  @override
  String get scanInitializingCamera => 'चित्रग्राही सज्जक्रियते...';

  @override
  String get scanInitializingFeed => 'चित्रग्राहीप्रवाहः सज्जक्रियते...';

  @override
  String get scanTorchTooltip => 'द्योतकदीपः';

  @override
  String get scanZoomTooltip => 'विस्तारसर्पकम्';

  @override
  String get scanFlipCameraTooltip => 'चित्रग्राहीपरिवर्तनम् (पुरतः/पृष्ठतः)';

  @override
  String scanZoomValue(String value) {
    return '${value}x';
  }

  @override
  String get scanViewfinderHint => 'सङ्केतं कोष्ठे स्थापयतु';

  @override
  String get scanCameraPermissionRequired => 'चित्रग्राह्यनुमतिः आवश्यकी';

  @override
  String get copiedLabel => 'प्रतिलिखितम्!';

  @override
  String get hideAction => 'गूढयतु';

  @override
  String get revealAction => 'दर्शयतु';

  @override
  String get openAnywayButton => 'तथापि उद्घाटयतु';

  @override
  String get resultScreenTitle => 'अन्वीक्षणफलम्';

  @override
  String get resultNoResult => 'फलं न लब्धम्';

  @override
  String get resultContentLabel => 'विषयः:';

  @override
  String get resultDecoyContentLabel => 'सार्वजनिकविषयः:';

  @override
  String get resultDetectedType => 'लब्धप्रकारः:';

  @override
  String get resultTypeStego => 'STEGO-QR (गूढद्विस्तरम्)';

  @override
  String get resultRecheckButton => 'पुनरीक्षताम्';

  @override
  String get resultOpenInBrowser => 'जालगवेषके उद्घाटयतु';

  @override
  String get resultCopyText => 'पाठं प्रतिलिखतु';

  @override
  String get resultCopyDecoyText => 'सार्वजनिकपाठं प्रतिलिखतु';

  @override
  String get resultShareText => 'पाठं विभजतु';

  @override
  String get resultShareDecoyText => 'सार्वजनिकपाठं विभजतु';

  @override
  String get resultScanAnother => 'अन्यसङ्केतं परीक्षताम्';

  @override
  String get resultLaunchFailed => 'जालसङ्केतं उद्घाटयितुं न शक्तम्';

  @override
  String get stegoUnlockedMessage => 'गूढ-AES-256-विषयः सफलतया उद्घाटितः।';

  @override
  String get stegoLockedMessage =>
      'अस्मिन् सङ्केते गूढं विषयमस्ति। दर्शनाय प्रमाणीकरणं कुरुत।';

  @override
  String get stegoBiometricUnlock => 'जैविक-प्रवेशः';

  @override
  String get stegoPassphrase => 'कूटवाक्यम्';

  @override
  String get stegoSecretPayload => 'गूढ-विषयः:';

  @override
  String get stegoCopySecret => 'गूढं प्रतिलिख्यताम्';

  @override
  String get stegoShareSecret => 'गूढं विभज्यताम्';

  @override
  String get stegoSecretCopied => 'गूढं फलके प्रतिलेखितम्';

  @override
  String get stegoDialogTitleBiometric => 'जैविकम् + कूटवाक्यम्';

  @override
  String get stegoDialogTitlePassphrase => 'कूटवाक्यं दीयताम्';

  @override
  String get stegoDialogMessageBiometric =>
      'प्रमाणीकरणाय कूटवाक्यं दृढीक्रियताम्।';

  @override
  String get stegoDialogMessagePassphrase =>
      'गूढ-रक्षणाय प्रयुक्तं कूटवाक्यं लिख्यताम्।';

  @override
  String get stegoUnlockButton => 'उद्घाट्यताम्';

  @override
  String get safetyCheckInProgress => 'सुरक्षा-परीक्षणं प्रचलति';

  @override
  String get safetyAnalysisTitle => 'सङ्केत-सुरक्षा-विश्लेषणम्';

  @override
  String get safetyAnalyzing => 'सुरक्षा-विश्लेषणं क्रियते...';

  @override
  String safetyIssuesDetected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सुरक्षा-दोषाः प्राप्ताः',
      one: '1 सुरक्षा-दोषः प्राप्तः',
    );
    return '$_temp0';
  }

  @override
  String get safetyNoIssues => 'न कोऽपि दोषः प्राप्तः';

  @override
  String get safetyTrustSourceHint =>
      'यदि स्रोतः विश्वस्तः तर्हि एव उद्घाट्यताम्';

  @override
  String get safetyResultsHeading => 'सुरक्षा-विश्लेषण-फलानि:';

  @override
  String get probingBannerActive =>
      'सक्रिय-परीक्षणं प्रवृत्तम्: अनेन जालेन सह साक्षात् सम्पर्कः जातः।';

  @override
  String get probingBannerPrivate =>
      'एकान्त-विधिः: स्थानीय-नियमाः एव प्रयुक्ताः। साक्षात् सम्पर्कः न जातः।';

  @override
  String get warningDialogTitle => 'सुरक्षाचेतावनी';

  @override
  String get warningDialogMessage =>
      'अस्मिन् जाले सुरक्षादोषाः सन्ति। अस्योद्घाटनेन यन्त्रस्य हानिः सम्भवेत्।\n\nकिं भवन्तः अग्रे गन्तुम् इच्छन्ति?';

  @override
  String get cautionDialogTitle => 'सावधानता';

  @override
  String get cautionDialogMessage =>
      'क्यूआर्-सङ्केतोद्घाटनात् पूर्वं मूलं सत्यापयतु।\n\nकिम् इदम् उद्घाटनीयम्?';

  @override
  String get overlayLaserLine => 'दीप्तिरेखा';

  @override
  String get overlayPulsingCorners => 'स्फुरन्तौ कोणाः';

  @override
  String get overlayCyberneticGrid => 'तन्त्रजालिका';

  @override
  String get overlaySubtleDotMatrix => 'बिन्दुमात्रिका';

  @override
  String get overlayLaserLineDesc =>
      'उज्ज्वलदीप्तिरेखायुक्तम् अन्वीक्षणकोष्ठम्';

  @override
  String get overlayPulsingCornersDesc => 'दीप्तियुक्ताः चलन्तश्च कोणाः';

  @override
  String get overlayCyberneticGridDesc => 'वैज्ञानिकजालिकायुक्तः संस्तरः';

  @override
  String get overlaySubtleDotMatrixDesc => 'सूक्ष्मबिन्दुमात्रिकायुक्ता शैली';

  @override
  String get themeSystemDefault => 'तन्त्रमानकम्';

  @override
  String get themeLight => 'प्रकाशरूपम्';

  @override
  String get themeDark => 'तिमिररूपम्';

  @override
  String get themeOled => 'शुद्धकृष्णम्';

  @override
  String get themeModeHeading => 'रूपविधा';

  @override
  String get themeChipSystem => 'तन्त्रम्';

  @override
  String get themeChipLight => 'प्रकाशः';

  @override
  String get themeChipDark => 'तिमिरम्';

  @override
  String get themeChipOled => 'कृष्णम्';

  @override
  String get themeDynamicColorsTitle => 'मटीरियलयू गतिकवर्णाः';

  @override
  String get themeDynamicColorsSubtitle =>
      'एण्ड्रायड् १२+ भित्तिचित्रवर्णानाम् उपयोगः';

  @override
  String get themeDescSystem => 'तन्त्रविन्यासम् अनुसरतु';

  @override
  String get themeDescLight => 'मानकप्रकाशविधा';

  @override
  String get themeDescDark => 'मानकतिमिरविधा';

  @override
  String get themeDescOled => 'शुद्धकृष्णम् (ऊर्जासंरक्षणम्)';

  @override
  String get settingsTitle => 'विन्यासाः';

  @override
  String get settingsFeedbackTitle => 'प्रतिसादः सूचनाश्च';

  @override
  String get settingsPrivacyTitle => 'गोपनीयता जालपरीक्षणं च';

  @override
  String get settingsSafeBrowsingTitle => 'गूगल-सुरक्षितसञ्चार-API';

  @override
  String get settingsPermissionsTitle => 'अनुमतयः';

  @override
  String get settingsPermissionsSubtitle =>
      'प्रत्यक्षाः अन्तर्निहिताश्च अनुमतयः';

  @override
  String get settingsHelpTitle => 'साहाय्यं वैशिष्ट्यानि च';

  @override
  String get settingsHelpSubtitle =>
      'ए-आर् दृष्टिः, वायु-क्यूआर्, जालसुरक्षा च';

  @override
  String get settingsAboutSubtitle => 'संस्करणं, विधाता, अनुज्ञापत्रविवरणं च';

  @override
  String get feedbackVibrationTitle => 'कम्पनप्रतिसादः';

  @override
  String get feedbackVibrationSubtitle => 'सङ्केतान्वीक्षणे दूरवाणीं कम्पयतु';

  @override
  String get feedbackSoundTitle => 'ध्वनिप्रतिसादः';

  @override
  String get feedbackSoundSubtitle => 'सङ्केतान्वीक्षणे ध्वनिं जनयतु';

  @override
  String get feedbackAnimationTitle => 'पुष्टीकरणसञ्चलनम्';

  @override
  String get feedbackAnimationSubtitle =>
      'सङ्केतान्वीक्षणे जालकस्पन्दनं सम्यक्-चिह्नं च दर्शयतु';

  @override
  String get privacyScreenTitle => 'गोपनीयता जालपरीक्षणं च';

  @override
  String get privacyActiveChecksTitle => 'सक्रियजालपरीक्षणम्';

  @override
  String get privacySummaryOn => 'सक्रियजालपरीक्षणं प्रवर्तितम्';

  @override
  String get privacySummaryOff => 'केवलम् अन्तस्थगोप्यपरीक्षणम्';

  @override
  String get apiKeyConfigured => 'विन्यस्तम्';

  @override
  String get apiKeyNotConfigured => 'न विन्यस्तम्';

  @override
  String get apiKeySaved => 'API-कुञ्चिका सुरक्षिता';

  @override
  String get apiKeyDeleted => 'API-कुञ्चिका अपाकृता';

  @override
  String get apiKeyDeleteTitle => 'API-कुञ्चिकां विलोपयतु';

  @override
  String get deleteButton => 'विलोपयतु';

  @override
  String get apiAboutHeading => 'सुरक्षितसञ्चार-API विषयम्';

  @override
  String get apiKeyConfiguredTitle => 'API-कुञ्चिका विन्यस्ता';

  @override
  String get apiKeyConfiguredSubtitle => 'दुष्टसङ्केतपरीक्षणं सक्रियम्';

  @override
  String get apiLimitReached => 'दैनिकसीमा समाप्ता। श्वः पुनरारम्भः।';

  @override
  String get apiLimitApproaching => 'दैनिकसीमा समीपे वर्तते';

  @override
  String get apiKeyFieldLabel => 'API-कुञ्चिका';

  @override
  String get apiKeyFieldHint => 'गूगल-सुरक्षितसञ्चार-API कुञ्चिकां निवेशयतु';

  @override
  String get apiKeyRequired => 'API-कुञ्चिका आवश्यकी';

  @override
  String get apiKeyTooShort => 'कुञ्चिकायाः दैर्घ्यम् अपर्याप्तम्';

  @override
  String get apiKeySaveButton => 'कुञ्चिकां रक्षतु';

  @override
  String get apiHowToHeading => 'API-कुञ्चिकां कथं प्राप्नुयात्';

  @override
  String get apiStep1Title => 'गूगल-क्लाउड-मञ्चं गच्छतु';

  @override
  String get apiStep1Desc => 'console.cloud.google.com पश्यतु';

  @override
  String get apiStep2Title => 'प्रकल्पं चिनोतु रचयतु वा';

  @override
  String get apiStep2Desc => 'विद्यमानं प्रकल्पं चिनोतु नूतनं वा रचयतु';

  @override
  String get apiStep3Title => 'सुरक्षितसञ्चार-API प्रवर्तयतु';

  @override
  String get apiStep4Title => 'प्रमाणपत्राणि सृजतु';

  @override
  String get apiStep4Desc =>
      'Credentials → Create Credentials → API Key गच्छतु';

  @override
  String get apiStep5Title => 'प्रतिलिख्य संयोजयतु';

  @override
  String get apiStep5Desc => 'लब्धां कुञ्चिकां प्रतिलिख्य अत्र स्थापयतु';

  @override
  String get apiFreeTierNote =>
      'निःशुल्कस्तरे प्रतिदिनं १०,००० अभ्यर्थनाः लभ्यन्ते';

  @override
  String get permissionsScreenTitle => 'अनुमतिविवरणम्';

  @override
  String get permissionsExplicitHeading => 'प्रत्यक्षसञ्चालनानुमतयः';

  @override
  String get permissionCameraTitle =>
      'चित्रग्राही अनुमतिः (android.permission.CAMERA)';

  @override
  String get permissionCameraDesc =>
      'अन्वीक्षणकाले एव प्रार्थ्यते। सजीवपरीक्षणाय ए-आर् पटलाय च आवश्यकी।';

  @override
  String get permissionBiometricTitle =>
      'जैविकप्रमाणीकरणम् (android.permission.USE_BIOMETRIC)';

  @override
  String get permissionBiometricDesc =>
      'गूढभाण्डाराणां गूढसङ्केतानां च उद्घाटनाय प्रयुज्यते।';

  @override
  String get permissionsImplicitHeading => 'अन्तर्निहिततन्त्रानुमतयः';

  @override
  String get permissionInternetTitle =>
      'अन्तर्जालप्रवेशः (android.permission.INTERNET)';

  @override
  String get permissionInternetDesc =>
      'सक्रियपरीक्षणे गूगल-सुरक्षापरीक्षणे वा प्रयुज्यते।';

  @override
  String get permissionVibrateTitle =>
      'कम्पननियन्त्रणम् (android.permission.VIBRATE)';

  @override
  String get permissionVibrateDesc =>
      'अन्वीक्षणसूचनासु कुञ्चकस्पर्शनेषु च कम्पनं जनयति।';

  @override
  String get permissionPhotoPickerTitle => 'चित्रचयनकम्';

  @override
  String get permissionPhotoPickerDesc =>
      'सञ्चयप्रवेशं विना वीथिकायाः चित्राणि चिनोतु।';

  @override
  String get permissionsSettingHeading => 'विन्यासाधारितानुमतयः';

  @override
  String get permissionProbingTitle => 'सक्रियजालपरीक्षणम्';

  @override
  String get permissionProbingDesc =>
      'प्रवर्तिते सति जालरूपान्तरणं परीक्षते। अन्यदा पूर्णतया अन्तस्थम्।';

  @override
  String get permissionSafeBrowsingTitle => 'गूगल-सुरक्षितसञ्चार-API';

  @override
  String get permissionSafeBrowsingDesc =>
      'कुञ्चिकाविन्यासे गूगल-सुरक्षाकोषे दुष्टसङ्केतान् परीक्षते।';

  @override
  String get permissionFeedbackTitle => 'अन्वीक्षणकम्पनम्';

  @override
  String get permissionFeedbackDesc => 'विन्यासे कम्पनप्रवर्तने एव प्रयुज्यते।';

  @override
  String get onLabel => 'सक्रियम्';

  @override
  String get offLabel => 'निष्क्रियम्';

  @override
  String get unknownLabel => 'अज्ञातम्';

  @override
  String get privacyActiveChecksSubtitle =>
      'निष्क्रियम्: सङ्केताः गोप्यतया परीक्ष्यन्ते — गन्तव्यजालकं न सम्पृच्यते।';

  @override
  String get privacyExplainerOn =>
      'प्रवर्तिते सति जालस्थानं साक्षात् सम्पृच्यते। अनेन भवतः IP-सङ्केतः तत्र दृश्यते।';

  @override
  String get privacyExplainerOff =>
      'अन्तस्थनियमैः एव सुरक्षितपरीक्षणं भवति। सङ्केताः कुत्रचिदपि न प्रेष्यन्ते।';

  @override
  String get apiKeyDeleteMessage =>
      'किं भवन्तः Google Safe Browsing API-कुञ्चिकां विलोपयितुम् इच्छन्ति? अनेन जालसुरक्षापरीक्षणं निष्क्रिये भविष्यति।';

  @override
  String get apiAboutBody =>
      'गूगल-सुरक्षा-API कपटसङ्केतान् विज्ञापयति। भवतः कुञ्चिका यन्त्रे गूढतया सुरक्षिता वर्तते।';

  @override
  String get apiTodaysUsage => 'अद्यतनउपयोगः';

  @override
  String get apiStep3Desc => '\"Safe Browsing API\" अन्विष्य प्रवर्तयतु';

  @override
  String feedbackSummary(String vibration, String sound) {
    return 'कम्पनम्: $vibration • ध्वनिः: $sound';
  }

  @override
  String settingsApiKeySubtitle(String status) {
    return 'API-कुञ्चिका: $status';
  }

  @override
  String apiKeySaveFailed(String error) {
    return 'कुञ्चिकारक्षणे दोषः: $error';
  }

  @override
  String apiKeyDeleteFailed(String error) {
    return 'कुञ्चिकाविलोपने दोषः: $error';
  }

  @override
  String apiDailyLimit(int count) {
    return 'दैनिकसीमा: प्रतिदिनं $count अभ्यर्थनाः';
  }

  @override
  String apiResets(String date) {
    return 'पुनर्नवीकरणम्: $date';
  }

  @override
  String get resultTypeTextFallback => 'पाठः';

  @override
  String get checkNameHttps => 'HTTPS संयोजनम्';

  @override
  String get checkNameSsl => 'SSL/TLS प्रमाणत्रम्';

  @override
  String get checkNameRedirect => 'पुनर्निर्देशन-विश्लेषणम्';

  @override
  String get checkNamePattern => 'स्वरूप-ज्ञानम्';

  @override
  String get checkNameShortener => 'ह्रस्व-सङ्केत-परीक्षणम्';

  @override
  String get checkNameHomograph => 'समरूप-कपट-परीक्षणम्';

  @override
  String get checkNameMalicious => 'अनिष्ट-विषय-परीक्षणम्';

  @override
  String get httpsNotUsed => 'अरक्षितं HTTP संयोजनं प्रयुक्तम्';

  @override
  String get sslPrivateModeOk => 'HTTPS प्रयुक्तम् (एकान्त-विधौ न परीक्षितम्)';

  @override
  String get sslValid => 'प्रमाणपत्रं प्रामाणिकम्';

  @override
  String get sslExpired => 'प्रमाणपत्रस्य कालः समाप्तः';

  @override
  String get sslNotYetValid => 'प्रमाणपत्रं न अद्यापि वैधम्';

  @override
  String get sslUnverifiable => 'प्रमाणपत्र-सत्यापनं न जातम्';

  @override
  String get sslCheckFailed => 'प्रमाणपत्र-परीक्षणं विफलम्';

  @override
  String get redirectSkippedPrivate => 'एकान्त-विधौ त्यक्तम्';

  @override
  String get redirectLoop => 'पुनर्निर्देशन-चक्रं प्राप्तम्';

  @override
  String get redirectNone => 'न कोऽपि पुनर्निर्देशः';

  @override
  String get redirectUnavailable => 'परीक्षणम् अशक्यम्';

  @override
  String get patternNone => 'न कोऽपि सन्दिग्ध-दोषः';

  @override
  String get patternUnavailable => 'विश्लेषणम् अशक्यम्';

  @override
  String get shortenerOfflineHeuristics =>
      'पूर्ण-परीक्षणं न जातम् (अनुपलब्ध-जालम्)';

  @override
  String get shortenerNone => 'न ह्रस्व-सङ्केतः';

  @override
  String get shortenerUnavailable => 'परीक्षणम् अशक्यम्';

  @override
  String get homographMixedScripts => 'मिश्रित-लिपयः प्राप्ताः';

  @override
  String get homographNone => 'न कोऽपि समरूप-कपट-वर्णः';

  @override
  String get homographUnavailable => 'परीक्षणम् अशक्यम्';

  @override
  String get maliciousSkippedNoKey => 'त्यक्तम् (API कुञ्चिका न न्यस्ता)';

  @override
  String get maliciousDailyLimit => 'दैनिक-सीमा समाप्ता';

  @override
  String get maliciousNone => 'न कोऽपि ज्ञात-दोषः';

  @override
  String get maliciousInvalidKey => 'दोषयुक्ता API कुञ्चिका';

  @override
  String get maliciousRateLimited => 'गति-सीमा अतीता';

  @override
  String get maliciousUnavailable => 'परीक्षणम् अशक्यम्';

  @override
  String get stegoWrongPassphrase => 'उद्घाटनं विफलम्। अशुद्धं कूटवाक्यम्।';

  @override
  String get airQrChecksumFailed => 'सङ्ख्या-परीक्षणं विफलम्।';

  @override
  String redirectSuspiciousChain(String count) {
    return 'सन्दिग्धा पुनर्निर्देशन-शृङ्खला ($count पुनर्निर्देशाः)';
  }

  @override
  String redirectWithinRange(String count) {
    return '$count पुनर्निर्देशाः - सामान्य-सीमायाम्';
  }

  @override
  String patternDetected(String patterns) {
    return 'प्राप्तम्: $patterns';
  }

  @override
  String shortenerKnown(String shortener) {
    return 'ज्ञातः ह्रस्व-सङ्केतः प्राप्तः ($shortener)';
  }

  @override
  String shortenerRedirect(String host) {
    return 'ह्रस्व-सङ्केतः ($host प्रति गच्छति)';
  }

  @override
  String homographLookalikes(String characters) {
    return 'समरूप-वर्णाः प्राप्ताः: $characters';
  }

  @override
  String maliciousThreats(String threats) {
    return 'दोषाः प्राप्ताः: $threats';
  }

  @override
  String maliciousApiError(String status) {
    return 'API दोषः (स्थितिः: $status)';
  }

  @override
  String get checkNameVirusTotal => 'वायरसटोटल';

  @override
  String get virusTotalSkippedNoKey => 'त्यक्तम् (API कुञ्चिका न न्यस्ता)';

  @override
  String get virusTotalDailyLimit => 'दैनिक-सीमा समाप्ता (५००/दिनम्)';

  @override
  String virusTotalThreats(String engines) {
    return '$engines यन्त्रेण दोषाः प्राप्ताः';
  }

  @override
  String get virusTotalNone => 'न कोऽपि दोषः (वायरसटोटल)';

  @override
  String get virusTotalInvalidKey => 'दोषयुक्ता API कुञ्चिका (वायरसटोटल)';

  @override
  String get virusTotalRateLimited => 'गति-सीमा अतीता (वायरसटोटल)';

  @override
  String virusTotalApiError(String status) {
    return 'API दोषः (स्थितिः: $status)';
  }

  @override
  String get virusTotalUnavailable => 'परीक्षणम् अशक्यम् (वायरसटोटल)';

  @override
  String get checkNameUrlhaus => 'URLhaus';

  @override
  String get urlhausSkippedNoKey => 'त्यक्तम् (API कुञ्चिका न न्यस्ता)';

  @override
  String urlhausMalware(String tags) {
    return 'दुष्टसङ्केतस्थानं प्राप्तम्: $tags';
  }

  @override
  String get urlhausClean => 'न कोऽपि दुष्ट-आतिथ्यम् (URLhaus)';

  @override
  String get urlhausNotFound => 'URLhaus-कोषे न विद्यते';

  @override
  String get urlhausInvalidKey => 'दोषयुक्ता API कुञ्चिका (URLhaus)';

  @override
  String urlhausApiError(String status) {
    return 'API दोषः (स्थितिः: $status)';
  }

  @override
  String get urlhausUnavailable => 'परीक्षणम् अशक्यम् (URLhaus)';

  @override
  String get checkNamePhishTank => 'PhishTank';

  @override
  String get phishTankSkippedDisabled => 'त्यक्तम् (PhishTank निष्क्रियम्)';

  @override
  String get phishTankPhishing => 'ज्ञात-प्रलोभन-स्थानम् (PhishTank)';

  @override
  String get phishTankClean => 'प्रलोभन-स्थानं नास्ति (PhishTank)';

  @override
  String get phishTankNotInDatabase => 'PhishTank-कोषे न विद्यते';

  @override
  String phishTankApiError(String status) {
    return 'API दोषः (स्थितिः: $status)';
  }

  @override
  String get phishTankUnavailable => 'परीक्षणम् अशक्यम् (PhishTank)';

  @override
  String get checkNameOpenPhish => 'OpenPhish';

  @override
  String get openPhishSkippedDisabled => 'त्यक्तम् (OpenPhish निष्क्रियम्)';

  @override
  String get openPhishPhishing => 'ज्ञात-प्रलोभन-स्थानम् (OpenPhish)';

  @override
  String get openPhishClean => 'प्रलोभन-सूचौ न विद्यते (OpenPhish)';

  @override
  String get openPhishFeedStale =>
      'सूचिः अनुपलब्धा — स्वस्थानीय-परीक्षणं त्यक्तम्';

  @override
  String get openPhishUnavailable => 'परीक्षणम् अशक्यम् (OpenPhish)';

  @override
  String get settingsUrlSafetyProvidersTitle => 'URL-सुरक्षा-दाताः';

  @override
  String settingsUrlSafetyProvidersSubtitle(String count) {
    return '$count दाता सक्रियाः';
  }

  @override
  String get urlSafetyProvidersHelpText =>
      'ऐच्छिकान् URL-सुरक्षा-परीक्षणान् संयोजयतु। प्रतिदाता स्वतन्त्रः। अव्यावसायिक-उपयोगिनः स्वकीयां कुञ्चिकां नयन्तु।';

  @override
  String get urlSafetyUserSuppliedHeader => 'भवतः API कुञ्चिकाः';

  @override
  String get urlSafetyUserSuppliedNote => 'केवलम् अव्यावसायिक-उपयोगः';

  @override
  String get urlSafetyBuiltInHeader => 'अन्तर्निहित-दाताः';

  @override
  String get urlSafetyBuiltInNote => 'खाता-रहितम् — केवलं सक्रियीकरणम्';

  @override
  String get providerEndpointLabel => 'API-समाप्ति-सङ्केतः';

  @override
  String get providerApiKeyHint => 'API कुञ्चिकां योजयतु';

  @override
  String get providerGetKeyAt => 'निःशुल्क-कुञ्चिकार्थम्:';

  @override
  String providerDailyUsage(String used, String max) {
    return 'अद्य $used / $max अनुरोधाः';
  }

  @override
  String openPhishLastUpdated(String datetime) {
    return 'अन्तिम-नवीकरणम्: $datetime';
  }

  @override
  String get openPhishRefreshNow => 'सूचिं नवीकरोतु';

  @override
  String openPhishFeedRefreshed(String count) {
    return 'सूचिः नवीकृता ($count सङ्केताः)';
  }

  @override
  String get openPhishFeedFailed => 'सूचि-नवीकरणं विफलम्';

  @override
  String get phishTankToggleLabel => 'PhishTank सक्रियीकरणम्';

  @override
  String get openPhishToggleLabel => 'OpenPhish-सूचिः सक्रियीकरणम्';

  @override
  String get quishingSummaryAuthentic =>
      'प्रामाणिकः मुद्रित-सङ्केतः। न काऽपि विकृतिः।';

  @override
  String get quishingSummaryWearAndTear => 'घर्षण-विकृतिः प्राप्ता।';

  @override
  String get quishingSummaryHighWarning =>
      'उच्च-सावधानता: उपरि लेपित-पत्रं दृष्टम्!';

  @override
  String get quishingStatusAuthentic => '🟢 प्रामाणिकः मुद्रित-सङ्केतः';

  @override
  String get quishingStatusWearAndTear => '🟡 घर्षण-विकृतिः दृष्टा';

  @override
  String get quishingStatusHighWarning =>
      '🔴 उच्च-सावधानता: लेपित-पत्रं दृष्टम्!';

  @override
  String get quishingSignalMicroShadowPerimeter =>
      'सीमायां सूक्ष्म-छाया-रेखा दृष्टा';

  @override
  String get quishingSignalGrainAberration => 'मुद्रण-कण-विषमता प्राप्ता';

  @override
  String get quishingSignalUniformReflection => 'समान-प्रतिफलनं सत्यापितम्';

  @override
  String get quishingSignalConsistentDotsQrMatrix =>
      'सङ्केते बिन्दु-घनत्वं समानम्';

  @override
  String get quishingSignalReflectionVerified => 'प्रतिफलनं सत्यापितम्';

  @override
  String get quishingSignalHalftoneConsistentQrMatrix =>
      'सीमायां बिन्दु-घनत्वं समानम्';

  @override
  String get quishingSignalHalftoneConsistentMatrix =>
      'सर्वत्र बिन्दु-घनत्वं समानम्';

  @override
  String get quishingSignalDoubleEdgeAroundMatrix => 'द्विगुण-धारा दृष्टा';

  @override
  String get quishingSignalMicroShadowStickerBorder =>
      'पत्र-सीमायां सूक्ष्म-छाया दृष्टा';

  @override
  String get quishingSignalGrainMismatchBase => 'मुद्रण-कणानां विषमता प्राप्ता';

  @override
  String get quishingSignalMinorScratch => 'अल्पं घर्षणं दृष्टम्';

  @override
  String get quishingSignalSlightDotIrregularity => 'धारासु अल्प-विषमता';

  @override
  String get quishingSignalConsistentDotsMatrixPerimeter =>
      'सीमायां समान-घनत्वम्';

  @override
  String quishingSignalPerimeterDoubleEdge(String zones) {
    return 'द्विगुण-धारा-प्रतिफलनं दृष्टम् ($zones मण्डलानि)';
  }

  @override
  String quishingSignalDotDensityVariance(String variance) {
    return 'घनत्व-विषमता दृष्टा ($variance% भेदः)';
  }

  @override
  String get domSslInvalidScheme => 'अमान्य-विधिः';

  @override
  String get domSslHttps => 'सुरक्षितं HTTPS प्रयुक्तम्';

  @override
  String get domSslHttp => 'असुरक्षितं HTTP संयोजनम् (उच्च-सङ्कटम्)';

  @override
  String get domStatusInvalidUrl => 'अमान्यः सङ्केत-प्रकारः।';

  @override
  String get domStatusHttpCaution => '⚠️ सावधानता: अरक्षितं HTTP जालस्थानम्';

  @override
  String get domStatusSafe => '✅ सुरक्षित-कक्षा: HTML पूर्वदर्शनं शुद्धीकृतम्।';

  @override
  String domStatusOpenRedirect(String target) {
    return '⚠️ पूर्वसूचना: $target प्रति गच्छन् अनावृत-पुनर्निर्देशः प्राप्तः';
  }

  @override
  String domStatusNewDomain(String days) {
    return '⚠️ पूर्वसूचना: नूतन-पञ्जीकृतं क्षेत्रम् ($days दिनानि)';
  }

  @override
  String get stegoPassphraseEmpty => 'कूटवाक्यं रिक्तं न भवेत्';

  @override
  String get stegoBiometricReason => 'गूढ-विषय-दर्शनाय प्रमाणीकरणं क्रियताम्';

  @override
  String get mediaNoCodeInImage => 'चित्रे सङ्केताः न दृष्टाः।';

  @override
  String get mediaNoCodeInPdf => 'PDF-प्रलेखे सङ्केताः न लब्धाः।';

  @override
  String mediaImagePickFailed(String error) {
    return 'चित्रपरीक्षणे दोषः: $error';
  }

  @override
  String mediaImageAnalyzeFailed(String error) {
    return 'चित्रविश्लेषणे दोषः: $error';
  }

  @override
  String mediaPdfPickFailed(String error) {
    return 'PDF-उद्घाटने दोषः: $error';
  }

  @override
  String mediaPdfScanFailed(String error) {
    return 'PDF-परीक्षणे दोषः: $error';
  }

  @override
  String get stegoBiometricCanceled => 'जैविक-प्रमाणीकरणं निरस्तं विफलम् वा।';

  @override
  String get formatQrUrl => 'क्यूआर् (जालसङ्केतः)';

  @override
  String get formatQrEmail => 'क्यूआर् (विद्युत्पत्रम्)';

  @override
  String get formatQrPhone => 'क्यूआर् (दूरवाणी)';

  @override
  String get formatQrSms => 'क्यूआर् (SMS)';

  @override
  String get formatQrWifi => 'क्यूआर् (वै-फै)';

  @override
  String get formatQrLocation => 'क्यूआर् (स्थानम्)';

  @override
  String get formatQrContact => 'क्यूआर् (सम्पर्कः)';

  @override
  String get formatIsbn => 'ISBN';

  @override
  String get formatEanUpc => 'EAN/UPC';

  @override
  String get formatQrCode => 'क्यूआर् सङ्केतः';

  @override
  String get formatEanUpcProduct => 'EAN/UPC उत्पादः';

  @override
  String get formatBarcode => 'दण्डसङ्केतः';

  @override
  String get wifiHiddenNetwork => 'गूढ-जालम्';

  @override
  String get totpDefaultAccount => 'विवरणम्';

  @override
  String get backupInvalidFormat => 'अमान्य-सञ्चिका-प्रकारः।';

  @override
  String get backupBadHeader => 'दोषयुक्तः सञ्चिका-शीर्षभागः।';

  @override
  String get backupWrongPassphrase => 'अशुद्धं कूटवाक्यं दोषयुक्तो विषयो वा।';

  @override
  String get reportHeading =>
      'श्रीराज् पि क्यू-आर-कार्यशाला - संवीक्षा-इतिहासः';

  @override
  String get reportTitle => 'इतिहास-निर्यातः';

  @override
  String get reportExportDate => 'निर्यात-दिनाङ्कः';

  @override
  String get reportTotalScans => 'कुल-संवीक्षाः';

  @override
  String get reportScanNumber => 'सङ्ख्या #';

  @override
  String get reportId => 'अभिज्ञानम्     ';

  @override
  String get reportTimestamp => 'दिनाङ्कः समयश्च ';

  @override
  String get reportFormat => 'प्रकारः        ';

  @override
  String get reportCategory => 'वर्गः          ';

  @override
  String get reportSafetyScore => 'सुरक्षा-मानाङ्कः';

  @override
  String get reportStarred => 'तारकाङ्कितम्   ';

  @override
  String get reportStarredYes => '⭐ आम्';

  @override
  String get reportStarredNo => 'न';

  @override
  String get reportLocation => 'स्थानम्        ';

  @override
  String get reportNotes => 'टिप्पणी        ';

  @override
  String get reportContent => 'विषयः          ';

  @override
  String get reportColumnDateTime => 'दिनाङ्कः समयश्च';

  @override
  String get reportColumnFormat => 'प्रकारः';

  @override
  String get reportColumnCategory => 'वर्गः';

  @override
  String get reportColumnSafety => 'सुरक्षा';

  @override
  String get reportColumnContent => 'विषय-भागः';

  @override
  String get reportColumnNotes => 'टिप्पणी';

  @override
  String get patternIpAddress => 'IP सङ्केतः';

  @override
  String get patternLongNumbers => 'दीर्घा सङ्ख्या-शृङ्खला';

  @override
  String get patternManyDashes => 'बहवः रेखाः';

  @override
  String get patternPhishingKeywords => 'कपट-पदानि';

  @override
  String get patternDataUri => 'दत्तांश-URI';

  @override
  String get patternManySubdomains => 'बहूनि उपक्षेत्राणि';

  @override
  String get shortenerPossibleShortDomain =>
      'ह्रस्व-सङ्केत-सम्भावना: लघु-क्षेत्रम्';

  @override
  String get shortenerPossibleRandomPath =>
      'ह्रस्व-सङ्केत-सम्भावना: अनियता वर्णाः';

  @override
  String shortenerPossibleTld(String tld) {
    return 'ह्रस्व-सङ्केत-सम्भावना ($tld)';
  }

  @override
  String get settingsFeaturesTitle => 'वैशिष्ट्यानि';

  @override
  String get settingsFeaturesSubtitle =>
      'अनुप्रयोगस्य सर्वाणि वैशिष्ट्यानि पश्यतु';

  @override
  String get appearanceHubTitle => 'दृश्यरूपम्';

  @override
  String get appearanceThemeModeCardTitle => 'रूपविधा';

  @override
  String get appearanceThemeModeCardSubtitle =>
      'तन्त्रं, प्रकाशः, तिमिरं, शुद्धकृष्णं वा चिनोतु';

  @override
  String get appearanceOverlayCardTitle => 'अन्वीक्षणसंस्तरशैली';

  @override
  String get appearanceOverlayCardSubtitle =>
      'दीप्तिरेखा, कोणाः, जालिका, बिन्दुमात्रिका वा';

  @override
  String get appearanceAccentCardTitle => 'प्रधानवर्णाः गतिकवर्णाश्च';

  @override
  String get appearanceAccentCardSubtitle => 'मटीरियलयू वर्णाः रुचिरवर्णाश्च';

  @override
  String get appearanceTypographyCardTitle => 'अक्षरशैली परिमाणं च';

  @override
  String get appearanceTypographyCardSubtitle =>
      'वर्णलिपिः अक्षरपरिमाणविन्यासाश्च';

  @override
  String get featuresHeaderTitle => 'अनुप्रयोगस्य वैशिष्ट्यानि';

  @override
  String get featuresHeaderSubtitle =>
      'बुद्धिमदन्वीक्षणसाधनानि, षट्स्तरीयां जालसुरक्षां, ए-आर् दृष्टिं च पश्यतु।';

  @override
  String get featuresCatScanningName => 'मूल-अन्वीक्षणं ग्रहणं च';

  @override
  String get featuresCatScanningSubtitle =>
      'बहुस्रोत-माध्यम-समर्थम् अतिशीघ्रं 1D/2D दण्डलेखा-यन्त्रम्';

  @override
  String get featuresCatSafetyName => 'षट्स्तरीयं URL-सुरक्षा-परीक्षायन्त्रम्';

  @override
  String get featuresCatSafetySubtitle =>
      'दुष्ट-QR-प्रलोभनात् वञ्चनाभ्यः च भवन्तं रक्षति शून्यविश्वास-परीक्षणम्';

  @override
  String get featuresCatVisionName => 'क्विशिंग-रक्षकः™ उन्नत-AI-दृष्टिः च';

  @override
  String get featuresCatVisionSubtitle =>
      'यन्त्रे एव सङ्गणक-दृष्टिः प्रकाशमार्गेण विच्छिन्न-दत्तांश-प्रवाहः च';

  @override
  String get featuresCatPayloadsName => 'चतुर-विषयाः एकस्पर्श-क्रियाः च';

  @override
  String get featuresCatPayloadsSubtitle =>
      'दैनिक-दण्डलेखानां सद्यः विश्लेषणं सन्दर्भोचिताः क्रियाः च';

  @override
  String get featuresCatHistoryName => 'इतिहासः, सञ्चयः, गोपनीयता-कोशः च';

  @override
  String get featuresCatHistorySubtitle =>
      'जैविक-सुरक्षया स्थानीय-सञ्चयेन च रक्षितः भवतः अन्वीक्षण-इतिहासः';

  @override
  String get featureBarcodeEngineTitle => 'बहुरूप-दण्डलेखा-यन्त्रम्';

  @override
  String get featureBarcodeEngineDesc =>
      '1D-दण्डलेखाः (EAN-13, UPC-A, Code 128, Code 39, Codabar, ITF) 2D-सङ्केतान् (QR, Data Matrix, Aztec, PDF417) च क्षणमात्रेण विकोडयति।';

  @override
  String get featureBarcodeEngineChip1 => 'QR, Data Matrix';

  @override
  String get featureBarcodeEngineChip2 => 'Aztec, PDF417';

  @override
  String get featureBarcodeEngineChip3 => 'EAN, Code 128';

  @override
  String get featureMediaSourcesTitle => 'बहुस्रोत-माध्यमं PDF-ग्रहणं च';

  @override
  String get featureMediaSourcesDesc =>
      'सजीव-छायाग्राहकात्, चित्रवीथ्याः चित्रेभ्यः, बहुपृष्ठ-PDF-लेखेभ्यः वा दण्डलेखाः अन्वीक्षताम्।';

  @override
  String get featureMediaSourcesChip1 => 'चित्रवीथी';

  @override
  String get featureMediaSourcesChip2 => 'बहुपृष्ठ-PDF';

  @override
  String get featureMediaSourcesChip3 => 'सजीव-दृश्यम्';

  @override
  String get featureGhostScanTitle => 'छायावीक्षणम्: पटलस्थ-सङ्केत-अन्वेषकः';

  @override
  String get featureGhostScanDesc =>
      'सन्देश-अनुप्रयोगेषु, सामाजिक-पटलेषु, जालदर्शकेषु च पटले दृश्यमानान् QR-सङ्केतान् शीघ्रविन्यास-खण्डेन, प्लवमान-वीक्षण-बुद्बुदेन, इच्छया वा अन्विष्य विकोडयति। पटलचित्राणि न रक्ष्यन्ते।';

  @override
  String get featureGhostScanChip1 => 'शीघ्रविन्यास-खण्डः';

  @override
  String get featureGhostScanChip2 => 'वीक्षण-बुद्बुदः';

  @override
  String get featureGhostScanChip3 => 'पटलचित्रं न';

  @override
  String get featureCameraControlsTitle => 'सूक्ष्म-छायाग्राहक-नियन्त्रणानि';

  @override
  String get featureCameraControlsDesc =>
      'सुगमं विस्तारसर्पकम्, प्रकाशदीप-परिवर्तकम्, अग्र-पृष्ठ-छायाग्राहक-परिवर्तनम्, अल्पप्रकाशे अन्वीक्षणाय निरन्तरं स्वनाभीकरणं च।';

  @override
  String get featureCameraControlsChip1 => 'प्रकाशदीपः';

  @override
  String get featureCameraControlsChip2 => 'विस्तार-नियन्त्रणम्';

  @override
  String get featureCameraControlsChip3 => 'अग्र/पृष्ठ-परिवर्तनम्';

  @override
  String get featureScanOverlaysTitle => 'परिवर्तनीयाः अन्वीक्षण-संस्तराः';

  @override
  String get featureScanOverlaysDesc =>
      'दीप्तिरेखा, स्पन्दमान-कोणाः, सङ्गणक-जालकम्, सूक्ष्म-बिन्दु-जालं वा — एतेषु अन्वीक्षण-संस्तरेषु एकं चिनोतु।';

  @override
  String get featureScanOverlaysChip1 => '4 संस्तर-शैल्यः';

  @override
  String get featureScanOverlaysChip2 => 'सजीव-चलनम्';

  @override
  String get featureScanOverlaysChip3 => 'OLED-अनुकूलम्';

  @override
  String get featureFeedbackTitle => 'कम्पन-ध्वनि-प्रतिसादः';

  @override
  String get featureFeedbackDesc =>
      'परिवर्तनीयं कम्पनं बीप्-ध्वनिः च कोलाहलयुक्ते स्थाने अपि सफलम् अभिज्ञानं सूचयतः।';

  @override
  String get featureFeedbackChip1 => 'कम्पनम्';

  @override
  String get featureFeedbackChip2 => 'बीप्-ध्वनिः';

  @override
  String get featureFeedbackChip3 => 'पृथक्-नियन्त्रणानि';

  @override
  String get featureProtocolGuardTitle => 'नियमाचार-रचना-रक्षकः (स्तरः 1)';

  @override
  String get featureProtocolGuardDesc =>
      'योजना-प्रामाण्यं गूढ-HTTPS-सम्बन्धं च परीक्षते। साधारण-HTTP अथवा असमर्थित-योजनाः सूचयति।';

  @override
  String get featureProtocolGuardChip1 => 'HTTPS-परीक्षा';

  @override
  String get featureProtocolGuardChip2 => 'योजना-परीक्षा';

  @override
  String get featureProtocolGuardChip3 => 'अदृश्याक्षर-पाशः';

  @override
  String get featureHomographShieldTitle => 'समरूप-यूनिकोड-कवचम् (स्तरः 2)';

  @override
  String get featureHomographShieldDesc =>
      'कपट-क्षेत्रनामानि आच्छादयितुं प्रयुक्तानि सिरिलिक्-ग्रीक्-यूनिकोड-समरूपाक्षराणि अभिजानाति (IDN punycode-रक्षा)।';

  @override
  String get featureHomographShieldChip1 => 'Punycode-रक्षा';

  @override
  String get featureHomographShieldChip2 => 'सिरिलिक्-समरूपाणि';

  @override
  String get featureHomographShieldChip3 => 'मिश्रलिपि-पाशः';

  @override
  String get featureTldEntropyTitle =>
      'शङ्कास्पद-TLD-अव्यवस्था-विश्लेषणम् (स्तरः 3)';

  @override
  String get featureTldEntropyDesc =>
      'उच्चसङ्कट-TLD-नामानि अतिमात्र-उपक्षेत्राणि च सूचयति। यन्त्रनिर्मित-क्षेत्राणि ज्ञातुं नाम्नः अक्षर-अव्यवस्थां मिनोति।';

  @override
  String get featureTldEntropyChip1 => 'सङ्कट-TLD';

  @override
  String get featureTldEntropyChip2 => 'अव्यवस्था-अङ्कः';

  @override
  String get featureTldEntropyChip3 => 'उपक्षेत्र-गभीरता';

  @override
  String get featureIpPortTitle => 'IP-द्वार-परीक्षा (स्तरः 4)';

  @override
  String get featureIpPortDesc =>
      'साक्षात् IP-सङ्केतं प्रति अथवा अग्निभित्ति-लङ्घनाय असामान्य-HTTP/HTTPS-द्वाराणि प्रति गच्छन्तः सम्बन्धाः सूच्यन्ते।';

  @override
  String get featureIpPortChip1 => 'IP-पाशः';

  @override
  String get featureIpPortChip2 => 'असामान्य-द्वाराणि';

  @override
  String get featureIpPortChip3 => 'उपयोक्तृ-सूचना';

  @override
  String get featureHeadProbeTitle =>
      'गोपनीयता-सुरक्षितं जाल-परीक्षणम् (स्तरः 5)';

  @override
  String get featureHeadProbeDesc =>
      'भवता अनुमते एव: लघु-HTTP-HEAD-परीक्षणेन लघु-URL-विस्तारणं, गुप्त-पुनर्निर्देशन-शृङ्खला-प्रकाशनं, TLS-प्रमाणपत्र-सत्यापनं च।';

  @override
  String get featureHeadProbeChip1 => 'पुनर्निर्देशन-शृङ्खला';

  @override
  String get featureHeadProbeChip2 => 'लघु-URL-विस्तारः';

  @override
  String get featureHeadProbeChip3 => 'ऐच्छिक-गोपनीयता';

  @override
  String get featureSafeBrowsingTitle => 'Google Safe Browsing API (स्तरः 6)';

  @override
  String get featureSafeBrowsingDesc =>
      'कोटिशः ज्ञातानां दुष्ट-URL-नाम्नां, दुष्टतन्त्रांश-केन्द्राणां, सामाजिक-वञ्चना-स्थानानां च विरुद्धम् ऐच्छिकं मेघ-सङ्कट-ज्ञानम्।';

  @override
  String get featureSafeBrowsingChip1 => 'Google-सङ्कट-कोशः';

  @override
  String get featureSafeBrowsingChip2 => 'स्थानीय-कुञ्चिका';

  @override
  String get featureSafeBrowsingChip3 => 'दैनिक-सीमा-मापकः';

  @override
  String get featureQuishingGuardTitle =>
      'क्विशिंग-रक्षकः™: भौतिक-विकृति-ज्ञानम्';

  @override
  String get featureQuishingGuardDesc =>
      'QR-उपरि लग्नानि आवरण-पत्राणि, प्रान्त-विच्छेदान्, सूक्ष्म-छायाः, मुद्रण-कणान् च अभिजानाति सङ्गणक-दृष्टिः।';

  @override
  String get featureQuishingGuardChip1 => 'लग्न-पत्राणि';

  @override
  String get featureQuishingGuardChip2 => 'प्रान्त-विच्छेदः';

  @override
  String get featureQuishingGuardChip3 => 'मुद्रणकण-विश्लेषणम्';

  @override
  String get featureArCodeVisionTitle => 'AR-सङ्केतदृष्टिः™ स्थानिक-HUD';

  @override
  String get featureArCodeVisionDesc =>
      'AR-बहुदण्डलेखा-अन्वीक्षकः — सर्वेषां लब्ध-सङ्केतानाम् उपरि सजीव-सुरक्षा-चिह्नैः युक्तानि चिप्-पत्राणि दर्शयति। समूहचयनम् अपि शक्यम्।';

  @override
  String get featureArCodeVisionChip1 => 'स्थानिकानुसरणम्';

  @override
  String get featureArCodeVisionChip2 => 'बहुसङ्केत-HUD';

  @override
  String get featureArCodeVisionChip3 => 'समूहचयनम्';

  @override
  String get featureAirQrTitle => 'वायु-क्यूआर™ प्रकाश-दत्तांश-प्रवाहः';

  @override
  String get featureAirQrDesc =>
      'Wi-Fi Bluetooth वा विना, पूर्णतया जालरहितं, गूढ-पाठं सञ्चिकाः कुञ्चिकाः च चलत्-QR-द्वारा शीघ्रं प्रेषयति गृह्णाति च।';

  @override
  String get featureAirQrChip1 => 'चलत्-QR';

  @override
  String get featureAirQrChip2 => 'Reed-Solomon FEC';

  @override
  String get featureAirQrChip3 => '100% जालरहितम्';

  @override
  String get featureStegoQrTitle => 'स्टेगो-क्यूआर™ गुप्तलेख-अन्वीक्षकः';

  @override
  String get featureStegoQrDesc =>
      'विशिष्ट-QR-सङ्केतेषु अदृश्यरूपेण निहितं गूढ-विषयं जलचिह्नित-दत्तांशं च अन्विष्य बहिः आनयति।';

  @override
  String get featureStegoQrChip1 => 'छद्म-QR-पठनम्';

  @override
  String get featureStegoQrChip2 => 'AES-विगूहनम्';

  @override
  String get featureStegoQrChip3 => 'जैविक-प्रवेशः';

  @override
  String get featureWifiTitle => 'Wi-Fi सद्यः सम्बन्धः';

  @override
  String get featureWifiDesc =>
      'WPA/WPA2/WPA3 जाल-प्रमाणानि पठित्वा जाल-सूचनां दर्शयति, कूटशब्दं प्रतिलिखति, एकस्पर्शेन Wi-Fi-विन्यासम् उद्घाटयति।';

  @override
  String get featureWifiChip1 => 'WPA3, WPA2';

  @override
  String get featureWifiChip2 => 'एकस्पर्श-सम्बन्धः';

  @override
  String get featureWifiChip3 => 'कूटशब्द-दर्शनम्';

  @override
  String get featurePaymentsTitle => 'UPI-गूढमुद्रा-धनप्रेषणम्';

  @override
  String get featurePaymentsDesc =>
      'भारतीय-UPI-QR-सङ्केतान् (GPay, PhonePe, Paytm प्रति प्रेषयति) Bitcoin/Ethereum/Solana-गूढमुद्रा-सङ्केतान् च धनराशिना सह पठति।';

  @override
  String get featurePaymentsChip1 => 'UPI-अनुप्रयोगः';

  @override
  String get featurePaymentsChip2 => 'गूढमुद्रा-कोशाः';

  @override
  String get featurePaymentsChip3 => 'SEPA-प्रेषणम्';

  @override
  String get featureTotpTitle => 'TOTP द्विघटक-प्रमाणीकरणम्';

  @override
  String get featureTotpDesc =>
      '2FA-सज्जीकरण-सङ्केतान् अन्वीक्ष्य वृत्ताकार-गणनया सह सजीव-षडङ्क-OTP दर्शयति। प्रमाणीकरण-अनुप्रयोगेषु योजयितुं शक्यते।';

  @override
  String get featureTotpChip1 => 'सजीव-सङ्केताः';

  @override
  String get featureTotpChip2 => 'दृश्य-गणना';

  @override
  String get featureTotpChip3 => 'अनुप्रयोगे योजनम्';

  @override
  String get featureContactsTitle => 'सम्पर्क-vCard-आयातः';

  @override
  String get featureContactsDesc =>
      'vCard 2.1/3.0/4.0 MeCard-सम्पर्क-सङ्केतान् च पठति। एकस्पर्शेन दूरवाणी-आह्वानं, विद्युत्पत्र-लेखनं, सम्पर्कसूच्यां रक्षणं च।';

  @override
  String get featureContactsChip1 => 'vCard 4.0';

  @override
  String get featureContactsChip2 => 'एकस्पर्श-रक्षणम्';

  @override
  String get featureContactsChip3 => 'आह्वानं विद्युत्पत्रम्';

  @override
  String get featureCalendarTitle => 'दिनदर्शिका-घटनाः';

  @override
  String get featureCalendarDesc =>
      'आरम्भ-अन्त-समयैः, स्थानैः, विवरणैः च युक्तान् iCalendar VEVENT पठित्वा साक्षात् यन्त्रस्य दिनदर्शिकायां योजयति।';

  @override
  String get featureCalendarChip1 => 'iCal-पठनम्';

  @override
  String get featureCalendarChip2 => 'आरम्भ/अन्त-समयः';

  @override
  String get featureCalendarChip3 => 'दिनदर्शिकायां योजनम्';

  @override
  String get featureGeoTitle => 'भौगोलिक-स्थानं मार्गदर्शनं च';

  @override
  String get featureGeoDesc =>
      'geo: निर्देशाङ्कान् अन्वेषण-पदानि च पठित्वा Google Maps द्वारा सद्यः मार्गं दर्शयति।';

  @override
  String get featureGeoChip1 => 'अक्षांश/रेखांशौ';

  @override
  String get featureGeoChip2 => 'Google Maps-सम्बन्धः';

  @override
  String get featureGeoChip3 => 'अन्वेषण-पदानि';

  @override
  String get featureScanHistoryTitle => 'सम्पूर्णः स्थानीय-अन्वीक्षण-इतिहासः';

  @override
  String get featureScanHistoryDesc =>
      'प्रत्येकम् अन्वीक्षणं वर्गेण, सुरक्षा-अङ्केन, समयेन, तारकेण च सह यन्त्रे एव रक्षति। सजीव-पूर्णपाठ-अन्वेषणम् अपि।';

  @override
  String get featureScanHistoryChip1 => 'पूर्णपाठ-अन्वेषणम्';

  @override
  String get featureScanHistoryChip2 => 'वर्ग-छालनी';

  @override
  String get featureScanHistoryChip3 => 'प्रिय-तारकाः';

  @override
  String get featureBackupsTitle => 'JSON-CSV-सञ्चयाः';

  @override
  String get featureBackupsDesc =>
      'सम्पूर्णम् अन्वीक्षण-इतिहासं CSV-सारणीरूपेण गूढ-JSON-सञ्चयरूपेण वा निर्यातयतु। एकस्पर्शेन पुनःस्थापनम्।';

  @override
  String get featureBackupsChip1 => 'CSV-सारणी';

  @override
  String get featureBackupsChip2 => 'JSON-सञ्चयः';

  @override
  String get featureBackupsChip3 => 'एकस्पर्श-पुनःस्थापनम्';

  @override
  String get featureBiometricGuardTitle => 'जैविक-पटल-सुरक्षा';

  @override
  String get featureBiometricGuardDesc =>
      'गुप्त-StegoQR-विषयम् इतिहासं च अङ्गुलिमुद्रा-मुख-प्रमाणीकरणेन रक्षति। पटलचित्र-ग्रहणं निवारयति (FLAG_SECURE)।';

  @override
  String get featureBiometricGuardChip1 => 'जैविक-प्रमाणम्';

  @override
  String get featureBiometricGuardChip2 => 'पटलचित्र-निरोधः';

  @override
  String get featureBiometricGuardChip3 => 'गूढ-सङ्ग्रहः';

  @override
  String get featureOfflinePrivacyTitle => '100% स्थानीय-गोपनीयता';

  @override
  String get featureOfflinePrivacyDesc =>
      'दण्डलेखानाम् अन्वीक्षणं विकोडनं विश्लेषणं च पूर्णतया भवतः दूरवाण्याम् एव। स्वतः कोऽपि दत्तांशः बहिः न प्रेष्यते।';

  @override
  String get featureOfflinePrivacyChip1 => 'दूरमापनं नास्ति';

  @override
  String get featureOfflinePrivacyChip2 => 'विज्ञापनानि न';

  @override
  String get featureOfflinePrivacyChip3 => 'मुक्त-स्रोतः';

  @override
  String get helpCenterHeaderTitle => 'साहाय्यकेन्द्रं मार्गदर्शिका च';

  @override
  String get helpCenterHeaderSubtitle =>
      'अनुप्रयोगस्य सर्वेषां वैशिष्ट्यानां विवरणात्मकानि सूत्राणि पठतु।';

  @override
  String get decryptPayloadAction => 'उद्घाट्यताम्';

  @override
  String get decryptPayloadTitle => 'विषयः उद्घाट्यताम्';

  @override
  String get decryptPayloadDescription =>
      'गूढ-विषयस्य उद्घाटनाय कूटवाक्यं लिख्यताम्।';

  @override
  String get cipherModeLabel => 'गूढ-प्रकारः';

  @override
  String get cipherModeAuto => 'स्वचालितम् / सामान्यम्';

  @override
  String get cipherModeAesGcm => 'AES-256-GCM (PBKDF2 SHA-256)';

  @override
  String get cipherModeAesCbc => 'AES-256-CBC';

  @override
  String get airQrCodeLabel => 'सत्र-सङ्केतः';

  @override
  String get airQrCodeHint => 'यथा ABC-DEF';

  @override
  String get airQrDetectedTitle => 'वायु-क्यूआर गूढ-हस्तान्तरणम्';

  @override
  String get airQrDetectedSubtitle =>
      'अत्र गूढ-प्रकाश-हस्तान्तरणमस्ति। उद्घाटनाय प्रेषक-यन्त्रे दृष्टं सत्र-सङ्केतं लिखन्तु।';

  @override
  String get jsonEnvelopeDetectedTitle => 'गूढसञ्चिकाभाण्डारम्';

  @override
  String get jsonEnvelopeDetectedSubtitle =>
      'अस्मिन् सङ्केते गूढदत्तांशः वर्तते। उद्घाटनाय कूटशब्दं ददातु।';

  @override
  String get decryptedContentLabel => 'उद्घाटित-विषयः:';

  @override
  String get manualDecryptionFailed => 'गूढोद्घाटने दोषः। कूटशब्दं सत्यापयतु।';

  @override
  String get emailCardTitle => 'विद्युत्पत्र-सङ्केतः';

  @override
  String get emailSendButton => 'विद्युत्पत्रं प्रेष्यताम्';

  @override
  String get emailCopyButton => 'प्रतिलिख्यताम्';

  @override
  String get emailLaunchFailed => 'विद्युत्पत्र-अनुप्रयोगः न उद्घाटितः।';

  @override
  String get emailSubjectLabel => 'विषयः';

  @override
  String get emailBodyLabel => 'सन्देशः';

  @override
  String get phoneCardTitle => 'दूरवाणी-सङ्ख्या';

  @override
  String get phoneCallButton => 'आहूयताम्';

  @override
  String get phoneCopyButton => 'प्रतिलिख्यताम्';

  @override
  String get phoneLaunchFailed => 'दूरवाणी न उद्घाटिता।';

  @override
  String get smsCardTitle => 'लघुसन्देशः';

  @override
  String get smsSendButton => 'सन्देशः प्रेष्यताम्';

  @override
  String get smsCopyButton => 'प्रतिलिख्यताम्';

  @override
  String get smsLaunchFailed => 'सन्देश-अनुप्रयोगः न उद्घाटितः।';

  @override
  String get smsBodyLabel => 'सन्देशः';

  @override
  String get appLinkCardTitle => 'अनुप्रयोगसम्पर्कः';

  @override
  String get appLinkOpenButton => 'अनुप्रयोगाभ्यन्तरे उद्घाटयतु';

  @override
  String get appLinkLaunchFailed =>
      'इदम् उद्घाटयितुं न शक्तम्। अनुप्रयोगः स्थापितः वा इति परीक्षताम्।';

  @override
  String get productBarcodeCardTitle => 'उत्पाद-दण्डलेखा';

  @override
  String get productSearchFoodButton => 'खाद्यविवरणम्';

  @override
  String get productSearchWebButton => 'जालेऽन्विष्यताम्';

  @override
  String get productCopyButton => 'दण्डलेखा प्रतिलिख्यताम्';

  @override
  String get productLaunchFailed => 'उत्पाद-अन्वेषणं न उद्घाटितम्।';

  @override
  String get isbnCardTitle => 'पुस्तकम् (ISBN)';

  @override
  String get isbnGoogleBooksButton => 'गूगल-पुस्तकानि';

  @override
  String get isbnOpenLibraryButton => 'मुक्त-ग्रन्थालयः';

  @override
  String get isbnCopyButton => 'ISBN प्रतिलिख्यताम्';

  @override
  String get isbnLaunchFailed => 'पुस्तक-अन्वेषणं न उद्घाटितम्।';

  @override
  String get historyFilterEmail => 'विद्युत्पत्रम्';

  @override
  String get historyFilterPhone => 'दूरवाणी';

  @override
  String get historyFilterSms => 'सन्देशः';

  @override
  String get historyFilterAppLink => 'सेतुः';

  @override
  String get historyFilterProductBarcode => 'उत्पादः';

  @override
  String get historyFilterIsbn => 'पुस्तकम्';

  @override
  String get scanFlashOff => 'दीपः: निष्क्रियः';

  @override
  String get scanFlashOn => 'दीपः: सक्रियः';

  @override
  String get scanFlashAuto => 'दीपः: स्वयञ्चालितः';

  @override
  String scanFlashAutoActive(String lux) {
    return 'स्वयञ्चालितदीपः सक्रियः ($lux lux)';
  }

  @override
  String get scanFlashAutoSensorUnavailable =>
      'अस्मिन् यन्त्रे प्रकाशसंवेदकः नास्ति';

  @override
  String get cameraTuneTooltip => 'चित्रग्राहीसंस्काराः';

  @override
  String get cameraTuneTitle => 'चित्रग्राहीसंस्काराः';

  @override
  String get cameraBrightnessLabel => 'द्युतिः';

  @override
  String get cameraContrastLabel => 'वैषम्यम्';

  @override
  String get cameraInvertLabel => 'वर्णव्युत्क्रमः (प्रतिलोमान्वीक्षणम्)';

  @override
  String get cameraInvertHint => 'कृष्णपृष्ठे श्वेतसङ्केतानाम् अन्वीक्षणाय';

  @override
  String get cameraResolutionLabel => 'चित्रग्राहिसङ्कल्पना';

  @override
  String get cameraResolutionFullHd => 'पूर्ण-HD (१०८०p - संस्तुतम्)';

  @override
  String get cameraResolutionMax => 'महत्तमम् (४K UHD)';

  @override
  String get cameraResolutionHd => 'HD (७२०p - मन्दशक्तिः)';

  @override
  String get cameraResetAdjustments => 'संस्कारान् पुनरनुकूलयतु';

  @override
  String get cameraFocusTapHint => 'संकेन्द्रणाय प्रकाशाय च स्पृशतु';

  @override
  String get settingsLanguageTitle => 'भाषा';

  @override
  String get settingsLanguageSubtitle => 'अनुप्रयोगप्रदर्शनभाषां चिनोतु';

  @override
  String get languageSystemDefault => 'तन्त्रमानकम्';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageMalayalam => 'മലയാളം';

  @override
  String get languageSanskrit => 'संस्कृतम्';

  @override
  String aboutCopyright(String year) {
    return '© $year Sreeraj P. All rights reserved.';
  }

  @override
  String apiQuotaPercentageUsed(String percentage) {
    return '$percentage% उपभुक्तम्';
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
  String get tooltipAirQrTransmitter => 'वायु-क्यूआर् प्रेषकं प्रति गच्छतु';

  @override
  String get airQrModeText => 'स्वेच्छापाठः';

  @override
  String get airQrModeSync => 'उपकरणतुल्यकालिकता';

  @override
  String airQrSyncIncludeHistory(int count) {
    return 'अवलोकनवृत्तं योजयतु ($count)';
  }

  @override
  String get airQrSyncIncludeSettings => 'अनुप्रयोगसंविधानानि योजयतु';

  @override
  String get airQrSyncPassphraseLabel => 'तुल्यकालनगुप्तपदम् / पिन्';

  @override
  String get airQrSyncPassphraseHint => 'गूढपदं लिखतु';

  @override
  String get airQrSyncGeneratePin => 'पिन्-सङ्ख्यां रचयतु';

  @override
  String get airQrSyncBeamButton => 'वृत्तं संविधानानि च प्रेषयतु';

  @override
  String get airQrSyncNoDataWarning => 'वृत्तं संविधानानि वा चिनोतु।';

  @override
  String get airQrSyncPackageDetected => 'एयर्-क्यु-आर् संवृतसञ्चिका';

  @override
  String airQrSyncPackageSummary(int records) {
    return '$records अवलोकनवृत्तानि संविधानानि च सन्ति';
  }

  @override
  String get airQrSyncEnterPassphrase => 'उद्घाटयितुं गुप्तपदं लिखतु';

  @override
  String get airQrSyncRestoreHistory => 'अवलोकनवृत्तं पुनस्स्थापयतु';

  @override
  String get airQrSyncApplySettings => 'संविधानानि प्रयोजयतु';

  @override
  String get airQrSyncDecryptButton => 'उद्घाट्य तुल्यकालीकरोतु';

  @override
  String airQrSyncSuccess(int count) {
    return '$count वृत्तानि संविधानानि च तुल्यकालीकृतानि!';
  }

  @override
  String get airQrSyncBeamAction => 'एयर्-क्यु-आर् द्वारा प्रेषयतु';

  @override
  String get airQrSyncSettingsTitle => 'एयर्-क्यु-आर् तुल्यकालनम्';

  @override
  String get airQrSyncSettingsSubtitle =>
      'सञ्जालं विना अन्योपकरणाय वृत्तं प्रेषयतु';

  @override
  String get tabScan => 'संवीक्षा';

  @override
  String get tabCodeForge => 'कोड-सृजनम्';

  @override
  String get tabHistory => 'इतिहासः';

  @override
  String get codeForgeTitle => 'कोड-सृजनम्';

  @override
  String get codeForgeSubtitle => 'सङ्केत-सृजन-शाला';

  @override
  String get codeForgeBarcodeType => 'सङ्केतप्रकारः';

  @override
  String get codeForgePayloadType => 'विषयप्रकारः';

  @override
  String get codeForgePresetText => 'पाठ्यम्';

  @override
  String get codeForgeTextHint =>
      'स्पष्टाय सुकराय च क्रमवीक्षणाय पाठ्यं ५०० वर्णेभ्यः न्यूनं स्थापयतु';

  @override
  String get codeForgeLoadFromFile => 'सञ्चिकातः पठतु';

  @override
  String get codeForgeLoadFromFileTooltip =>
      'QR-संकेत-निर्माणाय सञ्चिकातः पाठं स्वीकरोतु';

  @override
  String get codeForgeFileEmpty => 'चितसञ्चिका रिक्ता अस्ति।';

  @override
  String get codeForgeFileTruncated =>
      'एकस्मिन् त्वरित-स्कैन-QR-संकेते समावेशनाय पाठः ५०० वर्णेभ्यः सीमितः कृतः।';

  @override
  String get codeForgeFileLoaded => 'सञ्चिकायाः पाठः सफलतया स्वीकृतः।';

  @override
  String get codeForgeFileReadError => 'चितसञ्चिकायाः पठने असमर्थः।';

  @override
  String get codeForgePresetUrl => 'जालसङ्केतः';

  @override
  String get codeForgePresetWifi => 'वै-फाई';

  @override
  String get codeForgePresetContact => 'सम्पर्कः';

  @override
  String get codeForgePresetUpi => 'युपीआई';

  @override
  String get codeForgePresetSms => 'सन्देशः';

  @override
  String get codeForgePresetEmail => 'विद्युत्पत्रम्';

  @override
  String get codeForgePresetGeo => 'स्थानम्';

  @override
  String get codeForgeWifiSsid => 'संजालनाम (SSID)';

  @override
  String get codeForgeWifiPassword => 'कूटशब्दः';

  @override
  String get codeForgeWifiSecurity => 'सुरक्षा';

  @override
  String get codeForgeWifiHidden => 'गूढसंजालम्';

  @override
  String get codeForgeContactName => 'पूर्णनाम';

  @override
  String get codeForgeContactPhone => 'दूरवाणी-सङ्ख्या';

  @override
  String get codeForgeContactEmail => 'विद्युत्पत्र-सङ्केतः';

  @override
  String get codeForgeContactOrg => 'संस्था';

  @override
  String get codeForgeContactTitle => 'पदम्';

  @override
  String get codeForgeContactUrl => 'जालस्थानम्';

  @override
  String get codeForgeUpiVpa => 'युपीआई-सङ्केतः';

  @override
  String get codeForgeUpiName => 'प्राप्तुर्नाम';

  @override
  String get codeForgeUpiAmount => 'राशिः (रूप्यकम्)';

  @override
  String get codeForgeUpiNote => 'टिप्पणी';

  @override
  String get codeForgeSmsPhone => 'दूरवाणी-सङ्ख्या';

  @override
  String get codeForgeSmsMessage => 'सन्देशः';

  @override
  String get codeForgeEmailTo => 'विद्युत्पत्र-सङ्केतः';

  @override
  String get codeForgeEmailSubject => 'विषयः';

  @override
  String get codeForgeEmailBody => 'सन्देशः';

  @override
  String get codeForgeGeoLat => 'अक्षांशः';

  @override
  String get codeForgeGeoLng => 'रेखांशः';

  @override
  String get codeForgeGeoUseMyLocation => 'मम स्थानम्';

  @override
  String get codeForgeGeoFetching => 'स्थानं प्राप्यते…';

  @override
  String get codeForgeGeoFailed => 'स्थानं न प्राप्तम्';

  @override
  String get codeForgeGeoPermissionDenied => 'स्थान-अनुज्ञा निराकृता';

  @override
  String get codeForgeDesignStudio => 'संरचना-विन्यासः';

  @override
  String get codeForgeEyeShape => 'नेत्राकारः';

  @override
  String get codeForgeEyeBallShape => 'तारकाकारः';

  @override
  String get codeForgePatternShape => 'बिन्दुरुपाणि';

  @override
  String get codeForgeShapeSquare => 'चतुरस्रम्';

  @override
  String get codeForgeShapeDots => 'बिन्दवः';

  @override
  String get codeForgeShapeRounded => 'वर्तुलाकारम्';

  @override
  String get codeForgeShapeClassy => 'चारुरुपम्';

  @override
  String get codeForgeShapeDiamond => 'वज्राकारम्';

  @override
  String get codeForgeShapeLeaf => 'पर्णाकारम्';

  @override
  String get codeForgeShapeCircle => 'मण्डलाकारम्';

  @override
  String get codeForgeColorStudio => 'वर्णसंयोजनम्';

  @override
  String get codeForgeFgColor => 'अग्रवर्णः';

  @override
  String get codeForgeBgColor => 'पृष्ठवर्णः';

  @override
  String get codeForgeEyeOuterColor => 'नेत्र-परिवेषः';

  @override
  String get codeForgeEyeInnerColor => 'नेत्र-तारका';

  @override
  String get codeForgeGradientNone => 'एकवर्णः';

  @override
  String get codeForgeGradientSunset => 'सूर्यास्तः';

  @override
  String get codeForgeGradientOcean => 'सागरः';

  @override
  String get codeForgeGradientNeon => 'प्रभा';

  @override
  String get codeForgeGradientGold => 'राजस्वर्णम्';

  @override
  String get codeForgeErrorCorrection => 'त्रुटि-शोधनम्';

  @override
  String get codeForgeCenterBadge => 'केन्द्र-चिह्नम्';

  @override
  String get codeForgeBadgeNone => 'किमपि न';

  @override
  String get codeForgeBadgeIcon => 'विषय-चिह्नम्';

  @override
  String get codeForgeBadgeShield => 'सुरक्षा-फलकम्';

  @override
  String get codeForgeExportPng => 'चित्रांश-भाजनम्';

  @override
  String get codeForgeExportSvg => 'सदिश-भाजनम्';

  @override
  String get codeForgeCopyPayload => 'प्रतिलिख्यताम्';

  @override
  String get codeForgeCopied => 'विषयः फलके प्रतिलेखितः';

  @override
  String get codeForgeSafeVerified => 'षड्विध-सुरक्षा-तन्त्रेण प्रमाणीकृतम्';

  @override
  String get codeForgeResetStyle => 'विन्यासः प्रत्यानयताम्';

  @override
  String get codeForgeIncludeText => 'सङ्ख्या दृश्यताम्';

  @override
  String get codeForgePreview => 'प्रत्यक्ष-प्रदर्शनम्';

  @override
  String get onboardingSkip => 'त्यजतु';

  @override
  String get onboardingNext => 'अग्रिमम्';

  @override
  String get onboardingGetStarted => 'स्कैन आरभताम्';

  @override
  String get onboardingSlide1Badge => 'षट्स्तरीयरक्षा';

  @override
  String get onboardingSlide1Title => 'षट्स्तरीय-यूआरएल-सुरक्षा-यन्त्रम्';

  @override
  String get onboardingSlide1Description =>
      'उद्घाटनात् पूर्वं प्रत्येकः सम्पर्कतन्तुः षण्णां रक्षास्तराणां द्वारा परीक्ष्यते। एतत् कपटजालात्, वञ्चकपुनर्निर्देशनात्, कूटडोमेनात् च रक्षति।';

  @override
  String get onboardingSlide1Bullet1 => 'प्रोटोकॉल-कूटडोमेन-कवचम्';

  @override
  String get onboardingSlide1Bullet2 => 'टीएलडी-एन्ट्रोपी-पोर्ट-परीक्षणम्';

  @override
  String get onboardingSlide1Bullet3 => 'गोप्यपरीक्षणं सुरक्षितअन्वेषणं च';

  @override
  String get onboardingSlide2Badge => 'सङ्गणकदृष्टिः';

  @override
  String get onboardingSlide2Title => 'क्विशिङ्गगार्ड-विकृति-शोधनम्';

  @override
  String get onboardingSlide2Description =>
      'वास्तविकसङ्केतानाम् उपरि आरोपितान् कपट-क्यूआर-पत्रकान् क्विशिङ्गगार्ड-यन्त्रं परीक्षते। स्कैनकरणात् पूर्वं भित्तीः, छायाः, पत्राकारांश्च अवलोकयति।';

  @override
  String get onboardingSlide2Bullet1 => 'आरोपितपत्रकस्य शोधनम्';

  @override
  String get onboardingSlide2Bullet2 => 'छिन्नधाराणां छायासीम्नां च परीक्षणम्';

  @override
  String get onboardingSlide2Bullet3 => 'प्रत्यक्ष-दृश्यचक्र-परीक्षणम्';

  @override
  String get onboardingSlide3Badge => 'क्लाउड-रहितम् • अनुवर्तन-शून्यम्';

  @override
  String get onboardingSlide3Title => 'शतप्रतिशतम् अफलाइन-गोपनीयता';

  @override
  String get onboardingSlide3Description =>
      'भवतः सङ्केतलेखाः वैयक्तिकविवरणानि च कदापि दूरभाषं न त्यजन्ति। अत्र न विश्लेषणानि, न विज्ञापनं, न च अनुवर्तकाः।';

  @override
  String get onboardingSlide3Bullet1 => 'गूढलिखितं स्थानिक-दत्तांशस्थानम्';

  @override
  String get onboardingSlide3Bullet2 => 'एयर्-क्यूआर-दृश्यक-स्थानान्तरणम्';

  @override
  String get onboardingSlide3Bullet3 => 'विश्लेषण-रहितं सुरक्षित-रचना';

  @override
  String get settingsOnboardingTourTitle => 'स्वागत-परिचय-प्रवासः';

  @override
  String get settingsOnboardingTourSubtitle =>
      'सुरक्षा-गोपनीयता-वैशिष्ट्यानां त्रिफलक-परिचयं पुनः पश्यतु';

  @override
  String get batchScanMode => 'गणस्कैनिङ्ग्-रीतिः';

  @override
  String get batchModeTooltip => 'संतत-गणस्कैनिङ्ग्';

  @override
  String get batchModeEnabledToast => 'संतत-गणस्कैनिङ्ग् सक्रियम्';

  @override
  String get batchModeDisabledToast => 'संतत-गणस्कैनिङ्ग् निष्क्रियम्';

  @override
  String batchCounterBadge(int count) {
    return '$count स्कानिनानि';
  }

  @override
  String get batchReviewTitle => 'गणस्कैन्-सूची';

  @override
  String get batchReviewSubtitle => 'संततस्कैनिङ्ग्-पङ्क्तिः';

  @override
  String get batchEmptyTitle => 'गणे कोडाः अविद्यमानाः';

  @override
  String get batchEmptySubtitle =>
      'कॅमरां विना त्यक्त्वा संतततया कोडान् स्कैन् कुरु।';

  @override
  String get batchExport => 'गणनिर्यातयतु';

  @override
  String get batchClear => 'गणं रिक्तीकुरु';

  @override
  String get batchClearConfirmTitle => 'गणं रिक्तीकरोतु वा?';

  @override
  String get batchClearConfirmContent =>
      'किं भवान् अस्य गणस्य सर्वान् कोडान् निष्कासयितुम् इच्छति?';

  @override
  String get batchPreventDuplicates => 'पुनरावृत्तिनिवारणम्';

  @override
  String batchScannedToast(int count, String content) {
    return 'स्कानितम् #$count: $content';
  }

  @override
  String get batchSafeUrl => 'सुरक्षितसम्पर्कः';

  @override
  String get batchSuspiciousUrl => 'संदिग्धसम्पर्कः';

  @override
  String get batchAnalyzingUrl => 'सम्पर्कविश्लेषणं प्रचलति...';

  @override
  String batchUrlSafetySummary(int safeCount, int warningCount, int totalUrls) {
    return '$totalUrls सम्पर्कैः $safeCount सुरक्षिताः, $warningCount संदिग्धाः';
  }

  @override
  String get batchItemDetailsTitle => 'स्कानितकोडविवरणम्';

  @override
  String batchFormatLabel(String format) {
    return 'प्ररूपः: $format';
  }

  @override
  String batchTimeLabel(String time) {
    return 'स्कानितसमयः: $time';
  }

  @override
  String get cameraDistanceEnhanceLabel => 'दूरस्थवीक्षणसहायः';

  @override
  String get cameraDistanceEnhanceHint =>
      'दूरस्थचित्रपट्टानां कृते विस्तारकर्तनं तीक्ष्णीकरणं च';

  @override
  String get cameraUnsharpLabel => 'धारातीक्ष्णीकरणम्';

  @override
  String get cameraDistanceZoomLabel => 'दूरविस्तारः';

  @override
  String get scanDistanceModeTooltip => 'दूरस्थवीक्षणसहायः';

  @override
  String get scanDistanceModeActive => 'दूरस्थविधिः सक्रियः';

  @override
  String get scanFromClipboard => 'फलकात् स्कैन् कुर्वन्तु';

  @override
  String get clipboardBannerTitle => 'फलके सामग्री प्राप्ता';

  @override
  String get clipboardActionScan => 'स्कैन् क्रियताम्';

  @override
  String get clipboardDismiss => 'निरस्यतु';

  @override
  String get clipboardEmptyMessage => 'फलकं रिक्तम्';

  @override
  String get clipboardNoValidContent =>
      'फलके कोऽपि स्कैन्-योग्यः सङ्केतः न प्राप्तः';

  @override
  String get clipboardTypeUrl => 'सम्पर्कतन्तुः';

  @override
  String get clipboardTypeBarcode => 'बारकोड-दत्तांशः';

  @override
  String get clipboardTypeImage => 'चित्रम्';

  @override
  String get clipboardTypeText => 'पाठः';

  @override
  String get multiCodeDetectedBanner =>
      'बहवः सङ्केताः दृष्टाः। स्कैनाय सङ्केतं स्पृशतु।';

  @override
  String get multiCodeTapToScan => 'स्कैनाय स्पृशतु';

  @override
  String get multiCodeSelectionTitle => 'बहु-सङ्केत-चयनम्';

  @override
  String get multiCodeSelectionSubtitle =>
      'यदा बहवः स्युः तदा दृश्यसङ्केतान् रूपरेखयित्वा चयनार्थं स्पृशतु';

  @override
  String get multiCodeDismissTooltip => 'चयनं निराकरोतु';

  @override
  String get ghostScanTitle => 'छायावीक्षणम्';

  @override
  String get ghostScanSubtitle => 'पटपुटस्थ-क्यु-आर्-अन्वेषकम्';

  @override
  String get ghostScanDescription =>
      'कस्यामपि प्रयुक्तौ पटपुटे दृश्यमानान् क्यु-आर्-सङ्केतान् छायाचित्रणं विना अभिजानातु।';

  @override
  String get ghostScanTileLabel => 'छायावीक्षणम्';

  @override
  String get ghostScanActionScanNow => 'अधुना पटपुटं वीक्षताम्';

  @override
  String get ghostScanActionAddTile => 'शीघ्रसंयोजन-पट्टिका योज्यताम्';

  @override
  String get ghostScanTileAdded => 'शीघ्रसंयोजन-पट्टिकानुरोधः प्रेषितः';

  @override
  String get ghostScanHowItWorksTitle => 'छायावीक्षणस्य उपयोगविधिः';

  @override
  String get ghostScanStep1 =>
      'कस्यामपि प्रयुक्तौ शीघ्रसंयोजन-छादनम् अधः आकर्षतु।';

  @override
  String get ghostScanStep2 =>
      'पटपुटस्य क्यु-आर्-सङ्केतं पठितुं छायावीक्षण-पट्टिकां स्पृशतु।';

  @override
  String get ghostScanStep3 =>
      'चित्रागारे रक्षणं विना एव सङ्केतः सद्यः पठ्यते।';

  @override
  String get ghostScanAnalyzing => 'पटपुटविषयस्य विश्लेषणं क्रियते...';

  @override
  String get ghostScanNoCodeFound =>
      'पटपुटे कश्चिदपि क्यु-आर्-सङ्केतः न दृष्टः';

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
      'लब्धान् सर्वान् सङ्केतान् विशिष्टे अधःपत्रे परीक्ष्य एकेन स्पर्शेन संवीक्षा-इतिहासे रक्षतु।';

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
      'चितानां सर्वेषां विषयम् एकेन स्पर्शेन प्रतिलिखतु, इतिहासे वा निर्यातयतु।';

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
  String get titleHelpHistory => 'इतिहासः गोपनीयता च';

  @override
  String get helpGuideHistoryName => 'इतिहासः, प्रतिलिपिः, गोपनीयता च';

  @override
  String get helpGuideHistorySummary =>
      'अन्तर्जालरहितः SQLite-दत्तांशकोशः, JSON/CSV-प्रतिलिपयः, जैवमापन-प्रमाणीकरणं, पटलचित्र-रक्षणं च।';

  @override
  String get helpGuideHistoryIntro =>
      'भवतः संवीक्षा-अभिलेखाः केवलं भवतः एव। श्रीराज् पि क्यू-आर-कार्यशाला सर्वान् इतिहास-अभिलेखान् भवतः यन्त्रे स्थानीये SQLite-दत्तांशकोशे रक्षति, जैवमापन-प्रमाणीकरण-रक्षया सुव्यवस्थित-निर्यात-प्रारूपैः च सह।';

  @override
  String get helpGuideHistoryManageTitle => 'संवीक्षा-इतिहास-प्रबन्धनम्';

  @override
  String get helpGuideHistoryManageBullet1 =>
      'अन्वेषणं पृथक्करणं च: पाठेन संवीक्षा-इतिहासं तत्क्षणम् अन्विष्यतु, विषय-प्रकारानुसारं (URL, Wi-Fi, सम्पर्काः, देयानि, TOTP) वा पृथक् करोतु।';

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
      'JSON-पूर्णप्रतिलिपिः: स्वकीय-अङ्कनानि, प्रियाः, सुरक्षा-परिणामाः च इत्येतैः सहितं सम्पूर्णम् इतिहासं सुवहनीयायां .json-सञ्चिकायां निर्यातयति।';

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
      'जैवमापन-प्रमाणीकरणम्: संवेदनशीलान् गुप्त-StegoQR-अभिलेखान् यन्त्रस्य अङ्गुलिमुद्रया मुखाभिज्ञानेन वा रक्षति।';

  @override
  String get helpGuideHistoryBiometricsBullet2 =>
      'पटलचित्र-रक्षणम्: पृष्ठभूमौ स्थितानि दुष्ट-अनुप्रयोगाणि अनधिकृत-दर्शकाः वा पटल-विषयम् आदातुं न शक्नुवन्ति (FLAG_SECURE)।';

  @override
  String get helpGuideHistoryTip =>
      'सूचना: दूरवाणी-परिवर्तनात् पुनःस्थापनात् वा पूर्वं रक्षितानां संवीक्षाणां रक्षणाय इतिहासस्य JSON-प्रतिलिपिं रचयतु।';

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
  String get resultMoreActions => 'अधिकाः क्रियाः';

  @override
  String get verdictChecking => 'सम्पर्कसूत्र-सुरक्षा परीक्ष्यते…';

  @override
  String get verdictNoIssues => 'न कोऽपि दोषः';

  @override
  String verdictIssuesFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दोषाः प्राप्ताः',
      one: '1 दोषः प्राप्तः',
    );
    return '$_temp0';
  }

  @override
  String verdictChecksPassed(int passed, int total) {
    return '$total परीक्षासु $passed सफलाः';
  }

  @override
  String get verdictSeeDetails => 'विवरणं दृश्यताम्';

  @override
  String get verdictModePrivate => 'एकान्त-विधिः';

  @override
  String get verdictModeActive => 'सक्रिय-परीक्षणम्';

  @override
  String safetyShowPassed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सफल-परीक्षाः दृश्यन्ताम्',
      one: '1 सफल-परीक्षा दृश्यताम्',
    );
    return '$_temp0';
  }

  @override
  String get safetyHidePassed => 'सफल-परीक्षाः गोपयतु';

  @override
  String safetySkippedGroup(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count परीक्षाः त्यक्ताः',
      one: '1 परीक्षा त्यक्ता',
    );
    return '$_temp0';
  }

  @override
  String get safetySkippedSetup => 'विन्यासेषु सज्जीकरोतु';

  @override
  String openRiskDialogIssues(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'अस्मिन् सूत्रे $count दोषाः सन्ति। तथापि उद्घाटयितुम् इच्छसि वा?',
      one: 'अस्मिन् सूत्रे 1 दोषः अस्ति। तथापि उद्घाटयितुम् इच्छसि वा?',
    );
    return '$_temp0';
  }

  @override
  String get sandboxShowPreview => 'पूर्वावलोकनं दर्शयतु';

  @override
  String get sandboxHidePreview => 'पूर्वावलोकनं गोपयतु';

  @override
  String quishingCompactGenuine(String percent) {
    return 'यथार्थ-मुद्रणम् · $percent%';
  }

  @override
  String get scanBubbleTitle => 'वीक्षण-बुद्बुदः';

  @override
  String get scanBubbleSettingsSubtitle =>
      'अन्यानुप्रयोगेषु दृश्यमानानां सङ्केतानां वीक्षणम्';

  @override
  String get scanBubbleSwitchTitle => 'बुद्बुद-प्रदर्शनम्';

  @override
  String get scanBubbleSwitchSubtitle =>
      'अन्यानुप्रयोगाणाम् उपरि प्लवमानः लघुः बुद्बुदः। पटपुटस्थं सङ्केतं वीक्षितुं तं स्पृशतु।';

  @override
  String get scanBubblePermissionGranted => 'अनुमतम्';

  @override
  String get scanBubblePermissionMissing =>
      'अद्यापि न अनुमतम्। बुद्बुदाय आवश्यकम्।';

  @override
  String get scanBubbleAllowButton => 'अनुमन्यताम्';

  @override
  String get scanBubbleStartOnBootTitle => 'पुनरारम्भोत्तर-आरम्भः';

  @override
  String get scanBubbleStartOnBootSubtitle =>
      'यदि बुद्बुदः सक्रियः आसीत्, दूरवाण्याः पुनरारम्भानन्तरं सः पुनः दृश्यते। केचन दूरवाण्यः एतत् निरुन्धन्ति।';

  @override
  String get scanBubbleAddTileButton => 'शीघ्रसंयोजने योज्यताम्';

  @override
  String get scanBubbleTileAdded => 'शीघ्रसंयोजन-पट्टिकानुरोधः प्रेषितः';

  @override
  String get scanBubbleTileManual =>
      'शीघ्रसंयोजन-छादनम् अधः आकर्षतु, सम्पादन-चिह्नं स्पृशतु, ततः वीक्षण-बुद्बुद-पट्टिकां तत्र आनयतु।';

  @override
  String get scanBubblePermissionDialogTitle => 'बुद्बुदस्य अनुमतिः';

  @override
  String get scanBubblePermissionDialogBody =>
      'अन्यानुप्रयोगाणाम् उपरि प्लवितुं बुद्बुदाय \"अन्यानुप्रयोगाणाम् उपरि प्रदर्शनम्\" इति अनुमतिः आवश्यकी। अग्रिमे पृष्ठे अस्मै अनुप्रयोगाय तां सक्रियां कृत्वा प्रत्यागच्छतु।';

  @override
  String get scanBubbleOpenSettings => 'विन्यासः उद्घाट्यताम्';

  @override
  String get scanBubbleStartFailed =>
      'बुद्बुदः आरब्धुं न अशक्यत। पुनः प्रयत्यताम्।';

  @override
  String get scanBubbleBlockedCapture =>
      'अयम् अनुप्रयोगः पटपुट-ग्रहणं निरुणद्धि, अतः तस्य सङ्केताः पठितुं न शक्यन्ते।';

  @override
  String get historySourceScreen => 'पटपुटात्';

  @override
  String get permissionOverlayTitle => 'अन्यानुप्रयोगाणाम् उपरि प्रदर्शनम्';

  @override
  String get permissionOverlayDesc =>
      'केवलं वीक्षण-बुद्बुदेन, तस्य सक्रियीकरणानन्तरम् एव प्रयुज्यते। बुद्बुदम् अन्यानुप्रयोगाणाम् उपरि स्थापयति।';

  @override
  String get permissionNotificationTitle => 'सूचनाः';

  @override
  String get permissionNotificationDesc =>
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
  String get codeForgeBarcodeContent => 'दण्डलेखा-विषयः';

  @override
  String get codeForgeBarcodeContentHint =>
      'दण्डलेखा-सङ्ख्यां सङ्केतं वा लिखतु';

  @override
  String get codeForgeWifiSecurityNone => 'न किमपि (मुक्तम्)';

  @override
  String get codeForgeUpiVpaHint => 'यथा merchant@upi';

  @override
  String get optionalFieldHint => 'ऐच्छिकम्';

  @override
  String get codeForgeContentEmpty => 'विषयः रिक्तः न भवेत्';

  @override
  String codeForgeTextTooLong(String max) {
    return 'पाठः $max वर्णेभ्यः अधिकः न भवेत्';
  }

  @override
  String get codeForgeWifiSsidRequired => 'वाइ-फाइ संजालनाम (SSID) आवश्यकम्';

  @override
  String get codeForgeUpiVpaRequired => 'युपीआई-सङ्केतः आवश्यकः';

  @override
  String codeForgeBarcodeInvalid(String detail) {
    return 'अस्य दण्डलेखा-प्रकारस्य कृते अयोग्यम् ($detail)';
  }

  @override
  String get airQrUnlockedTitle => 'वायु-क्यूआर विषयः उद्घाटितः';

  @override
  String get jsonEnvelopeUnlockedTitle => 'JSON-विषयः उद्घाटितः';

  @override
  String get stegoUnlockedTitle => 'StegoQR-विषयः उद्घाटितः';

  @override
  String get stegoDetectedTitle => 'गूढः StegoQR-विषयः प्राप्तः';

  @override
  String get decryptShowAdvanced => 'विस्तृतम् (Salt / IV)';

  @override
  String get decryptHideAdvanced => 'विस्तृतं गोप्यताम्';

  @override
  String get decryptSaltLabel => 'Salt (Base64, ऐच्छिकम्)';

  @override
  String get decryptIvLabel => 'IV / Nonce (Base64, ऐच्छिकम्)';

  @override
  String historyRecordCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count संवीक्षा-अभिलेखाः प्राप्ताः',
      one: '1 संवीक्षा-अभिलेखः प्राप्तः',
    );
    return '$_temp0';
  }

  @override
  String arItemsSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count वस्तूनि चितानि',
      one: '1 वस्तु चितम्',
    );
    return '$_temp0';
  }

  @override
  String settingsAppearanceSummary(String themeMode) {
    return '$themeMode • गतिकवर्णाः';
  }

  @override
  String get openPhishFeedNotDownloaded => 'सूचिः अद्यापि न अवतारिता';

  @override
  String get accentDynamicColorInfo =>
      'गतिकवर्णाः भवतः एण्ड्रायड्-भित्तिचित्रात् अनुरूपां वर्णावलीं रचयन्ति (एण्ड्रायड् १२+)। निष्क्रिये सति मानक-उच्चविरोध-सुरक्षावर्णावली प्रयुज्यते।';

  @override
  String get typographySampleLine =>
      '6-स्तरीय URL-सुरक्षापरीक्षा • 100% अन्तस्थ QuishingGuard™ CV यन्त्रम्';

  @override
  String get typographyScaleTitle => 'अक्षरपरिमाणम्';

  @override
  String get typographyScaleInfo =>
      'अनुप्रयोगः भवतः एण्ड्रायड्-सुगम्यता-अक्षरपरिमाणम् अनुसरति, संवीक्षाचौकटं पटल-नामपत्राणि च सुपाठ्यानि रक्षति।';

  @override
  String domFetchFailedTitle(String host) {
    return '$host (असंयुक्तम् अथवा संजालम् अवरुद्धम्)';
  }

  @override
  String get scanPauseTooltip => 'संवीक्षा विरम्यताम्';

  @override
  String get scanResumeTooltip => 'संवीक्षा पुनरारभ्यताम्';

  @override
  String get arModeWarehouse => 'भाण्डागारम्';

  @override
  String get arModeSafety => 'सुरक्षा';

  @override
  String get arModeWarehouseTooltip =>
      'वस्तु-विवरणं दृश्यताम्, सङ्केताः चीयन्ताम्';

  @override
  String get arModeSafetyTooltip => 'प्रतिसम्पर्के सुरक्षाचिह्नं दृश्यताम्';

  @override
  String get cameraStartFailed => 'चित्रग्राही आरब्धुं न शक्तः';

  @override
  String get cameraNotFound => 'अस्मिन् दूरवाणौ चित्रग्राही न प्राप्तः';

  @override
  String get cameraRetryButton => 'पुनः प्रयत्यताम्';

  @override
  String get codeForgeSafetyPrompt => 'वितरणात् पूर्वं सम्बन्धः परीक्ष्यताम्';

  @override
  String get codeForgeSafetyCheckButton => 'परीक्ष्यताम्';

  @override
  String codeForgeSafetyProblems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'अस्मिन् सम्बन्धे $count दोषाः प्राप्ताः',
      one: 'अस्मिन् सम्बन्धे 1 दोषः प्राप्तः',
    );
    return '$_temp0';
  }

  @override
  String get codeForgeSafetyCheckAgain => 'पुनः परीक्ष्यताम्';
}
