// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get appTitle => 'SreerajP QR Reader';

  @override
  String get wifiCardTitle => 'വൈ-ഫൈ ശൃംഖല';

  @override
  String get wifiShowPassword => 'പാസ്‌വേഡ് കാണിക്കുക';

  @override
  String get wifiHidePassword => 'പാസ്‌വേഡ് മറയ്ക്കുക';

  @override
  String get wifiCopyPassword => 'പാസ്‌വേഡ് പകർത്തുക';

  @override
  String get wifiConnectButton => 'വൈ-ഫൈയിലേക്ക് ബന്ധിപ്പിക്കുക';

  @override
  String get wifiPasswordCopied => 'പാസ്‌വേഡ് ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get wifiOpenSettingsHint =>
      'പാസ്‌വേഡ് പകർത്തി. ബന്ധിപ്പിക്കുന്നതിന് ഉപകരണത്തിലെ വൈ-ഫൈ ക്രമീകരണങ്ങൾ തുറക്കുക.';

  @override
  String wifiConnectSuccess(String ssid) {
    return '$ssid ശൃംഖലയിലേക്ക് ബന്ധിപ്പിക്കാനുള്ള അഭ്യർത്ഥന നൽകി.';
  }

  @override
  String geoLatLng(String latitude, String longitude) {
    return 'അക്ഷാംശം: $latitude, രേഖാംശം: $longitude';
  }

  @override
  String geoQuery(String query) {
    return 'അന്വേഷണം: $query';
  }

  @override
  String get geoNavigateButton => 'ഗൂഗിൾ മാപ്‌സിൽ വഴികാട്ടുക';

  @override
  String get geoLaunchFailed => 'ഗൂഗിൾ മാപ്സ് ആപ്പ് തുറക്കാനായില്ല';

  @override
  String get calendarCardTitle => 'കലണ്ടർ ഇവന്റ്';

  @override
  String get calendarNoDate => 'ലഭ്യമല്ല';

  @override
  String calendarStart(String dateTime) {
    return 'ആരംഭം: $dateTime';
  }

  @override
  String calendarEnd(String dateTime) {
    return 'അവസാനം: $dateTime';
  }

  @override
  String get calendarAddButton => 'ഉപകരണ കലണ്ടറിലേക്ക് ചേർക്കുക';

  @override
  String get calendarLaunchFailed => 'കലണ്ടർ ആപ്പ് തുറക്കാനായില്ല';

  @override
  String get contactCardTitle => 'വിലാസ കാർഡ്';

  @override
  String get contactInitialFallback => 'വ';

  @override
  String get contactSaveButton => 'കോൺടാക്റ്റുകളിലേക്ക് സൂക്ഷിക്കുക';

  @override
  String get contactLaunchFailed => 'കോൺടാക്റ്റ്സ് ആപ്പ് തുറക്കാനായില്ല';

  @override
  String contactCallFailed(String number) {
    return '$number എന്നതിലേക്ക് വിളിക്കാനായില്ല';
  }

  @override
  String contactEmailFailed(String email) {
    return '$email എന്നതിലേക്ക് ഇമെയിൽ ആപ്പ് തുറക്കാനായില്ല';
  }

  @override
  String pdfResultsTitle(int count) {
    return 'പിഡിഎഫ് സ്കാൻ ഫലങ്ങൾ ($count)';
  }

  @override
  String pdfPageBadge(int page) {
    return 'താൾ $page';
  }

  @override
  String pdfPageLabel(int page) {
    return 'താൾ $page';
  }

  @override
  String pdfSaveAllButton(int count) {
    return 'എല്ലാം ചരിത്രത്തിലേക്ക് സൂക്ഷിക്കുക ($count)';
  }

  @override
  String pdfScanNote(int page) {
    return 'പിഡിഎഫിൽ നിന്ന് സ്കാൻ ചെയ്തത് (താൾ $page)';
  }

  @override
  String pdfSavedToHistory(int count) {
    return '$count കോഡുകൾ ചരിത്രത്തിൽ സൂക്ഷിച്ചു.';
  }

  @override
  String get totpDefaultIssuer => 'ദ്വിഘടക പ്രാമാണീകരണം';

  @override
  String totpLivePasscode(int period) {
    return 'തത്സമയ കോഡ് ($periodസെക്കൻഡ് TOTP)';
  }

  @override
  String totpSecondsLeft(int seconds) {
    return '$secondsസെക്കൻഡ്';
  }

  @override
  String get totpCopyToken => 'ടോക്കൺ പകർത്തുക';

  @override
  String get totpSecretLabel => 'രഹസ്യ കീ: ';

  @override
  String get totpImportButton => 'ഓതന്റിക്കേറ്ററിലേക്ക് ചേർക്കുക';

  @override
  String get totpLaunchFailed => 'ഓതന്റിക്കേറ്റർ ആപ്പ് തുറക്കാനായില്ല';

  @override
  String get totpTokenCopied => 'ടോക്കൺ ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get totpSecretCopied => 'രഹസ്യ കീ ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get paymentSchemeUpi => 'യുപിഐ പണമിടപാട്';

  @override
  String get paymentSchemeSepa => 'സെപ്പ കൈമാറ്റം';

  @override
  String get paymentSchemeCrypto => 'ക്രിപ്റ്റോ പണമിടപാട്';

  @override
  String get paymentPayeeFallback => 'വ്യാപാരി / സ്വീകർത്താവ്';

  @override
  String get paymentAddressLabelUpi => 'വിപിഎ / യുപിഐ ഐഡി:';

  @override
  String get paymentAddressLabelSepa => 'ഐബാൻ (IBAN):';

  @override
  String get paymentAddressLabelCrypto => 'വാലറ്റ് വിലാസം:';

  @override
  String get paymentCopyAction => 'പകർത്തുക';

  @override
  String get paymentUpiIdCopied => 'യുപിഐ ഐഡി ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get paymentAddressCopied => 'വിലാസം ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String paymentNote(String note) {
    return 'കുറിപ്പ്: $note';
  }

  @override
  String get paymentPayButtonUpi =>
      'ആപ്പ് വഴി പണം നൽകുക (GPay / PhonePe / Paytm)';

  @override
  String get paymentPayButton => 'ആപ്പ് വഴി പണം നൽകുക';

  @override
  String get paymentUpiLaunchFailed =>
      'യുപിഐ ആപ്പ് തുറക്കാനായില്ല. GPay, PhonePe, അല്ലെങ്കിൽ Paytm ഇൻസ്റ്റാൾ ചെയ്തിട്ടുണ്ടെന്ന് ഉറപ്പാക്കുക.';

  @override
  String get paymentLaunchFailed => 'ഈ പേയ്‌മെന്റ് ആപ്പ് തുറക്കാനായില്ല.';

  @override
  String get paymentCopyIdAction => 'ഐഡി പകർത്തുക';

  @override
  String percentValue(String value) {
    return '$value%';
  }

  @override
  String get quishingGuardTitle => 'ക്വിഷിംഗ് ഗാർഡ്™';

  @override
  String get quishingTamperBadge => 'ഭൗതിക കൃത്രിമം CV';

  @override
  String get quishingRiskScoreLabel => 'കൃത്രിമത്വ സാധ്യത നിരക്ക്:';

  @override
  String get quishingViewSignals => 'ഫോറൻസിക് വിശകലനം കാണുക';

  @override
  String get quishingHideSignals => 'ഫോറൻസിക് സിഗ്നലുകൾ മറയ്ക്കുക';

  @override
  String get quishingMetricEdgeLabel => 'അരികുകളുടെ വിച്ഛേദം';

  @override
  String get quishingMetricEdgeDescription => 'ഇരട്ട അരികുകളും നിഴൽ വരകളും';

  @override
  String get quishingMetricGrainLabel => 'പ്രിന്റ് തരികളും ഡിപിഐയും';

  @override
  String get quishingMetricGrainDescription => 'ഹാഫ്‌ടോൺ ഡോട്ടും വർണ്ണ ശബ്ദവും';

  @override
  String get quishingSignalsHeading => 'കണ്ടെത്തിയ കമ്പ്യൂട്ടർ വിഷൻ സിഗ്നലുകൾ:';

  @override
  String get arCloseSheet => 'അടയ്ക്കുക';

  @override
  String arItemPriceTag(String price) {
    return 'വില വിവരപ്പട്ടിക: $price';
  }

  @override
  String get arContentCopied => 'ഉള്ളടക്കം ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get arCopyButton => 'പകർത്തുക';

  @override
  String get arOpenUrlButton => 'URL തുറക്കുക';

  @override
  String get arSelectButton => 'തിരഞ്ഞെടുക്കുക';

  @override
  String get arDeselectButton => 'ഒഴിവാക്കുക';

  @override
  String get arSafetyStatusSafe => 'സുരക്ഷാ നില: സുരക്ഷിതമെന്ന് സ്ഥിരീകരിച്ചു';

  @override
  String get arSafetyStatusWarning =>
      'സുരക്ഷാ നില: മുന്നറിയിപ്പ് / ഫിഷിംഗ് സാധ്യത';

  @override
  String get arSafetyStatusUnknown => 'സുരക്ഷാ നില: പരിശോധിക്കുന്നു...';

  @override
  String get copiedToClipboard => 'ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String historyTimestamp(String date, String time) {
    return '$date • $time';
  }

  @override
  String get historyStar => 'പ്രിയപ്പെട്ടവയിൽ ചേർക്കുക';

  @override
  String get historyUnstar => 'പ്രിയപ്പെട്ടവയിൽ നിന്ന് മാറ്റുക';

  @override
  String get historyEditNotes => 'കുറിപ്പുകൾ തിരുത്തുക';

  @override
  String get historyCopyString => 'വാചകം പകർത്തുക';

  @override
  String get historyShare => 'പങ്കിടുക';

  @override
  String get historyDelete => 'ഇല്ലാതാക്കുക';

  @override
  String get historyDetailTitle => 'സ്കാൻ രേഖയുടെ വിവരങ്ങൾ';

  @override
  String historySafetyBadge(int score) {
    return '🛡️ $score% സുരക്ഷിതം';
  }

  @override
  String historyScoreBadge(int score) {
    return '🛡️ $score%';
  }

  @override
  String get historyScannedContent => 'സ്കാൻ ചെയ്ത ഉള്ളടക്കം:';

  @override
  String get historyCopyButton => 'പകർത്തുക';

  @override
  String get historyNotesLabel => 'സ്വന്തം കുറിപ്പുകൾ';

  @override
  String get historyNotesHint =>
      'ഈ സ്കാനിനെക്കുറിച്ച് വ്യക്തിഗത കുറിപ്പുകൾ ചേർക്കുക...';

  @override
  String get historyLocationLabel => 'സ്ഥല ടാഗ് (ഐച്ഛികം)';

  @override
  String get historyLocationHint => 'ഉദാ: ഓഫീസ്, സൂപ്പർമാർക്കറ്റ്, സമ്മേളനം';

  @override
  String get historySaveChanges => 'മാറ്റങ്ങൾ സൂക്ഷിക്കുക';

  @override
  String get closeButton => 'അടയ്ക്കുക';

  @override
  String get exportDialogTitle => 'കയറ്റുമതിയും ബാക്കപ്പും';

  @override
  String get restoreDialogTitle =>
      'എൻക്രിപ്റ്റ് ചെയ്ത ബാക്കപ്പ് പുനഃസ്ഥാപിക്കുക';

  @override
  String get exportRecordsTab => 'രേഖകൾ കയറ്റുമതി ചെയ്യുക';

  @override
  String get restoreBackupTab => 'ബാക്കപ്പ് പുനഃസ്ഥാപിക്കുക';

  @override
  String get exportFormatHeading => 'കയറ്റുമതി ഫോർമാറ്റ് തിരഞ്ഞെടുക്കുക:';

  @override
  String get exportCsvTitle => 'CSV ഫോർമാറ്റ് (.csv)';

  @override
  String get exportCsvSubtitle => 'Excel, Sheets എന്നിവയ്ക്ക് അനുയോജ്യം';

  @override
  String get exportJsonTitle => 'JSON ഡാറ്റാസെറ്റ് (.json)';

  @override
  String get exportJsonSubtitle => 'ഡെവലപ്പർ ഫോർമാറ്റ്';

  @override
  String get exportTxtTitle => 'ഫോർമാറ്റ് ചെയ്ത TXT റിപ്പോർട്ട് (.txt)';

  @override
  String get exportTxtSubtitle => 'വായിക്കാവുന്ന സംഗ്രഹ രേഖ';

  @override
  String get exportPdfTitle => 'പിഡിഎഫ് റിപ്പോർട്ട് (.pdf)';

  @override
  String get exportPdfSubtitle => 'പ്രിന്റ് ചെയ്യാവുന്ന പട്ടിക റിപ്പോർട്ട്';

  @override
  String get exportBackupHeading => 'പ്രാദേശിക ബാക്കപ്പ് ഫയൽ (.sreerajqr)';

  @override
  String get exportPassphraseLabel => 'ബാക്കപ്പ് എൻക്രിപ്ഷൻ രഹസ്യവാക്ക്';

  @override
  String get exportPassphraseHint => 'രഹസ്യവാക്ക് നൽകുക...';

  @override
  String get exportPassphraseRequired =>
      'ബാക്കപ്പ് ഫയൽ എൻക്രിപ്റ്റ് ചെയ്യാൻ രഹസ്യവാക്ക് നൽകുക.';

  @override
  String get exportCreateBackupButton =>
      'എൻക്രിപ്റ്റ് ചെയ്ത ബാക്കപ്പ് ഫയൽ നിർമ്മിക്കുക';

  @override
  String get exportShareText => 'ശ്രീരാജ് ക്യുആർ റീഡർ സ്കാൻ ചരിത്ര കയറ്റുമതി';

  @override
  String get exportSharePdfText =>
      'ശ്രീരാജ് ക്യുആർ റീഡർ സ്കാൻ ചരിത്ര റിപ്പോർട്ട് (PDF)';

  @override
  String get exportShareBackupText =>
      'ശ്രീരാജ് ക്യുആർ റീഡർ എൻക്രിപ്റ്റ് ചെയ്ത ബാക്കപ്പ് ഫയൽ';

  @override
  String get restoreHeading =>
      'ബാക്കപ്പ് ഫയലിൽ നിന്ന് ചരിത്രം പുനഃസ്ഥാപിക്കുക:';

  @override
  String get restorePassphraseLabel => 'ബാക്കപ്പ് ഡീക്രിപ്ഷൻ രഹസ്യവാക്ക്';

  @override
  String get restorePayloadLabel => 'ബാക്കപ്പ് വിവരങ്ങൾ (.sreerajqr)';

  @override
  String get restorePayloadHint =>
      'ബാക്കപ്പ് JSON വിവരങ്ങൾ ഇവിടെ ഒട്ടിക്കുക...';

  @override
  String get restoreFieldsRequired =>
      'രഹസ്യവാക്കും ബാക്കപ്പ് വിവരങ്ങളും നൽകുക.';

  @override
  String get restoreButton => 'ഡീക്രിപ്റ്റ് ചെയ്ത് പുനഃസ്ഥാപിക്കുക';

  @override
  String restoreSuccess(int count) {
    return '$count സ്കാൻ രേഖകൾ വിജയകരമായി പുനഃസ്ഥാപിച്ചു!';
  }

  @override
  String restoreFailed(String reason) {
    return 'പുനഃസ്ഥാപിക്കൽ പരാജയപ്പെട്ടു: $reason';
  }

  @override
  String get domSandboxedBadge => 'സാൻഡ്‌ബോക്സ് ചെയ്തത്';

  @override
  String get domTitleInitialFallback => 'വെ';

  @override
  String get domUntitledPage => 'പേരില്ലാത്ത വെബ് പേജ്';

  @override
  String get domThumbnailCaption =>
      'വിഷ്വൽ പ്രിവ്യൂ (സ്ക്രിപ്റ്റുകൾ തടഞ്ഞിരിക്കുന്നു)';

  @override
  String domBlockedBadge(int scripts, int trackers) {
    return 'തടഞ്ഞവ: $scripts സ്ക്രിപ്റ്റുകൾ, $trackers ട്രാക്കറുകൾ';
  }

  @override
  String domNewlyRegistered(int days) {
    return 'പുതിയ രജിസ്ട്രേഷൻ ($daysദിവസം)';
  }

  @override
  String domDomainAge(int days) {
    return 'ഡൊമെയ്ൻ പ്രായം: $days ദിവസങ്ങൾ';
  }

  @override
  String get domOpenRedirectFound => 'ഓപ്പൺ റീഡയറക്റ്റ് കെണി!';

  @override
  String get domNoOpenRedirect => 'ഓപ്പൺ റീഡയറക്റ്റുകൾ ഇല്ല';

  @override
  String get domInspectButton => 'സാൻഡ്‌ബോക്സ് ഘടന പരിശോധിക്കുക';

  @override
  String get domInspectTitle => 'DOM സാൻഡ്‌ബോക്സ് ശ്രേണി';

  @override
  String get domDetailPageTitle => 'പേജ് ശീർഷകം';

  @override
  String get domDetailNotSpecified => 'വ്യക്തമാക്കിയിട്ടില്ല';

  @override
  String get domDetailMetaDescription => 'മെറ്റാ വിവരണം';

  @override
  String get domDetailNoneFound => 'ഒന്നും കണ്ടെത്തിയില്ല';

  @override
  String get domDetailHeadingsCount => 'തലക്കെട്ടുകളുടെ എണ്ണം';

  @override
  String domDetailHeadingsValue(int count) {
    return '$count തലക്കെട്ടുകൾ വേർതിരിച്ചെടുത്തു';
  }

  @override
  String get domDetailLinksFound => 'കണ്ടെത്തിയ ലിങ്കുകൾ';

  @override
  String domDetailLinksValue(int count) {
    return '$count URL-കൾ വേർതിരിച്ചെടുത്തു';
  }

  @override
  String get domDetailBlockedScripts => 'തടഞ്ഞ സ്ക്രിപ്റ്റുകൾ';

  @override
  String domDetailBlockedScriptsValue(int count) {
    return '$count സ്ക്രിപ്റ്റ് ടാഗുകൾ നീക്കം ചെയ്തു';
  }

  @override
  String get domDetailBlockedTrackers => 'തടഞ്ഞ ട്രാക്കറുകൾ';

  @override
  String domDetailBlockedTrackersValue(int count) {
    return '$count ട്രാക്കിംഗ് പിക്സലുകൾ നീക്കം ചെയ്തു';
  }

  @override
  String get domDetailBlockedIframes => 'തടഞ്ഞ ഐഫ്രെയിമുകൾ';

  @override
  String domDetailBlockedIframesValue(int count) {
    return '$count ഉൾച്ചേർത്ത ഘടകങ്ങൾ നീക്കം ചെയ്തു';
  }

  @override
  String get domSanitizedSnippetHeading => 'ശുദ്ധീകരിച്ച HTML പ്രിവ്യൂ:';

  @override
  String get aboutTitle => 'വിവരങ്ങൾ';

  @override
  String aboutVersion(String version, String build) {
    return 'പതിപ്പ് $version+$build';
  }

  @override
  String get aboutBuildDate => 'നിർമ്മാണ തീയതി';

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
  String get aboutMadeWithLove => 'Made with ❤️ from India';

  @override
  String get airQrTransmitterTitle => 'എയർ ക്യുആർ ട്രാൻസ്മിറ്റർ';

  @override
  String get airQrSamplePayload =>
      'എയർ ക്യുആർ ഹൈ-സ്പീഡ് ഒപ്റ്റിക്കൽ ഡാറ്റാ ട്രാൻസ്ഫർ പരീക്ഷണ ഉള്ളടക്കം.';

  @override
  String get airQrPayloadLabel => 'പ്രക്ഷേപണം ചെയ്യേണ്ട വിവരങ്ങൾ';

  @override
  String get airQrPayloadHint => 'ടെക്സ്റ്റ് അല്ലെങ്കിൽ സന്ദേശം നൽകുക...';

  @override
  String get airQrStreamSpeed => 'സ്ട്രീം വേഗത:';

  @override
  String airQrFps(int fps) {
    return '$fps FPS';
  }

  @override
  String get airQrStartStream => 'പ്രക്ഷേപണം ആരംഭിക്കുക';

  @override
  String get airQrStopStream => 'പ്രക്ഷേപണം നിർത്തുക';

  @override
  String airQrFrameParity(int current, int total) {
    return 'ഫ്രെയിം $current/$total [പാരിറ്റി]';
  }

  @override
  String airQrFrameBlock(int current, int total, int block) {
    return 'ഫ്രെയിം $current/$total [ബ്ലോക്ക് $block]';
  }

  @override
  String airQrTotalFrames(int total, int source, int parity) {
    return 'ആകെ ഫ്രെയിമുകൾ: $total ($source ഉറവിടം + $parity പാരിറ്റി)';
  }

  @override
  String get toggleFlashlight => 'ഫ്ലാഷ്‌ലൈറ്റ് മാറ്റുക';

  @override
  String get grantCameraPermission => 'ക്യാമറ അനുമതി നൽകുക';

  @override
  String get arScreenTitle => 'എആർ കോഡ്‌വിഷൻ HUD';

  @override
  String get arInitializing => 'എആർ HUD സജ്ജമാക്കുന്നു...';

  @override
  String get arClearSelection => 'മായ്ക്കുക';

  @override
  String get arBatchCopy => 'മൊത്തമായി പകർത്തുക';

  @override
  String arBatchCopied(int count) {
    return '$count ബാർകോഡുകൾ ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';
  }

  @override
  String get arCameraPermissionMessage =>
      'എആർ കോഡ്‌വിഷന് ക്യാമറ അനുമതി ആവശ്യമാണ്';

  @override
  String get doneButton => 'പൂർത്തിയാക്കുക';

  @override
  String get airQrReceiverTitle => 'എയർ ക്യുആർ റിസീവർ';

  @override
  String get airQrTransmitterTooltip => 'എയർ ക്യുആർ ട്രാൻസ്മിറ്റർ';

  @override
  String get airQrResetStream => 'പുനഃക്രമീകരിക്കുക';

  @override
  String get airQrInitializing => 'എയർ ക്യുആർ റിസീവർ സജ്ജമാക്കുന്നു...';

  @override
  String get airQrStatusReassembled => 'സ്ട്രീം പൂർണ്ണമായി സ്വീകരിച്ചു';

  @override
  String get airQrStatusCapturing => 'ഒപ്റ്റിക്കൽ സ്ട്രീം സ്വീകരിക്കുന്നു...';

  @override
  String get airQrStatusIdle => 'ആനിമേറ്റഡ് ക്യുആറിലേക്ക് ക്യാമറ തിരിക്കുക';

  @override
  String airQrCaptured(int received, int total) {
    return 'ലഭിച്ചവ: $received / $total ബ്ലോക്കുകൾ';
  }

  @override
  String airQrMissing(int count) {
    return 'ബാക്കി: $count';
  }

  @override
  String get airQrTransferComplete => 'ഡാറ്റാ കൈമാറ്റം പൂർത്തിയായി!';

  @override
  String get airQrTransferCompleteDetail =>
      'വിവരങ്ങൾ വിജയകരമായി സ്വീകരിച്ച് സ്ഥിരീകരിച്ചു.';

  @override
  String get airQrPayloadCopied => 'ഉള്ളടക്കം ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get cancelButton => 'റദ്ദാക്കുക';

  @override
  String get historyScreenTitle => 'സ്കാൻ ചരിത്രം';

  @override
  String get historyExportTooltip => 'കയറ്റുമതി / ബാക്കപ്പ്';

  @override
  String get historyClearAll => 'എല്ലാം മായ്ക്കുക';

  @override
  String get historyClearTitle => 'ചരിത്രം മുഴുവൻ മായ്ക്കണമോ?';

  @override
  String get historyClearMessage =>
      'സ്കാൻ ചരിത്രം മുഴുവൻ ഇല്ലാതാക്കണമെന്ന് ഉറപ്പാണോ? ബാക്കപ്പ് എടുത്തിട്ടില്ലെങ്കിൽ ഇത് തിരിച്ചെടുക്കാനാവില്ല.';

  @override
  String get historySearchHint => 'ചരിത്രത്തിൽ തിരയുക...';

  @override
  String get historyFilterAll => 'എല്ലാം';

  @override
  String get historyFilterStarred => 'നക്ഷത്രമിട്ടവ';

  @override
  String get historyFilterUrls => 'ലിങ്കുകൾ';

  @override
  String get historyFilterWifi => 'വൈ-ഫൈ';

  @override
  String get historyFilterContacts => 'കോൺടാക്റ്റുകൾ';

  @override
  String get historyFilterText => 'വാചകം';

  @override
  String get historyFilterBarcodes => 'ബാർകോഡുകൾ';

  @override
  String get historyEmptyTitle => 'സ്കാൻ രേഖകളൊന്നും കണ്ടെത്തിയില്ല';

  @override
  String get historyEmptyMessage =>
      'സ്കാൻ ചെയ്യുന്ന ബാർകോഡുകൾ ഇവിടെ തനിയെ ദൃശ്യമാകും.';

  @override
  String historyNoMatches(String query) {
    return '\"$query\" എന്നതിന് ഫലങ്ങളില്ല';
  }

  @override
  String get moreOptions => 'കൂടുതൽ ഓപ്ഷനുകൾ';

  @override
  String get menuHistory => 'ചരിത്രം';

  @override
  String get menuSettings => 'ക്രമീകരണങ്ങൾ';

  @override
  String get grantPermission => 'അനുമതി നൽകുക';

  @override
  String get scanFromGallery => 'ഗാലറിയിൽ നിന്ന് ചിത്രം സ്കാൻ ചെയ്യുക';

  @override
  String get scanPdfDocument => 'PDF രേഖ സ്കാൻ ചെയ്യുക';

  @override
  String get scanPdfProgress => 'PDF പേജുകൾ വേർതിരിച്ച് സ്കാൻ ചെയ്യുന്നു...';

  @override
  String get scanSharedPdfProgress => 'പങ്കിട്ട PDF രേഖ സ്കാൻ ചെയ്യുന്നു...';

  @override
  String get scanInitializingCamera => 'ക്യാമറ ഒരുക്കുന്നു...';

  @override
  String get scanInitializingFeed => 'ക്യാമറ ദൃശ്യം ഒരുക്കുന്നു...';

  @override
  String get scanTorchTooltip => 'ഫ്ലാഷ്‌ലൈറ്റ് / ടോർച്ച്';

  @override
  String get scanZoomTooltip => 'വലുതാക്കൽ സ്ലൈഡർ';

  @override
  String get scanFlipCameraTooltip => 'ക്യാമറ തിരിക്കുക (മുന്നിൽ/പിന്നിൽ)';

  @override
  String scanZoomValue(String value) {
    return '${value}x';
  }

  @override
  String get scanViewfinderHint =>
      'ക്യുആർ കോഡോ ബാർകോഡോ ഫ്രെയിമിനുള്ളിൽ വെയ്ക്കുക';

  @override
  String get scanCameraPermissionRequired => 'ക്യാമറ അനുമതി ആവശ്യമാണ്';

  @override
  String get copiedLabel => 'പകർത്തി!';

  @override
  String get hideAction => 'മറയ്ക്കുക';

  @override
  String get revealAction => 'കാണിക്കുക';

  @override
  String get openAnywayButton => 'തുറക്കുക';

  @override
  String get resultScreenTitle => 'സ്കാൻ ഫലം';

  @override
  String get resultNoResult => 'ഫലങ്ങളൊന്നുമില്ല';

  @override
  String get resultContentLabel => 'ഉള്ളടക്കം:';

  @override
  String get resultDecoyContentLabel => 'പരസ്യ ഉള്ളടക്കം:';

  @override
  String get resultDetectedType => 'തിരിച്ചറിഞ്ഞ ഇനം:';

  @override
  String get resultTypeStego => 'STEGO-QR (രഹസ്യ ഡ്യുവൽ-ലെയർ)';

  @override
  String get resultRecheckButton => 'വീണ്ടും പരിശോധിക്കുക';

  @override
  String get resultOpenInBrowser => 'ബ്രൗസറിൽ തുറക്കുക';

  @override
  String get resultCopyText => 'ടെക്സ്റ്റ് പകർത്തുക';

  @override
  String get resultCopyDecoyText => 'പരസ്യ ഉള്ളടക്കം പകർത്തുക';

  @override
  String get resultShareText => 'ടെക്സ്റ്റ് പങ്കിടുക';

  @override
  String get resultShareDecoyText => 'പരസ്യ ഉള്ളടക്കം പങ്കിടുക';

  @override
  String get resultScanAnother => 'മറ്റൊരു കോഡ് സ്കാൻ ചെയ്യുക';

  @override
  String get resultLaunchFailed => 'URL തുറക്കാൻ കഴിഞ്ഞില്ല';

  @override
  String get stegoUnlockedMessage =>
      'മറഞ്ഞിരിക്കുന്ന AES-256 ഉള്ളടക്കം വിജയകരമായി ഡീക്രിപ്റ്റ് ചെയ്തു.';

  @override
  String get stegoLockedMessage =>
      'ഈ ക്യുആർ കോഡിൽ മറഞ്ഞിരിക്കുന്ന എൻക്രിപ്റ്റ് ചെയ്ത രഹസ്യമുണ്ട്. കാണാൻ ആധികാരികത ഉറപ്പാക്കുക.';

  @override
  String get stegoBiometricUnlock => 'ബയോമെട്രിക് അൺലോക്ക്';

  @override
  String get stegoPassphrase => 'രഹസ്യവാക്ക്';

  @override
  String get stegoSecretPayload => 'രഹസ്യ ഉള്ളടക്കം:';

  @override
  String get stegoCopySecret => 'രഹസ്യം പകർത്തുക';

  @override
  String get stegoShareSecret => 'രഹസ്യം പങ്കിടുക';

  @override
  String get stegoSecretCopied => 'രഹസ്യം ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get stegoDialogTitleBiometric => 'ബയോമെട്രിക് + രഹസ്യവാക്ക്';

  @override
  String get stegoDialogTitlePassphrase => 'രഹസ്യവാക്ക് നൽകുക';

  @override
  String get stegoDialogMessageBiometric =>
      'ഉള്ളടക്കം കാണുന്നതിനായി രഹസ്യവാക്ക് സ്ഥിരീകരിച്ച് ബയോമെട്രിക് ഉപയോഗിക്കുക.';

  @override
  String get stegoDialogMessagePassphrase =>
      'എൻക്രിപ്റ്റ് ചെയ്യാൻ ഉപയോഗിച്ച രഹസ്യവാക്ക് നൽകുക.';

  @override
  String get stegoUnlockButton => 'തുറക്കുക';

  @override
  String get safetyCheckInProgress => 'സുരക്ഷാ പരിശോധന പുരോഗമിക്കുന്നു';

  @override
  String get safetyAnalysisTitle => 'URL സുരക്ഷാ വിശകലനം';

  @override
  String get safetyAnalyzing => 'സുരക്ഷ പരിശോധിക്കുന്നു...';

  @override
  String safetyIssuesDetected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count സുരക്ഷാ പ്രശ്നങ്ങൾ കണ്ടെത്തി',
      one: '1 സുരക്ഷാ പ്രശ്നം കണ്ടെത്തി',
    );
    return '$_temp0';
  }

  @override
  String get safetyNoIssues => 'പ്രശ്നങ്ങളൊന്നും കണ്ടെത്തിയില്ല';

  @override
  String get safetyTrustSourceHint =>
      'ഉറവിടം വിശ്വസനീയമെങ്കിൽ മാത്രം ഈ ലിങ്ക് തുറക്കുക';

  @override
  String get safetyIssuesWarning =>
      'സുരക്ഷാ പ്രശ്നങ്ങൾ കണ്ടെത്തി. വ്യക്തിഗത വിവരങ്ങൾ നൽകുകയോ ഫയലുകൾ ഡൗൺലോഡ് ചെയ്യുകയോ ചെയ്യരുത്';

  @override
  String get safetyResultsHeading => 'സുരക്ഷാ വിശകലന ഫലങ്ങൾ:';

  @override
  String get probingBannerActive =>
      'സജീവ ഓൺലൈൻ പരിശോധനകൾ ഓണാണ്: ഈ സൈറ്റുമായി നേരിട്ട് ബന്ധപ്പെട്ടു, നിങ്ങളുടെ IP വിലാസം വെളിപ്പെട്ടു.';

  @override
  String get probingBannerPrivate =>
      'സ്വകാര്യ മോഡ്: പ്രാദേശിക നിയമങ്ങളും ഗൂഗിൾ സേഫ് ബ്രൗസിംഗും മാത്രമേ ഉപയോഗിച്ചിട്ടുള്ളൂ — സൈറ്റുമായി നേരിട്ട് ബന്ധപ്പെട്ടിട്ടില്ല.';

  @override
  String get warningDialogTitle => 'സുരക്ഷാ മുന്നറിയിപ്പ്';

  @override
  String get warningDialogMessage =>
      'ഈ URL സുരക്ഷാ പ്രശ്നങ്ങൾ ഉള്ളതാണ്. ഇത് തുറക്കുന്നത് അപകടകരമാകാം.\n\nതുടരണമെന്ന് ഉറപ്പാണോ?';

  @override
  String get cautionDialogTitle => 'ശ്രദ്ധിക്കുക';

  @override
  String get cautionDialogMessage =>
      'ക്യുആർ കോഡിലെ ലിങ്കുകൾ തുറക്കുന്നതിന് മുൻപ് ഉറപ്പാക്കുക.\n\nഈ ലിങ്ക് തുറക്കണമോ?';

  @override
  String get overlayLaserLine => 'ലേസർ വര';

  @override
  String get overlayPulsingCorners => 'മിന്നുന്ന കോണുകൾ';

  @override
  String get overlayCyberneticGrid => 'സൈബർ ഗ്രിഡ്';

  @override
  String get overlaySubtleDotMatrix => 'ഡോട്ട് മാട്രിക്സ്';

  @override
  String get overlayLaserLineDesc => 'ലേസർ രശ്മിയോടു കൂടിയ സ്കാൻ ബോക്സ്';

  @override
  String get overlayPulsingCornersDesc => 'മിന്നുന്ന പ്രകാശ കോണുകൾ';

  @override
  String get overlayCyberneticGridDesc =>
      'ആധുനിക സയൻസ് ഫിക്ഷൻ ശൈലിയിലുള്ള ഗ്രിഡ്';

  @override
  String get overlaySubtleDotMatrixDesc => 'ലളിതമായ ബിന്ദു രൂപകൽപ്പന';

  @override
  String get themeSystemDefault => 'സിസ്റ്റം സ്വതവേയുള്ളത്';

  @override
  String get themeLight => 'ലൈറ്റ് തീം';

  @override
  String get themeDark => 'ഡാർക്ക് തീം';

  @override
  String get themeOled => 'OLED പ്യുവർ ബ്ലാക്ക്';

  @override
  String get themeModeHeading => 'തീം മോഡ്';

  @override
  String get themeChipSystem => 'സിസ്റ്റം';

  @override
  String get themeChipLight => 'ലൈറ്റ്';

  @override
  String get themeChipDark => 'ഡാർക്ക്';

  @override
  String get themeChipOled => 'OLED';

  @override
  String get themeDynamicColorsTitle => 'മെറ്റീരിയൽ യു ഡൈനാമിക് നിറങ്ങൾ';

  @override
  String get themeDynamicColorsSubtitle =>
      'ആൻഡ്രോയിഡ് 12+ വാൾപേപ്പർ നിറങ്ങൾ ഉപയോഗിക്കുക (മോനെ എഞ്ചിൻ)';

  @override
  String get themeDescSystem => 'സിസ്റ്റം ക്രമീകരണങ്ങൾ പിന്തുടരുക';

  @override
  String get themeDescLight => 'സാധാരണ ലൈറ്റ് മോഡ്';

  @override
  String get themeDescDark => 'സാധാരണ ഡാർക്ക് മോഡ്';

  @override
  String get themeDescOled =>
      'യഥാർത്ഥ OLED പ്യുവർ ബ്ലാക്ക് (ബാറ്ററി ലാഭിക്കാം)';

  @override
  String get settingsTitle => 'ക്രമീകരണങ്ങൾ';

  @override
  String get settingsAppearanceTitle => 'രൂപഭംഗിയും തീമും';

  @override
  String get settingsOverlayTitle => 'സ്കാൻ ഓവർലേ ശൈലി';

  @override
  String get settingsFeedbackTitle => 'പ്രതികരണവും മുന്നറിയിപ്പുകളും';

  @override
  String get settingsPrivacyTitle => 'സ്വകാര്യതയും നെറ്റ്‌വർക്ക് പരിശോധനയും';

  @override
  String get settingsSafeBrowsingTitle => 'ഗൂഗിൾ സേഫ് ബ്രൗസിംഗ് API';

  @override
  String get settingsPermissionsTitle => 'അനുമതികൾ';

  @override
  String get settingsPermissionsSubtitle =>
      'പ്രത്യേകവും അന്തർലീനവുമായ അനുമതികളുടെ വിവരങ്ങൾ';

  @override
  String get settingsHelpTitle => 'സഹായവും സവിശേഷതകളും';

  @override
  String get settingsHelpSubtitle =>
      'AR കോഡ്‌വിഷൻ, എയർ ക്യുആർ, ക്വിഷിംഗ് ഗാർഡ്, സുരക്ഷ';

  @override
  String get settingsAboutSubtitle =>
      'ആപ്പ് പതിപ്പ്, നിർമ്മാതാവ്, ലൈസൻസ് വിവരങ്ങൾ';

  @override
  String get feedbackVibrationTitle => 'വൈബ്രേഷൻ പ്രതികരണം';

  @override
  String get feedbackVibrationSubtitle =>
      'കോഡ് സ്കാൻ ചെയ്യുമ്പോൾ ഫോൺ വൈബ്രേറ്റ് ചെയ്യുക';

  @override
  String get feedbackSoundTitle => 'ശബ്ദ പ്രതികരണം (ബീപ്പ്)';

  @override
  String get feedbackSoundSubtitle =>
      'കോഡ് തിരിച്ചറിയുമ്പോൾ ചെറിയ ശബ്ദം കേൾപ്പിക്കുക';

  @override
  String get feedbackAnimationTitle => 'സ്ഥിരീകരണ ആനിമേഷൻ';

  @override
  String get feedbackAnimationSubtitle =>
      'കോഡ് സ്കാൻ ചെയ്യുമ്പോൾ റെറ്റിക്കിൾ പൾസും ചിഹ്നവും കാണിക്കുക';

  @override
  String get privacyScreenTitle => 'സ്വകാര്യതയും നെറ്റ്‌വർക്ക് പരിശോധനയും';

  @override
  String get privacyActiveChecksTitle => 'ഓൺലൈൻ പരിശോധനകൾ';

  @override
  String get privacySummaryOn => 'ഓൺലൈൻ പരിശോധനകൾ സജീവമാണ്';

  @override
  String get privacySummaryOff => 'ഓഫ്‌ലൈൻ സ്വകാര്യ പരിശോധനകൾ മാത്രം';

  @override
  String get apiKeyConfigured => 'ക്രമീകരിച്ചിരിക്കുന്നു';

  @override
  String get apiKeyNotConfigured => 'ക്രമീകരിച്ചിട്ടില്ല';

  @override
  String get apiKeySaved => 'API കീ സുരക്ഷിതമായി സൂക്ഷിച്ചു';

  @override
  String get apiKeyDeleted => 'API കീ നീക്കംചെയ്തു';

  @override
  String get apiKeyDeleteTitle => 'API കീ നീക്കംചെയ്യുക';

  @override
  String get deleteButton => 'ഇല്ലാതാക്കുക';

  @override
  String get apiAboutHeading => 'സേഫ് ബ്രൗസിംഗ് API കുറിച്ച്';

  @override
  String get apiKeyConfiguredTitle => 'API കീ സജ്ജമാണ്';

  @override
  String get apiKeyConfiguredSubtitle => 'വ്യാജ URL പരിശോധന സജീവമാണ്';

  @override
  String get apiLimitReached => 'ഇന്നത്തെ പരിധി കഴിഞ്ഞു. നാളെ പുനഃസ്ഥാപിക്കും.';

  @override
  String get apiLimitApproaching => 'പ്രതിദിന പരിധി പൂർത്തിയാകുന്നു';

  @override
  String get apiKeyFieldLabel => 'API കീ';

  @override
  String get apiKeyFieldHint => 'നിങ്ങളുടെ ഗൂഗിൾ സേഫ് ബ്രൗസിംഗ് API കീ നൽകുക';

  @override
  String get apiKeyRequired => 'ദയവായി API കീ നൽകുക';

  @override
  String get apiKeyTooShort => 'API കീക്ക് ആവശ്യമായ നീളമില്ല';

  @override
  String get apiKeySaveButton => 'API കീ സംരക്ഷിക്കുക';

  @override
  String get apiHowToHeading => 'API കീ എങ്ങനെ സ്വന്തമാക്കാം';

  @override
  String get apiStep1Title => 'ഗൂഗിൾ ക്ലൗഡ് കൺസോളിൽ പോകുക';

  @override
  String get apiStep1Desc => 'console.cloud.google.com സന്ദർശിക്കുക';

  @override
  String get apiStep2Title =>
      'പ്രോജക്റ്റ് തിരഞ്ഞെടുക്കുക അല്ലെങ്കിൽ നിർമ്മിക്കുക';

  @override
  String get apiStep2Desc =>
      'നിലവിലുള്ള പ്രോജക്റ്റ് തിരഞ്ഞെടുക്കുക അല്ലെങ്കിൽ പുതിയത് ഉണ്ടാക്കുക';

  @override
  String get apiStep3Title => 'സേഫ് ബ്രൗസിംഗ് API പ്രവർത്തനക്ഷമമാക്കുക';

  @override
  String get apiStep4Title => 'ക്രെഡൻഷ്യലുകൾ നിർമ്മിക്കുക';

  @override
  String get apiStep4Desc =>
      'Credentials → Create Credentials → API Key വഴി നൽകുക';

  @override
  String get apiStep5Title => 'പകർത്തി ഒട്ടിക്കുക';

  @override
  String get apiStep5Desc => 'ലഭിച്ച API കീ ഇവിടെ പകർത്തി നൽകുക';

  @override
  String get apiFreeTierNote =>
      'സൗജന്യ പ്ലാനിൽ പ്രതിദിനം 10,000 അഭ്യർത്ഥനകൾ ലഭ്യമാണ്';

  @override
  String get permissionsScreenTitle => 'അനുമതി വിവരങ്ങൾ';

  @override
  String get permissionsExplicitHeading => 'പ്രത്യേക അനുമതികൾ (റൺടൈം)';

  @override
  String get permissionCameraTitle =>
      'ക്യാമറ അനുമതി (android.permission.CAMERA)';

  @override
  String get permissionCameraDesc =>
      'സ്കാൻ ചെയ്യുന്ന വേളയിൽ മാത്രം ചോദിക്കുന്നു. ലൈവ് സ്കാനിംഗ്, AR ഹഡ്, എയർ ക്യുആർ ഡീകോഡിംഗ് എന്നിവയ്ക്ക് ആവശ്യമാണ്.';

  @override
  String get permissionBiometricTitle =>
      'ബയോമെട്രിക് അനുമതി (android.permission.USE_BIOMETRIC)';

  @override
  String get permissionBiometricDesc =>
      'സുരക്ഷിത വോൾട്ടുകളും എൻക്രിപ്റ്റ് ചെയ്ത ക്യുആർ കോഡുകളും അൺലോക്ക് ചെയ്യാൻ ഉപയോഗിക്കുന്നു.';

  @override
  String get permissionsImplicitHeading => 'അന്തർലീന സിസ്റ്റം അനുമതികൾ';

  @override
  String get permissionInternetTitle =>
      'ഇന്റർനെറ്റ് അനുമതി (android.permission.INTERNET)';

  @override
  String get permissionInternetDesc =>
      'ഓൺലൈൻ പരിശോധനയോ ഗൂഗിൾ സേഫ് ബ്രൗസിംഗ് APIയോ സജീവമാക്കുമ്പോൾ മാത്രം ഉപയോഗിക്കുന്നു.';

  @override
  String get permissionVibrateTitle =>
      'വൈബ്രേഷൻ അനുമതി (android.permission.VIBRATE)';

  @override
  String get permissionVibrateDesc =>
      'സ്കാൻ ചെയ്യുമ്പോഴും ബട്ടണുകൾ അമർത്തുമ്പോഴും ഹാപ്റ്റിക് വൈബ്രേഷൻ നൽകാൻ ഉപയോഗിക്കുന്നു.';

  @override
  String get permissionPhotoPickerTitle => 'ഫോട്ടോ പിക്കർ അനുമതി';

  @override
  String get permissionPhotoPickerDesc =>
      'ഫോൺ സ്റ്റോറേജ് മുഴുവൻ നൽകാതെ തന്നെ ഗാലറിയിൽ നിന്ന് ചിത്രങ്ങളോ വീഡിയോകളോ തിരഞ്ഞെടുക്കാം.';

  @override
  String get permissionsSettingHeading =>
      'ക്രമീകരണങ്ങളെ അടിസ്ഥാനമാക്കിയുള്ള അനുമതികൾ';

  @override
  String get permissionProbingTitle => 'ഓൺലൈൻ നെറ്റ്‌വർക്ക് പരിശോധന';

  @override
  String get permissionProbingDesc =>
      'സജീവമാക്കുമ്പോൾ മാത്രം വെബ്‌സൈറ്റുകളിലേക്ക് സുരക്ഷിത കണക്ഷൻ വഴി റീഡയറക്‌ട് വിവരങ്ങൾ അറിയാൻ ശ്രമിക്കുന്നു. ഓഫാക്കിയാൽ 100% ഓഫ്‌ലൈൻ.';

  @override
  String get permissionSafeBrowsingTitle => 'ഗൂഗിൾ സേഫ് ബ്രൗസിംഗ് API';

  @override
  String get permissionSafeBrowsingDesc =>
      'API കീ നൽകുമ്പോൾ മാത്രം സുരക്ഷാ വിവരങ്ങൾക്കായി ഗൂഗിൾ ഭീഷണി ഡാറ്റാബേസിൽ പരിശോധിക്കുന്നു.';

  @override
  String get permissionFeedbackTitle => 'സ്കാൻ വൈബ്രേഷൻ ഫീഡ്‌ബാക്ക്';

  @override
  String get permissionFeedbackDesc =>
      'ക്രമീകരണങ്ങളിൽ വൈബ്രേഷൻ ഓൺ ചെയ്യുമ്പോൾ മാത്രം പ്രവർത്തിക്കുന്നു.';

  @override
  String get helpArBadge => 'ഓഗ്‌മെന്റഡ് റിയാലിറ്റി';

  @override
  String get helpArDesc =>
      'ക്യാമറ വ്യൂഫൈൻഡറിൽ ബാർകോഡുകളും ക്യുആർ കോഡുകളും നേരിട്ട് അടയാളപ്പെടുത്തി കാണിക്കുന്നു.';

  @override
  String get helpArPoint1 => 'ഒന്നിലധികം കോഡുകൾ ഒരേസമയം തിരിച്ചറിയുന്നു.';

  @override
  String get helpArPoint2 =>
      'ഓരോ കോഡിനും മുകളിലായി ഇന്ററാക്ടീവ് ചിപ്പുകൾ കാണിക്കുന്നു.';

  @override
  String get helpArPoint3 =>
      'ക്യാമറയിൽ നിന്ന് മാറാതെ തന്നെ വിവരങ്ങൾ കാണാനും പകർത്താനും കഴിയും.';

  @override
  String get helpArPoint4 =>
      'ഫ്ലാഷ്‌ലൈറ്റ്, ക്യാമറ തിരിക്കൽ, സൂം നിയന്ത്രണങ്ങൾ എന്നിവ ലഭ്യമാണ്.';

  @override
  String get helpAirQrBadge => 'ഒപ്റ്റിക്കൽ ഡാറ്റാ കൈമാറ്റം';

  @override
  String get helpAirQrDesc =>
      'ചലിക്കുന്ന ക്യുആർ ഫ്രെയിമുകൾ വഴി വലിയ ഫയലുകൾ ഒപ്റ്റിക്കലായി കൈമാറുന്നു.';

  @override
  String get helpAirQrPoint1 =>
      'തുടർച്ചയായ ഫ്രെയിമുകൾ സ്കാൻ ചെയ്ത് പൂർണ്ണ വിവരങ്ങൾ വീണ്ടെടുക്കുന്നു.';

  @override
  String get helpAirQrPoint2 =>
      'തത്സമയ പുരോഗതിയും വേഗതയും ശതമാനവും കാണിക്കുന്നു.';

  @override
  String get helpAirQrPoint3 =>
      'ക്യാമറ സ്കാനിംഗും വീഡിയോ/ചിത്രം ഇംപോർട്ടും പിന്തുണയ്ക്കുന്നു.';

  @override
  String get helpAirQrPoint4 =>
      'മറ്റു ഫോണുകളിലേക്ക് അയയ്ക്കാൻ എയർ ക്യുആർ ട്രാൻസ്മിറ്റർ മോഡ്.';

  @override
  String get helpQuishingTitle => 'ക്വിഷിംഗ് ഗാർഡ് (വ്യാജ സ്റ്റിക്കർ പരിശോധന)';

  @override
  String get helpQuishingBadge => 'ഓൺ-ഡിവൈസ് കമ്പ്യൂട്ടർ വിഷൻ';

  @override
  String get helpQuishingDesc =>
      'യഥാർത്ഥ കോഡിനു മുകളിൽ ഒട്ടിച്ച വ്യാജ ക്യുആർ സ്റ്റിക്കറുകൾ ഫോണിൽ തന്നെ പരിശോധിക്കുന്നു.';

  @override
  String get helpQuishingPoint1 =>
      '100% ഓഫ്‌ലൈൻ: ഇന്റർനെറ്റ് ആവശ്യമില്ലാതെ ഫോണിൽ പ്രവർത്തിക്കുന്നു.';

  @override
  String get helpQuishingPoint2 =>
      'മുകളിൽ പതിപ്പിച്ച വ്യാജ സ്റ്റിക്കറുകൾ തിരിച്ചറിയുന്നു.';

  @override
  String get helpQuishingPoint3 =>
      'അരികുകളുടെയും കോണുകളുടെയും വ്യത്യാസങ്ങൾ കണ്ടെത്തുന്നു.';

  @override
  String get helpQuishingPoint4 =>
      'പ്രിന്റ് ഗുണനിലവാരവും വ്യത്യാസങ്ങളും വിശകലനം ചെയ്യുന്നു.';

  @override
  String get helpUrlTitle => 'URL സുരക്ഷാ പരിശോധന';

  @override
  String get helpUrlBadge => '6-തല ഡിജിറ്റൽ സുരക്ഷ';

  @override
  String get helpUrlDesc =>
      'വ്യാജ വെബ് ലിങ്കുകൾ, ഫിഷിംഗ്, ലിങ്ക് തട്ടിപ്പുകൾ എന്നിവയിൽ നിന്ന് പൂർണ്ണ സുരക്ഷ.';

  @override
  String get helpUrlPoint1 =>
      'ഹോമോഗ്രാഫ് തട്ടിപ്പുകളും വ്യാജ അക്ഷരങ്ങളും കണ്ടെത്തുന്നു.';

  @override
  String get helpUrlPoint2 =>
      'സീറോ വിഡ്ത്ത് സ്പേസുകളും അദൃശ്യ അക്ഷരങ്ങളും പരിശോധിക്കുന്നു.';

  @override
  String get helpUrlPoint3 =>
      'സംശയാസ്പദമായ IP വിലാസങ്ങളും യൂസർ വിവരങ്ങളും കണ്ടെത്തുന്നു.';

  @override
  String get helpUrlPoint4 =>
      'അപകടസാധ്യതയുള്ള ഡൊമെയ്‌നുകളും സുരക്ഷിതമല്ലാത്ത കണക്ഷനുകളും തിരിച്ചറിയുന്നു.';

  @override
  String get helpUrlPoint5 =>
      'ചെറുതാക്കിയ ലിങ്കുകൾ പൂർണ്ണമായി പരിശോധിക്കുന്നു.';

  @override
  String get helpUrlPoint6 =>
      'ഗൂഗിൾ ഭീഷണി ഡാറ്റാബേസ് പരിശോധന (API കീ നൽകിയാൽ).';

  @override
  String get helpUrlPoint7 =>
      'സ്വകാര്യ പരിശോധനകൾ ഫോണിൽ തന്നെ 100% ഓഫ്‌ലൈനായി നടക്കുന്നു.';

  @override
  String get helpCapabilitiesHeading => 'പ്രധാന സവിശേഷതകൾ:';

  @override
  String get onLabel => 'ഓൺ';

  @override
  String get offLabel => 'ഓഫ്';

  @override
  String get unknownLabel => 'അജ്ഞാതം';

  @override
  String get privacyActiveChecksSubtitle =>
      'ഓഫ്: സ്കാൻ ചെയ്യുന്ന ലിങ്കുകൾ സ്വകാര്യമായി പരിശോധിക്കുന്നു — സർവറുമായി ബന്ധപ്പെടില്ല.';

  @override
  String get privacyExplainerOn =>
      'ഓൺ ചെയ്യുമ്പോൾ, SSL, റീഡയറക്‌ട് എന്നിവ പരിശോധിക്കാൻ സൈറ്റിലേക്ക് നേരിട്ട് കണക്റ്റുചെയ്യുന്നു. ഇത് നിങ്ങളുടെ IP വിലാസം വെളിപ്പെടുത്താം.';

  @override
  String get privacyExplainerOff =>
      'പ്രാദേശിക നിയമങ്ങൾ മാത്രമുപയോഗിച്ച് സുരക്ഷിതമായി പരിശോധിക്കുന്നു. ലിങ്കുകൾ മൂന്നാം കക്ഷി സെർവറുകളിലേക്ക് അയയ്ക്കില്ല.';

  @override
  String get apiKeyDeleteMessage =>
      'നിങ്ങളുടെ ഗൂഗിൾ സേഫ് ബ്രൗസിംഗ് API കീ നീക്കംചെയ്യണമെന്ന് ഉറപ്പാണോ? തുടർന്ന് ഓൺലൈൻ സുരക്ഷാ പരിശോധന പ്രവർത്തനരഹിതമാകും.';

  @override
  String get apiAboutBody =>
      'ഗൂഗിൾ സേഫ് ബ്രൗസിംഗ് API ഫിഷിംഗ്, മാൽവെയർ ഭീഷണികൾ കണ്ടെത്താൻ സഹായിക്കുന്നു. നിങ്ങളുടെ API കീ പൂർണ്ണമായും എൻക്രിപ്റ്റ് ചെയ്ത് ഫോണിൽ സൂക്ഷിക്കുന്നു.';

  @override
  String get apiTodaysUsage => 'ഇന്നത്തെ ഉപയോഗം';

  @override
  String get apiStep3Desc =>
      '\"Safe Browsing API\" തിരഞ്ഞ് പ്രവർത്തനക്ഷമമാക്കുക';

  @override
  String feedbackSummary(String vibration, String sound) {
    return 'വൈബ്രേഷൻ: $vibration • ശബ്ദം: $sound';
  }

  @override
  String settingsApiKeySubtitle(String status) {
    return 'API കീ: $status';
  }

  @override
  String apiKeySaveFailed(String error) {
    return 'API കീ സംരക്ഷിക്കാൻ കഴിഞ്ഞില്ല: $error';
  }

  @override
  String apiKeyDeleteFailed(String error) {
    return 'API കീ നീക്കംചെയ്യാൻ കഴിഞ്ഞില്ല: $error';
  }

  @override
  String apiDailyLimit(int count) {
    return 'പ്രതിദിന പരിധി: $count അഭ്യർത്ഥനകൾ';
  }

  @override
  String apiResets(String date) {
    return 'പുനഃസ്ഥാപനം: $date';
  }

  @override
  String get resultTypeTextFallback => 'ടെക്സ്റ്റ്';

  @override
  String get checkNameHttps => 'HTTPS കണക്ഷൻ';

  @override
  String get checkNameSsl => 'SSL/TLS സർട്ടിഫിക്കറ്റ്';

  @override
  String get checkNameRedirect => 'റീഡയറക്റ്റ് വിശകലനം';

  @override
  String get checkNamePattern => 'പാറ്റേൺ കണ്ടെത്തൽ';

  @override
  String get checkNameShortener => 'URL ചുരുക്കൽ പരിശോധന';

  @override
  String get checkNameHomograph => 'ഹോമോഗ്രാഫ് തട്ടിപ്പ് പരിശോധന';

  @override
  String get checkNameMalicious => 'ക്ഷുദ്ര ഉള്ളടക്ക പരിശോധന';

  @override
  String get httpsNotUsed => 'സുരക്ഷിതമല്ലാത്ത HTTP കണക്ഷനാണ് ഉപയോഗിക്കുന്നത്';

  @override
  String get sslPrivateModeOk =>
      'HTTPS ഉപയോഗിക്കുന്നു (സ്വകാര്യ മോഡിൽ തത്സമയ സർട്ടിഫിക്കറ്റ് പരിശോധിച്ചിട്ടില്ല)';

  @override
  String get sslValid => 'സാധുവായ SSL സർട്ടിഫിക്കറ്റ്';

  @override
  String get sslExpired => 'SSL സർട്ടിഫിക്കറ്റിന്റെ കാലാവധി കഴിഞ്ഞു';

  @override
  String get sslNotYetValid => 'SSL സർട്ടിഫിക്കറ്റ് ഇതുവരെ സാധുവല്ല';

  @override
  String get sslUnverifiable => 'സർട്ടിഫിക്കറ്റ് സ്ഥിരീകരിക്കാനായില്ല';

  @override
  String get sslCheckFailed => 'സർട്ടിഫിക്കറ്റ് പരിശോധന പരാജയപ്പെട്ടു';

  @override
  String get redirectSkippedPrivate =>
      'സ്വകാര്യ മോഡിൽ ഒഴിവാക്കി (സെർവറുമായി ബന്ധപ്പെട്ടില്ല)';

  @override
  String get redirectLoop => 'റീഡയറക്റ്റ് ലൂപ്പ് കണ്ടെത്തി';

  @override
  String get redirectNone => 'റീഡയറക്റ്റുകളൊന്നും കണ്ടെത്തിയില്ല';

  @override
  String get redirectUnavailable => 'റീഡയറക്റ്റുകൾ പരിശോധിക്കാനായില്ല';

  @override
  String get patternNone => 'സംശയാസ്പദമായ പാറ്റേണുകളൊന്നും കണ്ടെത്തിയില്ല';

  @override
  String get patternUnavailable => 'പാറ്റേണുകൾ വിശകലനം ചെയ്യാനായില്ല';

  @override
  String get shortenerOfflineHeuristics =>
      'പൂർണ്ണ പരിശോധന സാധ്യമല്ല (ഓഫ്‌ലൈൻ) - അനുമാനങ്ങൾ മാത്രം';

  @override
  String get shortenerNone => 'ചുരുക്കിയ ലിങ്കല്ല';

  @override
  String get shortenerUnavailable => 'ചുരുക്കിയ ലിങ്കുകൾ പരിശോധിക്കാനായില്ല';

  @override
  String get homographMixedScripts => 'സമ്മിശ്ര ലിപികൾ കണ്ടെത്തി';

  @override
  String get homographNone => 'വ്യാജ രൂപസാദൃശ്യ അക്ഷരങ്ങളില്ല';

  @override
  String get homographUnavailable => 'ഹോമോഗ്രാഫുകൾ പരിശോധിക്കാനായില്ല';

  @override
  String get maliciousSkippedNoKey => 'ഒഴിവാക്കി (API കീ ക്രമീകരിച്ചിട്ടില്ല)';

  @override
  String get maliciousDailyLimit =>
      'പ്രതിദിന API പരിധി കഴിഞ്ഞു (നാളെ പുനഃസ്ഥാപിക്കും)';

  @override
  String get maliciousNone => 'അറിയപ്പെടുന്ന ഭീഷണികളൊന്നും കണ്ടെത്തിയില്ല';

  @override
  String get maliciousInvalidKey => 'അസാധുവായ API കീ അല്ലെങ്കിൽ അഭ്യർത്ഥന';

  @override
  String get maliciousRateLimited => 'അഭ്യർത്ഥനകളുടെ പരിധി കവിഞ്ഞു';

  @override
  String get maliciousUnavailable => 'ക്ഷുദ്ര ഉള്ളടക്കം പരിശോധിക്കാനായില്ല';

  @override
  String get stegoWrongPassphrase =>
      'ഡീക്രിപ്ഷൻ പരാജയപ്പെട്ടു. തെറ്റായ രഹസ്യവാക്ക് അല്ലെങ്കിൽ തകരാറിലായ ഡാറ്റ.';

  @override
  String get airQrChecksumFailed => 'ഡാറ്റാ സ്ഥിരീകരണം പരാജയപ്പെട്ടു.';

  @override
  String redirectSuspiciousChain(String count) {
    return 'സംശയാസ്പദമായ റീഡയറക്റ്റ് ശൃംഖല ($count റീഡയറക്റ്റുകൾ)';
  }

  @override
  String redirectWithinRange(String count) {
    return '$count റീഡയറക്റ്റ് - സാധാരണ പരിധിയിലാണ്';
  }

  @override
  String patternDetected(String patterns) {
    return 'കണ്ടെത്തിയവ: $patterns';
  }

  @override
  String shortenerKnown(String shortener) {
    return 'അറിയപ്പെടുന്ന ചുരുക്കിയ URL കണ്ടെത്തി ($shortener)';
  }

  @override
  String shortenerRedirect(String host) {
    return 'ചുരുക്കിയ ലിങ്ക് കണ്ടെത്തി ($host എന്നതിലേക്ക് നയിക്കുന്നു)';
  }

  @override
  String homographLookalikes(String characters) {
    return 'രൂപസാദൃശ്യ അക്ഷരങ്ങൾ കണ്ടെത്തി: $characters';
  }

  @override
  String maliciousThreats(String threats) {
    return 'ഭീഷണികൾ കണ്ടെത്തി: $threats';
  }

  @override
  String maliciousApiError(String status) {
    return 'API പിശക് (പദവി: $status)';
  }

  @override
  String get quishingSummaryAuthentic =>
      'യഥാർത്ഥ പ്രിന്റ് ചെയ്ത കോഡ്. ഭൗതിക കൃത്രിമത്വം കണ്ടെത്തിയില്ല.';

  @override
  String get quishingSummaryWearAndTear =>
      'തേയ്മാനം കണ്ടെത്തി. ഉപരിതലത്തിൽ ചെറിയ മാറ്റങ്ങൾ കാണുന്നു.';

  @override
  String get quishingSummaryHighWarning =>
      'ഉയർന്ന മുന്നറിയിപ്പ്: ഭൗതിക സ്റ്റിക്കർ പതിച്ചതായി കണ്ടെത്തി! തുറക്കും മുൻപ് സ്ഥിരീകരിക്കുക.';

  @override
  String get quishingStatusAuthentic => '🟢 യഥാർത്ഥ പ്രിന്റ് ചെയ്ത കോഡ്';

  @override
  String get quishingStatusWearAndTear => '🟡 തേയ്മാനം കണ്ടെത്തി';

  @override
  String get quishingStatusHighWarning =>
      '🔴 ഉയർന്ന മുന്നറിയിപ്പ്: ഭൗതിക സ്റ്റിക്കർ കണ്ടെത്തി!';

  @override
  String get quishingSignalMicroShadowPerimeter =>
      'മാട്രിക്സ് ചുറ്റളവിൽ ചെറിയ നിഴൽ വര കണ്ടെത്തി';

  @override
  String get quishingSignalGrainAberration =>
      'പ്രിന്റ് തരികളുടെ പൊരുത്തക്കേട് കണ്ടെത്തി';

  @override
  String get quishingSignalUniformReflection => 'പ്രതല പ്രതിഫലനം സ്ഥിരീകരിച്ചു';

  @override
  String get quishingSignalConsistentDotsQrMatrix =>
      'ക്യുആർ മാട്രിക്സിൽ ഒരേപോലെയുള്ള ഡോട്ട് സാന്ദ്രത';

  @override
  String get quishingSignalReflectionVerified =>
      'പ്രതല പ്രതിഫലനം സ്ഥിരീകരിച്ചു';

  @override
  String get quishingSignalHalftoneConsistentQrMatrix =>
      'മാട്രിക്സ് ചുറ്റളവിൽ കൃത്യമായ ഡോട്ട് സാന്ദ്രത';

  @override
  String get quishingSignalHalftoneConsistentMatrix =>
      'മാട്രിക്സിൽ ഉടനീളം കൃത്യമായ ഡോട്ട് സാന്ദ്രത';

  @override
  String get quishingSignalDoubleEdgeAroundMatrix =>
      'മാട്രിക്സിന് ചുറ്റും ഇരട്ട അരികുകൾ കണ്ടെത്തി';

  @override
  String get quishingSignalMicroShadowStickerBorder =>
      'സ്റ്റിക്കർ അതിർത്തിയിൽ ചെറിയ നിഴൽ വര കണ്ടെത്തി';

  @override
  String get quishingSignalGrainMismatchBase =>
      'അടിസ്ഥാന പ്രതലവുമായി പൊരുത്തപ്പെടാത്ത പ്രിന്റ് തരികൾ';

  @override
  String get quishingSignalMinorScratch =>
      'ചെറിയ പോറലുകളോ തേയ്മാനമോ കാണപ്പെടുന്നു';

  @override
  String get quishingSignalSlightDotIrregularity =>
      'അരികുകളിൽ ചെറിയ ഡോട്ട് വ്യതിയാനങ്ങൾ';

  @override
  String get quishingSignalConsistentDotsMatrixPerimeter =>
      'ചുറ്റളവിൽ ഒരേപോലെയുള്ള ഡോട്ട് സാന്ദ്രത';

  @override
  String quishingSignalPerimeterDoubleEdge(String zones) {
    return 'ഇരട്ട അരികുകളുടെ പ്രതിഫലനം കണ്ടെത്തി ($zones അതിർത്തി മേഖലകൾ)';
  }

  @override
  String quishingSignalDotDensityVariance(String variance) {
    return 'ഡോട്ട് സാന്ദ്രതയിൽ പൊരുത്തക്കേട് കണ്ടെത്തി ($variance% വ്യതിയാനം)';
  }

  @override
  String get domSslInvalidScheme => 'അസാധുവായ URL സ്കീം';

  @override
  String get domSslHttps =>
      'എൻക്രിപ്റ്റ് ചെയ്ത HTTPS പ്രോട്ടോക്കോൾ ഉപയോഗിക്കുന്നു';

  @override
  String get domSslHttp => 'സുരക്ഷിതമല്ലാത്ത HTTP കണക്ഷൻ (ഉയർന്ന അപകടസാധ്യത)';

  @override
  String get domStatusInvalidUrl => 'അസാധുവായ വെബ് URL ഘടന.';

  @override
  String get domStatusHttpCaution =>
      '⚠️ ജാഗ്രത: എൻക്രിപ്റ്റ് ചെയ്യാത്ത HTTP സൈറ്റ്';

  @override
  String get domStatusSafe =>
      '✅ സുരക്ഷിതമായ സാൻഡ്‌ബോക്സ്: HTML പ്രിവ്യൂ ശുദ്ധീകരിച്ചു.';

  @override
  String domStatusOpenRedirect(String target) {
    return '⚠️ മുന്നറിയിപ്പ്: $target എന്നതിലേക്ക് നയിക്കുന്ന ഓപ്പൺ റീഡയറക്റ്റ് കണ്ടെത്തി';
  }

  @override
  String domStatusNewDomain(String days) {
    return '⚠️ മുന്നറിയിപ്പ്: അടുത്തിടെ രജിസ്റ്റർ ചെയ്ത ഡൊമെയ്ൻ ($days ദിവസം പഴക്കം)';
  }

  @override
  String get stegoPassphraseEmpty => 'രഹസ്യവാക്ക് ശൂന്യമാകരുത്';

  @override
  String get stegoBiometricReason =>
      'സ്റ്റെഗോ ക്യുആർ രഹസ്യം കാണുന്നതിന് ആധികാരികത ഉറപ്പാക്കുക';

  @override
  String get mediaNoCodeInImage => 'ചിത്രത്തിൽ കോഡുകളൊന്നും കണ്ടെത്തിയില്ല.';

  @override
  String get mediaNoCodeInPdf => 'PDF രേഖയിൽ കോഡുകളൊന്നും കണ്ടെത്തിയില്ല.';

  @override
  String mediaImagePickFailed(String error) {
    return 'ചിത്രം സ്കാൻ ചെയ്യാൻ കഴിഞ്ഞില്ല: $error';
  }

  @override
  String mediaImageAnalyzeFailed(String error) {
    return 'ചിത്രം പരിശോധിക്കുന്നതിൽ തടസ്സം: $error';
  }

  @override
  String mediaPdfPickFailed(String error) {
    return 'PDF തുറക്കാൻ കഴിഞ്ഞില്ല: $error';
  }

  @override
  String mediaPdfScanFailed(String error) {
    return 'PDF രേഖ സ്കാൻ ചെയ്യാൻ കഴിഞ്ഞില്ല: $error';
  }

  @override
  String get stegoBiometricCanceled =>
      'ബയോമെട്രിക് പരിശോധന റദ്ദാക്കി അല്ലെങ്കിൽ പരാജയപ്പെട്ടു.';

  @override
  String get formatQrUrl => 'ക്യുആർ (ലിങ്ക്)';

  @override
  String get formatQrEmail => 'ക്യുആർ (ഇമെയിൽ)';

  @override
  String get formatQrPhone => 'ക്യുആർ (ഫോൺ)';

  @override
  String get formatQrSms => 'ക്യുആർ (SMS)';

  @override
  String get formatQrWifi => 'ക്യുആർ (വൈ-ഫൈ)';

  @override
  String get formatQrLocation => 'ക്യുആർ (സ്ഥാനം)';

  @override
  String get formatQrContact => 'ക്യുആർ (കോൺടാക്റ്റ്)';

  @override
  String get formatIsbn => 'ISBN';

  @override
  String get formatEanUpc => 'EAN/UPC';

  @override
  String get formatQrCode => 'ക്യുആർ കോഡ്';

  @override
  String get formatEanUpcProduct => 'EAN/UPC ഉൽപ്പന്നം';

  @override
  String get formatBarcode => 'ബാർകോഡ്';

  @override
  String get wifiHiddenNetwork => 'മറഞ്ഞിരിക്കുന്ന ശൃംഖല';

  @override
  String get totpDefaultAccount => 'അക്കൗണ്ട്';

  @override
  String get backupInvalidFormat => 'അസാധുവായ ബാക്കപ്പ് ഫയൽ ഫോർമാറ്റ്.';

  @override
  String get backupBadHeader => 'അസാധുവായ ബാക്കപ്പ് ഫയൽ ഹെഡർ.';

  @override
  String get backupWrongPassphrase =>
      'തെറ്റായ രഹസ്യവാക്ക് അല്ലെങ്കിൽ തകരാറിലായ ബാക്കപ്പ്.';

  @override
  String get reportHeading => 'ശ്രീരാജ് പി ക്യുആർ റീഡർ - സ്കാൻ ചരിത്രം';

  @override
  String get reportTitle => 'സ്കാൻ ചരിത്ര കയറ്റുമതി';

  @override
  String get reportExportDate => 'കയറ്റുമതി ചെയ്ത തീയതി';

  @override
  String get reportTotalScans => 'ആകെ സ്കാനുകൾ';

  @override
  String get reportScanNumber => 'സ്കാൻ #';

  @override
  String get reportId => 'ഐഡി          ';

  @override
  String get reportTimestamp => 'തീയതിയും സമയവും ';

  @override
  String get reportFormat => 'ഫോർമാറ്റ്      ';

  @override
  String get reportCategory => 'വിഭാഗം        ';

  @override
  String get reportSafetyScore => 'സുരക്ഷാ നിരക്ക്';

  @override
  String get reportStarred => 'പ്രിയപ്പെട്ടത്   ';

  @override
  String get reportStarredYes => '⭐ അതെ';

  @override
  String get reportStarredNo => 'ഇല്ല';

  @override
  String get reportLocation => 'സ്ഥലം         ';

  @override
  String get reportNotes => 'കുറിപ്പുകൾ     ';

  @override
  String get reportContent => 'ഉള്ളടക്കം      ';

  @override
  String get reportColumnDateTime => 'തീയതിയും സമയവും';

  @override
  String get reportColumnFormat => 'ഫോർമാറ്റ്';

  @override
  String get reportColumnCategory => 'വിഭാഗം';

  @override
  String get reportColumnSafety => 'സുരക്ഷ';

  @override
  String get reportColumnContent => 'ഉള്ളടക്കം';

  @override
  String get reportColumnNotes => 'കുറിപ്പുകൾ';

  @override
  String get patternIpAddress => 'IP വിലാസം';

  @override
  String get patternLongNumbers => 'നീണ്ട സംഖ്യാ ശ്രേണി';

  @override
  String get patternManyDashes => 'ഒന്നിലധികം വരകൾ/അണ്ടർസ്കോറുകൾ';

  @override
  String get patternPhishingKeywords => 'ഫിഷിംഗ് കീവേഡുകൾ';

  @override
  String get patternDataUri => 'ഡാറ്റ URI';

  @override
  String get patternManySubdomains => 'ഒന്നിലധികം സബ് ഡൊമെയ്നുകൾ';

  @override
  String get shortenerPossibleShortDomain =>
      'ചുരുക്കിയ ലിങ്ക് സാധ്യത: ചെറിയ ഡൊമെയ്ൻ';

  @override
  String get shortenerPossibleRandomPath =>
      'ചുരുക്കിയ ലിങ്ക് സാധ്യത: ക്രമരഹിതമായ അക്ഷര പാത';

  @override
  String shortenerPossibleTld(String tld) {
    return 'ചുരുക്കിയ ലിങ്ക് സാധ്യത ($tld)';
  }

  @override
  String get settingsFeaturesTitle => 'സവിശേഷതകൾ';

  @override
  String get settingsFeaturesSubtitle => 'ആപ്പിന്റെ എല്ലാ സവിശേഷതകളും അറിയുക';

  @override
  String get appearanceHubTitle => 'രൂപഭംഗി';

  @override
  String get appearanceThemeModeCardTitle => 'തീം മോഡ്';

  @override
  String get appearanceThemeModeCardSubtitle =>
      'സിസ്റ്റം, ലൈറ്റ്, ഡാർക്ക് അല്ലെങ്കിൽ OLED മോഡ് തിരഞ്ഞെടുക്കുക';

  @override
  String get appearanceOverlayCardTitle => 'സ്കാൻ ഓവർലേ ശൈലി';

  @override
  String get appearanceOverlayCardSubtitle =>
      'ലേസർ വര, കോണുകൾ, സൈബർ ഗ്രിഡ് അല്ലെങ്കിൽ ഡോട്ട് മാട്രിക്സ്';

  @override
  String get appearanceAccentCardTitle => 'വർണ്ണങ്ങളും ഡൈനാമിക് തീമും';

  @override
  String get appearanceAccentCardSubtitle =>
      'മെറ്റീരിയൽ യു നിറങ്ങളും ഇഷ്ടാനുസൃത വർണ്ണങ്ങളും';

  @override
  String get appearanceTypographyCardTitle => 'അക്ഷര ശൈലിയും വലുപ്പവും';

  @override
  String get appearanceTypographyCardSubtitle =>
      'ഫോണ്ട് ശൈലിയും അക്ഷരങ്ങളുടെ വലുപ്പ ക്രമീകരണങ്ങളും';

  @override
  String get featuresHeaderTitle => 'ആപ്പ് സവിശേഷതകൾ';

  @override
  String get featuresHeaderSubtitle =>
      'സ്കാനിംഗ് ടൂളുകൾ, 6-തല URL സുരക്ഷ, AR കോഡ്‌വിഷൻ, ഓഫ്‌ലൈൻ സൗകര്യങ്ങൾ എന്നിവ അറിയുക.';

  @override
  String get helpCenterHeaderTitle => 'സഹായ കേന്ദ്രവും വഴികാട്ടിയും';

  @override
  String get helpCenterHeaderSubtitle =>
      'ആപ്പിന്റെ എല്ലാ സവിശേഷതകളെക്കുറിച്ചുമുള്ള സമഗ്രമായ നിർദ്ദേശങ്ങൾ വായിക്കുക.';

  @override
  String get decryptPayloadAction => 'ഡീക്രിപ്റ്റ് ചെയ്യുക';

  @override
  String get decryptPayloadTitle => 'ഉള്ളടക്കം ഡീക്രിപ്റ്റ് ചെയ്യുക';

  @override
  String get decryptPayloadDescription => 'രഹസ്യവാക്ക് നൽകി വിവരങ്ങൾ തുറക്കുക.';

  @override
  String get cipherModeLabel => 'സിഫർ മോഡ്';

  @override
  String get cipherModeAuto => 'ഓട്ടോ / സ്റ്റാൻഡേർഡ്';

  @override
  String get cipherModeAesGcm => 'AES-256-GCM (PBKDF2 SHA-256)';

  @override
  String get cipherModeAesCbc => 'AES-256-CBC';

  @override
  String get airQrCodeLabel => 'സെഷൻ കോഡ് / കീ';

  @override
  String get airQrCodeHint => 'ഉദാ: ABC-DEF';

  @override
  String get airQrDetectedTitle => 'എയർ ക്യുആർ എൻക്രിപ്റ്റ് ചെയ്ത കൈമാറ്റം';

  @override
  String get airQrDetectedSubtitle =>
      'ഇതൊരു എൻക്രിപ്റ്റ് ചെയ്ത ഒപ്റ്റിക്കൽ കൈമാറ്റമാണ്. തുറക്കുന്നതിന് അയച്ച ഉപകരണത്തിലെ സെഷൻ കോഡ് നൽകുക.';

  @override
  String get jsonEnvelopeDetectedTitle => 'എൻക്രിപ്റ്റ് ചെയ്ത കണ്ടെയ്നർ';

  @override
  String get jsonEnvelopeDetectedSubtitle =>
      'ഈ കോഡിൽ എൻക്രിപ്റ്റ് ചെയ്ത വിവരങ്ങൾ അടങ്ങിയിരിക്കുന്നു. പാസ്‌വേഡ് നൽകുക.';

  @override
  String get decryptedContentLabel => 'ഡീക്രിപ്റ്റ് ചെയ്ത ഉള്ളടക്കം:';

  @override
  String get manualDecryptionFailed =>
      'ഡീക്രിപ്ഷൻ പരാജയപ്പെട്ടു. പാസ്‌വേഡ് ശരിയാണോ എന്ന് പരിശോധിക്കുക.';

  @override
  String get emailCardTitle => 'ഇമെയിൽ വിലാസം';

  @override
  String get emailSendButton => 'ഇമെയിൽ അയക്കുക';

  @override
  String get emailCopyButton => 'പകർത്തുക';

  @override
  String get emailLaunchFailed =>
      'ഇമെയിൽ ആപ്പ് തുറക്കാനായില്ല. വിലാസം പകർത്തി സ്വമേധയാ തുറക്കുക.';

  @override
  String get emailSubjectLabel => 'വിഷയം';

  @override
  String get emailBodyLabel => 'സന്ദേശം';

  @override
  String get phoneCardTitle => 'ഫോൺ നമ്പർ';

  @override
  String get phoneCallButton => 'വിളിക്കുക';

  @override
  String get phoneCopyButton => 'പകർത്തുക';

  @override
  String get phoneLaunchFailed =>
      'ഫോൺ ഡയലർ തുറക്കാനായില്ല. നമ്പർ പകർത്തി സ്വമേധയാ ഡയൽ ചെയ്യുക.';

  @override
  String get smsCardTitle => 'ടെക്സ്റ്റ് സന്ദേശം';

  @override
  String get smsSendButton => 'സന്ദേശം അയക്കുക';

  @override
  String get smsCopyButton => 'പകർത്തുക';

  @override
  String get smsLaunchFailed =>
      'സന്ദേശ ആപ്പ് തുറക്കാനായില്ല. നമ്പറും സന്ദേശവും പകർത്തി സ്വമേധയാ അയക്കുക.';

  @override
  String get smsBodyLabel => 'സന്ദേശം';

  @override
  String get appLinkCardTitle => 'ആപ്പ് ലിങ്ക്';

  @override
  String get appLinkOpenButton => 'ആപ്പിൽ തുറക്കുക';

  @override
  String get appLinkLaunchFailed =>
      'ഈ ആപ്പ് ലിങ്ക് തുറക്കാൻ കഴിഞ്ഞില്ല. ആപ്പ് ഇൻസ്റ്റാൾ ചെയ്തിട്ടുണ്ടോ എന്ന് പരിശോധിക്കുക.';

  @override
  String get productBarcodeCardTitle => 'ഉൽപ്പന്ന ബാർകോഡ്';

  @override
  String get productSearchFoodButton => 'ഭക്ഷണ വിവരം';

  @override
  String get productSearchWebButton => 'വെബിൽ തിരയുക';

  @override
  String get productCopyButton => 'ബാർകോഡ് പകർത്തുക';

  @override
  String get productLaunchFailed =>
      'ഉൽപ്പന്ന തിരച്ചിൽ തുറക്കാനായില്ല. ബാർകോഡ് പകർത്തി സ്വമേധയാ തിരയുക.';

  @override
  String get isbnCardTitle => 'പുസ്തകം (ISBN)';

  @override
  String get isbnGoogleBooksButton => 'ഗൂഗിൾ ബുക്സ്';

  @override
  String get isbnOpenLibraryButton => 'ഓപ്പൺ ലൈബ്രറി';

  @override
  String get isbnCopyButton => 'ISBN പകർത്തുക';

  @override
  String get isbnLaunchFailed =>
      'പുസ്തക വിവരം തുറക്കാനായില്ല. ISBN പകർത്തി സ്വമേധയാ തിരയുക.';

  @override
  String get historyFilterEmail => 'ഇമെയിൽ';

  @override
  String get historyFilterPhone => 'ഫോൺ';

  @override
  String get historyFilterSms => 'സന്ദേശം';

  @override
  String get historyFilterAppLink => 'ആപ്പ് ലിങ്ക്';

  @override
  String get historyFilterProductBarcode => 'ഉൽപ്പന്നം';

  @override
  String get historyFilterIsbn => 'പുസ്തകം';

  @override
  String get scanFlashOff => 'ഫ്ലാഷ്: ഓഫ്';

  @override
  String get scanFlashOn => 'ഫ്ലാഷ്: ഓൺ';

  @override
  String get scanFlashAuto => 'ഫ്ലാഷ്: സ്വയം';

  @override
  String scanFlashAutoActive(String lux) {
    return 'ഓട്ടോ ഫ്ലാഷ് സജീവം ($lux lux)';
  }

  @override
  String get scanFlashAutoSensorUnavailable => 'ഈ ഫോണിൽ വെളിച്ച സെൻസർ ലഭ്യമല്ല';

  @override
  String get cameraTuneTooltip => 'ക്യാമറ ക്രമീകരണങ്ങൾ';

  @override
  String get cameraTuneTitle => 'ക്യാമറ ക്രമീകരണങ്ങൾ';

  @override
  String get cameraBrightnessLabel => 'തെളിച്ചം';

  @override
  String get cameraContrastLabel => 'കോൺട്രാസ്റ്റ്';

  @override
  String get cameraInvertLabel => 'നിറങ്ങൾ വിപരീതമാക്കുക (നെഗറ്റീവ്)';

  @override
  String get cameraInvertHint =>
      'കറുത്ത പശ്ചാത്തലത്തിലെ വെളുത്ത കോഡുകൾ എളുപ്പത്തിൽ സ്കാൻ ചെയ്യാൻ';

  @override
  String get cameraResolutionLabel => 'ക്യാമറ റെസല്യൂഷൻ';

  @override
  String get cameraResolutionFullHd => 'ഫുൾ HD (1080p - ശുപാർശ ചെയ്യുന്നത്)';

  @override
  String get cameraResolutionMax => 'പരമാവധി (4K UHD)';

  @override
  String get cameraResolutionHd => 'HD (720p - ബാറ്ററി ലാഭിക്കാം)';

  @override
  String get cameraResetAdjustments => 'ക്രമീകരണങ്ങൾ പുനഃക്രമീകരിക്കുക';

  @override
  String get cameraFocusTapHint =>
      'ഫോക്കസ് ചെയ്യാനും വെളിച്ചം ക്രമീകരിക്കാനും തൊടുക';

  @override
  String get settingsLanguageTitle => 'ഭാഷ';

  @override
  String get settingsLanguageSubtitle => 'ആപ്പ് പ്രദർശന ഭാഷ തിരഞ്ഞെടുക്കുക';

  @override
  String get languageSystemDefault => 'സിസ്റ്റം സ്വതവേയുള്ളത്';

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
    return '$percentage% ഉപയോഗിച്ചു';
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
  String get tooltipToggleSecretVisibility =>
      'രഹസ്യവിവരങ്ങൾ കാണിക്കുക/മറയ്ക്കുക';

  @override
  String get tooltipResetStream => 'സ്ട്രീം പുനരാരംഭിക്കുക';

  @override
  String get tooltipAirQrTransmitter => 'എയർ ക്യുആർ ട്രാൻസ്മിറ്ററിലേക്ക് മാറുക';

  @override
  String get airQrModeText => 'സ്വന്തം ഉള്ളടക്കം';

  @override
  String get airQrModeSync => 'ഡിവൈസ് സിങ്ക്';

  @override
  String airQrSyncIncludeHistory(int count) {
    return 'സ്കാൻ ഹിസ്റ്ററി ഉൾപ്പെടുത്തുക ($count)';
  }

  @override
  String get airQrSyncIncludeSettings => 'ആപ്പ് ക്രമീകരണങ്ങൾ ഉൾപ്പെടുത്തുക';

  @override
  String get airQrSyncPassphraseLabel => 'സിങ്ക് പാസ്ഫ്രെയ്സ് / പിൻ';

  @override
  String get airQrSyncPassphraseHint => 'രഹസ്യ പിൻ നൽകുക';

  @override
  String get airQrSyncGeneratePin => 'പിൻ നിർമ്മിക്കുക';

  @override
  String get airQrSyncBeamButton => 'വിവരങ്ങൾ പ്രക്ഷേപണം ചെയ്യുക';

  @override
  String get airQrSyncNoDataWarning =>
      'ഹിസ്റ്ററിയോ ക്രമീകരണങ്ങളോ തിരഞ്ഞെടുക്കുക.';

  @override
  String get airQrSyncPackageDetected => 'എയർക്യുആർ സിങ്ക് പാക്കേജ്';

  @override
  String airQrSyncPackageSummary(int records) {
    return '$records സ്കാൻ രേഖകളും ആപ്പ് ക്രമീകരണങ്ങളും അടങ്ങിയിരിക്കുന്നു';
  }

  @override
  String get airQrSyncEnterPassphrase =>
      'ഡീക്രിപ്റ്റ് ചെയ്യാൻ പാസ്‌ഫ്രെയ്സ് നൽകുക';

  @override
  String get airQrSyncRestoreHistory => 'സ്കാൻ ഹിസ്റ്ററി പുനഃസ്ഥാപിക്കുക';

  @override
  String get airQrSyncApplySettings => 'ക്രമീകരണങ്ങൾ മാറ്റുക';

  @override
  String get airQrSyncDecryptButton => 'ഡീക്രിപ്റ്റ് ചെയ്തു് സിങ്ക് ചെയ്യുക';

  @override
  String airQrSyncSuccess(int count) {
    return '$count സ്കാനുകളും ക്രമീകരണങ്ങളും വിജയകരമായി സിങ്ക് ചെയ്തു!';
  }

  @override
  String get airQrSyncBeamAction => 'എയർക്യുആർ വഴി അയക്കുക';

  @override
  String get airQrSyncSettingsTitle => 'എയർക്യുആർ സിങ്ക്';

  @override
  String get airQrSyncSettingsSubtitle =>
      'നെറ്റ്‌വർക്കില്ലാതെ മറ്റൊരു ഫോണിലേക്ക് വിവരങ്ങൾ അയക്കുക';

  @override
  String get tabScan => 'സ്കാൻ';

  @override
  String get tabCodeForge => 'കോഡ്ഫോർജ്';

  @override
  String get tabHistory => 'ഹിസ്റ്ററി';

  @override
  String get codeForgeTitle => 'കോഡ്ഫോർജ്';

  @override
  String get codeForgeSubtitle => 'ബാർകോഡ് & ക്യുആർ സ്റ്റുഡിയോ';

  @override
  String get codeForgeBarcodeType => 'ബാർകോഡ് തരം';

  @override
  String get codeForgePayloadType => 'ഉള്ളടക്ക തരം';

  @override
  String get codeForgePresetText => 'ടെക്സ്റ്റ്';

  @override
  String get codeForgePresetUrl => 'ലിങ്ക്';

  @override
  String get codeForgePresetWifi => 'വൈ-ഫൈ';

  @override
  String get codeForgePresetContact => 'കോൺടാക്റ്റ്';

  @override
  String get codeForgePresetUpi => 'യുപിഐ';

  @override
  String get codeForgePresetSms => 'എസ്എംഎസ്';

  @override
  String get codeForgePresetEmail => 'ഇമെയിൽ';

  @override
  String get codeForgePresetGeo => 'ലൊക്കേഷൻ';

  @override
  String get codeForgeWifiSsid => 'നെറ്റ്‌വർക്ക് പേര് (SSID)';

  @override
  String get codeForgeWifiPassword => 'പാസ്‌വേഡ്';

  @override
  String get codeForgeWifiSecurity => 'സുരക്ഷ';

  @override
  String get codeForgeWifiHidden => 'മറഞ്ഞിരിക്കുന്ന നെറ്റ്‌വർക്ക്';

  @override
  String get codeForgeContactName => 'പൂർണ്ണമായ പേര്';

  @override
  String get codeForgeContactPhone => 'ഫോൺ നമ്പർ';

  @override
  String get codeForgeContactEmail => 'ഇമെയിൽ വിലാസം';

  @override
  String get codeForgeContactOrg => 'സ്ഥാപനം';

  @override
  String get codeForgeContactTitle => 'തസ്തിക';

  @override
  String get codeForgeContactUrl => 'വെബ്സൈറ്റ്';

  @override
  String get codeForgeUpiVpa => 'യുപിഐ ഐഡി';

  @override
  String get codeForgeUpiName => 'സ്വീകർത്താവിന്റെ പേര്';

  @override
  String get codeForgeUpiAmount => 'തുക (രൂപ)';

  @override
  String get codeForgeUpiNote => 'കുറിപ്പ്';

  @override
  String get codeForgeSmsPhone => 'ഫോൺ നമ്പർ';

  @override
  String get codeForgeSmsMessage => 'സന്ദേശം';

  @override
  String get codeForgeEmailTo => 'ഇമെയിൽ';

  @override
  String get codeForgeEmailSubject => 'വിഷയം';

  @override
  String get codeForgeEmailBody => 'സന്ദേശം';

  @override
  String get codeForgeGeoLat => 'അക്ഷാംശം';

  @override
  String get codeForgeGeoLng => 'രേഖാംശം';

  @override
  String get codeForgeDesignStudio => 'രൂപകൽപ്പന';

  @override
  String get codeForgeEyeShape => 'ഐ ഡിസൈൻ';

  @override
  String get codeForgeEyeBallShape => 'ഇന്നർ പ്യൂപ്പിൾ';

  @override
  String get codeForgePatternShape => 'ഡോട്ട് പാറ്റേൺ';

  @override
  String get codeForgeShapeSquare => 'ചതുരം';

  @override
  String get codeForgeShapeDots => 'വൃത്തം';

  @override
  String get codeForgeShapeRounded => 'വട്ടമുള്ളത്';

  @override
  String get codeForgeShapeClassy => 'ക്ലാസി';

  @override
  String get codeForgeShapeDiamond => 'ഡയമണ്ട്';

  @override
  String get codeForgeShapeLeaf => 'ഇല രൂപം';

  @override
  String get codeForgeShapeCircle => 'വൃത്താകൃതി';

  @override
  String get codeForgeColorStudio => 'വർണ്ണങ്ങൾ';

  @override
  String get codeForgeFgColor => 'മുൻനിര നിറം';

  @override
  String get codeForgeBgColor => 'പശ്ചാത്തല നിറം';

  @override
  String get codeForgeEyeOuterColor => 'ബാഹ്യ വലയം';

  @override
  String get codeForgeEyeInnerColor => 'നേത്ര കേന്ദ്രം';

  @override
  String get codeForgeGradientNone => 'ഏകവർണ്ണം';

  @override
  String get codeForgeGradientSunset => 'സൂര്യാസ്തമയം';

  @override
  String get codeForgeGradientOcean => 'സമുദ്രം';

  @override
  String get codeForgeGradientNeon => 'നിയോൺ';

  @override
  String get codeForgeGradientGold => 'റോയൽ ഗോൾഡ്';

  @override
  String get codeForgeErrorCorrection => 'പിശക് തിരുത്തൽ';

  @override
  String get codeForgeCenterBadge => 'ചിഹ്നം';

  @override
  String get codeForgeBadgeNone => 'ഒന്നുമില്ല';

  @override
  String get codeForgeBadgeIcon => 'ഐക്കൺ';

  @override
  String get codeForgeBadgeShield => 'പരിശോധിച്ച ഷീൽഡ്';

  @override
  String get codeForgeExportPng => 'പിഎൻജി പങ്കിടുക';

  @override
  String get codeForgeExportSvg => 'എസ്വിജി പങ്കിടുക';

  @override
  String get codeForgeCopyPayload => 'പകർത്തുക';

  @override
  String get codeForgeCopied => 'ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get codeForgeVerifySafety => 'ലിങ്ക് സുരക്ഷാ പരിശോധന';

  @override
  String get codeForgeSafeVerified => 'സുരക്ഷിതമായി സ്ഥിരീകരിച്ചു';

  @override
  String get codeForgeResetStyle => 'ഡിസൈൻ മാറ്റുക';

  @override
  String get codeForgeIncludeText => 'വാചകം കാണിക്കുക';

  @override
  String get codeForgePreview => 'തത്സമയ പ്രിവ്യൂ';

  @override
  String get onboardingSkip => 'ഒഴിവാക്കുക';

  @override
  String get onboardingNext => 'അടുത്തത്';

  @override
  String get onboardingGetStarted => 'സ്കാൻ ആരംഭിക്കുക';

  @override
  String get onboardingSlide1Badge => '6-തല സുരക്ഷ';

  @override
  String get onboardingSlide1Title => '6-തല യുആർഎൽ സുരക്ഷാ എഞ്ചിൻ';

  @override
  String get onboardingSlide1Description =>
      'നിങ്ങൾ തുറക്കുന്നതിന് മുമ്പ് ഓരോ ലിങ്കും ആറ് സുരക്ഷാ തലങ്ങളിലൂടെ പരിശോധിക്കപ്പെടുന്നു. ഫിഷിംഗ്, വഞ്ചനാപരമായ റീഡയറക്റ്റുകൾ, വ്യാജ ഡൊമെയ്‌നുകൾ എന്നിവയിൽ നിന്ന് ഇത് നിങ്ങളെ സംരക്ഷിക്കുന്നു.';

  @override
  String get onboardingSlide1Bullet1 =>
      'പ്രോട്ടോക്കോളും വ്യാജ ഡൊമെയ്ൻ പ്രതിരോധവും';

  @override
  String get onboardingSlide1Bullet2 =>
      'ടിഎൽഡി എൻട്രോപ്പിയും പോർട്ട് പരിശോധനയും';

  @override
  String get onboardingSlide1Bullet3 => 'സ്വകാര്യ പരിശോധനയും സേഫ് ബ്രൗസിംഗും';

  @override
  String get onboardingSlide2Badge => 'കമ്പ്യൂട്ടർ വിഷൻ';

  @override
  String get onboardingSlide2Title =>
      'ക്വിഷിംഗ്ഗാർഡ് വ്യാജ സ്റ്റിക്കർ കണ്ടെത്തൽ';

  @override
  String get onboardingSlide2Description =>
      'യഥാർത്ഥ കോഡുകൾക്ക് മുകളിൽ പതിപ്പിച്ച വ്യാജ ക്യുആർ സ്റ്റിക്കറുകൾ ക്വിഷിംഗ്ഗാർഡ് ക്യാമറ വഴി തിരിച്ചറിയുന്നു. വശങ്ങളിലെ വെട്ടുകളും നിഴലുകളും ഉപരിതലവും ഇത് സൂക്ഷ്മമായി പരിശോധിക്കുന്നു.';

  @override
  String get onboardingSlide2Bullet1 =>
      'വ്യാജ സ്റ്റിക്കർ പതിപ്പിക്കലുകൾ കണ്ടെത്തുന്നു';

  @override
  String get onboardingSlide2Bullet2 =>
      'മുറിച്ച അരികുകളും നിഴൽ അതിരുകളും പരിശോധിക്കുന്നു';

  @override
  String get onboardingSlide2Bullet3 => 'തത്സമയ ക്യാമറ പരിശോധന';

  @override
  String get onboardingSlide3Badge => 'ക്ലൗഡ് രഹിതം • ട്രാക്കിംഗ് ഇല്ല';

  @override
  String get onboardingSlide3Title => '100% ഓഫ്ലൈൻ സ്വകാര്യത';

  @override
  String get onboardingSlide3Description =>
      'നിങ്ങളുടെ സ്കാനുകളും വ്യക്തിഗത വിവരങ്ങളും ഫോൺ വിട്ടുപോകില്ല. അനലിറ്റിക്‌സ്, പരസ്യങ്ങൾ, ട്രാക്കറുകൾ എന്നിവ പൂർണ്ണമായും ഒഴിവാക്കിയിരിക്കുന്നു.';

  @override
  String get onboardingSlide3Bullet1 =>
      'എൻക്രിപ്റ്റ് ചെയ്ത പ്രാദേശിക ഡാറ്റാബേസ്';

  @override
  String get onboardingSlide3Bullet2 => 'എയർ ക്യുആർ ഒപ്റ്റിക്കൽ കൈമാറ്റം';

  @override
  String get onboardingSlide3Bullet3 =>
      'അനലിറ്റിക്‌സോ ട്രാക്കിംഗോ ഇല്ലാത്ത നിർമ്മിതി';

  @override
  String get settingsOnboardingTourTitle => 'ആമുഖ ടൂർ';

  @override
  String get settingsOnboardingTourSubtitle =>
      'സുരക്ഷയും സ്വകാര്യതയും വിശദീകരിക്കുന്ന 3 സ്ലൈഡ് ആമുഖം വീണ്ടും കാണുക';

  @override
  String get batchScanMode => 'ബാച്ച് സ്കാനിംഗ് രീതി';

  @override
  String get batchModeTooltip => 'തുടർച്ചയായ ബാച്ച് സ്കാനിംഗ്';

  @override
  String get batchModeEnabledToast => 'തുടർച്ചയായ ബാച്ച് സ്കാനിംഗ് ഓണാക്കി';

  @override
  String get batchModeDisabledToast => 'തുടർച്ചയായ ബാച്ച് സ്കാനിംഗ് ഓഫാക്കി';

  @override
  String batchCounterBadge(int count) {
    return '$count സ്കാൻ ചെയ്തു';
  }

  @override
  String get batchReviewTitle => 'ബാച്ച് സ്കാനുകൾ';

  @override
  String get batchReviewSubtitle => 'തുടർച്ചയായ സ്കാനിംഗ് നിര';

  @override
  String get batchEmptyTitle => 'ബാച്ചിൽ കോഡുകൾ ഒന്നുമില്ല';

  @override
  String get batchEmptySubtitle =>
      'ക്യാമറയിൽ നിന്ന് പുറത്തുപോകാതെ തുടർച്ചയായി കോഡുകൾ സ്കാൻ ചെയ്യുക.';

  @override
  String get batchExport => 'ബാച്ച് എക്സ്പോർട്ട്';

  @override
  String get batchClear => 'ബാച്ച് മായ്ക്കുക';

  @override
  String get batchClearConfirmTitle => 'ബാച്ച് മായ്ക്കണമോ?';

  @override
  String get batchClearConfirmContent =>
      'ഈ ബാച്ചിലെ എല്ലാ സ്കാൻ ചെയ്ത കോഡുകളും നീക്കം ചെയ്യണമെന്ന് ഉറപ്പാണോ?';

  @override
  String get batchPreventDuplicates => 'ഡ്യൂപ്ലിക്കേറ്റുകൾ ഒഴിവാക്കുക';

  @override
  String batchScannedToast(int count, String content) {
    return 'സ്കാൻ ചെയ്തു #$count: $content';
  }

  @override
  String get batchSafeUrl => 'സുരക്ഷിത ലിങ്ക്';

  @override
  String get batchSuspiciousUrl => 'സംശയാസ്പദമായ ലിങ്ക്';

  @override
  String get batchAnalyzingUrl => 'ലിങ്ക് പരിശോധിക്കുന്നു...';

  @override
  String batchUrlSafetySummary(int safeCount, int warningCount, int totalUrls) {
    return '$totalUrls ലിങ്കുകളിൽ $safeCount സുരക്ഷിതം, $warningCount സംശയാസ്പദം';
  }

  @override
  String get batchItemDetailsTitle => 'സ്കാൻ ചെയ്ത കോഡ് വിവരങ്ങൾ';

  @override
  String batchFormatLabel(String format) {
    return 'ഫോർമാറ്റ്: $format';
  }

  @override
  String batchTimeLabel(String time) {
    return 'സ്കാൻ ചെയ്ത സമയം: $time';
  }

  @override
  String get cameraDistanceEnhanceLabel => 'ദൂര സ്കാൻ സഹായം';

  @override
  String get cameraDistanceEnhanceHint =>
      'ദൂരെയുള്ള പോസ്റ്ററുകൾക്കും അടയാളങ്ങൾക്കും സൂം ക്രോപ്പും മൂർച്ച കൂട്ടലും';

  @override
  String get cameraUnsharpLabel => 'അരികുകളുടെ മൂർച്ച';

  @override
  String get scanDistanceModeTooltip => 'ദൂര സ്കാൻ സഹായം';

  @override
  String get scanDistanceModeActive => 'ദൂര മോഡ് സജീവം';
}
