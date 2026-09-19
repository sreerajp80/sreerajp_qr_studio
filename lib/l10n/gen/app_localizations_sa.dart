// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Sanskrit (`sa`).
class AppLocalizationsSa extends AppLocalizations {
  AppLocalizationsSa([String locale = 'sa']) : super(locale);

  @override
  String get appTitle => 'श्रीराज् पि क्यू-आर-पाठकः';

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
  String get safetyIssuesWarning =>
      'सुरक्षा-दोषाः प्राप्ताः। अत्र व्यक्तिगत-विवरणं मा लिखन्तु';

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
  String get settingsAppearanceTitle => 'दृश्यरूपं वर्णाश्च';

  @override
  String get settingsOverlayTitle => 'अन्वीक्षणसंस्तरः';

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
  String get helpArBadge => 'संवर्धितवास्तविकता';

  @override
  String get helpArDesc =>
      'चित्रग्राहिदर्शके एव सङ्केतानां प्रत्यक्षं प्रदर्शनम्।';

  @override
  String get helpArPoint1 => 'एकस्मिन् समये एव बहून् सङ्केतान् अन्विष्यति।';

  @override
  String get helpArPoint2 => 'प्रत्येकसङ्केतोपरि तरन्तं पट्टिकाम् उत्पादयति।';

  @override
  String get helpArPoint3 =>
      'चित्रग्राहिणे स्थिता एव विषयान् द्रष्टुं प्रतिलेखितुं च शक्यते।';

  @override
  String get helpArPoint4 =>
      'दीपप्रवर्तनं, चित्रग्राहीपरिवर्तनं, विस्तारनियन्त्रणं च लभ्यते।';

  @override
  String get helpAirQrBadge => 'प्रकाशदत्तांशप्रोटोकॉल्';

  @override
  String get helpAirQrDesc =>
      'चलचित्रीकृत-क्यूआर्-सङ्केतैः बृहद्भाण्डाराणां प्रकाशकीयम् आदानप्रदानम्।';

  @override
  String get helpAirQrPoint1 =>
      'सङ्केतान् क्रमेण परीक्ष्य समग्रं दत्तांशं पुनर्निर्मिमीते।';

  @override
  String get helpAirQrPoint2 => 'सजीवप्रगतिः, गतिः, प्रतिशतं च दृश्यते।';

  @override
  String get helpAirQrPoint3 =>
      'चित्रग्राहिणा वीथिकाचित्रेण च परीक्षणं शक्यते।';

  @override
  String get helpAirQrPoint4 =>
      'अन्येभ्यः यन्त्रेभ्यः प्रेषणाय वायु-क्यूआर् प्रेषकविधा।';

  @override
  String get helpQuishingTitle => 'क्विषिङ्ग्-रक्षा (सङ्केतदोषपरीक्षणम्)';

  @override
  String get helpQuishingBadge => 'यन्त्रस्थदृष्टिविज्ञानम्';

  @override
  String get helpQuishingDesc =>
      'यथार्थसङ्केतोपरि लेपितान् कपटसङ्केतान् यन्त्रे एव परीक्षते।';

  @override
  String get helpQuishingPoint1 =>
      'पूर्णतया अन्तस्थम्: अन्तर्जालं विना यन्त्रे एव प्रचलति।';

  @override
  String get helpQuishingPoint2 => 'उपरि लेपितान् कपटसङ्केतान् विजानाति।';

  @override
  String get helpQuishingPoint3 => 'अन्तानां कोणानां च वैषम्यं परीक्षते।';

  @override
  String get helpQuishingPoint4 => 'मुद्रणगुणवत्तां वर्णवैषम्यं च परीक्षते।';

  @override
  String get helpUrlTitle => 'जालसङ्केतसुरक्षापरीक्षणम्';

  @override
  String get helpUrlBadge => 'षट्स्तरीया अङ्कीयसुरक्षा';

  @override
  String get helpUrlDesc => 'कपटजालेभ्यः दुष्टसङ्केतेभ्यश्च रक्षां करोति।';

  @override
  String get helpUrlPoint1 => 'कपटलिपिप्रयोगाणां संसक्तवर्णानां च अन्वेषणम्।';

  @override
  String get helpUrlPoint2 =>
      'अदृश्यवर्णानां शून्यविस्तारस्थानानां च विमर्शनम्।';

  @override
  String get helpUrlPoint3 =>
      'सन्दिग्ध-IP-सङ्केतानां प्रयोक्तृविवरणानां च शोधनम्।';

  @override
  String get helpUrlPoint4 =>
      'सन्दिग्धक्षेत्राणां असुरक्षितसम्पर्काणां च निरीक्षणम्।';

  @override
  String get helpUrlPoint5 => 'सङ्क्षिप्तसङ्केतानां मूलरूपपरीक्षणम्।';

  @override
  String get helpUrlPoint6 =>
      'गूगल-सुरक्षाकोषेण सह परीक्षणम् (API-कुञ्चिकायुते)।';

  @override
  String get helpUrlPoint7 =>
      'सर्वाणि मूलपरीक्षणानि अन्तर्जालं विना यन्त्रे एव भवन्ति।';

  @override
  String get helpCapabilitiesHeading => 'मुख्यानि सामर्थ्यानि:';

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
      'श्रीराज् पि क्यू-आर संवीक्षकः - संवीक्षा-इतिहासः';

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
  String get codeForgeVerifySafety => 'सम्बन्ध-सुरक्षा-परीक्षा';

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
}
