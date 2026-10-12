// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SreerajP QR Studio';

  @override
  String get wifiCardTitle => 'Wi-Fi Network';

  @override
  String get wifiShowPassword => 'Show Password';

  @override
  String get wifiHidePassword => 'Hide Password';

  @override
  String get wifiCopyPassword => 'Copy Password';

  @override
  String get wifiConnectButton => 'Connect to Wi-Fi';

  @override
  String get wifiPasswordCopied => 'Password copied to clipboard';

  @override
  String get wifiOpenSettingsHint =>
      'Password copied. Open Wi-Fi Settings on your device to connect.';

  @override
  String wifiConnectSuccess(String ssid) {
    return 'Connection requested for $ssid';
  }

  @override
  String geoLatLng(String latitude, String longitude) {
    return 'Lat: $latitude, Lng: $longitude';
  }

  @override
  String geoQuery(String query) {
    return 'Query: $query';
  }

  @override
  String get geoNavigateButton => 'Navigate in Google Maps';

  @override
  String get geoLaunchFailed => 'Could not launch Google Maps app';

  @override
  String get calendarCardTitle => 'Calendar Event';

  @override
  String get calendarNoDate => 'N/A';

  @override
  String calendarStart(String dateTime) {
    return 'Start: $dateTime';
  }

  @override
  String calendarEnd(String dateTime) {
    return 'End:   $dateTime';
  }

  @override
  String get calendarAddButton => 'Add to Device Calendar';

  @override
  String get calendarLaunchFailed => 'Could not open Calendar app';

  @override
  String get contactCardTitle => 'Contact Card';

  @override
  String get contactInitialFallback => 'C';

  @override
  String get contactSaveButton => 'Save to Contacts';

  @override
  String get contactLaunchFailed => 'Could not open Contacts app';

  @override
  String contactCallFailed(String number) {
    return 'Could not place call to $number';
  }

  @override
  String contactEmailFailed(String email) {
    return 'Could not open email app for $email';
  }

  @override
  String pdfResultsTitle(int count) {
    return 'PDF Scan Results ($count)';
  }

  @override
  String pdfPageBadge(int page) {
    return 'P$page';
  }

  @override
  String pdfPageLabel(int page) {
    return 'Page $page';
  }

  @override
  String pdfSaveAllButton(int count) {
    return 'Save All ($count) to History';
  }

  @override
  String pdfScanNote(int page) {
    return 'Scanned from PDF (Page $page)';
  }

  @override
  String pdfSavedToHistory(int count) {
    return 'Saved $count codes to history.';
  }

  @override
  String get totpDefaultIssuer => '2FA Authenticator';

  @override
  String totpLivePasscode(int period) {
    return 'Live Passcode (${period}s TOTP)';
  }

  @override
  String totpSecondsLeft(int seconds) {
    return '${seconds}s';
  }

  @override
  String get totpCopyToken => 'Copy Token';

  @override
  String get totpSecretLabel => 'Secret: ';

  @override
  String get totpImportButton => 'Import into Authenticator App';

  @override
  String get totpLaunchFailed => 'Could not open Authenticator app';

  @override
  String get totpTokenCopied => 'TOTP token copied to clipboard';

  @override
  String get totpSecretCopied => 'Secret key copied to clipboard';

  @override
  String get paymentSchemeUpi => 'UPI Payment';

  @override
  String get paymentSchemeSepa => 'SEPA Transfer';

  @override
  String get paymentSchemeCrypto => 'Crypto Payment';

  @override
  String get paymentPayeeFallback => 'Merchant / Payee';

  @override
  String get paymentAddressLabelUpi => 'VPA / UPI ID:';

  @override
  String get paymentAddressLabelSepa => 'IBAN:';

  @override
  String get paymentAddressLabelCrypto => 'Wallet Address:';

  @override
  String get paymentCopyAction => 'Copy';

  @override
  String get paymentUpiIdCopied => 'UPI ID copied to clipboard';

  @override
  String get paymentAddressCopied => 'Address copied to clipboard';

  @override
  String paymentNote(String note) {
    return 'Note: $note';
  }

  @override
  String get paymentPayButtonUpi => 'Pay via App (GPay / PhonePe / Paytm)';

  @override
  String get paymentPayButton => 'Pay via App';

  @override
  String get paymentUpiLaunchFailed =>
      'Could not open UPI app. Make sure GPay, PhonePe, or Paytm is installed.';

  @override
  String get paymentLaunchFailed =>
      'Could not open payment app for this scheme.';

  @override
  String get paymentCopyIdAction => 'Copy ID';

  @override
  String get paymentAmountDialogTitle => 'Enter amount';

  @override
  String paymentAmountDialogBody(String payee) {
    return 'This QR has no amount. Enter the amount to pay to $payee.';
  }

  @override
  String get paymentAmountFieldLabel => 'Amount';

  @override
  String get paymentAmountInvalid => 'Enter ₹1 or more';

  @override
  String get paymentAmountPayButton => 'Pay';

  @override
  String percentValue(String value) {
    return '$value%';
  }

  @override
  String get quishingGuardTitle => 'QuishingGuard™';

  @override
  String get quishingTamperBadge => 'Physical Tamper CV';

  @override
  String get quishingRiskScoreLabel => 'Tamper Risk Score:';

  @override
  String get quishingViewSignals => 'View Forensic Analysis';

  @override
  String get quishingHideSignals => 'Hide Forensic Signals';

  @override
  String get quishingMetricEdgeLabel => 'Edge Discontinuity';

  @override
  String get quishingMetricEdgeDescription => 'Double edges & shadow lines';

  @override
  String get quishingMetricGrainLabel => 'Print Grain & DPI';

  @override
  String get quishingMetricGrainDescription => 'Halftone dot & chromatic noise';

  @override
  String get quishingSignalsHeading => 'Detected Computer Vision Signals:';

  @override
  String get arCloseSheet => 'Close Sheet';

  @override
  String arItemPriceTag(String price) {
    return 'Item Price Tag: $price';
  }

  @override
  String get arContentCopied => 'Copied content to clipboard';

  @override
  String get arCopyButton => 'Copy';

  @override
  String get arOpenUrlButton => 'Open URL';

  @override
  String get arSelectButton => 'Select Item';

  @override
  String get arDeselectButton => 'Deselect';

  @override
  String get arSafetyStatusSafe => 'Safety Status: Verified Safe';

  @override
  String get arSafetyStatusWarning =>
      'Safety Status: Warning / Phishing Suspicion';

  @override
  String get arSafetyStatusUnknown => 'Safety Status: Analyzing link safety...';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String historyTimestamp(String date, String time) {
    return '$date • $time';
  }

  @override
  String get historyStar => 'Star favorite';

  @override
  String get historyUnstar => 'Unstar';

  @override
  String get historyEditNotes => 'Edit Notes';

  @override
  String get historyCopyString => 'Copy String';

  @override
  String get historyShare => 'Share';

  @override
  String get historyDelete => 'Delete';

  @override
  String get historyDetailTitle => 'Scan Record Details';

  @override
  String historySafetyBadge(int score) {
    return '🛡️ $score% Safe';
  }

  @override
  String historyScoreBadge(int score) {
    return '🛡️ $score%';
  }

  @override
  String get historyScannedContent => 'Scanned Content:';

  @override
  String get historyCopyButton => 'Copy';

  @override
  String get historyNotesLabel => 'Custom User Notes';

  @override
  String get historyNotesHint =>
      'Add personal notes or remarks about this scan...';

  @override
  String get historyLocationLabel => 'Location Tag (Optional)';

  @override
  String get historyLocationHint =>
      'e.g. Office Desk, Grocery Store, Conference';

  @override
  String get historySaveChanges => 'Save Metadata Changes';

  @override
  String get closeButton => 'Close';

  @override
  String get exportDialogTitle => 'Export & Cloud Backup';

  @override
  String get restoreDialogTitle => 'Restore Encrypted Backup';

  @override
  String get exportRecordsTab => 'Export Records';

  @override
  String get restoreBackupTab => 'Restore Backup';

  @override
  String get exportFormatHeading => 'Select Export Format:';

  @override
  String get exportCsvTitle => 'CSV Format (.csv)';

  @override
  String get exportCsvSubtitle => 'Compatible with Excel and Sheets';

  @override
  String get exportJsonTitle => 'JSON Dataset (.json)';

  @override
  String get exportJsonSubtitle => 'Structured developer format';

  @override
  String get exportTxtTitle => 'Formatted TXT Report (.txt)';

  @override
  String get exportTxtSubtitle => 'Human readable summary document';

  @override
  String get exportPdfTitle => 'PDF Document Report (.pdf)';

  @override
  String get exportPdfSubtitle => 'Formatted printable report table';

  @override
  String get exportBackupHeading => 'Encrypted Local Backup File (.sreerajqr)';

  @override
  String get exportPassphraseLabel => 'Backup Encryption Passphrase';

  @override
  String get exportPassphraseHint => 'Enter secret passphrase...';

  @override
  String get exportPassphraseRequired =>
      'Please enter a password to encrypt your backup file.';

  @override
  String get exportCreateBackupButton => 'Create Encrypted Backup File';

  @override
  String get exportShareText => 'SreerajP QR Studio Scan History Export';

  @override
  String get exportSharePdfText =>
      'SreerajP QR Studio Scan History Report (PDF)';

  @override
  String get exportShareBackupText =>
      'SreerajP QR Studio Encrypted Backup File';

  @override
  String get restoreHeading => 'Restore History from Encrypted Backup File:';

  @override
  String get restorePassphraseLabel => 'Backup Decryption Passphrase';

  @override
  String get restorePayloadLabel => 'Encrypted Backup Payload (.sreerajqr)';

  @override
  String get restorePayloadHint => 'Paste backup JSON payload string here...';

  @override
  String get restoreFieldsRequired =>
      'Please provide both the password and backup content.';

  @override
  String get restoreButton => 'Decrypt & Restore History';

  @override
  String restoreSuccess(int count) {
    return 'Successfully restored $count scan records!';
  }

  @override
  String restoreFailed(String reason) {
    return 'Restore failed: $reason';
  }

  @override
  String get domSandboxedBadge => 'SANDBOXED';

  @override
  String get domTitleInitialFallback => 'W';

  @override
  String get domUntitledPage => 'Untitled Web Page';

  @override
  String get domThumbnailCaption =>
      'Visual Thumbnail Pre-Render (Script Execution Blocked)';

  @override
  String domBlockedBadge(int scripts, int trackers) {
    return 'Blocked: $scripts Scripts, $trackers Trackers';
  }

  @override
  String domNewlyRegistered(int days) {
    return 'Newly Registered (${days}d)';
  }

  @override
  String domDomainAge(int days) {
    return 'Domain Age: $days days';
  }

  @override
  String get domOpenRedirectFound => 'Open Redirect Trap!';

  @override
  String get domNoOpenRedirect => 'No Open Redirects';

  @override
  String get domInspectButton => 'Inspect DOM Sandbox Structure';

  @override
  String get domInspectTitle => 'Zero-Trust DOM Sandbox Hierarchy';

  @override
  String get domDetailPageTitle => 'Page Title';

  @override
  String get domDetailNotSpecified => 'Not specified';

  @override
  String get domDetailMetaDescription => 'Meta Description';

  @override
  String get domDetailNoneFound => 'None found';

  @override
  String get domDetailHeadingsCount => 'Headings Count';

  @override
  String domDetailHeadingsValue(int count) {
    return '$count headings extracted';
  }

  @override
  String get domDetailLinksFound => 'Links Found';

  @override
  String domDetailLinksValue(int count) {
    return '$count URLs extracted';
  }

  @override
  String get domDetailBlockedScripts => 'Blocked Scripts';

  @override
  String domDetailBlockedScriptsValue(int count) {
    return '$count executable script tags/events stripped';
  }

  @override
  String get domDetailBlockedTrackers => 'Blocked Trackers';

  @override
  String domDetailBlockedTrackersValue(int count) {
    return '$count tracking pixels stripped';
  }

  @override
  String get domDetailBlockedIframes => 'Blocked Iframes';

  @override
  String domDetailBlockedIframesValue(int count) {
    return '$count iframe/embed elements removed';
  }

  @override
  String get domSanitizedSnippetHeading => 'Sanitized HTML Preview Snippet:';

  @override
  String get aboutTitle => 'About';

  @override
  String aboutVersion(String version, String build) {
    return 'Version $version+$build';
  }

  @override
  String get aboutBuildDate => 'Build Date';

  @override
  String get aboutOpenSourceLicenses => 'Open-source licences';

  @override
  String get aboutOpenSourceLicensesDetail =>
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
  String get aboutMadeWithLove => 'Made with ❤️ from India';

  @override
  String get airQrTransmitterTitle => 'AirQR Stream Transmitter';

  @override
  String get airQrSamplePayload =>
      'AirQR High-Speed Optical Air-Gap Transfer Test Payload. This payload is split into small chunks with Fountain FEC error correction.';

  @override
  String get airQrPayloadLabel => 'Payload Data to Broadcast';

  @override
  String get airQrPayloadHint => 'Enter text, contact, or file payload...';

  @override
  String get airQrStreamSpeed => 'Stream Speed:';

  @override
  String airQrFps(int fps) {
    return '$fps FPS';
  }

  @override
  String get airQrStartStream => 'Broadcast Optical Stream';

  @override
  String get airQrStopStream => 'Stop Optical Stream';

  @override
  String airQrFrameParity(int current, int total) {
    return 'Frame $current/$total [Fountain PARITY]';
  }

  @override
  String airQrFrameBlock(int current, int total, int block) {
    return 'Frame $current/$total [Block $block]';
  }

  @override
  String airQrTotalFrames(int total, int source, int parity) {
    return 'Total Stream Frames: $total ($source Source + $parity Fountain FEC)';
  }

  @override
  String get toggleFlashlight => 'Toggle Flashlight';

  @override
  String get grantCameraPermission => 'Grant Camera Permission';

  @override
  String get arScreenTitle => 'AR CodeVision HUD';

  @override
  String get arInitializing => 'Initializing AR HUD Viewport...';

  @override
  String get arClearSelection => 'Clear';

  @override
  String get arBatchCopy => 'Batch Copy';

  @override
  String arBatchCopied(int count) {
    return 'Copied $count barcodes to clipboard';
  }

  @override
  String get arCameraPermissionMessage =>
      'Camera permission is required for AR CodeVision';

  @override
  String get doneButton => 'Done';

  @override
  String get airQrReceiverTitle => 'AirQR Stream Receiver';

  @override
  String get airQrTransmitterTooltip => 'AirQR Transmitter';

  @override
  String get airQrResetStream => 'Reset Stream';

  @override
  String get airQrInitializing => 'Initializing AirQR Stream Receiver...';

  @override
  String get airQrStatusReassembled => 'STREAM REASSEMBLED';

  @override
  String get airQrStatusCapturing => 'CAPTURING OPTICAL STREAM...';

  @override
  String get airQrStatusIdle => 'POINT AT ANIMATED QR STREAM';

  @override
  String airQrCaptured(int received, int total) {
    return 'Captured: $received / $total Blocks';
  }

  @override
  String airQrMissing(int count) {
    return 'Missing: $count';
  }

  @override
  String get airQrTransferComplete => 'Air-Gap Transfer Complete!';

  @override
  String get airQrTransferCompleteDetail =>
      'Payload reassembled and verified offline via Fountain error correction.';

  @override
  String get airQrPayloadCopied => 'Copied payload to clipboard';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get historyScreenTitle => 'Scan History';

  @override
  String get historyExportTooltip => 'Export / Backup';

  @override
  String get historyClearAll => 'Clear All';

  @override
  String get historyClearTitle => 'Clear Scan History?';

  @override
  String get historyClearMessage =>
      'Are you sure you want to delete all persistent scan history? This action cannot be undone unless you have created a backup.';

  @override
  String get historySearchHint => 'Search history (content, format, notes)...';

  @override
  String get historyFilterAll => 'All';

  @override
  String get historyFilterStarred => 'Starred';

  @override
  String get historyFilterUrls => 'URLs';

  @override
  String get historyFilterWifi => 'Wi-Fi';

  @override
  String get historyFilterContacts => 'Contacts';

  @override
  String get historyFilterText => 'Text';

  @override
  String get historyFilterBarcodes => 'Barcodes';

  @override
  String get historyEmptyTitle => 'No Scan Records Found';

  @override
  String get historyEmptyMessage =>
      'Scanned barcodes will automatically appear here.';

  @override
  String historyNoMatches(String query) {
    return 'No matches for \"$query\"';
  }

  @override
  String get moreOptions => 'More options';

  @override
  String get menuHistory => 'History';

  @override
  String get menuSettings => 'Settings';

  @override
  String get grantPermission => 'Grant Permission';

  @override
  String get scanFromGallery => 'Scan Image from Gallery';

  @override
  String get scanPdfDocument => 'Scan PDF Document';

  @override
  String get scanPdfProgress => 'Extracting & scanning PDF pages...';

  @override
  String get scanSharedPdfProgress => 'Scanning shared PDF document...';

  @override
  String get scanInitializingCamera => 'Initializing camera...';

  @override
  String get scanInitializingFeed => 'Initializing camera feed...';

  @override
  String get scanTorchTooltip => 'Flashlight / Torch';

  @override
  String get scanZoomTooltip => 'Zoom slider';

  @override
  String get scanFlipCameraTooltip => 'Flip Camera (Front/Back)';

  @override
  String scanZoomValue(String value) {
    return '${value}x';
  }

  @override
  String get scanViewfinderHint =>
      'Position QR code or barcode within the frame';

  @override
  String get scanCameraPermissionRequired => 'Camera permission required';

  @override
  String get copiedLabel => 'Copied!';

  @override
  String get hideAction => 'Hide';

  @override
  String get revealAction => 'Reveal';

  @override
  String get openAnywayButton => 'Open Anyway';

  @override
  String get resultScreenTitle => 'Scan Result';

  @override
  String get resultNoResult => 'No result';

  @override
  String get resultContentLabel => 'Content:';

  @override
  String get resultDecoyContentLabel => 'Public Decoy Content:';

  @override
  String get resultDetectedType => 'Detected Type:';

  @override
  String get resultTypeStego => 'STEGO-QR (Encrypted Dual-Layer)';

  @override
  String get resultRecheckButton => 'Re-check';

  @override
  String get resultOpenInBrowser => 'Open in Browser';

  @override
  String get resultCopyText => 'Copy Text';

  @override
  String get resultCopyDecoyText => 'Copy Decoy Text';

  @override
  String get resultShareText => 'Share Text';

  @override
  String get resultShareDecoyText => 'Share Decoy Text';

  @override
  String get resultScanAnother => 'Scan Another Code';

  @override
  String get resultLaunchFailed => 'Could not launch URL';

  @override
  String get stegoUnlockedMessage =>
      'The hidden AES-256 encrypted payload has been decrypted successfully.';

  @override
  String get stegoLockedMessage =>
      'This QR code contains a hidden, encrypted secret layer. Authenticate to view the hidden payload.';

  @override
  String get stegoBiometricUnlock => 'Biometric Unlock';

  @override
  String get stegoPassphrase => 'Passphrase';

  @override
  String get stegoSecretPayload => 'Secret Payload:';

  @override
  String get stegoCopySecret => 'Copy Secret';

  @override
  String get stegoShareSecret => 'Share Secret';

  @override
  String get stegoSecretCopied => 'Secret copied to clipboard';

  @override
  String get stegoDialogTitleBiometric => 'Biometric + Passphrase';

  @override
  String get stegoDialogTitlePassphrase => 'Enter Passphrase';

  @override
  String get stegoDialogMessageBiometric =>
      'Confirm passphrase to authenticate with biometrics and decrypt payload.';

  @override
  String get stegoDialogMessagePassphrase =>
      'Enter the passphrase used to encrypt the secret payload.';

  @override
  String get stegoUnlockButton => 'Unlock';

  @override
  String get safetyCheckInProgress => 'Security Check In Progress';

  @override
  String get safetyAnalysisTitle => 'URL Security Analysis';

  @override
  String get safetyAnalyzing => 'Analyzing URL security...';

  @override
  String safetyIssuesDetected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count security issues detected',
      one: '1 security issue detected',
    );
    return '$_temp0';
  }

  @override
  String get safetyNoIssues => 'No issues detected';

  @override
  String get safetyTrustSourceHint =>
      'Only open this URL if you trust the source';

  @override
  String get safetyResultsHeading => 'Security Analysis Results:';

  @override
  String get probingBannerActive =>
      'Active online checks are ON: SSL, redirect and shortener checks contacted this site directly, exposing your IP address to it. Turn off \"Active online checks\" in Settings to check links privately.';

  @override
  String get probingBannerPrivate =>
      'Private mode: this link was analysed using local rules and Google Safe Browsing only — the site itself was never contacted, so your IP and device were not exposed. Enable \"Active online checks\" in Settings for live SSL/redirect verification.';

  @override
  String get warningDialogTitle => 'Security Warning';

  @override
  String get warningDialogMessage =>
      'This URL has security issues. Opening it may put your device or data at risk.\n\nAre you sure you want to proceed?';

  @override
  String get cautionDialogTitle => 'Caution';

  @override
  String get cautionDialogMessage =>
      'Always verify the source before opening URLs from QR codes.\n\nDo you want to open this URL?';

  @override
  String get overlayLaserLine => 'Laser Line';

  @override
  String get overlayPulsingCorners => 'Pulsing Corners';

  @override
  String get overlayCyberneticGrid => 'Cybernetic Grid';

  @override
  String get overlaySubtleDotMatrix => 'Subtle Dot Matrix';

  @override
  String get overlayLaserLineDesc =>
      'Scanning box with an animated vertical laser beam and glow line';

  @override
  String get overlayPulsingCornersDesc =>
      'Breathing corner reticles with color glow and scale animation';

  @override
  String get overlayCyberneticGridDesc =>
      'Sci-fi grid overlay pattern with target crosshair reticle';

  @override
  String get overlaySubtleDotMatrixDesc =>
      'Minimalist corner dot matrix pattern with pulsing accents';

  @override
  String get themeSystemDefault => 'System Default';

  @override
  String get themeLight => 'Light Theme';

  @override
  String get themeDark => 'Dark Theme';

  @override
  String get themeOled => 'OLED Pure Black';

  @override
  String get themeModeHeading => 'Theme Mode';

  @override
  String get themeChipSystem => 'System';

  @override
  String get themeChipLight => 'Light';

  @override
  String get themeChipDark => 'Dark';

  @override
  String get themeChipOled => 'OLED';

  @override
  String get themeDynamicColorsTitle => 'Material You Dynamic Colors';

  @override
  String get themeDynamicColorsSubtitle =>
      'Sample system wallpaper colors on Android 12+ (Monet engine)';

  @override
  String get themeDescSystem => 'Follow System Settings';

  @override
  String get themeDescLight => 'Standard Light Mode';

  @override
  String get themeDescDark => 'Standard Dark Mode';

  @override
  String get themeDescOled => 'True OLED Pure Black (Battery Saving)';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsFeedbackTitle => 'Scan Feedback & Alerts';

  @override
  String get settingsPrivacyTitle => 'Privacy & Online Probing';

  @override
  String get settingsSafeBrowsingTitle => 'Google Safe Browsing API';

  @override
  String get settingsPermissionsTitle => 'Permissions';

  @override
  String get settingsPermissionsSubtitle =>
      'Explicit, implicit & setting-dependent details';

  @override
  String get settingsHelpTitle => 'Help & Feature Guides';

  @override
  String get settingsHelpSubtitle =>
      'AR CodeVision, AirQR, Quishing Guard & URL Safety';

  @override
  String get settingsAboutSubtitle =>
      'App version, developer & license details';

  @override
  String get feedbackVibrationTitle => 'Vibration Feedback';

  @override
  String get feedbackVibrationSubtitle =>
      'Vibrate phone upon successful barcode recognition';

  @override
  String get feedbackSoundTitle => 'Audible Beep Sound';

  @override
  String get feedbackSoundSubtitle =>
      'Play audio beep signal upon successful code recognition';

  @override
  String get feedbackAnimationTitle => 'Confirmation Animation';

  @override
  String get feedbackAnimationSubtitle =>
      'Play reticle pulse and checkmark morph upon successful scan';

  @override
  String get privacyScreenTitle => 'Privacy & Network Probing';

  @override
  String get privacyActiveChecksTitle => 'Active online checks';

  @override
  String get privacySummaryOn => 'Active online checks enabled';

  @override
  String get privacySummaryOff => 'Private offline checks only';

  @override
  String get apiKeyConfigured => 'Configured';

  @override
  String get apiKeyNotConfigured => 'Not configured';

  @override
  String get apiKeySaved => 'API key saved securely';

  @override
  String get apiKeyDeleted => 'API key deleted';

  @override
  String get apiKeyDeleteTitle => 'Delete API Key';

  @override
  String get deleteButton => 'Delete';

  @override
  String get apiAboutHeading => 'About Safe Browsing API';

  @override
  String get apiKeyConfiguredTitle => 'API Key Configured';

  @override
  String get apiKeyConfiguredSubtitle => 'Malicious URL checking is enabled';

  @override
  String get apiLimitReached => 'Daily limit reached. Resets tomorrow.';

  @override
  String get apiLimitApproaching => 'Approaching daily limit';

  @override
  String get apiKeyFieldLabel => 'API Key';

  @override
  String get apiKeyFieldHint => 'Enter your Google Safe Browsing API key';

  @override
  String get apiKeyRequired => 'Please enter an API key';

  @override
  String get apiKeyTooShort => 'API key appears to be too short';

  @override
  String get apiKeySaveButton => 'Save API Key';

  @override
  String get apiHowToHeading => 'How to get an API key';

  @override
  String get apiStep1Title => 'Go to Google Cloud Console';

  @override
  String get apiStep1Desc => 'Visit console.cloud.google.com';

  @override
  String get apiStep2Title => 'Create or select a project';

  @override
  String get apiStep2Desc => 'Choose an existing project or create a new one';

  @override
  String get apiStep3Title => 'Enable Safe Browsing API';

  @override
  String get apiStep4Title => 'Create credentials';

  @override
  String get apiStep4Desc => 'Go to Credentials → Create Credentials → API Key';

  @override
  String get apiStep5Title => 'Copy and paste';

  @override
  String get apiStep5Desc => 'Copy the generated API key and paste it above';

  @override
  String get apiFreeTierNote => 'Free tier includes 10,000 requests per day';

  @override
  String get permissionsScreenTitle => 'Permissions Overview';

  @override
  String get permissionsExplicitHeading =>
      'Explicit Permissions (Runtime / Manifest)';

  @override
  String get permissionCameraTitle =>
      'Camera Access (android.permission.CAMERA)';

  @override
  String get permissionCameraDesc =>
      'Requested on-demand at point of use. Required for live scanning, AR CodeVision HUD overlay, and AirQR optical stream decoding.';

  @override
  String get permissionBiometricTitle =>
      'Biometric Authentication (android.permission.USE_BIOMETRIC)';

  @override
  String get permissionBiometricDesc =>
      'Requested when unlocking biometric secure vaults or encrypted QR code payloads.';

  @override
  String get permissionsImplicitHeading => 'Implicit & System Permissions';

  @override
  String get permissionInternetTitle =>
      'Internet Access (android.permission.INTERNET)';

  @override
  String get permissionInternetDesc =>
      'Declared in Android Manifest. Used only when Active Online Probing or Google Safe Browsing API lookup is enabled.';

  @override
  String get permissionVibrateTitle =>
      'Vibration & Haptics (android.permission.VIBRATE)';

  @override
  String get permissionVibrateDesc =>
      'System permission. Triggers haptic vibration feedback during scan alerts and button taps.';

  @override
  String get permissionPhotoPickerTitle => 'Scoped Media Photo Picker';

  @override
  String get permissionPhotoPickerDesc =>
      'System photo picker access. Allows selecting QR images or videos from gallery without requesting full storage access.';

  @override
  String get permissionsSettingHeading => 'Setting-Dependent Permissions';

  @override
  String get permissionProbingTitle =>
      'Active Online Probing (Privacy Setting)';

  @override
  String get permissionProbingDesc =>
      'Active only when enabled. Performs outbound HTTP HEAD requests to follow URL redirects and check SSL certificates. When disabled, checks are 100% offline.';

  @override
  String get permissionSafeBrowsingTitle =>
      'Google Safe Browsing API (API Key Setting)';

  @override
  String get permissionSafeBrowsingDesc =>
      'Active only when API key is configured. Queries Google Threat API for malware & phishing checks.';

  @override
  String get permissionFeedbackTitle =>
      'Scan Feedback Vibrations (Alert Setting)';

  @override
  String get permissionFeedbackDesc =>
      'Active only when Vibration is enabled in Scan Feedback & Alerts settings.';

  @override
  String get onLabel => 'On';

  @override
  String get offLabel => 'Off';

  @override
  String get unknownLabel => 'Unknown';

  @override
  String get privacyActiveChecksSubtitle =>
      'Off: scanned links are checked privately — the destination server is never contacted.';

  @override
  String get privacyExplainerOn =>
      'When on, the SSL, redirect and shortener checks connect directly to the scanned site. This exposes your IP address (and therefore your approximate location and mobile carrier) to that server before you open the link.';

  @override
  String get privacyExplainerOff =>
      'SSL, redirect and shortener checks run from local rules only. Malicious-content lookup still uses Google Safe Browsing (the link is sent only to Google, never to the scanned site).';

  @override
  String get apiKeyDeleteMessage =>
      'Are you sure you want to delete your Google Safe Browsing API key? URL malicious content checking will be disabled.';

  @override
  String get apiAboutBody =>
      'The Google Safe Browsing API helps detect malicious URLs including phishing, malware, and unwanted software. Your API key is stored securely and encrypted on your device.';

  @override
  String get apiTodaysUsage => 'Today\'s Usage';

  @override
  String get apiStep3Desc => 'Search for \"Safe Browsing API\" and enable it';

  @override
  String feedbackSummary(String vibration, String sound) {
    return 'Vibration: $vibration • Sound: $sound';
  }

  @override
  String settingsApiKeySubtitle(String status) {
    return 'API Key: $status';
  }

  @override
  String apiKeySaveFailed(String error) {
    return 'Error saving API key: $error';
  }

  @override
  String apiKeyDeleteFailed(String error) {
    return 'Error deleting API key: $error';
  }

  @override
  String apiDailyLimit(int count) {
    return 'Daily Limit: $count requests per day';
  }

  @override
  String apiResets(String date) {
    return 'Resets: $date';
  }

  @override
  String get resultTypeTextFallback => 'TEXT';

  @override
  String get checkNameHttps => 'HTTPS Connection';

  @override
  String get checkNameSsl => 'SSL/TLS Certificate';

  @override
  String get checkNameRedirect => 'Redirect Analysis';

  @override
  String get checkNamePattern => 'Pattern Detection';

  @override
  String get checkNameShortener => 'URL Shortener Check';

  @override
  String get checkNameHomograph => 'Homograph Attack Check';

  @override
  String get checkNameMalicious => 'Malicious Content Check';

  @override
  String get httpsNotUsed => 'URL uses unencrypted HTTP connection';

  @override
  String get sslPrivateModeOk =>
      'Uses HTTPS (live certificate not checked in private mode)';

  @override
  String get sslValid => 'Valid SSL certificate';

  @override
  String get sslExpired => 'SSL certificate has expired';

  @override
  String get sslNotYetValid => 'SSL certificate not yet valid';

  @override
  String get sslUnverifiable => 'Unable to verify certificate';

  @override
  String get sslCheckFailed => 'Certificate check failed';

  @override
  String get redirectSkippedPrivate =>
      'Skipped in private mode (destination server not contacted)';

  @override
  String get redirectLoop => 'Redirect loop detected';

  @override
  String get redirectNone => 'No redirects detected';

  @override
  String get redirectUnavailable => 'Unable to check redirects';

  @override
  String get patternNone => 'No suspicious patterns found';

  @override
  String get patternUnavailable => 'Unable to analyze patterns';

  @override
  String get shortenerOfflineHeuristics =>
      'Unable to perform full check (offline) - heuristics only';

  @override
  String get shortenerNone => 'No URL shortener detected';

  @override
  String get shortenerUnavailable => 'Unable to check for shorteners';

  @override
  String get homographMixedScripts => 'Mixed character scripts detected';

  @override
  String get homographNone => 'No lookalike characters detected';

  @override
  String get homographUnavailable => 'Unable to check for homographs';

  @override
  String get maliciousSkippedNoKey => 'Skipped (API key not configured)';

  @override
  String get maliciousDailyLimit => 'Daily API limit reached (resets tomorrow)';

  @override
  String get maliciousNone => 'No known threats detected';

  @override
  String get maliciousInvalidKey => 'Invalid API key or request';

  @override
  String get maliciousRateLimited => 'Rate limit exceeded';

  @override
  String get maliciousUnavailable => 'Unable to check for malicious content';

  @override
  String get stegoWrongPassphrase =>
      'Decryption failed. Invalid passphrase or corrupted data.';

  @override
  String get airQrChecksumFailed =>
      'Checksum verification failed during reassembly.';

  @override
  String redirectSuspiciousChain(String count) {
    return 'Suspicious redirect chain ($count redirects)';
  }

  @override
  String redirectWithinRange(String count) {
    return '$count redirect(s) - within normal range';
  }

  @override
  String patternDetected(String patterns) {
    return 'Detected: $patterns';
  }

  @override
  String shortenerKnown(String shortener) {
    return 'Known URL shortener detected ($shortener)';
  }

  @override
  String shortenerRedirect(String host) {
    return 'Detected URL shortener (redirects to $host)';
  }

  @override
  String homographLookalikes(String characters) {
    return 'Lookalike characters detected: $characters';
  }

  @override
  String maliciousThreats(String threats) {
    return 'Threats detected: $threats';
  }

  @override
  String maliciousApiError(String status) {
    return 'API error (status: $status)';
  }

  @override
  String get checkNameVirusTotal => 'VirusTotal';

  @override
  String get virusTotalSkippedNoKey => 'Skipped (API key not configured)';

  @override
  String get virusTotalDailyLimit =>
      'Daily limit reached (500/day — resets tomorrow)';

  @override
  String virusTotalThreats(String engines) {
    return 'Threats detected by $engines engine(s)';
  }

  @override
  String get virusTotalNone => 'No threats detected (VirusTotal)';

  @override
  String get virusTotalInvalidKey => 'Invalid API key or request (VirusTotal)';

  @override
  String get virusTotalRateLimited => 'Rate limit exceeded (VirusTotal)';

  @override
  String virusTotalApiError(String status) {
    return 'API error (status: $status)';
  }

  @override
  String get virusTotalUnavailable => 'Unable to check (VirusTotal)';

  @override
  String get checkNameUrlhaus => 'URLhaus';

  @override
  String get urlhausSkippedNoKey => 'Skipped (API key not configured)';

  @override
  String urlhausMalware(String tags) {
    return 'Malware URL detected: $tags';
  }

  @override
  String get urlhausClean => 'No known malware hosting (URLhaus)';

  @override
  String get urlhausNotFound => 'Not in URLhaus database';

  @override
  String get urlhausInvalidKey => 'Invalid API key (URLhaus)';

  @override
  String urlhausApiError(String status) {
    return 'API error (status: $status)';
  }

  @override
  String get urlhausUnavailable => 'Unable to check (URLhaus)';

  @override
  String get checkNamePhishTank => 'PhishTank';

  @override
  String get phishTankSkippedDisabled => 'Skipped (PhishTank disabled)';

  @override
  String get phishTankPhishing => 'Known phishing site (PhishTank)';

  @override
  String get phishTankClean => 'Not a known phishing site (PhishTank)';

  @override
  String get phishTankNotInDatabase => 'Not in PhishTank database';

  @override
  String phishTankApiError(String status) {
    return 'API error (status: $status)';
  }

  @override
  String get phishTankUnavailable => 'Unable to check (PhishTank)';

  @override
  String get checkNameOpenPhish => 'OpenPhish';

  @override
  String get openPhishSkippedDisabled => 'Skipped (OpenPhish disabled)';

  @override
  String get openPhishPhishing => 'Known phishing site (OpenPhish)';

  @override
  String get openPhishClean => 'Not in phishing feed (OpenPhish)';

  @override
  String get openPhishFeedStale => 'Feed unavailable — offline check skipped';

  @override
  String get openPhishUnavailable => 'Unable to check (OpenPhish)';

  @override
  String get settingsUrlSafetyProvidersTitle => 'URL Safety Providers';

  @override
  String settingsUrlSafetyProvidersSubtitle(String count) {
    return '$count provider(s) active';
  }

  @override
  String get urlSafetyProvidersHelpText =>
      'Configure optional online URL safety checks. Each provider is independent. Non-commercial providers require your own free account and API key.';

  @override
  String get urlSafetyUserSuppliedHeader => 'Your API Keys';

  @override
  String get urlSafetyUserSuppliedNote => 'Non-commercial use only';

  @override
  String get urlSafetyBuiltInHeader => 'Built-In Providers';

  @override
  String get urlSafetyBuiltInNote => 'No account needed — just toggle on';

  @override
  String get providerEndpointLabel => 'API Endpoint URL';

  @override
  String get providerApiKeyHint => 'Paste your API key';

  @override
  String get providerGetKeyAt => 'Get a free key at:';

  @override
  String providerDailyUsage(String used, String max) {
    return '$used / $max requests today';
  }

  @override
  String openPhishLastUpdated(String datetime) {
    return 'Last updated: $datetime';
  }

  @override
  String get openPhishRefreshNow => 'Refresh feed now';

  @override
  String openPhishFeedRefreshed(String count) {
    return 'Feed updated ($count URLs)';
  }

  @override
  String get openPhishFeedFailed => 'Feed refresh failed';

  @override
  String get phishTankToggleLabel => 'Enable PhishTank';

  @override
  String get openPhishToggleLabel => 'Enable OpenPhish feed';

  @override
  String get quishingSummaryAuthentic =>
      'Authentic Printed Code. No physical tampering detected.';

  @override
  String get quishingSummaryWearAndTear =>
      'Wear & Tear Detected. Slight physical surface noise observed.';

  @override
  String get quishingSummaryHighWarning =>
      'High Warning: Physical Overlay Sticker Detected! Verify Before Tapping Links.';

  @override
  String get quishingStatusAuthentic => '🟢 Authentic Printed Code';

  @override
  String get quishingStatusWearAndTear => '🟡 Wear & Tear Detected';

  @override
  String get quishingStatusHighWarning =>
      '🔴 High Warning: Physical Overlay Sticker Detected!';

  @override
  String get quishingSignalMicroShadowPerimeter =>
      'Micro-shadow depth step line detected along matrix perimeter';

  @override
  String get quishingSignalGrainAberration =>
      'Mismatching inkjet/thermal grain chromatic aberration detected';

  @override
  String get quishingSignalUniformReflection =>
      'Uniform substrate reflection profile verified';

  @override
  String get quishingSignalConsistentDotsQrMatrix =>
      'Consistent halftone dot density across QR matrix perimeter';

  @override
  String get quishingSignalReflectionVerified =>
      'Substrate reflection profile verified';

  @override
  String get quishingSignalHalftoneConsistentQrMatrix =>
      'Halftone dot density consistent across QR matrix perimeter';

  @override
  String get quishingSignalHalftoneConsistentMatrix =>
      'Halftone dot density consistent across matrix';

  @override
  String get quishingSignalDoubleEdgeAroundMatrix =>
      'Perimeter double-edge reflection detected around QR matrix';

  @override
  String get quishingSignalMicroShadowStickerBorder =>
      'Micro-shadow depth step line detected along sticker border';

  @override
  String get quishingSignalGrainMismatchBase =>
      'Inkjet/thermal print grain mismatching base substrate';

  @override
  String get quishingSignalMinorScratch =>
      'Minor surface scratch or wear pattern observed';

  @override
  String get quishingSignalSlightDotIrregularity =>
      'Slight dot density irregularity along edges';

  @override
  String get quishingSignalConsistentDotsMatrixPerimeter =>
      'Consistent halftone dot density across matrix perimeter';

  @override
  String quishingSignalPerimeterDoubleEdge(String zones) {
    return 'Perimeter double-edge reflection detected ($zones boundary zones)';
  }

  @override
  String quishingSignalDotDensityVariance(String variance) {
    return 'Substrate halftone dot density inconsistency detected ($variance% variance)';
  }

  @override
  String get domSslInvalidScheme => 'Invalid URL scheme';

  @override
  String get domSslHttps => 'Uses encrypted HTTPS protocol';

  @override
  String get domSslHttp => 'Unencrypted HTTP connection (High Risk)';

  @override
  String get domStatusInvalidUrl => 'Invalid or unsupported web URL format.';

  @override
  String get domStatusHttpCaution => '⚠️ Caution: Unencrypted HTTP site';

  @override
  String get domStatusSafe =>
      '✅ Zero-Trust DOM Sandbox: HTML preview sanitized safely.';

  @override
  String domStatusOpenRedirect(String target) {
    return '⚠️ Warning: Open Redirect Trap detected pointing to $target';
  }

  @override
  String domStatusNewDomain(String days) {
    return '⚠️ Warning: Newly registered domain ($days days old)';
  }

  @override
  String get stegoPassphraseEmpty => 'Passphrase cannot be empty';

  @override
  String get stegoBiometricReason =>
      'Authenticate to view StegoQR secret payload';

  @override
  String get mediaNoCodeInImage => 'No barcodes or QR codes detected in image.';

  @override
  String get mediaNoCodeInPdf =>
      'No barcodes or QR codes found in PDF document.';

  @override
  String mediaImagePickFailed(String error) {
    return 'Failed to pick or scan image: $error';
  }

  @override
  String mediaImageAnalyzeFailed(String error) {
    return 'Error analyzing image: $error';
  }

  @override
  String mediaPdfPickFailed(String error) {
    return 'Failed to pick or parse PDF: $error';
  }

  @override
  String mediaPdfScanFailed(String error) {
    return 'Failed to scan PDF document: $error';
  }

  @override
  String get stegoBiometricCanceled =>
      'Biometric authentication canceled or failed.';

  @override
  String get formatQrUrl => 'QR (URL)';

  @override
  String get formatQrEmail => 'QR (Email)';

  @override
  String get formatQrPhone => 'QR (Phone)';

  @override
  String get formatQrSms => 'QR (SMS)';

  @override
  String get formatQrWifi => 'QR (Wi-Fi)';

  @override
  String get formatQrLocation => 'QR (Location)';

  @override
  String get formatQrContact => 'QR (Contact)';

  @override
  String get formatIsbn => 'ISBN';

  @override
  String get formatEanUpc => 'EAN/UPC';

  @override
  String get formatQrCode => 'QR Code';

  @override
  String get formatEanUpcProduct => 'EAN/UPC Product';

  @override
  String get formatBarcode => 'Barcode';

  @override
  String get wifiHiddenNetwork => 'Hidden Network';

  @override
  String get totpDefaultAccount => 'Account';

  @override
  String get backupInvalidFormat => 'Invalid backup file format.';

  @override
  String get backupBadHeader => 'Unrecognized or corrupted backup file header.';

  @override
  String get backupWrongPassphrase =>
      'Incorrect passphrase or corrupted backup payload.';

  @override
  String get reportHeading => 'SREERAJP QR STUDIO - SCAN HISTORY';

  @override
  String get reportTitle => 'Scan History Export';

  @override
  String get reportExportDate => 'Export Date';

  @override
  String get reportTotalScans => 'Total Scans';

  @override
  String get reportScanNumber => 'Scan #';

  @override
  String get reportId => 'ID           ';

  @override
  String get reportTimestamp => 'Timestamp    ';

  @override
  String get reportFormat => 'Format       ';

  @override
  String get reportCategory => 'Category     ';

  @override
  String get reportSafetyScore => 'Safety Score ';

  @override
  String get reportStarred => 'Starred      ';

  @override
  String get reportStarredYes => '⭐ Yes';

  @override
  String get reportStarredNo => 'No';

  @override
  String get reportLocation => 'Location     ';

  @override
  String get reportNotes => 'Notes        ';

  @override
  String get reportContent => 'Content      ';

  @override
  String get reportColumnDateTime => 'Date & Time';

  @override
  String get reportColumnFormat => 'Format';

  @override
  String get reportColumnCategory => 'Category';

  @override
  String get reportColumnSafety => 'Safety';

  @override
  String get reportColumnContent => 'Content Snippet';

  @override
  String get reportColumnNotes => 'Notes';

  @override
  String get patternIpAddress => 'IP Address';

  @override
  String get patternLongNumbers => 'Long Number Sequence';

  @override
  String get patternManyDashes => 'Multiple Dashes/Underscores';

  @override
  String get patternPhishingKeywords => 'Phishing Keywords';

  @override
  String get patternDataUri => 'Data URI';

  @override
  String get patternManySubdomains => 'Multiple Subdomains';

  @override
  String get shortenerPossibleShortDomain =>
      'Possible URL shortener: short domain with minimal path';

  @override
  String get shortenerPossibleRandomPath =>
      'Possible URL shortener: random character pattern in short path';

  @override
  String shortenerPossibleTld(String tld) {
    return 'Possible URL shortener: short domain with common shortener ending ($tld)';
  }

  @override
  String get settingsFeaturesTitle => 'Features';

  @override
  String get settingsFeaturesSubtitle =>
      'Explore all features of SreerajP QR Studio';

  @override
  String get appearanceHubTitle => 'Appearance';

  @override
  String get appearanceThemeModeCardTitle => 'Theme Mode';

  @override
  String get appearanceThemeModeCardSubtitle =>
      'Choose between System, Light, Dark, or OLED mode';

  @override
  String get appearanceOverlayCardTitle => 'Scan Overlay Style';

  @override
  String get appearanceOverlayCardSubtitle =>
      'Laser line, pulsing corners, cybernetic grid, or dot matrix';

  @override
  String get appearanceAccentCardTitle => 'Accent Color & Dynamic Colors';

  @override
  String get appearanceAccentCardSubtitle =>
      'Material You dynamic color and custom accent palettes';

  @override
  String get appearanceTypographyCardTitle => 'Typography & Text Size';

  @override
  String get appearanceTypographyCardSubtitle =>
      'App font family and text scale preferences';

  @override
  String get featuresHeaderTitle => 'SreerajP QR Studio Features';

  @override
  String get featuresHeaderSubtitle =>
      'Explore every intelligent scanning tool, 6-layer URL safety engine, AR CodeVision, and offline feature designed for you.';

  @override
  String get featuresCatScanningName => 'Core Scanning & Ingestion';

  @override
  String get featuresCatScanningSubtitle =>
      'Lightning-fast 1D/2D barcode engine with multi-source media support';

  @override
  String get featuresCatSafetyName => '6-Layer URL Safety & Forensic Engine';

  @override
  String get featuresCatSafetySubtitle =>
      'Zero-trust forensic analysis defending you against malicious QR phishing & scams';

  @override
  String get featuresCatVisionName => 'QuishingGuard™ & Advanced AI Vision';

  @override
  String get featuresCatVisionSubtitle =>
      'Cutting-edge on-device computer vision and optical air-gap data streaming';

  @override
  String get featuresCatPayloadsName => 'Smart Payloads & 1-Tap Integrations';

  @override
  String get featuresCatPayloadsSubtitle =>
      'Instant parsing and contextual native actions for everyday barcodes';

  @override
  String get featuresCatHistoryName => 'History, Backup & Privacy Vault';

  @override
  String get featuresCatHistorySubtitle =>
      'Your personal scan history protected by biometric security and offline storage';

  @override
  String get featureBarcodeEngineTitle => 'Multi-Format Barcode Engine';

  @override
  String get featureBarcodeEngineDesc =>
      'Instantly decodes 1D barcodes (EAN-13, UPC-A, Code 128, Code 39, Codabar, ITF) and 2D codes (QR, Data Matrix, Aztec, PDF417) in milliseconds.';

  @override
  String get featureBarcodeEngineChip1 => 'QR & Data Matrix';

  @override
  String get featureBarcodeEngineChip2 => 'Aztec & PDF417';

  @override
  String get featureBarcodeEngineChip3 => 'EAN & Code 128';

  @override
  String get featureMediaSourcesTitle => 'Multi-Source Media & PDF Ingestion';

  @override
  String get featureMediaSourcesDesc =>
      'Scan barcodes from live camera feed, select existing images from your gallery, or extract and parse barcodes across multi-page PDF documents.';

  @override
  String get featureMediaSourcesChip1 => 'Gallery Photos';

  @override
  String get featureMediaSourcesChip2 => 'Multi-Page PDF';

  @override
  String get featureMediaSourcesChip3 => 'Live Viewport';

  @override
  String get featureGhostScanTitle => 'GhostScan Screen Content Detector';

  @override
  String get featureGhostScanDesc =>
      'Detects and decodes QR codes visible on your screen inside messaging apps, social feeds, and web browsers via Quick Settings tile, the floating Scan bubble, or on-demand trigger without saving screenshots.';

  @override
  String get featureGhostScanChip1 => 'Quick Settings Tile';

  @override
  String get featureGhostScanChip2 => 'Floating Scan Bubble';

  @override
  String get featureGhostScanChip3 => 'No Screenshots Saved';

  @override
  String get featureCameraControlsTitle => 'Precision Camera Controls';

  @override
  String get featureCameraControlsDesc =>
      'Smooth zoom slider, torch flashlight toggle, front and rear camera switching, and continuous autofocus for low-light scanning.';

  @override
  String get featureCameraControlsChip1 => 'Flashlight Torch';

  @override
  String get featureCameraControlsChip2 => 'Zoom Control';

  @override
  String get featureCameraControlsChip3 => 'Front/Back Flip';

  @override
  String get featureScanOverlaysTitle => 'Customizable Scan Overlays';

  @override
  String get featureScanOverlaysDesc =>
      'Choose between Laser Line, Pulsing Corners, Cybernetic Grid, or Subtle Dot Matrix viewfinder overlays with live feedback.';

  @override
  String get featureScanOverlaysChip1 => '4 Overlay Styles';

  @override
  String get featureScanOverlaysChip2 => 'Live Animation';

  @override
  String get featureScanOverlaysChip3 => 'OLED Compatible';

  @override
  String get featureFeedbackTitle => 'Tactile Haptic & Audio Feedback';

  @override
  String get featureFeedbackDesc =>
      'Customizable vibration pulses and audible beep tones confirm successful recognition even in noisy environments.';

  @override
  String get featureFeedbackChip1 => 'Haptic Pulse';

  @override
  String get featureFeedbackChip2 => 'Audio Beep';

  @override
  String get featureFeedbackChip3 => 'Independent Toggles';

  @override
  String get featureProtocolGuardTitle => 'Protocol & Syntax Guard (Layer 1)';

  @override
  String get featureProtocolGuardDesc =>
      'Validates scheme authenticity, checks for encrypted HTTPS connections, and flags plain HTTP or unsupported schemes.';

  @override
  String get featureProtocolGuardChip1 => 'HTTPS Validation';

  @override
  String get featureProtocolGuardChip2 => 'Scheme Checking';

  @override
  String get featureProtocolGuardChip3 => 'Zero-Width Char Trap';

  @override
  String get featureHomographShieldTitle =>
      'Homograph & Unicode Shield (Layer 2)';

  @override
  String get featureHomographShieldDesc =>
      'Detects lookalike Cyrillic, Greek, and Unicode spoofing characters used to disguise fraudulent domain names (IDN punycode defense).';

  @override
  String get featureHomographShieldChip1 => 'Punycode Defense';

  @override
  String get featureHomographShieldChip2 => 'Cyrillic Lookalikes';

  @override
  String get featureHomographShieldChip3 => 'Mixed-Script Trap';

  @override
  String get featureTldEntropyTitle =>
      'Suspicious TLD & Entropy Analysis (Layer 3)';

  @override
  String get featureTldEntropyDesc =>
      'Flags high-risk top-level domains, excessive subdomains, and evaluates domain name character entropy to catch algorithmic domains.';

  @override
  String get featureTldEntropyChip1 => 'High-Risk TLDs';

  @override
  String get featureTldEntropyChip2 => 'Entropy Scoring';

  @override
  String get featureTldEntropyChip3 => 'Subdomain Depth';

  @override
  String get featureIpPortTitle => 'Heuristic IP & Port Flagging (Layer 4)';

  @override
  String get featureIpPortDesc =>
      'Flags links pointing directly to raw IP addresses or non-standard HTTP/HTTPS network ports designed to bypass firewalls.';

  @override
  String get featureIpPortChip1 => 'Raw IP Traps';

  @override
  String get featureIpPortChip2 => 'Non-Standard Ports';

  @override
  String get featureIpPortChip3 => 'Embedded Userinfo';

  @override
  String get featureHeadProbeTitle =>
      'Privacy-Safe Online Head Probing (Layer 5)';

  @override
  String get featureHeadProbeDesc =>
      'Optional opt-in lightweight HTTP HEAD probing to resolve URL shorteners, uncover hidden redirect chains, and verify TLS certificates.';

  @override
  String get featureHeadProbeChip1 => 'Redirect Chains';

  @override
  String get featureHeadProbeChip2 => 'Shortener Unrolling';

  @override
  String get featureHeadProbeChip3 => 'Opt-In Privacy';

  @override
  String get featureSafeBrowsingTitle => 'Google Safe Browsing API (Layer 6)';

  @override
  String get featureSafeBrowsingDesc =>
      'Optional cloud threat intelligence against millions of known malicious URLs, malware distribution hubs, and social engineering sites.';

  @override
  String get featureSafeBrowsingChip1 => 'Google Threat DB';

  @override
  String get featureSafeBrowsingChip2 => 'Local Key Storage';

  @override
  String get featureSafeBrowsingChip3 => 'Daily Quota Meter';

  @override
  String get featureQuishingGuardTitle =>
      'QuishingGuard™ Physical Tamper Detection';

  @override
  String get featureQuishingGuardDesc =>
      'Forensic computer vision pipeline detecting physical QR sticker overlays, edge discontinuities, micro-shadows, and chromatic halftone print grain.';

  @override
  String get featureQuishingGuardChip1 => 'Sticker Overlays';

  @override
  String get featureQuishingGuardChip2 => 'Edge Discontinuity';

  @override
  String get featureQuishingGuardChip3 => 'Print Grain Analysis';

  @override
  String get featureArCodeVisionTitle => 'AR CodeVision™ Spatial HUD';

  @override
  String get featureArCodeVisionDesc =>
      'Augmented Reality multi-barcode scanner displaying floating interactive chips over all detected codes with live safety badges and batch selection.';

  @override
  String get featureArCodeVisionChip1 => 'Spatial Tracking';

  @override
  String get featureArCodeVisionChip2 => 'Multi-Code HUD';

  @override
  String get featureArCodeVisionChip3 => 'Batch Select';

  @override
  String get featureAirQrTitle => 'AirQR™ Optical Air-Gap Data Stream';

  @override
  String get featureAirQrDesc =>
      'High-speed animated strobe QR transmitter & receiver pipeline transferring encrypted text, files, and keys completely offline without Wi-Fi or Bluetooth.';

  @override
  String get featureAirQrChip1 => 'Animated Strobe QR';

  @override
  String get featureAirQrChip2 => 'Reed-Solomon FEC';

  @override
  String get featureAirQrChip3 => '100% Offline Air-Gap';

  @override
  String get featureStegoQrTitle => 'StegoQR™ Steganographic Scanner';

  @override
  String get featureStegoQrDesc =>
      'Discovers and extracts hidden encrypted payloads and watermarked data layers invisibly embedded within custom QR codes.';

  @override
  String get featureStegoQrChip1 => 'Decoy QR Parsing';

  @override
  String get featureStegoQrChip2 => 'AES Decryption';

  @override
  String get featureStegoQrChip3 => 'Biometric Auth';

  @override
  String get featureWifiTitle => 'Wi-Fi Instant Auto Connect';

  @override
  String get featureWifiDesc =>
      'Parses WPA/WPA2/WPA3 network credentials, displays network info, copies passwords, and opens Wi-Fi settings in 1 tap.';

  @override
  String get featureWifiChip1 => 'WPA3 & WPA2';

  @override
  String get featureWifiChip2 => '1-Tap Connect';

  @override
  String get featureWifiChip3 => 'Password Reveal/Copy';

  @override
  String get featurePaymentsTitle => 'UPI & Global Crypto Payments';

  @override
  String get featurePaymentsDesc =>
      'Parses Indian UPI QR codes (dispatching to GPay, PhonePe, Paytm) and Bitcoin/Ethereum/Solana crypto payment addresses with amount detection.';

  @override
  String get featurePaymentsChip1 => 'UPI App Dispatch';

  @override
  String get featurePaymentsChip2 => 'Crypto Wallets';

  @override
  String get featurePaymentsChip3 => 'SEPA Transfer';

  @override
  String get featureTotpTitle => 'TOTP 2FA Authenticator & Token Generator';

  @override
  String get featureTotpDesc =>
      'Scans 2FA setup codes, renders live rolling 6-digit OTP passcodes with circular countdown timers, and imports into authenticator apps.';

  @override
  String get featureTotpChip1 => 'Live Passcodes';

  @override
  String get featureTotpChip2 => 'Visual Countdown';

  @override
  String get featureTotpChip3 => 'App Importer';

  @override
  String get featureContactsTitle => 'Contacts & vCard Importer';

  @override
  String get featureContactsDesc =>
      'Parses vCard 2.1/3.0/4.0 and MeCard contact barcodes with 1-tap phone dialing, email composition, and saving to your address book.';

  @override
  String get featureContactsChip1 => 'vCard 4.0';

  @override
  String get featureContactsChip2 => '1-Tap Save';

  @override
  String get featureContactsChip3 => 'Direct Call & Email';

  @override
  String get featureCalendarTitle => 'Calendar Events & Scheduling';

  @override
  String get featureCalendarDesc =>
      'Reads iCalendar VEVENT formats with start/end time ranges, locations, and descriptions, adding them directly to your device calendar.';

  @override
  String get featureCalendarChip1 => 'iCal Parsing';

  @override
  String get featureCalendarChip2 => 'Start/End Time';

  @override
  String get featureCalendarChip3 => 'Device Calendar Add';

  @override
  String get featureGeoTitle => 'Geographic Location & Navigation';

  @override
  String get featureGeoDesc =>
      'Parses geo: coordinates and search queries, offering instant navigation directions via Google Maps.';

  @override
  String get featureGeoChip1 => 'Lat/Long Parsing';

  @override
  String get featureGeoChip2 => 'Google Maps Link';

  @override
  String get featureGeoChip3 => 'Search Queries';

  @override
  String get featureScanHistoryTitle => 'Comprehensive Offline Scan History';

  @override
  String get featureScanHistoryDesc =>
      'Stores every scan locally with payload categorization, safety scores, timestamp tracking, favorite stars, and real-time full-text search.';

  @override
  String get featureScanHistoryChip1 => 'Full-Text Search';

  @override
  String get featureScanHistoryChip2 => 'Category Filtering';

  @override
  String get featureScanHistoryChip3 => 'Favorite Stars';

  @override
  String get featureBackupsTitle => 'Flexible JSON & CSV Backups';

  @override
  String get featureBackupsDesc =>
      'Export your complete scan history to standard CSV spreadsheets or encrypted JSON backup files with one-click restore.';

  @override
  String get featureBackupsChip1 => 'CSV Spreadsheet';

  @override
  String get featureBackupsChip2 => 'JSON Backup';

  @override
  String get featureBackupsChip3 => 'One-Click Restore';

  @override
  String get featureBiometricGuardTitle => 'Biometric & Screen Security Guard';

  @override
  String get featureBiometricGuardDesc =>
      'Protects sensitive hidden StegoQR payloads and history with fingerprint/face authentication and blocks screen captures (FLAG_SECURE).';

  @override
  String get featureBiometricGuardChip1 => 'Biometric Prompt';

  @override
  String get featureBiometricGuardChip2 => 'Screenshot Guard';

  @override
  String get featureBiometricGuardChip3 => 'Encrypted Storage';

  @override
  String get featureOfflinePrivacyTitle => '100% Offline-First Privacy';

  @override
  String get featureOfflinePrivacyDesc =>
      'Scans, decodes, and analyzes barcodes completely on your phone without sending any data to external servers by default.';

  @override
  String get featureOfflinePrivacyChip1 => 'No Telemetry';

  @override
  String get featureOfflinePrivacyChip2 => 'Zero Ads';

  @override
  String get featureOfflinePrivacyChip3 => 'Open-Source Safety';

  @override
  String get helpCenterHeaderTitle => 'Help Center & User Guides';

  @override
  String get helpCenterHeaderSubtitle =>
      'Browse in-depth guides, step-by-step instructions, and solutions for all features of SreerajP QR Studio.';

  @override
  String get decryptPayloadAction => 'Decrypt Payload';

  @override
  String get decryptPayloadTitle => 'Decrypt Scanned Content';

  @override
  String get decryptPayloadDescription =>
      'Enter the passphrase or session code to decrypt this ciphertext payload.';

  @override
  String get cipherModeLabel => 'Cipher Mode';

  @override
  String get cipherModeAuto => 'Auto-detect / Standard';

  @override
  String get cipherModeAesGcm => 'AES-256-GCM (PBKDF2 SHA-256)';

  @override
  String get cipherModeAesCbc => 'AES-256-CBC';

  @override
  String get airQrCodeLabel => 'Session Code / Key';

  @override
  String get airQrCodeHint => 'e.g. ABC-DEF';

  @override
  String get airQrDetectedTitle => 'AirQR Encrypted Transfer';

  @override
  String get airQrDetectedSubtitle =>
      'This QR code carries an encrypted optical transfer. Enter the session code shown on the sending device to unlock.';

  @override
  String get jsonEnvelopeDetectedTitle => 'Encrypted JSON Container';

  @override
  String get jsonEnvelopeDetectedSubtitle =>
      'This QR code contains an encrypted JSON container. Enter the passphrase to decrypt.';

  @override
  String get decryptedContentLabel => 'Decrypted Content:';

  @override
  String get manualDecryptionFailed =>
      'Decryption failed. Please verify the passphrase or cipher settings.';

  @override
  String get emailCardTitle => 'Email Address';

  @override
  String get emailSendButton => 'Send Email';

  @override
  String get emailCopyButton => 'Copy';

  @override
  String get emailLaunchFailed =>
      'Could not open email app. Copy the address and open your email app manually.';

  @override
  String get emailSubjectLabel => 'Subject';

  @override
  String get emailBodyLabel => 'Message';

  @override
  String get phoneCardTitle => 'Phone Number';

  @override
  String get phoneCallButton => 'Call';

  @override
  String get phoneCopyButton => 'Copy';

  @override
  String get phoneLaunchFailed =>
      'Could not open the phone dialer. Copy the number and dial manually.';

  @override
  String get smsCardTitle => 'Text Message';

  @override
  String get smsSendButton => 'Send Message';

  @override
  String get smsCopyButton => 'Copy';

  @override
  String get smsLaunchFailed =>
      'Could not open the messaging app. Copy the number and message manually.';

  @override
  String get smsBodyLabel => 'Message';

  @override
  String get appLinkCardTitle => 'App Link';

  @override
  String get appLinkOpenButton => 'Open in App';

  @override
  String get appLinkLaunchFailed =>
      'Could not open this app link. The app may not be installed.';

  @override
  String get productBarcodeCardTitle => 'Product Barcode';

  @override
  String get productSearchFoodButton => 'Food Info';

  @override
  String get productSearchWebButton => 'Search Web';

  @override
  String get productCopyButton => 'Copy Barcode';

  @override
  String get productLaunchFailed =>
      'Could not open product search. Try copying the barcode and searching manually.';

  @override
  String get isbnCardTitle => 'Book (ISBN)';

  @override
  String get isbnGoogleBooksButton => 'Google Books';

  @override
  String get isbnOpenLibraryButton => 'Open Library';

  @override
  String get isbnCopyButton => 'Copy ISBN';

  @override
  String get isbnLaunchFailed =>
      'Could not open book lookup. Try copying the ISBN and searching manually.';

  @override
  String get historyFilterEmail => 'Email';

  @override
  String get historyFilterPhone => 'Phone';

  @override
  String get historyFilterSms => 'SMS';

  @override
  String get historyFilterAppLink => 'App Link';

  @override
  String get historyFilterProductBarcode => 'Product';

  @override
  String get historyFilterIsbn => 'Book';

  @override
  String get scanFlashOff => 'Flash: Off';

  @override
  String get scanFlashOn => 'Flash: On';

  @override
  String get scanFlashAuto => 'Flash: Auto';

  @override
  String scanFlashAutoActive(String lux) {
    return 'Auto Flash Active ($lux lux)';
  }

  @override
  String get scanFlashAutoSensorUnavailable =>
      'Light sensor unavailable on this device';

  @override
  String get cameraTuneTooltip => 'Camera adjustments';

  @override
  String get cameraTuneTitle => 'Camera Adjustments';

  @override
  String get cameraBrightnessLabel => 'Brightness';

  @override
  String get cameraContrastLabel => 'Contrast';

  @override
  String get cameraInvertLabel => 'Invert Colors (Negative Scan)';

  @override
  String get cameraInvertHint =>
      'Optimized for white QR codes on dark screens or metal';

  @override
  String get cameraResolutionLabel => 'Camera Resolution';

  @override
  String get cameraResolutionFullHd => 'Full HD (1080p - Recommended)';

  @override
  String get cameraResolutionMax => 'Maximum (4K UHD)';

  @override
  String get cameraResolutionHd => 'HD (720p - Battery Saver)';

  @override
  String get cameraResetAdjustments => 'Reset Adjustments';

  @override
  String get cameraFocusTapHint => 'Tap to focus & meter light';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsLanguageSubtitle => 'Select application display language';

  @override
  String get languageSystemDefault => 'System default';

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
    return '$percentage% used';
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
  String get tooltipToggleSecretVisibility => 'Toggle secret visibility';

  @override
  String get tooltipResetStream => 'Reset stream';

  @override
  String get tooltipAirQrTransmitter => 'Switch to AirQR Transmitter';

  @override
  String get airQrModeText => 'Custom Text';

  @override
  String get airQrModeSync => 'Device Sync';

  @override
  String airQrSyncIncludeHistory(int count) {
    return 'Include scan history ($count)';
  }

  @override
  String get airQrSyncIncludeSettings => 'Include app settings';

  @override
  String get airQrSyncPassphraseLabel => 'Sync Passphrase / PIN';

  @override
  String get airQrSyncPassphraseHint => 'Enter PIN or passphrase to encrypt';

  @override
  String get airQrSyncGeneratePin => 'Generate PIN';

  @override
  String get airQrSyncBeamButton => 'Beam History & Settings';

  @override
  String get airQrSyncNoDataWarning =>
      'Select at least history or settings to sync.';

  @override
  String get airQrSyncPackageDetected => 'AirQR Encrypted Sync Package';

  @override
  String airQrSyncPackageSummary(int records) {
    return 'Contains $records scan records and app configuration';
  }

  @override
  String get airQrSyncEnterPassphrase => 'Enter Passphrase to Decrypt';

  @override
  String get airQrSyncRestoreHistory => 'Restore scan history';

  @override
  String get airQrSyncApplySettings => 'Apply app settings';

  @override
  String get airQrSyncDecryptButton => 'Decrypt & Sync';

  @override
  String airQrSyncSuccess(int count) {
    return 'Successfully synced $count records and updated settings!';
  }

  @override
  String get airQrSyncBeamAction => 'Beam via AirQR';

  @override
  String get airQrSyncSettingsTitle => 'AirQR Optical Sync';

  @override
  String get airQrSyncSettingsSubtitle =>
      'Beam history & settings air-gapped to another phone';

  @override
  String get tabScan => 'Scan';

  @override
  String get tabCodeForge => 'CodeForge';

  @override
  String get tabHistory => 'History';

  @override
  String get codeForgeTitle => 'CodeForge';

  @override
  String get codeForgeSubtitle => 'Barcode & QR Studio';

  @override
  String get codeForgeBarcodeType => 'Barcode Type';

  @override
  String get codeForgePayloadType => 'Content Type';

  @override
  String get codeForgePresetText => 'Text';

  @override
  String get codeForgeTextHint =>
      'Keep text concise for clear and reliable scanning (up to 500 characters)';

  @override
  String get codeForgeLoadFromFile => 'Read from file';

  @override
  String get codeForgeLoadFromFileTooltip =>
      'Read text from a file into the QR code generator';

  @override
  String get codeForgeFileEmpty => 'The selected file is empty.';

  @override
  String get codeForgeFileTruncated =>
      'Text was trimmed to 500 characters to fit in a single, fast-scanning QR code.';

  @override
  String get codeForgeFileLoaded => 'Text loaded from file successfully.';

  @override
  String get codeForgeFileReadError => 'Unable to read the selected file.';

  @override
  String get codeForgePresetUrl => 'URL / Link';

  @override
  String get codeForgePresetWifi => 'Wi-Fi';

  @override
  String get codeForgePresetContact => 'Contact';

  @override
  String get codeForgePresetUpi => 'UPI Pay';

  @override
  String get codeForgePresetSms => 'SMS';

  @override
  String get codeForgePresetEmail => 'Email';

  @override
  String get codeForgePresetGeo => 'Location';

  @override
  String get codeForgeWifiSsid => 'Network Name (SSID)';

  @override
  String get codeForgeWifiPassword => 'Password';

  @override
  String get codeForgeWifiSecurity => 'Security';

  @override
  String get codeForgeWifiHidden => 'Hidden Network';

  @override
  String get codeForgeContactName => 'Full Name';

  @override
  String get codeForgeContactPhone => 'Phone Number';

  @override
  String get codeForgeContactEmail => 'Email Address';

  @override
  String get codeForgeContactOrg => 'Company / Org';

  @override
  String get codeForgeContactTitle => 'Job Title';

  @override
  String get codeForgeContactUrl => 'Website';

  @override
  String get codeForgeUpiVpa => 'UPI ID / VPA';

  @override
  String get codeForgeUpiName => 'Payee Name';

  @override
  String get codeForgeUpiAmount => 'Amount (INR)';

  @override
  String get codeForgeUpiNote => 'Transaction Note';

  @override
  String get codeForgeSmsPhone => 'Recipient Phone';

  @override
  String get codeForgeSmsMessage => 'Message Body';

  @override
  String get codeForgeEmailTo => 'Recipient Email';

  @override
  String get codeForgeEmailSubject => 'Subject';

  @override
  String get codeForgeEmailBody => 'Email Body';

  @override
  String get codeForgeGeoLat => 'Latitude';

  @override
  String get codeForgeGeoLng => 'Longitude';

  @override
  String get codeForgeGeoUseMyLocation => 'Use My Location';

  @override
  String get codeForgeGeoFetching => 'Getting location…';

  @override
  String get codeForgeGeoFailed => 'Could not get location';

  @override
  String get codeForgeGeoPermissionDenied => 'Location permission denied';

  @override
  String get codeForgeDesignStudio => 'Design & Structure';

  @override
  String get codeForgeEyeShape => 'Corner Eye Shape';

  @override
  String get codeForgeEyeBallShape => 'Inner Eye Pupil';

  @override
  String get codeForgePatternShape => 'Data Module Pattern';

  @override
  String get codeForgeShapeSquare => 'Square';

  @override
  String get codeForgeShapeDots => 'Dots';

  @override
  String get codeForgeShapeRounded => 'Rounded';

  @override
  String get codeForgeShapeClassy => 'Classy';

  @override
  String get codeForgeShapeDiamond => 'Diamond';

  @override
  String get codeForgeShapeLeaf => 'Leaf';

  @override
  String get codeForgeShapeCircle => 'Circle';

  @override
  String get codeForgeColorStudio => 'Colors & Gradients';

  @override
  String get codeForgeFgColor => 'Foreground';

  @override
  String get codeForgeBgColor => 'Background';

  @override
  String get codeForgeEyeOuterColor => 'Eye Outer Ring';

  @override
  String get codeForgeEyeInnerColor => 'Eye Center Ball';

  @override
  String get codeForgeGradientNone => 'Solid Color';

  @override
  String get codeForgeGradientSunset => 'Sunset';

  @override
  String get codeForgeGradientOcean => 'Ocean';

  @override
  String get codeForgeGradientNeon => 'Neon';

  @override
  String get codeForgeGradientGold => 'Royal Gold';

  @override
  String get codeForgeErrorCorrection => 'Error Correction';

  @override
  String get codeForgeCenterBadge => 'Center Badge';

  @override
  String get codeForgeBadgeNone => 'None';

  @override
  String get codeForgeBadgeIcon => 'Content Icon';

  @override
  String get codeForgeBadgeShield => 'Verified Shield';

  @override
  String get codeForgeExportPng => 'Share PNG';

  @override
  String get codeForgeExportSvg => 'Share SVG';

  @override
  String get codeForgeCopyPayload => 'Copy Content';

  @override
  String get codeForgeCopied => 'Barcode content copied to clipboard';

  @override
  String get codeForgeSafeVerified =>
      'Verified Safe by 6-Layer Security Engine';

  @override
  String get codeForgeResetStyle => 'Reset Styling';

  @override
  String get codeForgeIncludeText => 'Show Text Label';

  @override
  String get codeForgePreview => 'Live Preview';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingGetStarted => 'Start Scanning';

  @override
  String get onboardingSlide1Badge => '6-Layer Security';

  @override
  String get onboardingSlide1Title => '6-Layer URL Safety Engine';

  @override
  String get onboardingSlide1Description =>
      'Every link is inspected across six offline and online defense layers before you open it, protecting you against phishing, malicious redirects, and homograph traps.';

  @override
  String get onboardingSlide1Bullet1 => 'Protocol & Homograph Shield';

  @override
  String get onboardingSlide1Bullet2 => 'TLD Entropy & Port Trap Analysis';

  @override
  String get onboardingSlide1Bullet3 => 'Private Probing & Safe Browsing';

  @override
  String get onboardingSlide2Badge => 'Computer Vision';

  @override
  String get onboardingSlide2Title => 'QuishingGuard™ Tamper Detection';

  @override
  String get onboardingSlide2Description =>
      'Criminals paste fraudulent QR stickers over authentic signs. QuishingGuard inspects physical edges, shadows, and surface paper textures before you scan.';

  @override
  String get onboardingSlide2Bullet1 => 'Physical sticker overlay detection';

  @override
  String get onboardingSlide2Bullet2 => 'Cut edge & shadow boundary analysis';

  @override
  String get onboardingSlide2Bullet3 => 'Real-time camera frame inspection';

  @override
  String get onboardingSlide3Badge => 'Zero Cloud • Zero Tracking';

  @override
  String get onboardingSlide3Title => '100% Offline Privacy Model';

  @override
  String get onboardingSlide3Description =>
      'Your scans and personal data never leave your phone. There are no analytics SDKs, no trackers, and no remote servers watching your habits.';

  @override
  String get onboardingSlide3Bullet1 => 'Encrypted on-device SQLite database';

  @override
  String get onboardingSlide3Bullet2 => 'AirQR optical air-gap transfers';

  @override
  String get onboardingSlide3Bullet3 =>
      'Zero analytics or crash reporting SDKs';

  @override
  String get settingsOnboardingTourTitle => 'Welcome Tour';

  @override
  String get settingsOnboardingTourSubtitle =>
      'Revisit the 3-slide introduction to safety and privacy features';

  @override
  String get batchScanMode => 'Batch Scan Mode';

  @override
  String get batchModeTooltip => 'Toggle Continuous Batch Scan';

  @override
  String get batchModeEnabledToast => 'Continuous Batch Scan enabled';

  @override
  String get batchModeDisabledToast => 'Continuous Batch Scan disabled';

  @override
  String batchCounterBadge(int count) {
    return '$count Scanned';
  }

  @override
  String get batchReviewTitle => 'Batch Scans';

  @override
  String get batchReviewSubtitle => 'Continuous scanning queue';

  @override
  String get batchEmptyTitle => 'No codes in batch';

  @override
  String get batchEmptySubtitle =>
      'Point your camera at barcodes to scan them continuously without leaving the camera.';

  @override
  String get batchExport => 'Export Batch';

  @override
  String get batchClear => 'Clear Batch';

  @override
  String get batchClearConfirmTitle => 'Clear Batch?';

  @override
  String get batchClearConfirmContent =>
      'Are you sure you want to remove all scanned codes from this batch?';

  @override
  String get batchPreventDuplicates => 'Prevent Duplicates';

  @override
  String batchScannedToast(int count, String content) {
    return 'Scanned #$count: $content';
  }

  @override
  String get batchSafeUrl => 'Safe Link';

  @override
  String get batchSuspiciousUrl => 'Suspicious Link';

  @override
  String get batchAnalyzingUrl => 'Analyzing link...';

  @override
  String batchUrlSafetySummary(int safeCount, int warningCount, int totalUrls) {
    return '$safeCount safe, $warningCount suspicious of $totalUrls links';
  }

  @override
  String get batchItemDetailsTitle => 'Scanned Code Details';

  @override
  String batchFormatLabel(String format) {
    return 'Format: $format';
  }

  @override
  String batchTimeLabel(String time) {
    return 'Scanned at $time';
  }

  @override
  String get cameraDistanceEnhanceLabel => 'Distance Scan Assist';

  @override
  String get cameraDistanceEnhanceHint =>
      'Zoom-crop & unsharp mask for distant posters & signs';

  @override
  String get cameraUnsharpLabel => 'Edge Sharpness';

  @override
  String get cameraDistanceZoomLabel => 'Distance Zoom';

  @override
  String get scanDistanceModeTooltip => 'Distance Scan Assist';

  @override
  String get scanDistanceModeActive => 'Distance Mode Active';

  @override
  String get scanFromClipboard => 'Scan from Clipboard';

  @override
  String get clipboardBannerTitle => 'Clipboard content detected';

  @override
  String get clipboardActionScan => 'Scan Now';

  @override
  String get clipboardDismiss => 'Dismiss';

  @override
  String get clipboardEmptyMessage => 'Clipboard is empty';

  @override
  String get clipboardNoValidContent =>
      'No scannable link, code, or image found in clipboard';

  @override
  String get clipboardTypeUrl => 'URL';

  @override
  String get clipboardTypeBarcode => 'Barcode Payload';

  @override
  String get clipboardTypeImage => 'Image';

  @override
  String get clipboardTypeText => 'Text';

  @override
  String get multiCodeDetectedBanner =>
      'Multiple codes detected. Tap a code to scan.';

  @override
  String get multiCodeTapToScan => 'Tap to scan';

  @override
  String get multiCodeSelectionTitle => 'Multi-Code Selection';

  @override
  String get multiCodeSelectionSubtitle =>
      'Outline visible codes and tap to choose when multiple are present';

  @override
  String get multiCodeDismissTooltip => 'Dismiss selection';

  @override
  String get ghostScanTitle => 'GhostScan';

  @override
  String get ghostScanSubtitle => 'Screen Content QR Detector';

  @override
  String get ghostScanDescription =>
      'Detect and decode QR codes visible on your screen inside any app without taking manual screenshots.';

  @override
  String get ghostScanTileLabel => 'GhostScan';

  @override
  String get ghostScanActionScanNow => 'Scan Screen Now';

  @override
  String get ghostScanActionAddTile => 'Add Quick Settings Tile';

  @override
  String get ghostScanTileAdded => 'Quick Settings tile request sent';

  @override
  String get ghostScanHowItWorksTitle => 'How to use GhostScan';

  @override
  String get ghostScanStep1 =>
      'Pull down your Quick Settings notification shade from any app.';

  @override
  String get ghostScanStep2 =>
      'Tap the GhostScan tile to capture and decode the screen.';

  @override
  String get ghostScanStep3 =>
      'The code is decoded instantly without saving screenshots to your gallery.';

  @override
  String get ghostScanAnalyzing => 'Analyzing screen content...';

  @override
  String get ghostScanNoCodeFound => 'No QR code or barcode detected on screen';

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
      'Biometric Authentication: Protects sensitive StegoQR hidden records using your device fingerprint or facial recognition.';

  @override
  String get helpGuideHistoryBiometricsBullet2 =>
      'Screenshot Guard: Prevents malicious background apps or unauthorized shoulder-surfers from capturing screen content (FLAG_SECURE).';

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
  String get resultMoreActions => 'More actions';

  @override
  String get verdictChecking => 'Checking link safety…';

  @override
  String get verdictNoIssues => 'No issues found';

  @override
  String verdictIssuesFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count issues found',
      one: '1 issue found',
    );
    return '$_temp0';
  }

  @override
  String verdictChecksPassed(int passed, int total) {
    return '$passed of $total checks passed';
  }

  @override
  String get verdictSeeDetails => 'See details';

  @override
  String get verdictModePrivate => 'Private mode';

  @override
  String get verdictModeActive => 'Active probing';

  @override
  String safetyShowPassed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Show $count passed checks',
      one: 'Show 1 passed check',
    );
    return '$_temp0';
  }

  @override
  String get safetyHidePassed => 'Hide passed checks';

  @override
  String safetySkippedGroup(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count checks skipped',
      one: '1 check skipped',
    );
    return '$_temp0';
  }

  @override
  String get safetySkippedSetup => 'Set up in Settings';

  @override
  String openRiskDialogIssues(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'This link has $count issues. Open it anyway?',
      one: 'This link has 1 issue. Open it anyway?',
    );
    return '$_temp0';
  }

  @override
  String get sandboxShowPreview => 'Show preview';

  @override
  String get sandboxHidePreview => 'Hide preview';

  @override
  String quishingCompactGenuine(String percent) {
    return 'Genuine print · $percent%';
  }

  @override
  String get scanBubbleTitle => 'Scan bubble';

  @override
  String get scanBubbleSettingsSubtitle => 'Scan codes shown in other apps';

  @override
  String get scanBubbleSwitchTitle => 'Show scan bubble';

  @override
  String get scanBubbleSwitchSubtitle =>
      'A small button that floats over other apps. Tap it to scan a code on the screen.';

  @override
  String get scanBubblePermissionGranted => 'Allowed';

  @override
  String get scanBubblePermissionMissing =>
      'Not allowed yet. Needed for the bubble.';

  @override
  String get scanBubbleAllowButton => 'Allow';

  @override
  String get scanBubbleStartOnBootTitle => 'Start after restart';

  @override
  String get scanBubbleStartOnBootSubtitle =>
      'If the bubble was on, show it again after the phone restarts. Some phones may block this.';

  @override
  String get scanBubbleAddTileButton => 'Add to Quick Settings';

  @override
  String get scanBubbleTileAdded => 'Quick Settings tile request sent';

  @override
  String get scanBubbleTileManual =>
      'Pull down Quick Settings, tap the edit (pencil) button, and drag the Scan bubble tile in.';

  @override
  String get scanBubblePermissionDialogTitle => 'Allow the bubble';

  @override
  String get scanBubblePermissionDialogBody =>
      'To float over other apps, the bubble needs the \"Display over other apps\" permission. On the next page, turn it on for this app, then come back.';

  @override
  String get scanBubbleOpenSettings => 'Open settings';

  @override
  String get scanBubbleStartFailed =>
      'Could not start the bubble. Please try again.';

  @override
  String get scanBubbleBlockedCapture =>
      'This app blocks screen capture, so its codes cannot be read.';

  @override
  String get historySourceScreen => 'From screen';

  @override
  String get permissionOverlayTitle => 'Display over other apps';

  @override
  String get permissionOverlayDesc =>
      'Used only by the Scan bubble, and only after you turn it on. Lets the bubble float over other apps.';

  @override
  String get permissionNotificationTitle => 'Notifications';

  @override
  String get permissionNotificationDesc =>
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
  String get codeForgeBarcodeContent => 'Barcode content';

  @override
  String get codeForgeBarcodeContentHint => 'Enter the barcode number or code';

  @override
  String get codeForgeWifiSecurityNone => 'None (open)';

  @override
  String get codeForgeUpiVpaHint => 'e.g. merchant@upi';

  @override
  String get optionalFieldHint => 'Optional';

  @override
  String get codeForgeContentEmpty => 'Content cannot be empty';

  @override
  String codeForgeTextTooLong(String max) {
    return 'Text must not be longer than $max characters';
  }

  @override
  String get codeForgeWifiSsidRequired =>
      'Wi-Fi network name (SSID) is required';

  @override
  String get codeForgeUpiVpaRequired => 'UPI ID is required';

  @override
  String codeForgeBarcodeInvalid(String detail) {
    return 'Not valid for this barcode type ($detail)';
  }

  @override
  String get airQrUnlockedTitle => 'AirQR payload unlocked';

  @override
  String get jsonEnvelopeUnlockedTitle => 'JSON payload unlocked';

  @override
  String get stegoUnlockedTitle => 'StegoQR payload unlocked';

  @override
  String get stegoDetectedTitle => 'StegoQR encrypted payload found';

  @override
  String get decryptShowAdvanced => 'Advanced (Salt / IV)';

  @override
  String get decryptHideAdvanced => 'Hide advanced';

  @override
  String get decryptSaltLabel => 'Salt (Base64, optional)';

  @override
  String get decryptIvLabel => 'IV / Nonce (Base64, optional)';

  @override
  String historyRecordCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count scan records found',
      one: '1 scan record found',
    );
    return '$_temp0';
  }

  @override
  String arItemsSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items selected',
      one: '1 item selected',
    );
    return '$_temp0';
  }

  @override
  String settingsAppearanceSummary(String themeMode) {
    return '$themeMode • Dynamic colors';
  }

  @override
  String get openPhishFeedNotDownloaded => 'Feed not downloaded yet';

  @override
  String get accentDynamicColorInfo =>
      'Dynamic Color builds a matching palette from your Android wallpaper (Android 12+). When it is off, the standard high-contrast security palette is used.';

  @override
  String get typographySampleLine =>
      '6-Layer URL Safety Check • 100% Offline QuishingGuard™ CV Engine';

  @override
  String get typographyScaleTitle => 'Text size';

  @override
  String get typographyScaleInfo =>
      'The app follows your Android accessibility text size, while keeping the scan frame and on-screen labels easy to read.';

  @override
  String domFetchFailedTitle(String host) {
    return '$host (offline or network blocked)';
  }

  @override
  String get scanPauseTooltip => 'Pause scanning';

  @override
  String get scanResumeTooltip => 'Resume scanning';

  @override
  String get arModeWarehouse => 'Warehouse';

  @override
  String get arModeSafety => 'Safety';

  @override
  String get arModeWarehouseTooltip => 'Show item info and select codes';

  @override
  String get arModeSafetyTooltip => 'Show a safety badge on each link';

  @override
  String get cameraStartFailed => 'Camera could not start';

  @override
  String get cameraNotFound => 'No camera found on this phone';

  @override
  String get cameraRetryButton => 'Try again';

  @override
  String get codeForgeSafetyPrompt => 'Check this link before you share it';

  @override
  String get codeForgeSafetyCheckButton => 'Check';

  @override
  String codeForgeSafetyProblems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count problems found in this link',
      one: '1 problem found in this link',
    );
    return '$_temp0';
  }

  @override
  String get codeForgeSafetyCheckAgain => 'Check again';
}
