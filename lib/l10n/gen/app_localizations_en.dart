// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get titleApp => 'SreerajP QR Studio';

  @override
  String get titleWifiCard => 'Wi-Fi Network';

  @override
  String get tooltipWifiShowPassword => 'Show Password';

  @override
  String get tooltipWifiHidePassword => 'Hide Password';

  @override
  String get tooltipWifiCopyPassword => 'Copy Password';

  @override
  String get actionWifiConnect => 'Connect to Wi-Fi';

  @override
  String get bodyWifiPasswordCopied => 'Password copied to clipboard';

  @override
  String get bodyWifiOpenSettings =>
      'Password copied. Open Wi-Fi Settings on your device to connect.';

  @override
  String bodyWifiConnectSuccess(String ssid) {
    return 'Connection requested for $ssid';
  }

  @override
  String bodyGeoLatLng(String latitude, String longitude) {
    return 'Lat: $latitude, Lng: $longitude';
  }

  @override
  String bodyGeoQuery(String query) {
    return 'Query: $query';
  }

  @override
  String get actionGeoNavigate => 'Open in Maps';

  @override
  String get errorGeoLaunchFailed => 'Could not launch Google Maps app';

  @override
  String get titleCalendarCard => 'Calendar Event';

  @override
  String get labelCalendarNoDate => 'N/A';

  @override
  String labelCalendarStart(String dateTime) {
    return 'Start: $dateTime';
  }

  @override
  String labelCalendarEnd(String dateTime) {
    return 'End:   $dateTime';
  }

  @override
  String get actionCalendarAdd => 'Add to calendar';

  @override
  String get errorCalendarLaunchFailed => 'Could not open Calendar app';

  @override
  String get titleContactCard => 'Contact Card';

  @override
  String get labelContactInitialFallback => 'C';

  @override
  String get actionContactSave => 'Save to Contacts';

  @override
  String get errorContactLaunchFailed => 'Could not open Contacts app';

  @override
  String errorContactCallFailed(String number) {
    return 'Could not place call to $number';
  }

  @override
  String errorContactEmailFailed(String email) {
    return 'Could not open email app for $email';
  }

  @override
  String titlePdfResults(int count) {
    return 'PDF codes ($count)';
  }

  @override
  String labelPdfPageBadge(int page) {
    return 'P$page';
  }

  @override
  String labelPdfPage(int page) {
    return 'Page $page';
  }

  @override
  String actionPdfSaveAll(int count) {
    return 'Save all ($count)';
  }

  @override
  String bodyPdfScanNote(int page) {
    return 'Scanned from PDF (Page $page)';
  }

  @override
  String bodyPdfSavedToHistory(int count) {
    return 'Saved $count codes to history.';
  }

  @override
  String get labelTotpDefaultIssuer => '2FA Authenticator';

  @override
  String bodyTotpLivePasscode(int period) {
    return 'Live Passcode (${period}s TOTP)';
  }

  @override
  String labelTotpSecondsLeft(int seconds) {
    return '${seconds}s';
  }

  @override
  String get tooltipTotpCopyToken => 'Copy Token';

  @override
  String get labelTotpSecret => 'Secret: ';

  @override
  String get actionTotpImport => 'Add to authenticator';

  @override
  String get errorTotpLaunchFailed => 'Could not open Authenticator app';

  @override
  String get bodyTotpTokenCopied => 'TOTP token copied to clipboard';

  @override
  String get bodyTotpSecretCopied => 'Secret key copied to clipboard';

  @override
  String get labelPaymentSchemeUpi => 'UPI Payment';

  @override
  String get labelPaymentSchemeSepa => 'SEPA Transfer';

  @override
  String get labelPaymentSchemeCrypto => 'Crypto Payment';

  @override
  String get labelPaymentPayeeFallback => 'Merchant / Payee';

  @override
  String get labelPaymentAddressUpi => 'VPA / UPI ID:';

  @override
  String get labelPaymentAddressSepa => 'IBAN:';

  @override
  String get labelPaymentAddressCrypto => 'Wallet Address:';

  @override
  String get actionPaymentCopy => 'Copy';

  @override
  String get bodyPaymentUpiIdCopied => 'UPI ID copied to clipboard';

  @override
  String get bodyPaymentAddressCopied => 'Address copied to clipboard';

  @override
  String bodyPaymentNote(String note) {
    return 'Note: $note';
  }

  @override
  String get actionPaymentPayUpi => 'Pay with UPI app';

  @override
  String get actionPaymentPay => 'Pay via App';

  @override
  String get errorPaymentUpiLaunchFailed =>
      'Could not open UPI app. Make sure GPay, PhonePe, or Paytm is installed.';

  @override
  String get errorPaymentLaunchFailed =>
      'Could not open payment app for this scheme.';

  @override
  String get actionPaymentCopyId => 'Copy ID';

  @override
  String get titlePaymentAmountDialog => 'Enter amount';

  @override
  String bodyPaymentAmountDialog(String payee) {
    return 'This QR has no amount. Enter the amount to pay to $payee.';
  }

  @override
  String get labelPaymentAmountField => 'Amount';

  @override
  String get errorPaymentAmountInvalid => 'Enter ₹1 or more';

  @override
  String get actionPaymentAmountPay => 'Pay';

  @override
  String labelPercentValue(String value) {
    return '$value%';
  }

  @override
  String get titleQuishingGuard => 'QuishingGuard™';

  @override
  String get labelQuishingTamperBadge => 'Physical Tamper CV';

  @override
  String get labelQuishingRiskScore => 'Tamper Risk Score:';

  @override
  String get actionQuishingViewSignals => 'Show signals';

  @override
  String get actionQuishingHideSignals => 'Hide signals';

  @override
  String get labelQuishingMetricEdge => 'Edge Discontinuity';

  @override
  String get descQuishingMetricEdge => 'Double edges & shadow lines';

  @override
  String get labelQuishingMetricGrain => 'Print Grain & DPI';

  @override
  String get descQuishingMetricGrain => 'Halftone dot & chromatic noise';

  @override
  String get titleQuishingSignals => 'Detected signals:';

  @override
  String get tooltipArCloseSheet => 'Close Sheet';

  @override
  String bodyArItemPriceTag(String price) {
    return 'Item Price Tag: $price';
  }

  @override
  String get bodyArContentCopied => 'Copied content to clipboard';

  @override
  String get actionArCopy => 'Copy';

  @override
  String get actionArOpenUrl => 'Open URL';

  @override
  String get actionArSelect => 'Select Item';

  @override
  String get actionArDeselect => 'Deselect';

  @override
  String get bodyArSafetyStatusSafe => 'Safety Status: Verified Safe';

  @override
  String get bodyArSafetyStatusWarning =>
      'Safety Status: Warning / Phishing Suspicion';

  @override
  String get bodyArSafetyStatusUnknown =>
      'Safety Status: Analyzing link safety...';

  @override
  String get bodyCopiedToClipboard => 'Copied to clipboard';

  @override
  String bodyHistoryTimestamp(String date, String time) {
    return '$date • $time';
  }

  @override
  String get tooltipHistoryStar => 'Star favorite';

  @override
  String get tooltipHistoryUnstar => 'Unstar';

  @override
  String get actionHistoryEditNotes => 'Edit Notes';

  @override
  String get tooltipHistoryCopyString => 'Copy String';

  @override
  String get actionHistoryShare => 'Share';

  @override
  String get actionHistoryDelete => 'Delete';

  @override
  String get titleHistoryDetail => 'Scan Record Details';

  @override
  String labelHistorySafetyBadge(int score) {
    return '🛡️ $score% Safe';
  }

  @override
  String labelHistoryScoreBadge(int score) {
    return '🛡️ $score%';
  }

  @override
  String get labelHistoryScannedContent => 'Scanned Content:';

  @override
  String get actionHistoryCopy => 'Copy';

  @override
  String get labelHistoryNotes => 'Custom User Notes';

  @override
  String get helpHistoryNotes =>
      'Add personal notes or remarks about this scan...';

  @override
  String get labelHistoryLocation => 'Location (optional)';

  @override
  String get helpHistoryLocation =>
      'e.g. Office Desk, Grocery Store, Conference';

  @override
  String get actionHistorySaveChanges => 'Save changes';

  @override
  String get actionClose => 'Close';

  @override
  String get titleExportDialog => 'Export & backup';

  @override
  String get titleRestoreDialog => 'Restore backup';

  @override
  String get tabExportRecords => 'Export Records';

  @override
  String get tabRestoreBackup => 'Restore Backup';

  @override
  String get titleExportFormat => 'Export format:';

  @override
  String get labelExportCsv => 'CSV Format (.csv)';

  @override
  String get descExportCsv => 'Compatible with Excel and Sheets';

  @override
  String get labelExportJson => 'JSON Dataset (.json)';

  @override
  String get descExportJson => 'Structured developer format';

  @override
  String get labelExportTxt => 'Text report (.txt)';

  @override
  String get descExportTxt => 'Human readable summary document';

  @override
  String get labelExportPdf => 'PDF report (.pdf)';

  @override
  String get descExportPdf => 'Formatted printable report table';

  @override
  String get titleExportBackup => 'Encrypted backup';

  @override
  String get labelExportPassphrase => 'Backup passphrase';

  @override
  String get helpExportPassphrase => 'Enter secret passphrase...';

  @override
  String get errorExportPassphraseRequired =>
      'Please enter a password to encrypt your backup file.';

  @override
  String get actionExportCreateBackup => 'Create backup';

  @override
  String get bodyExportShare => 'SreerajP QR Studio Scan History Export';

  @override
  String get bodyExportSharePdf =>
      'SreerajP QR Studio Scan History Report (PDF)';

  @override
  String get bodyExportShareBackup =>
      'SreerajP QR Studio Encrypted Backup File';

  @override
  String get titleRestore => 'Restore from backup:';

  @override
  String get labelRestorePassphrase => 'Backup passphrase';

  @override
  String get labelRestorePayload => 'Backup data';

  @override
  String get helpRestorePayload => 'Paste backup JSON payload string here...';

  @override
  String get errorRestoreFieldsRequired =>
      'Please provide both the password and backup content.';

  @override
  String get actionRestore => 'Restore history';

  @override
  String bodyRestoreSuccess(int count) {
    return 'Successfully restored $count scan records!';
  }

  @override
  String errorRestoreFailed(String reason) {
    return 'Restore failed: $reason';
  }

  @override
  String get labelDomSandboxedBadge => 'SANDBOXED';

  @override
  String get labelDomTitleInitialFallback => 'W';

  @override
  String get labelDomUntitledPage => 'Untitled Web Page';

  @override
  String get bodyDomThumbnailCaption =>
      'Visual Thumbnail Pre-Render (Script Execution Blocked)';

  @override
  String bodyDomBlockedBadge(int scripts, int trackers) {
    return 'Blocked: $scripts Scripts, $trackers Trackers';
  }

  @override
  String bodyDomNewlyRegistered(int days) {
    return 'Newly Registered (${days}d)';
  }

  @override
  String bodyDomDomainAge(int days) {
    return 'Domain Age: $days days';
  }

  @override
  String get bodyDomOpenRedirectFound => 'Open Redirect Trap!';

  @override
  String get bodyDomNoOpenRedirect => 'No Open Redirects';

  @override
  String get actionDomInspect => 'Inspect page';

  @override
  String get titleDomInspect => 'Page structure';

  @override
  String get labelDomDetailPageTitle => 'Page Title';

  @override
  String get labelDomDetailNotSpecified => 'Not specified';

  @override
  String get labelDomDetailMetaDescription => 'Meta Description';

  @override
  String get labelDomDetailNoneFound => 'None found';

  @override
  String get labelDomDetailHeadingsCount => 'Headings Count';

  @override
  String bodyDomDetailHeadingsValue(int count) {
    return '$count headings extracted';
  }

  @override
  String get labelDomDetailLinksFound => 'Links Found';

  @override
  String bodyDomDetailLinksValue(int count) {
    return '$count URLs extracted';
  }

  @override
  String get labelDomDetailBlockedScripts => 'Blocked Scripts';

  @override
  String bodyDomDetailBlockedScriptsValue(int count) {
    return '$count executable script tags/events stripped';
  }

  @override
  String get labelDomDetailBlockedTrackers => 'Blocked Trackers';

  @override
  String bodyDomDetailBlockedTrackersValue(int count) {
    return '$count tracking pixels stripped';
  }

  @override
  String get labelDomDetailBlockedIframes => 'Blocked Iframes';

  @override
  String bodyDomDetailBlockedIframesValue(int count) {
    return '$count iframe/embed elements removed';
  }

  @override
  String get titleDomSanitizedSnippet => 'Clean HTML preview:';

  @override
  String get titleAbout => 'About';

  @override
  String bodyAboutVersion(String version, String build) {
    return 'Version $version+$build';
  }

  @override
  String get labelAboutBuildDate => 'Build Date';

  @override
  String get labelAboutOpenSourceLicenses => 'Open-source licences';

  @override
  String get descAboutOpenSourceLicenses =>
      'Includes zxing-cpp (Apache-2.0) as the barcode decoder. Tap to view all licences.';

  @override
  String get aboutDetailAuthor => 'Author';

  @override
  String get aboutDetailEmail => 'Email';

  @override
  String get aboutDetailLicense => 'License';

  @override
  String get aboutDetailAiUsed => 'AI Used';

  @override
  String get aboutDetailIdeUsed => 'IDE Used';

  @override
  String madeWithLove(String heart) {
    return 'Made with $heart from India';
  }

  @override
  String get madeWithLoveA11y => 'Made with love from India';

  @override
  String get titleAirQrTransmitter => 'AirQR transmitter';

  @override
  String get bodyAirQrSamplePayload =>
      'AirQR High-Speed Optical Air-Gap Transfer Test Payload. This payload is split into small chunks with Fountain FEC error correction.';

  @override
  String get labelAirQrPayload => 'Data to send';

  @override
  String get helpAirQrPayload => 'Enter text, contact, or file payload...';

  @override
  String get labelAirQrStreamSpeed => 'Stream Speed:';

  @override
  String labelAirQrFps(int fps) {
    return '$fps FPS';
  }

  @override
  String get actionAirQrStartStream => 'Start stream';

  @override
  String get actionAirQrStopStream => 'Stop stream';

  @override
  String bodyAirQrFrameParity(int current, int total) {
    return 'Frame $current/$total [Fountain PARITY]';
  }

  @override
  String bodyAirQrFrameBlock(int current, int total, int block) {
    return 'Frame $current/$total [Block $block]';
  }

  @override
  String bodyAirQrTotalFrames(int total, int source, int parity) {
    return 'Total Stream Frames: $total ($source Source + $parity Fountain FEC)';
  }

  @override
  String get tooltipToggleFlashlight => 'Toggle Flashlight';

  @override
  String get actionGrantCameraPermission => 'Allow camera';

  @override
  String get titleArScreen => 'AR CodeVision HUD';

  @override
  String get bodyArInitializing => 'Initializing AR HUD Viewport...';

  @override
  String get actionArClearSelection => 'Clear';

  @override
  String get actionArBatchCopy => 'Batch Copy';

  @override
  String bodyArBatchCopied(int count) {
    return 'Copied $count barcodes to clipboard';
  }

  @override
  String get bodyArCameraPermission =>
      'Camera permission is required for AR CodeVision';

  @override
  String get actionDone => 'Done';

  @override
  String get titleAirQrReceiver => 'AirQR receiver';

  @override
  String get tooltipAirQrTransmitter => 'AirQR Transmitter';

  @override
  String get tooltipAirQrResetStream => 'Reset Stream';

  @override
  String get bodyAirQrInitializing => 'Initializing AirQR Stream Receiver...';

  @override
  String get bodyAirQrStatusReassembled => 'STREAM REASSEMBLED';

  @override
  String get bodyAirQrStatusCapturing => 'CAPTURING OPTICAL STREAM...';

  @override
  String get bodyAirQrStatusIdle => 'POINT AT ANIMATED QR STREAM';

  @override
  String bodyAirQrCaptured(int received, int total) {
    return 'Captured: $received / $total Blocks';
  }

  @override
  String bodyAirQrMissing(int count) {
    return 'Missing: $count';
  }

  @override
  String get titleAirQrTransferComplete => 'Transfer complete!';

  @override
  String get bodyAirQrTransferComplete =>
      'Payload reassembled and verified offline via Fountain error correction.';

  @override
  String get bodyAirQrPayloadCopied => 'Copied payload to clipboard';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get titleHistoryScreen => 'Scan History';

  @override
  String get tooltipHistoryExport => 'Export / Backup';

  @override
  String get actionHistoryClearAll => 'Clear All';

  @override
  String get titleHistoryClear => 'Clear Scan History?';

  @override
  String get bodyHistoryClear =>
      'Are you sure you want to delete all persistent scan history? This action cannot be undone unless you have created a backup.';

  @override
  String get helpHistorySearch => 'Search history (content, format, notes)...';

  @override
  String get labelHistoryFilterAll => 'All';

  @override
  String get labelHistoryFilterStarred => 'Starred';

  @override
  String get labelHistoryFilterUrls => 'URLs';

  @override
  String get labelHistoryFilterWifi => 'Wi-Fi';

  @override
  String get labelHistoryFilterContacts => 'Contacts';

  @override
  String get labelHistoryFilterText => 'Text';

  @override
  String get labelHistoryFilterBarcodes => 'Barcodes';

  @override
  String get emptyHistoryTitle => 'No Scan Records Found';

  @override
  String get emptyHistoryMessage =>
      'Scanned barcodes will automatically appear here.';

  @override
  String emptyHistoryNoMatches(String query) {
    return 'No matches for \"$query\"';
  }

  @override
  String get tooltipMoreOptions => 'More options';

  @override
  String get actionMenuHistory => 'History';

  @override
  String get actionMenuSettings => 'Settings';

  @override
  String get actionGrantPermission => 'Grant Permission';

  @override
  String get tooltipScanFromGallery => 'Scan from gallery';

  @override
  String get tooltipScanPdfDocument => 'Scan PDF Document';

  @override
  String get bodyScanPdfProgress => 'Extracting & scanning PDF pages...';

  @override
  String get bodyScanSharedPdfProgress => 'Scanning shared PDF document...';

  @override
  String get bodyScanInitializingCamera => 'Initializing camera...';

  @override
  String get bodyScanInitializingFeed => 'Initializing camera feed...';

  @override
  String get tooltipScanZoom => 'Zoom slider';

  @override
  String get tooltipScanFlipCamera => 'Switch camera';

  @override
  String labelScanZoomValue(String value) {
    return '${value}x';
  }

  @override
  String get helpScanViewfinder =>
      'Position QR code or barcode within the frame';

  @override
  String get bodyScanCameraPermissionRequired => 'Camera permission required';

  @override
  String get labelCopied => 'Copied!';

  @override
  String get actionHide => 'Hide';

  @override
  String get actionReveal => 'Reveal';

  @override
  String get actionOpenAnyway => 'Open Anyway';

  @override
  String get titleResultScreen => 'Scan Result';

  @override
  String get bodyResultNoResult => 'No result';

  @override
  String get labelResultContent => 'Content:';

  @override
  String get labelResultDecoyContent => 'Decoy content:';

  @override
  String get labelResultDetectedType => 'Detected Type:';

  @override
  String get labelResultTypeStego => 'StegoQR (encrypted)';

  @override
  String get actionResultRecheck => 'Re-check';

  @override
  String get actionResultOpenInBrowser => 'Open in Browser';

  @override
  String get actionResultCopyText => 'Copy Text';

  @override
  String get actionResultCopyDecoyText => 'Copy Decoy Text';

  @override
  String get actionResultShareText => 'Share Text';

  @override
  String get actionResultShareDecoyText => 'Share Decoy Text';

  @override
  String get actionResultScanAnother => 'Scan Another Code';

  @override
  String get errorResultLaunchFailed => 'Could not launch URL';

  @override
  String get bodyStegoUnlocked =>
      'The hidden AES-256 encrypted payload has been decrypted successfully.';

  @override
  String get bodyStegoLocked =>
      'This QR code contains a hidden, encrypted secret layer. Authenticate to view the hidden payload.';

  @override
  String get actionStegoBiometricUnlock => 'Biometric Unlock';

  @override
  String get labelStegoPassphrase => 'Passphrase';

  @override
  String get labelStegoSecretPayload => 'Secret Payload:';

  @override
  String get actionStegoCopySecret => 'Copy Secret';

  @override
  String get actionStegoShareSecret => 'Share Secret';

  @override
  String get bodyStegoSecretCopied => 'Secret copied to clipboard';

  @override
  String get titleStegoDialogBiometric => 'Biometric unlock';

  @override
  String get titleStegoDialogPassphrase => 'Enter Passphrase';

  @override
  String get bodyStegoDialogBiometric =>
      'Confirm passphrase to authenticate with biometrics and decrypt payload.';

  @override
  String get bodyStegoDialogPassphrase =>
      'Enter the passphrase used to encrypt the secret payload.';

  @override
  String get actionStegoUnlock => 'Unlock';

  @override
  String get titleSafetyCheckInProgress => 'Checking security';

  @override
  String get titleSafetyAnalysis => 'Link security';

  @override
  String get bodySafetyAnalyzing => 'Analyzing URL security...';

  @override
  String bodySafetyIssuesDetected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count security issues detected',
      one: '1 security issue detected',
    );
    return '$_temp0';
  }

  @override
  String get bodySafetyNoIssues => 'No issues detected';

  @override
  String get helpSafetyTrustSource =>
      'Only open this URL if you trust the source';

  @override
  String get titleSafetyResults => 'Check results:';

  @override
  String get bodyProbingBannerActive =>
      'Active online checks are ON: SSL, redirect and shortener checks contacted this site directly, exposing your IP address to it. Turn off \"Active online checks\" in Settings to check links privately.';

  @override
  String get bodyProbingBannerPrivate =>
      'Private mode: the site itself was never contacted, so it did not see your IP address or device. Only local rules and the safety services you turned on were used. Turn on \"Active online checks\" in Settings for live SSL and redirect checks.';

  @override
  String get titleWarningDialog => 'Security Warning';

  @override
  String get bodyWarningDialog =>
      'This URL has security issues. Opening it may put your device or data at risk.\n\nAre you sure you want to proceed?';

  @override
  String get titleCautionDialog => 'Caution';

  @override
  String get bodyCautionDialog =>
      'Always verify the source before opening URLs from QR codes.\n\nDo you want to open this URL?';

  @override
  String get labelOverlayLaserLine => 'Laser Line';

  @override
  String get labelOverlayPulsingCorners => 'Pulsing Corners';

  @override
  String get labelOverlayCyberneticGrid => 'Cybernetic Grid';

  @override
  String get labelOverlaySubtleDotMatrix => 'Subtle Dot Matrix';

  @override
  String get descOverlayLaserLine =>
      'Scanning box with an animated vertical laser beam and glow line';

  @override
  String get descOverlayPulsingCorners =>
      'Breathing corner reticles with color glow and scale animation';

  @override
  String get descOverlayCyberneticGrid =>
      'Sci-fi grid overlay pattern with target crosshair reticle';

  @override
  String get descOverlaySubtleDotMatrix =>
      'Minimalist corner dot matrix pattern with pulsing accents';

  @override
  String get labelThemeSystemDefault => 'System Default';

  @override
  String get labelThemeLight => 'Light Theme';

  @override
  String get labelThemeDark => 'Dark Theme';

  @override
  String get labelThemeOled => 'OLED Pure Black';

  @override
  String get titleThemeMode => 'Theme Mode';

  @override
  String get labelThemeChipSystem => 'System';

  @override
  String get labelThemeChipLight => 'Light';

  @override
  String get labelThemeChipDark => 'Dark';

  @override
  String get labelThemeChipOled => 'OLED';

  @override
  String get labelThemeDynamicColors => 'Dynamic colors';

  @override
  String get descThemeDynamicColors =>
      'Sample system wallpaper colors on Android 12+ (Monet engine)';

  @override
  String get descThemeSystem => 'Follow System Settings';

  @override
  String get descThemeLight => 'Standard Light Mode';

  @override
  String get descThemeDark => 'Standard Dark Mode';

  @override
  String get descThemeOled => 'True OLED Pure Black (Battery Saving)';

  @override
  String get titleSettings => 'Settings';

  @override
  String get labelSettingsFeedback => 'Scan feedback';

  @override
  String get labelSettingsPrivacy => 'Privacy & probing';

  @override
  String get labelSettingsPermissions => 'Permissions';

  @override
  String get descSettingsPermissions =>
      'Explicit, implicit & setting-dependent details';

  @override
  String get labelSettingsHelp => 'Help & guides';

  @override
  String get descSettingsHelp =>
      'AR CodeVision, AirQR, Quishing Guard & URL Safety';

  @override
  String get descSettingsAbout => 'App version, developer & license details';

  @override
  String get labelFeedbackVibration => 'Vibration Feedback';

  @override
  String get descFeedbackVibration =>
      'Vibrate phone upon successful barcode recognition';

  @override
  String get labelFeedbackSound => 'Audible Beep Sound';

  @override
  String get descFeedbackSound =>
      'Play audio beep signal upon successful code recognition';

  @override
  String get labelFeedbackAnimation => 'Success animation';

  @override
  String get descFeedbackAnimation =>
      'Play reticle pulse and checkmark morph upon successful scan';

  @override
  String get titlePrivacyScreen => 'Privacy & probing';

  @override
  String get labelPrivacyActiveChecks => 'Active online checks';

  @override
  String get descPrivacySummaryOn => 'Active online checks enabled';

  @override
  String get descPrivacySummaryOff => 'Private offline checks only';

  @override
  String get labelApiKeyConfigured => 'Configured';

  @override
  String get labelApiKeyNotConfigured => 'Not configured';

  @override
  String get titleApiKeyDelete => 'Delete API Key';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionApiKeySave => 'Save API Key';

  @override
  String get titlePermissionsScreen => 'Permissions Overview';

  @override
  String get helpPermissionsExplicitHeading =>
      'Explicit Permissions (Runtime / Manifest)';

  @override
  String get helpPermissionCameraTitle =>
      'Camera Access (android.permission.CAMERA)';

  @override
  String get helpPermissionCameraDesc =>
      'Requested on-demand at point of use. Required for live scanning, AR CodeVision HUD overlay, and AirQR optical stream decoding.';

  @override
  String get helpPermissionBiometricTitle =>
      'Biometric Authentication (android.permission.USE_BIOMETRIC)';

  @override
  String get helpPermissionBiometricDesc =>
      'Requested when unlocking biometric secure vaults or encrypted QR code payloads.';

  @override
  String get helpPermissionsImplicitHeading => 'Implicit & System Permissions';

  @override
  String get helpPermissionInternetTitle =>
      'Internet Access (android.permission.INTERNET)';

  @override
  String get helpPermissionInternetDesc =>
      'Declared in Android Manifest. Used only when Active Online Probing or Google Safe Browsing API lookup is enabled.';

  @override
  String get helpPermissionVibrateTitle =>
      'Vibration & Haptics (android.permission.VIBRATE)';

  @override
  String get helpPermissionVibrateDesc =>
      'System permission. Triggers haptic vibration feedback during scan alerts and button taps.';

  @override
  String get helpPermissionPhotoPickerTitle => 'Scoped Media Photo Picker';

  @override
  String get helpPermissionPhotoPickerDesc =>
      'System photo picker access. Allows selecting QR images or videos from gallery without requesting full storage access.';

  @override
  String get helpPermissionsSettingHeading => 'Setting-Dependent Permissions';

  @override
  String get helpPermissionProbingTitle =>
      'Active Online Probing (Privacy Setting)';

  @override
  String get helpPermissionProbingDesc =>
      'Active only when enabled. Performs outbound HTTP HEAD requests to follow URL redirects and check SSL certificates. When disabled, checks are 100% offline.';

  @override
  String get helpPermissionSafeBrowsingTitle =>
      'Google Safe Browsing API (API Key Setting)';

  @override
  String get helpPermissionSafeBrowsingDesc =>
      'Active only when API key is configured. Queries Google Threat API for malware & phishing checks.';

  @override
  String get helpPermissionFeedbackTitle =>
      'Scan Feedback Vibrations (Alert Setting)';

  @override
  String get helpPermissionFeedbackDesc =>
      'Active only when Vibration is enabled in Scan Feedback & Alerts settings.';

  @override
  String get labelOn => 'On';

  @override
  String get labelOff => 'Off';

  @override
  String get descPrivacyActiveChecks =>
      'Off: scanned links are checked privately — the destination server is never contacted.';

  @override
  String get bodyPrivacyExplainerOn =>
      'When on, the SSL, redirect and shortener checks connect directly to the scanned site. This exposes your IP address (and therefore your approximate location and mobile carrier) to that server before you open the link.';

  @override
  String get bodyPrivacyExplainerOff =>
      'SSL, redirect and shortener checks run from local rules only. Malicious-content lookup still uses Google Safe Browsing (the link is sent only to Google, never to the scanned site).';

  @override
  String get bodyApiKeyDelete =>
      'Are you sure you want to delete your Google Safe Browsing API key? URL malicious content checking will be disabled.';

  @override
  String descFeedbackSummary(String vibration, String sound) {
    return 'Vibration: $vibration • Sound: $sound';
  }

  @override
  String get labelResultTypeTextFallback => 'TEXT';

  @override
  String get labelCheckNameHttps => 'HTTPS Connection';

  @override
  String get labelCheckNameSsl => 'SSL/TLS Certificate';

  @override
  String get labelCheckNameRedirect => 'Redirect Analysis';

  @override
  String get labelCheckNamePattern => 'Pattern Detection';

  @override
  String get labelCheckNameShortener => 'URL Shortener Check';

  @override
  String get labelCheckNameHomograph => 'Homograph check';

  @override
  String get labelCheckNameMalicious => 'Malicious content';

  @override
  String get bodyHttpsNotUsed => 'URL uses unencrypted HTTP connection';

  @override
  String get bodySslPrivateModeOk =>
      'Uses HTTPS (live certificate not checked in private mode)';

  @override
  String get bodySslValid => 'Valid SSL certificate';

  @override
  String get bodySslExpired => 'SSL certificate has expired';

  @override
  String get bodySslNotYetValid => 'SSL certificate not yet valid';

  @override
  String get bodySslUnverifiable => 'Unable to verify certificate';

  @override
  String get bodySslCheckFailed => 'Certificate check failed';

  @override
  String get bodyRedirectSkippedPrivate =>
      'Skipped in private mode (destination server not contacted)';

  @override
  String get bodyRedirectLoop => 'Redirect loop detected';

  @override
  String get bodyRedirectNone => 'No redirects detected';

  @override
  String get bodyRedirectUnavailable => 'Unable to check redirects';

  @override
  String get bodyPatternNone => 'No suspicious patterns found';

  @override
  String get bodyPatternUnavailable => 'Unable to analyze patterns';

  @override
  String get bodyShortenerOfflineHeuristics =>
      'Unable to perform full check (offline) - heuristics only';

  @override
  String get bodyShortenerNone => 'No URL shortener detected';

  @override
  String get bodyShortenerUnavailable => 'Unable to check for shorteners';

  @override
  String get bodyHomographMixedScripts => 'Mixed character scripts detected';

  @override
  String get bodyHomographNone => 'No lookalike characters detected';

  @override
  String get bodyHomographUnavailable => 'Unable to check for homographs';

  @override
  String get bodyMaliciousSkippedNoKey => 'Skipped (API key not configured)';

  @override
  String get bodyMaliciousDailyLimit =>
      'Daily API limit reached (resets tomorrow)';

  @override
  String get bodyMaliciousNone => 'No known threats detected';

  @override
  String get bodyMaliciousInvalidKey => 'Invalid API key or request';

  @override
  String get bodyMaliciousRateLimited => 'Rate limit exceeded';

  @override
  String get bodyMaliciousUnavailable =>
      'Unable to check for malicious content';

  @override
  String get errorStegoWrongPassphrase =>
      'Decryption failed. Invalid passphrase or corrupted data.';

  @override
  String get errorAirQrChecksumFailed =>
      'Checksum verification failed during reassembly.';

  @override
  String bodyRedirectSuspiciousChain(String count) {
    return 'Suspicious redirect chain ($count redirects)';
  }

  @override
  String bodyRedirectWithinRange(String count) {
    return '$count redirect(s) - within normal range';
  }

  @override
  String bodyPatternDetected(String patterns) {
    return 'Detected: $patterns';
  }

  @override
  String bodyShortenerKnown(String shortener) {
    return 'Known URL shortener detected ($shortener)';
  }

  @override
  String bodyShortenerRedirect(String host) {
    return 'Detected URL shortener (redirects to $host)';
  }

  @override
  String bodyHomographLookalikes(String characters) {
    return 'Lookalike characters detected: $characters';
  }

  @override
  String bodyMaliciousThreats(String threats) {
    return 'Threats detected: $threats';
  }

  @override
  String bodyMaliciousApiError(String status) {
    return 'API error (status: $status)';
  }

  @override
  String get labelCheckNameVirusTotal => 'VirusTotal';

  @override
  String get bodyVirusTotalSkippedNoKey => 'Skipped (API key not configured)';

  @override
  String get bodyVirusTotalDailyLimit =>
      'Daily limit reached (500/day — resets tomorrow)';

  @override
  String bodyVirusTotalThreats(String engines) {
    return 'Threats detected by $engines engine(s)';
  }

  @override
  String get bodyVirusTotalNone => 'No threats detected (VirusTotal)';

  @override
  String get bodyVirusTotalInvalidKey =>
      'Invalid API key or request (VirusTotal)';

  @override
  String get bodyVirusTotalRateLimited => 'Rate limit exceeded (VirusTotal)';

  @override
  String bodyVirusTotalApiError(String status) {
    return 'API error (status: $status)';
  }

  @override
  String get bodyVirusTotalUnavailable => 'Unable to check (VirusTotal)';

  @override
  String get labelCheckNameUrlhaus => 'URLhaus';

  @override
  String get bodyUrlhausSkippedNoKey => 'Skipped (API key not configured)';

  @override
  String bodyUrlhausMalware(String tags) {
    return 'Malware URL detected: $tags';
  }

  @override
  String get bodyUrlhausClean => 'No known malware hosting (URLhaus)';

  @override
  String get bodyUrlhausNotFound => 'Not in URLhaus database';

  @override
  String get bodyUrlhausInvalidKey => 'Invalid API key (URLhaus)';

  @override
  String bodyUrlhausApiError(String status) {
    return 'API error (status: $status)';
  }

  @override
  String get bodyUrlhausUnavailable => 'Unable to check (URLhaus)';

  @override
  String get labelCheckNamePhishTank => 'PhishTank';

  @override
  String get bodyPhishTankSkippedDisabled => 'Skipped (PhishTank disabled)';

  @override
  String get bodyPhishTankPhishing => 'Known phishing site (PhishTank)';

  @override
  String get bodyPhishTankClean => 'Not a known phishing site (PhishTank)';

  @override
  String get bodyPhishTankNotInDatabase => 'Not in PhishTank database';

  @override
  String bodyPhishTankApiError(String status) {
    return 'API error (status: $status)';
  }

  @override
  String get bodyPhishTankUnavailable => 'Unable to check (PhishTank)';

  @override
  String get labelCheckNameOpenPhish => 'OpenPhish';

  @override
  String get bodyOpenPhishSkippedDisabled => 'Skipped (OpenPhish disabled)';

  @override
  String get bodyOpenPhishPhishing => 'Known phishing site (OpenPhish)';

  @override
  String get bodyOpenPhishClean => 'Not in phishing feed (OpenPhish)';

  @override
  String get bodyOpenPhishFeedStale =>
      'Feed unavailable — offline check skipped';

  @override
  String get bodyOpenPhishUnavailable => 'Unable to check (OpenPhish)';

  @override
  String get labelSettingsUrlSafetyProviders => 'URL Safety Providers';

  @override
  String descSettingsUrlSafetyProviders(String count) {
    return '$count provider(s) active';
  }

  @override
  String get helpUrlSafetyProviders =>
      'Configure optional online URL safety checks. Each provider is independent. Non-commercial providers require your own free account and API key.';

  @override
  String get titleUrlSafetyUserSupplied => 'Your API Keys';

  @override
  String get descUrlSafetyUserSupplied => 'Non-commercial use only';

  @override
  String get titleUrlSafetyBuiltIn => 'Built-In Providers';

  @override
  String get descUrlSafetyBuiltIn => 'No account needed — just toggle on';

  @override
  String get labelProviderEndpoint => 'API Endpoint URL';

  @override
  String get labelProviderApiKey => 'Paste your API key';

  @override
  String get bodyProviderGetKeyAt => 'Get a free key at:';

  @override
  String bodyProviderDailyUsage(String used, String max) {
    return '$used / $max requests today';
  }

  @override
  String bodyOpenPhishLastUpdated(String datetime) {
    return 'Last updated: $datetime';
  }

  @override
  String get actionOpenPhishRefresh => 'Refresh feed now';

  @override
  String bodyOpenPhishFeedRefreshed(String count) {
    return 'Feed updated ($count URLs)';
  }

  @override
  String get errorOpenPhishFeedFailed => 'Feed refresh failed';

  @override
  String get labelPhishTankToggle => 'Enable PhishTank';

  @override
  String get labelOpenPhishToggle => 'Use OpenPhish feed';

  @override
  String get bodyQuishingSummaryAuthentic =>
      'Authentic Printed Code. No physical tampering detected.';

  @override
  String get bodyQuishingSummaryWearAndTear =>
      'Wear & Tear Detected. Slight physical surface noise observed.';

  @override
  String get bodyQuishingSummaryHighWarning =>
      'High Warning: Physical Overlay Sticker Detected! Verify Before Tapping Links.';

  @override
  String get bodyQuishingStatusAuthentic => '🟢 Authentic Printed Code';

  @override
  String get bodyQuishingStatusWearAndTear => '🟡 Wear & Tear Detected';

  @override
  String get bodyQuishingStatusHighWarning =>
      '🔴 High Warning: Physical Overlay Sticker Detected!';

  @override
  String get bodyQuishingSignalMicroShadowPerimeter =>
      'Micro-shadow depth step line detected along matrix perimeter';

  @override
  String get bodyQuishingSignalGrainAberration =>
      'Mismatching inkjet/thermal grain chromatic aberration detected';

  @override
  String get bodyQuishingSignalUniformReflection =>
      'Uniform substrate reflection profile verified';

  @override
  String get bodyQuishingSignalConsistentDotsQrMatrix =>
      'Consistent halftone dot density across QR matrix perimeter';

  @override
  String get bodyQuishingSignalReflectionVerified =>
      'Substrate reflection profile verified';

  @override
  String get bodyQuishingSignalHalftoneConsistentQrMatrix =>
      'Halftone dot density consistent across QR matrix perimeter';

  @override
  String get bodyQuishingSignalHalftoneConsistentMatrix =>
      'Halftone dot density consistent across matrix';

  @override
  String get bodyQuishingSignalDoubleEdgeAroundMatrix =>
      'Perimeter double-edge reflection detected around QR matrix';

  @override
  String get bodyQuishingSignalMicroShadowStickerBorder =>
      'Micro-shadow depth step line detected along sticker border';

  @override
  String get bodyQuishingSignalGrainMismatchBase =>
      'Inkjet/thermal print grain mismatching base substrate';

  @override
  String get bodyQuishingSignalMinorScratch =>
      'Minor surface scratch or wear pattern observed';

  @override
  String get bodyQuishingSignalSlightDotIrregularity =>
      'Slight dot density irregularity along edges';

  @override
  String get bodyQuishingSignalConsistentDotsMatrixPerimeter =>
      'Consistent halftone dot density across matrix perimeter';

  @override
  String bodyQuishingSignalPerimeterDoubleEdge(String zones) {
    return 'Perimeter double-edge reflection detected ($zones boundary zones)';
  }

  @override
  String bodyQuishingSignalDotDensityVariance(String variance) {
    return 'Substrate halftone dot density inconsistency detected ($variance% variance)';
  }

  @override
  String get bodyDomSslInvalidScheme => 'Invalid URL scheme';

  @override
  String get bodyDomSslHttps => 'Uses encrypted HTTPS protocol';

  @override
  String get bodyDomSslHttp => 'Unencrypted HTTP connection (High Risk)';

  @override
  String get bodyDomStatusInvalidUrl =>
      'Invalid or unsupported web URL format.';

  @override
  String get bodyDomStatusHttpCaution => '⚠️ Caution: Unencrypted HTTP site';

  @override
  String get bodyDomStatusSafe =>
      '✅ Zero-Trust DOM Sandbox: HTML preview sanitized safely.';

  @override
  String bodyDomStatusOpenRedirect(String target) {
    return '⚠️ Warning: Open Redirect Trap detected pointing to $target';
  }

  @override
  String bodyDomStatusNewDomain(String days) {
    return '⚠️ Warning: Newly registered domain ($days days old)';
  }

  @override
  String get errorStegoPassphraseEmpty => 'Passphrase cannot be empty';

  @override
  String get bodyStegoBiometricReason =>
      'Authenticate to view StegoQR secret payload';

  @override
  String get errorMediaNoCodeInImage =>
      'No barcodes or QR codes detected in image.';

  @override
  String get errorMediaNoCodeInPdf =>
      'No barcodes or QR codes found in PDF document.';

  @override
  String errorMediaImagePickFailed(String error) {
    return 'Failed to pick or scan image: $error';
  }

  @override
  String errorMediaImageAnalyzeFailed(String error) {
    return 'Error analyzing image: $error';
  }

  @override
  String errorMediaPdfPickFailed(String error) {
    return 'Failed to pick or parse PDF: $error';
  }

  @override
  String errorMediaPdfScanFailed(String error) {
    return 'Failed to scan PDF document: $error';
  }

  @override
  String get errorStegoBiometricCanceled =>
      'Biometric authentication canceled or failed.';

  @override
  String get labelFormatQrUrl => 'QR (URL)';

  @override
  String get labelFormatQrEmail => 'QR (Email)';

  @override
  String get labelFormatQrPhone => 'QR (Phone)';

  @override
  String get labelFormatQrSms => 'QR (SMS)';

  @override
  String get labelFormatQrWifi => 'QR (Wi-Fi)';

  @override
  String get labelFormatQrLocation => 'QR (Location)';

  @override
  String get labelFormatQrContact => 'QR (Contact)';

  @override
  String get labelFormatIsbn => 'ISBN';

  @override
  String get labelFormatEanUpc => 'EAN/UPC';

  @override
  String get labelFormatQrCode => 'QR Code';

  @override
  String get labelFormatEanUpcProduct => 'EAN/UPC Product';

  @override
  String get labelFormatBarcode => 'Barcode';

  @override
  String get labelWifiHiddenNetwork => 'Hidden Network';

  @override
  String get labelTotpDefaultAccount => 'Account';

  @override
  String get errorBackupInvalidFormat => 'Invalid backup file format.';

  @override
  String get errorBackupBadHeader =>
      'Unrecognized or corrupted backup file header.';

  @override
  String get errorBackupWrongPassphrase =>
      'Incorrect passphrase or corrupted backup payload.';

  @override
  String get bodyReportHeading => 'SREERAJP QR STUDIO - SCAN HISTORY';

  @override
  String get bodyReportTitle => 'Scan History Export';

  @override
  String get labelReportExportDate => 'Export Date';

  @override
  String get labelReportTotalScans => 'Total Scans';

  @override
  String get labelReportScanNumber => 'Scan #';

  @override
  String get labelReportId => 'ID           ';

  @override
  String get labelReportTimestamp => 'Timestamp    ';

  @override
  String get labelReportFormat => 'Format       ';

  @override
  String get labelReportCategory => 'Category     ';

  @override
  String get labelReportSafetyScore => 'Safety Score ';

  @override
  String get labelReportStarred => 'Starred      ';

  @override
  String get labelReportStarredYes => '⭐ Yes';

  @override
  String get labelReportStarredNo => 'No';

  @override
  String get labelReportLocation => 'Location     ';

  @override
  String get labelReportNotes => 'Notes        ';

  @override
  String get labelReportContent => 'Content      ';

  @override
  String get labelReportColumnDateTime => 'Date & Time';

  @override
  String get labelReportColumnFormat => 'Format';

  @override
  String get labelReportColumnCategory => 'Category';

  @override
  String get labelReportColumnSafety => 'Safety';

  @override
  String get labelReportColumnContent => 'Content Snippet';

  @override
  String get labelReportColumnNotes => 'Notes';

  @override
  String get labelPatternIpAddress => 'IP Address';

  @override
  String get labelPatternLongNumbers => 'Long Number Sequence';

  @override
  String get labelPatternManyDashes => 'Many dashes';

  @override
  String get labelPatternPhishingKeywords => 'Phishing Keywords';

  @override
  String get labelPatternDataUri => 'Data URI';

  @override
  String get labelPatternManySubdomains => 'Multiple Subdomains';

  @override
  String get bodyShortenerPossibleShortDomain =>
      'Possible URL shortener: short domain with minimal path';

  @override
  String get bodyShortenerPossibleRandomPath =>
      'Possible URL shortener: random character pattern in short path';

  @override
  String bodyShortenerPossibleTld(String tld) {
    return 'Possible URL shortener: short domain with common shortener ending ($tld)';
  }

  @override
  String get titleSettingsFeatures => 'Features';

  @override
  String get descSettingsFeatures =>
      'Explore all features of SreerajP QR Studio';

  @override
  String get titleAppearanceHub => 'Appearance';

  @override
  String get labelAppearanceThemeModeCard => 'Theme Mode';

  @override
  String get descAppearanceThemeModeCard =>
      'Choose between System, Light, Dark, or OLED mode';

  @override
  String get labelAppearanceOverlayCard => 'Scan Overlay Style';

  @override
  String get descAppearanceOverlayCard =>
      'Laser line, pulsing corners, cybernetic grid, or dot matrix';

  @override
  String get labelAppearanceAccentCard => 'Accent & colors';

  @override
  String get descAppearanceAccentCard =>
      'Material You dynamic color and custom accent palettes';

  @override
  String get labelAppearanceTypographyCard => 'Text size & font';

  @override
  String get descAppearanceTypographyCard =>
      'App font family and text scale preferences';

  @override
  String get titleFeaturesHeader => 'All features';

  @override
  String get descFeaturesHeader =>
      'Explore every intelligent scanning tool, 6-layer URL safety engine, AR CodeVision, and offline feature designed for you.';

  @override
  String get titleFeaturesCatScanning => 'Scanning';

  @override
  String get descFeaturesCatScanning =>
      'Lightning-fast 1D/2D barcode engine with multi-source media support';

  @override
  String get titleFeaturesCatSafety => '6-layer link safety';

  @override
  String get descFeaturesCatSafety =>
      'Zero-trust forensic analysis defending you against malicious QR phishing & scams';

  @override
  String get titleFeaturesCatVision => 'Vision tools';

  @override
  String get descFeaturesCatVision =>
      'Cutting-edge on-device computer vision and optical air-gap data streaming';

  @override
  String get titleFeaturesCatPayloads => 'Smart actions';

  @override
  String get descFeaturesCatPayloads =>
      'Instant parsing and contextual native actions for everyday barcodes';

  @override
  String get titleFeaturesCatHistory => 'History & privacy';

  @override
  String get descFeaturesCatHistory =>
      'Your personal scan history protected by biometric security and offline storage';

  @override
  String get titleFeatureBarcodeEngine => 'Barcode engine';

  @override
  String get descFeatureBarcodeEngine =>
      'Instantly decodes 1D barcodes (EAN-13, UPC-A, Code 128, Code 39, Codabar, ITF) and 2D codes (QR, Data Matrix, Aztec, PDF417) in milliseconds.';

  @override
  String get labelFeatureBarcodeEngineChip1 => 'QR & Data Matrix';

  @override
  String get labelFeatureBarcodeEngineChip2 => 'Aztec & PDF417';

  @override
  String get labelFeatureBarcodeEngineChip3 => 'EAN & Code 128';

  @override
  String get titleFeatureMediaSources => 'Images & PDF';

  @override
  String get descFeatureMediaSources =>
      'Scan barcodes from live camera feed, select existing images from your gallery, or extract and parse barcodes across multi-page PDF documents.';

  @override
  String get labelFeatureMediaSourcesChip1 => 'Gallery Photos';

  @override
  String get labelFeatureMediaSourcesChip2 => 'Multi-Page PDF';

  @override
  String get labelFeatureMediaSourcesChip3 => 'Live Viewport';

  @override
  String get titleFeatureGhostScan => 'GhostScan';

  @override
  String get descFeatureGhostScan =>
      'Detects and decodes QR codes visible on your screen inside messaging apps, social feeds, and web browsers via Quick Settings tile, the floating Scan bubble, or on-demand trigger without saving screenshots.';

  @override
  String get labelFeatureGhostScanChip1 => 'Quick Settings Tile';

  @override
  String get labelFeatureGhostScanChip2 => 'Floating Scan Bubble';

  @override
  String get labelFeatureGhostScanChip3 => 'No Screenshots Saved';

  @override
  String get titleFeatureCameraControls => 'Camera controls';

  @override
  String get descFeatureCameraControls =>
      'Smooth zoom slider, torch flashlight toggle, front and rear camera switching, and continuous autofocus for low-light scanning.';

  @override
  String get labelFeatureCameraControlsChip1 => 'Flashlight Torch';

  @override
  String get labelFeatureCameraControlsChip2 => 'Zoom Control';

  @override
  String get labelFeatureCameraControlsChip3 => 'Front/Back Flip';

  @override
  String get titleFeatureScanOverlays => 'Scan overlays';

  @override
  String get descFeatureScanOverlays =>
      'Choose between Laser Line, Pulsing Corners, Cybernetic Grid, or Subtle Dot Matrix viewfinder overlays with live feedback.';

  @override
  String get labelFeatureScanOverlaysChip1 => '4 Overlay Styles';

  @override
  String get labelFeatureScanOverlaysChip2 => 'Live Animation';

  @override
  String get labelFeatureScanOverlaysChip3 => 'OLED Compatible';

  @override
  String get titleFeatureFeedback => 'Haptic & sound';

  @override
  String get descFeatureFeedback =>
      'Customizable vibration pulses and audible beep tones confirm successful recognition even in noisy environments.';

  @override
  String get labelFeatureFeedbackChip1 => 'Haptic Pulse';

  @override
  String get labelFeatureFeedbackChip2 => 'Audio Beep';

  @override
  String get labelFeatureFeedbackChip3 => 'Independent Toggles';

  @override
  String get titleFeatureProtocolGuard => '1. Protocol guard';

  @override
  String get descFeatureProtocolGuard =>
      'Validates scheme authenticity, checks for encrypted HTTPS connections, and flags plain HTTP or unsupported schemes.';

  @override
  String get labelFeatureProtocolGuardChip1 => 'HTTPS Validation';

  @override
  String get labelFeatureProtocolGuardChip2 => 'Scheme Checking';

  @override
  String get labelFeatureProtocolGuardChip3 => 'Zero-Width Char Trap';

  @override
  String get titleFeatureHomographShield => '2. Homograph shield';

  @override
  String get descFeatureHomographShield =>
      'Detects lookalike Cyrillic, Greek, and Unicode spoofing characters used to disguise fraudulent domain names (IDN punycode defense).';

  @override
  String get labelFeatureHomographShieldChip1 => 'Punycode Defense';

  @override
  String get labelFeatureHomographShieldChip2 => 'Cyrillic Lookalikes';

  @override
  String get labelFeatureHomographShieldChip3 => 'Mixed-Script Trap';

  @override
  String get titleFeatureTldEntropy => '3. TLD & entropy';

  @override
  String get descFeatureTldEntropy =>
      'Flags high-risk top-level domains, excessive subdomains, and evaluates domain name character entropy to catch algorithmic domains.';

  @override
  String get labelFeatureTldEntropyChip1 => 'High-Risk TLDs';

  @override
  String get labelFeatureTldEntropyChip2 => 'Entropy Scoring';

  @override
  String get labelFeatureTldEntropyChip3 => 'Subdomain Depth';

  @override
  String get titleFeatureIpPort => '4. IP & port check';

  @override
  String get descFeatureIpPort =>
      'Flags links pointing directly to raw IP addresses or non-standard HTTP/HTTPS network ports designed to bypass firewalls.';

  @override
  String get labelFeatureIpPortChip1 => 'Raw IP Traps';

  @override
  String get labelFeatureIpPortChip2 => 'Non-Standard Ports';

  @override
  String get labelFeatureIpPortChip3 => 'Embedded Userinfo';

  @override
  String get titleFeatureHeadProbe => '5. Online probe';

  @override
  String get descFeatureHeadProbe =>
      'Optional opt-in lightweight HTTP HEAD probing to resolve URL shorteners, uncover hidden redirect chains, and verify TLS certificates.';

  @override
  String get labelFeatureHeadProbeChip1 => 'Redirect Chains';

  @override
  String get labelFeatureHeadProbeChip2 => 'Shortener Unrolling';

  @override
  String get labelFeatureHeadProbeChip3 => 'Opt-In Privacy';

  @override
  String get titleFeatureSafeBrowsing => '6. Safe Browsing';

  @override
  String get descFeatureSafeBrowsing =>
      'Optional cloud threat intelligence against millions of known malicious URLs, malware distribution hubs, and social engineering sites.';

  @override
  String get labelFeatureSafeBrowsingChip1 => 'Google Threat DB';

  @override
  String get labelFeatureSafeBrowsingChip2 => 'Local Key Storage';

  @override
  String get labelFeatureSafeBrowsingChip3 => 'Daily Quota Meter';

  @override
  String get titleFeatureQuishingGuard => 'QuishingGuard™';

  @override
  String get descFeatureQuishingGuard =>
      'Forensic computer vision pipeline detecting physical QR sticker overlays, edge discontinuities, micro-shadows, and chromatic halftone print grain.';

  @override
  String get labelFeatureQuishingGuardChip1 => 'Sticker Overlays';

  @override
  String get labelFeatureQuishingGuardChip2 => 'Edge Discontinuity';

  @override
  String get labelFeatureQuishingGuardChip3 => 'Print Grain Analysis';

  @override
  String get titleFeatureArCodeVision => 'AR CodeVision™';

  @override
  String get descFeatureArCodeVision =>
      'Augmented Reality multi-barcode scanner displaying floating interactive chips over all detected codes with live safety badges and batch selection.';

  @override
  String get labelFeatureArCodeVisionChip1 => 'Spatial Tracking';

  @override
  String get labelFeatureArCodeVisionChip2 => 'Multi-Code HUD';

  @override
  String get labelFeatureArCodeVisionChip3 => 'Batch Select';

  @override
  String get titleFeatureAirQr => 'AirQR™ transfer';

  @override
  String get descFeatureAirQr =>
      'High-speed animated strobe QR transmitter & receiver pipeline transferring encrypted text, files, and keys completely offline without Wi-Fi or Bluetooth.';

  @override
  String get labelFeatureAirQrChip1 => 'Animated Strobe QR';

  @override
  String get labelFeatureAirQrChip2 => 'Reed-Solomon FEC';

  @override
  String get labelFeatureAirQrChip3 => '100% Offline Air-Gap';

  @override
  String get titleFeatureStegoQr => 'StegoQR™ scanner';

  @override
  String get descFeatureStegoQr =>
      'Discovers and extracts hidden encrypted payloads and watermarked data layers invisibly embedded within custom QR codes.';

  @override
  String get labelFeatureStegoQrChip1 => 'Decoy QR Parsing';

  @override
  String get labelFeatureStegoQrChip2 => 'AES Decryption';

  @override
  String get labelFeatureStegoQrChip3 => 'Biometric Auth';

  @override
  String get titleFeatureWifi => 'Wi-Fi auto connect';

  @override
  String get descFeatureWifi =>
      'Parses WPA/WPA2/WPA3 network credentials, displays network info, copies passwords, and opens Wi-Fi settings in 1 tap.';

  @override
  String get labelFeatureWifiChip1 => 'WPA3 & WPA2';

  @override
  String get labelFeatureWifiChip2 => '1-Tap Connect';

  @override
  String get labelFeatureWifiChip3 => 'Password Reveal/Copy';

  @override
  String get titleFeaturePayments => 'UPI & crypto pay';

  @override
  String get descFeaturePayments =>
      'Parses Indian UPI QR codes (dispatching to GPay, PhonePe, Paytm) and Bitcoin/Ethereum/Solana crypto payment addresses with amount detection.';

  @override
  String get labelFeaturePaymentsChip1 => 'UPI App Dispatch';

  @override
  String get labelFeaturePaymentsChip2 => 'Crypto Wallets';

  @override
  String get labelFeaturePaymentsChip3 => 'SEPA Transfer';

  @override
  String get titleFeatureTotp => 'TOTP authenticator';

  @override
  String get descFeatureTotp =>
      'Scans 2FA setup codes, renders live rolling 6-digit OTP passcodes with circular countdown timers, and imports into authenticator apps.';

  @override
  String get labelFeatureTotpChip1 => 'Live Passcodes';

  @override
  String get labelFeatureTotpChip2 => 'Visual Countdown';

  @override
  String get labelFeatureTotpChip3 => 'App Importer';

  @override
  String get titleFeatureContacts => 'Contacts & vCard';

  @override
  String get descFeatureContacts =>
      'Parses vCard 2.1/3.0/4.0 and MeCard contact barcodes with 1-tap phone dialing, email composition, and saving to your address book.';

  @override
  String get labelFeatureContactsChip1 => 'vCard 4.0';

  @override
  String get labelFeatureContactsChip2 => '1-Tap Save';

  @override
  String get labelFeatureContactsChip3 => 'Direct Call & Email';

  @override
  String get titleFeatureCalendar => 'Calendar events';

  @override
  String get descFeatureCalendar =>
      'Reads iCalendar VEVENT formats with start/end time ranges, locations, and descriptions, adding them directly to your device calendar.';

  @override
  String get labelFeatureCalendarChip1 => 'iCal Parsing';

  @override
  String get labelFeatureCalendarChip2 => 'Start/End Time';

  @override
  String get labelFeatureCalendarChip3 => 'Device Calendar Add';

  @override
  String get titleFeatureGeo => 'Location & maps';

  @override
  String get descFeatureGeo =>
      'Parses geo: coordinates and search queries, offering instant navigation directions via Google Maps.';

  @override
  String get labelFeatureGeoChip1 => 'Lat/Long Parsing';

  @override
  String get labelFeatureGeoChip2 => 'Google Maps Link';

  @override
  String get labelFeatureGeoChip3 => 'Search Queries';

  @override
  String get titleFeatureScanHistory => 'Offline scan history';

  @override
  String get descFeatureScanHistory =>
      'Stores every scan locally with payload categorization, safety scores, timestamp tracking, favorite stars, and real-time full-text search.';

  @override
  String get labelFeatureScanHistoryChip1 => 'Full-Text Search';

  @override
  String get labelFeatureScanHistoryChip2 => 'Category Filtering';

  @override
  String get labelFeatureScanHistoryChip3 => 'Favorite Stars';

  @override
  String get titleFeatureBackups => 'JSON & CSV backups';

  @override
  String get descFeatureBackups =>
      'Export your complete scan history to standard CSV spreadsheets or encrypted JSON backup files with one-click restore.';

  @override
  String get labelFeatureBackupsChip1 => 'CSV Spreadsheet';

  @override
  String get labelFeatureBackupsChip2 => 'JSON Backup';

  @override
  String get labelFeatureBackupsChip3 => 'One-Click Restore';

  @override
  String get titleFeatureBiometricGuard => 'App & screen lock';

  @override
  String get descFeatureBiometricGuard =>
      'Optional app lock with fingerprint, face or your screen lock. Screens that show scans, history, secrets or API keys block screenshots and screen recording (FLAG_SECURE). You can turn this off in Settings › Privacy & probing. Hidden StegoQR messages can also ask for biometrics.';

  @override
  String get labelFeatureBiometricGuardChip1 => 'Biometric Prompt';

  @override
  String get labelFeatureBiometricGuardChip2 => 'Screenshot Guard';

  @override
  String get labelFeatureBiometricGuardChip3 => 'Encrypted Storage';

  @override
  String get titleFeatureOfflinePrivacy => '100% offline privacy';

  @override
  String get descFeatureOfflinePrivacy =>
      'Scans, decodes, and analyzes barcodes completely on your phone without sending any data to external servers by default.';

  @override
  String get labelFeatureOfflinePrivacyChip1 => 'No Telemetry';

  @override
  String get labelFeatureOfflinePrivacyChip2 => 'Zero Ads';

  @override
  String get labelFeatureOfflinePrivacyChip3 => 'Open-Source Safety';

  @override
  String get helpCenterHeaderTitle => 'Help Center & User Guides';

  @override
  String get helpCenterHeaderSubtitle =>
      'Browse in-depth guides, step-by-step instructions, and solutions for all features of SreerajP QR Studio.';

  @override
  String get actionDecryptPayload => 'Decrypt Payload';

  @override
  String get titleDecryptPayload => 'Decrypt content';

  @override
  String get descDecryptPayload =>
      'Enter the passphrase or session code to decrypt this ciphertext payload.';

  @override
  String get labelCipherMode => 'Cipher Mode';

  @override
  String get labelCipherModeAuto => 'Auto / Standard';

  @override
  String get labelCipherModeAesGcm => 'AES-256-GCM (PBKDF2)';

  @override
  String get labelCipherModeAesCbc => 'AES-256-CBC';

  @override
  String get labelAirQrCode => 'Session Code / Key';

  @override
  String get helpAirQrCode => 'e.g. ABC-DEF';

  @override
  String get titleAirQrDetected => 'AirQR transfer';

  @override
  String get bodyAirQrDetected =>
      'This QR code carries an encrypted optical transfer. Enter the session code shown on the sending device to unlock.';

  @override
  String get titleJsonEnvelopeDetected => 'Encrypted JSON';

  @override
  String get bodyJsonEnvelopeDetected =>
      'This QR code contains an encrypted JSON container. Enter the passphrase to decrypt.';

  @override
  String get labelDecryptedContent => 'Decrypted Content:';

  @override
  String get errorManualDecryptionFailed =>
      'Decryption failed. Please verify the passphrase or cipher settings.';

  @override
  String get titleEmailCard => 'Email Address';

  @override
  String get actionEmailSend => 'Send Email';

  @override
  String get actionEmailCopy => 'Copy';

  @override
  String get errorEmailLaunchFailed =>
      'Could not open email app. Copy the address and open your email app manually.';

  @override
  String get labelEmailSubject => 'Subject';

  @override
  String get labelEmailBody => 'Message';

  @override
  String get titlePhoneCard => 'Phone Number';

  @override
  String get actionPhoneCall => 'Call';

  @override
  String get actionPhoneCopy => 'Copy';

  @override
  String get errorPhoneLaunchFailed =>
      'Could not open the phone dialer. Copy the number and dial manually.';

  @override
  String get titleSmsCard => 'Text Message';

  @override
  String get actionSmsSend => 'Send Message';

  @override
  String get actionSmsCopy => 'Copy';

  @override
  String get errorSmsLaunchFailed =>
      'Could not open the messaging app. Copy the number and message manually.';

  @override
  String get labelSmsBody => 'Message';

  @override
  String get titleAppLinkCard => 'App Link';

  @override
  String get actionAppLinkOpen => 'Open in App';

  @override
  String get errorAppLinkLaunchFailed =>
      'Could not open this app link. The app may not be installed.';

  @override
  String get titleProductBarcodeCard => 'Product Barcode';

  @override
  String get actionProductSearchFood => 'Food Info';

  @override
  String get actionProductSearchWeb => 'Search Web';

  @override
  String get actionProductCopy => 'Copy Barcode';

  @override
  String get errorProductLaunchFailed =>
      'Could not open product search. Try copying the barcode and searching manually.';

  @override
  String get titleIsbnCard => 'Book (ISBN)';

  @override
  String get actionIsbnGoogleBooks => 'Google Books';

  @override
  String get actionIsbnOpenLibrary => 'Open Library';

  @override
  String get actionIsbnCopy => 'Copy ISBN';

  @override
  String get errorIsbnLaunchFailed =>
      'Could not open book lookup. Try copying the ISBN and searching manually.';

  @override
  String get labelHistoryFilterEmail => 'Email';

  @override
  String get labelHistoryFilterPhone => 'Phone';

  @override
  String get labelHistoryFilterSms => 'SMS';

  @override
  String get labelHistoryFilterAppLink => 'App Link';

  @override
  String get labelHistoryFilterProductBarcode => 'Product';

  @override
  String get labelHistoryFilterIsbn => 'Book';

  @override
  String get tooltipScanFlashOff => 'Flash: Off';

  @override
  String get tooltipScanFlashOn => 'Flash: On';

  @override
  String get tooltipScanFlashAuto => 'Flash: Auto';

  @override
  String bodyScanFlashAutoActive(String lux) {
    return 'Auto Flash Active ($lux lux)';
  }

  @override
  String get tooltipCameraTune => 'Camera adjustments';

  @override
  String get titleCameraTune => 'Camera Adjustments';

  @override
  String get labelCameraBrightness => 'Brightness';

  @override
  String get labelCameraContrast => 'Contrast';

  @override
  String get labelCameraInvert => 'Invert colors';

  @override
  String get descCameraInvert =>
      'Optimized for white QR codes on dark screens or metal';

  @override
  String get labelCameraResolution => 'Camera Resolution';

  @override
  String get tooltipCameraResolutionFullHd => '1080p, recommended';

  @override
  String get tooltipCameraResolutionMax => 'Maximum (4K UHD)';

  @override
  String get tooltipCameraResolutionHd => '720p, saves battery';

  @override
  String get actionCameraReset => 'Reset Adjustments';

  @override
  String get labelSettingsLanguage => 'Language';

  @override
  String get labelLanguageSystemDefault => 'System default';

  @override
  String get labelLanguageEnglish => 'English';

  @override
  String get labelLanguageMalayalam => 'മലയാളം';

  @override
  String get labelLanguageSanskrit => 'संस्कृतम्';

  @override
  String bodyAboutCopyright(String year) {
    return '© $year Sreeraj P. All rights reserved.';
  }

  @override
  String get tooltipToggleFlash => 'Toggle flash';

  @override
  String get tooltipCameraAdjustments => 'Camera adjustments';

  @override
  String get tooltipZoomControls => 'Zoom controls';

  @override
  String get tooltipSwitchCamera => 'Switch camera';

  @override
  String get tooltipBack => 'Back';

  @override
  String get tooltipToggleSecretVisibility => 'Show or hide secret';

  @override
  String get tooltipResetStream => 'Reset stream';

  @override
  String get labelAirQrModeText => 'Custom Text';

  @override
  String get labelAirQrModeSync => 'Device Sync';

  @override
  String labelAirQrSyncIncludeHistory(int count) {
    return 'History ($count)';
  }

  @override
  String get labelAirQrSyncIncludeSettings => 'Include app settings';

  @override
  String get labelAirQrSyncPassphrase => 'Passphrase / PIN';

  @override
  String get helpAirQrSyncPassphrase => 'Enter PIN or passphrase to encrypt';

  @override
  String get tooltipAirQrSyncGeneratePin => 'Generate PIN';

  @override
  String get errorAirQrSyncNoData =>
      'Select at least history or settings to sync.';

  @override
  String get titleAirQrSyncPackage => 'AirQR sync package';

  @override
  String bodyAirQrSyncPackageSummary(int records) {
    return 'Contains $records scan records and app configuration';
  }

  @override
  String get labelAirQrSyncEnterPassphrase => 'Sync passphrase';

  @override
  String get labelAirQrSyncRestoreHistory => 'Restore scan history';

  @override
  String get labelAirQrSyncApplySettings => 'Apply app settings';

  @override
  String get actionAirQrSyncDecrypt => 'Decrypt & Sync';

  @override
  String bodyAirQrSyncSuccess(int count) {
    return 'Successfully synced $count records and updated settings!';
  }

  @override
  String get actionAirQrSyncBeam => 'Beam via AirQR';

  @override
  String get titleAirQrSyncSettings => 'AirQR Optical Sync';

  @override
  String get descAirQrSyncSettings =>
      'Beam history & settings air-gapped to another phone';

  @override
  String get tabScan => 'Scan';

  @override
  String get tabCodeForge => 'CodeForge';

  @override
  String get tabHistory => 'History';

  @override
  String get titleCodeForge => 'CodeForge';

  @override
  String get labelCodeForgeSubtitle => 'Barcode & QR Studio';

  @override
  String get labelCodeForgePresetText => 'Text';

  @override
  String get helpCodeForgeText =>
      'Keep text concise for clear and reliable scanning (up to 500 characters)';

  @override
  String get actionCodeForgeLoadFromFile => 'Read from file';

  @override
  String get tooltipCodeForgeLoadFromFile => 'Read text from file';

  @override
  String get errorCodeForgeFileEmpty => 'The selected file is empty.';

  @override
  String get bodyCodeForgeFileTruncated =>
      'Text was trimmed to 500 characters to fit in a single, fast-scanning QR code.';

  @override
  String get bodyCodeForgeFileLoaded => 'Text loaded from file successfully.';

  @override
  String get errorCodeForgeFileReadError => 'Unable to read the selected file.';

  @override
  String get labelCodeForgePresetUrl => 'URL / Link';

  @override
  String get labelCodeForgePresetWifi => 'Wi-Fi';

  @override
  String get labelCodeForgePresetContact => 'Contact';

  @override
  String get labelCodeForgePresetUpi => 'UPI Pay';

  @override
  String get labelCodeForgePresetSms => 'SMS';

  @override
  String get labelCodeForgePresetEmail => 'Email';

  @override
  String get labelCodeForgePresetGeo => 'Location';

  @override
  String get labelCodeForgeWifiSsid => 'Network Name (SSID)';

  @override
  String get labelCodeForgeWifiPassword => 'Password';

  @override
  String get labelCodeForgeWifiSecurity => 'Security';

  @override
  String get labelCodeForgeWifiHidden => 'Hidden Network';

  @override
  String get labelCodeForgeContactName => 'Full Name';

  @override
  String get labelCodeForgeContactPhone => 'Phone Number';

  @override
  String get labelCodeForgeContactEmail => 'Email Address';

  @override
  String get labelCodeForgeContactOrg => 'Company / Org';

  @override
  String get labelCodeForgeUpiVpa => 'UPI ID / VPA';

  @override
  String get labelCodeForgeUpiName => 'Payee Name';

  @override
  String get labelCodeForgeUpiAmount => 'Amount (INR)';

  @override
  String get labelCodeForgeUpiNote => 'Transaction Note';

  @override
  String get labelCodeForgeSmsPhone => 'Recipient Phone';

  @override
  String get labelCodeForgeSmsMessage => 'Message Body';

  @override
  String get labelCodeForgeEmailTo => 'Recipient Email';

  @override
  String get labelCodeForgeEmailSubject => 'Subject';

  @override
  String get labelCodeForgeEmailBody => 'Email Body';

  @override
  String get labelCodeForgeGeoLat => 'Latitude';

  @override
  String get labelCodeForgeGeoLng => 'Longitude';

  @override
  String get actionCodeForgeGeoUseMyLocation => 'Use My Location';

  @override
  String get labelCodeForgeGeoFetching => 'Getting location…';

  @override
  String get errorCodeForgeGeoFailed => 'Could not get location';

  @override
  String get errorCodeForgeGeoPermissionDenied => 'Location permission denied';

  @override
  String get titleCodeForgeDesignStudio => 'Design & Structure';

  @override
  String get titleCodeForgeEyeShape => 'Corner Eye Shape';

  @override
  String get titleCodeForgeEyeBallShape => 'Inner Eye Pupil';

  @override
  String get titleCodeForgePatternShape => 'Data Module Pattern';

  @override
  String get labelCodeForgeShapeSquare => 'Square';

  @override
  String get labelCodeForgeShapeDots => 'Dots';

  @override
  String get labelCodeForgeShapeRounded => 'Rounded';

  @override
  String get labelCodeForgeShapeClassy => 'Classy';

  @override
  String get labelCodeForgeShapeDiamond => 'Diamond';

  @override
  String get labelCodeForgeShapeLeaf => 'Leaf';

  @override
  String get labelCodeForgeShapeCircle => 'Circle';

  @override
  String get titleCodeForgeColorStudio => 'Colors & Gradients';

  @override
  String get titleCodeForgeFgColor => 'Foreground';

  @override
  String get titleCodeForgeBgColor => 'Background';

  @override
  String get labelCodeForgeGradientNone => 'Solid Color';

  @override
  String get labelCodeForgeGradientSunset => 'Sunset';

  @override
  String get labelCodeForgeGradientOcean => 'Ocean';

  @override
  String get labelCodeForgeGradientNeon => 'Neon';

  @override
  String get labelCodeForgeGradientGold => 'Royal Gold';

  @override
  String get titleCodeForgeErrorCorrection => 'Error Correction';

  @override
  String get titleCodeForgeCenterBadge => 'Center Badge';

  @override
  String get labelCodeForgeBadgeNone => 'None';

  @override
  String get labelCodeForgeBadgeIcon => 'Content Icon';

  @override
  String get labelCodeForgeBadgeShield => 'Verified Shield';

  @override
  String get actionCodeForgeExportPng => 'Share PNG';

  @override
  String get actionCodeForgeExportSvg => 'Share SVG';

  @override
  String get tooltipCodeForgeCopyPayload => 'Copy Content';

  @override
  String get bodyCodeForgeCopied => 'Barcode content copied to clipboard';

  @override
  String get bodyCodeForgeSafeVerified =>
      'Verified Safe by 6-Layer Security Engine';

  @override
  String get tooltipCodeForgeResetStyle => 'Reset Styling';

  @override
  String get labelCodeForgeIncludeText => 'Show Text Label';

  @override
  String get titleCodeForgePreview => 'Live Preview';

  @override
  String get actionOnboardingSkip => 'Skip';

  @override
  String get actionOnboardingNext => 'Next';

  @override
  String get actionOnboardingGetStarted => 'Start Scanning';

  @override
  String get labelOnboardingSlide1Badge => '6-Layer Security';

  @override
  String get titleOnboardingSlide1 => '6-layer link safety';

  @override
  String get bodyOnboardingSlide1 =>
      'Every link is inspected across six offline and online defense layers before you open it, protecting you against phishing, malicious redirects, and homograph traps.';

  @override
  String get bodyOnboardingSlide1Bullet1 => 'Protocol & Homograph Shield';

  @override
  String get bodyOnboardingSlide1Bullet2 => 'TLD Entropy & Port Trap Analysis';

  @override
  String get bodyOnboardingSlide1Bullet3 => 'Private Probing & Safe Browsing';

  @override
  String get labelOnboardingSlide2Badge => 'Computer Vision';

  @override
  String get titleOnboardingSlide2 => 'Tamper detection';

  @override
  String get bodyOnboardingSlide2 =>
      'Criminals paste fraudulent QR stickers over authentic signs. QuishingGuard inspects physical edges, shadows, and surface paper textures before you scan.';

  @override
  String get bodyOnboardingSlide2Bullet1 =>
      'Physical sticker overlay detection';

  @override
  String get bodyOnboardingSlide2Bullet2 =>
      'Cut edge & shadow boundary analysis';

  @override
  String get bodyOnboardingSlide2Bullet3 => 'Real-time camera frame inspection';

  @override
  String get labelOnboardingSlide3Badge => 'Zero tracking';

  @override
  String get titleOnboardingSlide3 => '100% offline privacy';

  @override
  String get bodyOnboardingSlide3 =>
      'Your scans and personal data never leave your phone. There are no analytics SDKs, no trackers, and no remote servers watching your habits.';

  @override
  String get bodyOnboardingSlide3Bullet1 =>
      'Encrypted on-device SQLite database';

  @override
  String get bodyOnboardingSlide3Bullet2 => 'AirQR optical air-gap transfers';

  @override
  String get bodyOnboardingSlide3Bullet3 =>
      'Zero analytics or crash reporting SDKs';

  @override
  String get labelSettingsOnboardingTour => 'Welcome Tour';

  @override
  String get descSettingsOnboardingTour =>
      'Revisit the 3-slide introduction to safety and privacy features';

  @override
  String get tooltipBatchMode => 'Batch scan mode';

  @override
  String get bodyBatchModeEnabled => 'Continuous Batch Scan enabled';

  @override
  String get bodyBatchModeDisabled => 'Continuous Batch Scan disabled';

  @override
  String labelBatchCounter(int count) {
    return '$count Scanned';
  }

  @override
  String get labelBatchReview => 'Batch Scans';

  @override
  String get descBatchReview => 'Continuous scanning queue';

  @override
  String get emptyBatchTitle => 'No codes in batch';

  @override
  String get emptyBatchBody =>
      'Point your camera at barcodes to scan them continuously without leaving the camera.';

  @override
  String get titleBatchExport => 'Export Batch';

  @override
  String get actionBatchClear => 'Clear Batch';

  @override
  String get titleBatchClearConfirm => 'Clear Batch?';

  @override
  String get bodyBatchClearConfirm =>
      'Are you sure you want to remove all scanned codes from this batch?';

  @override
  String get labelBatchPreventDuplicates => 'Prevent Duplicates';

  @override
  String bodyBatchScanned(int count, String content) {
    return 'Scanned #$count: $content';
  }

  @override
  String get bodyBatchAnalyzingUrl => 'Analyzing link...';

  @override
  String bodyBatchUrlSafetySummary(
    int safeCount,
    int warningCount,
    int totalUrls,
  ) {
    return '$safeCount safe, $warningCount suspicious of $totalUrls links';
  }

  @override
  String get titleBatchItemDetails => 'Scanned Code Details';

  @override
  String get labelCameraDistanceEnhance => 'Distance Scan Assist';

  @override
  String get descCameraDistanceEnhance =>
      'Zoom-crop & unsharp mask for distant posters & signs';

  @override
  String get labelCameraUnsharp => 'Edge Sharpness';

  @override
  String get labelCameraDistanceZoom => 'Distance Zoom';

  @override
  String get tooltipScanFromClipboard => 'Scan from Clipboard';

  @override
  String get bodyClipboardBanner => 'Clipboard content detected';

  @override
  String get actionClipboardScan => 'Scan Now';

  @override
  String get tooltipClipboardDismiss => 'Dismiss';

  @override
  String get errorClipboardNoValidContent =>
      'No scannable link, code, or image found in clipboard';

  @override
  String get labelClipboardTypeUrl => 'URL';

  @override
  String get labelClipboardTypeBarcode => 'Barcode Payload';

  @override
  String get labelClipboardTypeImage => 'Image';

  @override
  String get labelClipboardTypeText => 'Text';

  @override
  String get bodyMultiCodeDetected =>
      'Multiple codes detected. Tap a code to scan.';

  @override
  String get tooltipMultiCodeTapToScan => 'Tap to scan';

  @override
  String get labelMultiCodeSelection => 'Multi-Code Selection';

  @override
  String get descMultiCodeSelection =>
      'Outline visible codes and tap to choose when multiple are present';

  @override
  String get tooltipMultiCodeDismiss => 'Dismiss selection';

  @override
  String get labelGhostScan => 'GhostScan';

  @override
  String get descGhostScan => 'Screen Content QR Detector';

  @override
  String get bodyGhostScan =>
      'Detect and decode QR codes visible on your screen inside any app without taking manual screenshots.';

  @override
  String get actionGhostScanNow => 'Scan Screen Now';

  @override
  String get actionGhostScanAddTile => 'Add Settings tile';

  @override
  String get bodyGhostScanTileAdded => 'Quick Settings tile request sent';

  @override
  String get titleGhostScanHowItWorks => 'How to use GhostScan';

  @override
  String get helpGhostScanStep1 =>
      'Pull down your Quick Settings notification shade from any app.';

  @override
  String get helpGhostScanStep2 =>
      'Tap the GhostScan tile to capture and decode the screen.';

  @override
  String get helpGhostScanStep3 =>
      'The code is decoded instantly without saving screenshots to your gallery.';

  @override
  String get bodyGhostScanAnalyzing => 'Analyzing screen content...';

  @override
  String get helpGuideGroupScanning => 'Scanning & Ingestion Guides';

  @override
  String get helpGuideGroupSecurity => 'Security & Threat Defense';

  @override
  String get helpGuideGroupPayloads => 'Payloads, Storage & Privacy';

  @override
  String get titleHelpBarcode => 'Barcode scanning';

  @override
  String get helpGuideBarcodeName => 'Barcode & Media Scanning';

  @override
  String get helpGuideBarcodeSummary =>
      'Live camera controls, gallery photos, and multi-page PDF document scanning.';

  @override
  String get helpGuideBarcodeIntro =>
      'Scan any 1D or 2D barcode instantly using live camera, photo gallery images, or multi-page PDF documents with high-precision computer vision.';

  @override
  String get helpGuideBarcodeCameraTitle => 'Live Camera Viewport';

  @override
  String get helpGuideBarcodeCameraBullet1 =>
      'Aim your camera at any QR code, Data Matrix, Aztec, PDF417, EAN-13, UPC-A, Code 128, or Codabar symbol.';

  @override
  String get helpGuideBarcodeCameraBullet2 =>
      'Torch & Zoom: Tap the Flashlight icon in low light, or use the zoom slider to read high-density micro-QR codes from a distance.';

  @override
  String get helpGuideBarcodeCameraBullet3 =>
      'Viewfinder Overlays: Customize the visual scan frame under Settings -> Appearance to suit your preference.';

  @override
  String get helpGuideBarcodeGalleryTitle => 'Scanning Gallery Photos & Images';

  @override
  String get helpGuideBarcodeGalleryBullet1 =>
      'Tap the Gallery icon on the scanner screen to pick any saved image or screenshot from your device.';

  @override
  String get helpGuideBarcodeGalleryBullet2 =>
      'Uses privacy-safe Android Photo Picker without requiring broad storage permissions.';

  @override
  String get helpGuideBarcodeGalleryBullet3 =>
      'The scanner analyzes full-resolution image frames to detect and decode multiple barcodes in milliseconds.';

  @override
  String get helpGuideBarcodePdfTitle => 'Multi-Page PDF Scanning';

  @override
  String get helpGuideBarcodePdfBullet1 =>
      'Select a PDF document (such as an invoice, ticket, or boarding pass) directly through the file picker.';

  @override
  String get helpGuideBarcodePdfBullet2 =>
      'Extracts and renders every page in memory, cataloging all barcodes found across each individual page.';

  @override
  String get helpGuideBarcodePdfBullet3 =>
      'Review all detected codes in a dedicated bottom sheet and save them into your scan history in 1 tap.';

  @override
  String get helpGuideBarcodeTip =>
      'Tip: Barcode recognition operates 100% locally on your device without uploading your camera frames or images to the cloud.';

  @override
  String get titleHelpArCodeVision => 'AR CodeVision';

  @override
  String get helpGuideArCodeVisionName => 'AR CodeVision™ Spatial HUD';

  @override
  String get helpGuideArCodeVisionSummary =>
      'Real-time multi-barcode camera tracking, floating chips, and batch actions.';

  @override
  String get helpGuideArCodeVisionIntro =>
      'AR CodeVision™ transforms your camera viewport into an augmented reality spatial heads-up display that detects, tracks, and analyzes multiple barcodes simultaneously in real time.';

  @override
  String get helpGuideArCodeVisionTrackingTitle => 'Real-Time Spatial Tracking';

  @override
  String get helpGuideArCodeVisionTrackingBullet1 =>
      'Simultaneously identifies every barcode within the camera frame, locking a spatial 2D/3D tracking anchor onto each code.';

  @override
  String get helpGuideArCodeVisionTrackingBullet2 =>
      'Renders floating interactive chips directly above each physical barcode on screen as you move your camera.';

  @override
  String get helpGuideArCodeVisionTrackingBullet3 =>
      'Live color-coded security badges immediately indicate if a link is Verified Safe (green) or Phishing Suspicion (red).';

  @override
  String get helpGuideArCodeVisionBatchTitle =>
      'Interactive Multi-Select & Batch Actions';

  @override
  String get helpGuideArCodeVisionBatchBullet1 =>
      'Tap any floating chip to inspect its payload, trigger contextual actions, or open the detailed AR Action Sheet.';

  @override
  String get helpGuideArCodeVisionBatchBullet2 =>
      'Select multiple items across warehouse shelves, product catalogs, or event badges for batch processing.';

  @override
  String get helpGuideArCodeVisionBatchBullet3 =>
      'Copy all selected payload contents or export targets to your history in a single tap.';

  @override
  String get helpGuideArCodeVisionHudTitle => 'HUD Controls & Performance';

  @override
  String get helpGuideArCodeVisionHudBullet1 =>
      'HUD Action Strip: Quick toggles for camera flash, zoom level, front/rear camera flip, and target clearing.';

  @override
  String get helpGuideArCodeVisionHudBullet2 =>
      'Optimized hardware frame rate processing prevents thermal throttling and conserves battery during extended scanning sessions.';

  @override
  String get helpGuideArCodeVisionTip =>
      'Tip: In dense environments with dozens of barcodes, use the zoom slider to isolate specific clusters with surgical precision.';

  @override
  String get titleHelpAirQr => 'AirQR guide';

  @override
  String get helpGuideAirQrName => 'AirQR™ Optical Air-Gap Stream';

  @override
  String get helpGuideAirQrSummary =>
      'Offline animated QR strobe transmitter and receiver for radio-silent data sharing.';

  @override
  String get helpGuideAirQrIntro =>
      'AirQR™ establishes a bidirectional, completely offline optical data pipeline between devices using high-speed animated QR strobe frames without needing Wi-Fi, Bluetooth, cellular data, or physical cables.';

  @override
  String get helpGuideAirQrStreamingTitle => 'How Optical Streaming Works';

  @override
  String get helpGuideAirQrStreamingBullet1 =>
      'Large files, cryptographic keys, or long documents are divided into small data frames, plus extra fountain-code repair frames that let the receiver rebuild frames it missed.';

  @override
  String get helpGuideAirQrStreamingBullet2 =>
      'The transmitting device flashes the animated QR code stream at a customizable frame rate (5 to 25 FPS).';

  @override
  String get helpGuideAirQrStreamingBullet3 =>
      'The receiving device continuously captures the strobe sequence, reconstructing missing frames on the fly until the full payload is reassembled.';

  @override
  String get helpGuideAirQrSecurityTitle => 'Air-Gap Security & Privacy';

  @override
  String get helpGuideAirQrSecurityBullet1 =>
      'Complete Radio Silence: Zero electromagnetic radio emissions (no RF broadcasts, pairing requests, or network logs).';

  @override
  String get helpGuideAirQrSecurityBullet2 =>
      'Immune to remote network interception, man-in-the-middle attacks, and Bluetooth sniffing vulnerabilities.';

  @override
  String get helpGuideAirQrSecurityBullet3 =>
      'Perfect for air-gapped cryptocurrency cold wallets, confidential credentials, and secure offline data sharing.';

  @override
  String get helpGuideAirQrControlsTitle => 'Transmitter & Receiver Controls';

  @override
  String get helpGuideAirQrControlsBullet1 =>
      'Transmitter Screen: Choose the frame rate (FPS) and see the total number of frames in the stream.';

  @override
  String get helpGuideAirQrControlsBullet2 =>
      'Receiver Screen: Real-time progress bar, captured frame counter, missing frame indices, and checksum verification.';

  @override
  String get helpGuideAirQrTip =>
      'Tip: When receiving an AirQR stream, hold your phone steady and ensure the transmitter screen brightness is set to high for maximum frame capture speed.';

  @override
  String get titleHelpUrlSafety => 'URL safety';

  @override
  String get helpGuideUrlSafetyName => '6-Layer URL Safety Engine';

  @override
  String get helpGuideUrlSafetySummary =>
      'Homograph attacks, punycode defense, suspicious TLDs, and heuristic port traps.';

  @override
  String get helpGuideUrlSafetyIntro =>
      'Before you open any scanned web link, our comprehensive 6-layer forensic safety engine evaluates the URL against modern phishing heuristics, homograph spoofing attacks, and malicious redirect traps.';

  @override
  String get helpGuideUrlSafetyLayersTitle => 'The 6 Safety Layers Explained';

  @override
  String get helpGuideUrlSafetyLayersBullet1 =>
      'Layer 1: Protocol & Scheme Guard - Enforces HTTPS encryption and verifies standard protocol formatting while intercepting malformed or zero-width character traps.';

  @override
  String get helpGuideUrlSafetyLayersBullet2 =>
      'Layer 2: Homograph & Unicode Attack Shield - Identifies Cyrillic, Greek, and mixed-script lookalike characters (such as \"а\" instead of \"a\") used by scammers to imitate trusted websites.';

  @override
  String get helpGuideUrlSafetyLayersBullet3 =>
      'Layer 3: Suspicious TLD & Entropy Analysis - Flags high-risk domain endings (.xyz, .top, .work), excessive subdomain nesting, and randomized machine-generated domain names.';

  @override
  String get helpGuideUrlSafetyLayersBullet4 =>
      'Layer 4: Heuristic IP & Non-Standard Port Trap - Detects links connecting directly to numeric IP addresses or weird port numbers often used by botnet malware servers.';

  @override
  String get helpGuideUrlSafetyLayersBullet5 =>
      'Layer 5: Privacy-Safe Online Head Probing - Optionally follows shortened URL redirects (bit.ly, tinyurl) and inspects SSL certificate trust chains without executing malicious JavaScript.';

  @override
  String get helpGuideUrlSafetyLayersBullet6 =>
      'Layer 6: Google Safe Browsing API Integration - Optional cloud-based real-time threat intelligence protecting against phishing sites and malware distribution networks.';

  @override
  String get helpGuideUrlSafetyVerdictsTitle =>
      'Safety Verdicts & Action Guidance';

  @override
  String get helpGuideUrlSafetyVerdictsBullet1 =>
      'Verified Safe (Green): The URL passed all structural and threat checks without triggering any suspicious signals.';

  @override
  String get helpGuideUrlSafetyVerdictsBullet2 =>
      'Caution / Warning (Orange/Red): High risk factors detected. The app displays the full unshortened destination and highlights exactly which rules triggered the alert.';

  @override
  String get helpGuideUrlSafetyTip =>
      'Tip: Layers 1 through 4 operate 100% offline using on-device heuristics, protecting your privacy wherever you are.';

  @override
  String get titleHelpQuishing => 'QuishingGuard';

  @override
  String get helpGuideQuishingName => 'QuishingGuard™ Tamper Detection';

  @override
  String get helpGuideQuishingSummary =>
      'On-device computer vision analyzing physical QR sticker overlays and edge cuts.';

  @override
  String get helpGuideQuishingIntro =>
      'Quishing (QR Phishing) occurs when criminals paste physical fraudulent sticker QR codes over legitimate QR codes on parking meters, restaurant menus, payment counters, or transit signs.';

  @override
  String get helpGuideQuishingCvTitle => 'On-Device Computer Vision Analysis';

  @override
  String get helpGuideQuishingCvBullet1 =>
      'Edge Discontinuity Metric: Detects double edges, cutting misalignment, and micro-shadows along the boundary of pasted overlay stickers.';

  @override
  String get helpGuideQuishingCvBullet2 =>
      'Print Grain & Halftone Metric: Identifies inconsistencies in dot pitch, chromatic noise, and print resolution between the code and surrounding background poster.';

  @override
  String get helpGuideQuishingCvBullet3 =>
      'Calculates a combined Tamper Risk Score from 0% (Authentic) to 100% (High Tamper Risk).';

  @override
  String get helpGuideQuishingForensicTitle => 'Forensic Signal Inspection';

  @override
  String get helpGuideQuishingForensicBullet1 =>
      'Tap \"View Forensic Analysis\" on any scanned code to view real-time CV confidence levels, border edge metrics, and chromatic noise charts.';

  @override
  String get helpGuideQuishingForensicBullet2 =>
      'Helps identify suspicious payment QR codes in public places before sending money or typing credentials.';

  @override
  String get helpGuideQuishingTip =>
      'Tip: When scanning outdoor QR codes on parking meters or public kiosks, inspect the code physically with your fingers if QuishingGuard flags an edge discontinuity alert.';

  @override
  String get titleHelpSafeBrowsing => 'Safe Browsing';

  @override
  String get helpGuideSafeBrowsingName => 'Google Safe Browsing Setup';

  @override
  String get helpGuideSafeBrowsingSummary =>
      'Acquiring a Google Cloud API key, hardware keystore storage, and lookup quotas.';

  @override
  String get helpGuideSafeBrowsingIntro =>
      'Google Safe Browsing enables Layer 6 cloud threat intelligence to check scanned URLs against billions of constantly updated known malware, social engineering, and phishing threat entries.';

  @override
  String get helpGuideSafeBrowsingKeyTitle => 'How to Obtain a Free API Key';

  @override
  String get helpGuideSafeBrowsingKeyStep1 =>
      '1. Open the Google Cloud Console (console.cloud.google.com) on your computer or mobile browser.';

  @override
  String get helpGuideSafeBrowsingKeyStep2 =>
      '2. Create a new Google Cloud Project (e.g., \"My QR Reader Security\").';

  @override
  String get helpGuideSafeBrowsingKeyStep3 =>
      '3. Navigate to APIs & Services -> Library and search for \"Web Risk API\" or \"Safe Browsing API\" and click Enable.';

  @override
  String get helpGuideSafeBrowsingKeyStep4 =>
      '4. Go to APIs & Services -> Credentials and click \"+ CREATE CREDENTIALS\" -> \"API key\".';

  @override
  String get helpGuideSafeBrowsingKeyStep5 =>
      '5. Copy your new API key and paste it into the Google Safe Browsing field under Settings.';

  @override
  String get helpGuideSafeBrowsingPrivacyTitle =>
      'Privacy & Secure Keystore Storage';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet1 =>
      'Your API key is encrypted using Android Keystore hardware-backed secure storage (FlutterSecureStorage) and never exported or shared.';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet2 =>
      'Google Safe Browsing is 100% optional. If no key is provided, the app continues to perform comprehensive offline checks.';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet3 =>
      'Free Tier Quota: Google provides up to 10,000 free requests per day, and the app resets its local usage counter every 24 hours.';

  @override
  String get helpGuideSafeBrowsingTip =>
      'Tip: Safe Browsing checks only execute after offline heuristics pass, conserving your daily lookup quota.';

  @override
  String get titleHelpSmartPayloads => 'Smart actions';

  @override
  String get helpGuideSmartPayloadsName => 'Smart Actions & Payments';

  @override
  String get helpGuideSmartPayloadsSummary =>
      'Wi-Fi connect, UPI & crypto payments, live TOTP 2FA tokens, vCards, and events.';

  @override
  String get helpGuideSmartPayloadsIntro =>
      'SreerajP QR Studio automatically identifies the semantic type of every barcode, presenting contextual, 1-tap actionable cards for Wi-Fi networks, UPI and crypto payments, 2FA tokens, contacts, and calendar events.';

  @override
  String get helpGuideSmartPayloadsWifiTitle => 'Wi-Fi Network Auto-Connect';

  @override
  String get helpGuideSmartPayloadsWifiBullet1 =>
      'Scans WIFI: formatted barcodes containing SSID, encryption type (WPA, WPA2, WPA3, WEP, None), and network passwords.';

  @override
  String get helpGuideSmartPayloadsWifiBullet2 =>
      'Includes a Password Reveal / Hide button and 1-tap clipboard copy.';

  @override
  String get helpGuideSmartPayloadsWifiBullet3 =>
      'Tap \"Connect to Wi-Fi\" to trigger direct connection or jump straight to system Wi-Fi settings.';

  @override
  String get helpGuideSmartPayloadsPaymentsTitle =>
      'UPI & Cryptocurrency Payments';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet1 =>
      'Indian UPI QR Codes: Parses Virtual Payment Addresses (VPA), merchant names, transaction references, and exact amount values.';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet2 =>
      '1-Tap Dispatch: Launches your installed payment apps (Google Pay, PhonePe, Paytm, or BHIM) with pre-filled transaction parameters.';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet3 =>
      'Crypto QR Codes: Recognizes Bitcoin, Ethereum, and Solana wallet schemes with 1-tap copy and address formatting.';

  @override
  String get helpGuideSmartPayloadsTotpTitle =>
      'TOTP 2FA Authenticator & Tokens';

  @override
  String get helpGuideSmartPayloadsTotpBullet1 =>
      'Scans otpauth:// standard two-factor authentication setup codes used by Google Authenticator and Microsoft Authenticator.';

  @override
  String get helpGuideSmartPayloadsTotpBullet2 =>
      'Displays a live, rolling 6-digit one-time passcode with an animated 30-second circular countdown timer on device.';

  @override
  String get helpGuideSmartPayloadsTotpBullet3 =>
      'Tap \"Import into Authenticator App\" to register the key in your preferred 2FA app.';

  @override
  String get helpGuideSmartPayloadsContactsTitle =>
      'Contacts & Calendar Events';

  @override
  String get helpGuideSmartPayloadsContactsBullet1 =>
      'vCard & MeCard: Parses full name, telephone numbers, email addresses, organization, and job title with 1-tap address book import.';

  @override
  String get helpGuideSmartPayloadsContactsBullet2 =>
      'iCalendar (VEVENT): Parses event title, start and end date/time, location, and description, offering 1-tap Google/device calendar scheduling.';

  @override
  String get helpGuideSmartPayloadsTip =>
      'Tip: When paying with UPI QR codes, always verify the merchant name shown on the card matches the physical store counter.';

  @override
  String get titleHelpHistory => 'History & privacy';

  @override
  String get helpGuideHistoryName => 'History, Backups & Privacy';

  @override
  String get helpGuideHistorySummary =>
      'Offline SQLite database, JSON/CSV backups, biometrics, and screenshot guard.';

  @override
  String get helpGuideHistoryIntro =>
      'Your scan records belong solely to you. SreerajP QR Studio stores all history entries in a local SQLite database on your device with biometric authentication safeguards and structured export formats.';

  @override
  String get helpGuideHistoryManageTitle => 'Scan History Management';

  @override
  String get helpGuideHistoryManageBullet1 =>
      'Search & Filter: Search scan history in real time by text query or filter by payload type (URLs, Wi-Fi, Contacts, Payments, TOTP).';

  @override
  String get helpGuideHistoryManageBullet2 =>
      'Star Favorites: Mark important Wi-Fi credentials or loyalty codes as favorites for quick access.';

  @override
  String get helpGuideHistoryManageBullet3 =>
      'Detailed Inspect Sheet: Review the exact raw decoded bytes, safety score breakdown, timestamp, and add custom notes.';

  @override
  String get helpGuideHistoryBackupTitle => 'Backup & Restore (JSON / CSV)';

  @override
  String get helpGuideHistoryBackupBullet1 =>
      'JSON Full Backup: Exports your complete history including custom tags, favorites, and safety results into a portable .json file.';

  @override
  String get helpGuideHistoryBackupBullet2 =>
      'CSV Spreadsheet: Generates a clean comma-separated values file compatible with Microsoft Excel and Google Sheets.';

  @override
  String get helpGuideHistoryBackupBullet3 =>
      'One-Click Restore: Import previously exported JSON backup files at any time to restore your scan log.';

  @override
  String get helpGuideHistoryBiometricsTitle => 'Biometrics & Screenshot Guard';

  @override
  String get helpGuideHistoryBiometricsBullet1 =>
      'App lock and biometrics: an optional app lock asks for your fingerprint, face or screen lock when the app opens. Hidden StegoQR messages can also ask for biometrics.';

  @override
  String get helpGuideHistoryBiometricsBullet2 =>
      'Screenshot guard: screens that show scans, history, secrets or API keys cannot be captured by screenshots or screen recording (FLAG_SECURE). You can turn this off in Settings › Privacy & probing.';

  @override
  String get helpGuideHistoryTip =>
      'Tip: Back up your history to a JSON file before switching or resetting your phone to preserve your saved scans.';

  @override
  String get titleHelpFaq => 'FAQ & help';

  @override
  String get helpGuideFaqName => 'FAQ & Troubleshooting';

  @override
  String get helpGuideFaqSummary =>
      'Common questions, camera focus tips, permission recovery, and offline guarantees.';

  @override
  String get helpGuideFaqIntro =>
      'Answers to common questions, camera troubleshooting advice, and privacy clarifications for SreerajP QR Studio.';

  @override
  String get helpGuideFaqQuestionsTitle => 'Frequently Asked Questions';

  @override
  String get helpGuideFaqQuestion1 =>
      'Q: Does the app work without internet?\nYes! 100% of barcode decoding, QuishingGuard CV checks, and URL safety heuristics (Layers 1-4) work completely offline.';

  @override
  String get helpGuideFaqQuestion2 =>
      'Q: Is my camera feed sent to any server?\nNo. Camera frames are processed strictly on-device in volatile memory and are never recorded, saved, or uploaded.';

  @override
  String get helpGuideFaqQuestion3 =>
      'Q: Why is Google Safe Browsing optional?\nWe believe in privacy-by-default. Offline safety layers protect you immediately, while Google Safe Browsing is an optional opt-in for users with a Google Cloud API key.';

  @override
  String get helpGuideFaqCameraTitle => 'Camera Troubleshooting';

  @override
  String get helpGuideFaqCameraBullet1 =>
      'Camera Fails to Focus: Ensure the lens is clean and hold the device 15-20 cm away. In low light, tap the Flashlight icon.';

  @override
  String get helpGuideFaqCameraBullet2 =>
      'Tiny or Dense QR Code: Use the zoom slider to magnify the QR code rather than bringing the phone too close.';

  @override
  String get helpGuideFaqCameraBullet3 =>
      'Permission Denied: If camera permission was revoked, go to Android Settings -> Apps -> SreerajP QR Studio -> Permissions -> Camera -> Allow.';

  @override
  String get helpGuideFaqTip =>
      'Tip: If you encounter an unusual barcode format, take a photo and use the Gallery scan tool to process it in full resolution.';

  @override
  String get tooltipResultMoreActions => 'More actions';

  @override
  String get bodyVerdictChecking => 'Checking link safety…';

  @override
  String get bodyVerdictNoIssues => 'No issues found';

  @override
  String bodyVerdictIssuesFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count issues found',
      one: '1 issue found',
    );
    return '$_temp0';
  }

  @override
  String bodyVerdictChecksPassed(int passed, int total) {
    return '$passed of $total checks passed';
  }

  @override
  String get actionVerdictSeeDetails => 'See details';

  @override
  String get labelVerdictModePrivate => 'Private mode';

  @override
  String get labelVerdictModeActive => 'Active probing';

  @override
  String actionSafetyShowPassed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Show $count passed',
      one: 'Show 1 passed',
    );
    return '$_temp0';
  }

  @override
  String get actionSafetyHidePassed => 'Hide passed checks';

  @override
  String actionSafetySkippedGroup(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skipped',
      one: '1 check skipped',
    );
    return '$_temp0';
  }

  @override
  String get actionSafetySkippedSetup => 'Set up in Settings';

  @override
  String bodyOpenRiskDialogIssues(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'This link has $count issues. Open it anyway?',
      one: 'This link has 1 issue. Open it anyway?',
    );
    return '$_temp0';
  }

  @override
  String get tooltipSandboxShowPreview => 'Show preview';

  @override
  String get tooltipSandboxHidePreview => 'Hide preview';

  @override
  String labelQuishingCompactGenuine(String percent) {
    return 'Genuine · $percent%';
  }

  @override
  String get labelScanBubble => 'Scan bubble';

  @override
  String get descScanBubbleSettings => 'Scan codes shown in other apps';

  @override
  String get labelScanBubbleSwitch => 'Show scan bubble';

  @override
  String get descScanBubbleSwitch =>
      'A small button that floats over other apps. Tap it to scan a code on the screen.';

  @override
  String get descScanBubblePermissionGranted => 'Allowed';

  @override
  String get descScanBubblePermissionMissing =>
      'Not allowed yet. Needed for the bubble.';

  @override
  String get actionScanBubbleAllow => 'Allow';

  @override
  String get labelScanBubbleStartOnBoot => 'Start after restart';

  @override
  String get descScanBubbleStartOnBoot =>
      'If the bubble was on, show it again after the phone restarts. Some phones may block this.';

  @override
  String get actionScanBubbleAddTile => 'Add Settings tile';

  @override
  String get bodyScanBubbleTileAdded => 'Quick Settings tile request sent';

  @override
  String get bodyScanBubbleTileManual =>
      'Pull down Quick Settings, tap the edit (pencil) button, and drag the Scan bubble tile in.';

  @override
  String get titleScanBubblePermissionDialog => 'Allow the bubble';

  @override
  String get bodyScanBubblePermissionDialog =>
      'To float over other apps, the bubble needs the \"Display over other apps\" permission. On the next page, turn it on for this app, then come back.';

  @override
  String get actionScanBubbleOpenSettings => 'Open settings';

  @override
  String get errorScanBubbleStartFailed =>
      'Could not start the bubble. Please try again.';

  @override
  String get errorScanBubbleBlockedCapture =>
      'This app blocks screen capture, so its codes cannot be read.';

  @override
  String get labelHistorySourceScreen => 'From screen';

  @override
  String get helpPermissionOverlayTitle => 'Display over other apps';

  @override
  String get helpPermissionOverlayDesc =>
      'Used only by the Scan bubble, and only after you turn it on. Lets the bubble float over other apps.';

  @override
  String get helpPermissionNotificationTitle => 'Notifications';

  @override
  String get helpPermissionNotificationDesc =>
      'Shows \"Scan bubble is on\" with a Turn off button while the bubble is on.';

  @override
  String get helpGuideScanBubbleName => 'Scan bubble';

  @override
  String get helpGuideScanBubbleSummary =>
      'A floating button to scan QR codes and barcodes shown in other apps.';

  @override
  String get helpGuideScanBubbleIntro =>
      'The Scan bubble is a small round button that floats over other apps. When a QR code or barcode is on your screen, tap the bubble and the app reads it, offline, on your phone.';

  @override
  String get helpGuideScanBubbleUseTitle => 'How to use it';

  @override
  String get helpGuideScanBubbleUseBullet1 =>
      'Turn it on in Settings > Scan bubble, from the Scan bubble tile in Quick Settings, or by long-pressing the app icon.';

  @override
  String get helpGuideScanBubbleUseBullet2 =>
      'Open any app that shows a QR code or barcode, then tap the bubble.';

  @override
  String get helpGuideScanBubbleUseBullet3 =>
      'Android asks to allow screen capture. Allow it, and the result opens with the usual safety checks.';

  @override
  String get helpGuideScanBubbleUseBullet4 =>
      'Drag the bubble to move it. Drag it onto the X at the bottom of the screen to turn it off.';

  @override
  String get helpGuideScanBubblePrivacyTitle => 'Privacy';

  @override
  String get helpGuideScanBubblePrivacyBullet1 =>
      'The screen is captured only when you tap the bubble, and Android always asks you first.';

  @override
  String get helpGuideScanBubblePrivacyBullet2 =>
      'The code is read on your phone. Nothing is sent online for reading.';

  @override
  String get helpGuideScanBubblePrivacyBullet3 =>
      'The screen picture is not saved to your gallery and is deleted right after reading.';

  @override
  String get helpGuideScanBubbleLimitsTitle => 'Good to know';

  @override
  String get helpGuideScanBubbleLimitsBullet1 =>
      'On Android 14 and newer, Android asks for screen capture permission on every tap.';

  @override
  String get helpGuideScanBubbleLimitsBullet2 =>
      'Banking, payment and some video apps block screen capture. Codes inside them cannot be read.';

  @override
  String get helpGuideScanBubbleLimitsBullet3 =>
      'Some phones have extra \"pop-up window\" or battery settings that can hide or stop the bubble.';

  @override
  String get helpGuideScanBubbleTip =>
      'Tip: Add the Scan bubble tile to Quick Settings. Then one tap turns the bubble on or off from any app.';

  @override
  String get labelCodeForgeBarcodeContent => 'Barcode content';

  @override
  String get helpCodeForgeBarcodeContent => 'Enter the barcode number or code';

  @override
  String get labelCodeForgeWifiSecurityNone => 'None (open)';

  @override
  String get helpCodeForgeUpiVpa => 'e.g. merchant@upi';

  @override
  String get labelOptionalField => 'Optional';

  @override
  String get errorCodeForgeContentEmpty => 'Content cannot be empty';

  @override
  String errorCodeForgeTextTooLong(String max) {
    return 'Text must not be longer than $max characters';
  }

  @override
  String get errorCodeForgeWifiSsidRequired =>
      'Wi-Fi network name (SSID) is required';

  @override
  String get errorCodeForgeUpiVpaRequired => 'UPI ID is required';

  @override
  String errorCodeForgeBarcodeInvalid(String detail) {
    return 'Not valid for this barcode type ($detail)';
  }

  @override
  String get titleAirQrUnlocked => 'AirQR unlocked';

  @override
  String get titleJsonEnvelopeUnlocked => 'JSON unlocked';

  @override
  String get titleStegoUnlocked => 'StegoQR unlocked';

  @override
  String get titleStegoDetected => 'StegoQR found';

  @override
  String get actionDecryptShowAdvanced => 'Advanced (Salt / IV)';

  @override
  String get actionDecryptHideAdvanced => 'Hide advanced';

  @override
  String get labelDecryptSalt => 'Salt (Base64)';

  @override
  String get labelDecryptIv => 'IV / Nonce (Base64)';

  @override
  String bodyHistoryRecordCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count scan records found',
      one: '1 scan record found',
    );
    return '$_temp0';
  }

  @override
  String bodyArItemsSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items selected',
      one: '1 item selected',
    );
    return '$_temp0';
  }

  @override
  String descSettingsAppearanceSummary(String themeMode) {
    return '$themeMode • Dynamic colors';
  }

  @override
  String get bodyOpenPhishFeedNotDownloaded => 'Feed not downloaded yet';

  @override
  String get helpAccentDynamicColor =>
      'Dynamic Color builds a matching palette from your Android wallpaper (Android 12+). When it is off, the standard high-contrast security palette is used.';

  @override
  String get bodyTypographySample =>
      '6-Layer URL Safety Check • 100% Offline QuishingGuard™ CV Engine';

  @override
  String get labelTypographyScale => 'Text size';

  @override
  String get helpTypographyScale =>
      'The app follows your Android accessibility text size, while keeping the scan frame and on-screen labels easy to read.';

  @override
  String bodyDomFetchFailed(String host) {
    return '$host (offline or network blocked)';
  }

  @override
  String get tooltipScanPause => 'Pause scanning';

  @override
  String get tooltipScanResume => 'Resume scanning';

  @override
  String get labelArModeWarehouse => 'Warehouse';

  @override
  String get labelArModeSafety => 'Safety';

  @override
  String get tooltipArModeWarehouse => 'Item info & select';

  @override
  String get tooltipArModeSafety => 'Link safety badges';

  @override
  String get errorCameraStartFailed => 'Camera could not start';

  @override
  String get errorCameraNotFound => 'No camera found on this phone';

  @override
  String get actionCameraRetry => 'Try again';

  @override
  String get bodyCodeForgeSafetyPrompt => 'Check this link before you share it';

  @override
  String get actionCodeForgeSafetyCheck => 'Check';

  @override
  String bodyCodeForgeSafetyProblems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count problems found in this link',
      one: '1 problem found in this link',
    );
    return '$_temp0';
  }

  @override
  String get actionCodeForgeSafetyCheckAgain => 'Check again';

  @override
  String get labelDeleteAllData => 'Delete all data';

  @override
  String get descDeleteAllData =>
      'Remove scan history, saved API keys and all settings from this phone.';

  @override
  String get titleDeleteAllDataConfirm => 'Delete all data?';

  @override
  String get bodyDeleteAllDataConfirm =>
      'This deletes your scan history, saved API keys, all settings, Scan bubble settings and temporary files. This cannot be undone.';

  @override
  String get actionDeleteAll => 'Delete all';

  @override
  String get bodyDeletingAllData => 'Deleting all data…';

  @override
  String get errorDeleteAllDataPartial => 'Some data could not be deleted.';

  @override
  String get errorHistoryLoadFailed => 'History could not be loaded.';

  @override
  String get actionTryAgain => 'Try again';

  @override
  String get aboutDetailPrivacyPolicy => 'Privacy policy';

  @override
  String get bodyEncryptingBackup => 'Protecting your backup…';

  @override
  String get bodyOpeningBackup => 'Opening the backup…';

  @override
  String get bodyEncryptingSync => 'Protecting the sync package…';

  @override
  String get titlePlainExport => 'Export unencrypted?';

  @override
  String get bodyPlainExport =>
      'This file is not encrypted. Anyone who gets it can read your scans.';

  @override
  String get bodyPlainExportBackupHint =>
      'To keep it private, use the encrypted backup instead.';

  @override
  String get actionExportAnyway => 'Export anyway';

  @override
  String get labelAppLock => 'App lock';

  @override
  String get descAppLock =>
      'Ask for fingerprint, face or screen lock when the app opens, and after 30 seconds away.';

  @override
  String get labelScreenshotGuard => 'Screenshot guard';

  @override
  String get descScreenshotGuard =>
      'Block screenshots and screen recording on screens that show scans, history, secrets or API keys. These screens also stay blank in recent apps.';

  @override
  String get titleAppLocked => 'App locked';

  @override
  String get bodyAppLocked =>
      'Unlock with your fingerprint, face or screen lock to continue.';

  @override
  String get actionUnlock => 'Unlock';

  @override
  String get bodyAppLockReason => 'Unlock SreerajP QR Studio';

  @override
  String get errorAppLockUnavailable =>
      'Set up a screen lock or fingerprint on this phone first.';

  @override
  String get errorAppLockFailed => 'Could not confirm it is you. Try again.';
}
