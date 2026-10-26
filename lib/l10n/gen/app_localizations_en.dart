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
  String get titleQuishingGuard => 'QuishingGuard™';

  @override
  String get titleStickerCheck => 'Fake sticker check';

  @override
  String get tooltipStickerCheckExpand => 'Show checks';

  @override
  String get tooltipStickerCheckCollapse => 'Hide checks';

  @override
  String get bodyStickerCheckIntro =>
      'Scammers stick their own QR code over the real one. This app cannot spot a sticker in the camera picture, so please check it yourself:';

  @override
  String get bodyStickerCheckEdges =>
      'Look at the code and feel it with your finger. A sticker on top often has raised edges or sits crooked.';

  @override
  String get bodyStickerCheckPayee =>
      'Before you pay, check that the name on the payment screen matches the shop.';

  @override
  String get bodyStickerCheckAsk =>
      'If in doubt, ask the staff, or type the website address yourself.';

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
  String get descSettingsPermissions => 'What the app uses, and why';

  @override
  String get labelSettingsHelp => 'Help & guides';

  @override
  String get descSettingsHelp => 'Simple guides for every feature';

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
  String get helpPermissionsIntro =>
      'Permissions let an app use parts of your phone, such as the camera. This app asks only for what a feature needs, and only when you use that feature. You can see or change them at any time in Android Settings > Apps > this app > Permissions.';

  @override
  String get labelPermGroupAsked => 'Asked when needed';

  @override
  String get helpPermGroupAskedNote =>
      'Android asks you before the app can use these. If you say no, the rest of the app still works.';

  @override
  String get labelPermGroupInstall => 'Allowed at install';

  @override
  String get helpPermGroupInstallNote =>
      'Android allows these when the app is installed, without asking. Each one is used only for the feature named here.';

  @override
  String get labelPermGroupNotUsed => 'Not asked for';

  @override
  String get helpPermGroupNotUsedNote =>
      'The app does not ask for these, so it cannot use them.';

  @override
  String get labelPermCamera => 'Camera';

  @override
  String get helpPermCameraDesc =>
      'Used to scan QR codes and barcodes, and for AR CodeVision and receiving AirQR transfers. Android asks you the first time you open a camera screen. Camera pictures are read on your phone and are never saved or sent. If you say no, you can still scan from pictures and PDFs.';

  @override
  String get labelPermLocation => 'Location';

  @override
  String get helpPermLocationDesc =>
      'Used only when you tap Use My Location in CodeForge, to put your current place into a map QR code. The app reads your position once, does not keep it and never sends it anywhere. It is never used in the background. If you say no, you can type the place yourself.';

  @override
  String get labelPermBiometric => 'Fingerprint or face';

  @override
  String get helpPermBiometricDesc =>
      'Used by App lock, and to open locked StegoQR items with your fingerprint, face or screen lock. Android does the check and only tells the app whether it passed. The app never sees your fingerprint or face.';

  @override
  String get labelPermNotifications => 'Notifications';

  @override
  String get helpPermNotificationsDesc =>
      'Used only while the Scan bubble is on, to show that it is on, with a Turn off button. Android asks the first time you turn the bubble on. If you say no, the bubble still works, just without the notice.';

  @override
  String get labelPermOverlay => 'Show over other apps';

  @override
  String get helpPermOverlayDesc =>
      'Lets the Scan bubble float over other apps, so you can scan a code you see on screen. Used only after you turn the bubble on. The app explains this first, then opens the Android page where you allow it. If you do not allow it, the bubble stays off.';

  @override
  String get labelPermScreenCapture => 'Screen capture';

  @override
  String get helpPermScreenCaptureDesc =>
      'Used by GhostScan and the Scan bubble to read a code shown on your screen. Android asks you every time. The app takes one picture of the screen, reads the code on your phone, then throws the picture away. It never records video and never sends the picture anywhere.';

  @override
  String get labelPermInternet => 'Internet';

  @override
  String get helpPermInternetDesc =>
      'Scanning works fully offline. The internet is used only by the two optional link checks below. Both are off until you turn them on. While they are off, nothing you scan leaves your phone. Opening a link is done by your browser, not by this app.';

  @override
  String get labelPermProbing => 'Online link check';

  @override
  String get helpPermProbingDesc =>
      'Off unless you turn on Active Online Probing in Settings > Privacy & probing. When on, the app visits the scanned link before you open it, to follow its redirects, check its security certificate and see how old the website is.';

  @override
  String get labelPermLinkServices => 'Link safety services';

  @override
  String get helpPermLinkServicesDesc =>
      'Off unless you turn them on in Settings > URL Safety Providers. When on, the scanned link is sent to the services you chose (such as Google Safe Browsing or VirusTotal) to check it against their lists of harmful sites. Some need your own API key, which is kept in the phone\'s secure storage.';

  @override
  String get labelPermWifi => 'Wi-Fi connect';

  @override
  String get helpPermWifiDesc =>
      'Used only when you tap Connect to Wi-Fi on a scanned Wi-Fi QR code, to add that network to your phone. On newer Android versions, Android asks you to confirm first. The app does not read your saved Wi-Fi passwords.';

  @override
  String get labelPermBackground => 'Keep running';

  @override
  String get helpPermBackgroundDesc =>
      'Lets GhostScan and the Scan bubble keep working while you are in another app. Android always shows a notification while this is running, so you know about it.';

  @override
  String get labelPermBoot => 'Start after restart';

  @override
  String get helpPermBootDesc =>
      'Brings the Scan bubble back after your phone restarts, but only if the bubble was on and you turned on Start after restart. Otherwise it does nothing.';

  @override
  String get labelPermStorage => 'Photos and files';

  @override
  String get helpPermStorageDesc =>
      'The app has no storage permission. When you scan from a picture or a PDF, Android\'s own picker opens, and the app gets only the file you choose.';

  @override
  String get labelPermMicrophone => 'Microphone';

  @override
  String get helpPermMicrophoneDesc =>
      'The app does not use the microphone. The camera always opens with sound turned off.';

  @override
  String get labelPermVibration => 'Vibration';

  @override
  String get helpPermVibrationDesc =>
      'Scan vibrations use Android\'s built-in touch feedback, which needs no permission.';

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
      'SSL, redirect and shortener checks use local rules only, so the scanned site is never contacted. A link is sent to a safety service, such as Google Safe Browsing, only if you turned that service on in Settings.';

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
      'Reminds you to check printed QR codes for fake stickers before you open a link or pay. It gives you quick checks to do by hand; it does not examine the picture.';

  @override
  String get labelFeatureQuishingGuardChip1 => 'Fake stickers';

  @override
  String get labelFeatureQuishingGuardChip2 => 'Hand checks';

  @override
  String get labelFeatureQuishingGuardChip3 => 'Payment tips';

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
  String get helpCenterHeaderTitle => 'How to use this app';

  @override
  String get helpCenterHeaderSubtitle =>
      'Simple guides for every part of the app. Pick a topic to see what it does and how to use it.';

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
  String get tooltipSwitchCamera => 'Switch camera';

  @override
  String get tooltipBack => 'Back';

  @override
  String get tooltipToggleSecretVisibility => 'Show or hide secret';

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
  String get labelOnboardingSlide2Badge => 'Scam stickers';

  @override
  String get titleOnboardingSlide2 => 'Fake sticker check';

  @override
  String get bodyOnboardingSlide2 =>
      'Scammers paste fake QR stickers over real ones. When you scan a link or a payment code with the camera, QuishingGuard reminds you what to check before you open it or pay.';

  @override
  String get bodyOnboardingSlide2Bullet1 => 'Feel for raised sticker edges';

  @override
  String get bodyOnboardingSlide2Bullet2 => 'Check the payee name';

  @override
  String get bodyOnboardingSlide2Bullet3 => 'Ask the staff when in doubt';

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
  String get helpGuideGroupScanning => 'Scanning';

  @override
  String get helpGuideGroupCreate => 'Making and sending codes';

  @override
  String get helpGuideGroupSecurity => 'Staying safe';

  @override
  String get helpGuideGroupPayloads => 'Using what you scan';

  @override
  String get helpGuideGroupApp => 'Your app and settings';

  @override
  String get helpGuideBarcodeName => 'Scanning codes';

  @override
  String get helpGuideBarcodeSummary =>
      'Scan with the camera, or from photos, PDF files and copied text. Scan many codes in a row.';

  @override
  String get helpGuideBarcodeIntro =>
      'Point your camera at a code and the app reads it at once. You can also read codes from photos, PDF files and copied text. All reading happens on your phone, with no internet needed.';

  @override
  String get helpGuideBarcodeCameraTitle => 'Scan with the camera';

  @override
  String get helpGuideBarcodeCameraBullet1 =>
      'Open the Scan tab and hold the code inside the frame. The app reads it by itself. You do not need to tap anything.';

  @override
  String get helpGuideBarcodeCameraBullet2 =>
      'It reads QR codes (also the small Micro QR and rMQR kinds), Data Matrix, Aztec, PDF417 and MaxiCode. It also reads shop and parcel barcodes such as EAN, UPC, Code 128, Code 39, Code 93, Codabar, ITF and DataBar.';

  @override
  String get helpGuideBarcodeCameraBullet3 =>
      'Flash: tap the flash button to switch between Off, On and Auto. In Auto, the flash comes on by itself when it is dark.';

  @override
  String get helpGuideBarcodeCameraBullet4 =>
      'Zoom: use the zoom slider for small or far-away codes. This works better than moving the phone very close.';

  @override
  String get helpGuideBarcodeCameraBullet5 =>
      'Switch camera: change between the back and the front camera.';

  @override
  String get helpGuideBarcodeCameraBullet6 =>
      'Pause: tap Pause scanning to stop for a moment, and Resume scanning to start again.';

  @override
  String get helpGuideBarcodeGalleryTitle => 'Scan a photo or screenshot';

  @override
  String get helpGuideBarcodeGalleryBullet1 =>
      'Tap the gallery button at the top of the Scan screen and pick a photo or screenshot.';

  @override
  String get helpGuideBarcodeGalleryBullet2 =>
      'Android\'s own picker opens. The app sees only the one picture you choose.';

  @override
  String get helpGuideBarcodeGalleryBullet3 =>
      'If the picture has more than one code, the app finds them all.';

  @override
  String get helpGuideBarcodePdfTitle => 'Scan a PDF file';

  @override
  String get helpGuideBarcodePdfBullet1 =>
      'Tap the PDF button and choose a file, such as a ticket, bill or boarding pass.';

  @override
  String get helpGuideBarcodePdfBullet2 =>
      'The app checks every page and lists each code it finds, with its page number.';

  @override
  String get helpGuideBarcodePdfBullet3 =>
      'Tap Save all to keep them all in your history at once.';

  @override
  String get helpGuideBarcodePdfBullet4 =>
      'You can also share a PDF to this app from another app, such as your email or files app.';

  @override
  String get helpGuideBarcodeClipboardTitle => 'Scan copied text or pictures';

  @override
  String get helpGuideBarcodeClipboardBullet1 =>
      'If you copied a link, a code\'s text or a picture, tap the clipboard button at the top of the Scan screen to check it.';

  @override
  String get helpGuideBarcodeClipboardBullet2 =>
      'When you come back to the app with something copied, a small bar may offer to check it. Tap Scan Now, or close the bar.';

  @override
  String get helpGuideBarcodeClipboardBullet3 =>
      'Copied links get the same safety check as scanned links.';

  @override
  String get helpGuideBarcodeBatchTitle => 'Scan many codes in a row';

  @override
  String get helpGuideBarcodeBatchBullet1 =>
      'Tap the batch button to turn on batch mode. The camera keeps scanning, and each new code is added to a list.';

  @override
  String get helpGuideBarcodeBatchBullet2 =>
      'A counter shows how many codes you have scanned. Tap it to open the list.';

  @override
  String get helpGuideBarcodeBatchBullet3 =>
      'In the list you can look at each code, turn on Prevent Duplicates, and export the list as CSV, JSON, text or PDF.';

  @override
  String get helpGuideBarcodeBatchBullet4 =>
      'Tap the batch button again to go back to normal scanning.';

  @override
  String get helpGuideBarcodeTuneTitle => 'When a code is hard to read';

  @override
  String get helpGuideBarcodeTuneBullet1 =>
      'Tap the Camera adjustments button. Your changes show on the camera picture at once.';

  @override
  String get helpGuideBarcodeTuneBullet2 =>
      'Brightness and Contrast: make a dark or faded code clearer.';

  @override
  String get helpGuideBarcodeTuneBullet3 =>
      'Invert colors: for a light code on a dark background, such as on a dark screen or on metal.';

  @override
  String get helpGuideBarcodeTuneBullet4 =>
      'Camera Resolution: 1080p suits most phones. 720p saves battery. Maximum helps with very small codes.';

  @override
  String get helpGuideBarcodeTuneBullet5 =>
      'Distance Scan Assist: helps read codes far away, such as on posters and signs. Fine-tune it with Distance Zoom and Edge Sharpness.';

  @override
  String get helpGuideBarcodeTuneBullet6 =>
      'Multi-Code Selection: when more than one code is in view, each one gets an outline. Tap the one you want.';

  @override
  String get helpGuideBarcodeTuneBullet7 =>
      'Reset Adjustments puts everything back to normal.';

  @override
  String get helpGuideBarcodeTip =>
      'Tip: Codes are read on your phone. Camera pictures are never saved or sent anywhere.';

  @override
  String get helpGuideArCodeVisionName => 'AR CodeVision';

  @override
  String get helpGuideArCodeVisionSummary =>
      'See and use many codes at once, right on the camera picture.';

  @override
  String get helpGuideArCodeVisionIntro =>
      'AR CodeVision finds every code the camera can see, all at the same time. A small label floats over each code on the screen, so you can see what it is before you tap it.';

  @override
  String get helpGuideArCodeVisionOpenTitle => 'How to open it';

  @override
  String get helpGuideArCodeVisionOpenBullet1 =>
      'On the Scan screen, tap More options (the three dots) and choose AR CodeVision HUD.';

  @override
  String get helpGuideArCodeVisionOpenBullet2 =>
      'Allow the camera if Android asks.';

  @override
  String get helpGuideArCodeVisionTrackingTitle => 'The two modes';

  @override
  String get helpGuideArCodeVisionTrackingBullet1 =>
      'Safety: each link gets a colour badge. Green means no problems were found. Red means the link looks unsafe.';

  @override
  String get helpGuideArCodeVisionTrackingBullet2 =>
      'Warehouse: shows item details, such as a price tag, and lets you select codes.';

  @override
  String get helpGuideArCodeVisionBatchTitle => 'Using the labels';

  @override
  String get helpGuideArCodeVisionBatchBullet1 =>
      'Tap a label to see its full content. From there you can copy it, open the link, or select it.';

  @override
  String get helpGuideArCodeVisionBatchBullet2 =>
      'In Warehouse mode, select several codes, then tap Batch Copy to copy them all together. Tap Clear to start again.';

  @override
  String get helpGuideArCodeVisionBatchBullet3 =>
      'Tap the flashlight button when it is dark.';

  @override
  String get helpGuideArCodeVisionTip =>
      'Tip: Move the phone slowly. The labels follow the codes as you move.';

  @override
  String get helpGuideScanBubbleName => 'Scan from other apps';

  @override
  String get helpGuideScanBubbleSummary =>
      'Read a code that is on your screen in another app, with GhostScan or the Scan bubble.';

  @override
  String get helpGuideScanBubbleIntro =>
      'Sometimes a code is on your screen, in a chat, a web page or an email. You can read it without taking a screenshot, in two ways: GhostScan and the Scan bubble. Both read the code on your phone, with no internet.';

  @override
  String get helpGuideScanBubbleGhostTitle => 'GhostScan: scan the screen once';

  @override
  String get helpGuideScanBubbleGhostBullet1 =>
      'On the Scan screen, tap More options and choose GhostScan.';

  @override
  String get helpGuideScanBubbleGhostBullet2 =>
      'Tap Add Settings tile to put a GhostScan button in your Quick Settings (the panel you pull down from the top of the screen).';

  @override
  String get helpGuideScanBubbleGhostBullet3 =>
      'Then, in any app, pull down Quick Settings and tap the GhostScan tile. The app reads the code on your screen.';

  @override
  String get helpGuideScanBubbleUseTitle => 'How to use the Scan bubble';

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
  String get helpGuideScanBubbleUseBullet5 =>
      'Turn on Start after restart if you want the bubble to come back after the phone restarts.';

  @override
  String get helpGuideScanBubblePrivacyTitle => 'Privacy';

  @override
  String get helpGuideScanBubblePrivacyBullet1 =>
      'The screen is captured only when you tap the bubble or the GhostScan tile, and Android asks you first.';

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
  String get helpGuideCodeForgeName => 'Making codes (CodeForge)';

  @override
  String get helpGuideCodeForgeSummary =>
      'Make your own QR codes and barcodes, change their look, and share them.';

  @override
  String get helpGuideCodeForgeIntro =>
      'CodeForge lets you make your own QR code or barcode: for your Wi-Fi, your contact details, a link, a UPI payment and more. You can change its colours and shapes, and share it as a picture.';

  @override
  String get helpGuideCodeForgeTypeTitle => '1. Choose what to put in it';

  @override
  String get helpGuideCodeForgeTypeBullet1 =>
      'Open the CodeForge tab at the bottom of the screen.';

  @override
  String get helpGuideCodeForgeTypeBullet2 =>
      'Pick the code type: QR Code, or a barcode such as Code 128, EAN-13, EAN-8, UPC-A, Code 39, PDF417 or Data Matrix.';

  @override
  String get helpGuideCodeForgeTypeBullet3 =>
      'For a QR code, pick what it holds: Text, URL / Link, Wi-Fi, Contact, UPI Pay, SMS, Email or Location.';

  @override
  String get helpGuideCodeForgeTypeBullet4 =>
      'Fill in the boxes. The preview changes as you type.';

  @override
  String get helpGuideCodeForgeTypeBullet5 =>
      'For text, you can also tap Read from file to load text from a file (up to 500 characters).';

  @override
  String get helpGuideCodeForgeTypeBullet6 =>
      'For a location, tap Use My Location to fill in where you are. The app asks for your location only at that moment and does not keep it.';

  @override
  String get helpGuideCodeForgeStyleTitle => '2. Change the look';

  @override
  String get helpGuideCodeForgeStyleBullet1 =>
      'Design & Structure: choose the shape of the big corner squares, their centres, and the small dots.';

  @override
  String get helpGuideCodeForgeStyleBullet2 =>
      'Colors & Gradients: choose the code colour and the background, or a colour blend such as Sunset or Ocean.';

  @override
  String get helpGuideCodeForgeStyleBullet3 =>
      'Keep strong contrast. A dark code on a light background scans best.';

  @override
  String get helpGuideCodeForgeStyleBullet4 =>
      'Center Badge: put a small icon in the middle of the code.';

  @override
  String get helpGuideCodeForgeStyleBullet5 =>
      'Error Correction: how much damage the code can take and still scan. L survives about 7%, M 15%, Q 25% and H 30%. Higher levels make the code busier. Choose H when you add a centre badge.';

  @override
  String get helpGuideCodeForgeStyleBullet6 =>
      'Show Text Label prints the text under a barcode. Reset Styling puts the look back to normal.';

  @override
  String get helpGuideCodeForgeShareTitle => '3. Check and share';

  @override
  String get helpGuideCodeForgeShareBullet1 =>
      'For a link, tap Check to test the link for safety before you share it.';

  @override
  String get helpGuideCodeForgeShareBullet2 =>
      'Tap Share PNG to share it as a normal picture, or Share SVG for a sharp picture that prints well at any size.';

  @override
  String get helpGuideCodeForgeShareBullet3 =>
      'Tap Copy Content to copy the text inside the code.';

  @override
  String get helpGuideCodeForgeTip =>
      'Tip: Before you print many copies, scan your new code once with this app to make sure it reads well.';

  @override
  String get helpGuideAirQrName => 'AirQR: send data with no network';

  @override
  String get helpGuideAirQrSummary =>
      'Send text, or move your app data to another phone, using moving QR codes. No Wi-Fi, Bluetooth or cables.';

  @override
  String get helpGuideAirQrIntro =>
      'AirQR sends data from one phone to another using only the screen and the camera. The sending phone shows a fast series of QR codes. The receiving phone watches them and joins them back together. No network is used at all.';

  @override
  String get helpGuideAirQrStreamingTitle => 'How to send';

  @override
  String get helpGuideAirQrStreamingBullet1 =>
      'On the sending phone, open Scan > More options > AirQR receiver, then tap the AirQR transmitter button at the top.';

  @override
  String get helpGuideAirQrStreamingBullet2 =>
      'Type or paste what you want to send under Data to send.';

  @override
  String get helpGuideAirQrStreamingBullet3 =>
      'Choose the Stream Speed (5 to 25 frames a second), then tap Start stream.';

  @override
  String get helpGuideAirQrStreamingBullet4 =>
      'Keep the sending screen bright and hold it still.';

  @override
  String get helpGuideAirQrControlsTitle => 'How to receive';

  @override
  String get helpGuideAirQrControlsBullet1 =>
      'On the other phone, open Scan > More options > AirQR receiver and point the camera at the sending screen.';

  @override
  String get helpGuideAirQrControlsBullet2 =>
      'A progress bar shows how many parts have arrived and how many are still missing.';

  @override
  String get helpGuideAirQrControlsBullet3 =>
      'Missed parts are no problem. AirQR also sends extra repair parts, so the receiver can fill in the gaps.';

  @override
  String get helpGuideAirQrControlsBullet4 =>
      'When all parts arrive, the app checks the data and shows Transfer complete! You can copy the data from there.';

  @override
  String get helpGuideAirQrSyncTitle => 'Move your data to a new phone';

  @override
  String get helpGuideAirQrSyncBullet1 =>
      'On the old phone, go to Settings > AirQR Optical Sync. Choose your history, your app settings, or both.';

  @override
  String get helpGuideAirQrSyncBullet2 =>
      'Type a passphrase or PIN, or tap Generate PIN. This locks the data, so only someone with the PIN can open it.';

  @override
  String get helpGuideAirQrSyncBullet3 =>
      'Tap Beam via AirQR, and receive it on the new phone with the AirQR receiver.';

  @override
  String get helpGuideAirQrSyncBullet4 =>
      'On the new phone, type the same passphrase or PIN and tap Decrypt & Sync.';

  @override
  String get helpGuideAirQrSecurityTitle => 'Why it is private';

  @override
  String get helpGuideAirQrSecurityBullet1 =>
      'No radio signals are used: no Wi-Fi, Bluetooth, mobile data or internet.';

  @override
  String get helpGuideAirQrSecurityBullet2 =>
      'Nobody can catch the data over a network. Only a camera that can see the screen can read it.';

  @override
  String get helpGuideAirQrSecurityBullet3 =>
      'Useful for passwords, keys and other private data you do not want to send online.';

  @override
  String get helpGuideAirQrTip =>
      'Tip: Turn the sending phone\'s brightness up and hold the receiving phone steady. If parts keep going missing, lower the speed.';

  @override
  String get helpGuideUrlSafetyName => 'Link safety checks';

  @override
  String get helpGuideUrlSafetySummary =>
      'How the app checks every link before you open it, and what the result means.';

  @override
  String get helpGuideUrlSafetyIntro =>
      'Scam QR codes often lead to fake websites. So before you open any link, the app checks it in up to six ways. The first four checks always run on your phone, with no internet.';

  @override
  String get helpGuideUrlSafetyLayersTitle => 'The six checks';

  @override
  String get helpGuideUrlSafetyLayersBullet1 =>
      '1. Safe connection: is the link using secure HTTPS? Does it hide strange or invisible characters?';

  @override
  String get helpGuideUrlSafetyLayersBullet2 =>
      '2. Lookalike letters: some fake sites use letters from other alphabets that look the same, for example a Cyrillic \"а\" in place of a normal \"a\".';

  @override
  String get helpGuideUrlSafetyLayersBullet3 =>
      '3. Odd web addresses: risky endings (such as .xyz or .top), too many parts in the name, or names made of random letters.';

  @override
  String get helpGuideUrlSafetyLayersBullet4 =>
      '4. Number addresses and odd ports: links that use a raw number (an IP address) or an unusual port, which normal shops and banks do not use.';

  @override
  String get helpGuideUrlSafetyLayersBullet5 =>
      '5. Online check of the site (optional): follows short links (like bit.ly) to see where they really go, and checks the site\'s security certificate. Runs only if you turn on Active online checks.';

  @override
  String get helpGuideUrlSafetyLayersBullet6 =>
      '6. Known-bad lists (optional): asks services such as Google Safe Browsing whether the link is a known scam or virus site. Runs only if you set it up.';

  @override
  String get helpGuideUrlSafetyVerdictsTitle => 'Reading the result';

  @override
  String get helpGuideUrlSafetyVerdictsBullet1 =>
      'No issues found: the link passed every check that ran. Still, trust only sources you know.';

  @override
  String get helpGuideUrlSafetyVerdictsBullet2 =>
      'Issues found: the app shows which checks failed. Tap See details to read why.';

  @override
  String get helpGuideUrlSafetyVerdictsBullet3 =>
      'If you still open a risky link, the app asks you first. Tap Open Anyway only if you trust the source.';

  @override
  String get helpGuideUrlSafetyVerdictsBullet4 =>
      'Tap Re-check to run the checks again, for example after you go online.';

  @override
  String get helpGuideUrlSafetyPrivacyTitle => 'Private mode and online checks';

  @override
  String get helpGuideUrlSafetyPrivacyBullet1 =>
      'By default, the app never contacts the website itself. The site cannot see your phone or your IP address (your internet address).';

  @override
  String get helpGuideUrlSafetyPrivacyBullet2 =>
      'If you turn on Active online checks in Settings > Privacy & probing, the app visits the site to follow short links and check its certificate. This finds more, but the site can see your IP address.';

  @override
  String get helpGuideUrlSafetyPrivacyBullet3 =>
      'With Active online checks on, the result can also show a safe preview of the page. Scripts and trackers are removed first, so nothing on the page can run. Tap Show preview or Inspect page.';

  @override
  String get helpGuideUrlSafetyProvidersTitle => 'Extra online checkers';

  @override
  String get helpGuideUrlSafetyProvidersBullet1 =>
      'In Settings > URL Safety Providers you can turn on more checkers. PhishTank and OpenPhish need no account.';

  @override
  String get helpGuideUrlSafetyProvidersBullet2 =>
      'Google Safe Browsing, VirusTotal and URLhaus need your own free key. See the guide \"Online checker setup\".';

  @override
  String get helpGuideUrlSafetyProvidersBullet3 =>
      'These checkers get only the link you scanned. OpenPhish works differently: the app downloads its list and checks on your phone. All of them are off until you turn them on.';

  @override
  String get helpGuideUrlSafetyTip =>
      'Tip: A good result is not a promise. Scammers make new sites every day. If a payment or login page looks odd, close it.';

  @override
  String get helpGuideQuishingName => 'QuishingGuard: fake sticker codes';

  @override
  String get helpGuideQuishingSummary =>
      'Spot QR codes that may be fake stickers placed over real ones.';

  @override
  String get helpGuideQuishingIntro =>
      '\"Quishing\" means QR phishing. Scammers stick their own QR code over the real one, on parking meters, menus, shop counters and posters, so that your payment or login goes to them.';

  @override
  String get helpGuideQuishingCvTitle => 'What QuishingGuard shows';

  @override
  String get helpGuideQuishingCvBullet1 =>
      'When you scan a link or a payment code with the camera, the result screen shows a small QuishingGuard card: Fake sticker check.';

  @override
  String get helpGuideQuishingCvBullet2 =>
      'Tap it to open a short list of checks. The app does not look for stickers in the picture and gives no score, so it cannot tell you that a code is safe.';

  @override
  String get helpGuideQuishingCvBullet3 =>
      'The card does not appear for photos, the clipboard, screen scans or plain text, because those codes are not stuck on a wall.';

  @override
  String get helpGuideQuishingForensicTitle => 'What you should do';

  @override
  String get helpGuideQuishingForensicBullet1 =>
      'Look at the code and feel it with your finger. A sticker on top often has raised edges or sits crooked.';

  @override
  String get helpGuideQuishingForensicBullet2 =>
      'Before you pay, check that the name on the payment screen matches the shop.';

  @override
  String get helpGuideQuishingForensicBullet3 =>
      'If in doubt, ask the staff, or type the website address yourself instead.';

  @override
  String get helpGuideQuishingTip =>
      'Tip: QuishingGuard is a helper, not a promise. Your own eyes and fingers are the best check.';

  @override
  String get helpGuideSafeBrowsingName => 'Online checker setup';

  @override
  String get helpGuideSafeBrowsingSummary =>
      'Turn on extra link checks, and get a free key for Google Safe Browsing.';

  @override
  String get helpGuideSafeBrowsingIntro =>
      'Online checkers compare a scanned link with lists of known scam and virus sites. They are optional. The app\'s own checks work without them.';

  @override
  String get helpGuideSafeBrowsingBuiltInTitle => 'No account needed';

  @override
  String get helpGuideSafeBrowsingBuiltInBullet1 =>
      'Open Settings > URL Safety Providers.';

  @override
  String get helpGuideSafeBrowsingBuiltInBullet2 =>
      'Turn on Enable PhishTank to check links against PhishTank\'s list of scam sites.';

  @override
  String get helpGuideSafeBrowsingBuiltInBullet3 =>
      'Turn on Use OpenPhish feed. The app downloads OpenPhish\'s list and checks links on your phone. Tap Refresh feed now to get the latest list.';

  @override
  String get helpGuideSafeBrowsingKeyTitle =>
      'Get a free Google Safe Browsing key';

  @override
  String get helpGuideSafeBrowsingKeyStep1 =>
      '1. In a browser, open console.cloud.google.com and sign in with a Google account.';

  @override
  String get helpGuideSafeBrowsingKeyStep2 =>
      '2. Create a new project. Any name is fine, for example \"QR safety\".';

  @override
  String get helpGuideSafeBrowsingKeyStep3 =>
      '3. Go to APIs & Services > Library, search for \"Safe Browsing API\" and tap Enable.';

  @override
  String get helpGuideSafeBrowsingKeyStep4 =>
      '4. Go to APIs & Services > Credentials, tap Create credentials and choose API key.';

  @override
  String get helpGuideSafeBrowsingKeyStep5 =>
      '5. Copy the key. In the app, open Settings > URL Safety Providers, paste it into the Google Safe Browsing box and tap Save API Key.';

  @override
  String get helpGuideSafeBrowsingOtherTitle => 'Other services with a key';

  @override
  String get helpGuideSafeBrowsingOtherBullet1 =>
      'VirusTotal and URLhaus work the same way. Make a free account on their website, copy your key, and paste it under Your API Keys. The app shows where to get each key.';

  @override
  String get helpGuideSafeBrowsingOtherBullet2 =>
      'These free keys are for personal, non-commercial use.';

  @override
  String get helpGuideSafeBrowsingOtherBullet3 =>
      'Each service has a daily limit, and the app shows how many checks you have used today. In this app, Safe Browsing allows up to 10,000 a day and VirusTotal 500 a day.';

  @override
  String get helpGuideSafeBrowsingPrivacyTitle => 'Your keys are safe';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet1 =>
      'Your keys are kept in Android\'s secure, locked storage on this phone, and are never shared.';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet2 =>
      'Only the link you scanned is sent to the service. Nothing else about you is sent.';

  @override
  String get helpGuideSafeBrowsingPrivacyBullet3 =>
      'You can delete a key at any time. The app then simply skips that check.';

  @override
  String get helpGuideSafeBrowsingTip =>
      'Tip: You do not need any key to stay safe. The app\'s own checks always run, even with no internet.';

  @override
  String get helpGuideSmartPayloadsName => 'Smart actions';

  @override
  String get helpGuideSmartPayloadsSummary =>
      'One-tap buttons for Wi-Fi, payments, contacts, events, phone numbers, products and more.';

  @override
  String get helpGuideSmartPayloadsIntro =>
      'The app understands what a code holds and shows a card with the right buttons. For example, a Wi-Fi code gets a Connect button, and a phone number gets a Call button.';

  @override
  String get helpGuideSmartPayloadsWifiTitle => 'Wi-Fi';

  @override
  String get helpGuideSmartPayloadsWifiBullet1 =>
      'Shows the network name and its type of security. Tap the eye button to show or hide the password, or copy it.';

  @override
  String get helpGuideSmartPayloadsWifiBullet2 =>
      'Tap Connect to Wi-Fi. Android may ask you to confirm. If your phone does not allow a direct connection, the password is copied so you can paste it in your Wi-Fi settings.';

  @override
  String get helpGuideSmartPayloadsPaymentsTitle => 'Payments';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet1 =>
      'UPI codes show who you are paying and the amount. Tap Pay with UPI app to open your UPI app (such as Google Pay, PhonePe, Paytm or BHIM) with the details filled in.';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet2 =>
      'If the code has no amount, the app asks you to type it first.';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet3 =>
      'This app never takes or sends money by itself. You confirm every payment in your UPI app.';

  @override
  String get helpGuideSmartPayloadsPaymentsBullet4 =>
      'Crypto wallet codes (Bitcoin, Ethereum, Solana) and SEPA bank transfer codes show the address, which you can copy.';

  @override
  String get helpGuideSmartPayloadsTotpTitle => 'Two-step login codes (2FA)';

  @override
  String get helpGuideSmartPayloadsTotpBullet1 =>
      'Websites often show a QR code when you turn on two-step login. Scanning it shows a 6-digit code that changes every 30 seconds, with a timer.';

  @override
  String get helpGuideSmartPayloadsTotpBullet2 =>
      'Tap Add to authenticator to save it in your authenticator app, such as Google or Microsoft Authenticator.';

  @override
  String get helpGuideSmartPayloadsTotpBullet3 =>
      'Keep this kind of code private. Anyone who scans it can make your login codes.';

  @override
  String get helpGuideSmartPayloadsContactsTitle => 'Contacts and events';

  @override
  String get helpGuideSmartPayloadsContactsBullet1 =>
      'Contact codes (vCard or MeCard) show the name, phone, email and company. Tap Save to Contacts, or call or email straight away.';

  @override
  String get helpGuideSmartPayloadsContactsBullet2 =>
      'Event codes show the title, time and place. Tap Add to calendar.';

  @override
  String get helpGuideSmartPayloadsOtherTitle =>
      'Phone, messages, maps and more';

  @override
  String get helpGuideSmartPayloadsOtherBullet1 =>
      'Phone number: tap Call. Text message: tap Send Message, and the message is filled in for you. Email: tap Send Email.';

  @override
  String get helpGuideSmartPayloadsOtherBullet2 =>
      'Location: tap Open in Maps to see the place or get directions.';

  @override
  String get helpGuideSmartPayloadsOtherBullet3 =>
      'App link: tap Open in App to open the matching app, if it is installed.';

  @override
  String get helpGuideSmartPayloadsOtherBullet4 =>
      'Product barcode: tap Food Info to look up food details, or Search Web.';

  @override
  String get helpGuideSmartPayloadsOtherBullet5 =>
      'Book (ISBN) barcode: look the book up on Google Books or Open Library.';

  @override
  String get helpGuideSmartPayloadsOtherBullet6 =>
      'Web links open in your browser only after the safety check has run.';

  @override
  String get helpGuideSmartPayloadsTip =>
      'Tip: Before you pay with a UPI code, check that the name on the card matches the shop or person you want to pay.';

  @override
  String get helpGuideHiddenName => 'Hidden and locked codes';

  @override
  String get helpGuideHiddenSummary =>
      'Open QR codes that carry a secret message or locked data.';

  @override
  String get helpGuideHiddenIntro =>
      'Some QR codes carry private data that is locked with a passphrase. The app spots these codes and lets you unlock them, right on your phone.';

  @override
  String get helpGuideHiddenStegoTitle =>
      'StegoQR: a code with a hidden message';

  @override
  String get helpGuideHiddenStegoBullet1 =>
      'A StegoQR code shows ordinary public text to everyone, and hides a second, secret message inside it.';

  @override
  String get helpGuideHiddenStegoBullet2 =>
      'When you scan one, the result shows StegoQR found. The public text is shown as usual.';

  @override
  String get helpGuideHiddenStegoBullet3 =>
      'To see the secret, type the passphrase and tap Unlock. The person who made the code must give you the passphrase.';

  @override
  String get helpGuideHiddenStegoBullet4 =>
      'Biometric Unlock asks for your fingerprint or face as well as the passphrase.';

  @override
  String get helpGuideHiddenStegoBullet5 =>
      'After unlocking, you can copy or share the secret.';

  @override
  String get helpGuideHiddenOtherTitle => 'Other locked codes';

  @override
  String get helpGuideHiddenOtherBullet1 =>
      'AirQR transfer codes: type the session code shown on the sending phone.';

  @override
  String get helpGuideHiddenOtherBullet2 =>
      'Encrypted JSON codes and other locked text: tap Decrypt Payload and type the passphrase.';

  @override
  String get helpGuideHiddenOtherBullet3 =>
      'Advanced (Salt / IV) is only for codes made by other tools that need extra settings. Most people never need it.';

  @override
  String get helpGuideHiddenSafetyTitle => 'Good to know';

  @override
  String get helpGuideHiddenSafetyBullet1 =>
      'Unlocking happens on your phone. The passphrase and the secret are never sent anywhere.';

  @override
  String get helpGuideHiddenSafetyBullet2 =>
      'A wrong passphrase just shows an error. Check the spelling, capital letters and spaces, and try again.';

  @override
  String get helpGuideHiddenSafetyBullet3 =>
      'This app can open these codes, but it does not make them.';

  @override
  String get helpGuideHiddenTip =>
      'Tip: Share the passphrase in a different way from the code, for example by phone call. Never write it next to the code.';

  @override
  String get helpGuideHistoryName => 'History, backups and privacy';

  @override
  String get helpGuideHistorySummary =>
      'Find old scans, add notes, export or back up your history, and lock the app.';

  @override
  String get helpGuideHistoryIntro =>
      'Every scan is saved in the History tab on your phone, in a locked (encrypted) store. Nothing is uploaded.';

  @override
  String get helpGuideHistoryManageTitle => 'Find and manage scans';

  @override
  String get helpGuideHistoryManageBullet1 =>
      'Type in the search box to find scans by their content, type or notes.';

  @override
  String get helpGuideHistoryManageBullet2 =>
      'Use the filter chips to show only links, Wi-Fi, contacts, products and so on. Tap the star on a scan to add it to Starred.';

  @override
  String get helpGuideHistoryManageBullet3 =>
      'Tap a scan to see all its details: full content, safety score and time. You can add notes and a place, or copy, share or delete it.';

  @override
  String get helpGuideHistoryManageBullet4 =>
      'Clear All deletes your whole history. This cannot be undone, so make a backup first.';

  @override
  String get helpGuideHistoryBackupTitle => 'Export and backup';

  @override
  String get helpGuideHistoryBackupBullet1 =>
      'Tap the Export / Backup button at the top of the History tab.';

  @override
  String get helpGuideHistoryBackupBullet2 =>
      'Export Records saves a copy as CSV (for Excel or Sheets), JSON, text or PDF. These files are not locked: anyone with the file can read your scans, so the app asks you first.';

  @override
  String get helpGuideHistoryBackupBullet3 =>
      'Encrypted backup is the safe way to keep a copy. Type a passphrase and tap Create backup, then save or share the file.';

  @override
  String get helpGuideHistoryBackupBullet4 =>
      'To restore, open Restore Backup, paste the text from your backup file, type the same passphrase and tap Restore history.';

  @override
  String get helpGuideHistoryBiometricsTitle => 'App lock and screenshot guard';

  @override
  String get helpGuideHistoryBiometricsBullet1 =>
      'App lock: turn it on in Settings > Privacy & probing. The app then asks for your fingerprint, face or screen lock when it opens, and after you have been away for 30 seconds.';

  @override
  String get helpGuideHistoryBiometricsBullet2 =>
      'Screenshot guard: stops screenshots and screen recording on screens with scans, history, secrets or keys. These screens also look blank in the recent apps list. Turn it on or off in Settings > Privacy & probing.';

  @override
  String get helpGuideHistoryBiometricsBullet3 =>
      'To move your history to a new phone, use AirQR Optical Sync. See the AirQR guide.';

  @override
  String get helpGuideHistoryTip =>
      'Tip: Make an encrypted backup before you reset or change your phone. Keep the passphrase somewhere safe. Without it, the backup cannot be opened.';

  @override
  String get helpGuideSettingsName => 'Settings and personal touch';

  @override
  String get helpGuideSettingsSummary =>
      'Change the look, language and sounds, see permissions, save battery, and delete your data.';

  @override
  String get helpGuideSettingsIntro =>
      'To open Settings, go to the Scan screen, tap More options and choose Settings. Here is what each part does.';

  @override
  String get helpGuideSettingsLookTitle => 'Look and language';

  @override
  String get helpGuideSettingsLookBullet1 =>
      'Appearance > Theme Mode: System, Light, Dark or OLED. OLED is pure black and saves battery on OLED screens.';

  @override
  String get helpGuideSettingsLookBullet2 =>
      'Accent & colors: pick a main colour, or turn on Dynamic colors to match your wallpaper (Android 12 and newer).';

  @override
  String get helpGuideSettingsLookBullet3 =>
      'Text size & font: choose the font. The text size follows the text size you set for your phone.';

  @override
  String get helpGuideSettingsLookBullet4 =>
      'Scan Overlay Style: choose how the scan frame looks.';

  @override
  String get helpGuideSettingsLookBullet5 =>
      'Language: choose System default, English, Malayalam (മലയാളം) or Sanskrit (संस्कृतम्). The app changes at once, with no restart.';

  @override
  String get helpGuideSettingsFeedbackTitle => 'Scan feedback';

  @override
  String get helpGuideSettingsFeedbackBullet1 =>
      'Choose whether the phone vibrates, beeps, or plays a short animation when a code is read.';

  @override
  String get helpGuideSettingsPrivacyTitle => 'Privacy & probing';

  @override
  String get helpGuideSettingsPrivacyBullet1 =>
      'Active online checks: off unless you turn it on. See the Link safety guide.';

  @override
  String get helpGuideSettingsPrivacyBullet2 =>
      'App lock and Screenshot guard: see the History, backups and privacy guide.';

  @override
  String get helpGuideSettingsPrivacyBullet3 =>
      'Delete all data: removes your scan history, saved keys and all settings from this phone. This cannot be undone.';

  @override
  String get helpGuideSettingsOtherTitle => 'Other settings';

  @override
  String get helpGuideSettingsOtherBullet1 =>
      'URL Safety Providers: turn on extra online link checkers.';

  @override
  String get helpGuideSettingsOtherBullet2 =>
      'AirQR Optical Sync: move your history and settings to another phone.';

  @override
  String get helpGuideSettingsOtherBullet3 =>
      'Scan bubble: a floating button to scan codes in other apps.';

  @override
  String get helpGuideSettingsOtherBullet4 =>
      'Permissions: a plain list of what the app may use, and why. The app asks for each one only when a feature needs it.';

  @override
  String get helpGuideSettingsOtherBullet5 =>
      'Features lists everything the app can do. Welcome Tour shows the first-start introduction again. About shows the app version and licences.';

  @override
  String get helpGuideSettingsBatteryTitle => 'Saving battery';

  @override
  String get helpGuideSettingsBatteryBullet1 =>
      'The camera turns off as soon as you leave the Scan screen or the app.';

  @override
  String get helpGuideSettingsBatteryBullet2 =>
      'Choose 720p in Camera adjustments to use less power.';

  @override
  String get helpGuideSettingsBatteryBullet3 =>
      'Turn off the Scan bubble when you do not need it.';

  @override
  String get helpGuideSettingsBatteryBullet4 =>
      'Use the OLED theme on phones with an OLED screen.';

  @override
  String get helpGuideSettingsTip =>
      'Tip: Not sure where something is? Every guide here names the button to tap.';

  @override
  String get helpGuideFaqName => 'FAQ and problems';

  @override
  String get helpGuideFaqSummary =>
      'Answers to common questions, and fixes when something does not work.';

  @override
  String get helpGuideFaqIntro =>
      'Quick answers to common questions, and what to do when something does not work.';

  @override
  String get helpGuideFaqQuestionsTitle => 'Common questions';

  @override
  String get helpGuideFaqQuestion1 =>
      'Does the app work without internet?\nYes. Reading codes, the first four link checks and QuishingGuard all work offline. Only the optional online checks need the internet.';

  @override
  String get helpGuideFaqQuestion2 =>
      'Are my camera pictures sent anywhere?\nNo. Pictures are read on your phone and are never saved or uploaded.';

  @override
  String get helpGuideFaqQuestion3 =>
      'Does the app collect data about me?\nNo. There are no ads, no tracking and no analytics. Your history stays on your phone.';

  @override
  String get helpGuideFaqQuestion4 =>
      'Why does the app ask for a permission?\nOnly when you use a feature that needs it, such as the camera for scanning. See Settings > Permissions for the full list.';

  @override
  String get helpGuideFaqQuestion5 =>
      'How do I change the language?\nGo to Settings > Language. The app changes at once.';

  @override
  String get helpGuideFaqQuestion6 =>
      'How do I delete everything?\nGo to Settings > Privacy & probing > Delete all data. You can also delete single scans in History.';

  @override
  String get helpGuideFaqQuestion7 =>
      'A link I trust is marked unsafe. Why?\nThe checks look for warning signs, and some real sites have them too. If you are sure about the source, you can still open it.';

  @override
  String get helpGuideFaqQuestion8 =>
      'Does the app use a lot of battery?\nNo. The camera stops as soon as you leave the Scan screen. See the Settings guide for more battery tips.';

  @override
  String get helpGuideFaqCameraTitle => 'When a code will not scan';

  @override
  String get helpGuideFaqCameraBullet1 =>
      'Clean the camera lens and hold the phone about 15 to 20 cm (6 to 8 inches) from the code.';

  @override
  String get helpGuideFaqCameraBullet2 =>
      'In a dark place, turn on the flash. For a shiny code, tilt the phone a little to remove the glare.';

  @override
  String get helpGuideFaqCameraBullet3 =>
      'For a small or far-away code, use the zoom slider or Distance Scan Assist, instead of moving very close.';

  @override
  String get helpGuideFaqCameraBullet4 =>
      'For a light code on a dark background, turn on Invert colors in Camera adjustments.';

  @override
  String get helpGuideFaqCameraBullet5 =>
      'For a damaged or faded code, try Brightness and Contrast in Camera adjustments, or take a photo and scan it from the gallery.';

  @override
  String get helpGuideFaqFixTitle => 'Other problems';

  @override
  String get helpGuideFaqFixBullet1 =>
      'Camera does not open: if you said no to the camera, go to Android Settings > Apps > SreerajP QR Studio > Permissions > Camera and choose Allow.';

  @override
  String get helpGuideFaqFixBullet2 =>
      'Wi-Fi will not connect: copy the password and join the network in your phone\'s Wi-Fi settings.';

  @override
  String get helpGuideFaqFixBullet3 =>
      'Payment app does not open: make sure a UPI app is installed. You can also copy the UPI ID.';

  @override
  String get helpGuideFaqFixBullet4 =>
      'Scan bubble keeps disappearing: some phones stop apps in the background. Allow this app in your phone\'s battery settings.';

  @override
  String get helpGuideFaqFixBullet5 =>
      'An online check says Skipped: that checker is turned off, or has no key. Tap Set up in Settings on the result to fix it.';

  @override
  String get helpGuideFaqTip =>
      'Tip: Still stuck? Take a clear photo of the code and scan it from the gallery.';

  @override
  String get titleHelpBarcode => 'Scanning codes';

  @override
  String get titleHelpArCodeVision => 'AR CodeVision';

  @override
  String get titleHelpAirQr => 'AirQR guide';

  @override
  String get titleHelpUrlSafety => 'Link safety';

  @override
  String get titleHelpQuishing => 'QuishingGuard';

  @override
  String get titleHelpSafeBrowsing => 'Online checkers';

  @override
  String get titleHelpSmartPayloads => 'Smart actions';

  @override
  String get titleHelpHistory => 'History & privacy';

  @override
  String get titleHelpFaq => 'FAQ & help';

  @override
  String get titleHelpScanBubble => 'Scan from other apps';

  @override
  String get titleHelpCodeForge => 'Making codes';

  @override
  String get titleHelpHiddenCodes => 'Locked codes';

  @override
  String get titleHelpSettings => 'Settings guide';

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

  @override
  String get titleIdCard => 'ID card';

  @override
  String get labelIdCardName => 'Name';

  @override
  String get labelIdCardBirthDate => 'Date of birth';

  @override
  String get labelIdCardExpiry => 'Expires';

  @override
  String get labelIdCardNumber => 'Document number';

  @override
  String get labelIdCardIssuer => 'Issued by';

  @override
  String get labelIdCardAddress => 'Address';

  @override
  String get actionIdCardShowNumber => 'Show number';

  @override
  String get actionIdCardHideNumber => 'Hide number';

  @override
  String get actionIdCardCopy => 'Copy details';

  @override
  String get bodyIdCardNotSaved => 'ID card data is not saved to history.';

  @override
  String get helpGuideSmartPayloadsOtherBullet7 =>
      'ID card (US or Canadian driving licence): see the name, dates and address. The number stays hidden until you tap Show. ID cards are never saved to history.';
}
