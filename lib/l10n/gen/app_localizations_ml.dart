// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get titleApp => 'ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ';

  @override
  String get titleWifiCard => 'വൈ-ഫൈ ശൃംഖല';

  @override
  String get tooltipWifiShowPassword => 'പാസ്‌വേഡ് കാണിക്കുക';

  @override
  String get tooltipWifiHidePassword => 'പാസ്‌വേഡ് മറയ്ക്കുക';

  @override
  String get tooltipWifiCopyPassword => 'പാസ്‌വേഡ് പകർത്തുക';

  @override
  String get actionWifiConnect => 'വൈ-ഫൈയിലേക്ക് ബന്ധിപ്പിക്കുക';

  @override
  String get bodyWifiPasswordCopied => 'പാസ്‌വേഡ് ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get bodyWifiOpenSettings =>
      'പാസ്‌വേഡ് പകർത്തി. ബന്ധിപ്പിക്കുന്നതിന് ഉപകരണത്തിലെ വൈ-ഫൈ ക്രമീകരണങ്ങൾ തുറക്കുക.';

  @override
  String bodyWifiConnectSuccess(String ssid) {
    return '$ssid ശൃംഖലയിലേക്ക് ബന്ധിപ്പിക്കാനുള്ള അഭ്യർത്ഥന നൽകി.';
  }

  @override
  String bodyGeoLatLng(String latitude, String longitude) {
    return 'അക്ഷാംശം: $latitude, രേഖാംശം: $longitude';
  }

  @override
  String bodyGeoQuery(String query) {
    return 'അന്വേഷണം: $query';
  }

  @override
  String get actionGeoNavigate => 'ഗൂഗിൾ മാപ്‌സിൽ വഴികാട്ടുക';

  @override
  String get errorGeoLaunchFailed => 'ഗൂഗിൾ മാപ്സ് ആപ്പ് തുറക്കാനായില്ല';

  @override
  String get titleCalendarCard => 'കലണ്ടർ ഇവന്റ്';

  @override
  String get labelCalendarNoDate => 'ലഭ്യമല്ല';

  @override
  String labelCalendarStart(String dateTime) {
    return 'ആരംഭം: $dateTime';
  }

  @override
  String labelCalendarEnd(String dateTime) {
    return 'അവസാനം: $dateTime';
  }

  @override
  String get actionCalendarAdd => 'ഉപകരണ കലണ്ടറിലേക്ക് ചേർക്കുക';

  @override
  String get errorCalendarLaunchFailed => 'കലണ്ടർ ആപ്പ് തുറക്കാനായില്ല';

  @override
  String get titleContactCard => 'വിലാസ കാർഡ്';

  @override
  String get labelContactInitialFallback => 'വ';

  @override
  String get actionContactSave => 'കോൺടാക്റ്റുകളിലേക്ക് സൂക്ഷിക്കുക';

  @override
  String get errorContactLaunchFailed => 'കോൺടാക്റ്റ്സ് ആപ്പ് തുറക്കാനായില്ല';

  @override
  String errorContactCallFailed(String number) {
    return '$number എന്നതിലേക്ക് വിളിക്കാനായില്ല';
  }

  @override
  String errorContactEmailFailed(String email) {
    return '$email എന്നതിലേക്ക് ഇമെയിൽ ആപ്പ് തുറക്കാനായില്ല';
  }

  @override
  String titlePdfResults(int count) {
    return 'പിഡിഎഫ് കോഡുകൾ ($count)';
  }

  @override
  String labelPdfPageBadge(int page) {
    return 'താൾ $page';
  }

  @override
  String labelPdfPage(int page) {
    return 'താൾ $page';
  }

  @override
  String actionPdfSaveAll(int count) {
    return 'എല്ലാം സൂക്ഷിക്കുക ($count)';
  }

  @override
  String bodyPdfScanNote(int page) {
    return 'പിഡിഎഫിൽ നിന്ന് സ്കാൻ ചെയ്തത് (താൾ $page)';
  }

  @override
  String bodyPdfSavedToHistory(int count) {
    return '$count കോഡുകൾ നാൾവഴിയിൽ സൂക്ഷിച്ചു.';
  }

  @override
  String get labelTotpDefaultIssuer => 'ദ്വിഘടക പ്രാമാണീകരണം';

  @override
  String bodyTotpLivePasscode(int period) {
    return 'തത്സമയ കോഡ് ($periodസെക്കൻഡ് TOTP)';
  }

  @override
  String labelTotpSecondsLeft(int seconds) {
    return '$secondsസെക്കൻഡ്';
  }

  @override
  String get tooltipTotpCopyToken => 'ടോക്കൺ പകർത്തുക';

  @override
  String get labelTotpSecret => 'രഹസ്യ കീ: ';

  @override
  String get actionTotpImport => 'ഓതന്റിക്കേറ്ററിലേക്ക് ചേർക്കുക';

  @override
  String get errorTotpLaunchFailed => 'ഓതന്റിക്കേറ്റർ ആപ്പ് തുറക്കാനായില്ല';

  @override
  String get bodyTotpTokenCopied => 'ടോക്കൺ ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get bodyTotpSecretCopied => 'രഹസ്യ കീ ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get labelPaymentSchemeUpi => 'യുപിഐ പണമിടപാട്';

  @override
  String get labelPaymentSchemeSepa => 'സെപ്പ കൈമാറ്റം';

  @override
  String get labelPaymentSchemeCrypto => 'ക്രിപ്റ്റോ പണമിടപാട്';

  @override
  String get labelPaymentPayeeFallback => 'വ്യാപാരി / സ്വീകർത്താവ്';

  @override
  String get labelPaymentAddressUpi => 'വിപിഎ / യുപിഐ ഐഡി:';

  @override
  String get labelPaymentAddressSepa => 'ഐബാൻ (IBAN):';

  @override
  String get labelPaymentAddressCrypto => 'വാലറ്റ് വിലാസം:';

  @override
  String get actionPaymentCopy => 'പകർത്തുക';

  @override
  String get bodyPaymentUpiIdCopied => 'യുപിഐ ഐഡി ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get bodyPaymentAddressCopied => 'വിലാസം ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String bodyPaymentNote(String note) {
    return 'കുറിപ്പ്: $note';
  }

  @override
  String get actionPaymentPayUpi => 'UPI ആപ്പ് വഴി നൽകുക';

  @override
  String get actionPaymentPay => 'ആപ്പ് വഴി പണം നൽകുക';

  @override
  String get errorPaymentUpiLaunchFailed =>
      'യുപിഐ ആപ്പ് തുറക്കാനായില്ല. GPay, PhonePe, അല്ലെങ്കിൽ Paytm ഇൻസ്റ്റാൾ ചെയ്തിട്ടുണ്ടെന്ന് ഉറപ്പാക്കുക.';

  @override
  String get errorPaymentLaunchFailed => 'ഈ പേയ്‌മെന്റ് ആപ്പ് തുറക്കാനായില്ല.';

  @override
  String get actionPaymentCopyId => 'ഐഡി പകർത്തുക';

  @override
  String get titlePaymentAmountDialog => 'തുക നൽകുക';

  @override
  String bodyPaymentAmountDialog(String payee) {
    return 'ഈ QR-ൽ തുകയില്ല. $payee-ന് നൽകേണ്ട തുക നൽകുക.';
  }

  @override
  String get labelPaymentAmountField => 'തുക';

  @override
  String get errorPaymentAmountInvalid => '₹1 അല്ലെങ്കിൽ കൂടുതൽ നൽകുക';

  @override
  String get actionPaymentAmountPay => 'പണം നൽകുക';

  @override
  String labelPercentValue(String value) {
    return '$value%';
  }

  @override
  String get titleQuishingGuard => 'ക്വിഷിംഗ് ഗാർഡ്™';

  @override
  String get labelQuishingTamperBadge => 'ഭൗതിക കൃത്രിമം CV';

  @override
  String get labelQuishingRiskScore => 'കൃത്രിമത്വ സാധ്യത നിരക്ക്:';

  @override
  String get actionQuishingViewSignals => 'സിഗ്നലുകൾ കാണിക്കുക';

  @override
  String get actionQuishingHideSignals => 'സിഗ്നലുകൾ മറയ്ക്കുക';

  @override
  String get labelQuishingMetricEdge => 'അരികുകളുടെ വിച്ഛേദം';

  @override
  String get descQuishingMetricEdge => 'ഇരട്ട അരികുകളും നിഴൽ വരകളും';

  @override
  String get labelQuishingMetricGrain => 'പ്രിന്റ് തരികളും ഡിപിഐയും';

  @override
  String get descQuishingMetricGrain => 'ഹാഫ്‌ടോൺ ഡോട്ടും വർണ്ണ ശബ്ദവും';

  @override
  String get titleQuishingSignals => 'കണ്ടെത്തിയ സിഗ്നലുകൾ:';

  @override
  String get tooltipArCloseSheet => 'അടയ്ക്കുക';

  @override
  String bodyArItemPriceTag(String price) {
    return 'വില വിവരപ്പട്ടിക: $price';
  }

  @override
  String get bodyArContentCopied => 'ഉള്ളടക്കം ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get actionArCopy => 'പകർത്തുക';

  @override
  String get actionArOpenUrl => 'URL തുറക്കുക';

  @override
  String get actionArSelect => 'തിരഞ്ഞെടുക്കുക';

  @override
  String get actionArDeselect => 'ഒഴിവാക്കുക';

  @override
  String get bodyArSafetyStatusSafe =>
      'സുരക്ഷാ നില: സുരക്ഷിതമെന്ന് സ്ഥിരീകരിച്ചു';

  @override
  String get bodyArSafetyStatusWarning =>
      'സുരക്ഷാ നില: മുന്നറിയിപ്പ് / ഫിഷിംഗ് സാധ്യത';

  @override
  String get bodyArSafetyStatusUnknown => 'സുരക്ഷാ നില: പരിശോധിക്കുന്നു...';

  @override
  String get bodyCopiedToClipboard => 'ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String bodyHistoryTimestamp(String date, String time) {
    return '$date • $time';
  }

  @override
  String get tooltipHistoryStar => 'പ്രിയപ്പെട്ടവയിൽ ചേർക്കുക';

  @override
  String get tooltipHistoryUnstar => 'പ്രിയപ്പെട്ടവയിൽ നിന്ന് മാറ്റുക';

  @override
  String get actionHistoryEditNotes => 'കുറിപ്പുകൾ തിരുത്തുക';

  @override
  String get tooltipHistoryCopyString => 'വാചകം പകർത്തുക';

  @override
  String get actionHistoryShare => 'പങ്കിടുക';

  @override
  String get actionHistoryDelete => 'ഇല്ലാതാക്കുക';

  @override
  String get titleHistoryDetail => 'സ്കാൻ രേഖയുടെ വിവരങ്ങൾ';

  @override
  String labelHistorySafetyBadge(int score) {
    return '🛡️ $score% സുരക്ഷിതം';
  }

  @override
  String labelHistoryScoreBadge(int score) {
    return '🛡️ $score%';
  }

  @override
  String get labelHistoryScannedContent => 'സ്കാൻ ചെയ്ത ഉള്ളടക്കം:';

  @override
  String get actionHistoryCopy => 'പകർത്തുക';

  @override
  String get labelHistoryNotes => 'സ്വന്തം കുറിപ്പുകൾ';

  @override
  String get helpHistoryNotes =>
      'ഈ സ്കാനിനെക്കുറിച്ച് വ്യക്തിഗത കുറിപ്പുകൾ ചേർക്കുക...';

  @override
  String get labelHistoryLocation => 'സ്ഥലം (ഐച്ഛികം)';

  @override
  String get helpHistoryLocation => 'ഉദാ: ഓഫീസ്, സൂപ്പർമാർക്കറ്റ്, സമ്മേളനം';

  @override
  String get actionHistorySaveChanges => 'മാറ്റങ്ങൾ സൂക്ഷിക്കുക';

  @override
  String get actionClose => 'അടയ്ക്കുക';

  @override
  String get titleExportDialog => 'കയറ്റുമതിയും ബാക്കപ്പും';

  @override
  String get titleRestoreDialog => 'ബാക്കപ്പ് പുനഃസ്ഥാപിക്കൽ';

  @override
  String get tabExportRecords => 'രേഖകൾ കയറ്റുമതി ചെയ്യുക';

  @override
  String get tabRestoreBackup => 'ബാക്കപ്പ് പുനഃസ്ഥാപിക്കുക';

  @override
  String get titleExportFormat => 'കയറ്റുമതി ഫോർമാറ്റ്:';

  @override
  String get labelExportCsv => 'CSV ഫോർമാറ്റ് (.csv)';

  @override
  String get descExportCsv => 'Excel, Sheets എന്നിവയ്ക്ക് അനുയോജ്യം';

  @override
  String get labelExportJson => 'JSON ഡാറ്റാസെറ്റ് (.json)';

  @override
  String get descExportJson => 'ഡെവലപ്പർ ഫോർമാറ്റ്';

  @override
  String get labelExportTxt => 'TXT റിപ്പോർട്ട് (.txt)';

  @override
  String get descExportTxt => 'വായിക്കാവുന്ന സംഗ്രഹ രേഖ';

  @override
  String get labelExportPdf => 'പിഡിഎഫ് റിപ്പോർട്ട് (.pdf)';

  @override
  String get descExportPdf => 'പ്രിന്റ് ചെയ്യാവുന്ന പട്ടിക റിപ്പോർട്ട്';

  @override
  String get titleExportBackup => 'എൻക്രിപ്റ്റ് ചെയ്ത ബാക്കപ്പ്';

  @override
  String get labelExportPassphrase => 'ബാക്കപ്പ് രഹസ്യവാക്ക്';

  @override
  String get helpExportPassphrase => 'രഹസ്യവാക്ക് നൽകുക...';

  @override
  String get errorExportPassphraseRequired =>
      'ബാക്കപ്പ് ഫയൽ എൻക്രിപ്റ്റ് ചെയ്യാൻ രഹസ്യവാക്ക് നൽകുക.';

  @override
  String get actionExportCreateBackup => 'ബാക്കപ്പ് നിർമ്മിക്കുക';

  @override
  String get bodyExportShare =>
      'ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ സ്കാൻ നാൾവഴി കയറ്റുമതി';

  @override
  String get bodyExportSharePdf =>
      'ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ സ്കാൻ നാൾവഴി റിപ്പോർട്ട് (PDF)';

  @override
  String get bodyExportShareBackup =>
      'ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ എൻക്രിപ്റ്റ് ചെയ്ത ബാക്കപ്പ് ഫയൽ';

  @override
  String get titleRestore => 'ബാക്കപ്പിൽ നിന്ന്:';

  @override
  String get labelRestorePassphrase => 'ബാക്കപ്പ് രഹസ്യവാക്ക്';

  @override
  String get labelRestorePayload => 'ബാക്കപ്പ് വിവരങ്ങൾ';

  @override
  String get helpRestorePayload =>
      'ബാക്കപ്പ് JSON വിവരങ്ങൾ ഇവിടെ ഒട്ടിക്കുക...';

  @override
  String get errorRestoreFieldsRequired =>
      'രഹസ്യവാക്കും ബാക്കപ്പ് വിവരങ്ങളും നൽകുക.';

  @override
  String get actionRestore => 'നാൾവഴി പുനഃസ്ഥാപിക്കുക';

  @override
  String bodyRestoreSuccess(int count) {
    return '$count സ്കാൻ രേഖകൾ വിജയകരമായി പുനഃസ്ഥാപിച്ചു!';
  }

  @override
  String errorRestoreFailed(String reason) {
    return 'പുനഃസ്ഥാപിക്കൽ പരാജയപ്പെട്ടു: $reason';
  }

  @override
  String get labelDomSandboxedBadge => 'സാൻഡ്‌ബോക്സ് ചെയ്തത്';

  @override
  String get labelDomTitleInitialFallback => 'വെ';

  @override
  String get labelDomUntitledPage => 'പേരില്ലാത്ത വെബ് പേജ്';

  @override
  String get bodyDomThumbnailCaption =>
      'വിഷ്വൽ പ്രിവ്യൂ (സ്ക്രിപ്റ്റുകൾ തടഞ്ഞിരിക്കുന്നു)';

  @override
  String bodyDomBlockedBadge(int scripts, int trackers) {
    return 'തടഞ്ഞവ: $scripts സ്ക്രിപ്റ്റുകൾ, $trackers ട്രാക്കറുകൾ';
  }

  @override
  String bodyDomNewlyRegistered(int days) {
    return 'പുതിയ രജിസ്ട്രേഷൻ ($daysദിവസം)';
  }

  @override
  String bodyDomDomainAge(int days) {
    return 'ഡൊമെയ്ൻ പ്രായം: $days ദിവസങ്ങൾ';
  }

  @override
  String get bodyDomOpenRedirectFound => 'ഓപ്പൺ റീഡയറക്റ്റ് കെണി!';

  @override
  String get bodyDomNoOpenRedirect => 'ഓപ്പൺ റീഡയറക്റ്റുകൾ ഇല്ല';

  @override
  String get actionDomInspect => 'പേജ് പരിശോധിക്കുക';

  @override
  String get titleDomInspect => 'പേജ് ഘടന';

  @override
  String get labelDomDetailPageTitle => 'പേജ് ശീർഷകം';

  @override
  String get labelDomDetailNotSpecified => 'വ്യക്തമാക്കിയിട്ടില്ല';

  @override
  String get labelDomDetailMetaDescription => 'മെറ്റാ വിവരണം';

  @override
  String get labelDomDetailNoneFound => 'ഒന്നും കണ്ടെത്തിയില്ല';

  @override
  String get labelDomDetailHeadingsCount => 'തലക്കെട്ടുകളുടെ എണ്ണം';

  @override
  String bodyDomDetailHeadingsValue(int count) {
    return '$count തലക്കെട്ടുകൾ വേർതിരിച്ചെടുത്തു';
  }

  @override
  String get labelDomDetailLinksFound => 'കണ്ടെത്തിയ ലിങ്കുകൾ';

  @override
  String bodyDomDetailLinksValue(int count) {
    return '$count URL-കൾ വേർതിരിച്ചെടുത്തു';
  }

  @override
  String get labelDomDetailBlockedScripts => 'തടഞ്ഞ സ്ക്രിപ്റ്റുകൾ';

  @override
  String bodyDomDetailBlockedScriptsValue(int count) {
    return '$count സ്ക്രിപ്റ്റ് ടാഗുകൾ നീക്കം ചെയ്തു';
  }

  @override
  String get labelDomDetailBlockedTrackers => 'തടഞ്ഞ ട്രാക്കറുകൾ';

  @override
  String bodyDomDetailBlockedTrackersValue(int count) {
    return '$count ട്രാക്കിംഗ് പിക്സലുകൾ നീക്കം ചെയ്തു';
  }

  @override
  String get labelDomDetailBlockedIframes => 'തടഞ്ഞ ഐഫ്രെയിമുകൾ';

  @override
  String bodyDomDetailBlockedIframesValue(int count) {
    return '$count ഉൾച്ചേർത്ത ഘടകങ്ങൾ നീക്കം ചെയ്തു';
  }

  @override
  String get titleDomSanitizedSnippet => 'ശുദ്ധീകരിച്ച HTML പ്രിവ്യൂ:';

  @override
  String get titleAbout => 'വിവരങ്ങൾ';

  @override
  String bodyAboutVersion(String version, String build) {
    return 'പതിപ്പ് $version+$build';
  }

  @override
  String get labelAboutBuildDate => 'നിർമ്മാണ തീയതി';

  @override
  String get labelAboutOpenSourceLicenses => 'ഓപ്പൺ സോഴ്സ് ലൈസൻസ്';

  @override
  String get descAboutOpenSourceLicenses =>
      'ബാർകോഡ് ഡീകോഡറായി zxing-cpp (Apache-2.0) ഉപയോഗിക്കുന്നു. എല്ലാ ലൈസൻസുകളും കാണാൻ ടാപ്പ് ചെയ്യുക.';

  @override
  String get aboutDetailAuthor => 'നിർമ്മാതാവ്';

  @override
  String get aboutDetailEmail => 'ഇമെയിൽ';

  @override
  String get aboutDetailLicense => 'ലൈസൻസ്';

  @override
  String get aboutDetailAiUsed => 'ഉപയോഗിച്ച AI';

  @override
  String get aboutDetailIdeUsed => 'ഉപയോഗിച്ച IDE';

  @override
  String madeWithLove(String heart) {
    return 'ഇന്ത്യയിൽ നിന്ന് $heart-ഓടെ നിർമ്മിച്ചത്';
  }

  @override
  String get madeWithLoveA11y => 'ഇന്ത്യയിൽ നിന്ന് സ്നേഹത്തോടെ നിർമ്മിച്ചത്';

  @override
  String get titleAirQrTransmitter => 'എയർ ക്യുആർ ട്രാൻസ്മിറ്റർ';

  @override
  String get bodyAirQrSamplePayload =>
      'എയർ ക്യുആർ ഹൈ-സ്പീഡ് ഒപ്റ്റിക്കൽ ഡാറ്റാ ട്രാൻസ്ഫർ പരീക്ഷണ ഉള്ളടക്കം.';

  @override
  String get labelAirQrPayload => 'അയയ്ക്കേണ്ട വിവരങ്ങൾ';

  @override
  String get helpAirQrPayload => 'ടെക്സ്റ്റ് അല്ലെങ്കിൽ സന്ദേശം നൽകുക...';

  @override
  String get labelAirQrStreamSpeed => 'സ്ട്രീം വേഗത:';

  @override
  String labelAirQrFps(int fps) {
    return '$fps FPS';
  }

  @override
  String get actionAirQrStartStream => 'പ്രക്ഷേപണം ആരംഭിക്കുക';

  @override
  String get actionAirQrStopStream => 'പ്രക്ഷേപണം നിർത്തുക';

  @override
  String bodyAirQrFrameParity(int current, int total) {
    return 'ഫ്രെയിം $current/$total [പാരിറ്റി]';
  }

  @override
  String bodyAirQrFrameBlock(int current, int total, int block) {
    return 'ഫ്രെയിം $current/$total [ബ്ലോക്ക് $block]';
  }

  @override
  String bodyAirQrTotalFrames(int total, int source, int parity) {
    return 'ആകെ ഫ്രെയിമുകൾ: $total ($source ഉറവിടം + $parity പാരിറ്റി)';
  }

  @override
  String get tooltipToggleFlashlight => 'ഫ്ലാഷ്‌ലൈറ്റ് മാറ്റുക';

  @override
  String get actionGrantCameraPermission => 'ക്യാമറ അനുമതി നൽകുക';

  @override
  String get titleArScreen => 'എആർ കോഡ്‌വിഷൻ HUD';

  @override
  String get bodyArInitializing => 'എആർ HUD സജ്ജമാക്കുന്നു...';

  @override
  String get actionArClearSelection => 'മായ്ക്കുക';

  @override
  String get actionArBatchCopy => 'മൊത്തമായി പകർത്തുക';

  @override
  String bodyArBatchCopied(int count) {
    return '$count ബാർകോഡുകൾ ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';
  }

  @override
  String get bodyArCameraPermission => 'എആർ കോഡ്‌വിഷന് ക്യാമറ അനുമതി ആവശ്യമാണ്';

  @override
  String get actionDone => 'പൂർത്തിയാക്കുക';

  @override
  String get titleAirQrReceiver => 'എയർ ക്യുആർ റിസീവർ';

  @override
  String get tooltipAirQrTransmitter => 'എയർ ക്യുആർ ട്രാൻസ്മിറ്റർ';

  @override
  String get tooltipAirQrResetStream => 'പുനഃക്രമീകരിക്കുക';

  @override
  String get bodyAirQrInitializing => 'എയർ ക്യുആർ റിസീവർ സജ്ജമാക്കുന്നു...';

  @override
  String get bodyAirQrStatusReassembled => 'സ്ട്രീം പൂർണ്ണമായി സ്വീകരിച്ചു';

  @override
  String get bodyAirQrStatusCapturing =>
      'ഒപ്റ്റിക്കൽ സ്ട്രീം സ്വീകരിക്കുന്നു...';

  @override
  String get bodyAirQrStatusIdle => 'ആനിമേറ്റഡ് ക്യുആറിലേക്ക് ക്യാമറ തിരിക്കുക';

  @override
  String bodyAirQrCaptured(int received, int total) {
    return 'ലഭിച്ചവ: $received / $total ബ്ലോക്കുകൾ';
  }

  @override
  String bodyAirQrMissing(int count) {
    return 'ബാക്കി: $count';
  }

  @override
  String get titleAirQrTransferComplete => 'കൈമാറ്റം പൂർത്തിയായി!';

  @override
  String get bodyAirQrTransferComplete =>
      'വിവരങ്ങൾ വിജയകരമായി സ്വീകരിച്ച് സ്ഥിരീകരിച്ചു.';

  @override
  String get bodyAirQrPayloadCopied => 'ഉള്ളടക്കം ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get actionCancel => 'റദ്ദാക്കുക';

  @override
  String get titleHistoryScreen => 'സ്കാൻ നാൾവഴി';

  @override
  String get tooltipHistoryExport => 'കയറ്റുമതി / ബാക്കപ്പ്';

  @override
  String get actionHistoryClearAll => 'എല്ലാം മായ്ക്കുക';

  @override
  String get titleHistoryClear => 'നാൾവഴി മുഴുവൻ മായ്ക്കണമോ?';

  @override
  String get bodyHistoryClear =>
      'സ്കാൻ നാൾവഴി മുഴുവൻ ഇല്ലാതാക്കണമെന്ന് ഉറപ്പാണോ? ബാക്കപ്പ് എടുത്തിട്ടില്ലെങ്കിൽ ഇത് തിരിച്ചെടുക്കാനാവില്ല.';

  @override
  String get helpHistorySearch => 'നാൾവഴിയിൽ തിരയുക...';

  @override
  String get labelHistoryFilterAll => 'എല്ലാം';

  @override
  String get labelHistoryFilterStarred => 'നക്ഷത്രമിട്ടവ';

  @override
  String get labelHistoryFilterUrls => 'ലിങ്കുകൾ';

  @override
  String get labelHistoryFilterWifi => 'വൈ-ഫൈ';

  @override
  String get labelHistoryFilterContacts => 'കോൺടാക്റ്റുകൾ';

  @override
  String get labelHistoryFilterText => 'വാചകം';

  @override
  String get labelHistoryFilterBarcodes => 'ബാർകോഡുകൾ';

  @override
  String get emptyHistoryTitle => 'സ്കാൻ രേഖകളൊന്നും കണ്ടെത്തിയില്ല';

  @override
  String get emptyHistoryMessage =>
      'സ്കാൻ ചെയ്യുന്ന ബാർകോഡുകൾ ഇവിടെ തനിയെ ദൃശ്യമാകും.';

  @override
  String emptyHistoryNoMatches(String query) {
    return '\"$query\" എന്നതിന് ഫലങ്ങളില്ല';
  }

  @override
  String get tooltipMoreOptions => 'കൂടുതൽ ഓപ്ഷനുകൾ';

  @override
  String get actionMenuHistory => 'നാൾവഴി';

  @override
  String get actionMenuSettings => 'ക്രമീകരണങ്ങൾ';

  @override
  String get actionGrantPermission => 'അനുമതി നൽകുക';

  @override
  String get tooltipScanFromGallery => 'ഗാലറിയിൽ നിന്ന് ചിത്രം സ്കാൻ ചെയ്യുക';

  @override
  String get tooltipScanPdfDocument => 'PDF രേഖ സ്കാൻ ചെയ്യുക';

  @override
  String get bodyScanPdfProgress =>
      'PDF പേജുകൾ വേർതിരിച്ച് സ്കാൻ ചെയ്യുന്നു...';

  @override
  String get bodyScanSharedPdfProgress =>
      'പങ്കിട്ട PDF രേഖ സ്കാൻ ചെയ്യുന്നു...';

  @override
  String get bodyScanInitializingCamera => 'ക്യാമറ ഒരുക്കുന്നു...';

  @override
  String get bodyScanInitializingFeed => 'ക്യാമറ ദൃശ്യം ഒരുക്കുന്നു...';

  @override
  String get tooltipScanZoom => 'വലുതാക്കൽ സ്ലൈഡർ';

  @override
  String get tooltipScanFlipCamera => 'ക്യാമറ തിരിക്കുക (മുന്നിൽ/പിന്നിൽ)';

  @override
  String labelScanZoomValue(String value) {
    return '${value}x';
  }

  @override
  String get helpScanViewfinder =>
      'ക്യുആർ കോഡോ ബാർകോഡോ ഫ്രെയിമിനുള്ളിൽ വെയ്ക്കുക';

  @override
  String get bodyScanCameraPermissionRequired => 'ക്യാമറ അനുമതി ആവശ്യമാണ്';

  @override
  String get labelCopied => 'പകർത്തി!';

  @override
  String get actionHide => 'മറയ്ക്കുക';

  @override
  String get actionReveal => 'കാണിക്കുക';

  @override
  String get actionOpenAnyway => 'തുറക്കുക';

  @override
  String get titleResultScreen => 'സ്കാൻ ഫലം';

  @override
  String get bodyResultNoResult => 'ഫലങ്ങളൊന്നുമില്ല';

  @override
  String get labelResultContent => 'ഉള്ളടക്കം:';

  @override
  String get labelResultDecoyContent => 'പരസ്യ ഉള്ളടക്കം:';

  @override
  String get labelResultDetectedType => 'തിരിച്ചറിഞ്ഞ ഇനം:';

  @override
  String get labelResultTypeStego => 'STEGO-QR (രഹസ്യ ഡ്യുവൽ-ലെയർ)';

  @override
  String get actionResultRecheck => 'വീണ്ടും പരിശോധിക്കുക';

  @override
  String get actionResultOpenInBrowser => 'ബ്രൗസറിൽ തുറക്കുക';

  @override
  String get actionResultCopyText => 'ടെക്സ്റ്റ് പകർത്തുക';

  @override
  String get actionResultCopyDecoyText => 'പരസ്യ ഉള്ളടക്കം പകർത്തുക';

  @override
  String get actionResultShareText => 'ടെക്സ്റ്റ് പങ്കിടുക';

  @override
  String get actionResultShareDecoyText => 'പരസ്യ ഉള്ളടക്കം പങ്കിടുക';

  @override
  String get actionResultScanAnother => 'മറ്റൊരു കോഡ് സ്കാൻ ചെയ്യുക';

  @override
  String get errorResultLaunchFailed => 'URL തുറക്കാൻ കഴിഞ്ഞില്ല';

  @override
  String get bodyStegoUnlocked =>
      'മറഞ്ഞിരിക്കുന്ന AES-256 ഉള്ളടക്കം വിജയകരമായി ഡീക്രിപ്റ്റ് ചെയ്തു.';

  @override
  String get bodyStegoLocked =>
      'ഈ ക്യുആർ കോഡിൽ മറഞ്ഞിരിക്കുന്ന എൻക്രിപ്റ്റ് ചെയ്ത രഹസ്യമുണ്ട്. കാണാൻ ആധികാരികത ഉറപ്പാക്കുക.';

  @override
  String get actionStegoBiometricUnlock => 'ബയോമെട്രിക് അൺലോക്ക്';

  @override
  String get labelStegoPassphrase => 'രഹസ്യവാക്ക്';

  @override
  String get labelStegoSecretPayload => 'രഹസ്യ ഉള്ളടക്കം:';

  @override
  String get actionStegoCopySecret => 'രഹസ്യം പകർത്തുക';

  @override
  String get actionStegoShareSecret => 'രഹസ്യം പങ്കിടുക';

  @override
  String get bodyStegoSecretCopied => 'രഹസ്യം ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get titleStegoDialogBiometric => 'ബയോമെട്രിക് അൺലോക്ക്';

  @override
  String get titleStegoDialogPassphrase => 'രഹസ്യവാക്ക് നൽകുക';

  @override
  String get bodyStegoDialogBiometric =>
      'ഉള്ളടക്കം കാണുന്നതിനായി രഹസ്യവാക്ക് സ്ഥിരീകരിച്ച് ബയോമെട്രിക് ഉപയോഗിക്കുക.';

  @override
  String get bodyStegoDialogPassphrase =>
      'എൻക്രിപ്റ്റ് ചെയ്യാൻ ഉപയോഗിച്ച രഹസ്യവാക്ക് നൽകുക.';

  @override
  String get actionStegoUnlock => 'തുറക്കുക';

  @override
  String get titleSafetyCheckInProgress => 'സുരക്ഷാ പരിശോധന പുരോഗമിക്കുന്നു';

  @override
  String get titleSafetyAnalysis => 'URL സുരക്ഷാ വിശകലനം';

  @override
  String get bodySafetyAnalyzing => 'സുരക്ഷ പരിശോധിക്കുന്നു...';

  @override
  String bodySafetyIssuesDetected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count സുരക്ഷാ പ്രശ്നങ്ങൾ കണ്ടെത്തി',
      one: '1 സുരക്ഷാ പ്രശ്നം കണ്ടെത്തി',
    );
    return '$_temp0';
  }

  @override
  String get bodySafetyNoIssues => 'പ്രശ്നങ്ങളൊന്നും കണ്ടെത്തിയില്ല';

  @override
  String get helpSafetyTrustSource =>
      'ഉറവിടം വിശ്വസനീയമെങ്കിൽ മാത്രം ഈ ലിങ്ക് തുറക്കുക';

  @override
  String get titleSafetyResults => 'സുരക്ഷാ വിശകലന ഫലങ്ങൾ:';

  @override
  String get bodyProbingBannerActive =>
      'സജീവ ഓൺലൈൻ പരിശോധനകൾ ഓണാണ്: ഈ സൈറ്റുമായി നേരിട്ട് ബന്ധപ്പെട്ടു, നിങ്ങളുടെ IP വിലാസം വെളിപ്പെട്ടു.';

  @override
  String get bodyProbingBannerPrivate =>
      'സ്വകാര്യ മോഡ്: സൈറ്റുമായി നേരിട്ട് ബന്ധപ്പെട്ടിട്ടില്ല, അതിനാൽ നിങ്ങളുടെ IP വിലാസം സൈറ്റിന് ലഭിച്ചിട്ടില്ല. പ്രാദേശിക നിയമങ്ങളും നിങ്ങൾ ഓണാക്കിയ സുരക്ഷാ സേവനങ്ങളും മാത്രമേ ഉപയോഗിച്ചിട്ടുള്ളൂ.';

  @override
  String get titleWarningDialog => 'സുരക്ഷാ മുന്നറിയിപ്പ്';

  @override
  String get bodyWarningDialog =>
      'ഈ URL സുരക്ഷാ പ്രശ്നങ്ങൾ ഉള്ളതാണ്. ഇത് തുറക്കുന്നത് അപകടകരമാകാം.\n\nതുടരണമെന്ന് ഉറപ്പാണോ?';

  @override
  String get titleCautionDialog => 'ശ്രദ്ധിക്കുക';

  @override
  String get bodyCautionDialog =>
      'ക്യുആർ കോഡിലെ ലിങ്കുകൾ തുറക്കുന്നതിന് മുൻപ് ഉറപ്പാക്കുക.\n\nഈ ലിങ്ക് തുറക്കണമോ?';

  @override
  String get labelOverlayLaserLine => 'ലേസർ വര';

  @override
  String get labelOverlayPulsingCorners => 'മിന്നുന്ന കോണുകൾ';

  @override
  String get labelOverlayCyberneticGrid => 'സൈബർ ഗ്രിഡ്';

  @override
  String get labelOverlaySubtleDotMatrix => 'ഡോട്ട് മാട്രിക്സ്';

  @override
  String get descOverlayLaserLine => 'ലേസർ രശ്മിയോടു കൂടിയ സ്കാൻ ബോക്സ്';

  @override
  String get descOverlayPulsingCorners => 'മിന്നുന്ന പ്രകാശ കോണുകൾ';

  @override
  String get descOverlayCyberneticGrid =>
      'ആധുനിക സയൻസ് ഫിക്ഷൻ ശൈലിയിലുള്ള ഗ്രിഡ്';

  @override
  String get descOverlaySubtleDotMatrix => 'ലളിതമായ ബിന്ദു രൂപകൽപ്പന';

  @override
  String get labelThemeSystemDefault => 'സിസ്റ്റം സ്വതവേയുള്ളത്';

  @override
  String get labelThemeLight => 'ലൈറ്റ് തീം';

  @override
  String get labelThemeDark => 'ഡാർക്ക് തീം';

  @override
  String get labelThemeOled => 'OLED പ്യുവർ ബ്ലാക്ക്';

  @override
  String get titleThemeMode => 'തീം മോഡ്';

  @override
  String get labelThemeChipSystem => 'സിസ്റ്റം';

  @override
  String get labelThemeChipLight => 'ലൈറ്റ്';

  @override
  String get labelThemeChipDark => 'ഡാർക്ക്';

  @override
  String get labelThemeChipOled => 'OLED';

  @override
  String get labelThemeDynamicColors => 'മെറ്റീരിയൽ യു ഡൈനാമിക് നിറങ്ങൾ';

  @override
  String get descThemeDynamicColors =>
      'ആൻഡ്രോയിഡ് 12+ വാൾപേപ്പർ നിറങ്ങൾ ഉപയോഗിക്കുക (മോനെ എഞ്ചിൻ)';

  @override
  String get descThemeSystem => 'സിസ്റ്റം ക്രമീകരണങ്ങൾ പിന്തുടരുക';

  @override
  String get descThemeLight => 'സാധാരണ ലൈറ്റ് മോഡ്';

  @override
  String get descThemeDark => 'സാധാരണ ഡാർക്ക് മോഡ്';

  @override
  String get descThemeOled =>
      'യഥാർത്ഥ OLED പ്യുവർ ബ്ലാക്ക് (ബാറ്ററി ലാഭിക്കാം)';

  @override
  String get titleSettings => 'ക്രമീകരണങ്ങൾ';

  @override
  String get labelSettingsFeedback => 'പ്രതികരണവും മുന്നറിയിപ്പുകളും';

  @override
  String get labelSettingsPrivacy => 'സ്വകാര്യതയും നെറ്റ്‌വർക്ക് പരിശോധനയും';

  @override
  String get labelSettingsPermissions => 'അനുമതികൾ';

  @override
  String get descSettingsPermissions =>
      'പ്രത്യേകവും അന്തർലീനവുമായ അനുമതികളുടെ വിവരങ്ങൾ';

  @override
  String get labelSettingsHelp => 'സഹായവും സവിശേഷതകളും';

  @override
  String get descSettingsHelp =>
      'AR കോഡ്‌വിഷൻ, എയർ ക്യുആർ, ക്വിഷിംഗ് ഗാർഡ്, സുരക്ഷ';

  @override
  String get descSettingsAbout => 'ആപ്പ് പതിപ്പ്, നിർമ്മാതാവ്, ലൈസൻസ് വിവരങ്ങൾ';

  @override
  String get labelFeedbackVibration => 'വൈബ്രേഷൻ പ്രതികരണം';

  @override
  String get descFeedbackVibration =>
      'കോഡ് സ്കാൻ ചെയ്യുമ്പോൾ ഫോൺ വൈബ്രേറ്റ് ചെയ്യുക';

  @override
  String get labelFeedbackSound => 'ശബ്ദ പ്രതികരണം (ബീപ്പ്)';

  @override
  String get descFeedbackSound =>
      'കോഡ് തിരിച്ചറിയുമ്പോൾ ചെറിയ ശബ്ദം കേൾപ്പിക്കുക';

  @override
  String get labelFeedbackAnimation => 'സ്ഥിരീകരണ ആനിമേഷൻ';

  @override
  String get descFeedbackAnimation =>
      'കോഡ് സ്കാൻ ചെയ്യുമ്പോൾ റെറ്റിക്കിൾ പൾസും ചിഹ്നവും കാണിക്കുക';

  @override
  String get titlePrivacyScreen => 'സ്വകാര്യതയും നെറ്റ്‌വർക്ക് പരിശോധനയും';

  @override
  String get labelPrivacyActiveChecks => 'ഓൺലൈൻ പരിശോധനകൾ';

  @override
  String get descPrivacySummaryOn => 'ഓൺലൈൻ പരിശോധനകൾ സജീവമാണ്';

  @override
  String get descPrivacySummaryOff => 'ഓഫ്‌ലൈൻ സ്വകാര്യ പരിശോധനകൾ മാത്രം';

  @override
  String get labelApiKeyConfigured => 'ക്രമീകരിച്ചിരിക്കുന്നു';

  @override
  String get labelApiKeyNotConfigured => 'ക്രമീകരിച്ചിട്ടില്ല';

  @override
  String get titleApiKeyDelete => 'API കീ നീക്കംചെയ്യുക';

  @override
  String get actionDelete => 'ഇല്ലാതാക്കുക';

  @override
  String get actionApiKeySave => 'API കീ സംരക്ഷിക്കുക';

  @override
  String get titlePermissionsScreen => 'അനുമതി വിവരങ്ങൾ';

  @override
  String get helpPermissionsExplicitHeading => 'പ്രത്യേക അനുമതികൾ (റൺടൈം)';

  @override
  String get helpPermissionCameraTitle =>
      'ക്യാമറ അനുമതി (android.permission.CAMERA)';

  @override
  String get helpPermissionCameraDesc =>
      'സ്കാൻ ചെയ്യുന്ന വേളയിൽ മാത്രം ചോദിക്കുന്നു. ലൈവ് സ്കാനിംഗ്, AR ഹഡ്, എയർ ക്യുആർ ഡീകോഡിംഗ് എന്നിവയ്ക്ക് ആവശ്യമാണ്.';

  @override
  String get helpPermissionBiometricTitle =>
      'ബയോമെട്രിക് അനുമതി (android.permission.USE_BIOMETRIC)';

  @override
  String get helpPermissionBiometricDesc =>
      'സുരക്ഷിത വോൾട്ടുകളും എൻക്രിപ്റ്റ് ചെയ്ത ക്യുആർ കോഡുകളും അൺലോക്ക് ചെയ്യാൻ ഉപയോഗിക്കുന്നു.';

  @override
  String get helpPermissionsImplicitHeading => 'അന്തർലീന സിസ്റ്റം അനുമതികൾ';

  @override
  String get helpPermissionInternetTitle =>
      'ഇന്റർനെറ്റ് അനുമതി (android.permission.INTERNET)';

  @override
  String get helpPermissionInternetDesc =>
      'ഓൺലൈൻ പരിശോധനയോ ഗൂഗിൾ സേഫ് ബ്രൗസിംഗ് APIയോ സജീവമാക്കുമ്പോൾ മാത്രം ഉപയോഗിക്കുന്നു.';

  @override
  String get helpPermissionVibrateTitle =>
      'വൈബ്രേഷൻ അനുമതി (android.permission.VIBRATE)';

  @override
  String get helpPermissionVibrateDesc =>
      'സ്കാൻ ചെയ്യുമ്പോഴും ബട്ടണുകൾ അമർത്തുമ്പോഴും ഹാപ്റ്റിക് വൈബ്രേഷൻ നൽകാൻ ഉപയോഗിക്കുന്നു.';

  @override
  String get helpPermissionPhotoPickerTitle => 'ഫോട്ടോ പിക്കർ അനുമതി';

  @override
  String get helpPermissionPhotoPickerDesc =>
      'ഫോൺ സ്റ്റോറേജ് മുഴുവൻ നൽകാതെ തന്നെ ഗാലറിയിൽ നിന്ന് ചിത്രങ്ങളോ വീഡിയോകളോ തിരഞ്ഞെടുക്കാം.';

  @override
  String get helpPermissionsSettingHeading =>
      'ക്രമീകരണങ്ങളെ അടിസ്ഥാനമാക്കിയുള്ള അനുമതികൾ';

  @override
  String get helpPermissionProbingTitle => 'ഓൺലൈൻ നെറ്റ്‌വർക്ക് പരിശോധന';

  @override
  String get helpPermissionProbingDesc =>
      'സജീവമാക്കുമ്പോൾ മാത്രം വെബ്‌സൈറ്റുകളിലേക്ക് സുരക്ഷിത കണക്ഷൻ വഴി റീഡയറക്‌ട് വിവരങ്ങൾ അറിയാൻ ശ്രമിക്കുന്നു. ഓഫാക്കിയാൽ 100% ഓഫ്‌ലൈൻ.';

  @override
  String get helpPermissionSafeBrowsingTitle => 'ഗൂഗിൾ സേഫ് ബ്രൗസിംഗ് API';

  @override
  String get helpPermissionSafeBrowsingDesc =>
      'API കീ നൽകുമ്പോൾ മാത്രം സുരക്ഷാ വിവരങ്ങൾക്കായി ഗൂഗിൾ ഭീഷണി ഡാറ്റാബേസിൽ പരിശോധിക്കുന്നു.';

  @override
  String get helpPermissionFeedbackTitle => 'സ്കാൻ വൈബ്രേഷൻ ഫീഡ്‌ബാക്ക്';

  @override
  String get helpPermissionFeedbackDesc =>
      'ക്രമീകരണങ്ങളിൽ വൈബ്രേഷൻ ഓൺ ചെയ്യുമ്പോൾ മാത്രം പ്രവർത്തിക്കുന്നു.';

  @override
  String get labelOn => 'ഓൺ';

  @override
  String get labelOff => 'ഓഫ്';

  @override
  String get descPrivacyActiveChecks =>
      'ഓഫ്: സ്കാൻ ചെയ്യുന്ന ലിങ്കുകൾ സ്വകാര്യമായി പരിശോധിക്കുന്നു — സർവറുമായി ബന്ധപ്പെടില്ല.';

  @override
  String get bodyPrivacyExplainerOn =>
      'ഓൺ ചെയ്യുമ്പോൾ, SSL, റീഡയറക്‌ട് എന്നിവ പരിശോധിക്കാൻ സൈറ്റിലേക്ക് നേരിട്ട് കണക്റ്റുചെയ്യുന്നു. ഇത് നിങ്ങളുടെ IP വിലാസം വെളിപ്പെടുത്താം.';

  @override
  String get bodyPrivacyExplainerOff =>
      'പ്രാദേശിക നിയമങ്ങൾ മാത്രമുപയോഗിച്ച് സുരക്ഷിതമായി പരിശോധിക്കുന്നു. ലിങ്കുകൾ മൂന്നാം കക്ഷി സെർവറുകളിലേക്ക് അയയ്ക്കില്ല.';

  @override
  String get bodyApiKeyDelete =>
      'നിങ്ങളുടെ ഗൂഗിൾ സേഫ് ബ്രൗസിംഗ് API കീ നീക്കംചെയ്യണമെന്ന് ഉറപ്പാണോ? തുടർന്ന് ഓൺലൈൻ സുരക്ഷാ പരിശോധന പ്രവർത്തനരഹിതമാകും.';

  @override
  String descFeedbackSummary(String vibration, String sound) {
    return 'വൈബ്രേഷൻ: $vibration • ശബ്ദം: $sound';
  }

  @override
  String get labelResultTypeTextFallback => 'ടെക്സ്റ്റ്';

  @override
  String get labelCheckNameHttps => 'HTTPS കണക്ഷൻ';

  @override
  String get labelCheckNameSsl => 'SSL/TLS സർട്ടിഫിക്കറ്റ്';

  @override
  String get labelCheckNameRedirect => 'റീഡയറക്റ്റ് വിശകലനം';

  @override
  String get labelCheckNamePattern => 'പാറ്റേൺ കണ്ടെത്തൽ';

  @override
  String get labelCheckNameShortener => 'URL ചുരുക്കൽ പരിശോധന';

  @override
  String get labelCheckNameHomograph => 'ഹോമോഗ്രാഫ് തട്ടിപ്പ് പരിശോധന';

  @override
  String get labelCheckNameMalicious => 'ക്ഷുദ്ര ഉള്ളടക്ക പരിശോധന';

  @override
  String get bodyHttpsNotUsed =>
      'സുരക്ഷിതമല്ലാത്ത HTTP കണക്ഷനാണ് ഉപയോഗിക്കുന്നത്';

  @override
  String get bodySslPrivateModeOk =>
      'HTTPS ഉപയോഗിക്കുന്നു (സ്വകാര്യ മോഡിൽ തത്സമയ സർട്ടിഫിക്കറ്റ് പരിശോധിച്ചിട്ടില്ല)';

  @override
  String get bodySslValid => 'സാധുവായ SSL സർട്ടിഫിക്കറ്റ്';

  @override
  String get bodySslExpired => 'SSL സർട്ടിഫിക്കറ്റിന്റെ കാലാവധി കഴിഞ്ഞു';

  @override
  String get bodySslNotYetValid => 'SSL സർട്ടിഫിക്കറ്റ് ഇതുവരെ സാധുവല്ല';

  @override
  String get bodySslUnverifiable => 'സർട്ടിഫിക്കറ്റ് സ്ഥിരീകരിക്കാനായില്ല';

  @override
  String get bodySslCheckFailed => 'സർട്ടിഫിക്കറ്റ് പരിശോധന പരാജയപ്പെട്ടു';

  @override
  String get bodyRedirectSkippedPrivate =>
      'സ്വകാര്യ മോഡിൽ ഒഴിവാക്കി (സെർവറുമായി ബന്ധപ്പെട്ടില്ല)';

  @override
  String get bodyRedirectLoop => 'റീഡയറക്റ്റ് ലൂപ്പ് കണ്ടെത്തി';

  @override
  String get bodyRedirectNone => 'റീഡയറക്റ്റുകളൊന്നും കണ്ടെത്തിയില്ല';

  @override
  String get bodyRedirectUnavailable => 'റീഡയറക്റ്റുകൾ പരിശോധിക്കാനായില്ല';

  @override
  String get bodyPatternNone => 'സംശയാസ്പദമായ പാറ്റേണുകളൊന്നും കണ്ടെത്തിയില്ല';

  @override
  String get bodyPatternUnavailable => 'പാറ്റേണുകൾ വിശകലനം ചെയ്യാനായില്ല';

  @override
  String get bodyShortenerOfflineHeuristics =>
      'പൂർണ്ണ പരിശോധന സാധ്യമല്ല (ഓഫ്‌ലൈൻ) - അനുമാനങ്ങൾ മാത്രം';

  @override
  String get bodyShortenerNone => 'ചുരുക്കിയ ലിങ്കല്ല';

  @override
  String get bodyShortenerUnavailable =>
      'ചുരുക്കിയ ലിങ്കുകൾ പരിശോധിക്കാനായില്ല';

  @override
  String get bodyHomographMixedScripts => 'സമ്മിശ്ര ലിപികൾ കണ്ടെത്തി';

  @override
  String get bodyHomographNone => 'വ്യാജ രൂപസാദൃശ്യ അക്ഷരങ്ങളില്ല';

  @override
  String get bodyHomographUnavailable => 'ഹോമോഗ്രാഫുകൾ പരിശോധിക്കാനായില്ല';

  @override
  String get bodyMaliciousSkippedNoKey =>
      'ഒഴിവാക്കി (API കീ ക്രമീകരിച്ചിട്ടില്ല)';

  @override
  String get bodyMaliciousDailyLimit =>
      'പ്രതിദിന API പരിധി കഴിഞ്ഞു (നാളെ പുനഃസ്ഥാപിക്കും)';

  @override
  String get bodyMaliciousNone => 'അറിയപ്പെടുന്ന ഭീഷണികളൊന്നും കണ്ടെത്തിയില്ല';

  @override
  String get bodyMaliciousInvalidKey => 'അസാധുവായ API കീ അല്ലെങ്കിൽ അഭ്യർത്ഥന';

  @override
  String get bodyMaliciousRateLimited => 'അഭ്യർത്ഥനകളുടെ പരിധി കവിഞ്ഞു';

  @override
  String get bodyMaliciousUnavailable => 'ക്ഷുദ്ര ഉള്ളടക്കം പരിശോധിക്കാനായില്ല';

  @override
  String get errorStegoWrongPassphrase =>
      'ഡീക്രിപ്ഷൻ പരാജയപ്പെട്ടു. തെറ്റായ രഹസ്യവാക്ക് അല്ലെങ്കിൽ തകരാറിലായ ഡാറ്റ.';

  @override
  String get errorAirQrChecksumFailed => 'ഡാറ്റാ സ്ഥിരീകരണം പരാജയപ്പെട്ടു.';

  @override
  String bodyRedirectSuspiciousChain(String count) {
    return 'സംശയാസ്പദമായ റീഡയറക്റ്റ് ശൃംഖല ($count റീഡയറക്റ്റുകൾ)';
  }

  @override
  String bodyRedirectWithinRange(String count) {
    return '$count റീഡയറക്റ്റ് - സാധാരണ പരിധിയിലാണ്';
  }

  @override
  String bodyPatternDetected(String patterns) {
    return 'കണ്ടെത്തിയവ: $patterns';
  }

  @override
  String bodyShortenerKnown(String shortener) {
    return 'അറിയപ്പെടുന്ന ചുരുക്കിയ URL കണ്ടെത്തി ($shortener)';
  }

  @override
  String bodyShortenerRedirect(String host) {
    return 'ചുരുക്കിയ ലിങ്ക് കണ്ടെത്തി ($host എന്നതിലേക്ക് നയിക്കുന്നു)';
  }

  @override
  String bodyHomographLookalikes(String characters) {
    return 'രൂപസാദൃശ്യ അക്ഷരങ്ങൾ കണ്ടെത്തി: $characters';
  }

  @override
  String bodyMaliciousThreats(String threats) {
    return 'ഭീഷണികൾ കണ്ടെത്തി: $threats';
  }

  @override
  String bodyMaliciousApiError(String status) {
    return 'API പിശക് (പദവി: $status)';
  }

  @override
  String get labelCheckNameVirusTotal => 'VirusTotal';

  @override
  String get bodyVirusTotalSkippedNoKey =>
      'ഒഴിവാക്കി (API കീ ക്രമീകരിച്ചിട്ടില്ല)';

  @override
  String get bodyVirusTotalDailyLimit => 'ദൈനിക പരിധി കഴിഞ്ഞു (500/ദിവസം)';

  @override
  String bodyVirusTotalThreats(String engines) {
    return '$engines എൻജിൻ(കൾ) ഭീഷണി കണ്ടെത്തി';
  }

  @override
  String get bodyVirusTotalNone => 'ഭീഷണി കണ്ടെത്തിയില്ല (VirusTotal)';

  @override
  String get bodyVirusTotalInvalidKey => 'തെറ്റായ API കീ (VirusTotal)';

  @override
  String get bodyVirusTotalRateLimited => 'നിരക്ക് പരിധി കഴിഞ്ഞു (VirusTotal)';

  @override
  String bodyVirusTotalApiError(String status) {
    return 'API പിശക് (നില: $status)';
  }

  @override
  String get bodyVirusTotalUnavailable =>
      'പരിശോധിക്കാൻ കഴിഞ്ഞില്ല (VirusTotal)';

  @override
  String get labelCheckNameUrlhaus => 'URLhaus';

  @override
  String get bodyUrlhausSkippedNoKey =>
      'ഒഴിവാക്കി (API കീ ക്രമീകരിച്ചിട്ടില്ല)';

  @override
  String bodyUrlhausMalware(String tags) {
    return 'ക്ഷുദ്രവെയർ URL കണ്ടെത്തി: $tags';
  }

  @override
  String get bodyUrlhausClean => 'ക്ഷുദ്ര ഹോസ്റ്റിംഗ് ഇല്ല (URLhaus)';

  @override
  String get bodyUrlhausNotFound => 'URLhaus ഡേറ്റാബേസിൽ ഇല്ല';

  @override
  String get bodyUrlhausInvalidKey => 'തെറ്റായ API കീ (URLhaus)';

  @override
  String bodyUrlhausApiError(String status) {
    return 'API പിശക് (നില: $status)';
  }

  @override
  String get bodyUrlhausUnavailable => 'പരിശോധിക്കാൻ കഴിഞ്ഞില്ല (URLhaus)';

  @override
  String get labelCheckNamePhishTank => 'PhishTank';

  @override
  String get bodyPhishTankSkippedDisabled => 'ഒഴിവാക്കി (PhishTank നിഷ്ക്രിയം)';

  @override
  String get bodyPhishTankPhishing =>
      'അറിയപ്പെടുന്ന ഫിഷിംഗ് സൈറ്റ് (PhishTank)';

  @override
  String get bodyPhishTankClean => 'ഫിഷിംഗ് സൈറ്റ് അല്ല (PhishTank)';

  @override
  String get bodyPhishTankNotInDatabase => 'PhishTank ഡേറ്റാബേസിൽ ഇല്ല';

  @override
  String bodyPhishTankApiError(String status) {
    return 'API പിശക് (നില: $status)';
  }

  @override
  String get bodyPhishTankUnavailable => 'പരിശോധിക്കാൻ കഴിഞ്ഞില്ല (PhishTank)';

  @override
  String get labelCheckNameOpenPhish => 'OpenPhish';

  @override
  String get bodyOpenPhishSkippedDisabled => 'ഒഴിവാക്കി (OpenPhish നിഷ്ക്രിയം)';

  @override
  String get bodyOpenPhishPhishing =>
      'അറിയപ്പെടുന്ന ഫിഷിംഗ് സൈറ്റ് (OpenPhish)';

  @override
  String get bodyOpenPhishClean => 'ഫിഷിംഗ് ഫീഡിൽ ഇല്ല (OpenPhish)';

  @override
  String get bodyOpenPhishFeedStale =>
      'ഫീഡ് ലഭ്യമല്ല — ഓഫ്‌ലൈൻ പരിശോധന ഒഴിവാക്കി';

  @override
  String get bodyOpenPhishUnavailable => 'പരിശോധിക്കാൻ കഴിഞ്ഞില്ല (OpenPhish)';

  @override
  String get labelSettingsUrlSafetyProviders => 'URL സുരക്ഷാ ദാതാക്കൾ';

  @override
  String descSettingsUrlSafetyProviders(String count) {
    return '$count ദാതാക്കൾ സജീവം';
  }

  @override
  String get helpUrlSafetyProviders =>
      'ഓൺലൈൻ URL സുരക്ഷാ പരിശോധനകൾ ക്രമീകരിക്കുക. ഓരോ ദാതാവും സ്വതന്ത്രമാണ്. വ്യക്തിഗത API കീ ആവശ്യമുള്ളവ ചിഹ്നീകരിച്ചിരിക്കുന്നു.';

  @override
  String get titleUrlSafetyUserSupplied => 'നിങ്ങളുടെ API കീകൾ';

  @override
  String get descUrlSafetyUserSupplied => 'വ്യക്തിഗതേതര ഉപയോഗം മാത്രം';

  @override
  String get titleUrlSafetyBuiltIn => 'ബിൽറ്റ്-ഇൻ ദാതാക്കൾ';

  @override
  String get descUrlSafetyBuiltIn => 'അക്കൗണ്ട് ആവശ്യമില്ല — ടോഗിൾ ചെയ്യുക';

  @override
  String get labelProviderEndpoint => 'API എൻഡ്‌പോയിന്റ് URL';

  @override
  String get labelProviderApiKey => 'നിങ്ങളുടെ API കീ ഒട്ടിക്കുക';

  @override
  String get bodyProviderGetKeyAt => 'സൗജന്യ കീ ലഭിക്കാൻ:';

  @override
  String bodyProviderDailyUsage(String used, String max) {
    return 'ഇന്ന് $used / $max അഭ്യർത്ഥനകൾ';
  }

  @override
  String bodyOpenPhishLastUpdated(String datetime) {
    return 'അവസാനം അപ്ഡേറ്റ് ചെയ്തത്: $datetime';
  }

  @override
  String get actionOpenPhishRefresh => 'ഫീഡ് ഇപ്പോൾ പുതുക്കുക';

  @override
  String bodyOpenPhishFeedRefreshed(String count) {
    return 'ഫീഡ് അപ്ഡേറ്റ് ചെയ്തു ($count URLs)';
  }

  @override
  String get errorOpenPhishFeedFailed => 'ഫീഡ് പുതുക്കൽ പരാജയപ്പെട്ടു';

  @override
  String get labelPhishTankToggle => 'PhishTank പ്രവർത്തനക്ഷമമാക്കുക';

  @override
  String get labelOpenPhishToggle => 'OpenPhish ഫീഡ് ഉപയോഗിക്കുക';

  @override
  String get bodyQuishingSummaryAuthentic =>
      'യഥാർത്ഥ പ്രിന്റ് ചെയ്ത കോഡ്. ഭൗതിക കൃത്രിമത്വം കണ്ടെത്തിയില്ല.';

  @override
  String get bodyQuishingSummaryWearAndTear =>
      'തേയ്മാനം കണ്ടെത്തി. ഉപരിതലത്തിൽ ചെറിയ മാറ്റങ്ങൾ കാണുന്നു.';

  @override
  String get bodyQuishingSummaryHighWarning =>
      'ഉയർന്ന മുന്നറിയിപ്പ്: ഭൗതിക സ്റ്റിക്കർ പതിച്ചതായി കണ്ടെത്തി! തുറക്കും മുൻപ് സ്ഥിരീകരിക്കുക.';

  @override
  String get bodyQuishingStatusAuthentic => '🟢 യഥാർത്ഥ പ്രിന്റ് ചെയ്ത കോഡ്';

  @override
  String get bodyQuishingStatusWearAndTear => '🟡 തേയ്മാനം കണ്ടെത്തി';

  @override
  String get bodyQuishingStatusHighWarning =>
      '🔴 ഉയർന്ന മുന്നറിയിപ്പ്: ഭൗതിക സ്റ്റിക്കർ കണ്ടെത്തി!';

  @override
  String get bodyQuishingSignalMicroShadowPerimeter =>
      'മാട്രിക്സ് ചുറ്റളവിൽ ചെറിയ നിഴൽ വര കണ്ടെത്തി';

  @override
  String get bodyQuishingSignalGrainAberration =>
      'പ്രിന്റ് തരികളുടെ പൊരുത്തക്കേട് കണ്ടെത്തി';

  @override
  String get bodyQuishingSignalUniformReflection =>
      'പ്രതല പ്രതിഫലനം സ്ഥിരീകരിച്ചു';

  @override
  String get bodyQuishingSignalConsistentDotsQrMatrix =>
      'ക്യുആർ മാട്രിക്സിൽ ഒരേപോലെയുള്ള ഡോട്ട് സാന്ദ്രത';

  @override
  String get bodyQuishingSignalReflectionVerified =>
      'പ്രതല പ്രതിഫലനം സ്ഥിരീകരിച്ചു';

  @override
  String get bodyQuishingSignalHalftoneConsistentQrMatrix =>
      'മാട്രിക്സ് ചുറ്റളവിൽ കൃത്യമായ ഡോട്ട് സാന്ദ്രത';

  @override
  String get bodyQuishingSignalHalftoneConsistentMatrix =>
      'മാട്രിക്സിൽ ഉടനീളം കൃത്യമായ ഡോട്ട് സാന്ദ്രത';

  @override
  String get bodyQuishingSignalDoubleEdgeAroundMatrix =>
      'മാട്രിക്സിന് ചുറ്റും ഇരട്ട അരികുകൾ കണ്ടെത്തി';

  @override
  String get bodyQuishingSignalMicroShadowStickerBorder =>
      'സ്റ്റിക്കർ അതിർത്തിയിൽ ചെറിയ നിഴൽ വര കണ്ടെത്തി';

  @override
  String get bodyQuishingSignalGrainMismatchBase =>
      'അടിസ്ഥാന പ്രതലവുമായി പൊരുത്തപ്പെടാത്ത പ്രിന്റ് തരികൾ';

  @override
  String get bodyQuishingSignalMinorScratch =>
      'ചെറിയ പോറലുകളോ തേയ്മാനമോ കാണപ്പെടുന്നു';

  @override
  String get bodyQuishingSignalSlightDotIrregularity =>
      'അരികുകളിൽ ചെറിയ ഡോട്ട് വ്യതിയാനങ്ങൾ';

  @override
  String get bodyQuishingSignalConsistentDotsMatrixPerimeter =>
      'ചുറ്റളവിൽ ഒരേപോലെയുള്ള ഡോട്ട് സാന്ദ്രത';

  @override
  String bodyQuishingSignalPerimeterDoubleEdge(String zones) {
    return 'ഇരട്ട അരികുകളുടെ പ്രതിഫലനം കണ്ടെത്തി ($zones അതിർത്തി മേഖലകൾ)';
  }

  @override
  String bodyQuishingSignalDotDensityVariance(String variance) {
    return 'ഡോട്ട് സാന്ദ്രതയിൽ പൊരുത്തക്കേട് കണ്ടെത്തി ($variance% വ്യതിയാനം)';
  }

  @override
  String get bodyDomSslInvalidScheme => 'അസാധുവായ URL സ്കീം';

  @override
  String get bodyDomSslHttps =>
      'എൻക്രിപ്റ്റ് ചെയ്ത HTTPS പ്രോട്ടോക്കോൾ ഉപയോഗിക്കുന്നു';

  @override
  String get bodyDomSslHttp =>
      'സുരക്ഷിതമല്ലാത്ത HTTP കണക്ഷൻ (ഉയർന്ന അപകടസാധ്യത)';

  @override
  String get bodyDomStatusInvalidUrl => 'അസാധുവായ വെബ് URL ഘടന.';

  @override
  String get bodyDomStatusHttpCaution =>
      '⚠️ ജാഗ്രത: എൻക്രിപ്റ്റ് ചെയ്യാത്ത HTTP സൈറ്റ്';

  @override
  String get bodyDomStatusSafe =>
      '✅ സുരക്ഷിതമായ സാൻഡ്‌ബോക്സ്: HTML പ്രിവ്യൂ ശുദ്ധീകരിച്ചു.';

  @override
  String bodyDomStatusOpenRedirect(String target) {
    return '⚠️ മുന്നറിയിപ്പ്: $target എന്നതിലേക്ക് നയിക്കുന്ന ഓപ്പൺ റീഡയറക്റ്റ് കണ്ടെത്തി';
  }

  @override
  String bodyDomStatusNewDomain(String days) {
    return '⚠️ മുന്നറിയിപ്പ്: അടുത്തിടെ രജിസ്റ്റർ ചെയ്ത ഡൊമെയ്ൻ ($days ദിവസം പഴക്കം)';
  }

  @override
  String get errorStegoPassphraseEmpty => 'രഹസ്യവാക്ക് ശൂന്യമാകരുത്';

  @override
  String get bodyStegoBiometricReason =>
      'സ്റ്റെഗോ ക്യുആർ രഹസ്യം കാണുന്നതിന് ആധികാരികത ഉറപ്പാക്കുക';

  @override
  String get errorMediaNoCodeInImage =>
      'ചിത്രത്തിൽ കോഡുകളൊന്നും കണ്ടെത്തിയില്ല.';

  @override
  String get errorMediaNoCodeInPdf => 'PDF രേഖയിൽ കോഡുകളൊന്നും കണ്ടെത്തിയില്ല.';

  @override
  String errorMediaImagePickFailed(String error) {
    return 'ചിത്രം സ്കാൻ ചെയ്യാൻ കഴിഞ്ഞില്ല: $error';
  }

  @override
  String errorMediaImageAnalyzeFailed(String error) {
    return 'ചിത്രം പരിശോധിക്കുന്നതിൽ തടസ്സം: $error';
  }

  @override
  String errorMediaPdfPickFailed(String error) {
    return 'PDF തുറക്കാൻ കഴിഞ്ഞില്ല: $error';
  }

  @override
  String errorMediaPdfScanFailed(String error) {
    return 'PDF രേഖ സ്കാൻ ചെയ്യാൻ കഴിഞ്ഞില്ല: $error';
  }

  @override
  String get errorStegoBiometricCanceled =>
      'ബയോമെട്രിക് പരിശോധന റദ്ദാക്കി അല്ലെങ്കിൽ പരാജയപ്പെട്ടു.';

  @override
  String get labelFormatQrUrl => 'ക്യുആർ (ലിങ്ക്)';

  @override
  String get labelFormatQrEmail => 'ക്യുആർ (ഇമെയിൽ)';

  @override
  String get labelFormatQrPhone => 'ക്യുആർ (ഫോൺ)';

  @override
  String get labelFormatQrSms => 'ക്യുആർ (SMS)';

  @override
  String get labelFormatQrWifi => 'ക്യുആർ (വൈ-ഫൈ)';

  @override
  String get labelFormatQrLocation => 'ക്യുആർ (സ്ഥാനം)';

  @override
  String get labelFormatQrContact => 'ക്യുആർ (കോൺടാക്റ്റ്)';

  @override
  String get labelFormatIsbn => 'ISBN';

  @override
  String get labelFormatEanUpc => 'EAN/UPC';

  @override
  String get labelFormatQrCode => 'ക്യുആർ കോഡ്';

  @override
  String get labelFormatEanUpcProduct => 'EAN/UPC ഉൽപ്പന്നം';

  @override
  String get labelFormatBarcode => 'ബാർകോഡ്';

  @override
  String get labelWifiHiddenNetwork => 'മറഞ്ഞിരിക്കുന്ന ശൃംഖല';

  @override
  String get labelTotpDefaultAccount => 'അക്കൗണ്ട്';

  @override
  String get errorBackupInvalidFormat => 'അസാധുവായ ബാക്കപ്പ് ഫയൽ ഫോർമാറ്റ്.';

  @override
  String get errorBackupBadHeader => 'അസാധുവായ ബാക്കപ്പ് ഫയൽ ഹെഡർ.';

  @override
  String get errorBackupWrongPassphrase =>
      'തെറ്റായ രഹസ്യവാക്ക് അല്ലെങ്കിൽ തകരാറിലായ ബാക്കപ്പ്.';

  @override
  String get bodyReportHeading =>
      'ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ - സ്കാൻ നാൾവഴി';

  @override
  String get bodyReportTitle => 'സ്കാൻ നാൾവഴി കയറ്റുമതി';

  @override
  String get labelReportExportDate => 'കയറ്റുമതി ചെയ്ത തീയതി';

  @override
  String get labelReportTotalScans => 'ആകെ സ്കാനുകൾ';

  @override
  String get labelReportScanNumber => 'സ്കാൻ #';

  @override
  String get labelReportId => 'ഐഡി          ';

  @override
  String get labelReportTimestamp => 'തീയതിയും സമയവും ';

  @override
  String get labelReportFormat => 'ഫോർമാറ്റ്      ';

  @override
  String get labelReportCategory => 'വിഭാഗം        ';

  @override
  String get labelReportSafetyScore => 'സുരക്ഷാ നിരക്ക്';

  @override
  String get labelReportStarred => 'പ്രിയപ്പെട്ടത്   ';

  @override
  String get labelReportStarredYes => '⭐ അതെ';

  @override
  String get labelReportStarredNo => 'ഇല്ല';

  @override
  String get labelReportLocation => 'സ്ഥലം         ';

  @override
  String get labelReportNotes => 'കുറിപ്പുകൾ     ';

  @override
  String get labelReportContent => 'ഉള്ളടക്കം      ';

  @override
  String get labelReportColumnDateTime => 'തീയതിയും സമയവും';

  @override
  String get labelReportColumnFormat => 'ഫോർമാറ്റ്';

  @override
  String get labelReportColumnCategory => 'വിഭാഗം';

  @override
  String get labelReportColumnSafety => 'സുരക്ഷ';

  @override
  String get labelReportColumnContent => 'ഉള്ളടക്കം';

  @override
  String get labelReportColumnNotes => 'കുറിപ്പുകൾ';

  @override
  String get labelPatternIpAddress => 'IP വിലാസം';

  @override
  String get labelPatternLongNumbers => 'നീണ്ട സംഖ്യാ ശ്രേണി';

  @override
  String get labelPatternManyDashes => 'ഒന്നിലധികം വരകൾ/അണ്ടർസ്കോറുകൾ';

  @override
  String get labelPatternPhishingKeywords => 'ഫിഷിംഗ് കീവേഡുകൾ';

  @override
  String get labelPatternDataUri => 'ഡാറ്റ URI';

  @override
  String get labelPatternManySubdomains => 'ഒന്നിലധികം സബ് ഡൊമെയ്നുകൾ';

  @override
  String get bodyShortenerPossibleShortDomain =>
      'ചുരുക്കിയ ലിങ്ക് സാധ്യത: ചെറിയ ഡൊമെയ്ൻ';

  @override
  String get bodyShortenerPossibleRandomPath =>
      'ചുരുക്കിയ ലിങ്ക് സാധ്യത: ക്രമരഹിതമായ അക്ഷര പാത';

  @override
  String bodyShortenerPossibleTld(String tld) {
    return 'ചുരുക്കിയ ലിങ്ക് സാധ്യത ($tld)';
  }

  @override
  String get titleSettingsFeatures => 'സവിശേഷതകൾ';

  @override
  String get descSettingsFeatures => 'ആപ്പിന്റെ എല്ലാ സവിശേഷതകളും അറിയുക';

  @override
  String get titleAppearanceHub => 'രൂപഭംഗി';

  @override
  String get labelAppearanceThemeModeCard => 'തീം മോഡ്';

  @override
  String get descAppearanceThemeModeCard =>
      'സിസ്റ്റം, ലൈറ്റ്, ഡാർക്ക് അല്ലെങ്കിൽ OLED മോഡ് തിരഞ്ഞെടുക്കുക';

  @override
  String get labelAppearanceOverlayCard => 'സ്കാൻ ഓവർലേ ശൈലി';

  @override
  String get descAppearanceOverlayCard =>
      'ലേസർ വര, കോണുകൾ, സൈബർ ഗ്രിഡ് അല്ലെങ്കിൽ ഡോട്ട് മാട്രിക്സ്';

  @override
  String get labelAppearanceAccentCard => 'വർണ്ണങ്ങളും ഡൈനാമിക് തീമും';

  @override
  String get descAppearanceAccentCard =>
      'മെറ്റീരിയൽ യു നിറങ്ങളും ഇഷ്ടാനുസൃത വർണ്ണങ്ങളും';

  @override
  String get labelAppearanceTypographyCard => 'അക്ഷര ശൈലിയും വലുപ്പവും';

  @override
  String get descAppearanceTypographyCard =>
      'ഫോണ്ട് ശൈലിയും അക്ഷരങ്ങളുടെ വലുപ്പ ക്രമീകരണങ്ങളും';

  @override
  String get titleFeaturesHeader => 'എല്ലാ സവിശേഷതകളും';

  @override
  String get descFeaturesHeader =>
      'സ്കാനിംഗ് ടൂളുകൾ, 6-തല URL സുരക്ഷ, AR കോഡ്‌വിഷൻ, ഓഫ്‌ലൈൻ സൗകര്യങ്ങൾ എന്നിവ അറിയുക.';

  @override
  String get titleFeaturesCatScanning => 'സ്കാനിംഗ്';

  @override
  String get descFeaturesCatScanning =>
      'പല ഉറവിടങ്ങളിൽ നിന്നുള്ള മീഡിയ പിന്തുണയുള്ള അതിവേഗ 1D/2D ബാർകോഡ് എഞ്ചിൻ';

  @override
  String get titleFeaturesCatSafety => '6-തല ലിങ്ക് സുരക്ഷ';

  @override
  String get descFeaturesCatSafety =>
      'ദുരുദ്ദേശ്യമുള്ള QR ഫിഷിംഗിൽ നിന്നും തട്ടിപ്പുകളിൽ നിന്നും നിങ്ങളെ സംരക്ഷിക്കുന്ന സീറോ-ട്രസ്റ്റ് ഫോറൻസിക് വിശകലനം';

  @override
  String get titleFeaturesCatVision => 'ദൃഷ്ടി ഉപകരണങ്ങൾ';

  @override
  String get descFeaturesCatVision =>
      'ഫോണിൽ തന്നെ പ്രവർത്തിക്കുന്ന കമ്പ്യൂട്ടർ ദൃഷ്ടിയും പ്രകാശം വഴിയുള്ള ഓഫ്‌ലൈൻ ഡാറ്റാ കൈമാറ്റവും';

  @override
  String get titleFeaturesCatPayloads => 'സ്മാർട്ട് പ്രവർത്തനങ്ങൾ';

  @override
  String get descFeaturesCatPayloads =>
      'ദൈനംദിന ബാർകോഡുകൾക്ക് തൽക്ഷണ വിശകലനവും അനുയോജ്യമായ പ്രവർത്തനങ്ങളും';

  @override
  String get titleFeaturesCatHistory => 'നാൾവഴിയും സ്വകാര്യതയും';

  @override
  String get descFeaturesCatHistory =>
      'ബയോമെട്രിക് സുരക്ഷയും ഓഫ്‌ലൈൻ സംഭരണവും കൊണ്ട് സംരക്ഷിക്കുന്ന നിങ്ങളുടെ സ്കാൻ നാൾവഴി';

  @override
  String get titleFeatureBarcodeEngine => 'ബാർകോഡ് എഞ്ചിൻ';

  @override
  String get descFeatureBarcodeEngine =>
      '1D ബാർകോഡുകളും (EAN-13, UPC-A, Code 128, Code 39, Codabar, ITF) 2D കോഡുകളും (QR, Data Matrix, Aztec, PDF417) മില്ലിസെക്കൻഡുകൾക്കുള്ളിൽ ഡീകോഡ് ചെയ്യുന്നു.';

  @override
  String get labelFeatureBarcodeEngineChip1 => 'QR, Data Matrix';

  @override
  String get labelFeatureBarcodeEngineChip2 => 'Aztec, PDF417';

  @override
  String get labelFeatureBarcodeEngineChip3 => 'EAN, Code 128';

  @override
  String get titleFeatureMediaSources => 'ചിത്രങ്ങളും PDF-ഉം';

  @override
  String get descFeatureMediaSources =>
      'ലൈവ് ക്യാമറയിൽ നിന്നോ ഗാലറിയിലെ ചിത്രങ്ങളിൽ നിന്നോ പല പേജുകളുള്ള PDF രേഖകളിൽ നിന്നോ ബാർകോഡുകൾ സ്കാൻ ചെയ്യുക.';

  @override
  String get labelFeatureMediaSourcesChip1 => 'ഗാലറി ചിത്രങ്ങൾ';

  @override
  String get labelFeatureMediaSourcesChip2 => 'പല പേജ് PDF';

  @override
  String get labelFeatureMediaSourcesChip3 => 'ലൈവ് ക്യാമറ';

  @override
  String get titleFeatureGhostScan => 'ഗോസ്റ്റ്സ്കാൻ';

  @override
  String get descFeatureGhostScan =>
      'മെസേജിംഗ് ആപ്പുകൾ, സോഷ്യൽ ഫീഡുകൾ, ബ്രൗസറുകൾ എന്നിവയിൽ സ്ക്രീനിൽ കാണുന്ന QR കോഡുകൾ ക്വിക്ക് സെറ്റിങ്സ് ടൈൽ, ഫ്ലോട്ടിംഗ് സ്കാൻ ബബിൾ, അല്ലെങ്കിൽ ആവശ്യാനുസരണം കണ്ടെത്തി ഡീകോഡ് ചെയ്യുന്നു. സ്ക്രീൻഷോട്ടുകൾ സൂക്ഷിക്കില്ല.';

  @override
  String get labelFeatureGhostScanChip1 => 'ക്വിക്ക് ടൈൽ';

  @override
  String get labelFeatureGhostScanChip2 => 'സ്കാൻ ബബിൾ';

  @override
  String get labelFeatureGhostScanChip3 => 'സ്ക്രീൻഷോട്ട് ഇല്ല';

  @override
  String get titleFeatureCameraControls => 'ക്യാമറ നിയന്ത്രണങ്ങൾ';

  @override
  String get descFeatureCameraControls =>
      'സുഗമമായ സൂം സ്ലൈഡർ, ഫ്ലാഷ്‌ലൈറ്റ് സ്വിച്ച്, മുൻ-പിൻ ക്യാമറ മാറ്റം, കുറഞ്ഞ വെളിച്ചത്തിൽ സ്കാൻ ചെയ്യാൻ തുടർച്ചയായ ഓട്ടോഫോക്കസ്.';

  @override
  String get labelFeatureCameraControlsChip1 => 'ഫ്ലാഷ്‌ലൈറ്റ്';

  @override
  String get labelFeatureCameraControlsChip2 => 'സൂം നിയന്ത്രണം';

  @override
  String get labelFeatureCameraControlsChip3 => 'മുൻ/പിൻ ക്യാമറ';

  @override
  String get titleFeatureScanOverlays => 'സ്കാൻ ഓവർലേകൾ';

  @override
  String get descFeatureScanOverlays =>
      'ലേസർ ലൈൻ, മിടിക്കുന്ന മൂലകൾ, സൈബർനെറ്റിക് ഗ്രിഡ്, സൂക്ഷ്മ ഡോട്ട് മാട്രിക്സ് എന്നീ വ്യൂഫൈൻഡർ ഓവർലേകളിൽ ഒന്ന് തിരഞ്ഞെടുക്കുക.';

  @override
  String get labelFeatureScanOverlaysChip1 => '4 ഓവർലേ ശൈലികൾ';

  @override
  String get labelFeatureScanOverlaysChip2 => 'തത്സമയ ആനിമേഷൻ';

  @override
  String get labelFeatureScanOverlaysChip3 => 'OLED അനുയോജ്യം';

  @override
  String get titleFeatureFeedback => 'വൈബ്രേഷനും ശബ്ദവും';

  @override
  String get descFeatureFeedback =>
      'മാറ്റാവുന്ന വൈബ്രേഷനും ബീപ് ശബ്ദവും ശബ്ദമുള്ള സ്ഥലങ്ങളിൽ പോലും സ്കാൻ വിജയിച്ചെന്ന് ഉറപ്പാക്കുന്നു.';

  @override
  String get labelFeatureFeedbackChip1 => 'വൈബ്രേഷൻ';

  @override
  String get labelFeatureFeedbackChip2 => 'ബീപ് ശബ്ദം';

  @override
  String get labelFeatureFeedbackChip3 => 'പ്രത്യേക സ്വിച്ചുകൾ';

  @override
  String get titleFeatureProtocolGuard => '1. പ്രോട്ടോക്കോൾ കാവൽ';

  @override
  String get descFeatureProtocolGuard =>
      'സ്കീം ശരിയാണോ എന്നും HTTPS എൻക്രിപ്ഷൻ ഉണ്ടോ എന്നും പരിശോധിക്കുന്നു. സാധാരണ HTTP-യും പിന്തുണയില്ലാത്ത സ്കീമുകളും ചൂണ്ടിക്കാട്ടുന്നു.';

  @override
  String get labelFeatureProtocolGuardChip1 => 'HTTPS പരിശോധന';

  @override
  String get labelFeatureProtocolGuardChip2 => 'സ്കീം പരിശോധന';

  @override
  String get labelFeatureProtocolGuardChip3 => 'അദൃശ്യ അക്ഷര കെണി';

  @override
  String get titleFeatureHomographShield => '2. ഹോമോഗ്രാഫ് കവചം';

  @override
  String get descFeatureHomographShield =>
      'വ്യാജ ഡൊമെയ്ൻ പേരുകൾ മറയ്ക്കാൻ ഉപയോഗിക്കുന്ന സിറിലിക്, ഗ്രീക്ക്, യൂണികോഡ് സമാനാക്ഷരങ്ങൾ കണ്ടെത്തുന്നു (IDN punycode പ്രതിരോധം).';

  @override
  String get labelFeatureHomographShieldChip1 => 'Punycode പ്രതിരോധം';

  @override
  String get labelFeatureHomographShieldChip2 => 'സിറിലിക് സമാനങ്ങൾ';

  @override
  String get labelFeatureHomographShieldChip3 => 'മിശ്ര ലിപി കെണി';

  @override
  String get titleFeatureTldEntropy => '3. TLD, എൻട്രോപ്പി';

  @override
  String get descFeatureTldEntropy =>
      'അപകടസാധ്യതയുള്ള TLD-കളും അമിത സബ്ഡൊമെയ്നുകളും ചൂണ്ടിക്കാട്ടുന്നു. യന്ത്രം നിർമ്മിച്ച ഡൊമെയ്നുകൾ പിടിക്കാൻ പേരിലെ അക്ഷര എൻട്രോപ്പി അളക്കുന്നു.';

  @override
  String get labelFeatureTldEntropyChip1 => 'അപകട TLD-കൾ';

  @override
  String get labelFeatureTldEntropyChip2 => 'എൻട്രോപ്പി സ്കോർ';

  @override
  String get labelFeatureTldEntropyChip3 => 'സബ്ഡൊമെയ്ൻ ആഴം';

  @override
  String get titleFeatureIpPort => '4. IP, പോർട്ട്';

  @override
  String get descFeatureIpPort =>
      'നേരിട്ട് IP വിലാസത്തിലേക്കോ ഫയർവാൾ മറികടക്കാനുള്ള അസാധാരണ HTTP/HTTPS പോർട്ടുകളിലേക്കോ പോകുന്ന ലിങ്കുകൾ ചൂണ്ടിക്കാട്ടുന്നു.';

  @override
  String get labelFeatureIpPortChip1 => 'IP വിലാസ കെണി';

  @override
  String get labelFeatureIpPortChip2 => 'അസാധാരണ പോർട്ടുകൾ';

  @override
  String get labelFeatureIpPortChip3 => 'ഉള്ളിലെ യൂസർ വിവരം';

  @override
  String get titleFeatureHeadProbe => '5. ഓൺലൈൻ പരിശോധന';

  @override
  String get descFeatureHeadProbe =>
      'നിങ്ങൾ ഓൺ ചെയ്താൽ മാത്രം: ചെറു URL-കൾ തുറന്നു നോക്കാനും മറഞ്ഞ റീഡയറക്റ്റ് ശൃംഖലകൾ കണ്ടെത്താനും TLS സർട്ടിഫിക്കറ്റുകൾ ഉറപ്പാക്കാനും ലഘു HTTP HEAD പരിശോധന.';

  @override
  String get labelFeatureHeadProbeChip1 => 'റീഡയറക്റ്റ് ശൃംഖല';

  @override
  String get labelFeatureHeadProbeChip2 => 'ചെറു URL തുറക്കൽ';

  @override
  String get labelFeatureHeadProbeChip3 => 'ഓപ്റ്റ്-ഇൻ സ്വകാര്യത';

  @override
  String get titleFeatureSafeBrowsing => '6. സേഫ് ബ്രൗസിംഗ്';

  @override
  String get descFeatureSafeBrowsing =>
      'ദശലക്ഷക്കണക്കിന് അറിയപ്പെടുന്ന ദോഷകരമായ URL-കൾ, മാൽവെയർ കേന്ദ്രങ്ങൾ, സോഷ്യൽ എഞ്ചിനീയറിംഗ് സൈറ്റുകൾ എന്നിവയ്ക്കെതിരെ ഐച്ഛിക ക്ലൗഡ് ഭീഷണി വിവരം.';

  @override
  String get labelFeatureSafeBrowsingChip1 => 'Google ഭീഷണി DB';

  @override
  String get labelFeatureSafeBrowsingChip2 => 'കീ ഫോണിൽ മാത്രം';

  @override
  String get labelFeatureSafeBrowsingChip3 => 'ദൈനംദിന പരിധി';

  @override
  String get titleFeatureQuishingGuard => 'ക്വിഷിംഗ് ഗാർഡ്™';

  @override
  String get descFeatureQuishingGuard =>
      'QR കോഡിന് മുകളിൽ ഒട്ടിച്ച സ്റ്റിക്കറുകൾ, അരികിലെ വിടവുകൾ, ചെറു നിഴലുകൾ, അച്ചടി തരികൾ എന്നിവ കണ്ടെത്തുന്ന ഫോറൻസിക് കമ്പ്യൂട്ടർ ദൃഷ്ടി.';

  @override
  String get labelFeatureQuishingGuardChip1 => 'ഒട്ടിച്ച സ്റ്റിക്കർ';

  @override
  String get labelFeatureQuishingGuardChip2 => 'അരികിലെ വിടവ്';

  @override
  String get labelFeatureQuishingGuardChip3 => 'അച്ചടി തരി വിശകലനം';

  @override
  String get titleFeatureArCodeVision => 'AR കോഡ്‌വിഷൻ™';

  @override
  String get descFeatureArCodeVision =>
      'കണ്ടെത്തിയ എല്ലാ കോഡുകൾക്കും മുകളിൽ തത്സമയ സുരക്ഷാ ബാഡ്ജുകളുള്ള ചിപ്പുകൾ കാണിക്കുന്ന AR ബഹു-ബാർകോഡ് സ്കാനർ. ഒന്നിച്ച് തിരഞ്ഞെടുക്കാം.';

  @override
  String get labelFeatureArCodeVisionChip1 => 'സ്ഥാന ട്രാക്കിംഗ്';

  @override
  String get labelFeatureArCodeVisionChip2 => 'ബഹു-കോഡ് HUD';

  @override
  String get labelFeatureArCodeVisionChip3 => 'ബാച്ച് തിരഞ്ഞെടുപ്പ്';

  @override
  String get titleFeatureAirQr => 'എയർ ക്യുആർ™ കൈമാറ്റം';

  @override
  String get descFeatureAirQr =>
      'Wi-Fi-ഓ Bluetooth-ഓ ഇല്ലാതെ, പൂർണ്ണമായും ഓഫ്‌ലൈനായി, എൻക്രിപ്റ്റ് ചെയ്ത ടെക്സ്റ്റ്, ഫയലുകൾ, കീകൾ എന്നിവ ചലിക്കുന്ന QR വഴി അയയ്ക്കുകയും സ്വീകരിക്കുകയും ചെയ്യുന്നു.';

  @override
  String get labelFeatureAirQrChip1 => 'ചലിക്കുന്ന QR';

  @override
  String get labelFeatureAirQrChip2 => 'Reed-Solomon FEC';

  @override
  String get labelFeatureAirQrChip3 => '100% ഓഫ്‌ലൈൻ';

  @override
  String get titleFeatureStegoQr => 'സ്റ്റെഗോ ക്യുആർ™';

  @override
  String get descFeatureStegoQr =>
      'പ്രത്യേക QR കോഡുകൾക്കുള്ളിൽ അദൃശ്യമായി ഒളിപ്പിച്ച എൻക്രിപ്റ്റ് ചെയ്ത ഉള്ളടക്കവും വാട്ടർമാർക്ക് ഡാറ്റയും കണ്ടെത്തി പുറത്തെടുക്കുന്നു.';

  @override
  String get labelFeatureStegoQrChip1 => 'ഡികോയ് QR വായന';

  @override
  String get labelFeatureStegoQrChip2 => 'AES ഡീക്രിപ്ഷൻ';

  @override
  String get labelFeatureStegoQrChip3 => 'ബയോമെട്രിക് ലോക്ക്';

  @override
  String get titleFeatureWifi => 'Wi-Fi ഉടൻ കണക്റ്റ്';

  @override
  String get descFeatureWifi =>
      'WPA/WPA2/WPA3 നെറ്റ്‌വർക്ക് വിവരങ്ങൾ വായിച്ച് കാണിക്കുന്നു, പാസ്‌വേഡ് പകർത്തുന്നു, 1 ടാപ്പിൽ Wi-Fi ക്രമീകരണം തുറക്കുന്നു.';

  @override
  String get labelFeatureWifiChip1 => 'WPA3, WPA2';

  @override
  String get labelFeatureWifiChip2 => '1-ടാപ്പ് കണക്റ്റ്';

  @override
  String get labelFeatureWifiChip3 => 'പാസ്‌വേഡ് കാണുക';

  @override
  String get titleFeaturePayments => 'UPI, ക്രിപ്റ്റോ പണമിടപാട്';

  @override
  String get descFeaturePayments =>
      'ഇന്ത്യൻ UPI QR കോഡുകളും (GPay, PhonePe, Paytm എന്നിവയിലേക്ക് അയയ്ക്കുന്നു) Bitcoin/Ethereum/Solana ക്രിപ്റ്റോ വിലാസങ്ങളും തുക സഹിതം വായിക്കുന്നു.';

  @override
  String get labelFeaturePaymentsChip1 => 'UPI ആപ്പിലേക്ക്';

  @override
  String get labelFeaturePaymentsChip2 => 'ക്രിപ്റ്റോ വാലറ്റ്';

  @override
  String get labelFeaturePaymentsChip3 => 'SEPA കൈമാറ്റം';

  @override
  String get titleFeatureTotp => 'TOTP ഓതന്റിക്കേറ്റർ';

  @override
  String get descFeatureTotp =>
      '2FA സജ്ജീകരണ കോഡുകൾ സ്കാൻ ചെയ്ത്, വൃത്താകൃതിയിലുള്ള കൗണ്ട്ഡൗണോടെ തത്സമയ 6-അക്ക OTP കാണിക്കുന്നു. ഓതന്റിക്കേറ്റർ ആപ്പുകളിലേക്ക് ചേർക്കാം.';

  @override
  String get labelFeatureTotpChip1 => 'തത്സമയ കോഡ്';

  @override
  String get labelFeatureTotpChip2 => 'കൗണ്ട്ഡൗൺ';

  @override
  String get labelFeatureTotpChip3 => 'ആപ്പിലേക്ക് ചേർക്കൽ';

  @override
  String get titleFeatureContacts => 'കോൺടാക്റ്റ്, vCard ഇറക്കുമതി';

  @override
  String get descFeatureContacts =>
      'vCard 2.1/3.0/4.0, MeCard കോൺടാക്റ്റ് കോഡുകൾ വായിക്കുന്നു. 1 ടാപ്പിൽ വിളിക്കാം, ഇമെയിൽ എഴുതാം, കോൺടാക്റ്റിൽ സേവ് ചെയ്യാം.';

  @override
  String get labelFeatureContactsChip1 => 'vCard 4.0';

  @override
  String get labelFeatureContactsChip2 => '1-ടാപ്പ് സേവ്';

  @override
  String get labelFeatureContactsChip3 => 'വിളി, ഇമെയിൽ';

  @override
  String get titleFeatureCalendar => 'കലണ്ടർ ഇവന്റുകൾ';

  @override
  String get descFeatureCalendar =>
      'ആരംഭ/അവസാന സമയം, സ്ഥലം, വിവരണം എന്നിവയുള്ള iCalendar VEVENT വായിച്ച് നേരിട്ട് ഫോൺ കലണ്ടറിൽ ചേർക്കുന്നു.';

  @override
  String get labelFeatureCalendarChip1 => 'iCal വായന';

  @override
  String get labelFeatureCalendarChip2 => 'ആരംഭ/അവസാന സമയം';

  @override
  String get labelFeatureCalendarChip3 => 'കലണ്ടറിൽ ചേർക്കൽ';

  @override
  String get titleFeatureGeo => 'സ്ഥാനവും മാപ്പും';

  @override
  String get descFeatureGeo =>
      'geo: നിർദ്ദേശാങ്കങ്ങളും തിരയൽ വാക്കുകളും വായിച്ച് Google Maps വഴി ഉടൻ വഴി കാണിക്കുന്നു.';

  @override
  String get labelFeatureGeoChip1 => 'അക്ഷാംശ/രേഖാംശം';

  @override
  String get labelFeatureGeoChip2 => 'Google Maps ലിങ്ക്';

  @override
  String get labelFeatureGeoChip3 => 'തിരയൽ വാക്കുകൾ';

  @override
  String get titleFeatureScanHistory => 'ഓഫ്‌ലൈൻ സ്കാൻ നാൾവഴി';

  @override
  String get descFeatureScanHistory =>
      'ഓരോ സ്കാനും വിഭാഗം, സുരക്ഷാ സ്കോർ, സമയം, പ്രിയപ്പെട്ടവ എന്നിവയോടെ ഫോണിൽ തന്നെ സൂക്ഷിക്കുന്നു. തത്സമയ പൂർണ്ണ-ടെക്സ്റ്റ് തിരയലും.';

  @override
  String get labelFeatureScanHistoryChip1 => 'പൂർണ്ണ തിരയൽ';

  @override
  String get labelFeatureScanHistoryChip2 => 'വിഭാഗ ഫിൽട്ടർ';

  @override
  String get labelFeatureScanHistoryChip3 => 'പ്രിയപ്പെട്ടവ';

  @override
  String get titleFeatureBackups => 'JSON, CSV ബാക്കപ്പുകൾ';

  @override
  String get descFeatureBackups =>
      'മുഴുവൻ സ്കാൻ നാൾവഴിയും CSV സ്പ്രെഡ്ഷീറ്റായോ എൻക്രിപ്റ്റ് ചെയ്ത JSON ബാക്കപ്പായോ കയറ്റുമതി ചെയ്യാം. ഒറ്റ ടാപ്പിൽ പുനഃസ്ഥാപിക്കാം.';

  @override
  String get labelFeatureBackupsChip1 => 'CSV സ്പ്രെഡ്ഷീറ്റ്';

  @override
  String get labelFeatureBackupsChip2 => 'JSON ബാക്കപ്പ്';

  @override
  String get labelFeatureBackupsChip3 => '1-ടാപ്പ് വീണ്ടെടുക്കൽ';

  @override
  String get titleFeatureBiometricGuard => 'ബയോമെട്രിക്, സ്ക്രീൻ സുരക്ഷ';

  @override
  String get descFeatureBiometricGuard =>
      'വിരലടയാളം, മുഖം അല്ലെങ്കിൽ ഫോണിന്റെ സ്ക്രീൻ ലോക്ക് ഉപയോഗിച്ചുള്ള ഐച്ഛിക ആപ്പ് ലോക്ക്. സ്കാനുകൾ, നാൾവഴി, രഹസ്യങ്ങൾ, API കീകൾ എന്നിവ കാണിക്കുന്ന സ്ക്രീനുകൾ സ്ക്രീൻഷോട്ടും സ്ക്രീൻ റെക്കോർഡിംഗും തടയുന്നു (FLAG_SECURE). ക്രമീകരണങ്ങൾ › സ്വകാര്യതയും നെറ്റ്‌വർക്ക് പരിശോധനയും എന്നതിൽ ഇത് ഓഫാക്കാം. രഹസ്യ StegoQR സന്ദേശങ്ങൾക്കും ബയോമെട്രിക് പരിശോധന ആവശ്യപ്പെടാം.';

  @override
  String get labelFeatureBiometricGuardChip1 => 'ബയോമെട്രിക് ലോക്ക്';

  @override
  String get labelFeatureBiometricGuardChip2 => 'സ്ക്രീൻഷോട്ട് തടയൽ';

  @override
  String get labelFeatureBiometricGuardChip3 => 'എൻക്രിപ്റ്റഡ് സംഭരണം';

  @override
  String get titleFeatureOfflinePrivacy => '100% ഓഫ്‌ലൈൻ സ്വകാര്യത';

  @override
  String get descFeatureOfflinePrivacy =>
      'ബാർകോഡുകൾ സ്കാൻ ചെയ്യുന്നതും ഡീകോഡ് ചെയ്യുന്നതും വിശകലനം ചെയ്യുന്നതും പൂർണ്ണമായും ഫോണിൽ തന്നെ. സ്വതവേ ഒരു ഡാറ്റയും പുറത്തേക്ക് അയയ്ക്കില്ല.';

  @override
  String get labelFeatureOfflinePrivacyChip1 => 'ടെലിമെട്രി ഇല്ല';

  @override
  String get labelFeatureOfflinePrivacyChip2 => 'പരസ്യങ്ങളില്ല';

  @override
  String get labelFeatureOfflinePrivacyChip3 => 'ഓപ്പൺ സോഴ്സ്';

  @override
  String get helpCenterHeaderTitle => 'സഹായ കേന്ദ്രവും വഴികാട്ടിയും';

  @override
  String get helpCenterHeaderSubtitle =>
      'ആപ്പിന്റെ എല്ലാ സവിശേഷതകളെക്കുറിച്ചുമുള്ള സമഗ്രമായ നിർദ്ദേശങ്ങൾ വായിക്കുക.';

  @override
  String get actionDecryptPayload => 'ഡീക്രിപ്റ്റ് ചെയ്യുക';

  @override
  String get titleDecryptPayload => 'ഉള്ളടക്കം ഡീക്രിപ്റ്റ് ചെയ്യുക';

  @override
  String get descDecryptPayload => 'രഹസ്യവാക്ക് നൽകി വിവരങ്ങൾ തുറക്കുക.';

  @override
  String get labelCipherMode => 'സിഫർ മോഡ്';

  @override
  String get labelCipherModeAuto => 'ഓട്ടോ / സ്റ്റാൻഡേർഡ്';

  @override
  String get labelCipherModeAesGcm => 'AES-256-GCM (PBKDF2)';

  @override
  String get labelCipherModeAesCbc => 'AES-256-CBC';

  @override
  String get labelAirQrCode => 'സെഷൻ കോഡ് / കീ';

  @override
  String get helpAirQrCode => 'ഉദാ: ABC-DEF';

  @override
  String get titleAirQrDetected => 'എയർ ക്യുആർ കൈമാറ്റം';

  @override
  String get bodyAirQrDetected =>
      'ഇതൊരു എൻക്രിപ്റ്റ് ചെയ്ത ഒപ്റ്റിക്കൽ കൈമാറ്റമാണ്. തുറക്കുന്നതിന് അയച്ച ഉപകരണത്തിലെ സെഷൻ കോഡ് നൽകുക.';

  @override
  String get titleJsonEnvelopeDetected => 'എൻക്രിപ്റ്റ് ചെയ്ത കണ്ടെയ്നർ';

  @override
  String get bodyJsonEnvelopeDetected =>
      'ഈ കോഡിൽ എൻക്രിപ്റ്റ് ചെയ്ത വിവരങ്ങൾ അടങ്ങിയിരിക്കുന്നു. പാസ്‌വേഡ് നൽകുക.';

  @override
  String get labelDecryptedContent => 'ഡീക്രിപ്റ്റ് ചെയ്ത ഉള്ളടക്കം:';

  @override
  String get errorManualDecryptionFailed =>
      'ഡീക്രിപ്ഷൻ പരാജയപ്പെട്ടു. പാസ്‌വേഡ് ശരിയാണോ എന്ന് പരിശോധിക്കുക.';

  @override
  String get titleEmailCard => 'ഇമെയിൽ വിലാസം';

  @override
  String get actionEmailSend => 'ഇമെയിൽ അയക്കുക';

  @override
  String get actionEmailCopy => 'പകർത്തുക';

  @override
  String get errorEmailLaunchFailed =>
      'ഇമെയിൽ ആപ്പ് തുറക്കാനായില്ല. വിലാസം പകർത്തി സ്വമേധയാ തുറക്കുക.';

  @override
  String get labelEmailSubject => 'വിഷയം';

  @override
  String get labelEmailBody => 'സന്ദേശം';

  @override
  String get titlePhoneCard => 'ഫോൺ നമ്പർ';

  @override
  String get actionPhoneCall => 'വിളിക്കുക';

  @override
  String get actionPhoneCopy => 'പകർത്തുക';

  @override
  String get errorPhoneLaunchFailed =>
      'ഫോൺ ഡയലർ തുറക്കാനായില്ല. നമ്പർ പകർത്തി സ്വമേധയാ ഡയൽ ചെയ്യുക.';

  @override
  String get titleSmsCard => 'ടെക്സ്റ്റ് സന്ദേശം';

  @override
  String get actionSmsSend => 'സന്ദേശം അയക്കുക';

  @override
  String get actionSmsCopy => 'പകർത്തുക';

  @override
  String get errorSmsLaunchFailed =>
      'സന്ദേശ ആപ്പ് തുറക്കാനായില്ല. നമ്പറും സന്ദേശവും പകർത്തി സ്വമേധയാ അയക്കുക.';

  @override
  String get labelSmsBody => 'സന്ദേശം';

  @override
  String get titleAppLinkCard => 'ആപ്പ് ലിങ്ക്';

  @override
  String get actionAppLinkOpen => 'ആപ്പിൽ തുറക്കുക';

  @override
  String get errorAppLinkLaunchFailed =>
      'ഈ ആപ്പ് ലിങ്ക് തുറക്കാൻ കഴിഞ്ഞില്ല. ആപ്പ് ഇൻസ്റ്റാൾ ചെയ്തിട്ടുണ്ടോ എന്ന് പരിശോധിക്കുക.';

  @override
  String get titleProductBarcodeCard => 'ഉൽപ്പന്ന ബാർകോഡ്';

  @override
  String get actionProductSearchFood => 'ഭക്ഷണ വിവരം';

  @override
  String get actionProductSearchWeb => 'വെബിൽ തിരയുക';

  @override
  String get actionProductCopy => 'ബാർകോഡ് പകർത്തുക';

  @override
  String get errorProductLaunchFailed =>
      'ഉൽപ്പന്ന തിരച്ചിൽ തുറക്കാനായില്ല. ബാർകോഡ് പകർത്തി സ്വമേധയാ തിരയുക.';

  @override
  String get titleIsbnCard => 'പുസ്തകം (ISBN)';

  @override
  String get actionIsbnGoogleBooks => 'ഗൂഗിൾ ബുക്സ്';

  @override
  String get actionIsbnOpenLibrary => 'ഓപ്പൺ ലൈബ്രറി';

  @override
  String get actionIsbnCopy => 'ISBN പകർത്തുക';

  @override
  String get errorIsbnLaunchFailed =>
      'പുസ്തക വിവരം തുറക്കാനായില്ല. ISBN പകർത്തി സ്വമേധയാ തിരയുക.';

  @override
  String get labelHistoryFilterEmail => 'ഇമെയിൽ';

  @override
  String get labelHistoryFilterPhone => 'ഫോൺ';

  @override
  String get labelHistoryFilterSms => 'സന്ദേശം';

  @override
  String get labelHistoryFilterAppLink => 'ആപ്പ് ലിങ്ക്';

  @override
  String get labelHistoryFilterProductBarcode => 'ഉൽപ്പന്നം';

  @override
  String get labelHistoryFilterIsbn => 'പുസ്തകം';

  @override
  String get tooltipScanFlashOff => 'ഫ്ലാഷ്: ഓഫ്';

  @override
  String get tooltipScanFlashOn => 'ഫ്ലാഷ്: ഓൺ';

  @override
  String get tooltipScanFlashAuto => 'ഫ്ലാഷ്: സ്വയം';

  @override
  String bodyScanFlashAutoActive(String lux) {
    return 'ഓട്ടോ ഫ്ലാഷ് സജീവം ($lux lux)';
  }

  @override
  String get tooltipCameraTune => 'ക്യാമറ ക്രമീകരണങ്ങൾ';

  @override
  String get titleCameraTune => 'ക്യാമറ ക്രമീകരണങ്ങൾ';

  @override
  String get labelCameraBrightness => 'തെളിച്ചം';

  @override
  String get labelCameraContrast => 'കോൺട്രാസ്റ്റ്';

  @override
  String get labelCameraInvert => 'നിറങ്ങൾ വിപരീതമാക്കുക (നെഗറ്റീവ്)';

  @override
  String get descCameraInvert =>
      'കറുത്ത പശ്ചാത്തലത്തിലെ വെളുത്ത കോഡുകൾ എളുപ്പത്തിൽ സ്കാൻ ചെയ്യാൻ';

  @override
  String get labelCameraResolution => 'ക്യാമറ റെസല്യൂഷൻ';

  @override
  String get tooltipCameraResolutionFullHd => '1080p, ശുപാർശ';

  @override
  String get tooltipCameraResolutionMax => 'പരമാവധി (4K UHD)';

  @override
  String get tooltipCameraResolutionHd => '720p, ബാറ്ററി ലാഭം';

  @override
  String get actionCameraReset => 'ക്രമീകരണങ്ങൾ പുനഃക്രമീകരിക്കുക';

  @override
  String get labelSettingsLanguage => 'ഭാഷ';

  @override
  String get labelLanguageSystemDefault => 'സിസ്റ്റം സ്വതവേയുള്ളത്';

  @override
  String get labelLanguageEnglish => 'English';

  @override
  String get labelLanguageMalayalam => 'മലയാളം';

  @override
  String get labelLanguageSanskrit => 'संस्कृतम्';

  @override
  String bodyAboutCopyright(String year) {
    return '© $year Sreeraj P. എല്ലാ അവകാശങ്ങളും നിക്ഷിപ്തം.';
  }

  @override
  String get tooltipToggleFlash => 'ഫ്ലാഷ്‌ലൈറ്റ് മാറ്റുക';

  @override
  String get tooltipCameraAdjustments => 'ക്യാമറ ക്രമീകരണങ്ങൾ';

  @override
  String get tooltipZoomControls => 'വലുതാക്കൽ നിയന്ത്രണം';

  @override
  String get tooltipSwitchCamera => 'ക്യാമറ മാറ്റുക';

  @override
  String get tooltipBack => 'പിന്നോട്ട്';

  @override
  String get tooltipToggleSecretVisibility => 'രഹസ്യം കാണിക്കുക/മറയ്ക്കുക';

  @override
  String get tooltipResetStream => 'സ്ട്രീം പുനരാരംഭിക്കുക';

  @override
  String get labelAirQrModeText => 'സ്വന്തം ഉള്ളടക്കം';

  @override
  String get labelAirQrModeSync => 'ഡിവൈസ് സിങ്ക്';

  @override
  String labelAirQrSyncIncludeHistory(int count) {
    return 'നാൾവഴി ($count)';
  }

  @override
  String get labelAirQrSyncIncludeSettings =>
      'ആപ്പ് ക്രമീകരണങ്ങൾ ഉൾപ്പെടുത്തുക';

  @override
  String get labelAirQrSyncPassphrase => 'സിങ്ക് പാസ്ഫ്രെയ്സ് / പിൻ';

  @override
  String get helpAirQrSyncPassphrase => 'രഹസ്യ പിൻ നൽകുക';

  @override
  String get tooltipAirQrSyncGeneratePin => 'പിൻ നിർമ്മിക്കുക';

  @override
  String get errorAirQrSyncNoData => 'നാൾവഴിയോ ക്രമീകരണങ്ങളോ തിരഞ്ഞെടുക്കുക.';

  @override
  String get titleAirQrSyncPackage => 'എയർക്യുആർ സിങ്ക് പാക്കേജ്';

  @override
  String bodyAirQrSyncPackageSummary(int records) {
    return '$records സ്കാൻ രേഖകളും ആപ്പ് ക്രമീകരണങ്ങളും അടങ്ങിയിരിക്കുന്നു';
  }

  @override
  String get labelAirQrSyncEnterPassphrase => 'സിങ്ക് പാസ്‌ഫ്രെയ്സ്';

  @override
  String get labelAirQrSyncRestoreHistory => 'സ്കാൻ നാൾവഴി പുനഃസ്ഥാപിക്കുക';

  @override
  String get labelAirQrSyncApplySettings => 'ക്രമീകരണങ്ങൾ മാറ്റുക';

  @override
  String get actionAirQrSyncDecrypt => 'ഡീക്രിപ്റ്റ് ചെയ്തു് സിങ്ക് ചെയ്യുക';

  @override
  String bodyAirQrSyncSuccess(int count) {
    return '$count സ്കാനുകളും ക്രമീകരണങ്ങളും വിജയകരമായി സിങ്ക് ചെയ്തു!';
  }

  @override
  String get actionAirQrSyncBeam => 'എയർക്യുആർ വഴി അയക്കുക';

  @override
  String get titleAirQrSyncSettings => 'എയർക്യുആർ സിങ്ക്';

  @override
  String get descAirQrSyncSettings =>
      'നെറ്റ്‌വർക്കില്ലാതെ മറ്റൊരു ഫോണിലേക്ക് വിവരങ്ങൾ അയക്കുക';

  @override
  String get tabScan => 'സ്കാൻ';

  @override
  String get tabCodeForge => 'കോഡ്ഫോർജ്';

  @override
  String get tabHistory => 'നാൾവഴി';

  @override
  String get titleCodeForge => 'കോഡ്ഫോർജ്';

  @override
  String get labelCodeForgeSubtitle => 'ബാർകോഡ് & ക്യുആർ സ്റ്റുഡിയോ';

  @override
  String get labelCodeForgePresetText => 'ടെക്സ്റ്റ്';

  @override
  String get helpCodeForgeText =>
      'വ്യക്തവും എളുപ്പവുമായ സ്കാനിംഗിനായി ടെക്സ്റ്റ് 500 അക്ഷരങ്ങളിൽ പരിമിതപ്പെടുത്തുക';

  @override
  String get actionCodeForgeLoadFromFile => 'ഫയലിൽ നിന്ന് ചേർക്കുക';

  @override
  String get tooltipCodeForgeLoadFromFile => 'ഫയലിൽ നിന്ന് വായിക്കുക';

  @override
  String get errorCodeForgeFileEmpty => 'തിരഞ്ഞെടുത്ത ഫയൽ ശൂന്യമാണ്.';

  @override
  String get bodyCodeForgeFileTruncated =>
      'ഒറ്റ QR കോഡിൽ എളുപ്പത്തിൽ സ്കാൻ ചെയ്യുന്നതിനായി ഉള്ളടക്കം 500 അക്ഷരങ്ങളായി ചുരുക്കി.';

  @override
  String get bodyCodeForgeFileLoaded =>
      'ഫയലിൽ നിന്നുള്ള വിവരങ്ങൾ വിജയകരമായി എടുത്തു.';

  @override
  String get errorCodeForgeFileReadError =>
      'തിരഞ്ഞെടുത്ത ഫയൽ വായിക്കാൻ കഴിഞ്ഞില്ല.';

  @override
  String get labelCodeForgePresetUrl => 'ലിങ്ക്';

  @override
  String get labelCodeForgePresetWifi => 'വൈ-ഫൈ';

  @override
  String get labelCodeForgePresetContact => 'കോൺടാക്റ്റ്';

  @override
  String get labelCodeForgePresetUpi => 'യുപിഐ';

  @override
  String get labelCodeForgePresetSms => 'എസ്എംഎസ്';

  @override
  String get labelCodeForgePresetEmail => 'ഇമെയിൽ';

  @override
  String get labelCodeForgePresetGeo => 'ലൊക്കേഷൻ';

  @override
  String get labelCodeForgeWifiSsid => 'നെറ്റ്‌വർക്ക് പേര് (SSID)';

  @override
  String get labelCodeForgeWifiPassword => 'പാസ്‌വേഡ്';

  @override
  String get labelCodeForgeWifiSecurity => 'സുരക്ഷ';

  @override
  String get labelCodeForgeWifiHidden => 'മറഞ്ഞിരിക്കുന്ന നെറ്റ്‌വർക്ക്';

  @override
  String get labelCodeForgeContactName => 'പൂർണ്ണമായ പേര്';

  @override
  String get labelCodeForgeContactPhone => 'ഫോൺ നമ്പർ';

  @override
  String get labelCodeForgeContactEmail => 'ഇമെയിൽ വിലാസം';

  @override
  String get labelCodeForgeContactOrg => 'സ്ഥാപനം';

  @override
  String get labelCodeForgeUpiVpa => 'യുപിഐ ഐഡി';

  @override
  String get labelCodeForgeUpiName => 'സ്വീകർത്താവിന്റെ പേര്';

  @override
  String get labelCodeForgeUpiAmount => 'തുക (രൂപ)';

  @override
  String get labelCodeForgeUpiNote => 'കുറിപ്പ്';

  @override
  String get labelCodeForgeSmsPhone => 'ഫോൺ നമ്പർ';

  @override
  String get labelCodeForgeSmsMessage => 'സന്ദേശം';

  @override
  String get labelCodeForgeEmailTo => 'ഇമെയിൽ';

  @override
  String get labelCodeForgeEmailSubject => 'വിഷയം';

  @override
  String get labelCodeForgeEmailBody => 'സന്ദേശം';

  @override
  String get labelCodeForgeGeoLat => 'അക്ഷാംശം';

  @override
  String get labelCodeForgeGeoLng => 'രേഖാംശം';

  @override
  String get actionCodeForgeGeoUseMyLocation => 'എന്റെ ലൊക്കേഷൻ';

  @override
  String get labelCodeForgeGeoFetching => 'ലൊക്കേഷൻ കണ്ടെത്തുന്നു…';

  @override
  String get errorCodeForgeGeoFailed => 'ലൊക്കേഷൻ ലഭിച്ചില്ല';

  @override
  String get errorCodeForgeGeoPermissionDenied => 'ലൊക്കേഷൻ അനുമതി നിരസിച്ചു';

  @override
  String get titleCodeForgeDesignStudio => 'രൂപകൽപ്പന';

  @override
  String get titleCodeForgeEyeShape => 'ഐ ഡിസൈൻ';

  @override
  String get titleCodeForgeEyeBallShape => 'ഇന്നർ പ്യൂപ്പിൾ';

  @override
  String get titleCodeForgePatternShape => 'ഡോട്ട് പാറ്റേൺ';

  @override
  String get labelCodeForgeShapeSquare => 'ചതുരം';

  @override
  String get labelCodeForgeShapeDots => 'വൃത്തം';

  @override
  String get labelCodeForgeShapeRounded => 'വട്ടമുള്ളത്';

  @override
  String get labelCodeForgeShapeClassy => 'ക്ലാസി';

  @override
  String get labelCodeForgeShapeDiamond => 'ഡയമണ്ട്';

  @override
  String get labelCodeForgeShapeLeaf => 'ഇല രൂപം';

  @override
  String get labelCodeForgeShapeCircle => 'വൃത്താകൃതി';

  @override
  String get titleCodeForgeColorStudio => 'വർണ്ണങ്ങൾ';

  @override
  String get titleCodeForgeFgColor => 'മുൻനിര നിറം';

  @override
  String get titleCodeForgeBgColor => 'പശ്ചാത്തല നിറം';

  @override
  String get labelCodeForgeGradientNone => 'ഏകവർണ്ണം';

  @override
  String get labelCodeForgeGradientSunset => 'സൂര്യാസ്തമയം';

  @override
  String get labelCodeForgeGradientOcean => 'സമുദ്രം';

  @override
  String get labelCodeForgeGradientNeon => 'നിയോൺ';

  @override
  String get labelCodeForgeGradientGold => 'റോയൽ ഗോൾഡ്';

  @override
  String get titleCodeForgeErrorCorrection => 'പിശക് തിരുത്തൽ';

  @override
  String get titleCodeForgeCenterBadge => 'ചിഹ്നം';

  @override
  String get labelCodeForgeBadgeNone => 'ഒന്നുമില്ല';

  @override
  String get labelCodeForgeBadgeIcon => 'ഐക്കൺ';

  @override
  String get labelCodeForgeBadgeShield => 'പരിശോധിച്ച ഷീൽഡ്';

  @override
  String get actionCodeForgeExportPng => 'പിഎൻജി പങ്കിടുക';

  @override
  String get actionCodeForgeExportSvg => 'എസ്വിജി പങ്കിടുക';

  @override
  String get tooltipCodeForgeCopyPayload => 'പകർത്തുക';

  @override
  String get bodyCodeForgeCopied => 'ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get bodyCodeForgeSafeVerified => 'സുരക്ഷിതമായി സ്ഥിരീകരിച്ചു';

  @override
  String get tooltipCodeForgeResetStyle => 'ഡിസൈൻ മാറ്റുക';

  @override
  String get labelCodeForgeIncludeText => 'വാചകം കാണിക്കുക';

  @override
  String get titleCodeForgePreview => 'തത്സമയ പ്രിവ്യൂ';

  @override
  String get actionOnboardingSkip => 'ഒഴിവാക്കുക';

  @override
  String get actionOnboardingNext => 'അടുത്തത്';

  @override
  String get actionOnboardingGetStarted => 'സ്കാൻ ആരംഭിക്കുക';

  @override
  String get labelOnboardingSlide1Badge => '6-തല സുരക്ഷ';

  @override
  String get titleOnboardingSlide1 => '6-തല ലിങ്ക് സുരക്ഷ';

  @override
  String get bodyOnboardingSlide1 =>
      'നിങ്ങൾ തുറക്കുന്നതിന് മുമ്പ് ഓരോ ലിങ്കും ആറ് സുരക്ഷാ തലങ്ങളിലൂടെ പരിശോധിക്കപ്പെടുന്നു. ഫിഷിംഗ്, വഞ്ചനാപരമായ റീഡയറക്റ്റുകൾ, വ്യാജ ഡൊമെയ്‌നുകൾ എന്നിവയിൽ നിന്ന് ഇത് നിങ്ങളെ സംരക്ഷിക്കുന്നു.';

  @override
  String get bodyOnboardingSlide1Bullet1 =>
      'പ്രോട്ടോക്കോളും വ്യാജ ഡൊമെയ്ൻ പ്രതിരോധവും';

  @override
  String get bodyOnboardingSlide1Bullet2 =>
      'ടിഎൽഡി എൻട്രോപ്പിയും പോർട്ട് പരിശോധനയും';

  @override
  String get bodyOnboardingSlide1Bullet3 =>
      'സ്വകാര്യ പരിശോധനയും സേഫ് ബ്രൗസിംഗും';

  @override
  String get labelOnboardingSlide2Badge => 'കമ്പ്യൂട്ടർ വിഷൻ';

  @override
  String get titleOnboardingSlide2 => 'വ്യാജ സ്റ്റിക്കർ കണ്ടെത്തൽ';

  @override
  String get bodyOnboardingSlide2 =>
      'യഥാർത്ഥ കോഡുകൾക്ക് മുകളിൽ പതിപ്പിച്ച വ്യാജ ക്യുആർ സ്റ്റിക്കറുകൾ ക്വിഷിംഗ്ഗാർഡ് ക്യാമറ വഴി തിരിച്ചറിയുന്നു. വശങ്ങളിലെ വെട്ടുകളും നിഴലുകളും ഉപരിതലവും ഇത് സൂക്ഷ്മമായി പരിശോധിക്കുന്നു.';

  @override
  String get bodyOnboardingSlide2Bullet1 =>
      'വ്യാജ സ്റ്റിക്കർ പതിപ്പിക്കലുകൾ കണ്ടെത്തുന്നു';

  @override
  String get bodyOnboardingSlide2Bullet2 =>
      'മുറിച്ച അരികുകളും നിഴൽ അതിരുകളും പരിശോധിക്കുന്നു';

  @override
  String get bodyOnboardingSlide2Bullet3 => 'തത്സമയ ക്യാമറ പരിശോധന';

  @override
  String get labelOnboardingSlide3Badge => 'ട്രാക്കിംഗ് ഇല്ല';

  @override
  String get titleOnboardingSlide3 => '100% ഓഫ്‌ലൈൻ സ്വകാര്യത';

  @override
  String get bodyOnboardingSlide3 =>
      'നിങ്ങളുടെ സ്കാനുകളും വ്യക്തിഗത വിവരങ്ങളും ഫോൺ വിട്ടുപോകില്ല. അനലിറ്റിക്‌സ്, പരസ്യങ്ങൾ, ട്രാക്കറുകൾ എന്നിവ പൂർണ്ണമായും ഒഴിവാക്കിയിരിക്കുന്നു.';

  @override
  String get bodyOnboardingSlide3Bullet1 =>
      'എൻക്രിപ്റ്റ് ചെയ്ത പ്രാദേശിക ഡാറ്റാബേസ്';

  @override
  String get bodyOnboardingSlide3Bullet2 => 'എയർ ക്യുആർ ഒപ്റ്റിക്കൽ കൈമാറ്റം';

  @override
  String get bodyOnboardingSlide3Bullet3 =>
      'അനലിറ്റിക്‌സോ ട്രാക്കിംഗോ ഇല്ലാത്ത നിർമ്മിതി';

  @override
  String get labelSettingsOnboardingTour => 'ആമുഖ ടൂർ';

  @override
  String get descSettingsOnboardingTour =>
      'സുരക്ഷയും സ്വകാര്യതയും വിശദീകരിക്കുന്ന 3 സ്ലൈഡ് ആമുഖം വീണ്ടും കാണുക';

  @override
  String get tooltipBatchMode => 'തുടർച്ചയായ ബാച്ച് സ്കാനിംഗ്';

  @override
  String get bodyBatchModeEnabled => 'തുടർച്ചയായ ബാച്ച് സ്കാനിംഗ് ഓണാക്കി';

  @override
  String get bodyBatchModeDisabled => 'തുടർച്ചയായ ബാച്ച് സ്കാനിംഗ് ഓഫാക്കി';

  @override
  String labelBatchCounter(int count) {
    return '$count സ്കാൻ ചെയ്തു';
  }

  @override
  String get labelBatchReview => 'ബാച്ച് സ്കാനുകൾ';

  @override
  String get descBatchReview => 'തുടർച്ചയായ സ്കാനിംഗ് നിര';

  @override
  String get emptyBatchTitle => 'ബാച്ചിൽ കോഡുകൾ ഒന്നുമില്ല';

  @override
  String get emptyBatchBody =>
      'ക്യാമറയിൽ നിന്ന് പുറത്തുപോകാതെ തുടർച്ചയായി കോഡുകൾ സ്കാൻ ചെയ്യുക.';

  @override
  String get titleBatchExport => 'ബാച്ച് എക്സ്പോർട്ട്';

  @override
  String get actionBatchClear => 'ബാച്ച് മായ്ക്കുക';

  @override
  String get titleBatchClearConfirm => 'ബാച്ച് മായ്ക്കണമോ?';

  @override
  String get bodyBatchClearConfirm =>
      'ഈ ബാച്ചിലെ എല്ലാ സ്കാൻ ചെയ്ത കോഡുകളും നീക്കം ചെയ്യണമെന്ന് ഉറപ്പാണോ?';

  @override
  String get labelBatchPreventDuplicates => 'ഡ്യൂപ്ലിക്കേറ്റുകൾ ഒഴിവാക്കുക';

  @override
  String bodyBatchScanned(int count, String content) {
    return 'സ്കാൻ ചെയ്തു #$count: $content';
  }

  @override
  String get bodyBatchAnalyzingUrl => 'ലിങ്ക് പരിശോധിക്കുന്നു...';

  @override
  String bodyBatchUrlSafetySummary(
    int safeCount,
    int warningCount,
    int totalUrls,
  ) {
    return '$totalUrls ലിങ്കുകളിൽ $safeCount സുരക്ഷിതം, $warningCount സംശയാസ്പദം';
  }

  @override
  String get titleBatchItemDetails => 'സ്കാൻ ചെയ്ത കോഡ് വിവരങ്ങൾ';

  @override
  String get labelCameraDistanceEnhance => 'ദൂര സ്കാൻ സഹായം';

  @override
  String get descCameraDistanceEnhance =>
      'ദൂരെയുള്ള പോസ്റ്ററുകൾക്കും അടയാളങ്ങൾക്കും സൂം ക്രോപ്പും മൂർച്ച കൂട്ടലും';

  @override
  String get labelCameraUnsharp => 'അരികുകളുടെ മൂർച്ച';

  @override
  String get labelCameraDistanceZoom => 'ദൂര സൂം';

  @override
  String get tooltipScanFromClipboard => 'ക്ലിപ്പ്ബോർഡിൽ നിന്ന് സ്കാൻ ചെയ്യുക';

  @override
  String get bodyClipboardBanner => 'ക്ലിപ്പ്ബോർഡ് വിവരം കണ്ടെത്തി';

  @override
  String get actionClipboardScan => 'ഇപ്പോൾ സ്കാൻ ചെയ്യുക';

  @override
  String get tooltipClipboardDismiss => 'ഒഴിവാക്കുക';

  @override
  String get errorClipboardNoValidContent =>
      'ക്ലിപ്പ്ബോർഡിൽ സ്കാൻ ചെയ്യാൻ കഴിയുന്ന വിവരങ്ങൾ ഒന്നുമില്ല';

  @override
  String get labelClipboardTypeUrl => 'യുആർഎൽ';

  @override
  String get labelClipboardTypeBarcode => 'ബാർകോഡ് വിവരം';

  @override
  String get labelClipboardTypeImage => 'ചിത്രം';

  @override
  String get labelClipboardTypeText => 'വാചകം';

  @override
  String get bodyMultiCodeDetected =>
      'ഒന്നിലധികം കോഡുകൾ കണ്ടെത്തി. സ്കാൻ ചെയ്യാൻ കോഡിൽ തൊടുക.';

  @override
  String get tooltipMultiCodeTapToScan => 'സ്കാൻ ചെയ്യാൻ തൊടുക';

  @override
  String get labelMultiCodeSelection => 'മൾട്ടി-കോഡ് സ്കാൻ';

  @override
  String get descMultiCodeSelection =>
      'ഒന്നിലധികം കോഡുകൾ ഉണ്ടാകുമ്പോൾ അവ അടയാളപ്പെടുത്തി തെരഞ്ഞെടുക്കാൻ അനുവദിക്കുന്നു';

  @override
  String get tooltipMultiCodeDismiss => 'ഒഴിവാക്കുക';

  @override
  String get labelGhostScan => 'ഗോസ്റ്റ്സ്കാൻ';

  @override
  String get descGhostScan => 'സ്ക്രീനിലെ ക്യുആർ കോഡ് സ്കാനർ';

  @override
  String get bodyGhostScan =>
      'മറ്റ് ആപ്പുകളിലെ സ്ക്രീനിലുള്ള ക്യുആർ കോഡുകൾ സ്ക്രീൻഷോട്ട് എടുക്കാതെ തന്നെ കണ്ടെത്തുന്നു.';

  @override
  String get actionGhostScanNow => 'സ്ക്രീൻ ഇപ്പോൾ സ്കാൻ ചെയ്യുക';

  @override
  String get actionGhostScanAddTile => 'ക്വിക്ക് സെറ്റിങ്സ് ടൈൽ ചേർക്കുക';

  @override
  String get bodyGhostScanTileAdded =>
      'ക്വിക്ക് സെറ്റിങ്സ് ടൈൽ അഭ്യർത്ഥന അയച്ചു';

  @override
  String get titleGhostScanHowItWorks => 'ഗോസ്റ്റ്സ്കാൻ എങ്ങനെ ഉപയോഗിക്കാം';

  @override
  String get helpGhostScanStep1 =>
      'ഏത് ആപ്പിൽ നിന്നും നിങ്ങളുടെ ക്വിക്ക് സെറ്റിങ്സ് ഷേഡ് താഴേക്ക് വലിക്കുക.';

  @override
  String get helpGhostScanStep2 =>
      'സ്ക്രീനിലുള്ള കോഡ് സ്കാൻ ചെയ്യാൻ ഗോസ്റ്റ്സ്കാൻ ടൈലിൽ തൊടുക.';

  @override
  String get helpGhostScanStep3 =>
      'ഗാലറിയിൽ ഫോട്ടോ സൂക്ഷിക്കാതെ തന്നെ കോഡ് ഉടനടി സ്കാൻ ചെയ്യുന്നു.';

  @override
  String get bodyGhostScanAnalyzing => 'സ്ക്രീൻ ഉള്ളടക്കം പരിശോധിക്കുന്നു...';

  @override
  String get helpGuideGroupScanning => 'സ്കാനിംഗ് ഗൈഡുകൾ';

  @override
  String get helpGuideGroupSecurity => 'സുരക്ഷയും ഭീഷണി പ്രതിരോധവും';

  @override
  String get helpGuideGroupPayloads => 'ഉള്ളടക്കം, സംഭരണം, സ്വകാര്യത';

  @override
  String get titleHelpBarcode => 'ബാർകോഡ് സ്കാനിംഗ്';

  @override
  String get helpGuideBarcodeName => 'ബാർകോഡും മീഡിയയും സ്കാൻ ചെയ്യൽ';

  @override
  String get helpGuideBarcodeSummary =>
      'തത്സമയ ക്യാമറ നിയന്ത്രണങ്ങൾ, ഗാലറി ഫോട്ടോകൾ, പല പേജുള്ള PDF രേഖകളുടെ സ്കാനിംഗ്.';

  @override
  String get helpGuideBarcodeIntro =>
      'ഉയർന്ന കൃത്യതയുള്ള കമ്പ്യൂട്ടർ വിഷൻ ഉപയോഗിച്ച്, തത്സമയ ക്യാമറ, ഗാലറിയിലെ ചിത്രങ്ങൾ, പല പേജുള്ള PDF രേഖകൾ എന്നിവയിൽ നിന്ന് ഏത് 1D അല്ലെങ്കിൽ 2D ബാർകോഡും ഉടൻ സ്കാൻ ചെയ്യാം.';

  @override
  String get helpGuideBarcodeCameraTitle => 'തത്സമയ ക്യാമറ കാഴ്ച';

  @override
  String get helpGuideBarcodeCameraBullet1 =>
      'ഏത് ക്യുആർ കോഡ്, Data Matrix, Aztec, PDF417, EAN-13, UPC-A, Code 128, Codabar ചിഹ്നത്തിനു നേരെയും ക്യാമറ തിരിക്കുക.';

  @override
  String get helpGuideBarcodeCameraBullet2 =>
      'ടോർച്ചും സൂമും: കുറഞ്ഞ വെളിച്ചത്തിൽ ഫ്ലാഷ്‌ലൈറ്റ് ഐക്കണിൽ തൊടുക. അകലെയുള്ള ചെറുതും തിങ്ങിയതുമായ മൈക്രോ-ക്യുആർ കോഡുകൾ വായിക്കാൻ സൂം സ്ലൈഡർ ഉപയോഗിക്കുക.';

  @override
  String get helpGuideBarcodeCameraBullet3 =>
      'വ്യൂഫൈൻഡർ ഓവർലേകൾ: ക്രമീകരണങ്ങൾ -> രൂപഭംഗിയും തീമും എന്നതിൽ സ്കാൻ ഫ്രെയിമിന്റെ രൂപം നിങ്ങളുടെ ഇഷ്ടത്തിന് മാറ്റാം.';

  @override
  String get helpGuideBarcodeGalleryTitle =>
      'ഗാലറി ഫോട്ടോകളും ചിത്രങ്ങളും സ്കാൻ ചെയ്യൽ';

  @override
  String get helpGuideBarcodeGalleryBullet1 =>
      'ഉപകരണത്തിൽ സേവ് ചെയ്ത ഏതെങ്കിലും ചിത്രമോ സ്ക്രീൻഷോട്ടോ തിരഞ്ഞെടുക്കാൻ സ്കാനർ സ്ക്രീനിലെ ഗാലറി ഐക്കണിൽ തൊടുക.';

  @override
  String get helpGuideBarcodeGalleryBullet2 =>
      'വിപുലമായ സ്റ്റോറേജ് അനുമതി ആവശ്യപ്പെടാതെ, സ്വകാര്യത സംരക്ഷിക്കുന്ന Android ഫോട്ടോ പിക്കർ ഉപയോഗിക്കുന്നു.';

  @override
  String get helpGuideBarcodeGalleryBullet3 =>
      'പൂർണ്ണ റെസല്യൂഷനുള്ള ചിത്രം വിശകലനം ചെയ്ത്, മില്ലിസെക്കൻഡുകൾക്കുള്ളിൽ ഒന്നിലധികം ബാർകോഡുകൾ കണ്ടെത്തി വായിക്കുന്നു.';

  @override
  String get helpGuideBarcodePdfTitle => 'പല പേജുള്ള PDF സ്കാനിംഗ്';

  @override
  String get helpGuideBarcodePdfBullet1 =>
      'ഫയൽ പിക്കർ വഴി ഒരു PDF രേഖ (ഇൻവോയ്സ്, ടിക്കറ്റ്, ബോർഡിംഗ് പാസ് തുടങ്ങിയവ) നേരിട്ട് തിരഞ്ഞെടുക്കുക.';

  @override
  String get helpGuideBarcodePdfBullet2 =>
      'ഓരോ പേജും മെമ്മറിയിൽ തന്നെ തുറന്ന്, ഓരോ പേജിലും കണ്ടെത്തുന്ന എല്ലാ ബാർകോഡുകളുടെയും പട്ടിക തയ്യാറാക്കുന്നു.';

  @override
  String get helpGuideBarcodePdfBullet3 =>
      'കണ്ടെത്തിയ എല്ലാ കോഡുകളും പ്രത്യേക ബോട്ടം ഷീറ്റിൽ പരിശോധിച്ച്, ഒറ്റ ടാപ്പിൽ സ്കാൻ നാൾവഴിയിൽ സേവ് ചെയ്യാം.';

  @override
  String get helpGuideBarcodeTip =>
      'നുറുങ്ങ്: ബാർകോഡ് തിരിച്ചറിയൽ പൂർണ്ണമായും (100%) നിങ്ങളുടെ ഉപകരണത്തിൽ തന്നെ നടക്കുന്നു. ക്യാമറ ഫ്രെയിമുകളോ ചിത്രങ്ങളോ ക്ലൗഡിലേക്ക് അപ്‌ലോഡ് ചെയ്യുന്നില്ല.';

  @override
  String get titleHelpArCodeVision => 'AR കോഡ്‌വിഷൻ';

  @override
  String get helpGuideArCodeVisionName => 'AR CodeVision™ സ്പേഷ്യൽ HUD';

  @override
  String get helpGuideArCodeVisionSummary =>
      'ഒരേസമയം പല ബാർകോഡുകളും തത്സമയം പിന്തുടരൽ, ഒഴുകിനിൽക്കുന്ന ചിപ്പുകൾ, കൂട്ടമായ പ്രവർത്തനങ്ങൾ.';

  @override
  String get helpGuideArCodeVisionIntro =>
      'AR CodeVision™ നിങ്ങളുടെ ക്യാമറ കാഴ്ചയെ ഒരു ഓഗ്‌മെന്റഡ് റിയാലിറ്റി ഹെഡ്സ്-അപ് ഡിസ്‌പ്ലേ (HUD) ആക്കി മാറ്റുന്നു. ഇത് ഒന്നിലധികം ബാർകോഡുകൾ ഒരേസമയം തത്സമയം കണ്ടെത്തുകയും പിന്തുടരുകയും വിശകലനം ചെയ്യുകയും ചെയ്യുന്നു.';

  @override
  String get helpGuideArCodeVisionTrackingTitle =>
      'തത്സമയ സ്പേഷ്യൽ ട്രാക്കിംഗ്';

  @override
  String get helpGuideArCodeVisionTrackingBullet1 =>
      'ക്യാമറ ഫ്രെയിമിലുള്ള എല്ലാ ബാർകോഡുകളും ഒരേസമയം തിരിച്ചറിയുകയും ഓരോ കോഡിലും ഒരു 2D/3D ട്രാക്കിംഗ് ആങ്കർ ഉറപ്പിക്കുകയും ചെയ്യുന്നു.';

  @override
  String get helpGuideArCodeVisionTrackingBullet2 =>
      'ക്യാമറ നീക്കുമ്പോഴും, സ്ക്രീനിൽ ഓരോ ബാർകോഡിനും തൊട്ടുമുകളിൽ ഒഴുകിനിൽക്കുന്ന, തൊട്ടുപയോഗിക്കാവുന്ന ചിപ്പുകൾ കാണിക്കുന്നു.';

  @override
  String get helpGuideArCodeVisionTrackingBullet3 =>
      'ഒരു ലിങ്ക് സുരക്ഷിതമാണോ (പച്ച) ഫിഷിംഗ് സംശയമുള്ളതാണോ (ചുവപ്പ്) എന്ന്, നിറം കൊണ്ട് തിരിച്ചറിയാവുന്ന തത്സമയ സുരക്ഷാ ബാഡ്ജുകൾ ഉടൻ കാണിക്കുന്നു.';

  @override
  String get helpGuideArCodeVisionBatchTitle =>
      'ഒന്നിലധികം തിരഞ്ഞെടുക്കലും കൂട്ടമായ പ്രവർത്തനങ്ങളും';

  @override
  String get helpGuideArCodeVisionBatchBullet1 =>
      'ഏതെങ്കിലും ചിപ്പിൽ തൊട്ട് അതിലെ ഉള്ളടക്കം പരിശോധിക്കാം, അനുയോജ്യമായ പ്രവർത്തനങ്ങൾ ചെയ്യാം, അല്ലെങ്കിൽ വിശദമായ AR ആക്ഷൻ ഷീറ്റ് തുറക്കാം.';

  @override
  String get helpGuideArCodeVisionBatchBullet2 =>
      'ഗോഡൗൺ ഷെൽഫുകൾ, ഉൽപ്പന്ന കാറ്റലോഗുകൾ, ഇവന്റ് ബാഡ്ജുകൾ എന്നിവയിലെ പല കോഡുകളും ഒന്നിച്ച് തിരഞ്ഞെടുത്ത് കൂട്ടമായി കൈകാര്യം ചെയ്യാം.';

  @override
  String get helpGuideArCodeVisionBatchBullet3 =>
      'തിരഞ്ഞെടുത്ത എല്ലാ ഉള്ളടക്കവും ഒറ്റ ടാപ്പിൽ പകർത്താം, അല്ലെങ്കിൽ നാൾവഴിയിലേക്ക് മാറ്റാം.';

  @override
  String get helpGuideArCodeVisionHudTitle => 'HUD നിയന്ത്രണങ്ങളും പ്രകടനവും';

  @override
  String get helpGuideArCodeVisionHudBullet1 =>
      'HUD ആക്ഷൻ സ്ട്രിപ്പ്: ക്യാമറ ഫ്ലാഷ്, സൂം നില, മുൻ/പിൻ ക്യാമറ മാറ്റം, ലക്ഷ്യങ്ങൾ മായ്ക്കൽ എന്നിവയ്ക്കുള്ള ദ്രുത ബട്ടണുകൾ.';

  @override
  String get helpGuideArCodeVisionHudBullet2 =>
      'ഫ്രെയിം നിരക്ക് കാര്യക്ഷമമായി കൈകാര്യം ചെയ്യുന്നതിനാൽ ദീർഘനേരം സ്കാൻ ചെയ്യുമ്പോഴും ഫോൺ അമിതമായി ചൂടാകുന്നില്ല, ബാറ്ററിയും ലാഭിക്കുന്നു.';

  @override
  String get helpGuideArCodeVisionTip =>
      'നുറുങ്ങ്: ഡസൻ കണക്കിന് ബാർകോഡുകൾ തിങ്ങിനിറഞ്ഞ സ്ഥലങ്ങളിൽ, വേണ്ട കോഡുകൾ മാത്രം കൃത്യമായി വേർതിരിക്കാൻ സൂം സ്ലൈഡർ ഉപയോഗിക്കുക.';

  @override
  String get titleHelpAirQr => 'എയർ ക്യുആർ സഹായി';

  @override
  String get helpGuideAirQrName => 'AirQR™ ഒപ്റ്റിക്കൽ എയർ-ഗ്യാപ് സ്ട്രീം';

  @override
  String get helpGuideAirQrSummary =>
      'റേഡിയോ സിഗ്നൽ ഇല്ലാതെ, ചലിക്കുന്ന ക്യുആർ കോഡുകൾ വഴി ഓഫ്‌ലൈനായി ഡാറ്റ അയയ്ക്കാനും സ്വീകരിക്കാനും.';

  @override
  String get helpGuideAirQrIntro =>
      'Wi-Fi, ബ്ലൂടൂത്ത്, മൊബൈൽ ഡാറ്റ, കേബിൾ എന്നിവയൊന്നും ഇല്ലാതെ, അതിവേഗം മാറുന്ന ചലിക്കുന്ന ക്യുആർ ഫ്രെയിമുകൾ ഉപയോഗിച്ച് AirQR™ രണ്ട് ഉപകരണങ്ങൾക്കിടയിൽ പൂർണ്ണമായും ഓഫ്‌ലൈനായ ഒരു ഒപ്റ്റിക്കൽ ഡാറ്റാ പാത ഒരുക്കുന്നു. ഇരു ദിശകളിലേക്കും ഡാറ്റ കൈമാറാം.';

  @override
  String get helpGuideAirQrStreamingTitle =>
      'ഒപ്റ്റിക്കൽ സ്ട്രീമിംഗ് എങ്ങനെ പ്രവർത്തിക്കുന്നു';

  @override
  String get helpGuideAirQrStreamingBullet1 =>
      'വലിയ ഫയലുകൾ, ക്രിപ്റ്റോഗ്രാഫിക് കീകൾ, നീണ്ട രേഖകൾ എന്നിവ ചെറിയ ഡാറ്റാ ഫ്രെയിമുകളായി വിഭജിക്കുന്നു. ഒപ്പം, നഷ്ടപ്പെട്ട ഫ്രെയിമുകൾ സ്വീകരിക്കുന്ന ഉപകരണത്തിന് വീണ്ടും നിർമ്മിക്കാൻ സഹായിക്കുന്ന ഫൗണ്ടൻ-കോഡ് റിപ്പയർ ഫ്രെയിമുകളും അധികമായി ചേർക്കുന്നു.';

  @override
  String get helpGuideAirQrStreamingBullet2 =>
      'അയയ്ക്കുന്ന ഉപകരണം ചലിക്കുന്ന ക്യുആർ കോഡ് സ്ട്രീം നിങ്ങൾക്ക് ക്രമീകരിക്കാവുന്ന ഫ്രെയിം നിരക്കിൽ (5 മുതൽ 25 FPS വരെ) മിന്നിക്കുന്നു.';

  @override
  String get helpGuideAirQrStreamingBullet3 =>
      'സ്വീകരിക്കുന്ന ഉപകരണം ഫ്രെയിമുകൾ തുടർച്ചയായി പകർത്തുന്നു. മുഴുവൻ ഡാറ്റയും വീണ്ടും ഒന്നിച്ചു ചേരുന്നതുവരെ നഷ്ടപ്പെട്ട ഫ്രെയിമുകൾ അപ്പപ്പോൾ പുനർനിർമ്മിക്കുന്നു.';

  @override
  String get helpGuideAirQrSecurityTitle => 'എയർ-ഗ്യാപ് സുരക്ഷയും സ്വകാര്യതയും';

  @override
  String get helpGuideAirQrSecurityBullet1 =>
      'പൂർണ്ണ റേഡിയോ നിശ്ശബ്ദത: റേഡിയോ തരംഗങ്ങൾ ഒട്ടും പുറപ്പെടുവിക്കുന്നില്ല (RF പ്രക്ഷേപണമോ പെയറിംഗ് അഭ്യർത്ഥനകളോ നെറ്റ്‌വർക്ക് ലോഗുകളോ ഇല്ല).';

  @override
  String get helpGuideAirQrSecurityBullet2 =>
      'ദൂരെനിന്നുള്ള നെറ്റ്‌വർക്ക് ചോർത്തൽ, മാൻ-ഇൻ-ദ-മിഡിൽ ആക്രമണങ്ങൾ, ബ്ലൂടൂത്ത് വഴിയുള്ള ചോർത്തൽ എന്നിവയൊന്നും ഇതിനെ ബാധിക്കില്ല.';

  @override
  String get helpGuideAirQrSecurityBullet3 =>
      'എയർ-ഗ്യാപ് ചെയ്ത ക്രിപ്റ്റോകറൻസി കോൾഡ് വാലറ്റുകൾ, രഹസ്യ ലോഗിൻ വിവരങ്ങൾ, സുരക്ഷിതമായ ഓഫ്‌ലൈൻ ഡാറ്റ കൈമാറ്റം എന്നിവയ്ക്ക് ഏറ്റവും അനുയോജ്യം.';

  @override
  String get helpGuideAirQrControlsTitle =>
      'ട്രാൻസ്മിറ്റർ, റിസീവർ നിയന്ത്രണങ്ങൾ';

  @override
  String get helpGuideAirQrControlsBullet1 =>
      'ട്രാൻസ്മിറ്റർ സ്ക്രീൻ: ഫ്രെയിം നിരക്ക് (FPS) തിരഞ്ഞെടുക്കാം, സ്ട്രീമിലെ ആകെ ഫ്രെയിമുകളുടെ എണ്ണം കാണാം.';

  @override
  String get helpGuideAirQrControlsBullet2 =>
      'റിസീവർ സ്ക്രീൻ: തത്സമയ പുരോഗതി ബാർ, ലഭിച്ച ഫ്രെയിമുകളുടെ എണ്ണം, കിട്ടാത്ത ഫ്രെയിമുകളുടെ നമ്പറുകൾ, ചെക്ക്‌സം പരിശോധന.';

  @override
  String get helpGuideAirQrTip =>
      'നുറുങ്ങ്: AirQR സ്ട്രീം സ്വീകരിക്കുമ്പോൾ ഫോൺ അനങ്ങാതെ പിടിക്കുക. ഫ്രെയിമുകൾ ഏറ്റവും വേഗത്തിൽ പകർത്താൻ, അയയ്ക്കുന്ന ഫോണിന്റെ സ്ക്രീൻ തെളിച്ചം കൂട്ടി വയ്ക്കുക.';

  @override
  String get titleHelpUrlSafety => 'URL സുരക്ഷ';

  @override
  String get helpGuideUrlSafetyName => '6-ലെയർ URL സുരക്ഷാ സംവിധാനം';

  @override
  String get helpGuideUrlSafetySummary =>
      'ഹോമോഗ്രാഫ് ആക്രമണങ്ങൾ, പ്യൂണികോഡ് പ്രതിരോധം, സംശയാസ്പദമായ TLD-കൾ, പോർട്ട് കെണികൾ.';

  @override
  String get helpGuideUrlSafetyIntro =>
      'സ്കാൻ ചെയ്ത ഏതെങ്കിലും വെബ് ലിങ്ക് തുറക്കുന്നതിനു മുമ്പ്, ഞങ്ങളുടെ 6-ലെയർ സുരക്ഷാ സംവിധാനം ആധുനിക ഫിഷിംഗ് രീതികൾ, ഹോമോഗ്രാഫ് കബളിപ്പിക്കൽ ആക്രമണങ്ങൾ, അപകടകരമായ റീഡയറക്ട് കെണികൾ എന്നിവയ്ക്കെതിരെ URL പരിശോധിക്കുന്നു.';

  @override
  String get helpGuideUrlSafetyLayersTitle => '6 സുരക്ഷാ ലെയറുകൾ വിശദമായി';

  @override
  String get helpGuideUrlSafetyLayersBullet1 =>
      'ലെയർ 1: പ്രോട്ടോക്കോൾ, സ്കീം സംരക്ഷണം - HTTPS എൻക്രിപ്ഷൻ ഉറപ്പാക്കുന്നു, പ്രോട്ടോക്കോൾ ഘടന ശരിയാണോ എന്ന് പരിശോധിക്കുന്നു, തെറ്റായ രൂപത്തിലുള്ളതോ കാണാനാവാത്ത (zero-width) അക്ഷരങ്ങളുള്ളതോ ആയ കെണികൾ തടയുന്നു.';

  @override
  String get helpGuideUrlSafetyLayersBullet2 =>
      'ലെയർ 2: ഹോമോഗ്രാഫ്, യൂണികോഡ് ആക്രമണ കവചം - വിശ്വസനീയ വെബ്സൈറ്റുകളെ അനുകരിക്കാൻ തട്ടിപ്പുകാർ ഉപയോഗിക്കുന്ന സിറിലിക്, ഗ്രീക്ക്, കലർന്ന ലിപികളിലെ ഒരുപോലെ തോന്നുന്ന അക്ഷരങ്ങൾ (\"a\"-ക്കു പകരം \"а\" പോലുള്ളവ) തിരിച്ചറിയുന്നു.';

  @override
  String get helpGuideUrlSafetyLayersBullet3 =>
      'ലെയർ 3: സംശയാസ്പദ TLD, എൻട്രോപ്പി വിശകലനം - അപകടസാധ്യത കൂടിയ ഡൊമെയ്ൻ അവസാനങ്ങൾ (.xyz, .top, .work), അമിതമായ സബ്ഡൊമെയ്ൻ അടുക്കുകൾ, യന്ത്രം ക്രമരഹിതമായി ഉണ്ടാക്കിയ ഡൊമെയ്ൻ പേരുകൾ എന്നിവ ചൂണ്ടിക്കാട്ടുന്നു.';

  @override
  String get helpGuideUrlSafetyLayersBullet4 =>
      'ലെയർ 4: IP, അസാധാരണ പോർട്ട് കെണി - ബോട്ട്‌നെറ്റ് മാൽവെയർ സെർവറുകൾ പലപ്പോഴും ഉപയോഗിക്കുന്ന, സംഖ്യാ IP വിലാസങ്ങളിലേക്കോ അസാധാരണ പോർട്ട് നമ്പറുകളിലേക്കോ നേരിട്ട് ബന്ധിപ്പിക്കുന്ന ലിങ്കുകൾ കണ്ടെത്തുന്നു.';

  @override
  String get helpGuideUrlSafetyLayersBullet5 =>
      'ലെയർ 5: സ്വകാര്യത സംരക്ഷിക്കുന്ന ഓൺലൈൻ HEAD പരിശോധന - വേണമെങ്കിൽ, ചുരുക്കിയ URL-കളുടെ റീഡയറക്ടുകൾ (bit.ly, tinyurl) പിന്തുടരുകയും, അപകടകരമായ JavaScript പ്രവർത്തിപ്പിക്കാതെ SSL സർട്ടിഫിക്കറ്റ് വിശ്വാസ ശൃംഖല പരിശോധിക്കുകയും ചെയ്യുന്നു.';

  @override
  String get helpGuideUrlSafetyLayersBullet6 =>
      'ലെയർ 6: Google Safe Browsing API സംയോജനം - ഫിഷിംഗ് സൈറ്റുകളിൽ നിന്നും മാൽവെയർ വിതരണ ശൃംഖലകളിൽ നിന്നും സംരക്ഷിക്കുന്ന, ഐച്ഛികമായ ക്ലൗഡ് അധിഷ്ഠിത തത്സമയ ഭീഷണി വിവരങ്ങൾ.';

  @override
  String get helpGuideUrlSafetyVerdictsTitle =>
      'സുരക്ഷാ വിധികളും നിർദ്ദേശങ്ങളും';

  @override
  String get helpGuideUrlSafetyVerdictsBullet1 =>
      'സുരക്ഷിതം എന്ന് ഉറപ്പാക്കി (പച്ച): സംശയകരമായ ഒരു സൂചനയും ഇല്ലാതെ URL എല്ലാ ഘടനാ, ഭീഷണി പരിശോധനകളും വിജയിച്ചു.';

  @override
  String get helpGuideUrlSafetyVerdictsBullet2 =>
      'ജാഗ്രത / മുന്നറിയിപ്പ് (ഓറഞ്ച്/ചുവപ്പ്): ഉയർന്ന അപകടസാധ്യത കണ്ടെത്തി. ചുരുക്കാത്ത മുഴുവൻ ലക്ഷ്യസ്ഥാനവും ആപ്പ് കാണിക്കുന്നു, ഏതൊക്കെ നിയമങ്ങളാണ് മുന്നറിയിപ്പിന് കാരണമായതെന്ന് കൃത്യമായി എടുത്തുകാണിക്കുന്നു.';

  @override
  String get helpGuideUrlSafetyTip =>
      'നുറുങ്ങ്: ലെയർ 1 മുതൽ 4 വരെ ഉപകരണത്തിൽ തന്നെയുള്ള പരിശോധനകളിലൂടെ പൂർണ്ണമായും ഓഫ്‌ലൈനായി പ്രവർത്തിക്കുന്നു. നിങ്ങൾ എവിടെയായിരുന്നാലും സ്വകാര്യത സംരക്ഷിക്കപ്പെടുന്നു.';

  @override
  String get titleHelpQuishing => 'ക്വിഷിംഗ് ഗാർഡ്';

  @override
  String get helpGuideQuishingName => 'QuishingGuard™ കൃത്രിമം കണ്ടെത്തൽ';

  @override
  String get helpGuideQuishingSummary =>
      'യഥാർത്ഥ കോഡിനു മുകളിൽ ഒട്ടിച്ച ക്യുആർ സ്റ്റിക്കറുകളും അരികിലെ മുറിവുകളും ഫോണിൽ തന്നെ കമ്പ്യൂട്ടർ വിഷൻ വഴി പരിശോധിക്കുന്നു.';

  @override
  String get helpGuideQuishingIntro =>
      'പാർക്കിംഗ് മീറ്ററുകൾ, റെസ്റ്റോറന്റ് മെനുകൾ, പണമടയ്ക്കുന്ന കൗണ്ടറുകൾ, യാത്രാ ബോർഡുകൾ എന്നിവയിലെ യഥാർത്ഥ ക്യുആർ കോഡുകൾക്കു മുകളിൽ തട്ടിപ്പുകാർ വ്യാജ ക്യുആർ സ്റ്റിക്കറുകൾ ഒട്ടിക്കുന്നതാണ് ക്വിഷിംഗ് (ക്യുആർ ഫിഷിംഗ്).';

  @override
  String get helpGuideQuishingCvTitle => 'ഉപകരണത്തിലെ കമ്പ്യൂട്ടർ വിഷൻ വിശകലനം';

  @override
  String get helpGuideQuishingCvBullet1 =>
      'അരിക് തുടർച്ചയില്ലായ്മ അളവ്: ഒട്ടിച്ച സ്റ്റിക്കറുകളുടെ അതിരുകളിലെ ഇരട്ട അരികുകൾ, ചരിഞ്ഞ മുറിവുകൾ, ചെറിയ നിഴലുകൾ എന്നിവ കണ്ടെത്തുന്നു.';

  @override
  String get helpGuideQuishingCvBullet2 =>
      'പ്രിന്റ് ഗ്രെയിൻ, ഹാഫ്‌ടോൺ അളവ്: കോഡും ചുറ്റുമുള്ള പോസ്റ്ററും തമ്മിൽ ഡോട്ട് അകലം, നിറത്തിലെ നോയ്സ്, പ്രിന്റ് റെസല്യൂഷൻ എന്നിവയിലെ പൊരുത്തക്കേടുകൾ കണ്ടെത്തുന്നു.';

  @override
  String get helpGuideQuishingCvBullet3 =>
      '0% (യഥാർത്ഥം) മുതൽ 100% (ഉയർന്ന കൃത്രിമ സാധ്യത) വരെയുള്ള ഒരു സംയുക്ത കൃത്രിമ സാധ്യതാ സ്കോർ കണക്കാക്കുന്നു.';

  @override
  String get helpGuideQuishingForensicTitle => 'ഫോറൻസിക് സൂചനാ പരിശോധന';

  @override
  String get helpGuideQuishingForensicBullet1 =>
      'തത്സമയ CV വിശ്വാസ്യതാ നിലകൾ, അതിർ-അരിക് അളവുകൾ, നിറ നോയ്സ് ചാർട്ടുകൾ എന്നിവ കാണാൻ, സ്കാൻ ചെയ്ത ഏത് കോഡിലും \"ഫോറൻസിക് വിശകലനം കാണുക\" എന്നതിൽ തൊടുക.';

  @override
  String get helpGuideQuishingForensicBullet2 =>
      'പണം അയയ്ക്കുന്നതിനോ ലോഗിൻ വിവരങ്ങൾ നൽകുന്നതിനോ മുമ്പ്, പൊതുസ്ഥലങ്ങളിലെ സംശയാസ്പദമായ പേയ്‌മെന്റ് ക്യുആർ കോഡുകൾ തിരിച്ചറിയാൻ സഹായിക്കുന്നു.';

  @override
  String get helpGuideQuishingTip =>
      'നുറുങ്ങ്: പാർക്കിംഗ് മീറ്ററുകളിലോ പൊതു കിയോസ്കുകളിലോ ഉള്ള ക്യുആർ കോഡുകൾ സ്കാൻ ചെയ്യുമ്പോൾ QuishingGuard അരിക് മുന്നറിയിപ്പ് നൽകിയാൽ, കോഡ് വിരലുകൾ കൊണ്ട് തൊട്ടുനോക്കി പരിശോധിക്കുക.';

  @override
  String get titleHelpSafeBrowsing => 'സേഫ് ബ്രൗസിംഗ്';

  @override
  String get helpGuideSafeBrowsingName => 'Google Safe Browsing സജ്ജീകരണം';

  @override
  String get helpGuideSafeBrowsingSummary =>
      'Google Cloud API കീ നേടൽ, ഹാർഡ്‌വെയർ കീസ്റ്റോർ സംഭരണം, പരിശോധനാ പരിധികൾ.';

  @override
  String get helpGuideSafeBrowsingIntro =>
      'Google Safe Browsing ലെയർ 6 ക്ലൗഡ് ഭീഷണി വിവരങ്ങൾ ഓണാക്കുന്നു. സ്കാൻ ചെയ്ത URL-കൾ, നിരന്തരം പുതുക്കുന്ന കോടിക്കണക്കിന് മാൽവെയർ, സോഷ്യൽ എഞ്ചിനീയറിംഗ്, ഫിഷിംഗ് ഭീഷണി വിവരങ്ങളുമായി ഒത്തുനോക്കുന്നു.';

  @override
  String get helpGuideSafeBrowsingKeyTitle => 'സൗജന്യ API കീ എങ്ങനെ നേടാം';

  @override
  String get helpGuideSafeBrowsingKeyStep1 =>
      '1. കമ്പ്യൂട്ടറിലോ മൊബൈൽ ബ്രൗസറിലോ Google Cloud Console (console.cloud.google.com) തുറക്കുക.';

  @override
  String get helpGuideSafeBrowsingKeyStep2 =>
      '2. ഒരു പുതിയ Google Cloud Project ഉണ്ടാക്കുക (ഉദാ: \"My QR Reader Security\").';

  @override
  String get helpGuideSafeBrowsingKeyStep3 =>
      '3. \"APIs & Services\" -> \"Library\" എന്നതിലേക്ക് പോയി \"Web Risk API\" അല്ലെങ്കിൽ \"Safe Browsing API\" തിരഞ്ഞ് \"Enable\" ക്ലിക്ക് ചെയ്യുക.';

  @override
  String get helpGuideSafeBrowsingKeyStep4 =>
      '4. \"APIs & Services\" -> \"Credentials\" എന്നതിൽ പോയി \"+ CREATE CREDENTIALS\" -> \"API key\" ക്ലിക്ക് ചെയ്യുക.';

  @override
  String get helpGuideSafeBrowsingKeyStep5 =>
      '5. പുതിയ API കീ പകർത്തി, ക്രമീകരണങ്ങളിലെ Google Safe Browsing ഫീൽഡിൽ ഒട്ടിക്കുക.';

  @override
  String get helpGuideSafeBrowsingPrivacyTitle =>
      'സ്വകാര്യതയും സുരക്ഷിത കീസ്റ്റോർ സംഭരണവും';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet1 =>
      'നിങ്ങളുടെ API കീ Android Keystore ഹാർഡ്‌വെയർ പിന്തുണയുള്ള സുരക്ഷിത സംഭരണിയിൽ (FlutterSecureStorage) എൻക്രിപ്റ്റ് ചെയ്ത് സൂക്ഷിക്കുന്നു. അത് ഒരിക്കലും പുറത്തേക്ക് എക്സ്പോർട്ട് ചെയ്യുകയോ പങ്കിടുകയോ ഇല്ല.';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet2 =>
      'Google Safe Browsing പൂർണ്ണമായും ഐച്ഛികമാണ്. കീ നൽകിയില്ലെങ്കിലും ആപ്പ് വിശദമായ ഓഫ്‌ലൈൻ പരിശോധനകൾ തുടർന്നും നടത്തും.';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet3 =>
      'സൗജന്യ പരിധി: Google ദിവസം 10,000 സൗജന്യ അഭ്യർത്ഥനകൾ വരെ അനുവദിക്കുന്നു. ആപ്പ് അതിന്റെ ഉപയോഗ കൗണ്ടർ ഓരോ 24 മണിക്കൂറിലും പുനഃസജ്ജമാക്കുന്നു.';

  @override
  String get helpGuideSafeBrowsingTip =>
      'നുറുങ്ങ്: ഓഫ്‌ലൈൻ പരിശോധനകൾ വിജയിച്ചതിനു ശേഷം മാത്രമേ Safe Browsing പരിശോധന നടക്കൂ. അതുവഴി ദിവസേനയുള്ള പരിശോധനാ പരിധി ലാഭിക്കാം.';

  @override
  String get titleHelpSmartPayloads => 'സ്മാർട്ട് പ്രവർത്തനങ്ങൾ';

  @override
  String get helpGuideSmartPayloadsName =>
      'സ്മാർട്ട് പ്രവർത്തനങ്ങളും പേയ്‌മെന്റുകളും';

  @override
  String get helpGuideSmartPayloadsSummary =>
      'Wi-Fi കണക്ഷൻ, UPI, ക്രിപ്റ്റോ പേയ്‌മെന്റുകൾ, തത്സമയ TOTP 2FA ടോക്കണുകൾ, vCard-കൾ, ഇവന്റുകൾ.';

  @override
  String get helpGuideSmartPayloadsIntro =>
      'ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ ഓരോ ബാർകോഡിന്റെയും തരം സ്വയം തിരിച്ചറിയുന്നു. Wi-Fi ശൃംഖലകൾ, UPI, ക്രിപ്റ്റോ പേയ്‌മെന്റുകൾ, 2FA ടോക്കണുകൾ, കോൺടാക്റ്റുകൾ, കലണ്ടർ ഇവന്റുകൾ എന്നിവയ്ക്ക് ഒറ്റ ടാപ്പിൽ ഉപയോഗിക്കാവുന്ന കാർഡുകൾ കാണിക്കുന്നു.';

  @override
  String get helpGuideSmartPayloadsWifiTitle =>
      'Wi-Fi ശൃംഖലയിലേക്ക് സ്വയം ബന്ധിപ്പിക്കൽ';

  @override
  String get helpGuideSmartPayloadsWifiBullet1 =>
      'SSID, എൻക്രിപ്ഷൻ തരം (WPA, WPA2, WPA3, WEP, ഒന്നുമില്ല), നെറ്റ്‌വർക്ക് പാസ്‌വേഡ് എന്നിവ അടങ്ങിയ WIFI: ഫോർമാറ്റിലുള്ള ബാർകോഡുകൾ സ്കാൻ ചെയ്യുന്നു.';

  @override
  String get helpGuideSmartPayloadsWifiBullet2 =>
      'പാസ്‌വേഡ് കാണിക്കാനും മറയ്ക്കാനുമുള്ള ബട്ടണും ഒറ്റ ടാപ്പിൽ ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്താനുള്ള സൗകര്യവും ഉണ്ട്.';

  @override
  String get helpGuideSmartPayloadsWifiBullet3 =>
      'നേരിട്ട് ബന്ധിപ്പിക്കാനോ സിസ്റ്റം Wi-Fi ക്രമീകരണങ്ങൾ തുറക്കാനോ \"വൈ-ഫൈയിലേക്ക് ബന്ധിപ്പിക്കുക\" എന്നതിൽ തൊടുക.';

  @override
  String get helpGuideSmartPayloadsPaymentsTitle =>
      'UPI, ക്രിപ്റ്റോകറൻസി പേയ്‌മെന്റുകൾ';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet1 =>
      'ഇന്ത്യൻ UPI ക്യുആർ കോഡുകൾ: വെർച്വൽ പേയ്‌മെന്റ് വിലാസം (VPA), വ്യാപാരിയുടെ പേര്, ഇടപാട് റഫറൻസ്, കൃത്യമായ തുക എന്നിവ വേർതിരിച്ചെടുക്കുന്നു.';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet2 =>
      'ഒറ്റ ടാപ്പ് അയയ്ക്കൽ: ഇടപാട് വിവരങ്ങൾ മുൻകൂട്ടി പൂരിപ്പിച്ച്, ഫോണിലുള്ള പേയ്‌മെന്റ് ആപ്പുകൾ (Google Pay, PhonePe, Paytm, BHIM) തുറക്കുന്നു.';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet3 =>
      'ക്രിപ്റ്റോ ക്യുആർ കോഡുകൾ: Bitcoin, Ethereum, Solana വാലറ്റ് വിലാസങ്ങൾ തിരിച്ചറിയുന്നു; ഒറ്റ ടാപ്പിൽ പകർത്താം, വിലാസം വ്യക്തമായി ക്രമീകരിച്ച് കാണിക്കുന്നു.';

  @override
  String get helpGuideSmartPayloadsTotpTitle =>
      'TOTP 2FA ഓതന്റിക്കേറ്ററും ടോക്കണുകളും';

  @override
  String get helpGuideSmartPayloadsTotpBullet1 =>
      'Google Authenticator, Microsoft Authenticator എന്നിവ ഉപയോഗിക്കുന്ന otpauth:// മാനദണ്ഡത്തിലുള്ള ടു-ഫാക്ടർ ഓതന്റിക്കേഷൻ സജ്ജീകരണ കോഡുകൾ സ്കാൻ ചെയ്യുന്നു.';

  @override
  String get helpGuideSmartPayloadsTotpBullet2 =>
      '30 സെക്കൻഡ് എണ്ണിക്കുറയ്ക്കുന്ന വൃത്താകൃതിയിലുള്ള ടൈമറിനൊപ്പം, മാറിക്കൊണ്ടിരിക്കുന്ന 6 അക്ക ഒറ്റത്തവണ പാസ്‌കോഡ് ഉപകരണത്തിൽ തത്സമയം കാണിക്കുന്നു.';

  @override
  String get helpGuideSmartPayloadsTotpBullet3 =>
      'നിങ്ങൾക്കിഷ്ടമുള്ള 2FA ആപ്പിൽ കീ ചേർക്കാൻ \"ഓതന്റിക്കേറ്ററിലേക്ക് ചേർക്കുക\" എന്നതിൽ തൊടുക.';

  @override
  String get helpGuideSmartPayloadsContactsTitle =>
      'കോൺടാക്റ്റുകളും കലണ്ടർ ഇവന്റുകളും';

  @override
  String get helpGuideSmartPayloadsContactsBullet1 =>
      'vCard, MeCard: മുഴുവൻ പേര്, ഫോൺ നമ്പറുകൾ, ഇമെയിൽ വിലാസങ്ങൾ, സ്ഥാപനം, ജോലിപ്പേര് എന്നിവ വേർതിരിച്ചെടുത്ത്, ഒറ്റ ടാപ്പിൽ കോൺടാക്റ്റുകളിലേക്ക് ചേർക്കാം.';

  @override
  String get helpGuideSmartPayloadsContactsBullet2 =>
      'iCalendar (VEVENT): ഇവന്റിന്റെ പേര്, ആരംഭ-അവസാന തീയതിയും സമയവും, സ്ഥലം, വിവരണം എന്നിവ വേർതിരിച്ചെടുത്ത്, ഒറ്റ ടാപ്പിൽ Google/ഉപകരണ കലണ്ടറിൽ ചേർക്കാൻ സൗകര്യമൊരുക്കുന്നു.';

  @override
  String get helpGuideSmartPayloadsTip =>
      'നുറുങ്ങ്: UPI ക്യുആർ കോഡ് വഴി പണമടയ്ക്കുമ്പോൾ, കാർഡിൽ കാണിക്കുന്ന വ്യാപാരിയുടെ പേര് കടയിലെ പേരുമായി ഒത്തുപോകുന്നുണ്ടെന്ന് എപ്പോഴും ഉറപ്പാക്കുക.';

  @override
  String get titleHelpHistory => 'നാൾവഴിയും സ്വകാര്യതയും';

  @override
  String get helpGuideHistoryName => 'നാൾവഴി, ബാക്കപ്പ്, സ്വകാര്യത';

  @override
  String get helpGuideHistorySummary =>
      'ഓഫ്‌ലൈൻ SQLite ഡാറ്റാബേസ്, JSON/CSV ബാക്കപ്പുകൾ, ബയോമെട്രിക്സ്, സ്ക്രീൻഷോട്ട് സംരക്ഷണം.';

  @override
  String get helpGuideHistoryIntro =>
      'നിങ്ങളുടെ സ്കാൻ രേഖകൾ നിങ്ങളുടേത് മാത്രമാണ്. ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോ എല്ലാ നാൾവഴി വിവരങ്ങളും നിങ്ങളുടെ ഉപകരണത്തിലെ ഒരു ലോക്കൽ SQLite ഡാറ്റാബേസിൽ സൂക്ഷിക്കുന്നു. ബയോമെട്രിക് സംരക്ഷണവും ക്രമീകൃത എക്സ്പോർട്ട് ഫോർമാറ്റുകളും ഇതിനൊപ്പമുണ്ട്.';

  @override
  String get helpGuideHistoryManageTitle => 'സ്കാൻ നാൾവഴി കൈകാര്യം ചെയ്യൽ';

  @override
  String get helpGuideHistoryManageBullet1 =>
      'തിരയലും ഫിൽട്ടറും: വാക്കുകൾ ഉപയോഗിച്ച് സ്കാൻ നാൾവഴി തത്സമയം തിരയാം, അല്ലെങ്കിൽ ഉള്ളടക്ക തരം (URL, Wi-Fi, കോൺടാക്റ്റുകൾ, പേയ്‌മെന്റുകൾ, TOTP) അനുസരിച്ച് ഫിൽട്ടർ ചെയ്യാം.';

  @override
  String get helpGuideHistoryManageBullet2 =>
      'പ്രിയപ്പെട്ടവ: പ്രധാനപ്പെട്ട Wi-Fi വിവരങ്ങളോ ലോയൽറ്റി കോഡുകളോ വേഗം തുറക്കാൻ പ്രിയപ്പെട്ടവയായി അടയാളപ്പെടുത്താം.';

  @override
  String get helpGuideHistoryManageBullet3 =>
      'വിശദ പരിശോധനാ ഷീറ്റ്: ഡീകോഡ് ചെയ്ത യഥാർത്ഥ ഡാറ്റ, സുരക്ഷാ സ്കോറിന്റെ വിശദാംശങ്ങൾ, സമയം എന്നിവ കാണാം; സ്വന്തം കുറിപ്പുകളും ചേർക്കാം.';

  @override
  String get helpGuideHistoryBackupTitle =>
      'ബാക്കപ്പും പുനഃസ്ഥാപനവും (JSON / CSV)';

  @override
  String get helpGuideHistoryBackupBullet1 =>
      'JSON പൂർണ്ണ ബാക്കപ്പ്: ടാഗുകൾ, പ്രിയപ്പെട്ടവ, സുരക്ഷാ ഫലങ്ങൾ എന്നിവ ഉൾപ്പെടെ മുഴുവൻ നാൾവഴിയും എവിടെയും കൊണ്ടുപോകാവുന്ന ഒരു .json ഫയലിലേക്ക് എക്സ്പോർട്ട് ചെയ്യുന്നു.';

  @override
  String get helpGuideHistoryBackupBullet2 =>
      'CSV സ്പ്രെഡ്‌ഷീറ്റ്: Microsoft Excel-ലും Google Sheets-ലും തുറക്കാവുന്ന വൃത്തിയുള്ള ഒരു കോമ-വേർതിരിച്ച (CSV) ഫയൽ തയ്യാറാക്കുന്നു.';

  @override
  String get helpGuideHistoryBackupBullet3 =>
      'ഒറ്റ ക്ലിക്ക് പുനഃസ്ഥാപനം: മുമ്പ് എക്സ്പോർട്ട് ചെയ്ത JSON ബാക്കപ്പ് ഫയലുകൾ എപ്പോൾ വേണമെങ്കിലും ഇമ്പോർട്ട് ചെയ്ത് സ്കാൻ രേഖകൾ തിരികെ കൊണ്ടുവരാം.';

  @override
  String get helpGuideHistoryBiometricsTitle =>
      'ബയോമെട്രിക്സും സ്ക്രീൻഷോട്ട് സംരക്ഷണവും';

  @override
  String get helpGuideHistoryBiometricsBullet1 =>
      'ആപ്പ് ലോക്കും ബയോമെട്രിക്സും: ഐച്ഛിക ആപ്പ് ലോക്ക് ആപ്പ് തുറക്കുമ്പോൾ നിങ്ങളുടെ വിരലടയാളം, മുഖം അല്ലെങ്കിൽ സ്ക്രീൻ ലോക്ക് ആവശ്യപ്പെടുന്നു. രഹസ്യ StegoQR സന്ദേശങ്ങൾക്കും ബയോമെട്രിക് പരിശോധന ആവശ്യപ്പെടാം.';

  @override
  String get helpGuideHistoryBiometricsBullet2 =>
      'സ്ക്രീൻഷോട്ട് സംരക്ഷണം: സ്കാനുകൾ, നാൾവഴി, രഹസ്യങ്ങൾ, API കീകൾ എന്നിവ കാണിക്കുന്ന സ്ക്രീനുകൾ സ്ക്രീൻഷോട്ടായോ സ്ക്രീൻ റെക്കോർഡിംഗായോ പകർത്താൻ കഴിയില്ല (FLAG_SECURE). ക്രമീകരണങ്ങൾ › സ്വകാര്യതയും നെറ്റ്‌വർക്ക് പരിശോധനയും എന്നതിൽ ഇത് ഓഫാക്കാം.';

  @override
  String get helpGuideHistoryTip =>
      'നുറുങ്ങ്: ഫോൺ മാറ്റുന്നതിനോ റീസെറ്റ് ചെയ്യുന്നതിനോ മുമ്പ്, സേവ് ചെയ്ത സ്കാനുകൾ നഷ്ടപ്പെടാതിരിക്കാൻ നാൾവഴി ഒരു JSON ഫയലിലേക്ക് ബാക്കപ്പ് ചെയ്യുക.';

  @override
  String get titleHelpFaq => 'പതിവ് ചോദ്യങ്ങൾ';

  @override
  String get helpGuideFaqName => 'പതിവ് ചോദ്യങ്ങളും പ്രശ്നപരിഹാരവും';

  @override
  String get helpGuideFaqSummary =>
      'സാധാരണ ചോദ്യങ്ങൾ, ക്യാമറ ഫോക്കസ് നുറുങ്ങുകൾ, അനുമതി വീണ്ടെടുക്കൽ, ഓഫ്‌ലൈൻ ഉറപ്പുകൾ.';

  @override
  String get helpGuideFaqIntro =>
      'ശ്രീരാജ് പി ക്യുആർ സ്റ്റുഡിയോയെക്കുറിച്ചുള്ള സാധാരണ ചോദ്യങ്ങൾക്കുള്ള ഉത്തരങ്ങൾ, ക്യാമറ പ്രശ്നങ്ങൾക്കുള്ള പരിഹാരങ്ങൾ, സ്വകാര്യതയെക്കുറിച്ചുള്ള വിശദീകരണങ്ങൾ.';

  @override
  String get helpGuideFaqQuestionsTitle => 'പതിവ് ചോദ്യങ്ങൾ';

  @override
  String get helpGuideFaqQuestion1 =>
      'ചോ: ഇന്റർനെറ്റ് ഇല്ലാതെ ആപ്പ് പ്രവർത്തിക്കുമോ?\nഉവ്വ്! ബാർകോഡ് വായന, QuishingGuard CV പരിശോധനകൾ, URL സുരക്ഷാ പരിശോധനകൾ (ലെയർ 1-4) എന്നിവയെല്ലാം പൂർണ്ണമായും ഓഫ്‌ലൈനായി പ്രവർത്തിക്കുന്നു.';

  @override
  String get helpGuideFaqQuestion2 =>
      'ചോ: എന്റെ ക്യാമറ ദൃശ്യങ്ങൾ ഏതെങ്കിലും സെർവറിലേക്ക് അയയ്ക്കുന്നുണ്ടോ?\nഇല്ല. ക്യാമറ ഫ്രെയിമുകൾ ഉപകരണത്തിലെ താൽക്കാലിക മെമ്മറിയിൽ മാത്രമാണ് കൈകാര്യം ചെയ്യുന്നത്. അവ ഒരിക്കലും റെക്കോർഡ് ചെയ്യുകയോ സേവ് ചെയ്യുകയോ അപ്‌ലോഡ് ചെയ്യുകയോ ഇല്ല.';

  @override
  String get helpGuideFaqQuestion3 =>
      'ചോ: Google Safe Browsing എന്തുകൊണ്ട് ഐച്ഛികമാണ്?\nസ്വകാര്യതയ്ക്കാണ് ഞങ്ങൾ ആദ്യ പരിഗണന നൽകുന്നത്. ഓഫ്‌ലൈൻ സുരക്ഷാ ലെയറുകൾ ഉടൻ തന്നെ നിങ്ങളെ സംരക്ഷിക്കുന്നു. Google Cloud API കീ ഉള്ളവർക്ക് വേണമെങ്കിൽ മാത്രം Google Safe Browsing ഓണാക്കാം.';

  @override
  String get helpGuideFaqCameraTitle => 'ക്യാമറ പ്രശ്നപരിഹാരം';

  @override
  String get helpGuideFaqCameraBullet1 =>
      'ക്യാമറ ഫോക്കസ് ആകുന്നില്ലെങ്കിൽ: ലെൻസ് വൃത്തിയാണെന്ന് ഉറപ്പാക്കി ഉപകരണം 15-20 സെ.മീ. അകലെ പിടിക്കുക. വെളിച്ചം കുറവാണെങ്കിൽ ഫ്ലാഷ്‌ലൈറ്റ് ഐക്കണിൽ തൊടുക.';

  @override
  String get helpGuideFaqCameraBullet2 =>
      'വളരെ ചെറുതോ തിങ്ങിയതോ ആയ ക്യുആർ കോഡ്: ഫോൺ വളരെ അടുത്തേക്ക് കൊണ്ടുവരുന്നതിനു പകരം സൂം സ്ലൈഡർ ഉപയോഗിച്ച് കോഡ് വലുതാക്കുക.';

  @override
  String get helpGuideFaqCameraBullet3 =>
      'അനുമതി നിഷേധിച്ചാൽ: ക്യാമറ അനുമതി പിൻവലിച്ചിട്ടുണ്ടെങ്കിൽ, Android ക്രമീകരണങ്ങൾ -> ആപ്പുകൾ -> SreerajP QR Studio -> അനുമതികൾ -> ക്യാമറ -> അനുവദിക്കുക എന്നതിലേക്ക് പോകുക.';

  @override
  String get helpGuideFaqTip =>
      'നുറുങ്ങ്: അസാധാരണമായ ഒരു ബാർകോഡ് ഫോർമാറ്റ് കണ്ടാൽ, അതിന്റെ ഫോട്ടോ എടുത്ത് ഗാലറി സ്കാൻ വഴി പൂർണ്ണ റെസല്യൂഷനിൽ പരിശോധിക്കുക.';

  @override
  String get tooltipResultMoreActions => 'കൂടുതൽ';

  @override
  String get bodyVerdictChecking => 'ലിങ്ക് സുരക്ഷ പരിശോധിക്കുന്നു…';

  @override
  String get bodyVerdictNoIssues => 'പ്രശ്നങ്ങളൊന്നുമില്ല';

  @override
  String bodyVerdictIssuesFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count പ്രശ്നങ്ങൾ കണ്ടെത്തി',
      one: '1 പ്രശ്നം കണ്ടെത്തി',
    );
    return '$_temp0';
  }

  @override
  String bodyVerdictChecksPassed(int passed, int total) {
    return '$total പരിശോധനകളിൽ $passed എണ്ണം വിജയിച്ചു';
  }

  @override
  String get actionVerdictSeeDetails => 'വിശദാംശങ്ങൾ കാണുക';

  @override
  String get labelVerdictModePrivate => 'സ്വകാര്യ മോഡ്';

  @override
  String get labelVerdictModeActive => 'സജീവ പരിശോധന';

  @override
  String actionSafetyShowPassed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count വിജയിച്ചവ കാണിക്കുക',
      one: '1 വിജയിച്ചത് കാണിക്കുക',
    );
    return '$_temp0';
  }

  @override
  String get actionSafetyHidePassed => 'വിജയിച്ചവ മറയ്ക്കുക';

  @override
  String actionSafetySkippedGroup(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count പരിശോധനകൾ ഒഴിവാക്കി',
      one: '1 പരിശോധന ഒഴിവാക്കി',
    );
    return '$_temp0';
  }

  @override
  String get actionSafetySkippedSetup => 'ക്രമീകരണങ്ങളിൽ സജ്ജമാക്കുക';

  @override
  String bodyOpenRiskDialogIssues(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ഈ ലിങ്കിൽ $count പ്രശ്നങ്ങളുണ്ട്. എന്നിട്ടും തുറക്കണോ?',
      one: 'ഈ ലിങ്കിൽ 1 പ്രശ്നമുണ്ട്. എന്നിട്ടും തുറക്കണോ?',
    );
    return '$_temp0';
  }

  @override
  String get tooltipSandboxShowPreview => 'പ്രിവ്യൂ കാണിക്കുക';

  @override
  String get tooltipSandboxHidePreview => 'പ്രിവ്യൂ മറയ്ക്കുക';

  @override
  String labelQuishingCompactGenuine(String percent) {
    return 'യഥാർത്ഥം · $percent%';
  }

  @override
  String get labelScanBubble => 'സ്കാൻ ബബിൾ';

  @override
  String get descScanBubbleSettings => 'മറ്റ് ആപ്പുകളിലെ കോഡുകൾ സ്കാൻ ചെയ്യാം';

  @override
  String get labelScanBubbleSwitch => 'സ്കാൻ ബബിൾ കാണിക്കുക';

  @override
  String get descScanBubbleSwitch =>
      'മറ്റ് ആപ്പുകൾക്ക് മുകളിൽ നിൽക്കുന്ന ഒരു ചെറിയ ബട്ടൺ. സ്ക്രീനിലെ കോഡ് സ്കാൻ ചെയ്യാൻ അതിൽ തൊടുക.';

  @override
  String get descScanBubblePermissionGranted => 'അനുവദിച്ചു';

  @override
  String get descScanBubblePermissionMissing =>
      'ഇതുവരെ അനുവദിച്ചിട്ടില്ല. ബബിളിന് ഇത് ആവശ്യമാണ്.';

  @override
  String get actionScanBubbleAllow => 'അനുവദിക്കുക';

  @override
  String get labelScanBubbleStartOnBoot => 'റീസ്റ്റാർട്ടിനു ശേഷം തുടങ്ങുക';

  @override
  String get descScanBubbleStartOnBoot =>
      'ഫോൺ ഓഫാകുമ്പോൾ ബബിൾ ഓണായിരുന്നെങ്കിൽ, റീസ്റ്റാർട്ടിനു ശേഷം അത് വീണ്ടും കാണിക്കും. ചില ഫോണുകൾ ഇത് തടഞ്ഞേക്കാം.';

  @override
  String get actionScanBubbleAddTile => 'ക്വിക്ക് സെറ്റിംഗ്സിൽ ചേർക്കുക';

  @override
  String get bodyScanBubbleTileAdded =>
      'ക്വിക്ക് സെറ്റിംഗ്സ് ടൈൽ അഭ്യർത്ഥന അയച്ചു';

  @override
  String get bodyScanBubbleTileManual =>
      'ക്വിക്ക് സെറ്റിംഗ്സ് താഴേക്ക് വലിക്കുക, എഡിറ്റ് (പെൻസിൽ) ബട്ടൺ തൊടുക, സ്കാൻ ബബിൾ ടൈൽ വലിച്ചിടുക.';

  @override
  String get titleScanBubblePermissionDialog => 'ബബിൾ അനുവദിക്കുക';

  @override
  String get bodyScanBubblePermissionDialog =>
      'മറ്റ് ആപ്പുകൾക്ക് മുകളിൽ നിൽക്കാൻ ബബിളിന് \"മറ്റ് ആപ്പുകൾക്ക് മുകളിൽ കാണിക്കുക\" എന്ന അനുമതി വേണം. അടുത്ത പേജിൽ ഈ ആപ്പിനായി അത് ഓണാക്കി തിരികെ വരിക.';

  @override
  String get actionScanBubbleOpenSettings => 'ക്രമീകരണം തുറക്കുക';

  @override
  String get errorScanBubbleStartFailed =>
      'ബബിൾ തുടങ്ങാനായില്ല. വീണ്ടും ശ്രമിക്കുക.';

  @override
  String get errorScanBubbleBlockedCapture =>
      'ഈ ആപ്പ് സ്ക്രീൻ പകർത്തുന്നത് തടയുന്നു, അതിനാൽ അതിലെ കോഡുകൾ വായിക്കാനാവില്ല.';

  @override
  String get labelHistorySourceScreen => 'സ്ക്രീനിൽ നിന്ന്';

  @override
  String get helpPermissionOverlayTitle => 'മറ്റ് ആപ്പുകൾക്ക് മുകളിൽ കാണിക്കുക';

  @override
  String get helpPermissionOverlayDesc =>
      'സ്കാൻ ബബിൾ മാത്രം ഉപയോഗിക്കുന്നു, നിങ്ങൾ അത് ഓണാക്കിയ ശേഷം മാത്രം. ബബിളിനെ മറ്റ് ആപ്പുകൾക്ക് മുകളിൽ നിർത്തുന്നു.';

  @override
  String get helpPermissionNotificationTitle => 'അറിയിപ്പുകൾ';

  @override
  String get helpPermissionNotificationDesc =>
      'ബബിൾ ഓണായിരിക്കുമ്പോൾ, ഓഫാക്കാനുള്ള ബട്ടണോടൊപ്പം \"സ്കാൻ ബബിൾ ഓണാണ്\" എന്ന് കാണിക്കുന്നു.';

  @override
  String get helpGuideScanBubbleName => 'സ്കാൻ ബബിൾ';

  @override
  String get helpGuideScanBubbleSummary =>
      'മറ്റ് ആപ്പുകളിൽ കാണുന്ന ക്യുആർ കോഡുകളും ബാർകോഡുകളും സ്കാൻ ചെയ്യാനുള്ള ഒഴുകുന്ന ബട്ടൺ.';

  @override
  String get helpGuideScanBubbleIntro =>
      'സ്കാൻ ബബിൾ മറ്റ് ആപ്പുകൾക്ക് മുകളിൽ നിൽക്കുന്ന ഒരു ചെറിയ വട്ട ബട്ടണാണ്. സ്ക്രീനിൽ ക്യുആർ കോഡോ ബാർകോഡോ ഉള്ളപ്പോൾ ബബിളിൽ തൊട്ടാൽ, ആപ്പ് അത് ഓഫ്‌ലൈനായി നിങ്ങളുടെ ഫോണിൽ തന്നെ വായിക്കും.';

  @override
  String get helpGuideScanBubbleUseTitle => 'എങ്ങനെ ഉപയോഗിക്കാം';

  @override
  String get helpGuideScanBubbleUseBullet1 =>
      'ക്രമീകരണം > സ്കാൻ ബബിൾ, ക്വിക്ക് സെറ്റിംഗ്സിലെ സ്കാൻ ബബിൾ ടൈൽ, അല്ലെങ്കിൽ ആപ്പ് ഐക്കൺ അമർത്തിപ്പിടിക്കൽ എന്നിവയിലൂടെ ഇത് ഓണാക്കാം.';

  @override
  String get helpGuideScanBubbleUseBullet2 =>
      'ക്യുആർ കോഡോ ബാർകോഡോ കാണിക്കുന്ന ഏതെങ്കിലും ആപ്പ് തുറന്ന് ബബിളിൽ തൊടുക.';

  @override
  String get helpGuideScanBubbleUseBullet3 =>
      'സ്ക്രീൻ പകർത്താൻ ആൻഡ്രോയിഡ് അനുമതി ചോദിക്കും. അനുവദിച്ചാൽ, സാധാരണ സുരക്ഷാ പരിശോധനകളോടെ ഫലം തുറക്കും.';

  @override
  String get helpGuideScanBubbleUseBullet4 =>
      'ബബിൾ നീക്കാൻ അത് വലിക്കുക. ഓഫാക്കാൻ സ്ക്രീനിന്റെ താഴെയുള്ള X-ലേക്ക് വലിച്ചിടുക.';

  @override
  String get helpGuideScanBubblePrivacyTitle => 'സ്വകാര്യത';

  @override
  String get helpGuideScanBubblePrivacyBullet1 =>
      'നിങ്ങൾ ബബിളിൽ തൊടുമ്പോൾ മാത്രമേ സ്ക്രീൻ പകർത്തുകയുള്ളൂ, ആൻഡ്രോയിഡ് എപ്പോഴും ആദ്യം ചോദിക്കും.';

  @override
  String get helpGuideScanBubblePrivacyBullet2 =>
      'കോഡ് നിങ്ങളുടെ ഫോണിൽ തന്നെ വായിക്കുന്നു. വായിക്കാനായി ഒന്നും ഓൺലൈനിൽ അയയ്ക്കുന്നില്ല.';

  @override
  String get helpGuideScanBubblePrivacyBullet3 =>
      'സ്ക്രീൻ ചിത്രം ഗാലറിയിൽ സൂക്ഷിക്കുന്നില്ല, വായിച്ച ഉടനെ മായ്ക്കുന്നു.';

  @override
  String get helpGuideScanBubbleLimitsTitle => 'അറിഞ്ഞിരിക്കേണ്ടവ';

  @override
  String get helpGuideScanBubbleLimitsBullet1 =>
      'ആൻഡ്രോയിഡ് 14-ലും പുതിയവയിലും, ഓരോ തവണ തൊടുമ്പോഴും സ്ക്രീൻ പകർത്താനുള്ള അനുമതി ചോദിക്കും.';

  @override
  String get helpGuideScanBubbleLimitsBullet2 =>
      'ബാങ്കിംഗ്, പേയ്‌മെന്റ്, ചില വീഡിയോ ആപ്പുകൾ സ്ക്രീൻ പകർത്തുന്നത് തടയുന്നു. അവയിലെ കോഡുകൾ വായിക്കാനാവില്ല.';

  @override
  String get helpGuideScanBubbleLimitsBullet3 =>
      'ചില ഫോണുകളിൽ ബബിളിനെ മറയ്ക്കാനോ നിർത്താനോ കഴിയുന്ന അധിക \"പോപ്പ്-അപ്പ് വിൻഡോ\" അല്ലെങ്കിൽ ബാറ്ററി ക്രമീകരണങ്ങൾ ഉണ്ട്.';

  @override
  String get helpGuideScanBubbleTip =>
      'നുറുങ്ങ്: സ്കാൻ ബബിൾ ടൈൽ ക്വിക്ക് സെറ്റിംഗ്സിൽ ചേർക്കുക. പിന്നെ ഏത് ആപ്പിൽ നിന്നും ഒറ്റ തൊടലിൽ ബബിൾ ഓണാക്കാനും ഓഫാക്കാനും കഴിയും.';

  @override
  String get labelCodeForgeBarcodeContent => 'ബാർകോഡ് ഉള്ളടക്കം';

  @override
  String get helpCodeForgeBarcodeContent =>
      'ബാർകോഡ് നമ്പർ അല്ലെങ്കിൽ കോഡ് നൽകുക';

  @override
  String get labelCodeForgeWifiSecurityNone => 'ഒന്നുമില്ല (തുറന്നത്)';

  @override
  String get helpCodeForgeUpiVpa => 'ഉദാ. merchant@upi';

  @override
  String get labelOptionalField => 'ഐച്ഛികം';

  @override
  String get errorCodeForgeContentEmpty => 'ഉള്ളടക്കം ശൂന്യമാകരുത്';

  @override
  String errorCodeForgeTextTooLong(String max) {
    return 'എഴുത്ത് $max അക്ഷരങ്ങളിൽ കൂടരുത്';
  }

  @override
  String get errorCodeForgeWifiSsidRequired =>
      'വൈ-ഫൈ നെറ്റ്‌വർക്ക് പേര് (SSID) ആവശ്യമാണ്';

  @override
  String get errorCodeForgeUpiVpaRequired => 'യുപിഐ ഐഡി ആവശ്യമാണ്';

  @override
  String errorCodeForgeBarcodeInvalid(String detail) {
    return 'ഈ ബാർകോഡ് തരത്തിന് സാധുവല്ല ($detail)';
  }

  @override
  String get titleAirQrUnlocked => 'എയർ ക്യുആർ ഉള്ളടക്കം തുറന്നു';

  @override
  String get titleJsonEnvelopeUnlocked => 'JSON ഉള്ളടക്കം തുറന്നു';

  @override
  String get titleStegoUnlocked => 'StegoQR ഉള്ളടക്കം തുറന്നു';

  @override
  String get titleStegoDetected => 'StegoQR കണ്ടെത്തി';

  @override
  String get actionDecryptShowAdvanced => 'വിപുലം (Salt / IV)';

  @override
  String get actionDecryptHideAdvanced => 'വിപുലം മറയ്ക്കുക';

  @override
  String get labelDecryptSalt => 'സോൾട്ട് (Base64)';

  @override
  String get labelDecryptIv => 'IV / നോൺസ് (Base64)';

  @override
  String bodyHistoryRecordCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count സ്കാൻ രേഖകൾ കണ്ടെത്തി',
      one: '1 സ്കാൻ രേഖ കണ്ടെത്തി',
    );
    return '$_temp0';
  }

  @override
  String bodyArItemsSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ഇനങ്ങൾ തിരഞ്ഞെടുത്തു',
      one: '1 ഇനം തിരഞ്ഞെടുത്തു',
    );
    return '$_temp0';
  }

  @override
  String descSettingsAppearanceSummary(String themeMode) {
    return '$themeMode • ഡൈനാമിക് നിറങ്ങൾ';
  }

  @override
  String get bodyOpenPhishFeedNotDownloaded =>
      'ഫീഡ് ഇതുവരെ ഡൗൺലോഡ് ചെയ്തിട്ടില്ല';

  @override
  String get helpAccentDynamicColor =>
      'നിങ്ങളുടെ ആൻഡ്രോയിഡ് വാൾപേപ്പറിൽ നിന്ന് ഡൈനാമിക് കളർ ചേരുന്ന നിറങ്ങൾ ഒരുക്കുന്നു (ആൻഡ്രോയിഡ് 12+). ഇത് ഓഫാണെങ്കിൽ, സാധാരണ ഉയർന്ന കോൺട്രാസ്റ്റ് സുരക്ഷാ നിറങ്ങൾ ഉപയോഗിക്കും.';

  @override
  String get bodyTypographySample =>
      '6-തല URL സുരക്ഷാ പരിശോധന • 100% ഓഫ്‌ലൈൻ QuishingGuard™ CV എഞ്ചിൻ';

  @override
  String get labelTypographyScale => 'അക്ഷര വലുപ്പം';

  @override
  String get helpTypographyScale =>
      'ആപ്പ് നിങ്ങളുടെ ആൻഡ്രോയിഡ് പ്രവേശനക്ഷമതാ അക്ഷര വലുപ്പം പിന്തുടരുന്നു; സ്കാൻ ഫ്രെയിമും സ്ക്രീനിലെ ലേബലുകളും വായിക്കാൻ എളുപ്പമായി നിലനിർത്തുന്നു.';

  @override
  String bodyDomFetchFailed(String host) {
    return '$host (ഓഫ്‌ലൈൻ അല്ലെങ്കിൽ നെറ്റ്‌വർക്ക് തടഞ്ഞു)';
  }

  @override
  String get tooltipScanPause => 'സ്കാനിംഗ് നിർത്തിവയ്ക്കുക';

  @override
  String get tooltipScanResume => 'സ്കാനിംഗ് തുടരുക';

  @override
  String get labelArModeWarehouse => 'വെയർഹൗസ്';

  @override
  String get labelArModeSafety => 'സുരക്ഷ';

  @override
  String get tooltipArModeWarehouse => 'വിവരം, തിരഞ്ഞെടുപ്പ്';

  @override
  String get tooltipArModeSafety => 'ലിങ്ക് സുരക്ഷാ ബാഡ്ജ്';

  @override
  String get errorCameraStartFailed => 'ക്യാമറ തുടങ്ങാൻ കഴിഞ്ഞില്ല';

  @override
  String get errorCameraNotFound => 'ഈ ഫോണിൽ ക്യാമറ കണ്ടെത്തിയില്ല';

  @override
  String get actionCameraRetry => 'വീണ്ടും ശ്രമിക്കുക';

  @override
  String get bodyCodeForgeSafetyPrompt =>
      'പങ്കിടുന്നതിന് മുമ്പ് ഈ ലിങ്ക് പരിശോധിക്കുക';

  @override
  String get actionCodeForgeSafetyCheck => 'പരിശോധിക്കുക';

  @override
  String bodyCodeForgeSafetyProblems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ഈ ലിങ്കിൽ $count പ്രശ്നങ്ങൾ കണ്ടെത്തി',
      one: 'ഈ ലിങ്കിൽ 1 പ്രശ്നം കണ്ടെത്തി',
    );
    return '$_temp0';
  }

  @override
  String get actionCodeForgeSafetyCheckAgain => 'വീണ്ടും പരിശോധിക്കുക';

  @override
  String get labelDeleteAllData => 'എല്ലാ വിവരങ്ങളും ഇല്ലാതാക്കുക';

  @override
  String get descDeleteAllData =>
      'സ്കാൻ നാൾവഴി, സംരക്ഷിച്ച API കീകൾ, എല്ലാ ക്രമീകരണങ്ങളും ഈ ഫോണിൽ നിന്ന് ഇല്ലാതാക്കുന്നു.';

  @override
  String get titleDeleteAllDataConfirm => 'എല്ലാ വിവരങ്ങളും ഇല്ലാതാക്കണോ?';

  @override
  String get bodyDeleteAllDataConfirm =>
      'ഇത് നിങ്ങളുടെ സ്കാൻ നാൾവഴി, സംരക്ഷിച്ച API കീകൾ, എല്ലാ ക്രമീകരണങ്ങൾ, സ്കാൻ ബബിൾ ക്രമീകരണങ്ങൾ, താൽക്കാലിക ഫയലുകൾ എന്നിവ ഇല്ലാതാക്കും. ഇത് പഴയപടിയാക്കാൻ കഴിയില്ല.';

  @override
  String get actionDeleteAll => 'എല്ലാം ഇല്ലാതാക്കുക';

  @override
  String get bodyDeletingAllData => 'എല്ലാ വിവരങ്ങളും ഇല്ലാതാക്കുന്നു…';

  @override
  String get errorDeleteAllDataPartial =>
      'ചില വിവരങ്ങൾ ഇല്ലാതാക്കാൻ കഴിഞ്ഞില്ല.';

  @override
  String get errorHistoryLoadFailed => 'നാൾവഴി തുറക്കാൻ കഴിഞ്ഞില്ല.';

  @override
  String get actionTryAgain => 'വീണ്ടും ശ്രമിക്കുക';

  @override
  String get aboutDetailPrivacyPolicy => 'സ്വകാര്യതാ നയം';

  @override
  String get bodyEncryptingBackup => 'നിങ്ങളുടെ ബാക്കപ്പ് സംരക്ഷിക്കുന്നു…';

  @override
  String get bodyOpeningBackup => 'ബാക്കപ്പ് തുറക്കുന്നു…';

  @override
  String get bodyEncryptingSync => 'സിങ്ക് പാക്കേജ് സംരക്ഷിക്കുന്നു…';

  @override
  String get titlePlainExport => 'എൻക്രിപ്റ്റ് ചെയ്യാതെ?';

  @override
  String get bodyPlainExport =>
      'ഈ ഫയൽ എൻക്രിപ്റ്റ് ചെയ്തിട്ടില്ല. ഇത് കിട്ടുന്ന ആർക്കും നിങ്ങളുടെ സ്കാനുകൾ വായിക്കാം.';

  @override
  String get bodyPlainExportBackupHint =>
      'സ്വകാര്യമായി സൂക്ഷിക്കാൻ, പകരം എൻക്രിപ്റ്റ് ചെയ്ത ബാക്കപ്പ് ഉപയോഗിക്കുക.';

  @override
  String get actionExportAnyway => 'എന്നാലും എക്സ്പോർട്ട്';

  @override
  String get labelAppLock => 'ആപ്പ് ലോക്ക്';

  @override
  String get descAppLock =>
      'ആപ്പ് തുറക്കുമ്പോഴും 30 സെക്കൻഡിലേറെ പുറത്തായിരുന്ന ശേഷവും വിരലടയാളം, മുഖം അല്ലെങ്കിൽ സ്ക്രീൻ ലോക്ക് ആവശ്യപ്പെടുക.';

  @override
  String get labelScreenshotGuard => 'സ്ക്രീൻഷോട്ട് സംരക്ഷണം';

  @override
  String get descScreenshotGuard =>
      'സ്കാനുകൾ, നാൾവഴി, രഹസ്യങ്ങൾ, API കീകൾ എന്നിവ കാണിക്കുന്ന സ്ക്രീനുകളിൽ സ്ക്രീൻഷോട്ടും സ്ക്രീൻ റെക്കോർഡിംഗും തടയുക. സമീപകാല ആപ്പുകളുടെ പട്ടികയിലും ഈ സ്ക്രീനുകൾ ശൂന്യമായി കാണിക്കും.';

  @override
  String get titleAppLocked => 'ആപ്പ് ലോക്ക് ചെയ്തു';

  @override
  String get bodyAppLocked =>
      'തുടരാൻ വിരലടയാളം, മുഖം അല്ലെങ്കിൽ സ്ക്രീൻ ലോക്ക് ഉപയോഗിച്ച് അൺലോക്ക് ചെയ്യുക.';

  @override
  String get actionUnlock => 'അൺലോക്ക് ചെയ്യുക';

  @override
  String get bodyAppLockReason => 'SreerajP QR Studio അൺലോക്ക് ചെയ്യുക';

  @override
  String get errorAppLockUnavailable =>
      'ആദ്യം ഈ ഫോണിൽ ഒരു സ്ക്രീൻ ലോക്കോ വിരലടയാളമോ സജ്ജമാക്കുക.';

  @override
  String get errorAppLockFailed =>
      'നിങ്ങളാണെന്ന് ഉറപ്പാക്കാൻ കഴിഞ്ഞില്ല. വീണ്ടും ശ്രമിക്കുക.';
}
