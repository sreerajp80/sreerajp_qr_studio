// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

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
  String get titleQuishingGuard => 'ക്വിഷിംഗ് ഗാർഡ്™';

  @override
  String get titleStickerCheck => 'സ്റ്റിക്കർ പരിശോധന';

  @override
  String get tooltipStickerCheckExpand => 'പരിശോധനകൾ കാണിക്കുക';

  @override
  String get tooltipStickerCheckCollapse => 'പരിശോധനകൾ മറയ്ക്കുക';

  @override
  String get bodyStickerCheckIntro =>
      'തട്ടിപ്പുകാർ യഥാർത്ഥ കോഡിനു മുകളിൽ സ്വന്തം QR കോഡ് ഒട്ടിക്കാറുണ്ട്. ക്യാമറ ചിത്രത്തിൽ നിന്ന് സ്റ്റിക്കർ തിരിച്ചറിയാൻ ഈ ആപ്പിന് കഴിയില്ല, അതിനാൽ നിങ്ങൾ തന്നെ പരിശോധിക്കുക:';

  @override
  String get bodyStickerCheckEdges =>
      'കോഡ് നോക്കുകയും വിരൽ കൊണ്ട് തൊട്ടുനോക്കുകയും ചെയ്യുക. മുകളിൽ ഒട്ടിച്ച സ്റ്റിക്കറിന് പലപ്പോഴും ഉയർന്ന അരികുകൾ ഉണ്ടാകും, അല്ലെങ്കിൽ ചരിഞ്ഞിരിക്കും.';

  @override
  String get bodyStickerCheckPayee =>
      'പണം നൽകുന്നതിനു മുൻപ്, പണമിടപാട് സ്ക്രീനിലെ പേര് കടയുടേതു തന്നെയാണോ എന്ന് ഉറപ്പാക്കുക.';

  @override
  String get bodyStickerCheckAsk =>
      'സംശയമുണ്ടെങ്കിൽ ജീവനക്കാരോടു ചോദിക്കുക, അല്ലെങ്കിൽ വെബ്സൈറ്റ് വിലാസം സ്വയം ടൈപ്പ് ചെയ്യുക.';

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
  String get descSettingsPermissions => 'ആപ്പ് എന്ത് ഉപയോഗിക്കുന്നു, എന്തിന്';

  @override
  String get labelSettingsHelp => 'സഹായവും സവിശേഷതകളും';

  @override
  String get descSettingsHelp => 'എല്ലാ സവിശേഷതകൾക്കും ലളിതമായ വഴികാട്ടി';

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
  String get helpPermissionsIntro =>
      'ക്യാമറ പോലുള്ള ഫോണിന്റെ ഭാഗങ്ങൾ ഉപയോഗിക്കാൻ ആപ്പിന് അനുമതി വേണം. ഓരോ സവിശേഷതയ്ക്കും ആവശ്യമുള്ളത് മാത്രം, നിങ്ങൾ ആ സവിശേഷത ഉപയോഗിക്കുമ്പോൾ മാത്രം, ഈ ആപ്പ് ചോദിക്കുന്നു. Android ക്രമീകരണങ്ങൾ > ആപ്പുകൾ > ഈ ആപ്പ് > അനുമതികൾ എന്നതിൽ എപ്പോൾ വേണമെങ്കിലും ഇവ കാണാനും മാറ്റാനും കഴിയും.';

  @override
  String get labelPermGroupAsked => 'ആവശ്യമുള്ളപ്പോൾ ചോദിക്കും';

  @override
  String get helpPermGroupAskedNote =>
      'ഇവ ഉപയോഗിക്കുന്നതിന് മുമ്പ് Android നിങ്ങളോട് ചോദിക്കും. വേണ്ടെന്ന് പറഞ്ഞാലും ആപ്പിന്റെ മറ്റ് ഭാഗങ്ങൾ പ്രവർത്തിക്കും.';

  @override
  String get labelPermGroupInstall => 'സ്വയം ലഭിക്കുന്നവ';

  @override
  String get helpPermGroupInstallNote =>
      'ആപ്പ് ഇൻസ്റ്റാൾ ചെയ്യുമ്പോൾ ചോദിക്കാതെ തന്നെ Android ഇവ അനുവദിക്കുന്നു. ഓരോന്നും ഇവിടെ പറഞ്ഞ സവിശേഷതയ്ക്ക് മാത്രം ഉപയോഗിക്കുന്നു.';

  @override
  String get labelPermGroupNotUsed => 'ചോദിക്കാത്തവ';

  @override
  String get helpPermGroupNotUsedNote =>
      'ആപ്പ് ഇവ ചോദിക്കുന്നില്ല, അതിനാൽ ഇവ ഉപയോഗിക്കാൻ ആപ്പിന് കഴിയില്ല.';

  @override
  String get labelPermCamera => 'ക്യാമറ';

  @override
  String get helpPermCameraDesc =>
      'QR കോഡുകളും ബാർകോഡുകളും സ്കാൻ ചെയ്യാനും AR കോഡ്‌വിഷനും AirQR കൈമാറ്റങ്ങൾ സ്വീകരിക്കാനും ഉപയോഗിക്കുന്നു. ക്യാമറ സ്ക്രീൻ ആദ്യമായി തുറക്കുമ്പോൾ Android ചോദിക്കും. ക്യാമറ ദൃശ്യങ്ങൾ ഫോണിൽ തന്നെ വായിക്കുന്നു; അവ സൂക്ഷിക്കുകയോ അയയ്ക്കുകയോ ചെയ്യുന്നില്ല. വേണ്ടെന്ന് പറഞ്ഞാലും ചിത്രങ്ങളിൽ നിന്നും PDF-കളിൽ നിന്നും സ്കാൻ ചെയ്യാം.';

  @override
  String get labelPermLocation => 'സ്ഥാനം';

  @override
  String get helpPermLocationDesc =>
      'കോഡ്ഫോർജിൽ \"എന്റെ ലൊക്കേഷൻ\" അമർത്തുമ്പോൾ മാത്രം, നിങ്ങളുടെ ഇപ്പോഴത്തെ സ്ഥലം ഒരു മാപ്പ് QR കോഡിൽ ചേർക്കാൻ ഉപയോഗിക്കുന്നു. സ്ഥാനം ഒരിക്കൽ മാത്രം വായിക്കുന്നു; അത് സൂക്ഷിക്കുകയോ എവിടേക്കും അയയ്ക്കുകയോ ചെയ്യുന്നില്ല. പശ്ചാത്തലത്തിൽ ഒരിക്കലും ഉപയോഗിക്കുന്നില്ല. വേണ്ടെന്ന് പറഞ്ഞാൽ സ്ഥലം നിങ്ങൾക്ക് തന്നെ നൽകാം.';

  @override
  String get labelPermBiometric => 'വിരലടയാളം / മുഖം';

  @override
  String get helpPermBiometricDesc =>
      'ആപ്പ് ലോക്കിനും, പൂട്ടിയ StegoQR ഇനങ്ങൾ വിരലടയാളം, മുഖം അല്ലെങ്കിൽ സ്ക്രീൻ ലോക്ക് ഉപയോഗിച്ച് തുറക്കാനും ഉപയോഗിക്കുന്നു. പരിശോധന നടത്തുന്നത് Android ആണ്; വിജയിച്ചോ ഇല്ലയോ എന്ന് മാത്രം ആപ്പിനെ അറിയിക്കുന്നു. നിങ്ങളുടെ വിരലടയാളമോ മുഖമോ ആപ്പ് ഒരിക്കലും കാണുന്നില്ല.';

  @override
  String get labelPermNotifications => 'അറിയിപ്പുകൾ';

  @override
  String get helpPermNotificationsDesc =>
      'സ്കാൻ ബബിൾ ഓണായിരിക്കുമ്പോൾ മാത്രം, അത് ഓണാണെന്ന് ഓഫാക്കാനുള്ള ബട്ടണോടൊപ്പം കാണിക്കാൻ ഉപയോഗിക്കുന്നു. ബബിൾ ആദ്യമായി ഓണാക്കുമ്പോൾ Android ചോദിക്കും. വേണ്ടെന്ന് പറഞ്ഞാലും ബബിൾ പ്രവർത്തിക്കും, അറിയിപ്പ് മാത്രം കാണില്ല.';

  @override
  String get labelPermOverlay => 'മറ്റ് ആപ്പുകൾക്ക് മുകളിൽ';

  @override
  String get helpPermOverlayDesc =>
      'സ്ക്രീനിൽ കാണുന്ന കോഡ് സ്കാൻ ചെയ്യാൻ, സ്കാൻ ബബിളിനെ മറ്റ് ആപ്പുകൾക്ക് മുകളിൽ കാണിക്കുന്നു. നിങ്ങൾ ബബിൾ ഓണാക്കിയ ശേഷം മാത്രം ഉപയോഗിക്കുന്നു. ആപ്പ് ആദ്യം ഇത് വിശദീകരിക്കും, തുടർന്ന് അനുമതി നൽകാനുള്ള Android താൾ തുറക്കും. അനുവദിച്ചില്ലെങ്കിൽ ബബിൾ ഓഫായി തുടരും.';

  @override
  String get labelPermScreenCapture => 'സ്ക്രീൻ പകർത്തൽ';

  @override
  String get helpPermScreenCaptureDesc =>
      'സ്ക്രീനിൽ കാണുന്ന കോഡ് വായിക്കാൻ ഗോസ്റ്റ്സ്കാനും സ്കാൻ ബബിളും ഉപയോഗിക്കുന്നു. ഓരോ തവണയും Android നിങ്ങളോട് ചോദിക്കും. ആപ്പ് സ്ക്രീനിന്റെ ഒരു ചിത്രം മാത്രം എടുത്ത്, കോഡ് ഫോണിൽ തന്നെ വായിച്ച്, ചിത്രം ഉപേക്ഷിക്കുന്നു. വീഡിയോ പകർത്തുകയോ ചിത്രം എവിടേക്കും അയയ്ക്കുകയോ ചെയ്യുന്നില്ല.';

  @override
  String get labelPermInternet => 'ഇന്റർനെറ്റ്';

  @override
  String get helpPermInternetDesc =>
      'സ്കാനിംഗ് പൂർണ്ണമായും ഓഫ്‌ലൈനായി പ്രവർത്തിക്കുന്നു. താഴെയുള്ള രണ്ട് ഐച്ഛിക ലിങ്ക് പരിശോധനകൾക്ക് മാത്രമാണ് ഇന്റർനെറ്റ് ഉപയോഗിക്കുന്നത്. നിങ്ങൾ ഓണാക്കുന്നതുവരെ രണ്ടും ഓഫാണ്. അവ ഓഫായിരിക്കുമ്പോൾ നിങ്ങൾ സ്കാൻ ചെയ്യുന്ന ഒന്നും ഫോണിൽ നിന്ന് പുറത്തുപോകുന്നില്ല. ലിങ്ക് തുറക്കുന്നത് നിങ്ങളുടെ ബ്രൗസറാണ്, ഈ ആപ്പല്ല.';

  @override
  String get labelPermProbing => 'ഓൺലൈൻ ലിങ്ക് പരിശോധന';

  @override
  String get helpPermProbingDesc =>
      'ക്രമീകരണങ്ങൾ > സ്വകാര്യതയും നെറ്റ്‌വർക്ക് പരിശോധനയും എന്നതിൽ ഓണാക്കിയാൽ മാത്രം. ഓണായിരിക്കുമ്പോൾ, നിങ്ങൾ ലിങ്ക് തുറക്കുന്നതിന് മുമ്പ് ആപ്പ് ആ ലിങ്ക് സന്ദർശിച്ച് അതിന്റെ വഴിതിരിച്ചുവിടലുകൾ പിന്തുടരുകയും സുരക്ഷാ സർട്ടിഫിക്കറ്റ് പരിശോധിക്കുകയും വെബ്‌സൈറ്റിന്റെ പഴക്കം നോക്കുകയും ചെയ്യുന്നു.';

  @override
  String get labelPermLinkServices => 'ലിങ്ക് സുരക്ഷാ സേവനങ്ങൾ';

  @override
  String get helpPermLinkServicesDesc =>
      'ക്രമീകരണങ്ങൾ > URL സുരക്ഷാ ദാതാക്കൾ എന്നതിൽ നിങ്ങൾ ഓണാക്കിയാൽ മാത്രം. ഓണായിരിക്കുമ്പോൾ, സ്കാൻ ചെയ്ത ലിങ്ക് നിങ്ങൾ തിരഞ്ഞെടുത്ത സേവനങ്ങളിലേക്ക് (ഉദാ. Google Safe Browsing, VirusTotal) അയച്ച് അപകടകരമായ സൈറ്റുകളുടെ പട്ടികയുമായി ഒത്തുനോക്കുന്നു. ചിലതിന് നിങ്ങളുടെ സ്വന്തം API കീ വേണം; അത് ഫോണിന്റെ സുരക്ഷിത സംഭരണിയിൽ സൂക്ഷിക്കുന്നു.';

  @override
  String get labelPermWifi => 'വൈ-ഫൈ കണക്ഷൻ';

  @override
  String get helpPermWifiDesc =>
      'സ്കാൻ ചെയ്ത വൈ-ഫൈ QR കോഡിൽ \"വൈ-ഫൈയിലേക്ക് ബന്ധിപ്പിക്കുക\" അമർത്തുമ്പോൾ മാത്രം, ആ ശൃംഖല ഫോണിൽ ചേർക്കാൻ ഉപയോഗിക്കുന്നു. പുതിയ Android പതിപ്പുകളിൽ Android ആദ്യം നിങ്ങളോട് സ്ഥിരീകരണം ചോദിക്കും. നിങ്ങൾ സൂക്ഷിച്ച വൈ-ഫൈ പാസ്‌വേഡുകൾ ആപ്പ് വായിക്കുന്നില്ല.';

  @override
  String get labelPermBackground => 'പശ്ചാത്തല പ്രവർത്തനം';

  @override
  String get helpPermBackgroundDesc =>
      'നിങ്ങൾ മറ്റൊരു ആപ്പിലായിരിക്കുമ്പോഴും ഗോസ്റ്റ്സ്കാനും സ്കാൻ ബബിളും പ്രവർത്തിക്കാൻ അനുവദിക്കുന്നു. ഇത് പ്രവർത്തിക്കുമ്പോൾ നിങ്ങൾ അറിയാനായി Android എപ്പോഴും ഒരു അറിയിപ്പ് കാണിക്കും.';

  @override
  String get labelPermBoot => 'റീസ്റ്റാർട്ടിനു ശേഷം';

  @override
  String get helpPermBootDesc =>
      'ഫോൺ റീസ്റ്റാർട്ട് ചെയ്ത ശേഷം സ്കാൻ ബബിൾ തിരികെ കൊണ്ടുവരുന്നു. ബബിൾ ഓണായിരിക്കുകയും \"റീസ്റ്റാർട്ടിനു ശേഷം തുടങ്ങുക\" ഓണാക്കുകയും ചെയ്തിട്ടുണ്ടെങ്കിൽ മാത്രം. അല്ലാത്തപക്ഷം ഇത് ഒന്നും ചെയ്യുന്നില്ല.';

  @override
  String get labelPermStorage => 'ഫോട്ടോകളും ഫയലുകളും';

  @override
  String get helpPermStorageDesc =>
      'ആപ്പിന് സംഭരണ അനുമതി ഇല്ല. ചിത്രത്തിൽ നിന്നോ PDF-ൽ നിന്നോ സ്കാൻ ചെയ്യുമ്പോൾ Android-ന്റെ സ്വന്തം തിരഞ്ഞെടുക്കൽ സ്ക്രീൻ തുറക്കും; നിങ്ങൾ തിരഞ്ഞെടുക്കുന്ന ഫയൽ മാത്രമേ ആപ്പിന് ലഭിക്കൂ.';

  @override
  String get labelPermMicrophone => 'മൈക്രോഫോൺ';

  @override
  String get helpPermMicrophoneDesc =>
      'ആപ്പ് മൈക്രോഫോൺ ഉപയോഗിക്കുന്നില്ല. ക്യാമറ എപ്പോഴും ശബ്ദമില്ലാതെയാണ് തുറക്കുന്നത്.';

  @override
  String get labelPermVibration => 'കമ്പനം';

  @override
  String get helpPermVibrationDesc =>
      'സ്കാൻ കമ്പനങ്ങൾ Android-ന്റെ സ്വന്തം സ്പർശന പ്രതികരണം ഉപയോഗിക്കുന്നു; അതിന് അനുമതി ആവശ്യമില്ല.';

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
      'SSL, റീഡയറക്ട്, ഷോർട്ട്‌നർ പരിശോധനകൾ പ്രാദേശിക നിയമങ്ങൾ മാത്രം ഉപയോഗിക്കുന്നു; സ്കാൻ ചെയ്ത സൈറ്റുമായി ബന്ധപ്പെടുന്നില്ല. ക്രമീകരണങ്ങളിൽ നിങ്ങൾ ഓണാക്കിയ സുരക്ഷാ സേവനത്തിലേക്ക് (ഉദാ. Google Safe Browsing) മാത്രമേ ലിങ്ക് അയയ്ക്കൂ.';

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
  String get bodySslUntrusted => 'SSL സർട്ടിഫിക്കറ്റ് വിശ്വസനീയമല്ല';

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
  String errorMediaImageTooLarge(String maxMb) {
    return 'ഈ ചിത്രം സ്കാൻ ചെയ്യാൻ വളരെ വലുതാണ് ($maxMb MB-ൽ കൂടുതൽ).';
  }

  @override
  String errorMediaPdfTooLarge(String maxMb) {
    return 'ഈ PDF സ്കാൻ ചെയ്യാൻ വളരെ വലുതാണ് ($maxMb MB-ൽ കൂടുതൽ).';
  }

  @override
  String bodyPdfPagesSkipped(int count) {
    return 'ആദ്യത്തെ $count പേജുകൾ മാത്രമേ പരിശോധിച്ചുള്ളൂ.';
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
      'ലിങ്ക് തുറക്കുന്നതിനോ പണം നൽകുന്നതിനോ മുൻപ്, അച്ചടിച്ച QR കോഡിൽ വ്യാജ സ്റ്റിക്കർ ഉണ്ടോ എന്നു പരിശോധിക്കാൻ ഓർമ്മിപ്പിക്കുന്നു. കൈകൊണ്ടു ചെയ്യാവുന്ന ലളിതമായ പരിശോധനകൾ നൽകുന്നു; ചിത്രം പരിശോധിക്കുന്നില്ല.';

  @override
  String get labelFeatureQuishingGuardChip1 => 'വ്യാജ സ്റ്റിക്കർ';

  @override
  String get labelFeatureQuishingGuardChip2 => 'സ്വയം പരിശോധന';

  @override
  String get labelFeatureQuishingGuardChip3 => 'പണമിടപാട് നുറുങ്ങുകൾ';

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
  String get helpCenterHeaderTitle => 'ആപ്പ് എങ്ങനെ ഉപയോഗിക്കാം';

  @override
  String get helpCenterHeaderSubtitle =>
      'ആപ്പിന്റെ ഓരോ ഭാഗത്തിനും ലളിതമായ വഴികാട്ടികൾ. ഒരു വിഷയം തിരഞ്ഞെടുത്ത്, അത് എന്തു ചെയ്യുന്നു, എങ്ങനെ ഉപയോഗിക്കാം എന്നു കാണുക.';

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
  String get tooltipSwitchCamera => 'ക്യാമറ മാറ്റുക';

  @override
  String get tooltipBack => 'പിന്നോട്ട്';

  @override
  String get tooltipToggleSecretVisibility => 'രഹസ്യം കാണിക്കുക/മറയ്ക്കുക';

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
  String get tooltipCodeForgeShare => 'പങ്കിടുക';

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
  String get labelOnboardingSlide2Badge => 'തട്ടിപ്പ് സ്റ്റിക്കർ';

  @override
  String get titleOnboardingSlide2 => 'സ്റ്റിക്കർ പരിശോധന';

  @override
  String get bodyOnboardingSlide2 =>
      'തട്ടിപ്പുകാർ യഥാർത്ഥ കോഡുകൾക്കു മുകളിൽ വ്യാജ QR സ്റ്റിക്കറുകൾ ഒട്ടിക്കാറുണ്ട്. ക്യാമറ കൊണ്ട് ലിങ്കോ പണമിടപാട് കോഡോ സ്കാൻ ചെയ്യുമ്പോൾ, തുറക്കുന്നതിനോ പണം നൽകുന്നതിനോ മുൻപ് എന്തു പരിശോധിക്കണമെന്ന് ക്വിഷിംഗ് ഗാർഡ് ഓർമ്മിപ്പിക്കും.';

  @override
  String get bodyOnboardingSlide2Bullet1 =>
      'സ്റ്റിക്കറിന്റെ ഉയർന്ന അരികുകൾ തൊട്ടുനോക്കുക';

  @override
  String get bodyOnboardingSlide2Bullet2 =>
      'പണം വാങ്ങുന്നയാളുടെ പേര് ഉറപ്പാക്കുക';

  @override
  String get bodyOnboardingSlide2Bullet3 =>
      'സംശയമുണ്ടെങ്കിൽ ജീവനക്കാരോടു ചോദിക്കുക';

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
  String get helpGuideGroupScanning => 'സ്കാനിംഗ്';

  @override
  String get helpGuideGroupCreate => 'കോഡുകൾ നിർമ്മിക്കലും അയയ്ക്കലും';

  @override
  String get helpGuideGroupSecurity => 'സുരക്ഷിതരായിരിക്കാൻ';

  @override
  String get helpGuideGroupPayloads => 'സ്കാൻ ചെയ്തവ ഉപയോഗിക്കാൻ';

  @override
  String get helpGuideGroupApp => 'ആപ്പും ക്രമീകരണങ്ങളും';

  @override
  String get helpGuideBarcodeName => 'കോഡുകൾ സ്കാൻ ചെയ്യൽ';

  @override
  String get helpGuideBarcodeSummary =>
      'ക്യാമറ കൊണ്ടോ, ഫോട്ടോ, PDF ഫയൽ, പകർത്തിയ വാചകം എന്നിവയിൽ നിന്നോ സ്കാൻ ചെയ്യുക. പല കോഡുകൾ ഒന്നിനു പിന്നാലെ ഒന്നായി സ്കാൻ ചെയ്യുക.';

  @override
  String get helpGuideBarcodeIntro =>
      'ക്യാമറ ഒരു കോഡിനു നേരെ പിടിച്ചാൽ ആപ്പ് ഉടൻ അത് വായിക്കും. ഫോട്ടോകൾ, PDF ഫയലുകൾ, പകർത്തിയ വാചകം എന്നിവയിൽ നിന്നും കോഡുകൾ വായിക്കാം. എല്ലാം നിങ്ങളുടെ ഫോണിൽത്തന്നെ നടക്കുന്നു; ഇന്റർനെറ്റ് ആവശ്യമില്ല.';

  @override
  String get helpGuideBarcodeCameraTitle => 'ക്യാമറ കൊണ്ട് സ്കാൻ ചെയ്യുക';

  @override
  String get helpGuideBarcodeCameraBullet1 =>
      'സ്കാൻ ടാബ് തുറന്ന്, കോഡ് ഫ്രെയിമിനുള്ളിൽ വരുന്ന വിധം പിടിക്കുക. ആപ്പ് സ്വയം അത് വായിക്കും. ഒന്നും തൊടേണ്ടതില്ല.';

  @override
  String get helpGuideBarcodeCameraBullet2 =>
      'QR കോഡുകൾ (ചെറിയ Micro QR, rMQR എന്നിവയും), Data Matrix, Aztec, PDF417, MaxiCode എന്നിവ വായിക്കും. കടകളിലും പാഴ്സലുകളിലും കാണുന്ന EAN, UPC, Code 128, Code 39, Code 93, Codabar, ITF, DataBar ബാർകോഡുകളും വായിക്കും.';

  @override
  String get helpGuideBarcodeCameraBullet3 =>
      'ഫ്ലാഷ്: ഫ്ലാഷ് ബട്ടൺ തൊട്ട് ഓഫ്, ഓൺ, സ്വയം എന്നിവയ്ക്കിടയിൽ മാറ്റുക. ‘സ്വയം’ ആണെങ്കിൽ ഇരുട്ടാകുമ്പോൾ ഫ്ലാഷ് തനിയെ തെളിയും.';

  @override
  String get helpGuideBarcodeCameraBullet4 =>
      'സൂം: ചെറുതോ ദൂരെയുള്ളതോ ആയ കോഡുകൾക്ക് സൂം സ്ലൈഡർ ഉപയോഗിക്കുക. ഫോൺ വളരെ അടുപ്പിക്കുന്നതിനേക്കാൾ നന്നായി ഇതു പ്രവർത്തിക്കും.';

  @override
  String get helpGuideBarcodeCameraBullet5 =>
      'ക്യാമറ മാറ്റുക: പിൻ ക്യാമറയ്ക്കും മുൻ ക്യാമറയ്ക്കും ഇടയിൽ മാറ്റുക.';

  @override
  String get helpGuideBarcodeCameraBullet6 =>
      'നിർത്തിവയ്ക്കൽ: അൽപനേരം നിർത്താൻ ‘സ്കാനിംഗ് നിർത്തിവയ്ക്കുക’, വീണ്ടും തുടങ്ങാൻ ‘സ്കാനിംഗ് തുടരുക’ തൊടുക.';

  @override
  String get helpGuideBarcodeGalleryTitle =>
      'ഫോട്ടോയോ സ്ക്രീൻഷോട്ടോ സ്കാൻ ചെയ്യുക';

  @override
  String get helpGuideBarcodeGalleryBullet1 =>
      'സ്കാൻ സ്ക്രീനിന്റെ മുകളിലെ ഗാലറി ബട്ടൺ തൊട്ട് ഒരു ഫോട്ടോയോ സ്ക്രീൻഷോട്ടോ തിരഞ്ഞെടുക്കുക.';

  @override
  String get helpGuideBarcodeGalleryBullet2 =>
      'Android-ന്റെ സ്വന്തം പിക്കർ തുറക്കും. നിങ്ങൾ തിരഞ്ഞെടുക്കുന്ന ആ ഒരു ചിത്രം മാത്രമേ ആപ്പ് കാണൂ.';

  @override
  String get helpGuideBarcodeGalleryBullet3 =>
      'ചിത്രത്തിൽ ഒന്നിലധികം കോഡുകൾ ഉണ്ടെങ്കിൽ ആപ്പ് എല്ലാം കണ്ടെത്തും.';

  @override
  String get helpGuideBarcodePdfTitle => 'PDF ഫയൽ സ്കാൻ ചെയ്യുക';

  @override
  String get helpGuideBarcodePdfBullet1 =>
      'PDF ബട്ടൺ തൊട്ട്, ടിക്കറ്റ്, ബിൽ, ബോർഡിംഗ് പാസ് പോലുള്ള ഒരു ഫയൽ തിരഞ്ഞെടുക്കുക.';

  @override
  String get helpGuideBarcodePdfBullet2 =>
      'ആപ്പ് ഓരോ താളും പരിശോധിച്ച്, കണ്ടെത്തുന്ന ഓരോ കോഡും അതിന്റെ താൾ നമ്പറോടെ കാണിക്കും.';

  @override
  String get helpGuideBarcodePdfBullet3 =>
      'എല്ലാം ഒരുമിച്ച് നാൾവഴിയിൽ സൂക്ഷിക്കാൻ ‘എല്ലാം സൂക്ഷിക്കുക’ തൊടുക.';

  @override
  String get helpGuideBarcodePdfBullet4 =>
      'ഇമെയിൽ, ഫയൽ ആപ്പ് പോലുള്ള മറ്റൊരു ആപ്പിൽ നിന്ന് PDF ഈ ആപ്പിലേക്ക് പങ്കിട്ടും സ്കാൻ ചെയ്യാം.';

  @override
  String get helpGuideBarcodeClipboardTitle =>
      'പകർത്തിയ വാചകമോ ചിത്രമോ സ്കാൻ ചെയ്യുക';

  @override
  String get helpGuideBarcodeClipboardBullet1 =>
      'ഒരു ലിങ്കോ കോഡിലെ വാചകമോ ചിത്രമോ പകർത്തിയിട്ടുണ്ടെങ്കിൽ, അതു പരിശോധിക്കാൻ സ്കാൻ സ്ക്രീനിന്റെ മുകളിലെ ക്ലിപ്പ്ബോർഡ് ബട്ടൺ തൊടുക.';

  @override
  String get helpGuideBarcodeClipboardBullet2 =>
      'എന്തെങ്കിലും പകർത്തിയ ശേഷം ആപ്പിലേക്ക് തിരികെ വരുമ്പോൾ, അതു പരിശോധിക്കണോ എന്ന് ഒരു ചെറിയ പട്ട ചോദിച്ചേക്കാം. ‘ഇപ്പോൾ സ്കാൻ ചെയ്യുക’ തൊടുക, അല്ലെങ്കിൽ പട്ട അടയ്ക്കുക.';

  @override
  String get helpGuideBarcodeClipboardBullet3 =>
      'സ്കാൻ ചെയ്ത ലിങ്കുകൾക്കുള്ള അതേ സുരക്ഷാ പരിശോധന പകർത്തിയ ലിങ്കുകൾക്കും നടക്കും.';

  @override
  String get helpGuideBarcodeBatchTitle =>
      'പല കോഡുകൾ തുടർച്ചയായി സ്കാൻ ചെയ്യുക';

  @override
  String get helpGuideBarcodeBatchBullet1 =>
      'ബാച്ച് മോഡ് ഓണാക്കാൻ ബാച്ച് ബട്ടൺ തൊടുക. ക്യാമറ സ്കാൻ ചെയ്തുകൊണ്ടേയിരിക്കും, ഓരോ പുതിയ കോഡും ഒരു പട്ടികയിൽ ചേരും.';

  @override
  String get helpGuideBarcodeBatchBullet2 =>
      'എത്ര കോഡുകൾ സ്കാൻ ചെയ്തു എന്ന് ഒരു എണ്ണം കാണിക്കും. പട്ടിക തുറക്കാൻ അതിൽ തൊടുക.';

  @override
  String get helpGuideBarcodeBatchBullet3 =>
      'പട്ടികയിൽ ഓരോ കോഡും കാണാം, ‘ഡ്യൂപ്ലിക്കേറ്റുകൾ ഒഴിവാക്കുക’ ഓണാക്കാം, പട്ടിക CSV, JSON, ടെക്സ്റ്റ്, PDF ആയി കയറ്റുമതി ചെയ്യാം.';

  @override
  String get helpGuideBarcodeBatchBullet4 =>
      'സാധാരണ സ്കാനിംഗിലേക്ക് മടങ്ങാൻ ബാച്ച് ബട്ടൺ വീണ്ടും തൊടുക.';

  @override
  String get helpGuideBarcodeTuneTitle => 'കോഡ് വായിക്കാൻ പ്രയാസമാകുമ്പോൾ';

  @override
  String get helpGuideBarcodeTuneBullet1 =>
      '‘ക്യാമറ ക്രമീകരണങ്ങൾ’ ബട്ടൺ തൊടുക. മാറ്റങ്ങൾ ക്യാമറ ദൃശ്യത്തിൽ ഉടൻ കാണാം.';

  @override
  String get helpGuideBarcodeTuneBullet2 =>
      'തെളിച്ചം, കോൺട്രാസ്റ്റ്: ഇരുണ്ടതോ മങ്ങിയതോ ആയ കോഡ് കൂടുതൽ വ്യക്തമാക്കുന്നു.';

  @override
  String get helpGuideBarcodeTuneBullet3 =>
      'നിറങ്ങൾ വിപരീതമാക്കുക: ഇരുണ്ട പശ്ചാത്തലത്തിലെ തെളിഞ്ഞ കോഡിന്, ഉദാഹരണത്തിന് ഇരുണ്ട സ്ക്രീനിലോ ലോഹത്തിലോ ഉള്ളവയ്ക്ക്.';

  @override
  String get helpGuideBarcodeTuneBullet4 =>
      'ക്യാമറ റെസല്യൂഷൻ: മിക്ക ഫോണുകൾക്കും 1080p നല്ലത്. 720p ബാറ്ററി ലാഭിക്കും. വളരെ ചെറിയ കോഡുകൾക്ക് ‘പരമാവധി’ സഹായിക്കും.';

  @override
  String get helpGuideBarcodeTuneBullet5 =>
      'ദൂര സ്കാൻ സഹായം: പോസ്റ്ററുകളിലും ബോർഡുകളിലും ഉള്ളതുപോലെ ദൂരെയുള്ള കോഡുകൾ വായിക്കാൻ സഹായിക്കും. ‘ദൂര സൂം’, ‘അരികുകളുടെ മൂർച്ച’ എന്നിവ കൊണ്ട് ഇതു ക്രമീകരിക്കാം.';

  @override
  String get helpGuideBarcodeTuneBullet6 =>
      'മൾട്ടി-കോഡ് സ്കാൻ: ഒന്നിലധികം കോഡുകൾ കാണുമ്പോൾ ഓരോന്നിനും ചുറ്റും ഒരു വര വരും. വേണ്ടതിൽ തൊടുക.';

  @override
  String get helpGuideBarcodeTuneBullet7 =>
      '‘ക്രമീകരണങ്ങൾ പുനഃക്രമീകരിക്കുക’ എല്ലാം പഴയപടിയാക്കും.';

  @override
  String get helpGuideBarcodeTip =>
      'നുറുങ്ങ്: കോഡുകൾ നിങ്ങളുടെ ഫോണിൽത്തന്നെ വായിക്കുന്നു. ക്യാമറ ദൃശ്യങ്ങൾ ഒരിക്കലും സൂക്ഷിക്കുകയോ എവിടേക്കും അയയ്ക്കുകയോ ചെയ്യില്ല.';

  @override
  String get helpGuideArCodeVisionName => 'AR കോഡ്‌വിഷൻ';

  @override
  String get helpGuideArCodeVisionSummary =>
      'പല കോഡുകൾ ഒരേസമയം ക്യാമറ ദൃശ്യത്തിൽത്തന്നെ കാണാനും ഉപയോഗിക്കാനും.';

  @override
  String get helpGuideArCodeVisionIntro =>
      'ക്യാമറയ്ക്ക് കാണാവുന്ന എല്ലാ കോഡുകളും AR കോഡ്‌വിഷൻ ഒരേസമയം കണ്ടെത്തും. ഓരോ കോഡിനും മുകളിൽ ഒരു ചെറിയ ലേബൽ തെളിയും; അതിനാൽ തൊടുന്നതിനു മുൻപേ അത് എന്താണെന്ന് അറിയാം.';

  @override
  String get helpGuideArCodeVisionOpenTitle => 'എങ്ങനെ തുറക്കാം';

  @override
  String get helpGuideArCodeVisionOpenBullet1 =>
      'സ്കാൻ സ്ക്രീനിൽ ‘കൂടുതൽ ഓപ്ഷനുകൾ’ (മൂന്നു കുത്തുകൾ) തൊട്ട് ‘എആർ കോഡ്‌വിഷൻ HUD’ തിരഞ്ഞെടുക്കുക.';

  @override
  String get helpGuideArCodeVisionOpenBullet2 =>
      'Android ചോദിച്ചാൽ ക്യാമറ അനുവദിക്കുക.';

  @override
  String get helpGuideArCodeVisionTrackingTitle => 'രണ്ടു മോഡുകൾ';

  @override
  String get helpGuideArCodeVisionTrackingBullet1 =>
      'സുരക്ഷ: ഓരോ ലിങ്കിനും ഒരു നിറമുള്ള അടയാളം കിട്ടും. പച്ച എന്നാൽ പ്രശ്നമൊന്നും കണ്ടില്ല. ചുവപ്പ് എന്നാൽ ലിങ്ക് സുരക്ഷിതമല്ലെന്നു തോന്നുന്നു.';

  @override
  String get helpGuideArCodeVisionTrackingBullet2 =>
      'വെയർഹൗസ്: വിലച്ചീട്ട് പോലുള്ള സാധനവിവരങ്ങൾ കാണിക്കും, കോഡുകൾ തിരഞ്ഞെടുക്കാനും കഴിയും.';

  @override
  String get helpGuideArCodeVisionBatchTitle => 'ലേബലുകൾ ഉപയോഗിക്കാൻ';

  @override
  String get helpGuideArCodeVisionBatchBullet1 =>
      'മുഴുവൻ ഉള്ളടക്കം കാണാൻ ഒരു ലേബലിൽ തൊടുക. അവിടെനിന്ന് അതു പകർത്താം, ലിങ്ക് തുറക്കാം, അല്ലെങ്കിൽ തിരഞ്ഞെടുക്കാം.';

  @override
  String get helpGuideArCodeVisionBatchBullet2 =>
      'വെയർഹൗസ് മോഡിൽ കുറെ കോഡുകൾ തിരഞ്ഞെടുത്ത്, എല്ലാം ഒരുമിച്ച് പകർത്താൻ ‘മൊത്തമായി പകർത്തുക’ തൊടുക. വീണ്ടും തുടങ്ങാൻ ‘മായ്ക്കുക’ തൊടുക.';

  @override
  String get helpGuideArCodeVisionBatchBullet3 =>
      'ഇരുട്ടാണെങ്കിൽ ഫ്ലാഷ്‌ലൈറ്റ് ബട്ടൺ തൊടുക.';

  @override
  String get helpGuideArCodeVisionTip =>
      'നുറുങ്ങ്: ഫോൺ പതുക്കെ നീക്കുക. നീക്കുമ്പോൾ ലേബലുകൾ കോഡുകളെ പിന്തുടരും.';

  @override
  String get helpGuideScanBubbleName => 'മറ്റ് ആപ്പുകളിൽ നിന്ന് സ്കാൻ ചെയ്യുക';

  @override
  String get helpGuideScanBubbleSummary =>
      'മറ്റൊരു ആപ്പിൽ സ്ക്രീനിൽ കാണുന്ന കോഡ് ഗോസ്റ്റ്സ്കാൻ അല്ലെങ്കിൽ സ്കാൻ ബബിൾ ഉപയോഗിച്ച് വായിക്കുക.';

  @override
  String get helpGuideScanBubbleIntro =>
      'ചിലപ്പോൾ ഒരു കോഡ് ചാറ്റിലോ വെബ് പേജിലോ ഇമെയിലിലോ നിങ്ങളുടെ സ്ക്രീനിൽ കാണും. സ്ക്രീൻഷോട്ട് എടുക്കാതെ രണ്ടു വിധത്തിൽ അതു വായിക്കാം: ഗോസ്റ്റ്സ്കാൻ, സ്കാൻ ബബിൾ. രണ്ടും ഇന്റർനെറ്റ് ഇല്ലാതെ നിങ്ങളുടെ ഫോണിൽത്തന്നെ കോഡ് വായിക്കും.';

  @override
  String get helpGuideScanBubbleGhostTitle =>
      'ഗോസ്റ്റ്സ്കാൻ: സ്ക്രീൻ ഒരു തവണ സ്കാൻ ചെയ്യുക';

  @override
  String get helpGuideScanBubbleGhostBullet1 =>
      'സ്കാൻ സ്ക്രീനിൽ ‘കൂടുതൽ ഓപ്ഷനുകൾ’ തൊട്ട് ‘ഗോസ്റ്റ്സ്കാൻ’ തിരഞ്ഞെടുക്കുക.';

  @override
  String get helpGuideScanBubbleGhostBullet2 =>
      'ക്വിക്ക് സെറ്റിങ്സിൽ (സ്ക്രീനിന്റെ മുകളിൽ നിന്ന് താഴേക്ക് വലിക്കുന്ന പാനൽ) ഒരു ഗോസ്റ്റ്സ്കാൻ ബട്ടൺ വയ്ക്കാൻ ‘ക്വിക്ക് സെറ്റിങ്സ് ടൈൽ ചേർക്കുക’ തൊടുക.';

  @override
  String get helpGuideScanBubbleGhostBullet3 =>
      'പിന്നെ, ഏത് ആപ്പിലായാലും ക്വിക്ക് സെറ്റിങ്സ് താഴേക്ക് വലിച്ച് ഗോസ്റ്റ്സ്കാൻ ടൈൽ തൊടുക. സ്ക്രീനിലെ കോഡ് ആപ്പ് വായിക്കും.';

  @override
  String get helpGuideScanBubbleUseTitle => 'സ്കാൻ ബബിൾ എങ്ങനെ ഉപയോഗിക്കാം';

  @override
  String get helpGuideScanBubbleUseBullet1 =>
      'ക്രമീകരണങ്ങൾ > സ്കാൻ ബബിൾ, ക്വിക്ക് സെറ്റിങ്സിലെ സ്കാൻ ബബിൾ ടൈൽ, അല്ലെങ്കിൽ ആപ്പ് ഐക്കൺ അമർത്തിപ്പിടിക്കൽ എന്നിവയിലൂടെ ഇത് ഓണാക്കാം.';

  @override
  String get helpGuideScanBubbleUseBullet2 =>
      'ക്യുആർ കോഡോ ബാർകോഡോ കാണിക്കുന്ന ഏതെങ്കിലും ആപ്പ് തുറന്ന് ബബിളിൽ തൊടുക.';

  @override
  String get helpGuideScanBubbleUseBullet3 =>
      'സ്ക്രീൻ പകർത്താൻ Android അനുമതി ചോദിക്കും. അനുവദിച്ചാൽ, സാധാരണ സുരക്ഷാ പരിശോധനകളോടെ ഫലം തുറക്കും.';

  @override
  String get helpGuideScanBubbleUseBullet4 =>
      'ബബിൾ നീക്കാൻ അതു വലിക്കുക. ഓഫാക്കാൻ സ്ക്രീനിന്റെ താഴെയുള്ള X-ലേക്ക് വലിച്ചിടുക.';

  @override
  String get helpGuideScanBubbleUseBullet5 =>
      'ഫോൺ റീസ്റ്റാർട്ട് ചെയ്ത ശേഷവും ബബിൾ തിരികെ വരണമെങ്കിൽ ‘റീസ്റ്റാർട്ടിനു ശേഷം തുടങ്ങുക’ ഓണാക്കുക.';

  @override
  String get helpGuideScanBubblePrivacyTitle => 'സ്വകാര്യത';

  @override
  String get helpGuideScanBubblePrivacyBullet1 =>
      'നിങ്ങൾ ബബിളിലോ ഗോസ്റ്റ്സ്കാൻ ടൈലിലോ തൊടുമ്പോൾ മാത്രമേ സ്ക്രീൻ പകർത്തുകയുള്ളൂ; Android ആദ്യം നിങ്ങളോടു ചോദിക്കും.';

  @override
  String get helpGuideScanBubblePrivacyBullet2 =>
      'കോഡ് നിങ്ങളുടെ ഫോണിൽത്തന്നെ വായിക്കുന്നു. വായിക്കാനായി ഒന്നും ഓൺലൈനിൽ അയയ്ക്കുന്നില്ല.';

  @override
  String get helpGuideScanBubblePrivacyBullet3 =>
      'സ്ക്രീൻ ചിത്രം ഗാലറിയിൽ സൂക്ഷിക്കുന്നില്ല, വായിച്ച ഉടനെ മായ്ക്കുന്നു.';

  @override
  String get helpGuideScanBubbleLimitsTitle => 'അറിഞ്ഞിരിക്കേണ്ടവ';

  @override
  String get helpGuideScanBubbleLimitsBullet1 =>
      'Android 14-ലും പുതിയവയിലും, ഓരോ തവണ തൊടുമ്പോഴും സ്ക്രീൻ പകർത്താനുള്ള അനുമതി ചോദിക്കും.';

  @override
  String get helpGuideScanBubbleLimitsBullet2 =>
      'ബാങ്കിംഗ്, പണമിടപാട്, ചില വീഡിയോ ആപ്പുകൾ സ്ക്രീൻ പകർത്തുന്നത് തടയുന്നു. അവയിലെ കോഡുകൾ വായിക്കാനാവില്ല.';

  @override
  String get helpGuideScanBubbleLimitsBullet3 =>
      'ചില ഫോണുകളിൽ ബബിളിനെ മറയ്ക്കാനോ നിർത്താനോ കഴിയുന്ന അധിക \"പോപ്പ്-അപ്പ് വിൻഡോ\" അല്ലെങ്കിൽ ബാറ്ററി ക്രമീകരണങ്ങൾ ഉണ്ട്.';

  @override
  String get helpGuideScanBubbleTip =>
      'നുറുങ്ങ്: സ്കാൻ ബബിൾ ടൈൽ ക്വിക്ക് സെറ്റിങ്സിൽ ചേർക്കുക. പിന്നെ ഏത് ആപ്പിൽ നിന്നും ഒറ്റ തൊടലിൽ ബബിൾ ഓണാക്കാനും ഓഫാക്കാനും കഴിയും.';

  @override
  String get helpGuideCodeForgeName => 'കോഡുകൾ നിർമ്മിക്കാൻ (കോഡ്ഫോർജ്)';

  @override
  String get helpGuideCodeForgeSummary =>
      'സ്വന്തം QR കോഡുകളും ബാർകോഡുകളും നിർമ്മിക്കുക, അവയുടെ രൂപം മാറ്റുക, പങ്കിടുക.';

  @override
  String get helpGuideCodeForgeIntro =>
      'നിങ്ങളുടെ വൈ-ഫൈ, വിലാസവിവരം, ഒരു ലിങ്ക്, UPI പണമിടപാട് തുടങ്ങിയവയ്ക്കായി സ്വന്തം QR കോഡോ ബാർകോഡോ കോഡ്ഫോർജിൽ നിർമ്മിക്കാം. അതിന്റെ നിറവും രൂപവും മാറ്റി ഒരു ചിത്രമായി പങ്കിടാം.';

  @override
  String get helpGuideCodeForgeTypeTitle =>
      '1. എന്തു ചേർക്കണമെന്നു തിരഞ്ഞെടുക്കുക';

  @override
  String get helpGuideCodeForgeTypeBullet1 =>
      'സ്ക്രീനിന്റെ താഴെയുള്ള ‘കോഡ്ഫോർജ്’ ടാബ് തുറക്കുക.';

  @override
  String get helpGuideCodeForgeTypeBullet2 =>
      'കോഡിന്റെ തരം തിരഞ്ഞെടുക്കുക: ക്യുആർ കോഡ്, അല്ലെങ്കിൽ Code 128, EAN-13, EAN-8, UPC-A, Code 39, PDF417, Data Matrix പോലുള്ള ബാർകോഡ്.';

  @override
  String get helpGuideCodeForgeTypeBullet3 =>
      'QR കോഡിൽ എന്തു വേണമെന്നു തിരഞ്ഞെടുക്കുക: ടെക്സ്റ്റ്, ലിങ്ക്, വൈ-ഫൈ, കോൺടാക്റ്റ്, യുപിഐ, എസ്എംഎസ്, ഇമെയിൽ, ലൊക്കേഷൻ.';

  @override
  String get helpGuideCodeForgeTypeBullet4 =>
      'കള്ളികൾ പൂരിപ്പിക്കുക. ടൈപ്പ് ചെയ്യുന്നതിനൊപ്പം പ്രിവ്യൂ മാറും.';

  @override
  String get helpGuideCodeForgeTypeBullet5 =>
      'ടെക്സ്റ്റിനായി, ഒരു ഫയലിൽ നിന്ന് വാചകം എടുക്കാൻ ‘ഫയലിൽ നിന്ന് ചേർക്കുക’ തൊടുകയുമാവാം (500 അക്ഷരം വരെ).';

  @override
  String get helpGuideCodeForgeTypeBullet6 =>
      'ലൊക്കേഷനായി, നിങ്ങൾ ഇപ്പോൾ എവിടെയാണോ അതു ചേർക്കാൻ ‘എന്റെ ലൊക്കേഷൻ’ തൊടുക. ആ നിമിഷം മാത്രമേ ആപ്പ് ലൊക്കേഷൻ ചോദിക്കൂ; അതു സൂക്ഷിക്കില്ല.';

  @override
  String get helpGuideCodeForgeStyleTitle => '2. രൂപം മാറ്റുക';

  @override
  String get helpGuideCodeForgeStyleBullet1 =>
      'രൂപകൽപ്പന: വലിയ മൂലച്ചതുരങ്ങൾ, അവയുടെ നടുഭാഗം, ചെറിയ കുത്തുകൾ എന്നിവയുടെ ആകൃതി തിരഞ്ഞെടുക്കുക.';

  @override
  String get helpGuideCodeForgeStyleBullet2 =>
      'വർണ്ണങ്ങൾ: കോഡിന്റെ നിറവും പശ്ചാത്തലവും, അല്ലെങ്കിൽ ‘സൂര്യാസ്തമയം’, ‘സമുദ്രം’ പോലുള്ള നിറക്കൂട്ട് തിരഞ്ഞെടുക്കുക.';

  @override
  String get helpGuideCodeForgeStyleBullet3 =>
      'നിറങ്ങൾ തമ്മിൽ നല്ല വ്യത്യാസം വേണം. തെളിഞ്ഞ പശ്ചാത്തലത്തിൽ ഇരുണ്ട കോഡാണ് ഏറ്റവും നന്നായി സ്കാൻ ആകുന്നത്.';

  @override
  String get helpGuideCodeForgeStyleBullet4 =>
      'ചിഹ്നം: കോഡിന്റെ നടുവിൽ ഒരു ചെറിയ ചിഹ്നം വയ്ക്കുക.';

  @override
  String get helpGuideCodeForgeStyleBullet5 =>
      'പിശക് തിരുത്തൽ: കോഡിന് എത്ര കേടുപാട് പറ്റിയാലും സ്കാൻ ആകും എന്നത്. L ഏകദേശം 7%, M 15%, Q 25%, H 30% വരെ താങ്ങും. ഉയർന്ന നിലയിൽ കോഡിൽ കുത്തുകൾ കൂടും. നടുവിൽ ചിഹ്നം ചേർക്കുമ്പോൾ H തിരഞ്ഞെടുക്കുക.';

  @override
  String get helpGuideCodeForgeStyleBullet6 =>
      '‘വാചകം കാണിക്കുക’ ബാർകോഡിനു താഴെ അതിലെ വാചകം കാണിക്കും. ‘ഡിസൈൻ മാറ്റുക’ രൂപം പഴയപടിയാക്കും.';

  @override
  String get helpGuideCodeForgeShareTitle => '3. പരിശോധിച്ച് പങ്കിടുക';

  @override
  String get helpGuideCodeForgeShareBullet1 =>
      'ലിങ്ക് ആണെങ്കിൽ, പങ്കിടുന്നതിനു മുൻപ് അതിന്റെ സുരക്ഷ നോക്കാൻ ‘പരിശോധിക്കുക’ തൊടുക.';

  @override
  String get helpGuideCodeForgeShareBullet2 =>
      'സാധാരണ ചിത്രമായി പങ്കിടാൻ ‘പിഎൻജി പങ്കിടുക’, ഏതു വലുപ്പത്തിലും വ്യക്തമായി അച്ചടിക്കാവുന്ന ചിത്രത്തിന് ‘എസ്വിജി പങ്കിടുക’ തൊടുക.';

  @override
  String get helpGuideCodeForgeShareBullet3 =>
      'കോഡിനുള്ളിലെ വാചകം പകർത്താൻ ‘പകർത്തുക’ ബട്ടൺ തൊടുക.';

  @override
  String get helpGuideCodeForgeTip =>
      'നുറുങ്ങ്: ധാരാളം പകർപ്പുകൾ അച്ചടിക്കുന്നതിനു മുൻപ്, പുതിയ കോഡ് നന്നായി വായിക്കുന്നുണ്ടോ എന്ന് ഈ ആപ്പ് കൊണ്ട് ഒരിക്കൽ സ്കാൻ ചെയ്തു നോക്കുക.';

  @override
  String get helpGuideAirQrName =>
      'എയർ ക്യുആർ: നെറ്റ്‌വർക്ക് ഇല്ലാതെ വിവരങ്ങൾ അയയ്ക്കാം';

  @override
  String get helpGuideAirQrSummary =>
      'ചലിക്കുന്ന QR കോഡുകൾ വഴി വാചകം അയയ്ക്കുക, അല്ലെങ്കിൽ ആപ്പിലെ വിവരങ്ങൾ മറ്റൊരു ഫോണിലേക്ക് മാറ്റുക. വൈ-ഫൈയോ ബ്ലൂടൂത്തോ കേബിളോ വേണ്ട.';

  @override
  String get helpGuideAirQrIntro =>
      'സ്ക്രീനും ക്യാമറയും മാത്രം ഉപയോഗിച്ച് എയർ ക്യുആർ ഒരു ഫോണിൽ നിന്ന് മറ്റൊന്നിലേക്ക് വിവരങ്ങൾ അയയ്ക്കുന്നു. അയയ്ക്കുന്ന ഫോൺ വേഗത്തിൽ മാറുന്ന QR കോഡുകൾ കാണിക്കും. സ്വീകരിക്കുന്ന ഫോൺ അവ കണ്ട് വീണ്ടും ഒന്നായി ചേർക്കും. ഒരു നെറ്റ്‌വർക്കും ഉപയോഗിക്കുന്നില്ല.';

  @override
  String get helpGuideAirQrStreamingTitle => 'എങ്ങനെ അയയ്ക്കാം';

  @override
  String get helpGuideAirQrStreamingBullet1 =>
      'അയയ്ക്കുന്ന ഫോണിൽ സ്കാൻ > കൂടുതൽ ഓപ്ഷനുകൾ > എയർ ക്യുആർ റിസീവർ തുറന്ന്, മുകളിലെ എയർ ക്യുആർ ട്രാൻസ്മിറ്റർ ബട്ടൺ തൊടുക.';

  @override
  String get helpGuideAirQrStreamingBullet2 =>
      'അയയ്ക്കേണ്ടത് ‘അയയ്ക്കേണ്ട വിവരങ്ങൾ’ എന്നതിൽ ടൈപ്പ് ചെയ്യുകയോ ഒട്ടിക്കുകയോ ചെയ്യുക.';

  @override
  String get helpGuideAirQrStreamingBullet3 =>
      '‘സ്ട്രീം വേഗത’ (സെക്കൻഡിൽ 5 മുതൽ 25 വരെ ചിത്രങ്ങൾ) തിരഞ്ഞെടുത്ത് ‘പ്രക്ഷേപണം ആരംഭിക്കുക’ തൊടുക.';

  @override
  String get helpGuideAirQrStreamingBullet4 =>
      'അയയ്ക്കുന്ന സ്ക്രീനിന് നല്ല തെളിച്ചം വേണം; അത് അനക്കാതെ പിടിക്കുക.';

  @override
  String get helpGuideAirQrControlsTitle => 'എങ്ങനെ സ്വീകരിക്കാം';

  @override
  String get helpGuideAirQrControlsBullet1 =>
      'മറ്റേ ഫോണിൽ സ്കാൻ > കൂടുതൽ ഓപ്ഷനുകൾ > എയർ ക്യുആർ റിസീവർ തുറന്ന്, ക്യാമറ അയയ്ക്കുന്ന സ്ക്രീനിനു നേരെ പിടിക്കുക.';

  @override
  String get helpGuideAirQrControlsBullet2 =>
      'എത്ര ഭാഗങ്ങൾ എത്തി, ഇനിയും എത്ര കിട്ടാനുണ്ട് എന്ന് ഒരു പുരോഗതി വര കാണിക്കും.';

  @override
  String get helpGuideAirQrControlsBullet3 =>
      'ചില ഭാഗങ്ങൾ വിട്ടുപോയാലും പ്രശ്നമില്ല. വിടവുകൾ നികത്താൻ എയർ ക്യുആർ അധിക ‘പരിഹാര’ ഭാഗങ്ങളും അയയ്ക്കുന്നു.';

  @override
  String get helpGuideAirQrControlsBullet4 =>
      'എല്ലാ ഭാഗങ്ങളും എത്തുമ്പോൾ ആപ്പ് വിവരങ്ങൾ പരിശോധിച്ച് ‘കൈമാറ്റം പൂർത്തിയായി!’ എന്നു കാണിക്കും. അവിടെനിന്ന് വിവരങ്ങൾ പകർത്താം.';

  @override
  String get helpGuideAirQrSyncTitle => 'വിവരങ്ങൾ പുതിയ ഫോണിലേക്ക് മാറ്റുക';

  @override
  String get helpGuideAirQrSyncBullet1 =>
      'പഴയ ഫോണിൽ ക്രമീകരണങ്ങൾ > എയർക്യുആർ സിങ്ക് തുറക്കുക. നാൾവഴിയോ ആപ്പ് ക്രമീകരണങ്ങളോ രണ്ടുമോ തിരഞ്ഞെടുക്കുക.';

  @override
  String get helpGuideAirQrSyncBullet2 =>
      'ഒരു രഹസ്യവാക്കോ പിൻ നമ്പറോ ടൈപ്പ് ചെയ്യുക, അല്ലെങ്കിൽ ‘പിൻ നിർമ്മിക്കുക’ തൊടുക. ഇതു വിവരങ്ങൾ പൂട്ടും; പിൻ അറിയുന്നവർക്കു മാത്രമേ തുറക്കാനാകൂ.';

  @override
  String get helpGuideAirQrSyncBullet3 =>
      '‘എയർക്യുആർ വഴി അയക്കുക’ തൊട്ട്, പുതിയ ഫോണിൽ എയർ ക്യുആർ റിസീവർ കൊണ്ട് സ്വീകരിക്കുക.';

  @override
  String get helpGuideAirQrSyncBullet4 =>
      'പുതിയ ഫോണിൽ അതേ രഹസ്യവാക്കോ പിൻ നമ്പറോ ടൈപ്പ് ചെയ്ത് ‘ഡീക്രിപ്റ്റ് ചെയ്തു് സിങ്ക് ചെയ്യുക’ തൊടുക.';

  @override
  String get helpGuideAirQrSecurityTitle => 'എന്തുകൊണ്ട് സ്വകാര്യം';

  @override
  String get helpGuideAirQrSecurityBullet1 =>
      'റേഡിയോ സിഗ്നലുകൾ ഒന്നും ഉപയോഗിക്കുന്നില്ല: വൈ-ഫൈ, ബ്ലൂടൂത്ത്, മൊബൈൽ ഡാറ്റ, ഇന്റർനെറ്റ് ഒന്നും വേണ്ട.';

  @override
  String get helpGuideAirQrSecurityBullet2 =>
      'നെറ്റ്‌വർക്ക് വഴി ആർക്കും ഈ വിവരങ്ങൾ പിടിച്ചെടുക്കാനാവില്ല. സ്ക്രീൻ കാണാവുന്ന ക്യാമറയ്ക്കു മാത്രമേ ഇതു വായിക്കാനാകൂ.';

  @override
  String get helpGuideAirQrSecurityBullet3 =>
      'ഓൺലൈനായി അയയ്ക്കാൻ ആഗ്രഹിക്കാത്ത പാസ്‌വേഡുകൾ, കീകൾ, മറ്റു സ്വകാര്യ വിവരങ്ങൾ എന്നിവയ്ക്ക് ഉപകാരപ്രദം.';

  @override
  String get helpGuideAirQrTip =>
      'നുറുങ്ങ്: അയയ്ക്കുന്ന ഫോണിന്റെ തെളിച്ചം കൂട്ടുക, സ്വീകരിക്കുന്ന ഫോൺ അനക്കാതെ പിടിക്കുക. ഭാഗങ്ങൾ വിട്ടുപോകുന്നുണ്ടെങ്കിൽ വേഗത കുറയ്ക്കുക.';

  @override
  String get helpGuideUrlSafetyName => 'ലിങ്ക് സുരക്ഷാ പരിശോധന';

  @override
  String get helpGuideUrlSafetySummary =>
      'തുറക്കുന്നതിനു മുൻപ് ആപ്പ് ഓരോ ലിങ്കും എങ്ങനെ പരിശോധിക്കുന്നു, ഫലത്തിന്റെ അർഥം എന്ത്.';

  @override
  String get helpGuideUrlSafetyIntro =>
      'തട്ടിപ്പ് QR കോഡുകൾ പലപ്പോഴും വ്യാജ വെബ്സൈറ്റുകളിലേക്കാണ് കൊണ്ടുപോകുന്നത്. അതിനാൽ ഏതു ലിങ്കും തുറക്കുന്നതിനു മുൻപ് ആപ്പ് അത് ആറു വിധത്തിൽ വരെ പരിശോധിക്കും. ആദ്യത്തെ നാലു പരിശോധനകൾ എപ്പോഴും ഇന്റർനെറ്റ് ഇല്ലാതെ നിങ്ങളുടെ ഫോണിൽത്തന്നെ നടക്കും.';

  @override
  String get helpGuideUrlSafetyLayersTitle => 'ആറു പരിശോധനകൾ';

  @override
  String get helpGuideUrlSafetyLayersBullet1 =>
      '1. സുരക്ഷിത കണക്ഷൻ: ലിങ്ക് സുരക്ഷിതമായ HTTPS ആണോ? അതിൽ വിചിത്രമോ കാണാനാകാത്തതോ ആയ അക്ഷരങ്ങൾ ഒളിപ്പിച്ചിട്ടുണ്ടോ?';

  @override
  String get helpGuideUrlSafetyLayersBullet2 =>
      '2. ഒരുപോലെ തോന്നുന്ന അക്ഷരങ്ങൾ: ചില വ്യാജ സൈറ്റുകൾ ഒരുപോലെ തോന്നുന്ന മറ്റു ലിപികളിലെ അക്ഷരങ്ങൾ ഉപയോഗിക്കും; ഉദാഹരണത്തിന് സാധാരണ \"a\"-യ്ക്കു പകരം സിറിലിക് \"а\".';

  @override
  String get helpGuideUrlSafetyLayersBullet3 =>
      '3. വിചിത്രമായ വെബ് വിലാസങ്ങൾ: അപകടസാധ്യതയുള്ള അവസാനഭാഗങ്ങൾ (.xyz, .top പോലെ), പേരിൽ വളരെയധികം ഭാഗങ്ങൾ, അല്ലെങ്കിൽ ക്രമമില്ലാത്ത അക്ഷരങ്ങൾ കൊണ്ടുള്ള പേരുകൾ.';

  @override
  String get helpGuideUrlSafetyLayersBullet4 =>
      '4. നമ്പർ വിലാസങ്ങളും അസാധാരണ പോർട്ടുകളും: വെറും നമ്പർ (IP വിലാസം) അല്ലെങ്കിൽ അസാധാരണ പോർട്ട് ഉപയോഗിക്കുന്ന ലിങ്കുകൾ; സാധാരണ കടകളും ബാങ്കുകളും ഇവ ഉപയോഗിക്കാറില്ല.';

  @override
  String get helpGuideUrlSafetyLayersBullet5 =>
      '5. സൈറ്റിന്റെ ഓൺലൈൻ പരിശോധന (ഐച്ഛികം): ചുരുക്കിയ ലിങ്കുകൾ (bit.ly പോലെ) ശരിക്കും എവിടേക്കാണ് പോകുന്നതെന്ന് നോക്കും, സൈറ്റിന്റെ സുരക്ഷാ സർട്ടിഫിക്കറ്റും പരിശോധിക്കും. ‘ഓൺലൈൻ പരിശോധനകൾ’ ഓണാക്കിയാൽ മാത്രം.';

  @override
  String get helpGuideUrlSafetyLayersBullet6 =>
      '6. അറിയപ്പെടുന്ന അപകട സൈറ്റുകളുടെ പട്ടിക (ഐച്ഛികം): ലിങ്ക് അറിയപ്പെടുന്ന തട്ടിപ്പ് അല്ലെങ്കിൽ വൈറസ് സൈറ്റ് ആണോ എന്ന് Google Safe Browsing പോലുള്ള സേവനങ്ങളോടു ചോദിക്കും. നിങ്ങൾ സജ്ജമാക്കിയാൽ മാത്രം.';

  @override
  String get helpGuideUrlSafetyVerdictsTitle => 'ഫലം എങ്ങനെ വായിക്കാം';

  @override
  String get helpGuideUrlSafetyVerdictsBullet1 =>
      'പ്രശ്നങ്ങളൊന്നുമില്ല: നടന്ന എല്ലാ പരിശോധനകളും ലിങ്ക് വിജയിച്ചു. എങ്കിലും, അറിയാവുന്ന ഉറവിടങ്ങളെ മാത്രം വിശ്വസിക്കുക.';

  @override
  String get helpGuideUrlSafetyVerdictsBullet2 =>
      'പ്രശ്നങ്ങൾ കണ്ടെത്തി: ഏതൊക്കെ പരിശോധനകൾ പരാജയപ്പെട്ടു എന്ന് ആപ്പ് കാണിക്കും. കാരണം വായിക്കാൻ ‘വിശദാംശങ്ങൾ കാണുക’ തൊടുക.';

  @override
  String get helpGuideUrlSafetyVerdictsBullet3 =>
      'അപകടസാധ്യതയുള്ള ലിങ്ക് തുറക്കാൻ ശ്രമിച്ചാൽ ആപ്പ് ആദ്യം ചോദിക്കും. ഉറവിടം വിശ്വസനീയമാണെങ്കിൽ മാത്രം തുറക്കുക.';

  @override
  String get helpGuideUrlSafetyVerdictsBullet4 =>
      'പരിശോധനകൾ വീണ്ടും നടത്താൻ ‘വീണ്ടും പരിശോധിക്കുക’ തൊടുക; ഉദാഹരണത്തിന്, ഇന്റർനെറ്റ് കിട്ടിയ ശേഷം.';

  @override
  String get helpGuideUrlSafetyPrivacyTitle =>
      'സ്വകാര്യ മോഡും ഓൺലൈൻ പരിശോധനയും';

  @override
  String get helpGuideUrlSafetyPrivacyBullet1 =>
      'സാധാരണ നിലയിൽ ആപ്പ് ആ വെബ്സൈറ്റുമായി ഒരിക്കലും ബന്ധപ്പെടില്ല. നിങ്ങളുടെ ഫോണോ IP വിലാസമോ (ഇന്റർനെറ്റ് വിലാസം) ആ സൈറ്റിന് കാണാനാവില്ല.';

  @override
  String get helpGuideUrlSafetyPrivacyBullet2 =>
      'ക്രമീകരണങ്ങൾ > സ്വകാര്യതയും നെറ്റ്‌വർക്ക് പരിശോധനയും എന്നതിൽ ‘ഓൺലൈൻ പരിശോധനകൾ’ ഓണാക്കിയാൽ, ചുരുക്കിയ ലിങ്കുകൾ പിന്തുടരാനും സർട്ടിഫിക്കറ്റ് നോക്കാനും ആപ്പ് ആ സൈറ്റ് സന്ദർശിക്കും. ഇതു കൂടുതൽ കണ്ടെത്തും, പക്ഷേ സൈറ്റിന് നിങ്ങളുടെ IP വിലാസം കാണാം.';

  @override
  String get helpGuideUrlSafetyPrivacyBullet3 =>
      '‘ഓൺലൈൻ പരിശോധനകൾ’ ഓണാണെങ്കിൽ, ഫലത്തിൽ പേജിന്റെ ഒരു സുരക്ഷിത പ്രിവ്യൂവും കാണാം. സ്ക്രിപ്റ്റുകളും ട്രാക്കറുകളും ആദ്യമേ നീക്കുന്നതിനാൽ പേജിലെ ഒന്നും പ്രവർത്തിക്കില്ല. ‘പ്രിവ്യൂ കാണിക്കുക’ അല്ലെങ്കിൽ ‘പേജ് പരിശോധിക്കുക’ തൊടുക.';

  @override
  String get helpGuideUrlSafetyProvidersTitle => 'അധിക ഓൺലൈൻ പരിശോധകർ';

  @override
  String get helpGuideUrlSafetyProvidersBullet1 =>
      'ക്രമീകരണങ്ങൾ > URL സുരക്ഷാ ദാതാക്കൾ എന്നതിൽ കൂടുതൽ പരിശോധകരെ ഓണാക്കാം. PhishTank, OpenPhish എന്നിവയ്ക്ക് അക്കൗണ്ട് വേണ്ട.';

  @override
  String get helpGuideUrlSafetyProvidersBullet2 =>
      'Google Safe Browsing, VirusTotal, URLhaus എന്നിവയ്ക്ക് നിങ്ങളുടെ സ്വന്തം സൗജന്യ കീ വേണം. \"ഓൺലൈൻ പരിശോധകരെ സജ്ജമാക്കൽ\" എന്ന വഴികാട്ടി കാണുക.';

  @override
  String get helpGuideUrlSafetyProvidersBullet3 =>
      'ഈ പരിശോധകർക്ക് നിങ്ങൾ സ്കാൻ ചെയ്ത ലിങ്ക് മാത്രമേ കിട്ടൂ. OpenPhish വേറൊരു രീതിയിലാണ്: ആപ്പ് അതിന്റെ പട്ടിക ഡൗൺലോഡ് ചെയ്ത് ഫോണിൽത്തന്നെ പരിശോധിക്കും. നിങ്ങൾ ഓണാക്കുന്നതു വരെ ഇവയെല്ലാം ഓഫ് ആയിരിക്കും.';

  @override
  String get helpGuideUrlSafetyTip =>
      'നുറുങ്ങ്: നല്ല ഫലം ഒരു ഉറപ്പല്ല. തട്ടിപ്പുകാർ ദിവസവും പുതിയ സൈറ്റുകൾ ഉണ്ടാക്കുന്നു. പണമിടപാടിന്റെയോ ലോഗിൻ ചെയ്യുന്നതിന്റെയോ പേജ് വിചിത്രമായി തോന്നിയാൽ അത് അടയ്ക്കുക.';

  @override
  String get helpGuideQuishingName =>
      'ക്വിഷിംഗ് ഗാർഡ്: വ്യാജ സ്റ്റിക്കർ കോഡുകൾ';

  @override
  String get helpGuideQuishingSummary =>
      'യഥാർത്ഥ കോഡിനു മുകളിൽ ഒട്ടിച്ച വ്യാജ സ്റ്റിക്കർ ആയേക്കാവുന്ന QR കോഡുകൾ തിരിച്ചറിയുക.';

  @override
  String get helpGuideQuishingIntro =>
      '\"ക്വിഷിംഗ്\" എന്നാൽ QR വഴിയുള്ള തട്ടിപ്പ്. പാർക്കിംഗ് മീറ്റർ, മെനു, കടയിലെ കൗണ്ടർ, പോസ്റ്റർ എന്നിവയിലെ യഥാർത്ഥ കോഡിനു മുകളിൽ തട്ടിപ്പുകാർ സ്വന്തം QR കോഡ് ഒട്ടിക്കും; അപ്പോൾ നിങ്ങളുടെ പണമോ ലോഗിനോ അവരിലേക്കെത്തും.';

  @override
  String get helpGuideQuishingCvTitle => 'ക്വിഷിംഗ് ഗാർഡ് എന്തു കാണിക്കുന്നു';

  @override
  String get helpGuideQuishingCvBullet1 =>
      'ക്യാമറ കൊണ്ട് ലിങ്കോ പണമിടപാട് കോഡോ സ്കാൻ ചെയ്യുമ്പോൾ, ഫല സ്ക്രീനിൽ ‘സ്റ്റിക്കർ പരിശോധന’ എന്ന ചെറിയ ക്വിഷിംഗ് ഗാർഡ് കാർഡ് കാണാം.';

  @override
  String get helpGuideQuishingCvBullet2 =>
      'അതിൽ തൊട്ടാൽ ചെറിയൊരു പരിശോധനാ പട്ടിക തുറക്കും. ആപ്പ് ചിത്രത്തിൽ സ്റ്റിക്കർ തിരയുന്നില്ല, സ്കോറും നൽകുന്നില്ല; അതിനാൽ ഒരു കോഡ് സുരക്ഷിതമാണെന്ന് ഇതിനു പറയാൻ കഴിയില്ല.';

  @override
  String get helpGuideQuishingCvBullet3 =>
      'ഫോട്ടോ, ക്ലിപ്പ്ബോർഡ്, സ്ക്രീൻ സ്കാൻ, സാധാരണ എഴുത്ത് എന്നിവയ്ക്ക് ഈ കാർഡ് കാണിക്കില്ല, കാരണം അവ ചുമരിൽ ഒട്ടിച്ചവയല്ല.';

  @override
  String get helpGuideQuishingForensicTitle => 'നിങ്ങൾ എന്തു ചെയ്യണം';

  @override
  String get helpGuideQuishingForensicBullet1 =>
      'കോഡ് നോക്കുകയും വിരൽ കൊണ്ട് തൊട്ടുനോക്കുകയും ചെയ്യുക. മുകളിൽ ഒട്ടിച്ച സ്റ്റിക്കറിന് പലപ്പോഴും ഉയർന്ന അരികുകൾ ഉണ്ടാകും, അല്ലെങ്കിൽ ചരിഞ്ഞിരിക്കും.';

  @override
  String get helpGuideQuishingForensicBullet2 =>
      'പണം നൽകുന്നതിനു മുൻപ്, പണമിടപാട് സ്ക്രീനിലെ പേര് കടയുടേതു തന്നെയാണോ എന്ന് ഉറപ്പാക്കുക.';

  @override
  String get helpGuideQuishingForensicBullet3 =>
      'സംശയമുണ്ടെങ്കിൽ ജീവനക്കാരോടു ചോദിക്കുക, അല്ലെങ്കിൽ വെബ്സൈറ്റ് വിലാസം സ്വയം ടൈപ്പ് ചെയ്യുക.';

  @override
  String get helpGuideQuishingTip =>
      'നുറുങ്ങ്: ക്വിഷിംഗ് ഗാർഡ് ഒരു സഹായി മാത്രമാണ്, ഉറപ്പല്ല. നിങ്ങളുടെ കണ്ണും വിരലുമാണ് ഏറ്റവും നല്ല പരിശോധന.';

  @override
  String get helpGuideSafeBrowsingName => 'ഓൺലൈൻ പരിശോധകരെ സജ്ജമാക്കൽ';

  @override
  String get helpGuideSafeBrowsingSummary =>
      'അധിക ലിങ്ക് പരിശോധനകൾ ഓണാക്കുക, Google Safe Browsing-നുള്ള സൗജന്യ കീ നേടുക.';

  @override
  String get helpGuideSafeBrowsingIntro =>
      'സ്കാൻ ചെയ്ത ലിങ്കിനെ അറിയപ്പെടുന്ന തട്ടിപ്പ്, വൈറസ് സൈറ്റുകളുടെ പട്ടികകളുമായി ഓൺലൈൻ പരിശോധകർ താരതമ്യം ചെയ്യുന്നു. ഇവ ഐച്ഛികമാണ്. ഇവ ഇല്ലാതെയും ആപ്പിന്റെ സ്വന്തം പരിശോധനകൾ പ്രവർത്തിക്കും.';

  @override
  String get helpGuideSafeBrowsingBuiltInTitle => 'അക്കൗണ്ട് വേണ്ട';

  @override
  String get helpGuideSafeBrowsingBuiltInBullet1 =>
      'ക്രമീകരണങ്ങൾ > URL സുരക്ഷാ ദാതാക്കൾ തുറക്കുക.';

  @override
  String get helpGuideSafeBrowsingBuiltInBullet2 =>
      'PhishTank-ന്റെ തട്ടിപ്പ് സൈറ്റ് പട്ടികയുമായി ലിങ്കുകൾ ഒത്തുനോക്കാൻ ‘PhishTank പ്രവർത്തനക്ഷമമാക്കുക’ ഓണാക്കുക.';

  @override
  String get helpGuideSafeBrowsingBuiltInBullet3 =>
      '‘OpenPhish ഫീഡ് ഉപയോഗിക്കുക’ ഓണാക്കുക. ആപ്പ് OpenPhish-ന്റെ പട്ടിക ഡൗൺലോഡ് ചെയ്ത് ലിങ്കുകൾ ഫോണിൽത്തന്നെ പരിശോധിക്കും. പുതിയ പട്ടിക കിട്ടാൻ ‘ഫീഡ് ഇപ്പോൾ പുതുക്കുക’ തൊടുക.';

  @override
  String get helpGuideSafeBrowsingKeyTitle =>
      'Google Safe Browsing-ന് സൗജന്യ കീ നേടുക';

  @override
  String get helpGuideSafeBrowsingKeyStep1 =>
      '1. ഒരു ബ്രൗസറിൽ console.cloud.google.com തുറന്ന് Google അക്കൗണ്ട് കൊണ്ട് പ്രവേശിക്കുക.';

  @override
  String get helpGuideSafeBrowsingKeyStep2 =>
      '2. ഒരു പുതിയ പ്രോജക്റ്റ് ഉണ്ടാക്കുക. ഏതു പേരും മതി, ഉദാഹരണത്തിന് \"QR safety\".';

  @override
  String get helpGuideSafeBrowsingKeyStep3 =>
      '3. APIs & Services > Library എന്നതിൽ ചെന്ന് \"Safe Browsing API\" തിരഞ്ഞ് Enable തൊടുക.';

  @override
  String get helpGuideSafeBrowsingKeyStep4 =>
      '4. APIs & Services > Credentials എന്നതിൽ ചെന്ന് Create credentials തൊട്ട് API key തിരഞ്ഞെടുക്കുക.';

  @override
  String get helpGuideSafeBrowsingKeyStep5 =>
      '5. കീ പകർത്തുക. ആപ്പിൽ ക്രമീകരണങ്ങൾ > URL സുരക്ഷാ ദാതാക്കൾ തുറന്ന്, Google Safe Browsing കള്ളിയിൽ ഒട്ടിച്ച് ‘API കീ സംരക്ഷിക്കുക’ തൊടുക.';

  @override
  String get helpGuideSafeBrowsingOtherTitle => 'കീ വേണ്ട മറ്റു സേവനങ്ങൾ';

  @override
  String get helpGuideSafeBrowsingOtherBullet1 =>
      'VirusTotal, URLhaus എന്നിവയും ഇതേ രീതിയിലാണ്. അവരുടെ വെബ്സൈറ്റിൽ സൗജന്യ അക്കൗണ്ട് ഉണ്ടാക്കി, കീ പകർത്തി, ‘നിങ്ങളുടെ API കീകൾ’ എന്നതിൽ ഒട്ടിക്കുക. ഓരോ കീയും എവിടെ കിട്ടുമെന്ന് ആപ്പ് കാണിക്കും.';

  @override
  String get helpGuideSafeBrowsingOtherBullet2 =>
      'ഈ സൗജന്യ കീകൾ വ്യക്തിപരമായ, വാണിജ്യേതര ഉപയോഗത്തിനു മാത്രമാണ്.';

  @override
  String get helpGuideSafeBrowsingOtherBullet3 =>
      'ഓരോ സേവനത്തിനും ദിവസ പരിധിയുണ്ട്; ഇന്ന് എത്ര പരിശോധനകൾ ഉപയോഗിച്ചു എന്ന് ആപ്പ് കാണിക്കും. ഈ ആപ്പിൽ Safe Browsing ദിവസം 10,000 വരെയും VirusTotal 500 വരെയും അനുവദിക്കുന്നു.';

  @override
  String get helpGuideSafeBrowsingPrivacyTitle => 'നിങ്ങളുടെ കീകൾ സുരക്ഷിതം';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet1 =>
      'നിങ്ങളുടെ കീകൾ ഈ ഫോണിലെ Android-ന്റെ സുരക്ഷിതവും പൂട്ടിയതുമായ സംഭരണിയിൽ സൂക്ഷിക്കുന്നു; ഒരിക്കലും പങ്കിടില്ല.';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet2 =>
      'നിങ്ങൾ സ്കാൻ ചെയ്ത ലിങ്ക് മാത്രമേ സേവനത്തിലേക്ക് അയയ്ക്കൂ. നിങ്ങളെക്കുറിച്ചുള്ള മറ്റൊന്നും അയയ്ക്കില്ല.';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet3 =>
      'ഏതു സമയത്തും ഒരു കീ ഇല്ലാതാക്കാം. അപ്പോൾ ആപ്പ് ആ പരിശോധന ഒഴിവാക്കും.';

  @override
  String get helpGuideSafeBrowsingTip =>
      'നുറുങ്ങ്: സുരക്ഷിതരായിരിക്കാൻ ഒരു കീയും നിർബന്ധമില്ല. ഇന്റർനെറ്റ് ഇല്ലെങ്കിലും ആപ്പിന്റെ സ്വന്തം പരിശോധനകൾ എപ്പോഴും നടക്കും.';

  @override
  String get helpGuideSmartPayloadsName => 'സ്മാർട്ട് പ്രവർത്തനങ്ങൾ';

  @override
  String get helpGuideSmartPayloadsSummary =>
      'വൈ-ഫൈ, പണമിടപാട്, വിലാസവിവരങ്ങൾ, പരിപാടികൾ, ഫോൺ നമ്പറുകൾ, ഉൽപ്പന്നങ്ങൾ തുടങ്ങിയവയ്ക്ക് ഒറ്റ തൊടലിൽ പ്രവർത്തിക്കുന്ന ബട്ടണുകൾ.';

  @override
  String get helpGuideSmartPayloadsIntro =>
      'കോഡിൽ എന്താണുള്ളതെന്ന് ആപ്പ് മനസ്സിലാക്കി, അതിനു പറ്റിയ ബട്ടണുകളുള്ള ഒരു കാർഡ് കാണിക്കും. ഉദാഹരണത്തിന്, വൈ-ഫൈ കോഡിന് ബന്ധിപ്പിക്കാനുള്ള ബട്ടണും ഫോൺ നമ്പറിന് വിളിക്കാനുള്ള ബട്ടണും.';

  @override
  String get helpGuideSmartPayloadsWifiTitle => 'വൈ-ഫൈ';

  @override
  String get helpGuideSmartPayloadsWifiBullet1 =>
      'നെറ്റ്‌വർക്കിന്റെ പേരും സുരക്ഷാ തരവും കാണിക്കും. പാസ്‌വേഡ് കാണിക്കാനോ മറയ്ക്കാനോ കണ്ണിന്റെ ബട്ടൺ തൊടുക; പകർത്തുകയുമാവാം.';

  @override
  String get helpGuideSmartPayloadsWifiBullet2 =>
      '‘വൈ-ഫൈയിലേക്ക് ബന്ധിപ്പിക്കുക’ തൊടുക. Android സ്ഥിരീകരണം ചോദിച്ചേക്കാം. ഫോൺ നേരിട്ടു ബന്ധിപ്പിക്കാൻ അനുവദിക്കുന്നില്ലെങ്കിൽ, പാസ്‌വേഡ് പകർത്തും; വൈ-ഫൈ ക്രമീകരണങ്ങളിൽ അത് ഒട്ടിക്കാം.';

  @override
  String get helpGuideSmartPayloadsPaymentsTitle => 'പണമിടപാടുകൾ';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet1 =>
      'UPI കോഡുകൾ ആർക്കാണ് പണം നൽകുന്നതെന്നും തുകയും കാണിക്കും. വിവരങ്ങൾ പൂരിപ്പിച്ച നിലയിൽ നിങ്ങളുടെ UPI ആപ്പ് (Google Pay, PhonePe, Paytm, BHIM പോലെ) തുറക്കാൻ ‘UPI ആപ്പ് വഴി നൽകുക’ തൊടുക.';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet2 =>
      'കോഡിൽ തുക ഇല്ലെങ്കിൽ, ആദ്യം അതു ടൈപ്പ് ചെയ്യാൻ ആപ്പ് ആവശ്യപ്പെടും.';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet3 =>
      'ഈ ആപ്പ് ഒരിക്കലും സ്വയം പണം എടുക്കുകയോ അയയ്ക്കുകയോ ചെയ്യില്ല. ഓരോ പണമിടപാടും നിങ്ങളുടെ UPI ആപ്പിൽ നിങ്ങൾ തന്നെ സ്ഥിരീകരിക്കണം.';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet4 =>
      'ക്രിപ്റ്റോ വാലറ്റ് കോഡുകളും (Bitcoin, Ethereum, Solana) SEPA ബാങ്ക് കൈമാറ്റ കോഡുകളും വിലാസം കാണിക്കും; അതു പകർത്താം.';

  @override
  String get helpGuideSmartPayloadsTotpTitle => 'രണ്ടു-ഘട്ട ലോഗിൻ കോഡുകൾ (2FA)';

  @override
  String get helpGuideSmartPayloadsTotpBullet1 =>
      'രണ്ടു-ഘട്ട ലോഗിൻ ഓണാക്കുമ്പോൾ വെബ്സൈറ്റുകൾ പലപ്പോഴും ഒരു QR കോഡ് കാണിക്കും. അതു സ്കാൻ ചെയ്താൽ ഓരോ 30 സെക്കൻഡിലും മാറുന്ന 6 അക്ക കോഡ് ഒരു ടൈമറോടെ കാണാം.';

  @override
  String get helpGuideSmartPayloadsTotpBullet2 =>
      'Google Authenticator, Microsoft Authenticator പോലുള്ള നിങ്ങളുടെ ഓതന്റിക്കേറ്റർ ആപ്പിൽ സൂക്ഷിക്കാൻ ‘ഓതന്റിക്കേറ്ററിലേക്ക് ചേർക്കുക’ തൊടുക.';

  @override
  String get helpGuideSmartPayloadsTotpBullet3 =>
      'ഇത്തരം കോഡ് രഹസ്യമായി സൂക്ഷിക്കുക. ഇതു സ്കാൻ ചെയ്യുന്ന ആർക്കും നിങ്ങളുടെ ലോഗിൻ കോഡുകൾ ഉണ്ടാക്കാൻ കഴിയും.';

  @override
  String get helpGuideSmartPayloadsContactsTitle =>
      'വിലാസവിവരങ്ങളും പരിപാടികളും';

  @override
  String get helpGuideSmartPayloadsContactsBullet1 =>
      'വിലാസവിവര കോഡുകൾ (vCard, MeCard) പേര്, ഫോൺ, ഇമെയിൽ, സ്ഥാപനം എന്നിവ കാണിക്കും. ‘കോൺടാക്റ്റുകളിലേക്ക് സൂക്ഷിക്കുക’ തൊടുക, അല്ലെങ്കിൽ നേരിട്ട് വിളിക്കുകയോ ഇമെയിൽ അയയ്ക്കുകയോ ചെയ്യുക.';

  @override
  String get helpGuideSmartPayloadsContactsBullet2 =>
      'പരിപാടി കോഡുകൾ ശീർഷകം, സമയം, സ്ഥലം എന്നിവ കാണിക്കും. ‘ഉപകരണ കലണ്ടറിലേക്ക് ചേർക്കുക’ തൊടുക.';

  @override
  String get helpGuideSmartPayloadsOtherTitle =>
      'ഫോൺ, സന്ദേശം, മാപ്പ് തുടങ്ങിയവ';

  @override
  String get helpGuideSmartPayloadsOtherBullet1 =>
      'ഫോൺ നമ്പർ: ‘വിളിക്കുക’ തൊടുക. ടെക്സ്റ്റ് സന്ദേശം: ‘സന്ദേശം അയക്കുക’ തൊടുക; സന്ദേശം മുൻകൂട്ടി പൂരിപ്പിച്ചിരിക്കും. ഇമെയിൽ: ‘ഇമെയിൽ അയക്കുക’ തൊടുക.';

  @override
  String get helpGuideSmartPayloadsOtherBullet2 =>
      'സ്ഥലം: സ്ഥലം കാണാനോ വഴി അറിയാനോ ‘ഗൂഗിൾ മാപ്‌സിൽ വഴികാട്ടുക’ തൊടുക.';

  @override
  String get helpGuideSmartPayloadsOtherBullet3 =>
      'ആപ്പ് ലിങ്ക്: ബന്ധപ്പെട്ട ആപ്പ് ഇൻസ്റ്റാൾ ചെയ്തിട്ടുണ്ടെങ്കിൽ അതു തുറക്കാൻ ‘ആപ്പിൽ തുറക്കുക’ തൊടുക.';

  @override
  String get helpGuideSmartPayloadsOtherBullet4 =>
      'ഉൽപ്പന്ന ബാർകോഡ്: ഭക്ഷണത്തിന്റെ വിവരങ്ങൾ അറിയാൻ ‘ഭക്ഷണ വിവരം’, അല്ലെങ്കിൽ ‘വെബിൽ തിരയുക’ തൊടുക.';

  @override
  String get helpGuideSmartPayloadsOtherBullet5 =>
      'പുസ്തക (ISBN) ബാർകോഡ്: പുസ്തകം ഗൂഗിൾ ബുക്സിലോ ഓപ്പൺ ലൈബ്രറിയിലോ തിരയുക.';

  @override
  String get helpGuideSmartPayloadsOtherBullet6 =>
      'സുരക്ഷാ പരിശോധന കഴിഞ്ഞതിനു ശേഷമേ വെബ് ലിങ്കുകൾ ബ്രൗസറിൽ തുറക്കൂ.';

  @override
  String get helpGuideSmartPayloadsTip =>
      'നുറുങ്ങ്: UPI കോഡ് വഴി പണം നൽകുന്നതിനു മുൻപ്, കാർഡിലെ പേര് നിങ്ങൾ പണം നൽകാൻ ഉദ്ദേശിക്കുന്ന കടയുടേതോ ആളുടേതോ തന്നെയാണെന്ന് ഉറപ്പാക്കുക.';

  @override
  String get helpGuideHiddenName => 'ഒളിപ്പിച്ചതും പൂട്ടിയതുമായ കോഡുകൾ';

  @override
  String get helpGuideHiddenSummary =>
      'രഹസ്യ സന്ദേശമോ പൂട്ടിയ വിവരങ്ങളോ ഉള്ള QR കോഡുകൾ തുറക്കുക.';

  @override
  String get helpGuideHiddenIntro =>
      'ചില QR കോഡുകളിൽ രഹസ്യവാക്ക് കൊണ്ട് പൂട്ടിയ സ്വകാര്യ വിവരങ്ങൾ ഉണ്ടാകും. ആപ്പ് ഇത്തരം കോഡുകൾ തിരിച്ചറിയുകയും നിങ്ങളുടെ ഫോണിൽത്തന്നെ അവ തുറക്കാൻ സഹായിക്കുകയും ചെയ്യും.';

  @override
  String get helpGuideHiddenStegoTitle =>
      'StegoQR: ഒളിപ്പിച്ച സന്ദേശമുള്ള കോഡ്';

  @override
  String get helpGuideHiddenStegoBullet1 =>
      'StegoQR കോഡ് എല്ലാവർക്കും സാധാരണ ഒരു പൊതു വാചകം കാണിക്കും; അതിനുള്ളിൽ രണ്ടാമതൊരു രഹസ്യ സന്ദേശം ഒളിപ്പിച്ചിരിക്കും.';

  @override
  String get helpGuideHiddenStegoBullet2 =>
      'അത്തരമൊന്ന് സ്കാൻ ചെയ്യുമ്പോൾ ഫലത്തിൽ ‘StegoQR കണ്ടെത്തി’ എന്നു കാണാം. പൊതു വാചകം പതിവുപോലെ കാണിക്കും.';

  @override
  String get helpGuideHiddenStegoBullet3 =>
      'രഹസ്യം കാണാൻ രഹസ്യവാക്ക് ടൈപ്പ് ചെയ്ത് ‘തുറക്കുക’ തൊടുക. കോഡ് ഉണ്ടാക്കിയ ആളാണ് രഹസ്യവാക്ക് നിങ്ങൾക്കു തരേണ്ടത്.';

  @override
  String get helpGuideHiddenStegoBullet4 =>
      '‘ബയോമെട്രിക് അൺലോക്ക്’ രഹസ്യവാക്കിനൊപ്പം നിങ്ങളുടെ വിരലടയാളമോ മുഖമോ കൂടി ചോദിക്കും.';

  @override
  String get helpGuideHiddenStegoBullet5 =>
      'തുറന്നതിനു ശേഷം രഹസ്യം പകർത്തുകയോ പങ്കിടുകയോ ചെയ്യാം.';

  @override
  String get helpGuideHiddenOtherTitle => 'മറ്റു പൂട്ടിയ കോഡുകൾ';

  @override
  String get helpGuideHiddenOtherBullet1 =>
      'എയർ ക്യുആർ കൈമാറ്റ കോഡുകൾ: അയയ്ക്കുന്ന ഫോണിൽ കാണിക്കുന്ന സെഷൻ കോഡ് ടൈപ്പ് ചെയ്യുക.';

  @override
  String get helpGuideHiddenOtherBullet2 =>
      'എൻക്രിപ്റ്റ് ചെയ്ത JSON കോഡുകളും പൂട്ടിയ മറ്റു വാചകങ്ങളും: ‘ഡീക്രിപ്റ്റ് ചെയ്യുക’ തൊട്ട് രഹസ്യവാക്ക് ടൈപ്പ് ചെയ്യുക.';

  @override
  String get helpGuideHiddenOtherBullet3 =>
      '‘വിപുലം (Salt / IV)’ അധിക ക്രമീകരണങ്ങൾ ആവശ്യമുള്ള, മറ്റു ടൂളുകൾ കൊണ്ടുണ്ടാക്കിയ കോഡുകൾക്കു മാത്രമാണ്. മിക്കവർക്കും ഇത് ഒരിക്കലും വേണ്ടിവരില്ല.';

  @override
  String get helpGuideHiddenSafetyTitle => 'അറിഞ്ഞിരിക്കേണ്ടവ';

  @override
  String get helpGuideHiddenSafetyBullet1 =>
      'തുറക്കൽ നിങ്ങളുടെ ഫോണിൽത്തന്നെ നടക്കുന്നു. രഹസ്യവാക്കും രഹസ്യവും ഒരിക്കലും എവിടേക്കും അയയ്ക്കില്ല.';

  @override
  String get helpGuideHiddenSafetyBullet2 =>
      'തെറ്റായ രഹസ്യവാക്ക് ഒരു പിശക് കാണിക്കുക മാത്രം ചെയ്യും. അക്ഷരങ്ങൾ, വലിയക്ഷരങ്ങൾ, ഇടകൾ എന്നിവ ശ്രദ്ധിച്ച് വീണ്ടും ശ്രമിക്കുക.';

  @override
  String get helpGuideHiddenSafetyBullet3 =>
      'ഈ ആപ്പിന് ഇത്തരം കോഡുകൾ തുറക്കാനാകും; പക്ഷേ ഇവ നിർമ്മിക്കുന്നില്ല.';

  @override
  String get helpGuideHiddenTip =>
      'നുറുങ്ങ്: രഹസ്യവാക്ക് കോഡിൽ നിന്നു വേറിട്ട ഒരു വഴിയിൽ, ഉദാഹരണത്തിന് ഫോൺ വിളിയിലൂടെ, പങ്കിടുക. കോഡിന്റെ അടുത്ത് ഒരിക്കലും അത് എഴുതിവയ്ക്കരുത്.';

  @override
  String get helpGuideHistoryName => 'നാൾവഴി, ബാക്കപ്പ്, സ്വകാര്യത';

  @override
  String get helpGuideHistorySummary =>
      'പഴയ സ്കാനുകൾ കണ്ടെത്തുക, കുറിപ്പുകൾ ചേർക്കുക, നാൾവഴി കയറ്റുമതി ചെയ്യുക അല്ലെങ്കിൽ ബാക്കപ്പ് എടുക്കുക, ആപ്പ് പൂട്ടുക.';

  @override
  String get helpGuideHistoryIntro =>
      'ഓരോ സ്കാനും നിങ്ങളുടെ ഫോണിലെ നാൾവഴി ടാബിൽ, പൂട്ടിയ (എൻക്രിപ്റ്റ് ചെയ്ത) സംഭരണിയിൽ സൂക്ഷിക്കുന്നു. ഒന്നും അപ്‌ലോഡ് ചെയ്യുന്നില്ല.';

  @override
  String get helpGuideHistoryManageTitle =>
      'സ്കാനുകൾ കണ്ടെത്താനും നിയന്ത്രിക്കാനും';

  @override
  String get helpGuideHistoryManageBullet1 =>
      'ഉള്ളടക്കം, തരം, കുറിപ്പുകൾ എന്നിവ കൊണ്ട് സ്കാനുകൾ കണ്ടെത്താൻ തിരയൽ കള്ളിയിൽ ടൈപ്പ് ചെയ്യുക.';

  @override
  String get helpGuideHistoryManageBullet2 =>
      'ലിങ്കുകൾ, വൈ-ഫൈ, വിലാസവിവരങ്ങൾ, ഉൽപ്പന്നങ്ങൾ തുടങ്ങിയവ മാത്രം കാണാൻ ഫിൽട്ടർ ചിപ്പുകൾ ഉപയോഗിക്കുക. ഒരു സ്കാൻ ‘നക്ഷത്രമിട്ടവ’യിൽ ചേർക്കാൻ അതിലെ നക്ഷത്രം തൊടുക.';

  @override
  String get helpGuideHistoryManageBullet3 =>
      'ഒരു സ്കാനിന്റെ മുഴുവൻ വിശദാംശങ്ങളും (ഉള്ളടക്കം, സുരക്ഷാ സ്കോർ, സമയം) കാണാൻ അതിൽ തൊടുക. കുറിപ്പും സ്ഥലവും ചേർക്കാം, അല്ലെങ്കിൽ പകർത്താം, പങ്കിടാം, ഇല്ലാതാക്കാം.';

  @override
  String get helpGuideHistoryManageBullet4 =>
      '‘എല്ലാം മായ്ക്കുക’ മുഴുവൻ നാൾവഴിയും ഇല്ലാതാക്കും. ഇതു പഴയപടിയാക്കാനാവില്ല; അതിനാൽ ആദ്യം ബാക്കപ്പ് എടുക്കുക.';

  @override
  String get helpGuideHistoryBackupTitle => 'കയറ്റുമതിയും ബാക്കപ്പും';

  @override
  String get helpGuideHistoryBackupBullet1 =>
      'നാൾവഴി ടാബിന്റെ മുകളിലെ ‘കയറ്റുമതി / ബാക്കപ്പ്’ ബട്ടൺ തൊടുക.';

  @override
  String get helpGuideHistoryBackupBullet2 =>
      '‘രേഖകൾ കയറ്റുമതി ചെയ്യുക’ ഒരു പകർപ്പ് CSV (Excel, Sheets എന്നിവയ്ക്ക്), JSON, ടെക്സ്റ്റ്, PDF ആയി സൂക്ഷിക്കും. ഈ ഫയലുകൾ പൂട്ടിയവയല്ല: ഫയൽ കിട്ടുന്ന ആർക്കും നിങ്ങളുടെ സ്കാനുകൾ വായിക്കാം; അതിനാൽ ആപ്പ് ആദ്യം ചോദിക്കും.';

  @override
  String get helpGuideHistoryBackupBullet3 =>
      'പകർപ്പ് സൂക്ഷിക്കാനുള്ള സുരക്ഷിത മാർഗമാണ് ‘എൻക്രിപ്റ്റ് ചെയ്ത ബാക്കപ്പ്’. ഒരു രഹസ്യവാക്ക് ടൈപ്പ് ചെയ്ത് ‘ബാക്കപ്പ് നിർമ്മിക്കുക’ തൊടുക; തുടർന്ന് ഫയൽ സൂക്ഷിക്കുകയോ പങ്കിടുകയോ ചെയ്യുക.';

  @override
  String get helpGuideHistoryBackupBullet4 =>
      'പുനഃസ്ഥാപിക്കാൻ ‘ബാക്കപ്പ് പുനഃസ്ഥാപിക്കുക’ തുറന്ന്, ബാക്കപ്പ് ഫയലിലെ വാചകം ഒട്ടിച്ച്, അതേ രഹസ്യവാക്ക് ടൈപ്പ് ചെയ്ത് ‘നാൾവഴി പുനഃസ്ഥാപിക്കുക’ തൊടുക.';

  @override
  String get helpGuideHistoryBiometricsTitle =>
      'ആപ്പ് ലോക്കും സ്ക്രീൻഷോട്ട് സംരക്ഷണവും';

  @override
  String get helpGuideHistoryBiometricsBullet1 =>
      'ആപ്പ് ലോക്ക്: ക്രമീകരണങ്ങൾ > സ്വകാര്യതയും നെറ്റ്‌വർക്ക് പരിശോധനയും എന്നതിൽ ഓണാക്കുക. പിന്നെ ആപ്പ് തുറക്കുമ്പോഴും 30 സെക്കൻഡ് മാറിനിന്നതിനു ശേഷവും വിരലടയാളമോ മുഖമോ സ്ക്രീൻ ലോക്കോ ചോദിക്കും.';

  @override
  String get helpGuideHistoryBiometricsBullet2 =>
      'സ്ക്രീൻഷോട്ട് സംരക്ഷണം: സ്കാനുകൾ, നാൾവഴി, രഹസ്യങ്ങൾ, കീകൾ എന്നിവയുള്ള സ്ക്രീനുകളിൽ സ്ക്രീൻഷോട്ടും സ്ക്രീൻ റെക്കോർഡിംഗും തടയും. സമീപകാല ആപ്പുകളുടെ പട്ടികയിൽ ഈ സ്ക്രീനുകൾ ശൂന്യമായി കാണും. ക്രമീകരണങ്ങൾ > സ്വകാര്യതയും നെറ്റ്‌വർക്ക് പരിശോധനയും എന്നതിൽ ഓണാക്കുകയോ ഓഫാക്കുകയോ ചെയ്യാം.';

  @override
  String get helpGuideHistoryBiometricsBullet3 =>
      'നാൾവഴി പുതിയ ഫോണിലേക്ക് മാറ്റാൻ ‘എയർക്യുആർ സിങ്ക്’ ഉപയോഗിക്കുക. എയർ ക്യുആർ വഴികാട്ടി കാണുക.';

  @override
  String get helpGuideHistoryTip =>
      'നുറുങ്ങ്: ഫോൺ റീസെറ്റ് ചെയ്യുന്നതിനോ മാറ്റുന്നതിനോ മുൻപ് എൻക്രിപ്റ്റ് ചെയ്ത ബാക്കപ്പ് എടുക്കുക. രഹസ്യവാക്ക് സുരക്ഷിതമായി സൂക്ഷിക്കുക; അതില്ലാതെ ബാക്കപ്പ് തുറക്കാനാവില്ല.';

  @override
  String get helpGuideSettingsName => 'ക്രമീകരണങ്ങളും ഇഷ്ടാനുസൃതമാക്കലും';

  @override
  String get helpGuideSettingsSummary =>
      'രൂപം, ഭാഷ, ശബ്ദം എന്നിവ മാറ്റുക, അനുമതികൾ കാണുക, ബാറ്ററി ലാഭിക്കുക, നിങ്ങളുടെ വിവരങ്ങൾ ഇല്ലാതാക്കുക.';

  @override
  String get helpGuideSettingsIntro =>
      'ക്രമീകരണങ്ങൾ തുറക്കാൻ സ്കാൻ സ്ക്രീനിൽ ‘കൂടുതൽ ഓപ്ഷനുകൾ’ തൊട്ട് ‘ക്രമീകരണങ്ങൾ’ തിരഞ്ഞെടുക്കുക. ഓരോ ഭാഗവും എന്തു ചെയ്യുന്നു എന്നു താഴെ.';

  @override
  String get helpGuideSettingsLookTitle => 'രൂപവും ഭാഷയും';

  @override
  String get helpGuideSettingsLookBullet1 =>
      'രൂപഭംഗി > തീം മോഡ്: സിസ്റ്റം, ലൈറ്റ്, ഡാർക്ക്, OLED. OLED പൂർണ്ണ കറുപ്പാണ്; OLED സ്ക്രീനുകളിൽ ബാറ്ററി ലാഭിക്കും.';

  @override
  String get helpGuideSettingsLookBullet2 =>
      'വർണ്ണങ്ങളും ഡൈനാമിക് തീമും: ഒരു പ്രധാന നിറം തിരഞ്ഞെടുക്കുക, അല്ലെങ്കിൽ വാൾപേപ്പറിനു ചേരാൻ ഡൈനാമിക് നിറങ്ങൾ ഓണാക്കുക (Android 12-ഉം പുതിയവയും).';

  @override
  String get helpGuideSettingsLookBullet3 =>
      'അക്ഷര ശൈലിയും വലുപ്പവും: അക്ഷരരൂപം തിരഞ്ഞെടുക്കുക. ഫോണിൽ നിങ്ങൾ വച്ചിരിക്കുന്ന അക്ഷരവലുപ്പം ആപ്പും പിന്തുടരും.';

  @override
  String get helpGuideSettingsLookBullet4 =>
      'സ്കാൻ ഓവർലേ ശൈലി: സ്കാൻ ഫ്രെയിം എങ്ങനെ കാണണമെന്നു തിരഞ്ഞെടുക്കുക.';

  @override
  String get helpGuideSettingsLookBullet5 =>
      'ഭാഷ: സിസ്റ്റം സ്വതവേയുള്ളത്, English, മലയാളം, സംസ്കൃതം (संस्कृतम्) എന്നിവയിൽ ഒന്നു തിരഞ്ഞെടുക്കുക. റീസ്റ്റാർട്ട് ഇല്ലാതെ ആപ്പ് ഉടൻ മാറും.';

  @override
  String get helpGuideSettingsFeedbackTitle => 'സ്കാൻ പ്രതികരണം';

  @override
  String get helpGuideSettingsFeedbackBullet1 =>
      'കോഡ് വായിക്കുമ്പോൾ ഫോൺ വിറയ്ക്കണോ, ബീപ്പ് ശബ്ദം വേണോ, ചെറിയ ആനിമേഷൻ വേണോ എന്നു തിരഞ്ഞെടുക്കുക.';

  @override
  String get helpGuideSettingsPrivacyTitle =>
      'സ്വകാര്യതയും നെറ്റ്‌വർക്ക് പരിശോധനയും';

  @override
  String get helpGuideSettingsPrivacyBullet1 =>
      'ഓൺലൈൻ പരിശോധനകൾ: നിങ്ങൾ ഓണാക്കുന്നില്ലെങ്കിൽ ഓഫ്. ലിങ്ക് സുരക്ഷാ വഴികാട്ടി കാണുക.';

  @override
  String get helpGuideSettingsPrivacyBullet2 =>
      'ആപ്പ് ലോക്ക്, സ്ക്രീൻഷോട്ട് സംരക്ഷണം: നാൾവഴി, ബാക്കപ്പ്, സ്വകാര്യത വഴികാട്ടി കാണുക.';

  @override
  String get helpGuideSettingsPrivacyBullet3 =>
      'എല്ലാ വിവരങ്ങളും ഇല്ലാതാക്കുക: സ്കാൻ നാൾവഴി, സൂക്ഷിച്ച കീകൾ, എല്ലാ ക്രമീകരണങ്ങളും ഈ ഫോണിൽ നിന്നു നീക്കും. ഇതു പഴയപടിയാക്കാനാവില്ല.';

  @override
  String get helpGuideSettingsOtherTitle => 'മറ്റു ക്രമീകരണങ്ങൾ';

  @override
  String get helpGuideSettingsOtherBullet1 =>
      'URL സുരക്ഷാ ദാതാക്കൾ: അധിക ഓൺലൈൻ ലിങ്ക് പരിശോധകരെ ഓണാക്കുക.';

  @override
  String get helpGuideSettingsOtherBullet2 =>
      'എയർക്യുആർ സിങ്ക്: നാൾവഴിയും ക്രമീകരണങ്ങളും മറ്റൊരു ഫോണിലേക്കു മാറ്റുക.';

  @override
  String get helpGuideSettingsOtherBullet3 =>
      'സ്കാൻ ബബിൾ: മറ്റ് ആപ്പുകളിലെ കോഡുകൾ സ്കാൻ ചെയ്യാനുള്ള ഒഴുകി നിൽക്കുന്ന ബട്ടൺ.';

  @override
  String get helpGuideSettingsOtherBullet4 =>
      'അനുമതികൾ: ആപ്പ് എന്തൊക്കെ ഉപയോഗിച്ചേക്കാം, എന്തിന് എന്നതിന്റെ ലളിതമായ പട്ടിക. ഒരു സവിശേഷതയ്ക്ക് ആവശ്യമുള്ളപ്പോൾ മാത്രമേ ആപ്പ് ഓരോന്നും ചോദിക്കൂ.';

  @override
  String get helpGuideSettingsOtherBullet5 =>
      'സവിശേഷതകൾ ആപ്പിന് ചെയ്യാനാകുന്ന എല്ലാം കാണിക്കും. ആമുഖ ടൂർ ആദ്യം തുറന്നപ്പോഴുള്ള പരിചയപ്പെടുത്തൽ വീണ്ടും കാണിക്കും. ‘വിവരങ്ങൾ’ ആപ്പിന്റെ പതിപ്പും ലൈസൻസുകളും കാണിക്കും.';

  @override
  String get helpGuideSettingsBatteryTitle => 'ബാറ്ററി ലാഭിക്കാൻ';

  @override
  String get helpGuideSettingsBatteryBullet1 =>
      'സ്കാൻ സ്ക്രീനിൽ നിന്നോ ആപ്പിൽ നിന്നോ പുറത്തുപോകുന്ന ഉടൻ ക്യാമറ ഓഫാകും.';

  @override
  String get helpGuideSettingsBatteryBullet2 =>
      'കുറഞ്ഞ ഊർജ്ജം ഉപയോഗിക്കാൻ ക്യാമറ ക്രമീകരണങ്ങളിൽ 720p തിരഞ്ഞെടുക്കുക.';

  @override
  String get helpGuideSettingsBatteryBullet3 =>
      'ആവശ്യമില്ലാത്തപ്പോൾ സ്കാൻ ബബിൾ ഓഫാക്കുക.';

  @override
  String get helpGuideSettingsBatteryBullet4 =>
      'OLED സ്ക്രീനുള്ള ഫോണുകളിൽ OLED തീം ഉപയോഗിക്കുക.';

  @override
  String get helpGuideSettingsTip =>
      'നുറുങ്ങ്: എന്തെങ്കിലും എവിടെയാണെന്ന് ഉറപ്പില്ലേ? ഇവിടത്തെ ഓരോ വഴികാട്ടിയും തൊടേണ്ട ബട്ടണിന്റെ പേരു പറയുന്നു.';

  @override
  String get helpGuideFaqName => 'പതിവ് ചോദ്യങ്ങളും പ്രശ്നങ്ങളും';

  @override
  String get helpGuideFaqSummary =>
      'സാധാരണ ചോദ്യങ്ങൾക്കുള്ള ഉത്തരങ്ങളും, എന്തെങ്കിലും പ്രവർത്തിക്കാത്തപ്പോഴുള്ള പരിഹാരങ്ങളും.';

  @override
  String get helpGuideFaqIntro =>
      'സാധാരണ ചോദ്യങ്ങൾക്കുള്ള ചുരുക്ക ഉത്തരങ്ങളും, എന്തെങ്കിലും പ്രവർത്തിക്കാത്തപ്പോൾ എന്തു ചെയ്യണമെന്നും.';

  @override
  String get helpGuideFaqQuestionsTitle => 'സാധാരണ ചോദ്യങ്ങൾ';

  @override
  String get helpGuideFaqQuestion1 =>
      'ഇന്റർനെറ്റ് ഇല്ലാതെ ആപ്പ് പ്രവർത്തിക്കുമോ?\nഉവ്വ്. കോഡ് വായിക്കൽ, ആദ്യത്തെ നാലു ലിങ്ക് പരിശോധനകൾ, ക്വിഷിംഗ് ഗാർഡ് എന്നിവയെല്ലാം ഓഫ്‌ലൈനായി പ്രവർത്തിക്കും. ഐച്ഛികമായ ഓൺലൈൻ പരിശോധനകൾക്കു മാത്രമേ ഇന്റർനെറ്റ് വേണ്ടൂ.';

  @override
  String get helpGuideFaqQuestion2 =>
      'എന്റെ ക്യാമറ ദൃശ്യങ്ങൾ എവിടേക്കെങ്കിലും അയയ്ക്കുമോ?\nഇല്ല. ദൃശ്യങ്ങൾ നിങ്ങളുടെ ഫോണിൽത്തന്നെ വായിക്കുന്നു; ഒരിക്കലും സൂക്ഷിക്കുകയോ അപ്‌ലോഡ് ചെയ്യുകയോ ഇല്ല.';

  @override
  String get helpGuideFaqQuestion3 =>
      'ആപ്പ് എന്നെക്കുറിച്ചുള്ള വിവരങ്ങൾ ശേഖരിക്കുന്നുണ്ടോ?\nഇല്ല. പരസ്യങ്ങളോ പിന്തുടരലോ വിശകലനങ്ങളോ ഇല്ല. നിങ്ങളുടെ നാൾവഴി നിങ്ങളുടെ ഫോണിൽത്തന്നെ നിൽക്കും.';

  @override
  String get helpGuideFaqQuestion4 =>
      'ആപ്പ് എന്തിനാണ് അനുമതി ചോദിക്കുന്നത്?\nആവശ്യമുള്ള ഒരു സവിശേഷത, ഉദാഹരണത്തിന് സ്കാനിംഗിനുള്ള ക്യാമറ, ഉപയോഗിക്കുമ്പോൾ മാത്രം. മുഴുവൻ പട്ടികയ്ക്ക് ക്രമീകരണങ്ങൾ > അനുമതികൾ കാണുക.';

  @override
  String get helpGuideFaqQuestion5 =>
      'ഭാഷ എങ്ങനെ മാറ്റാം?\nക്രമീകരണങ്ങൾ > ഭാഷ എന്നതിൽ ചെല്ലുക. ആപ്പ് ഉടൻ മാറും.';

  @override
  String get helpGuideFaqQuestion6 =>
      'എല്ലാം എങ്ങനെ ഇല്ലാതാക്കാം?\nക്രമീകരണങ്ങൾ > സ്വകാര്യതയും നെറ്റ്‌വർക്ക് പരിശോധനയും > എല്ലാ വിവരങ്ങളും ഇല്ലാതാക്കുക. നാൾവഴിയിൽ ഓരോ സ്കാനായും ഇല്ലാതാക്കാം.';

  @override
  String get helpGuideFaqQuestion7 =>
      'ഞാൻ വിശ്വസിക്കുന്ന ഒരു ലിങ്ക് സുരക്ഷിതമല്ല എന്നു കാണിക്കുന്നു. എന്തുകൊണ്ട്?\nപരിശോധനകൾ മുന്നറിയിപ്പു ലക്ഷണങ്ങൾ നോക്കുന്നു; ചില യഥാർത്ഥ സൈറ്റുകളിലും അവ ഉണ്ടാകാം. ഉറവിടത്തെക്കുറിച്ച് ഉറപ്പുണ്ടെങ്കിൽ എന്നിട്ടും തുറക്കാം.';

  @override
  String get helpGuideFaqQuestion8 =>
      'ആപ്പ് ധാരാളം ബാറ്ററി ഉപയോഗിക്കുമോ?\nഇല്ല. സ്കാൻ സ്ക്രീൻ വിടുന്ന ഉടൻ ക്യാമറ നിൽക്കും. കൂടുതൽ ബാറ്ററി നുറുങ്ങുകൾക്ക് ക്രമീകരണ സഹായി കാണുക.';

  @override
  String get helpGuideFaqCameraTitle => 'കോഡ് സ്കാൻ ആകുന്നില്ലെങ്കിൽ';

  @override
  String get helpGuideFaqCameraBullet1 =>
      'ക്യാമറ ലെൻസ് വൃത്തിയാക്കി, ഫോൺ കോഡിൽ നിന്ന് ഏകദേശം 15 മുതൽ 20 സെ.മീ. (6 മുതൽ 8 ഇഞ്ച്) അകലെ പിടിക്കുക.';

  @override
  String get helpGuideFaqCameraBullet2 =>
      'ഇരുണ്ട സ്ഥലത്ത് ഫ്ലാഷ് ഓണാക്കുക. തിളങ്ങുന്ന കോഡാണെങ്കിൽ തിളക്കം മാറാൻ ഫോൺ അൽപം ചരിക്കുക.';

  @override
  String get helpGuideFaqCameraBullet3 =>
      'ചെറുതോ ദൂരെയുള്ളതോ ആയ കോഡിന്, വളരെ അടുത്തു പോകുന്നതിനു പകരം സൂം സ്ലൈഡറോ ‘ദൂര സ്കാൻ സഹായം’ ഉപയോഗിക്കുക.';

  @override
  String get helpGuideFaqCameraBullet4 =>
      'ഇരുണ്ട പശ്ചാത്തലത്തിലെ തെളിഞ്ഞ കോഡിന്, ക്യാമറ ക്രമീകരണങ്ങളിൽ ‘നിറങ്ങൾ വിപരീതമാക്കുക’ ഓണാക്കുക.';

  @override
  String get helpGuideFaqCameraBullet5 =>
      'കേടായതോ മങ്ങിയതോ ആയ കോഡിന്, ക്യാമറ ക്രമീകരണങ്ങളിലെ തെളിച്ചവും കോൺട്രാസ്റ്റും നോക്കുക, അല്ലെങ്കിൽ ഫോട്ടോ എടുത്ത് ഗാലറിയിൽ നിന്ന് സ്കാൻ ചെയ്യുക.';

  @override
  String get helpGuideFaqFixTitle => 'മറ്റു പ്രശ്നങ്ങൾ';

  @override
  String get helpGuideFaqFixBullet1 =>
      'ക്യാമറ തുറക്കുന്നില്ല: ക്യാമറയ്ക്ക് അനുമതി നിഷേധിച്ചിട്ടുണ്ടെങ്കിൽ, Android ക്രമീകരണങ്ങൾ > ആപ്പുകൾ > SreerajP QR Studio > അനുമതികൾ > ക്യാമറ എന്നതിൽ ചെന്ന് ‘അനുവദിക്കുക’ തിരഞ്ഞെടുക്കുക.';

  @override
  String get helpGuideFaqFixBullet2 =>
      'വൈ-ഫൈ ബന്ധിപ്പിക്കുന്നില്ല: പാസ്‌വേഡ് പകർത്തി ഫോണിന്റെ വൈ-ഫൈ ക്രമീകരണങ്ങളിൽ നെറ്റ്‌വർക്കിൽ ചേരുക.';

  @override
  String get helpGuideFaqFixBullet3 =>
      'പണമിടപാട് ആപ്പ് തുറക്കുന്നില്ല: ഒരു UPI ആപ്പ് ഇൻസ്റ്റാൾ ചെയ്തിട്ടുണ്ടെന്ന് ഉറപ്പാക്കുക. UPI ഐഡി പകർത്തുകയുമാവാം.';

  @override
  String get helpGuideFaqFixBullet4 =>
      'സ്കാൻ ബബിൾ അപ്രത്യക്ഷമാകുന്നു: ചില ഫോണുകൾ പശ്ചാത്തലത്തിലെ ആപ്പുകൾ നിർത്തും. ഫോണിന്റെ ബാറ്ററി ക്രമീകരണങ്ങളിൽ ഈ ആപ്പിനെ അനുവദിക്കുക.';

  @override
  String get helpGuideFaqFixBullet5 =>
      'ഒരു ഓൺലൈൻ പരിശോധന ഒഴിവാക്കി എന്നു കാണിക്കുന്നു: ആ പരിശോധകൻ ഓഫാണ്, അല്ലെങ്കിൽ കീ ഇല്ല. ശരിയാക്കാൻ ഫലത്തിലെ ‘ക്രമീകരണങ്ങളിൽ സജ്ജമാക്കുക’ തൊടുക.';

  @override
  String get helpGuideFaqTip =>
      'നുറുങ്ങ്: ഇപ്പോഴും പ്രശ്നമുണ്ടോ? കോഡിന്റെ വ്യക്തമായ ഒരു ഫോട്ടോ എടുത്ത് ഗാലറിയിൽ നിന്ന് സ്കാൻ ചെയ്യുക.';

  @override
  String get titleHelpBarcode => 'കോഡ് സ്കാനിംഗ്';

  @override
  String get titleHelpArCodeVision => 'AR കോഡ്‌വിഷൻ';

  @override
  String get titleHelpAirQr => 'എയർ ക്യുആർ സഹായി';

  @override
  String get titleHelpUrlSafety => 'ലിങ്ക് സുരക്ഷ';

  @override
  String get titleHelpQuishing => 'ക്വിഷിംഗ് ഗാർഡ്';

  @override
  String get titleHelpSafeBrowsing => 'ഓൺലൈൻ പരിശോധകർ';

  @override
  String get titleHelpSmartPayloads => 'സ്മാർട്ട് പ്രവർത്തനങ്ങൾ';

  @override
  String get titleHelpHistory => 'നാൾവഴിയും സ്വകാര്യതയും';

  @override
  String get titleHelpFaq => 'പതിവ് ചോദ്യങ്ങൾ';

  @override
  String get titleHelpScanBubble => 'മറ്റ് ആപ്പുകളിൽ നിന്ന്';

  @override
  String get titleHelpCodeForge => 'കോഡ് നിർമ്മാണം';

  @override
  String get titleHelpHiddenCodes => 'പൂട്ടിയ കോഡുകൾ';

  @override
  String get titleHelpSettings => 'ക്രമീകരണ സഹായി';

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

  @override
  String get titleIdCard => 'തിരിച്ചറിയൽ കാർഡ്';

  @override
  String get labelIdCardName => 'പേര്';

  @override
  String get labelIdCardBirthDate => 'ജനനത്തീയതി';

  @override
  String get labelIdCardExpiry => 'കാലാവധി തീരുന്നത്';

  @override
  String get labelIdCardNumber => 'രേഖയുടെ നമ്പർ';

  @override
  String get labelIdCardIssuer => 'നൽകിയത്';

  @override
  String get labelIdCardAddress => 'വിലാസം';

  @override
  String get actionIdCardShowNumber => 'നമ്പർ കാണിക്കുക';

  @override
  String get actionIdCardHideNumber => 'നമ്പർ മറയ്ക്കുക';

  @override
  String get actionIdCardCopy => 'വിവരങ്ങൾ പകർത്തുക';

  @override
  String get bodyIdCardNotSaved =>
      'തിരിച്ചറിയൽ കാർഡ് വിവരങ്ങൾ നാൾവഴിയിൽ സൂക്ഷിക്കുന്നില്ല.';

  @override
  String get helpGuideSmartPayloadsOtherBullet7 =>
      'തിരിച്ചറിയൽ കാർഡ് (യുഎസ് അല്ലെങ്കിൽ കാനഡ ഡ്രൈവിംഗ് ലൈസൻസ്): പേര്, തീയതികൾ, വിലാസം എന്നിവ കാണാം. \'കാണിക്കുക\' അമർത്തുന്നതുവരെ നമ്പർ മറച്ചുവയ്ക്കും. തിരിച്ചറിയൽ കാർഡുകൾ ഒരിക്കലും നാൾവഴിയിൽ സൂക്ഷിക്കില്ല.';
}
