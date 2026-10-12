import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_sa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ml'),
    Locale('sa'),
  ];

  /// The application name, shown as the task title and in the About screen
  ///
  /// In en, this message translates to:
  /// **'SreerajP QR Studio'**
  String get appTitle;

  /// Label above the network name on the Wi-Fi action card
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi Network'**
  String get wifiCardTitle;

  /// Tooltip on the button that reveals the Wi-Fi password
  ///
  /// In en, this message translates to:
  /// **'Show Password'**
  String get wifiShowPassword;

  /// Tooltip on the button that hides the Wi-Fi password
  ///
  /// In en, this message translates to:
  /// **'Hide Password'**
  String get wifiHidePassword;

  /// Tooltip on the button that copies the Wi-Fi password
  ///
  /// In en, this message translates to:
  /// **'Copy Password'**
  String get wifiCopyPassword;

  /// Button that opens the device Wi-Fi settings to connect
  ///
  /// In en, this message translates to:
  /// **'Connect to Wi-Fi'**
  String get wifiConnectButton;

  /// Message shown after the Wi-Fi password is copied
  ///
  /// In en, this message translates to:
  /// **'Password copied to clipboard'**
  String get wifiPasswordCopied;

  /// Message shown when the app cannot open Wi-Fi settings directly
  ///
  /// In en, this message translates to:
  /// **'Password copied. Open Wi-Fi Settings on your device to connect.'**
  String get wifiOpenSettingsHint;

  /// Message shown when a Wi-Fi direct connection prompt or request is initiated
  ///
  /// In en, this message translates to:
  /// **'Connection requested for {ssid}'**
  String wifiConnectSuccess(String ssid);

  /// Coordinates line on the location action card
  ///
  /// In en, this message translates to:
  /// **'Lat: {latitude}, Lng: {longitude}'**
  String geoLatLng(String latitude, String longitude);

  /// Search text carried by a scanned location code
  ///
  /// In en, this message translates to:
  /// **'Query: {query}'**
  String geoQuery(String query);

  /// Button that opens the scanned location in Google Maps
  ///
  /// In en, this message translates to:
  /// **'Navigate in Google Maps'**
  String get geoNavigateButton;

  /// Message shown when Google Maps cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Could not launch Google Maps app'**
  String get geoLaunchFailed;

  /// Label above the event name on the calendar action card
  ///
  /// In en, this message translates to:
  /// **'Calendar Event'**
  String get calendarCardTitle;

  /// Shown in place of a date when the scanned event has none
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get calendarNoDate;

  /// Start date and time of a scanned calendar event
  ///
  /// In en, this message translates to:
  /// **'Start: {dateTime}'**
  String calendarStart(String dateTime);

  /// End date and time of a scanned calendar event. The extra spaces line it up under the start line
  ///
  /// In en, this message translates to:
  /// **'End:   {dateTime}'**
  String calendarEnd(String dateTime);

  /// Button that adds the scanned event to the device calendar
  ///
  /// In en, this message translates to:
  /// **'Add to Device Calendar'**
  String get calendarAddButton;

  /// Message shown when the calendar app cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open Calendar app'**
  String get calendarLaunchFailed;

  /// Label above the person's name on the contact action card
  ///
  /// In en, this message translates to:
  /// **'Contact Card'**
  String get contactCardTitle;

  /// Single letter shown in the contact avatar when the scanned contact has no name
  ///
  /// In en, this message translates to:
  /// **'C'**
  String get contactInitialFallback;

  /// Button that saves the scanned contact to the device
  ///
  /// In en, this message translates to:
  /// **'Save to Contacts'**
  String get contactSaveButton;

  /// Message shown when the contacts app cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open Contacts app'**
  String get contactLaunchFailed;

  /// Message shown when a phone call cannot be started
  ///
  /// In en, this message translates to:
  /// **'Could not place call to {number}'**
  String contactCallFailed(String number);

  /// Message shown when the email app cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open email app for {email}'**
  String contactEmailFailed(String email);

  /// Title of the sheet listing codes found in a PDF, with how many were found
  ///
  /// In en, this message translates to:
  /// **'PDF Scan Results ({count})'**
  String pdfResultsTitle(int count);

  /// Short page badge on a PDF result row, for example P3
  ///
  /// In en, this message translates to:
  /// **'P{page}'**
  String pdfPageBadge(int page);

  /// Page number of a code found in a PDF
  ///
  /// In en, this message translates to:
  /// **'Page {page}'**
  String pdfPageLabel(int page);

  /// Button that saves every code found in the PDF to history
  ///
  /// In en, this message translates to:
  /// **'Save All ({count}) to History'**
  String pdfSaveAllButton(int count);

  /// Note stored with a history record for a code found in a PDF
  ///
  /// In en, this message translates to:
  /// **'Scanned from PDF (Page {page})'**
  String pdfScanNote(int page);

  /// Message shown after saving all PDF codes to history
  ///
  /// In en, this message translates to:
  /// **'Saved {count} codes to history.'**
  String pdfSavedToHistory(int count);

  /// Shown in place of the issuer name when a scanned 2FA code has none
  ///
  /// In en, this message translates to:
  /// **'2FA Authenticator'**
  String get totpDefaultIssuer;

  /// Label above the rolling one-time passcode, with how many seconds each code lasts
  ///
  /// In en, this message translates to:
  /// **'Live Passcode ({period}s TOTP)'**
  String totpLivePasscode(int period);

  /// Seconds left before the current one-time passcode changes
  ///
  /// In en, this message translates to:
  /// **'{seconds}s'**
  String totpSecondsLeft(int seconds);

  /// Tooltip on the button that copies the current one-time passcode
  ///
  /// In en, this message translates to:
  /// **'Copy Token'**
  String get totpCopyToken;

  /// Label before the 2FA secret key. Keeps a trailing space
  ///
  /// In en, this message translates to:
  /// **'Secret: '**
  String get totpSecretLabel;

  /// Button that sends the scanned 2FA code to an authenticator app
  ///
  /// In en, this message translates to:
  /// **'Import into Authenticator App'**
  String get totpImportButton;

  /// Message shown when no authenticator app could be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open Authenticator app'**
  String get totpLaunchFailed;

  /// Message shown after the one-time passcode is copied
  ///
  /// In en, this message translates to:
  /// **'TOTP token copied to clipboard'**
  String get totpTokenCopied;

  /// Message shown after the 2FA secret key is copied
  ///
  /// In en, this message translates to:
  /// **'Secret key copied to clipboard'**
  String get totpSecretCopied;

  /// Title of the payment card for an Indian UPI code
  ///
  /// In en, this message translates to:
  /// **'UPI Payment'**
  String get paymentSchemeUpi;

  /// Title of the payment card for a European SEPA transfer code
  ///
  /// In en, this message translates to:
  /// **'SEPA Transfer'**
  String get paymentSchemeSepa;

  /// Title of the payment card for a cryptocurrency code
  ///
  /// In en, this message translates to:
  /// **'Crypto Payment'**
  String get paymentSchemeCrypto;

  /// Shown in place of the payee name when the scanned code has none
  ///
  /// In en, this message translates to:
  /// **'Merchant / Payee'**
  String get paymentPayeeFallback;

  /// Label before the payee address for a UPI code
  ///
  /// In en, this message translates to:
  /// **'VPA / UPI ID:'**
  String get paymentAddressLabelUpi;

  /// Label before the payee address for a SEPA transfer code
  ///
  /// In en, this message translates to:
  /// **'IBAN:'**
  String get paymentAddressLabelSepa;

  /// Label before the payee address for a cryptocurrency code
  ///
  /// In en, this message translates to:
  /// **'Wallet Address:'**
  String get paymentAddressLabelCrypto;

  /// Small button that copies the payee address
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get paymentCopyAction;

  /// Message shown after a UPI id is copied
  ///
  /// In en, this message translates to:
  /// **'UPI ID copied to clipboard'**
  String get paymentUpiIdCopied;

  /// Message shown after a payment address is copied
  ///
  /// In en, this message translates to:
  /// **'Address copied to clipboard'**
  String get paymentAddressCopied;

  /// Transaction note carried by a scanned payment code
  ///
  /// In en, this message translates to:
  /// **'Note: {note}'**
  String paymentNote(String note);

  /// Button that opens a UPI payment app
  ///
  /// In en, this message translates to:
  /// **'Pay via App (GPay / PhonePe / Paytm)'**
  String get paymentPayButtonUpi;

  /// Button that opens a payment app for a non-UPI code
  ///
  /// In en, this message translates to:
  /// **'Pay via App'**
  String get paymentPayButton;

  /// Message shown when no UPI payment app could be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open UPI app. Make sure GPay, PhonePe, or Paytm is installed.'**
  String get paymentUpiLaunchFailed;

  /// Message shown when no payment app could be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open payment app for this scheme.'**
  String get paymentLaunchFailed;

  /// Action on the failure message that copies the payee address instead
  ///
  /// In en, this message translates to:
  /// **'Copy ID'**
  String get paymentCopyIdAction;

  /// Title of the dialog that asks for an amount when a UPI code has none
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get paymentAmountDialogTitle;

  /// Explains why the amount dialog is shown; payee is the merchant or person being paid
  ///
  /// In en, this message translates to:
  /// **'This QR has no amount. Enter the amount to pay to {payee}.'**
  String paymentAmountDialogBody(String payee);

  /// Label of the amount input field in the UPI amount dialog
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get paymentAmountFieldLabel;

  /// Error under the amount field when the amount is below 1 rupee or badly formatted
  ///
  /// In en, this message translates to:
  /// **'Enter ₹1 or more'**
  String get paymentAmountInvalid;

  /// Button in the UPI amount dialog that opens the UPI app with the entered amount
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get paymentAmountPayButton;

  /// A percentage shown to the user, for example 42%
  ///
  /// In en, this message translates to:
  /// **'{value}%'**
  String percentValue(String value);

  /// Name of the feature that checks a printed code for physical tampering
  ///
  /// In en, this message translates to:
  /// **'QuishingGuard™'**
  String get quishingGuardTitle;

  /// Small badge saying the check uses computer vision on the printed code
  ///
  /// In en, this message translates to:
  /// **'Physical Tamper CV'**
  String get quishingTamperBadge;

  /// Label before the tamper risk percentage
  ///
  /// In en, this message translates to:
  /// **'Tamper Risk Score:'**
  String get quishingRiskScoreLabel;

  /// Link that opens the detailed tamper findings
  ///
  /// In en, this message translates to:
  /// **'View Forensic Analysis'**
  String get quishingViewSignals;

  /// Link that closes the detailed tamper findings
  ///
  /// In en, this message translates to:
  /// **'Hide Forensic Signals'**
  String get quishingHideSignals;

  /// Name of the tamper metric that looks at the edges of the printed code
  ///
  /// In en, this message translates to:
  /// **'Edge Discontinuity'**
  String get quishingMetricEdgeLabel;

  /// Short explanation of the edge discontinuity metric
  ///
  /// In en, this message translates to:
  /// **'Double edges & shadow lines'**
  String get quishingMetricEdgeDescription;

  /// Name of the tamper metric that looks at print quality
  ///
  /// In en, this message translates to:
  /// **'Print Grain & DPI'**
  String get quishingMetricGrainLabel;

  /// Short explanation of the print grain metric
  ///
  /// In en, this message translates to:
  /// **'Halftone dot & chromatic noise'**
  String get quishingMetricGrainDescription;

  /// Heading above the list of tamper findings
  ///
  /// In en, this message translates to:
  /// **'Detected Computer Vision Signals:'**
  String get quishingSignalsHeading;

  /// Tooltip on the button that closes the AR detail sheet
  ///
  /// In en, this message translates to:
  /// **'Close Sheet'**
  String get arCloseSheet;

  /// Price read from a scanned item label in warehouse mode
  ///
  /// In en, this message translates to:
  /// **'Item Price Tag: {price}'**
  String arItemPriceTag(String price);

  /// Message shown after the AR target content is copied
  ///
  /// In en, this message translates to:
  /// **'Copied content to clipboard'**
  String get arContentCopied;

  /// Button that copies the AR target content
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get arCopyButton;

  /// Button that opens the link held by the AR target
  ///
  /// In en, this message translates to:
  /// **'Open URL'**
  String get arOpenUrlButton;

  /// Button that marks an AR target as selected
  ///
  /// In en, this message translates to:
  /// **'Select Item'**
  String get arSelectButton;

  /// Button that clears the selection on an AR target
  ///
  /// In en, this message translates to:
  /// **'Deselect'**
  String get arDeselectButton;

  /// Shown when the AR target link passed the safety checks
  ///
  /// In en, this message translates to:
  /// **'Safety Status: Verified Safe'**
  String get arSafetyStatusSafe;

  /// Shown when the AR target link may be a phishing attempt
  ///
  /// In en, this message translates to:
  /// **'Safety Status: Warning / Phishing Suspicion'**
  String get arSafetyStatusWarning;

  /// Shown while the AR target link is still being checked
  ///
  /// In en, this message translates to:
  /// **'Safety Status: Analyzing link safety...'**
  String get arSafetyStatusUnknown;

  /// Message shown after content is copied, used on several screens
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// Date and time of a saved scan, joined by a dot
  ///
  /// In en, this message translates to:
  /// **'{date} • {time}'**
  String historyTimestamp(String date, String time);

  /// Tooltip on the button that marks a saved scan as a favourite
  ///
  /// In en, this message translates to:
  /// **'Star favorite'**
  String get historyStar;

  /// Tooltip on the button that removes a saved scan from favourites
  ///
  /// In en, this message translates to:
  /// **'Unstar'**
  String get historyUnstar;

  /// Menu item that opens the notes editor for a saved scan
  ///
  /// In en, this message translates to:
  /// **'Edit Notes'**
  String get historyEditNotes;

  /// Menu item that copies the saved scan content
  ///
  /// In en, this message translates to:
  /// **'Copy String'**
  String get historyCopyString;

  /// Button and menu item that shares the saved scan content
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get historyShare;

  /// Menu item that deletes a saved scan
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get historyDelete;

  /// Title of the sheet showing one saved scan in full
  ///
  /// In en, this message translates to:
  /// **'Scan Record Details'**
  String get historyDetailTitle;

  /// Safety score badge on a saved scan
  ///
  /// In en, this message translates to:
  /// **'🛡️ {score}% Safe'**
  String historySafetyBadge(int score);

  /// Short safety score badge on a history card
  ///
  /// In en, this message translates to:
  /// **'🛡️ {score}%'**
  String historyScoreBadge(int score);

  /// Label above the raw content of a saved scan
  ///
  /// In en, this message translates to:
  /// **'Scanned Content:'**
  String get historyScannedContent;

  /// Button that copies the saved scan content
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get historyCopyButton;

  /// Label of the field where the user writes their own note
  ///
  /// In en, this message translates to:
  /// **'Custom User Notes'**
  String get historyNotesLabel;

  /// Hint inside the empty notes field
  ///
  /// In en, this message translates to:
  /// **'Add personal notes or remarks about this scan...'**
  String get historyNotesHint;

  /// Label of the field where the user names the place of the scan
  ///
  /// In en, this message translates to:
  /// **'Location Tag (Optional)'**
  String get historyLocationLabel;

  /// Hint inside the empty location field
  ///
  /// In en, this message translates to:
  /// **'e.g. Office Desk, Grocery Store, Conference'**
  String get historyLocationHint;

  /// Button that saves the edited note and location
  ///
  /// In en, this message translates to:
  /// **'Save Metadata Changes'**
  String get historySaveChanges;

  /// Button that closes a dialog, used on several screens
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// Title of the dialog when it is exporting scan history
  ///
  /// In en, this message translates to:
  /// **'Export & Cloud Backup'**
  String get exportDialogTitle;

  /// Title of the dialog when it is restoring a backup
  ///
  /// In en, this message translates to:
  /// **'Restore Encrypted Backup'**
  String get restoreDialogTitle;

  /// Button that switches the dialog to export mode
  ///
  /// In en, this message translates to:
  /// **'Export Records'**
  String get exportRecordsTab;

  /// Button that switches the dialog to restore mode
  ///
  /// In en, this message translates to:
  /// **'Restore Backup'**
  String get restoreBackupTab;

  /// Heading above the list of export file formats
  ///
  /// In en, this message translates to:
  /// **'Select Export Format:'**
  String get exportFormatHeading;

  /// Name of the CSV export option
  ///
  /// In en, this message translates to:
  /// **'CSV Format (.csv)'**
  String get exportCsvTitle;

  /// Short explanation of the CSV export option
  ///
  /// In en, this message translates to:
  /// **'Compatible with Excel and Sheets'**
  String get exportCsvSubtitle;

  /// Name of the JSON export option
  ///
  /// In en, this message translates to:
  /// **'JSON Dataset (.json)'**
  String get exportJsonTitle;

  /// Short explanation of the JSON export option
  ///
  /// In en, this message translates to:
  /// **'Structured developer format'**
  String get exportJsonSubtitle;

  /// Name of the plain text export option
  ///
  /// In en, this message translates to:
  /// **'Formatted TXT Report (.txt)'**
  String get exportTxtTitle;

  /// Short explanation of the plain text export option
  ///
  /// In en, this message translates to:
  /// **'Human readable summary document'**
  String get exportTxtSubtitle;

  /// Name of the PDF export option
  ///
  /// In en, this message translates to:
  /// **'PDF Document Report (.pdf)'**
  String get exportPdfTitle;

  /// Short explanation of the PDF export option
  ///
  /// In en, this message translates to:
  /// **'Formatted printable report table'**
  String get exportPdfSubtitle;

  /// Heading above the encrypted backup controls
  ///
  /// In en, this message translates to:
  /// **'Encrypted Local Backup File (.sreerajqr)'**
  String get exportBackupHeading;

  /// Label of the field for the backup password
  ///
  /// In en, this message translates to:
  /// **'Backup Encryption Passphrase'**
  String get exportPassphraseLabel;

  /// Hint inside the empty backup password field
  ///
  /// In en, this message translates to:
  /// **'Enter secret passphrase...'**
  String get exportPassphraseHint;

  /// Message shown when the user tries to back up without a password
  ///
  /// In en, this message translates to:
  /// **'Please enter a password to encrypt your backup file.'**
  String get exportPassphraseRequired;

  /// Button that builds and shares the encrypted backup file
  ///
  /// In en, this message translates to:
  /// **'Create Encrypted Backup File'**
  String get exportCreateBackupButton;

  /// Message attached when sharing an exported history file
  ///
  /// In en, this message translates to:
  /// **'SreerajP QR Studio Scan History Export'**
  String get exportShareText;

  /// Message attached when sharing the PDF history report
  ///
  /// In en, this message translates to:
  /// **'SreerajP QR Studio Scan History Report (PDF)'**
  String get exportSharePdfText;

  /// Message attached when sharing the encrypted backup file
  ///
  /// In en, this message translates to:
  /// **'SreerajP QR Studio Encrypted Backup File'**
  String get exportShareBackupText;

  /// Heading above the restore controls
  ///
  /// In en, this message translates to:
  /// **'Restore History from Encrypted Backup File:'**
  String get restoreHeading;

  /// Label of the field for the password that unlocks a backup
  ///
  /// In en, this message translates to:
  /// **'Backup Decryption Passphrase'**
  String get restorePassphraseLabel;

  /// Label of the field holding the backup file content
  ///
  /// In en, this message translates to:
  /// **'Encrypted Backup Payload (.sreerajqr)'**
  String get restorePayloadLabel;

  /// Hint inside the empty backup content field
  ///
  /// In en, this message translates to:
  /// **'Paste backup JSON payload string here...'**
  String get restorePayloadHint;

  /// Message shown when a restore is tried with a missing field
  ///
  /// In en, this message translates to:
  /// **'Please provide both the password and backup content.'**
  String get restoreFieldsRequired;

  /// Button that unlocks a backup and restores the scans in it
  ///
  /// In en, this message translates to:
  /// **'Decrypt & Restore History'**
  String get restoreButton;

  /// Message shown after a backup is restored
  ///
  /// In en, this message translates to:
  /// **'Successfully restored {count} scan records!'**
  String restoreSuccess(int count);

  /// Message shown when a backup could not be restored
  ///
  /// In en, this message translates to:
  /// **'Restore failed: {reason}'**
  String restoreFailed(String reason);

  /// Badge saying the page preview ran with scripts blocked
  ///
  /// In en, this message translates to:
  /// **'SANDBOXED'**
  String get domSandboxedBadge;

  /// Single letter shown in the site avatar when the page has no title
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get domTitleInitialFallback;

  /// Shown in place of the page title when the page has none
  ///
  /// In en, this message translates to:
  /// **'Untitled Web Page'**
  String get domUntitledPage;

  /// Caption under the safe preview image of a scanned web page
  ///
  /// In en, this message translates to:
  /// **'Visual Thumbnail Pre-Render (Script Execution Blocked)'**
  String get domThumbnailCaption;

  /// Badge counting the scripts and trackers the preview blocked
  ///
  /// In en, this message translates to:
  /// **'Blocked: {scripts} Scripts, {trackers} Trackers'**
  String domBlockedBadge(int scripts, int trackers);

  /// Badge warning that the site domain was registered very recently
  ///
  /// In en, this message translates to:
  /// **'Newly Registered ({days}d)'**
  String domNewlyRegistered(int days);

  /// Badge showing how old the site domain is
  ///
  /// In en, this message translates to:
  /// **'Domain Age: {days} days'**
  String domDomainAge(int days);

  /// Badge warning that the link forwards to another site
  ///
  /// In en, this message translates to:
  /// **'Open Redirect Trap!'**
  String get domOpenRedirectFound;

  /// Badge saying the link does not forward to another site
  ///
  /// In en, this message translates to:
  /// **'No Open Redirects'**
  String get domNoOpenRedirect;

  /// Button that opens the detailed page structure sheet
  ///
  /// In en, this message translates to:
  /// **'Inspect DOM Sandbox Structure'**
  String get domInspectButton;

  /// Title of the detailed page structure sheet
  ///
  /// In en, this message translates to:
  /// **'Zero-Trust DOM Sandbox Hierarchy'**
  String get domInspectTitle;

  /// Row label for the page title
  ///
  /// In en, this message translates to:
  /// **'Page Title'**
  String get domDetailPageTitle;

  /// Shown when the page did not give a title
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get domDetailNotSpecified;

  /// Row label for the page description
  ///
  /// In en, this message translates to:
  /// **'Meta Description'**
  String get domDetailMetaDescription;

  /// Shown when the page did not give a description
  ///
  /// In en, this message translates to:
  /// **'None found'**
  String get domDetailNoneFound;

  /// Row label for how many headings the page had
  ///
  /// In en, this message translates to:
  /// **'Headings Count'**
  String get domDetailHeadingsCount;

  /// How many headings were read from the page
  ///
  /// In en, this message translates to:
  /// **'{count} headings extracted'**
  String domDetailHeadingsValue(int count);

  /// Row label for how many links the page had
  ///
  /// In en, this message translates to:
  /// **'Links Found'**
  String get domDetailLinksFound;

  /// How many links were read from the page
  ///
  /// In en, this message translates to:
  /// **'{count} URLs extracted'**
  String domDetailLinksValue(int count);

  /// Row label for blocked scripts
  ///
  /// In en, this message translates to:
  /// **'Blocked Scripts'**
  String get domDetailBlockedScripts;

  /// How many scripts were removed before the preview
  ///
  /// In en, this message translates to:
  /// **'{count} executable script tags/events stripped'**
  String domDetailBlockedScriptsValue(int count);

  /// Row label for blocked trackers
  ///
  /// In en, this message translates to:
  /// **'Blocked Trackers'**
  String get domDetailBlockedTrackers;

  /// How many trackers were removed before the preview
  ///
  /// In en, this message translates to:
  /// **'{count} tracking pixels stripped'**
  String domDetailBlockedTrackersValue(int count);

  /// Row label for blocked embedded frames
  ///
  /// In en, this message translates to:
  /// **'Blocked Iframes'**
  String get domDetailBlockedIframes;

  /// How many embedded frames were removed before the preview
  ///
  /// In en, this message translates to:
  /// **'{count} iframe/embed elements removed'**
  String domDetailBlockedIframesValue(int count);

  /// Heading above the cleaned page source snippet
  ///
  /// In en, this message translates to:
  /// **'Sanitized HTML Preview Snippet:'**
  String get domSanitizedSnippetHeading;

  /// Title of the About screen
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// App version and build number on the About screen
  ///
  /// In en, this message translates to:
  /// **'Version {version}+{build}'**
  String aboutVersion(String version, String build);

  /// Label for the application build date on the About screen
  ///
  /// In en, this message translates to:
  /// **'Build Date'**
  String get aboutBuildDate;

  /// Title of the About screen card that opens the list of open-source licences used by the app (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Open-source licences'**
  String get aboutOpenSourceLicenses;

  /// Subtitle of the open-source licences card on the About screen. 'zxing-cpp' and 'Apache-2.0' are names and must not be translated.
  ///
  /// In en, this message translates to:
  /// **'Includes zxing-cpp (Apache-2.0) as the barcode decoder. Tap to view all licences.'**
  String get aboutOpenSourceLicensesDetail;

  /// Detail label for author in About screen
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get aboutDetailAuthor;

  /// Detail label for email in About screen
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get aboutDetailEmail;

  /// Detail label for license in About screen
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get aboutDetailLicense;

  /// Detail label for AI tools used in About screen
  ///
  /// In en, this message translates to:
  /// **'AI Used'**
  String get aboutDetailAiUsed;

  /// Detail label for IDE used in About screen
  ///
  /// In en, this message translates to:
  /// **'IDE Used'**
  String get aboutDetailIdeUsed;

  /// About-screen signature badge. {heart} is a red heart glyph.
  ///
  /// In en, this message translates to:
  /// **'Made with {heart} from India'**
  String madeWithLove(String heart);

  /// Screen-reader text for the About badge
  ///
  /// In en, this message translates to:
  /// **'Made with love from India'**
  String get madeWithLoveA11y;

  /// Footer line on the About screen
  ///
  /// In en, this message translates to:
  /// **'Made with ❤️ from India'**
  String get aboutMadeWithLove;

  /// Title of the screen that sends data as a stream of codes
  ///
  /// In en, this message translates to:
  /// **'AirQR Stream Transmitter'**
  String get airQrTransmitterTitle;

  /// Sample text that fills the payload box when the transmitter screen opens
  ///
  /// In en, this message translates to:
  /// **'AirQR High-Speed Optical Air-Gap Transfer Test Payload. This payload is split into small chunks with Fountain FEC error correction.'**
  String get airQrSamplePayload;

  /// Label of the box holding the data to send
  ///
  /// In en, this message translates to:
  /// **'Payload Data to Broadcast'**
  String get airQrPayloadLabel;

  /// Hint inside the empty payload box
  ///
  /// In en, this message translates to:
  /// **'Enter text, contact, or file payload...'**
  String get airQrPayloadHint;

  /// Label before the slider that sets how fast codes are shown
  ///
  /// In en, this message translates to:
  /// **'Stream Speed:'**
  String get airQrStreamSpeed;

  /// How many code frames are shown per second
  ///
  /// In en, this message translates to:
  /// **'{fps} FPS'**
  String airQrFps(int fps);

  /// Button that starts showing the stream of codes
  ///
  /// In en, this message translates to:
  /// **'Broadcast Optical Stream'**
  String get airQrStartStream;

  /// Button that stops showing the stream of codes
  ///
  /// In en, this message translates to:
  /// **'Stop Optical Stream'**
  String get airQrStopStream;

  /// Caption under a repair frame of the stream
  ///
  /// In en, this message translates to:
  /// **'Frame {current}/{total} [Fountain PARITY]'**
  String airQrFrameParity(int current, int total);

  /// Caption under a data frame of the stream
  ///
  /// In en, this message translates to:
  /// **'Frame {current}/{total} [Block {block}]'**
  String airQrFrameBlock(int current, int total, int block);

  /// Summary of how many frames the stream holds
  ///
  /// In en, this message translates to:
  /// **'Total Stream Frames: {total} ({source} Source + {parity} Fountain FEC)'**
  String airQrTotalFrames(int total, int source, int parity);

  /// Tooltip on the button that turns the camera light on or off
  ///
  /// In en, this message translates to:
  /// **'Toggle Flashlight'**
  String get toggleFlashlight;

  /// Button that asks the system for camera permission again
  ///
  /// In en, this message translates to:
  /// **'Grant Camera Permission'**
  String get grantCameraPermission;

  /// Title of the screen that marks up live camera view with found codes
  ///
  /// In en, this message translates to:
  /// **'AR CodeVision HUD'**
  String get arScreenTitle;

  /// Shown while the live camera view is starting
  ///
  /// In en, this message translates to:
  /// **'Initializing AR HUD Viewport...'**
  String get arInitializing;

  /// Button that unselects every marked code
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get arClearSelection;

  /// Button that copies every selected code at once
  ///
  /// In en, this message translates to:
  /// **'Batch Copy'**
  String get arBatchCopy;

  /// Message shown after copying several codes at once
  ///
  /// In en, this message translates to:
  /// **'Copied {count} barcodes to clipboard'**
  String arBatchCopied(int count);

  /// Shown when camera permission is missing on the AR screen
  ///
  /// In en, this message translates to:
  /// **'Camera permission is required for AR CodeVision'**
  String get arCameraPermissionMessage;

  /// Button that closes a finished step, used on several screens
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneButton;

  /// Title of the screen that reads a stream of codes
  ///
  /// In en, this message translates to:
  /// **'AirQR Stream Receiver'**
  String get airQrReceiverTitle;

  /// Tooltip on the button that opens the sending screen
  ///
  /// In en, this message translates to:
  /// **'AirQR Transmitter'**
  String get airQrTransmitterTooltip;

  /// Tooltip on the button that starts the capture again
  ///
  /// In en, this message translates to:
  /// **'Reset Stream'**
  String get airQrResetStream;

  /// Shown while the stream reader is starting
  ///
  /// In en, this message translates to:
  /// **'Initializing AirQR Stream Receiver...'**
  String get airQrInitializing;

  /// Status shown when every part of the stream has been received
  ///
  /// In en, this message translates to:
  /// **'STREAM REASSEMBLED'**
  String get airQrStatusReassembled;

  /// Status shown while parts of the stream are being read
  ///
  /// In en, this message translates to:
  /// **'CAPTURING OPTICAL STREAM...'**
  String get airQrStatusCapturing;

  /// Status telling the user to aim the camera at the sending screen
  ///
  /// In en, this message translates to:
  /// **'POINT AT ANIMATED QR STREAM'**
  String get airQrStatusIdle;

  /// How many parts of the stream have been read so far
  ///
  /// In en, this message translates to:
  /// **'Captured: {received} / {total} Blocks'**
  String airQrCaptured(int received, int total);

  /// How many parts of the stream are still missing
  ///
  /// In en, this message translates to:
  /// **'Missing: {count}'**
  String airQrMissing(int count);

  /// Title of the panel shown when the whole stream has been received
  ///
  /// In en, this message translates to:
  /// **'Air-Gap Transfer Complete!'**
  String get airQrTransferComplete;

  /// Explanation under the transfer complete title
  ///
  /// In en, this message translates to:
  /// **'Payload reassembled and verified offline via Fountain error correction.'**
  String get airQrTransferCompleteDetail;

  /// Message shown after the received data is copied
  ///
  /// In en, this message translates to:
  /// **'Copied payload to clipboard'**
  String get airQrPayloadCopied;

  /// Button that closes a dialog without acting, used on several screens
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// Title of the saved scans screen
  ///
  /// In en, this message translates to:
  /// **'Scan History'**
  String get historyScreenTitle;

  /// Tooltip on the button that opens the export and backup dialog
  ///
  /// In en, this message translates to:
  /// **'Export / Backup'**
  String get historyExportTooltip;

  /// Button and tooltip for deleting every saved scan
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get historyClearAll;

  /// Title of the dialog asking to confirm deleting all saved scans
  ///
  /// In en, this message translates to:
  /// **'Clear Scan History?'**
  String get historyClearTitle;

  /// Warning shown before all saved scans are deleted
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all persistent scan history? This action cannot be undone unless you have created a backup.'**
  String get historyClearMessage;

  /// Hint inside the empty search box on the saved scans screen
  ///
  /// In en, this message translates to:
  /// **'Search history (content, format, notes)...'**
  String get historySearchHint;

  /// Filter chip showing every saved scan
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get historyFilterAll;

  /// Filter chip showing only favourite scans
  ///
  /// In en, this message translates to:
  /// **'Starred'**
  String get historyFilterStarred;

  /// Filter chip showing only saved links
  ///
  /// In en, this message translates to:
  /// **'URLs'**
  String get historyFilterUrls;

  /// Filter chip showing only saved Wi-Fi codes
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi'**
  String get historyFilterWifi;

  /// Filter chip showing only saved contact cards
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get historyFilterContacts;

  /// Filter chip showing only saved plain text scans
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get historyFilterText;

  /// Filter chip showing only saved product barcodes
  ///
  /// In en, this message translates to:
  /// **'Barcodes'**
  String get historyFilterBarcodes;

  /// Title shown when the saved scans list is empty
  ///
  /// In en, this message translates to:
  /// **'No Scan Records Found'**
  String get historyEmptyTitle;

  /// Explanation shown when no scans have been saved yet
  ///
  /// In en, this message translates to:
  /// **'Scanned barcodes will automatically appear here.'**
  String get historyEmptyMessage;

  /// Shown when a search over saved scans finds nothing
  ///
  /// In en, this message translates to:
  /// **'No matches for \"{query}\"'**
  String historyNoMatches(String query);

  /// Tooltip on the button that opens the overflow menu
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get moreOptions;

  /// Menu item that opens the saved scans screen
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get menuHistory;

  /// Menu item that opens the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get menuSettings;

  /// Button that asks the system for a permission again
  ///
  /// In en, this message translates to:
  /// **'Grant Permission'**
  String get grantPermission;

  /// Tooltip on the button that reads a code from a saved picture
  ///
  /// In en, this message translates to:
  /// **'Scan Image from Gallery'**
  String get scanFromGallery;

  /// Tooltip on the button that reads codes from a PDF file
  ///
  /// In en, this message translates to:
  /// **'Scan PDF Document'**
  String get scanPdfDocument;

  /// Shown while the pages of a chosen PDF are being read
  ///
  /// In en, this message translates to:
  /// **'Extracting & scanning PDF pages...'**
  String get scanPdfProgress;

  /// Shown while a PDF shared from another app is being read
  ///
  /// In en, this message translates to:
  /// **'Scanning shared PDF document...'**
  String get scanSharedPdfProgress;

  /// Shown while the camera is starting
  ///
  /// In en, this message translates to:
  /// **'Initializing camera...'**
  String get scanInitializingCamera;

  /// Shown while the live camera picture is starting
  ///
  /// In en, this message translates to:
  /// **'Initializing camera feed...'**
  String get scanInitializingFeed;

  /// Tooltip on the camera light button
  ///
  /// In en, this message translates to:
  /// **'Flashlight / Torch'**
  String get scanTorchTooltip;

  /// Tooltip on the button that shows the zoom slider
  ///
  /// In en, this message translates to:
  /// **'Zoom slider'**
  String get scanZoomTooltip;

  /// Tooltip on the button that switches between front and back cameras
  ///
  /// In en, this message translates to:
  /// **'Flip Camera (Front/Back)'**
  String get scanFlipCameraTooltip;

  /// A zoom level, for example 2.5x
  ///
  /// In en, this message translates to:
  /// **'{value}x'**
  String scanZoomValue(String value);

  /// Instruction shown over the camera picture
  ///
  /// In en, this message translates to:
  /// **'Position QR code or barcode within the frame'**
  String get scanViewfinderHint;

  /// Shown when camera permission is missing on the scanner screen
  ///
  /// In en, this message translates to:
  /// **'Camera permission required'**
  String get scanCameraPermissionRequired;

  /// Short confirmation shown on a button right after copying
  ///
  /// In en, this message translates to:
  /// **'Copied!'**
  String get copiedLabel;

  /// Tooltip on a button that hides secret text
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get hideAction;

  /// Tooltip on a button that shows secret text
  ///
  /// In en, this message translates to:
  /// **'Reveal'**
  String get revealAction;

  /// Button that opens a link despite a safety warning
  ///
  /// In en, this message translates to:
  /// **'Open Anyway'**
  String get openAnywayButton;

  /// Title of the screen showing what was scanned
  ///
  /// In en, this message translates to:
  /// **'Scan Result'**
  String get resultScreenTitle;

  /// Shown when the screen opens with nothing scanned
  ///
  /// In en, this message translates to:
  /// **'No result'**
  String get resultNoResult;

  /// Label above the scanned content
  ///
  /// In en, this message translates to:
  /// **'Content:'**
  String get resultContentLabel;

  /// Label above the visible content of a code that also hides a secret
  ///
  /// In en, this message translates to:
  /// **'Public Decoy Content:'**
  String get resultDecoyContentLabel;

  /// Label above the kind of code that was scanned
  ///
  /// In en, this message translates to:
  /// **'Detected Type:'**
  String get resultDetectedType;

  /// Type name for a code that carries a hidden encrypted layer
  ///
  /// In en, this message translates to:
  /// **'STEGO-QR (Encrypted Dual-Layer)'**
  String get resultTypeStego;

  /// Button that runs the link safety checks again
  ///
  /// In en, this message translates to:
  /// **'Re-check'**
  String get resultRecheckButton;

  /// Button that opens the scanned link in a browser
  ///
  /// In en, this message translates to:
  /// **'Open in Browser'**
  String get resultOpenInBrowser;

  /// Button that copies the scanned content
  ///
  /// In en, this message translates to:
  /// **'Copy Text'**
  String get resultCopyText;

  /// Button that copies the visible content of a code hiding a secret
  ///
  /// In en, this message translates to:
  /// **'Copy Decoy Text'**
  String get resultCopyDecoyText;

  /// Button that shares the scanned content
  ///
  /// In en, this message translates to:
  /// **'Share Text'**
  String get resultShareText;

  /// Button that shares the visible content of a code hiding a secret
  ///
  /// In en, this message translates to:
  /// **'Share Decoy Text'**
  String get resultShareDecoyText;

  /// Button that returns to the camera to scan again
  ///
  /// In en, this message translates to:
  /// **'Scan Another Code'**
  String get resultScanAnother;

  /// Message shown when a link could not be opened
  ///
  /// In en, this message translates to:
  /// **'Could not launch URL'**
  String get resultLaunchFailed;

  /// Shown after the hidden secret layer has been unlocked
  ///
  /// In en, this message translates to:
  /// **'The hidden AES-256 encrypted payload has been decrypted successfully.'**
  String get stegoUnlockedMessage;

  /// Shown when a code hides a secret that is still locked
  ///
  /// In en, this message translates to:
  /// **'This QR code contains a hidden, encrypted secret layer. Authenticate to view the hidden payload.'**
  String get stegoLockedMessage;

  /// Button that unlocks the secret using fingerprint or face
  ///
  /// In en, this message translates to:
  /// **'Biometric Unlock'**
  String get stegoBiometricUnlock;

  /// Button and field label for the secret password
  ///
  /// In en, this message translates to:
  /// **'Passphrase'**
  String get stegoPassphrase;

  /// Label above the unlocked secret content
  ///
  /// In en, this message translates to:
  /// **'Secret Payload:'**
  String get stegoSecretPayload;

  /// Button that copies the unlocked secret
  ///
  /// In en, this message translates to:
  /// **'Copy Secret'**
  String get stegoCopySecret;

  /// Button that shares the unlocked secret
  ///
  /// In en, this message translates to:
  /// **'Share Secret'**
  String get stegoShareSecret;

  /// Message shown after the secret is copied
  ///
  /// In en, this message translates to:
  /// **'Secret copied to clipboard'**
  String get stegoSecretCopied;

  /// Title of the unlock dialog when fingerprint or face is also used
  ///
  /// In en, this message translates to:
  /// **'Biometric + Passphrase'**
  String get stegoDialogTitleBiometric;

  /// Title of the unlock dialog when only the password is used
  ///
  /// In en, this message translates to:
  /// **'Enter Passphrase'**
  String get stegoDialogTitlePassphrase;

  /// Explanation in the unlock dialog when fingerprint or face is also used
  ///
  /// In en, this message translates to:
  /// **'Confirm passphrase to authenticate with biometrics and decrypt payload.'**
  String get stegoDialogMessageBiometric;

  /// Explanation in the unlock dialog when only the password is used
  ///
  /// In en, this message translates to:
  /// **'Enter the passphrase used to encrypt the secret payload.'**
  String get stegoDialogMessagePassphrase;

  /// Button that confirms the unlock dialog
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get stegoUnlockButton;

  /// Title shown while the link safety checks are running
  ///
  /// In en, this message translates to:
  /// **'Security Check In Progress'**
  String get safetyCheckInProgress;

  /// Title of the link safety result panel
  ///
  /// In en, this message translates to:
  /// **'URL Security Analysis'**
  String get safetyAnalysisTitle;

  /// Shown under the panel while the checks run
  ///
  /// In en, this message translates to:
  /// **'Analyzing URL security...'**
  String get safetyAnalyzing;

  /// How many safety checks failed
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 security issue detected} other{{count} security issues detected}}'**
  String safetyIssuesDetected(int count);

  /// Shown when every safety check passed
  ///
  /// In en, this message translates to:
  /// **'No issues detected'**
  String get safetyNoIssues;

  /// Advice shown when the link passed the checks but still needs care
  ///
  /// In en, this message translates to:
  /// **'Only open this URL if you trust the source'**
  String get safetyTrustSourceHint;

  /// Heading above the list of individual safety checks
  ///
  /// In en, this message translates to:
  /// **'Security Analysis Results:'**
  String get safetyResultsHeading;

  /// Banner shown when the app contacted the scanned site directly
  ///
  /// In en, this message translates to:
  /// **'Active online checks are ON: SSL, redirect and shortener checks contacted this site directly, exposing your IP address to it. Turn off \"Active online checks\" in Settings to check links privately.'**
  String get probingBannerActive;

  /// Banner shown when the app checked the link without contacting the site
  ///
  /// In en, this message translates to:
  /// **'Private mode: this link was analysed using local rules and Google Safe Browsing only — the site itself was never contacted, so your IP and device were not exposed. Enable \"Active online checks\" in Settings for live SSL/redirect verification.'**
  String get probingBannerPrivate;

  /// Title of the dialog shown before opening a risky link
  ///
  /// In en, this message translates to:
  /// **'Security Warning'**
  String get warningDialogTitle;

  /// Warning shown before opening a link that failed the checks
  ///
  /// In en, this message translates to:
  /// **'This URL has security issues. Opening it may put your device or data at risk.\n\nAre you sure you want to proceed?'**
  String get warningDialogMessage;

  /// Title of the dialog shown before opening any scanned link
  ///
  /// In en, this message translates to:
  /// **'Caution'**
  String get cautionDialogTitle;

  /// Advice shown before opening a link that passed the checks
  ///
  /// In en, this message translates to:
  /// **'Always verify the source before opening URLs from QR codes.\n\nDo you want to open this URL?'**
  String get cautionDialogMessage;

  /// Name of the laser line scan overlay style
  ///
  /// In en, this message translates to:
  /// **'Laser Line'**
  String get overlayLaserLine;

  /// Name of the pulsing corners scan overlay style
  ///
  /// In en, this message translates to:
  /// **'Pulsing Corners'**
  String get overlayPulsingCorners;

  /// Name of the grid scan overlay style
  ///
  /// In en, this message translates to:
  /// **'Cybernetic Grid'**
  String get overlayCyberneticGrid;

  /// Name of the dot matrix scan overlay style
  ///
  /// In en, this message translates to:
  /// **'Subtle Dot Matrix'**
  String get overlaySubtleDotMatrix;

  /// Explanation of the laser line overlay style
  ///
  /// In en, this message translates to:
  /// **'Scanning box with an animated vertical laser beam and glow line'**
  String get overlayLaserLineDesc;

  /// Explanation of the pulsing corners overlay style
  ///
  /// In en, this message translates to:
  /// **'Breathing corner reticles with color glow and scale animation'**
  String get overlayPulsingCornersDesc;

  /// Explanation of the grid overlay style
  ///
  /// In en, this message translates to:
  /// **'Sci-fi grid overlay pattern with target crosshair reticle'**
  String get overlayCyberneticGridDesc;

  /// Explanation of the dot matrix overlay style
  ///
  /// In en, this message translates to:
  /// **'Minimalist corner dot matrix pattern with pulsing accents'**
  String get overlaySubtleDotMatrixDesc;

  /// Theme setting that follows the device
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get themeSystemDefault;

  /// Light theme setting
  ///
  /// In en, this message translates to:
  /// **'Light Theme'**
  String get themeLight;

  /// Dark theme setting
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get themeDark;

  /// Pure black theme setting for OLED screens
  ///
  /// In en, this message translates to:
  /// **'OLED Pure Black'**
  String get themeOled;

  /// Heading above the theme choice buttons
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeModeHeading;

  /// Short theme button that follows the device
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeChipSystem;

  /// Short theme button for the light theme
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeChipLight;

  /// Short theme button for the dark theme
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeChipDark;

  /// Short theme button for the pure black theme
  ///
  /// In en, this message translates to:
  /// **'OLED'**
  String get themeChipOled;

  /// Setting that takes colours from the device wallpaper
  ///
  /// In en, this message translates to:
  /// **'Material You Dynamic Colors'**
  String get themeDynamicColorsTitle;

  /// Explanation of the wallpaper colour setting
  ///
  /// In en, this message translates to:
  /// **'Sample system wallpaper colors on Android 12+ (Monet engine)'**
  String get themeDynamicColorsSubtitle;

  /// Explanation shown for the system theme
  ///
  /// In en, this message translates to:
  /// **'Follow System Settings'**
  String get themeDescSystem;

  /// Explanation shown for the light theme
  ///
  /// In en, this message translates to:
  /// **'Standard Light Mode'**
  String get themeDescLight;

  /// Explanation shown for the dark theme
  ///
  /// In en, this message translates to:
  /// **'Standard Dark Mode'**
  String get themeDescDark;

  /// Explanation shown for the pure black theme
  ///
  /// In en, this message translates to:
  /// **'True OLED Pure Black (Battery Saving)'**
  String get themeDescOled;

  /// Title of the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Settings card that opens the vibration and sound options
  ///
  /// In en, this message translates to:
  /// **'Scan Feedback & Alerts'**
  String get settingsFeedbackTitle;

  /// Settings card that opens the privacy options
  ///
  /// In en, this message translates to:
  /// **'Privacy & Online Probing'**
  String get settingsPrivacyTitle;

  /// Settings card that opens the Safe Browsing key options
  ///
  /// In en, this message translates to:
  /// **'Google Safe Browsing API'**
  String get settingsSafeBrowsingTitle;

  /// Settings card that opens the permissions overview
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get settingsPermissionsTitle;

  /// Explanation under the permissions card
  ///
  /// In en, this message translates to:
  /// **'Explicit, implicit & setting-dependent details'**
  String get settingsPermissionsSubtitle;

  /// Settings card that opens the feature guides
  ///
  /// In en, this message translates to:
  /// **'Help & Feature Guides'**
  String get settingsHelpTitle;

  /// Explanation under the help card
  ///
  /// In en, this message translates to:
  /// **'AR CodeVision, AirQR, Quishing Guard & URL Safety'**
  String get settingsHelpSubtitle;

  /// Explanation under the about card
  ///
  /// In en, this message translates to:
  /// **'App version, developer & license details'**
  String get settingsAboutSubtitle;

  /// Setting that turns scan vibration on or off
  ///
  /// In en, this message translates to:
  /// **'Vibration Feedback'**
  String get feedbackVibrationTitle;

  /// Explanation of the vibration setting
  ///
  /// In en, this message translates to:
  /// **'Vibrate phone upon successful barcode recognition'**
  String get feedbackVibrationSubtitle;

  /// Setting that turns the scan beep on or off
  ///
  /// In en, this message translates to:
  /// **'Audible Beep Sound'**
  String get feedbackSoundTitle;

  /// Explanation of the beep setting
  ///
  /// In en, this message translates to:
  /// **'Play audio beep signal upon successful code recognition'**
  String get feedbackSoundSubtitle;

  /// Setting that turns the visual scan confirmation animation on or off
  ///
  /// In en, this message translates to:
  /// **'Confirmation Animation'**
  String get feedbackAnimationTitle;

  /// Explanation of the visual animation setting
  ///
  /// In en, this message translates to:
  /// **'Play reticle pulse and checkmark morph upon successful scan'**
  String get feedbackAnimationSubtitle;

  /// Title of the privacy settings screen
  ///
  /// In en, this message translates to:
  /// **'Privacy & Network Probing'**
  String get privacyScreenTitle;

  /// Setting that allows contacting the scanned site directly
  ///
  /// In en, this message translates to:
  /// **'Active online checks'**
  String get privacyActiveChecksTitle;

  /// Summary shown on the settings card when online checks are on
  ///
  /// In en, this message translates to:
  /// **'Active online checks enabled'**
  String get privacySummaryOn;

  /// Summary shown on the settings card when online checks are off
  ///
  /// In en, this message translates to:
  /// **'Private offline checks only'**
  String get privacySummaryOff;

  /// Shown when a Safe Browsing key is saved
  ///
  /// In en, this message translates to:
  /// **'Configured'**
  String get apiKeyConfigured;

  /// Shown when no Safe Browsing key is saved
  ///
  /// In en, this message translates to:
  /// **'Not configured'**
  String get apiKeyNotConfigured;

  /// Message shown after the key is saved
  ///
  /// In en, this message translates to:
  /// **'API key saved securely'**
  String get apiKeySaved;

  /// Message shown after the key is deleted
  ///
  /// In en, this message translates to:
  /// **'API key deleted'**
  String get apiKeyDeleted;

  /// Title of the dialog and button for deleting the key
  ///
  /// In en, this message translates to:
  /// **'Delete API Key'**
  String get apiKeyDeleteTitle;

  /// Button that confirms deleting something
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// Heading of the panel explaining the Safe Browsing service
  ///
  /// In en, this message translates to:
  /// **'About Safe Browsing API'**
  String get apiAboutHeading;

  /// Title shown when a key is in place
  ///
  /// In en, this message translates to:
  /// **'API Key Configured'**
  String get apiKeyConfiguredTitle;

  /// Explanation shown when a key is in place
  ///
  /// In en, this message translates to:
  /// **'Malicious URL checking is enabled'**
  String get apiKeyConfiguredSubtitle;

  /// Shown when the free daily lookups are used up
  ///
  /// In en, this message translates to:
  /// **'Daily limit reached. Resets tomorrow.'**
  String get apiLimitReached;

  /// Shown when few free daily lookups are left
  ///
  /// In en, this message translates to:
  /// **'Approaching daily limit'**
  String get apiLimitApproaching;

  /// Label of the field holding the Safe Browsing key
  ///
  /// In en, this message translates to:
  /// **'API Key'**
  String get apiKeyFieldLabel;

  /// Hint inside the empty key field
  ///
  /// In en, this message translates to:
  /// **'Enter your Google Safe Browsing API key'**
  String get apiKeyFieldHint;

  /// Validation message when the key field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter an API key'**
  String get apiKeyRequired;

  /// Validation message when the key looks wrong
  ///
  /// In en, this message translates to:
  /// **'API key appears to be too short'**
  String get apiKeyTooShort;

  /// Button that stores the key
  ///
  /// In en, this message translates to:
  /// **'Save API Key'**
  String get apiKeySaveButton;

  /// Heading of the step-by-step key instructions
  ///
  /// In en, this message translates to:
  /// **'How to get an API key'**
  String get apiHowToHeading;

  /// First step of getting a key
  ///
  /// In en, this message translates to:
  /// **'Go to Google Cloud Console'**
  String get apiStep1Title;

  /// Explanation of the first step
  ///
  /// In en, this message translates to:
  /// **'Visit console.cloud.google.com'**
  String get apiStep1Desc;

  /// Second step of getting a key
  ///
  /// In en, this message translates to:
  /// **'Create or select a project'**
  String get apiStep2Title;

  /// Explanation of the second step
  ///
  /// In en, this message translates to:
  /// **'Choose an existing project or create a new one'**
  String get apiStep2Desc;

  /// Third step of getting a key
  ///
  /// In en, this message translates to:
  /// **'Enable Safe Browsing API'**
  String get apiStep3Title;

  /// Fourth step of getting a key
  ///
  /// In en, this message translates to:
  /// **'Create credentials'**
  String get apiStep4Title;

  /// Explanation of the fourth step
  ///
  /// In en, this message translates to:
  /// **'Go to Credentials → Create Credentials → API Key'**
  String get apiStep4Desc;

  /// Fifth step of getting a key
  ///
  /// In en, this message translates to:
  /// **'Copy and paste'**
  String get apiStep5Title;

  /// Explanation of the fifth step
  ///
  /// In en, this message translates to:
  /// **'Copy the generated API key and paste it above'**
  String get apiStep5Desc;

  /// Note about the free daily allowance
  ///
  /// In en, this message translates to:
  /// **'Free tier includes 10,000 requests per day'**
  String get apiFreeTierNote;

  /// Title of the permissions screen
  ///
  /// In en, this message translates to:
  /// **'Permissions Overview'**
  String get permissionsScreenTitle;

  /// Heading for permissions the user is asked for
  ///
  /// In en, this message translates to:
  /// **'Explicit Permissions (Runtime / Manifest)'**
  String get permissionsExplicitHeading;

  /// Name of the camera permission
  ///
  /// In en, this message translates to:
  /// **'Camera Access (android.permission.CAMERA)'**
  String get permissionCameraTitle;

  /// What the camera permission is used for
  ///
  /// In en, this message translates to:
  /// **'Requested on-demand at point of use. Required for live scanning, AR CodeVision HUD overlay, and AirQR optical stream decoding.'**
  String get permissionCameraDesc;

  /// Name of the fingerprint and face permission
  ///
  /// In en, this message translates to:
  /// **'Biometric Authentication (android.permission.USE_BIOMETRIC)'**
  String get permissionBiometricTitle;

  /// What the biometric permission is used for
  ///
  /// In en, this message translates to:
  /// **'Requested when unlocking biometric secure vaults or encrypted QR code payloads.'**
  String get permissionBiometricDesc;

  /// Heading for permissions granted by the system
  ///
  /// In en, this message translates to:
  /// **'Implicit & System Permissions'**
  String get permissionsImplicitHeading;

  /// Name of the internet permission
  ///
  /// In en, this message translates to:
  /// **'Internet Access (android.permission.INTERNET)'**
  String get permissionInternetTitle;

  /// What the internet permission is used for
  ///
  /// In en, this message translates to:
  /// **'Declared in Android Manifest. Used only when Active Online Probing or Google Safe Browsing API lookup is enabled.'**
  String get permissionInternetDesc;

  /// Name of the vibration permission
  ///
  /// In en, this message translates to:
  /// **'Vibration & Haptics (android.permission.VIBRATE)'**
  String get permissionVibrateTitle;

  /// What the vibration permission is used for
  ///
  /// In en, this message translates to:
  /// **'System permission. Triggers haptic vibration feedback during scan alerts and button taps.'**
  String get permissionVibrateDesc;

  /// Name of the photo picker access
  ///
  /// In en, this message translates to:
  /// **'Scoped Media Photo Picker'**
  String get permissionPhotoPickerTitle;

  /// What the photo picker access is used for
  ///
  /// In en, this message translates to:
  /// **'System photo picker access. Allows selecting QR images or videos from gallery without requesting full storage access.'**
  String get permissionPhotoPickerDesc;

  /// Heading for permissions that depend on a setting
  ///
  /// In en, this message translates to:
  /// **'Setting-Dependent Permissions'**
  String get permissionsSettingHeading;

  /// Name of the active online checks setting
  ///
  /// In en, this message translates to:
  /// **'Active Online Probing (Privacy Setting)'**
  String get permissionProbingTitle;

  /// What active online checks do
  ///
  /// In en, this message translates to:
  /// **'Active only when enabled. Performs outbound HTTP HEAD requests to follow URL redirects and check SSL certificates. When disabled, checks are 100% offline.'**
  String get permissionProbingDesc;

  /// Name of the Safe Browsing lookup setting
  ///
  /// In en, this message translates to:
  /// **'Google Safe Browsing API (API Key Setting)'**
  String get permissionSafeBrowsingTitle;

  /// What the Safe Browsing lookup does
  ///
  /// In en, this message translates to:
  /// **'Active only when API key is configured. Queries Google Threat API for malware & phishing checks.'**
  String get permissionSafeBrowsingDesc;

  /// Name of the scan vibration setting
  ///
  /// In en, this message translates to:
  /// **'Scan Feedback Vibrations (Alert Setting)'**
  String get permissionFeedbackTitle;

  /// When scan vibration is used
  ///
  /// In en, this message translates to:
  /// **'Active only when Vibration is enabled in Scan Feedback & Alerts settings.'**
  String get permissionFeedbackDesc;

  /// Word shown when a setting is turned on
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get onLabel;

  /// Word shown when a setting is turned off
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get offLabel;

  /// Shown when a value is not known
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownLabel;

  /// Explanation under the active online checks switch
  ///
  /// In en, this message translates to:
  /// **'Off: scanned links are checked privately — the destination server is never contacted.'**
  String get privacyActiveChecksSubtitle;

  /// Longer explanation shown when active online checks are on
  ///
  /// In en, this message translates to:
  /// **'When on, the SSL, redirect and shortener checks connect directly to the scanned site. This exposes your IP address (and therefore your approximate location and mobile carrier) to that server before you open the link.'**
  String get privacyExplainerOn;

  /// Longer explanation shown when active online checks are off
  ///
  /// In en, this message translates to:
  /// **'SSL, redirect and shortener checks run from local rules only. Malicious-content lookup still uses Google Safe Browsing (the link is sent only to Google, never to the scanned site).'**
  String get privacyExplainerOff;

  /// Warning shown before the Safe Browsing key is deleted
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your Google Safe Browsing API key? URL malicious content checking will be disabled.'**
  String get apiKeyDeleteMessage;

  /// Explanation of what the Safe Browsing service does
  ///
  /// In en, this message translates to:
  /// **'The Google Safe Browsing API helps detect malicious URLs including phishing, malware, and unwanted software. Your API key is stored securely and encrypted on your device.'**
  String get apiAboutBody;

  /// Heading above how many lookups were used today
  ///
  /// In en, this message translates to:
  /// **'Today\'s Usage'**
  String get apiTodaysUsage;

  /// Explanation of the third step of getting a key
  ///
  /// In en, this message translates to:
  /// **'Search for \"Safe Browsing API\" and enable it'**
  String get apiStep3Desc;

  /// Summary of the scan feedback settings shown on the settings card
  ///
  /// In en, this message translates to:
  /// **'Vibration: {vibration} • Sound: {sound}'**
  String feedbackSummary(String vibration, String sound);

  /// Whether a Safe Browsing key is saved, shown on the settings card
  ///
  /// In en, this message translates to:
  /// **'API Key: {status}'**
  String settingsApiKeySubtitle(String status);

  /// Message shown when the key could not be saved
  ///
  /// In en, this message translates to:
  /// **'Error saving API key: {error}'**
  String apiKeySaveFailed(String error);

  /// Message shown when the key could not be deleted
  ///
  /// In en, this message translates to:
  /// **'Error deleting API key: {error}'**
  String apiKeyDeleteFailed(String error);

  /// How many free lookups are allowed each day
  ///
  /// In en, this message translates to:
  /// **'Daily Limit: {count} requests per day'**
  String apiDailyLimit(int count);

  /// When the daily lookup count starts again
  ///
  /// In en, this message translates to:
  /// **'Resets: {date}'**
  String apiResets(String date);

  /// Type label shown when the scanned code is plain text
  ///
  /// In en, this message translates to:
  /// **'TEXT'**
  String get resultTypeTextFallback;

  /// Name of the check that looks for an encrypted connection
  ///
  /// In en, this message translates to:
  /// **'HTTPS Connection'**
  String get checkNameHttps;

  /// Name of the check that inspects the site certificate
  ///
  /// In en, this message translates to:
  /// **'SSL/TLS Certificate'**
  String get checkNameSsl;

  /// Name of the check that follows link forwarding
  ///
  /// In en, this message translates to:
  /// **'Redirect Analysis'**
  String get checkNameRedirect;

  /// Name of the check that looks for suspicious link patterns
  ///
  /// In en, this message translates to:
  /// **'Pattern Detection'**
  String get checkNamePattern;

  /// Name of the check that spots shortened links
  ///
  /// In en, this message translates to:
  /// **'URL Shortener Check'**
  String get checkNameShortener;

  /// Name of the check that spots lookalike characters
  ///
  /// In en, this message translates to:
  /// **'Homograph Attack Check'**
  String get checkNameHomograph;

  /// Name of the Google Safe Browsing lookup
  ///
  /// In en, this message translates to:
  /// **'Malicious Content Check'**
  String get checkNameMalicious;

  /// Result when the link is not encrypted
  ///
  /// In en, this message translates to:
  /// **'URL uses unencrypted HTTP connection'**
  String get httpsNotUsed;

  /// Result when only the scheme was checked, to protect privacy
  ///
  /// In en, this message translates to:
  /// **'Uses HTTPS (live certificate not checked in private mode)'**
  String get sslPrivateModeOk;

  /// Result when the site certificate is good
  ///
  /// In en, this message translates to:
  /// **'Valid SSL certificate'**
  String get sslValid;

  /// Result when the site certificate has run out
  ///
  /// In en, this message translates to:
  /// **'SSL certificate has expired'**
  String get sslExpired;

  /// Result when the site certificate starts in the future
  ///
  /// In en, this message translates to:
  /// **'SSL certificate not yet valid'**
  String get sslNotYetValid;

  /// Result when the certificate could not be read
  ///
  /// In en, this message translates to:
  /// **'Unable to verify certificate'**
  String get sslUnverifiable;

  /// Result when the certificate check itself failed
  ///
  /// In en, this message translates to:
  /// **'Certificate check failed'**
  String get sslCheckFailed;

  /// Result when redirects were not followed, to protect privacy
  ///
  /// In en, this message translates to:
  /// **'Skipped in private mode (destination server not contacted)'**
  String get redirectSkippedPrivate;

  /// Result when the link forwards round in a circle
  ///
  /// In en, this message translates to:
  /// **'Redirect loop detected'**
  String get redirectLoop;

  /// Result when the link goes straight to its target
  ///
  /// In en, this message translates to:
  /// **'No redirects detected'**
  String get redirectNone;

  /// Result when link forwarding could not be checked
  ///
  /// In en, this message translates to:
  /// **'Unable to check redirects'**
  String get redirectUnavailable;

  /// Result when the link looks ordinary
  ///
  /// In en, this message translates to:
  /// **'No suspicious patterns found'**
  String get patternNone;

  /// Result when the pattern check could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to analyze patterns'**
  String get patternUnavailable;

  /// Result when only local rules could be used to spot a shortened link
  ///
  /// In en, this message translates to:
  /// **'Unable to perform full check (offline) - heuristics only'**
  String get shortenerOfflineHeuristics;

  /// Result when the link is not shortened
  ///
  /// In en, this message translates to:
  /// **'No URL shortener detected'**
  String get shortenerNone;

  /// Result when the shortener check could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to check for shorteners'**
  String get shortenerUnavailable;

  /// Result when a domain mixes alphabets, a common trick
  ///
  /// In en, this message translates to:
  /// **'Mixed character scripts detected'**
  String get homographMixedScripts;

  /// Result when the domain uses one alphabet
  ///
  /// In en, this message translates to:
  /// **'No lookalike characters detected'**
  String get homographNone;

  /// Result when the lookalike check could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to check for homographs'**
  String get homographUnavailable;

  /// Result when no Safe Browsing key is saved
  ///
  /// In en, this message translates to:
  /// **'Skipped (API key not configured)'**
  String get maliciousSkippedNoKey;

  /// Result when the free daily lookups are used up
  ///
  /// In en, this message translates to:
  /// **'Daily API limit reached (resets tomorrow)'**
  String get maliciousDailyLimit;

  /// Result when Safe Browsing reports nothing
  ///
  /// In en, this message translates to:
  /// **'No known threats detected'**
  String get maliciousNone;

  /// Result when Safe Browsing rejects the key
  ///
  /// In en, this message translates to:
  /// **'Invalid API key or request'**
  String get maliciousInvalidKey;

  /// Result when Safe Browsing asks us to slow down
  ///
  /// In en, this message translates to:
  /// **'Rate limit exceeded'**
  String get maliciousRateLimited;

  /// Result when the Safe Browsing lookup could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to check for malicious content'**
  String get maliciousUnavailable;

  /// Shown when the secret could not be unlocked
  ///
  /// In en, this message translates to:
  /// **'Decryption failed. Invalid passphrase or corrupted data.'**
  String get stegoWrongPassphrase;

  /// Shown when a received stream did not rebuild correctly
  ///
  /// In en, this message translates to:
  /// **'Checksum verification failed during reassembly.'**
  String get airQrChecksumFailed;

  /// Result when a link forwards many times
  ///
  /// In en, this message translates to:
  /// **'Suspicious redirect chain ({count} redirects)'**
  String redirectSuspiciousChain(String count);

  /// Result when a link forwards an ordinary number of times
  ///
  /// In en, this message translates to:
  /// **'{count} redirect(s) - within normal range'**
  String redirectWithinRange(String count);

  /// Result listing the suspicious patterns found in a link
  ///
  /// In en, this message translates to:
  /// **'Detected: {patterns}'**
  String patternDetected(String patterns);

  /// Result naming the shortening service used by a link
  ///
  /// In en, this message translates to:
  /// **'Known URL shortener detected ({shortener})'**
  String shortenerKnown(String shortener);

  /// Result naming where a shortened link actually goes
  ///
  /// In en, this message translates to:
  /// **'Detected URL shortener (redirects to {host})'**
  String shortenerRedirect(String host);

  /// Result listing the lookalike characters found in a domain
  ///
  /// In en, this message translates to:
  /// **'Lookalike characters detected: {characters}'**
  String homographLookalikes(String characters);

  /// Result listing the threat types Safe Browsing reported
  ///
  /// In en, this message translates to:
  /// **'Threats detected: {threats}'**
  String maliciousThreats(String threats);

  /// Result when Safe Browsing returned an unexpected status
  ///
  /// In en, this message translates to:
  /// **'API error (status: {status})'**
  String maliciousApiError(String status);

  /// Label for the VirusTotal URL safety check row
  ///
  /// In en, this message translates to:
  /// **'VirusTotal'**
  String get checkNameVirusTotal;

  /// Result when no VirusTotal key is saved
  ///
  /// In en, this message translates to:
  /// **'Skipped (API key not configured)'**
  String get virusTotalSkippedNoKey;

  /// Result when the VirusTotal free daily quota is exhausted
  ///
  /// In en, this message translates to:
  /// **'Daily limit reached (500/day — resets tomorrow)'**
  String get virusTotalDailyLimit;

  /// Result when VirusTotal reports malicious votes
  ///
  /// In en, this message translates to:
  /// **'Threats detected by {engines} engine(s)'**
  String virusTotalThreats(String engines);

  /// Result when VirusTotal reports the URL is clean
  ///
  /// In en, this message translates to:
  /// **'No threats detected (VirusTotal)'**
  String get virusTotalNone;

  /// Result when VirusTotal rejects the key
  ///
  /// In en, this message translates to:
  /// **'Invalid API key or request (VirusTotal)'**
  String get virusTotalInvalidKey;

  /// Result when VirusTotal asks us to slow down
  ///
  /// In en, this message translates to:
  /// **'Rate limit exceeded (VirusTotal)'**
  String get virusTotalRateLimited;

  /// Result when VirusTotal returned an unexpected HTTP status
  ///
  /// In en, this message translates to:
  /// **'API error (status: {status})'**
  String virusTotalApiError(String status);

  /// Result when the VirusTotal lookup could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to check (VirusTotal)'**
  String get virusTotalUnavailable;

  /// Label for the URLhaus URL safety check row
  ///
  /// In en, this message translates to:
  /// **'URLhaus'**
  String get checkNameUrlhaus;

  /// Result when no URLhaus key is saved
  ///
  /// In en, this message translates to:
  /// **'Skipped (API key not configured)'**
  String get urlhausSkippedNoKey;

  /// Result when URLhaus flags the URL as a malware host
  ///
  /// In en, this message translates to:
  /// **'Malware URL detected: {tags}'**
  String urlhausMalware(String tags);

  /// Result when URLhaus reports the URL is offline or clean
  ///
  /// In en, this message translates to:
  /// **'No known malware hosting (URLhaus)'**
  String get urlhausClean;

  /// Result when URLhaus has no record of this URL
  ///
  /// In en, this message translates to:
  /// **'Not in URLhaus database'**
  String get urlhausNotFound;

  /// Result when URLhaus rejects the auth key
  ///
  /// In en, this message translates to:
  /// **'Invalid API key (URLhaus)'**
  String get urlhausInvalidKey;

  /// Result when URLhaus returned an unexpected HTTP status
  ///
  /// In en, this message translates to:
  /// **'API error (status: {status})'**
  String urlhausApiError(String status);

  /// Result when the URLhaus lookup could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to check (URLhaus)'**
  String get urlhausUnavailable;

  /// Label for the PhishTank URL safety check row
  ///
  /// In en, this message translates to:
  /// **'PhishTank'**
  String get checkNamePhishTank;

  /// Result when PhishTank is toggled off in settings
  ///
  /// In en, this message translates to:
  /// **'Skipped (PhishTank disabled)'**
  String get phishTankSkippedDisabled;

  /// Result when PhishTank confirms the URL is a phishing site
  ///
  /// In en, this message translates to:
  /// **'Known phishing site (PhishTank)'**
  String get phishTankPhishing;

  /// Result when PhishTank says the URL is valid / not phishing
  ///
  /// In en, this message translates to:
  /// **'Not a known phishing site (PhishTank)'**
  String get phishTankClean;

  /// Result when PhishTank has no record of this URL
  ///
  /// In en, this message translates to:
  /// **'Not in PhishTank database'**
  String get phishTankNotInDatabase;

  /// Result when PhishTank returned an unexpected HTTP status
  ///
  /// In en, this message translates to:
  /// **'API error (status: {status})'**
  String phishTankApiError(String status);

  /// Result when the PhishTank lookup could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to check (PhishTank)'**
  String get phishTankUnavailable;

  /// Label for the OpenPhish offline URL safety check row
  ///
  /// In en, this message translates to:
  /// **'OpenPhish'**
  String get checkNameOpenPhish;

  /// Result when OpenPhish is toggled off in settings
  ///
  /// In en, this message translates to:
  /// **'Skipped (OpenPhish disabled)'**
  String get openPhishSkippedDisabled;

  /// Result when the URL appears in the cached OpenPhish feed
  ///
  /// In en, this message translates to:
  /// **'Known phishing site (OpenPhish)'**
  String get openPhishPhishing;

  /// Result when the URL does not appear in the OpenPhish feed
  ///
  /// In en, this message translates to:
  /// **'Not in phishing feed (OpenPhish)'**
  String get openPhishClean;

  /// Result when no cached feed exists and network is unavailable
  ///
  /// In en, this message translates to:
  /// **'Feed unavailable — offline check skipped'**
  String get openPhishFeedStale;

  /// Result when the OpenPhish check could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to check (OpenPhish)'**
  String get openPhishUnavailable;

  /// Settings card that opens the URL safety providers page
  ///
  /// In en, this message translates to:
  /// **'URL Safety Providers'**
  String get settingsUrlSafetyProvidersTitle;

  /// Summary under the URL safety providers card
  ///
  /// In en, this message translates to:
  /// **'{count} provider(s) active'**
  String settingsUrlSafetyProvidersSubtitle(String count);

  /// Help text at the top of the URL safety providers settings screen
  ///
  /// In en, this message translates to:
  /// **'Configure optional online URL safety checks. Each provider is independent. Non-commercial providers require your own free account and API key.'**
  String get urlSafetyProvidersHelpText;

  /// Section header for providers that require the user to supply a key
  ///
  /// In en, this message translates to:
  /// **'Your API Keys'**
  String get urlSafetyUserSuppliedHeader;

  /// Note below the user-supplied section header
  ///
  /// In en, this message translates to:
  /// **'Non-commercial use only'**
  String get urlSafetyUserSuppliedNote;

  /// Section header for providers that are built in and just need a toggle
  ///
  /// In en, this message translates to:
  /// **'Built-In Providers'**
  String get urlSafetyBuiltInHeader;

  /// Note below the built-in providers section header
  ///
  /// In en, this message translates to:
  /// **'No account needed — just toggle on'**
  String get urlSafetyBuiltInNote;

  /// Label for the optional custom API endpoint URL field
  ///
  /// In en, this message translates to:
  /// **'API Endpoint URL'**
  String get providerEndpointLabel;

  /// Hint text inside the API key text field
  ///
  /// In en, this message translates to:
  /// **'Paste your API key'**
  String get providerApiKeyHint;

  /// Prefix label before the registration URL link
  ///
  /// In en, this message translates to:
  /// **'Get a free key at:'**
  String get providerGetKeyAt;

  /// Shows how many daily requests have been used out of the limit
  ///
  /// In en, this message translates to:
  /// **'{used} / {max} requests today'**
  String providerDailyUsage(String used, String max);

  /// Shows when the OpenPhish feed was last downloaded
  ///
  /// In en, this message translates to:
  /// **'Last updated: {datetime}'**
  String openPhishLastUpdated(String datetime);

  /// Button to manually refresh the OpenPhish phishing feed
  ///
  /// In en, this message translates to:
  /// **'Refresh feed now'**
  String get openPhishRefreshNow;

  /// Snackbar after a successful OpenPhish feed refresh
  ///
  /// In en, this message translates to:
  /// **'Feed updated ({count} URLs)'**
  String openPhishFeedRefreshed(String count);

  /// Snackbar when the OpenPhish feed download fails
  ///
  /// In en, this message translates to:
  /// **'Feed refresh failed'**
  String get openPhishFeedFailed;

  /// Toggle switch label for the PhishTank built-in provider
  ///
  /// In en, this message translates to:
  /// **'Enable PhishTank'**
  String get phishTankToggleLabel;

  /// Toggle switch label for the OpenPhish built-in provider
  ///
  /// In en, this message translates to:
  /// **'Enable OpenPhish feed'**
  String get openPhishToggleLabel;

  /// Summary when the printed code looks untouched
  ///
  /// In en, this message translates to:
  /// **'Authentic Printed Code. No physical tampering detected.'**
  String get quishingSummaryAuthentic;

  /// Summary when marks look like ordinary wear
  ///
  /// In en, this message translates to:
  /// **'Wear & Tear Detected. Slight physical surface noise observed.'**
  String get quishingSummaryWearAndTear;

  /// Summary when a sticker may cover the printed code
  ///
  /// In en, this message translates to:
  /// **'High Warning: Physical Overlay Sticker Detected! Verify Before Tapping Links.'**
  String get quishingSummaryHighWarning;

  /// Short status label when the printed code looks untouched
  ///
  /// In en, this message translates to:
  /// **'🟢 Authentic Printed Code'**
  String get quishingStatusAuthentic;

  /// Short status label when marks look like ordinary wear
  ///
  /// In en, this message translates to:
  /// **'🟡 Wear & Tear Detected'**
  String get quishingStatusWearAndTear;

  /// Short status label when a sticker may cover the printed code
  ///
  /// In en, this message translates to:
  /// **'🔴 High Warning: Physical Overlay Sticker Detected!'**
  String get quishingStatusHighWarning;

  /// Finding: a shadow line suggests a raised layer around the code
  ///
  /// In en, this message translates to:
  /// **'Micro-shadow depth step line detected along matrix perimeter'**
  String get quishingSignalMicroShadowPerimeter;

  /// Finding: the print grain colours do not match
  ///
  /// In en, this message translates to:
  /// **'Mismatching inkjet/thermal grain chromatic aberration detected'**
  String get quishingSignalGrainAberration;

  /// Finding: light bounces evenly off the whole surface
  ///
  /// In en, this message translates to:
  /// **'Uniform substrate reflection profile verified'**
  String get quishingSignalUniformReflection;

  /// Finding: print grain is even around the code edge
  ///
  /// In en, this message translates to:
  /// **'Consistent halftone dot density across QR matrix perimeter'**
  String get quishingSignalConsistentDotsQrMatrix;

  /// Finding: the surface reflects light as expected
  ///
  /// In en, this message translates to:
  /// **'Substrate reflection profile verified'**
  String get quishingSignalReflectionVerified;

  /// Finding: print grain is consistent around the code edge
  ///
  /// In en, this message translates to:
  /// **'Halftone dot density consistent across QR matrix perimeter'**
  String get quishingSignalHalftoneConsistentQrMatrix;

  /// Finding: print grain is consistent across the code
  ///
  /// In en, this message translates to:
  /// **'Halftone dot density consistent across matrix'**
  String get quishingSignalHalftoneConsistentMatrix;

  /// Finding: two edges seen where there should be one
  ///
  /// In en, this message translates to:
  /// **'Perimeter double-edge reflection detected around QR matrix'**
  String get quishingSignalDoubleEdgeAroundMatrix;

  /// Finding: a shadow line suggests a sticker border
  ///
  /// In en, this message translates to:
  /// **'Micro-shadow depth step line detected along sticker border'**
  String get quishingSignalMicroShadowStickerBorder;

  /// Finding: the code was printed on different material from its background
  ///
  /// In en, this message translates to:
  /// **'Inkjet/thermal print grain mismatching base substrate'**
  String get quishingSignalGrainMismatchBase;

  /// Finding: ordinary scratches or wear
  ///
  /// In en, this message translates to:
  /// **'Minor surface scratch or wear pattern observed'**
  String get quishingSignalMinorScratch;

  /// Finding: small print grain differences at the edges
  ///
  /// In en, this message translates to:
  /// **'Slight dot density irregularity along edges'**
  String get quishingSignalSlightDotIrregularity;

  /// Finding: print grain is even around the code edge
  ///
  /// In en, this message translates to:
  /// **'Consistent halftone dot density across matrix perimeter'**
  String get quishingSignalConsistentDotsMatrixPerimeter;

  /// Finding naming how many edge zones look doubled
  ///
  /// In en, this message translates to:
  /// **'Perimeter double-edge reflection detected ({zones} boundary zones)'**
  String quishingSignalPerimeterDoubleEdge(String zones);

  /// Finding naming how uneven the print grain is
  ///
  /// In en, this message translates to:
  /// **'Substrate halftone dot density inconsistency detected ({variance}% variance)'**
  String quishingSignalDotDensityVariance(String variance);

  /// Badge when the link is not a normal web address
  ///
  /// In en, this message translates to:
  /// **'Invalid URL scheme'**
  String get domSslInvalidScheme;

  /// Badge when the site uses an encrypted connection
  ///
  /// In en, this message translates to:
  /// **'Uses encrypted HTTPS protocol'**
  String get domSslHttps;

  /// Badge when the site connection is not encrypted
  ///
  /// In en, this message translates to:
  /// **'Unencrypted HTTP connection (High Risk)'**
  String get domSslHttp;

  /// Status when the link cannot be understood
  ///
  /// In en, this message translates to:
  /// **'Invalid or unsupported web URL format.'**
  String get domStatusInvalidUrl;

  /// Status when the site connection is not encrypted
  ///
  /// In en, this message translates to:
  /// **'⚠️ Caution: Unencrypted HTTP site'**
  String get domStatusHttpCaution;

  /// Status when the preview was built with nothing risky left in
  ///
  /// In en, this message translates to:
  /// **'✅ Zero-Trust DOM Sandbox: HTML preview sanitized safely.'**
  String get domStatusSafe;

  /// Status naming where a hidden forward would send the user
  ///
  /// In en, this message translates to:
  /// **'⚠️ Warning: Open Redirect Trap detected pointing to {target}'**
  String domStatusOpenRedirect(String target);

  /// Status naming how new the site domain is
  ///
  /// In en, this message translates to:
  /// **'⚠️ Warning: Newly registered domain ({days} days old)'**
  String domStatusNewDomain(String days);

  /// Shown when the unlock box was left blank
  ///
  /// In en, this message translates to:
  /// **'Passphrase cannot be empty'**
  String get stegoPassphraseEmpty;

  /// Text shown in the system fingerprint or face unlock dialog
  ///
  /// In en, this message translates to:
  /// **'Authenticate to view StegoQR secret payload'**
  String get stegoBiometricReason;

  /// Shown when a chosen picture holds no code
  ///
  /// In en, this message translates to:
  /// **'No barcodes or QR codes detected in image.'**
  String get mediaNoCodeInImage;

  /// Shown when a chosen PDF holds no code
  ///
  /// In en, this message translates to:
  /// **'No barcodes or QR codes found in PDF document.'**
  String get mediaNoCodeInPdf;

  /// Shown when a picture could not be opened or read
  ///
  /// In en, this message translates to:
  /// **'Failed to pick or scan image: {error}'**
  String mediaImagePickFailed(String error);

  /// Shown when a picture could not be analysed
  ///
  /// In en, this message translates to:
  /// **'Error analyzing image: {error}'**
  String mediaImageAnalyzeFailed(String error);

  /// Shown when a PDF could not be opened or read
  ///
  /// In en, this message translates to:
  /// **'Failed to pick or parse PDF: {error}'**
  String mediaPdfPickFailed(String error);

  /// Shown when a PDF could not be scanned
  ///
  /// In en, this message translates to:
  /// **'Failed to scan PDF document: {error}'**
  String mediaPdfScanFailed(String error);

  /// Shown when fingerprint or face unlock was cancelled or did not work
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication canceled or failed.'**
  String get stegoBiometricCanceled;

  /// Label for a QR code holding a web link
  ///
  /// In en, this message translates to:
  /// **'QR (URL)'**
  String get formatQrUrl;

  /// Label for a QR code holding an email address
  ///
  /// In en, this message translates to:
  /// **'QR (Email)'**
  String get formatQrEmail;

  /// Label for a QR code holding a phone number
  ///
  /// In en, this message translates to:
  /// **'QR (Phone)'**
  String get formatQrPhone;

  /// Label for a QR code holding a text message
  ///
  /// In en, this message translates to:
  /// **'QR (SMS)'**
  String get formatQrSms;

  /// Label for a QR code holding Wi-Fi details
  ///
  /// In en, this message translates to:
  /// **'QR (Wi-Fi)'**
  String get formatQrWifi;

  /// Label for a QR code holding a place
  ///
  /// In en, this message translates to:
  /// **'QR (Location)'**
  String get formatQrLocation;

  /// Label for a QR code holding a contact card
  ///
  /// In en, this message translates to:
  /// **'QR (Contact)'**
  String get formatQrContact;

  /// Label for a book barcode
  ///
  /// In en, this message translates to:
  /// **'ISBN'**
  String get formatIsbn;

  /// Label for a product barcode
  ///
  /// In en, this message translates to:
  /// **'EAN/UPC'**
  String get formatEanUpc;

  /// Label for a plain QR code
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get formatQrCode;

  /// Label for a shop product barcode
  ///
  /// In en, this message translates to:
  /// **'EAN/UPC Product'**
  String get formatEanUpcProduct;

  /// Label for any other barcode
  ///
  /// In en, this message translates to:
  /// **'Barcode'**
  String get formatBarcode;

  /// Shown in place of the network name when a Wi-Fi code hides it
  ///
  /// In en, this message translates to:
  /// **'Hidden Network'**
  String get wifiHiddenNetwork;

  /// Shown in place of the account name when a 2FA code has none
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get totpDefaultAccount;

  /// Shown when a backup file cannot be read at all
  ///
  /// In en, this message translates to:
  /// **'Invalid backup file format.'**
  String get backupInvalidFormat;

  /// Shown when a backup file is not one this app wrote
  ///
  /// In en, this message translates to:
  /// **'Unrecognized or corrupted backup file header.'**
  String get backupBadHeader;

  /// Shown when a backup could not be unlocked
  ///
  /// In en, this message translates to:
  /// **'Incorrect passphrase or corrupted backup payload.'**
  String get backupWrongPassphrase;

  /// Heading at the top of the exported history report
  ///
  /// In en, this message translates to:
  /// **'SREERAJP QR STUDIO - SCAN HISTORY'**
  String get reportHeading;

  /// Title inside the exported PDF report
  ///
  /// In en, this message translates to:
  /// **'Scan History Export'**
  String get reportTitle;

  /// Label before the date the report was made
  ///
  /// In en, this message translates to:
  /// **'Export Date'**
  String get reportExportDate;

  /// Label before how many scans the report covers
  ///
  /// In en, this message translates to:
  /// **'Total Scans'**
  String get reportTotalScans;

  /// Label before the number of each scan in the text report
  ///
  /// In en, this message translates to:
  /// **'Scan #'**
  String get reportScanNumber;

  /// Row label for the scan id, padded to line up
  ///
  /// In en, this message translates to:
  /// **'ID           '**
  String get reportId;

  /// Row label for the scan time, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Timestamp    '**
  String get reportTimestamp;

  /// Row label for the code format, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Format       '**
  String get reportFormat;

  /// Row label for the scan category, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Category     '**
  String get reportCategory;

  /// Row label for the safety score, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Safety Score '**
  String get reportSafetyScore;

  /// Row label for whether the scan is a favourite, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Starred      '**
  String get reportStarred;

  /// Shown when a scan is a favourite
  ///
  /// In en, this message translates to:
  /// **'⭐ Yes'**
  String get reportStarredYes;

  /// Shown when a scan is not a favourite
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get reportStarredNo;

  /// Row label for the place of the scan, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Location     '**
  String get reportLocation;

  /// Row label for the user note, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Notes        '**
  String get reportNotes;

  /// Row label for the scanned content, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Content      '**
  String get reportContent;

  /// PDF table column for the scan time
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get reportColumnDateTime;

  /// PDF table column for the code format
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get reportColumnFormat;

  /// PDF table column for the scan category
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get reportColumnCategory;

  /// PDF table column for the safety score
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get reportColumnSafety;

  /// PDF table column for a short piece of the content
  ///
  /// In en, this message translates to:
  /// **'Content Snippet'**
  String get reportColumnContent;

  /// PDF table column for the user note
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get reportColumnNotes;

  /// Suspicious pattern: the link uses a raw IP address
  ///
  /// In en, this message translates to:
  /// **'IP Address'**
  String get patternIpAddress;

  /// Suspicious pattern: a long run of digits
  ///
  /// In en, this message translates to:
  /// **'Long Number Sequence'**
  String get patternLongNumbers;

  /// Suspicious pattern: many dashes or underscores
  ///
  /// In en, this message translates to:
  /// **'Multiple Dashes/Underscores'**
  String get patternManyDashes;

  /// Suspicious pattern: words often used in phishing links
  ///
  /// In en, this message translates to:
  /// **'Phishing Keywords'**
  String get patternPhishingKeywords;

  /// Suspicious pattern: the link embeds data directly
  ///
  /// In en, this message translates to:
  /// **'Data URI'**
  String get patternDataUri;

  /// Suspicious pattern: unusually many subdomains
  ///
  /// In en, this message translates to:
  /// **'Multiple Subdomains'**
  String get patternManySubdomains;

  /// Result when a link looks shortened by its shape
  ///
  /// In en, this message translates to:
  /// **'Possible URL shortener: short domain with minimal path'**
  String get shortenerPossibleShortDomain;

  /// Result when a link path looks machine-generated
  ///
  /// In en, this message translates to:
  /// **'Possible URL shortener: random character pattern in short path'**
  String get shortenerPossibleRandomPath;

  /// Result naming the domain ending that suggests a shortened link
  ///
  /// In en, this message translates to:
  /// **'Possible URL shortener: short domain with common shortener ending ({tld})'**
  String shortenerPossibleTld(String tld);

  /// Title of the Features settings card
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get settingsFeaturesTitle;

  /// Subtitle of the Features settings card
  ///
  /// In en, this message translates to:
  /// **'Explore all features of SreerajP QR Studio'**
  String get settingsFeaturesSubtitle;

  /// Title of the Appearance preferences hub screen
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceHubTitle;

  /// Title of the Theme Mode card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get appearanceThemeModeCardTitle;

  /// Subtitle of the Theme Mode card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'Choose between System, Light, Dark, or OLED mode'**
  String get appearanceThemeModeCardSubtitle;

  /// Title of the Scan Overlay Style card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'Scan Overlay Style'**
  String get appearanceOverlayCardTitle;

  /// Subtitle of the Scan Overlay Style card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'Laser line, pulsing corners, cybernetic grid, or dot matrix'**
  String get appearanceOverlayCardSubtitle;

  /// Title of the Accent Color card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'Accent Color & Dynamic Colors'**
  String get appearanceAccentCardTitle;

  /// Subtitle of the Accent Color card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'Material You dynamic color and custom accent palettes'**
  String get appearanceAccentCardSubtitle;

  /// Title of the Typography & Text Size card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'Typography & Text Size'**
  String get appearanceTypographyCardTitle;

  /// Subtitle of the Typography & Text Size card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'App font family and text scale preferences'**
  String get appearanceTypographyCardSubtitle;

  /// Hero header title on the Features screen
  ///
  /// In en, this message translates to:
  /// **'SreerajP QR Studio Features'**
  String get featuresHeaderTitle;

  /// Hero header subtitle on the Features screen
  ///
  /// In en, this message translates to:
  /// **'Explore every intelligent scanning tool, 6-layer URL safety engine, AR CodeVision, and offline feature designed for you.'**
  String get featuresHeaderSubtitle;

  /// Features screen: name of the core scanning category
  ///
  /// In en, this message translates to:
  /// **'Core Scanning & Ingestion'**
  String get featuresCatScanningName;

  /// Features screen: subtitle of the core scanning category
  ///
  /// In en, this message translates to:
  /// **'Lightning-fast 1D/2D barcode engine with multi-source media support'**
  String get featuresCatScanningSubtitle;

  /// Features screen: name of the URL safety engine category
  ///
  /// In en, this message translates to:
  /// **'6-Layer URL Safety & Forensic Engine'**
  String get featuresCatSafetyName;

  /// Features screen: subtitle of the URL safety engine category
  ///
  /// In en, this message translates to:
  /// **'Zero-trust forensic analysis defending you against malicious QR phishing & scams'**
  String get featuresCatSafetySubtitle;

  /// Features screen: name of the QuishingGuard and AI vision category
  ///
  /// In en, this message translates to:
  /// **'QuishingGuard™ & Advanced AI Vision'**
  String get featuresCatVisionName;

  /// Features screen: subtitle of the QuishingGuard and AI vision category
  ///
  /// In en, this message translates to:
  /// **'Cutting-edge on-device computer vision and optical air-gap data streaming'**
  String get featuresCatVisionSubtitle;

  /// Features screen: name of the smart payloads category
  ///
  /// In en, this message translates to:
  /// **'Smart Payloads & 1-Tap Integrations'**
  String get featuresCatPayloadsName;

  /// Features screen: subtitle of the smart payloads category
  ///
  /// In en, this message translates to:
  /// **'Instant parsing and contextual native actions for everyday barcodes'**
  String get featuresCatPayloadsSubtitle;

  /// Features screen: name of the history and privacy category
  ///
  /// In en, this message translates to:
  /// **'History, Backup & Privacy Vault'**
  String get featuresCatHistoryName;

  /// Features screen: subtitle of the history and privacy category
  ///
  /// In en, this message translates to:
  /// **'Your personal scan history protected by biometric security and offline storage'**
  String get featuresCatHistorySubtitle;

  /// Features screen: title of the barcode engine feature
  ///
  /// In en, this message translates to:
  /// **'Multi-Format Barcode Engine'**
  String get featureBarcodeEngineTitle;

  /// Features screen: description of the barcode engine feature
  ///
  /// In en, this message translates to:
  /// **'Instantly decodes 1D barcodes (EAN-13, UPC-A, Code 128, Code 39, Codabar, ITF) and 2D codes (QR, Data Matrix, Aztec, PDF417) in milliseconds.'**
  String get featureBarcodeEngineDesc;

  /// Features screen: highlight chip 1 of the barcode engine feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'QR & Data Matrix'**
  String get featureBarcodeEngineChip1;

  /// Features screen: highlight chip 2 of the barcode engine feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Aztec & PDF417'**
  String get featureBarcodeEngineChip2;

  /// Features screen: highlight chip 3 of the barcode engine feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'EAN & Code 128'**
  String get featureBarcodeEngineChip3;

  /// Features screen: title of the multi-source media feature
  ///
  /// In en, this message translates to:
  /// **'Multi-Source Media & PDF Ingestion'**
  String get featureMediaSourcesTitle;

  /// Features screen: description of the multi-source media feature
  ///
  /// In en, this message translates to:
  /// **'Scan barcodes from live camera feed, select existing images from your gallery, or extract and parse barcodes across multi-page PDF documents.'**
  String get featureMediaSourcesDesc;

  /// Features screen: highlight chip 1 of the multi-source media feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Gallery Photos'**
  String get featureMediaSourcesChip1;

  /// Features screen: highlight chip 2 of the multi-source media feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Multi-Page PDF'**
  String get featureMediaSourcesChip2;

  /// Features screen: highlight chip 3 of the multi-source media feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Live Viewport'**
  String get featureMediaSourcesChip3;

  /// Features screen: title of the GhostScan feature
  ///
  /// In en, this message translates to:
  /// **'GhostScan Screen Content Detector'**
  String get featureGhostScanTitle;

  /// Features screen: description of the GhostScan feature
  ///
  /// In en, this message translates to:
  /// **'Detects and decodes QR codes visible on your screen inside messaging apps, social feeds, and web browsers via Quick Settings tile, the floating Scan bubble, or on-demand trigger without saving screenshots.'**
  String get featureGhostScanDesc;

  /// Features screen: highlight chip 1 of the GhostScan feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Quick Settings Tile'**
  String get featureGhostScanChip1;

  /// Features screen: highlight chip 2 of the GhostScan feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Floating Scan Bubble'**
  String get featureGhostScanChip2;

  /// Features screen: highlight chip 3 of the GhostScan feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'No Screenshots Saved'**
  String get featureGhostScanChip3;

  /// Features screen: title of the camera controls feature
  ///
  /// In en, this message translates to:
  /// **'Precision Camera Controls'**
  String get featureCameraControlsTitle;

  /// Features screen: description of the camera controls feature
  ///
  /// In en, this message translates to:
  /// **'Smooth zoom slider, torch flashlight toggle, front and rear camera switching, and continuous autofocus for low-light scanning.'**
  String get featureCameraControlsDesc;

  /// Features screen: highlight chip 1 of the camera controls feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Flashlight Torch'**
  String get featureCameraControlsChip1;

  /// Features screen: highlight chip 2 of the camera controls feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Zoom Control'**
  String get featureCameraControlsChip2;

  /// Features screen: highlight chip 3 of the camera controls feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Front/Back Flip'**
  String get featureCameraControlsChip3;

  /// Features screen: title of the scan overlays feature
  ///
  /// In en, this message translates to:
  /// **'Customizable Scan Overlays'**
  String get featureScanOverlaysTitle;

  /// Features screen: description of the scan overlays feature
  ///
  /// In en, this message translates to:
  /// **'Choose between Laser Line, Pulsing Corners, Cybernetic Grid, or Subtle Dot Matrix viewfinder overlays with live feedback.'**
  String get featureScanOverlaysDesc;

  /// Features screen: highlight chip 1 of the scan overlays feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'4 Overlay Styles'**
  String get featureScanOverlaysChip1;

  /// Features screen: highlight chip 2 of the scan overlays feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Live Animation'**
  String get featureScanOverlaysChip2;

  /// Features screen: highlight chip 3 of the scan overlays feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'OLED Compatible'**
  String get featureScanOverlaysChip3;

  /// Features screen: title of the haptic and audio feedback feature
  ///
  /// In en, this message translates to:
  /// **'Tactile Haptic & Audio Feedback'**
  String get featureFeedbackTitle;

  /// Features screen: description of the haptic and audio feedback feature
  ///
  /// In en, this message translates to:
  /// **'Customizable vibration pulses and audible beep tones confirm successful recognition even in noisy environments.'**
  String get featureFeedbackDesc;

  /// Features screen: highlight chip 1 of the haptic and audio feedback feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Haptic Pulse'**
  String get featureFeedbackChip1;

  /// Features screen: highlight chip 2 of the haptic and audio feedback feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Audio Beep'**
  String get featureFeedbackChip2;

  /// Features screen: highlight chip 3 of the haptic and audio feedback feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Independent Toggles'**
  String get featureFeedbackChip3;

  /// Features screen: title of the protocol guard (layer 1) feature
  ///
  /// In en, this message translates to:
  /// **'Protocol & Syntax Guard (Layer 1)'**
  String get featureProtocolGuardTitle;

  /// Features screen: description of the protocol guard (layer 1) feature
  ///
  /// In en, this message translates to:
  /// **'Validates scheme authenticity, checks for encrypted HTTPS connections, and flags plain HTTP or unsupported schemes.'**
  String get featureProtocolGuardDesc;

  /// Features screen: highlight chip 1 of the protocol guard (layer 1) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'HTTPS Validation'**
  String get featureProtocolGuardChip1;

  /// Features screen: highlight chip 2 of the protocol guard (layer 1) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Scheme Checking'**
  String get featureProtocolGuardChip2;

  /// Features screen: highlight chip 3 of the protocol guard (layer 1) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Zero-Width Char Trap'**
  String get featureProtocolGuardChip3;

  /// Features screen: title of the homograph shield (layer 2) feature
  ///
  /// In en, this message translates to:
  /// **'Homograph & Unicode Shield (Layer 2)'**
  String get featureHomographShieldTitle;

  /// Features screen: description of the homograph shield (layer 2) feature
  ///
  /// In en, this message translates to:
  /// **'Detects lookalike Cyrillic, Greek, and Unicode spoofing characters used to disguise fraudulent domain names (IDN punycode defense).'**
  String get featureHomographShieldDesc;

  /// Features screen: highlight chip 1 of the homograph shield (layer 2) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Punycode Defense'**
  String get featureHomographShieldChip1;

  /// Features screen: highlight chip 2 of the homograph shield (layer 2) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Cyrillic Lookalikes'**
  String get featureHomographShieldChip2;

  /// Features screen: highlight chip 3 of the homograph shield (layer 2) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Mixed-Script Trap'**
  String get featureHomographShieldChip3;

  /// Features screen: title of the TLD and entropy analysis (layer 3) feature
  ///
  /// In en, this message translates to:
  /// **'Suspicious TLD & Entropy Analysis (Layer 3)'**
  String get featureTldEntropyTitle;

  /// Features screen: description of the TLD and entropy analysis (layer 3) feature
  ///
  /// In en, this message translates to:
  /// **'Flags high-risk top-level domains, excessive subdomains, and evaluates domain name character entropy to catch algorithmic domains.'**
  String get featureTldEntropyDesc;

  /// Features screen: highlight chip 1 of the TLD and entropy analysis (layer 3) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'High-Risk TLDs'**
  String get featureTldEntropyChip1;

  /// Features screen: highlight chip 2 of the TLD and entropy analysis (layer 3) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Entropy Scoring'**
  String get featureTldEntropyChip2;

  /// Features screen: highlight chip 3 of the TLD and entropy analysis (layer 3) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Subdomain Depth'**
  String get featureTldEntropyChip3;

  /// Features screen: title of the IP and port flagging (layer 4) feature
  ///
  /// In en, this message translates to:
  /// **'Heuristic IP & Port Flagging (Layer 4)'**
  String get featureIpPortTitle;

  /// Features screen: description of the IP and port flagging (layer 4) feature
  ///
  /// In en, this message translates to:
  /// **'Flags links pointing directly to raw IP addresses or non-standard HTTP/HTTPS network ports designed to bypass firewalls.'**
  String get featureIpPortDesc;

  /// Features screen: highlight chip 1 of the IP and port flagging (layer 4) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Raw IP Traps'**
  String get featureIpPortChip1;

  /// Features screen: highlight chip 2 of the IP and port flagging (layer 4) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Non-Standard Ports'**
  String get featureIpPortChip2;

  /// Features screen: highlight chip 3 of the IP and port flagging (layer 4) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Embedded Userinfo'**
  String get featureIpPortChip3;

  /// Features screen: title of the online HEAD probing (layer 5) feature
  ///
  /// In en, this message translates to:
  /// **'Privacy-Safe Online Head Probing (Layer 5)'**
  String get featureHeadProbeTitle;

  /// Features screen: description of the online HEAD probing (layer 5) feature
  ///
  /// In en, this message translates to:
  /// **'Optional opt-in lightweight HTTP HEAD probing to resolve URL shorteners, uncover hidden redirect chains, and verify TLS certificates.'**
  String get featureHeadProbeDesc;

  /// Features screen: highlight chip 1 of the online HEAD probing (layer 5) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Redirect Chains'**
  String get featureHeadProbeChip1;

  /// Features screen: highlight chip 2 of the online HEAD probing (layer 5) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Shortener Unrolling'**
  String get featureHeadProbeChip2;

  /// Features screen: highlight chip 3 of the online HEAD probing (layer 5) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Opt-In Privacy'**
  String get featureHeadProbeChip3;

  /// Features screen: title of the Google Safe Browsing (layer 6) feature
  ///
  /// In en, this message translates to:
  /// **'Google Safe Browsing API (Layer 6)'**
  String get featureSafeBrowsingTitle;

  /// Features screen: description of the Google Safe Browsing (layer 6) feature
  ///
  /// In en, this message translates to:
  /// **'Optional cloud threat intelligence against millions of known malicious URLs, malware distribution hubs, and social engineering sites.'**
  String get featureSafeBrowsingDesc;

  /// Features screen: highlight chip 1 of the Google Safe Browsing (layer 6) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Google Threat DB'**
  String get featureSafeBrowsingChip1;

  /// Features screen: highlight chip 2 of the Google Safe Browsing (layer 6) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Local Key Storage'**
  String get featureSafeBrowsingChip2;

  /// Features screen: highlight chip 3 of the Google Safe Browsing (layer 6) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Daily Quota Meter'**
  String get featureSafeBrowsingChip3;

  /// Features screen: title of the QuishingGuard tamper detection feature
  ///
  /// In en, this message translates to:
  /// **'QuishingGuard™ Physical Tamper Detection'**
  String get featureQuishingGuardTitle;

  /// Features screen: description of the QuishingGuard tamper detection feature
  ///
  /// In en, this message translates to:
  /// **'Forensic computer vision pipeline detecting physical QR sticker overlays, edge discontinuities, micro-shadows, and chromatic halftone print grain.'**
  String get featureQuishingGuardDesc;

  /// Features screen: highlight chip 1 of the QuishingGuard tamper detection feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Sticker Overlays'**
  String get featureQuishingGuardChip1;

  /// Features screen: highlight chip 2 of the QuishingGuard tamper detection feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Edge Discontinuity'**
  String get featureQuishingGuardChip2;

  /// Features screen: highlight chip 3 of the QuishingGuard tamper detection feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Print Grain Analysis'**
  String get featureQuishingGuardChip3;

  /// Features screen: title of the AR CodeVision feature
  ///
  /// In en, this message translates to:
  /// **'AR CodeVision™ Spatial HUD'**
  String get featureArCodeVisionTitle;

  /// Features screen: description of the AR CodeVision feature
  ///
  /// In en, this message translates to:
  /// **'Augmented Reality multi-barcode scanner displaying floating interactive chips over all detected codes with live safety badges and batch selection.'**
  String get featureArCodeVisionDesc;

  /// Features screen: highlight chip 1 of the AR CodeVision feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Spatial Tracking'**
  String get featureArCodeVisionChip1;

  /// Features screen: highlight chip 2 of the AR CodeVision feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Multi-Code HUD'**
  String get featureArCodeVisionChip2;

  /// Features screen: highlight chip 3 of the AR CodeVision feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Batch Select'**
  String get featureArCodeVisionChip3;

  /// Features screen: title of the AirQR feature
  ///
  /// In en, this message translates to:
  /// **'AirQR™ Optical Air-Gap Data Stream'**
  String get featureAirQrTitle;

  /// Features screen: description of the AirQR feature
  ///
  /// In en, this message translates to:
  /// **'High-speed animated strobe QR transmitter & receiver pipeline transferring encrypted text, files, and keys completely offline without Wi-Fi or Bluetooth.'**
  String get featureAirQrDesc;

  /// Features screen: highlight chip 1 of the AirQR feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Animated Strobe QR'**
  String get featureAirQrChip1;

  /// Features screen: highlight chip 2 of the AirQR feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Reed-Solomon FEC'**
  String get featureAirQrChip2;

  /// Features screen: highlight chip 3 of the AirQR feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'100% Offline Air-Gap'**
  String get featureAirQrChip3;

  /// Features screen: title of the StegoQR feature
  ///
  /// In en, this message translates to:
  /// **'StegoQR™ Steganographic Scanner'**
  String get featureStegoQrTitle;

  /// Features screen: description of the StegoQR feature
  ///
  /// In en, this message translates to:
  /// **'Discovers and extracts hidden encrypted payloads and watermarked data layers invisibly embedded within custom QR codes.'**
  String get featureStegoQrDesc;

  /// Features screen: highlight chip 1 of the StegoQR feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Decoy QR Parsing'**
  String get featureStegoQrChip1;

  /// Features screen: highlight chip 2 of the StegoQR feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'AES Decryption'**
  String get featureStegoQrChip2;

  /// Features screen: highlight chip 3 of the StegoQR feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Biometric Auth'**
  String get featureStegoQrChip3;

  /// Features screen: title of the Wi-Fi auto connect feature
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi Instant Auto Connect'**
  String get featureWifiTitle;

  /// Features screen: description of the Wi-Fi auto connect feature
  ///
  /// In en, this message translates to:
  /// **'Parses WPA/WPA2/WPA3 network credentials, displays network info, copies passwords, and opens Wi-Fi settings in 1 tap.'**
  String get featureWifiDesc;

  /// Features screen: highlight chip 1 of the Wi-Fi auto connect feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'WPA3 & WPA2'**
  String get featureWifiChip1;

  /// Features screen: highlight chip 2 of the Wi-Fi auto connect feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'1-Tap Connect'**
  String get featureWifiChip2;

  /// Features screen: highlight chip 3 of the Wi-Fi auto connect feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Password Reveal/Copy'**
  String get featureWifiChip3;

  /// Features screen: title of the UPI and crypto payments feature
  ///
  /// In en, this message translates to:
  /// **'UPI & Global Crypto Payments'**
  String get featurePaymentsTitle;

  /// Features screen: description of the UPI and crypto payments feature
  ///
  /// In en, this message translates to:
  /// **'Parses Indian UPI QR codes (dispatching to GPay, PhonePe, Paytm) and Bitcoin/Ethereum/Solana crypto payment addresses with amount detection.'**
  String get featurePaymentsDesc;

  /// Features screen: highlight chip 1 of the UPI and crypto payments feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'UPI App Dispatch'**
  String get featurePaymentsChip1;

  /// Features screen: highlight chip 2 of the UPI and crypto payments feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Crypto Wallets'**
  String get featurePaymentsChip2;

  /// Features screen: highlight chip 3 of the UPI and crypto payments feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'SEPA Transfer'**
  String get featurePaymentsChip3;

  /// Features screen: title of the TOTP authenticator feature
  ///
  /// In en, this message translates to:
  /// **'TOTP 2FA Authenticator & Token Generator'**
  String get featureTotpTitle;

  /// Features screen: description of the TOTP authenticator feature
  ///
  /// In en, this message translates to:
  /// **'Scans 2FA setup codes, renders live rolling 6-digit OTP passcodes with circular countdown timers, and imports into authenticator apps.'**
  String get featureTotpDesc;

  /// Features screen: highlight chip 1 of the TOTP authenticator feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Live Passcodes'**
  String get featureTotpChip1;

  /// Features screen: highlight chip 2 of the TOTP authenticator feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Visual Countdown'**
  String get featureTotpChip2;

  /// Features screen: highlight chip 3 of the TOTP authenticator feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'App Importer'**
  String get featureTotpChip3;

  /// Features screen: title of the contacts and vCard feature
  ///
  /// In en, this message translates to:
  /// **'Contacts & vCard Importer'**
  String get featureContactsTitle;

  /// Features screen: description of the contacts and vCard feature
  ///
  /// In en, this message translates to:
  /// **'Parses vCard 2.1/3.0/4.0 and MeCard contact barcodes with 1-tap phone dialing, email composition, and saving to your address book.'**
  String get featureContactsDesc;

  /// Features screen: highlight chip 1 of the contacts and vCard feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'vCard 4.0'**
  String get featureContactsChip1;

  /// Features screen: highlight chip 2 of the contacts and vCard feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'1-Tap Save'**
  String get featureContactsChip2;

  /// Features screen: highlight chip 3 of the contacts and vCard feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Direct Call & Email'**
  String get featureContactsChip3;

  /// Features screen: title of the calendar events feature
  ///
  /// In en, this message translates to:
  /// **'Calendar Events & Scheduling'**
  String get featureCalendarTitle;

  /// Features screen: description of the calendar events feature
  ///
  /// In en, this message translates to:
  /// **'Reads iCalendar VEVENT formats with start/end time ranges, locations, and descriptions, adding them directly to your device calendar.'**
  String get featureCalendarDesc;

  /// Features screen: highlight chip 1 of the calendar events feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'iCal Parsing'**
  String get featureCalendarChip1;

  /// Features screen: highlight chip 2 of the calendar events feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Start/End Time'**
  String get featureCalendarChip2;

  /// Features screen: highlight chip 3 of the calendar events feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Device Calendar Add'**
  String get featureCalendarChip3;

  /// Features screen: title of the geo location feature
  ///
  /// In en, this message translates to:
  /// **'Geographic Location & Navigation'**
  String get featureGeoTitle;

  /// Features screen: description of the geo location feature
  ///
  /// In en, this message translates to:
  /// **'Parses geo: coordinates and search queries, offering instant navigation directions via Google Maps.'**
  String get featureGeoDesc;

  /// Features screen: highlight chip 1 of the geo location feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Lat/Long Parsing'**
  String get featureGeoChip1;

  /// Features screen: highlight chip 2 of the geo location feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Google Maps Link'**
  String get featureGeoChip2;

  /// Features screen: highlight chip 3 of the geo location feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Search Queries'**
  String get featureGeoChip3;

  /// Features screen: title of the scan history feature
  ///
  /// In en, this message translates to:
  /// **'Comprehensive Offline Scan History'**
  String get featureScanHistoryTitle;

  /// Features screen: description of the scan history feature
  ///
  /// In en, this message translates to:
  /// **'Stores every scan locally with payload categorization, safety scores, timestamp tracking, favorite stars, and real-time full-text search.'**
  String get featureScanHistoryDesc;

  /// Features screen: highlight chip 1 of the scan history feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Full-Text Search'**
  String get featureScanHistoryChip1;

  /// Features screen: highlight chip 2 of the scan history feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Category Filtering'**
  String get featureScanHistoryChip2;

  /// Features screen: highlight chip 3 of the scan history feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Favorite Stars'**
  String get featureScanHistoryChip3;

  /// Features screen: title of the backups feature
  ///
  /// In en, this message translates to:
  /// **'Flexible JSON & CSV Backups'**
  String get featureBackupsTitle;

  /// Features screen: description of the backups feature
  ///
  /// In en, this message translates to:
  /// **'Export your complete scan history to standard CSV spreadsheets or encrypted JSON backup files with one-click restore.'**
  String get featureBackupsDesc;

  /// Features screen: highlight chip 1 of the backups feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'CSV Spreadsheet'**
  String get featureBackupsChip1;

  /// Features screen: highlight chip 2 of the backups feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'JSON Backup'**
  String get featureBackupsChip2;

  /// Features screen: highlight chip 3 of the backups feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'One-Click Restore'**
  String get featureBackupsChip3;

  /// Features screen: title of the biometric and screen guard feature
  ///
  /// In en, this message translates to:
  /// **'Biometric & Screen Security Guard'**
  String get featureBiometricGuardTitle;

  /// Features screen: description of the biometric and screen guard feature
  ///
  /// In en, this message translates to:
  /// **'Protects sensitive hidden StegoQR payloads and history with fingerprint/face authentication and blocks screen captures (FLAG_SECURE).'**
  String get featureBiometricGuardDesc;

  /// Features screen: highlight chip 1 of the biometric and screen guard feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Biometric Prompt'**
  String get featureBiometricGuardChip1;

  /// Features screen: highlight chip 2 of the biometric and screen guard feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Screenshot Guard'**
  String get featureBiometricGuardChip2;

  /// Features screen: highlight chip 3 of the biometric and screen guard feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Encrypted Storage'**
  String get featureBiometricGuardChip3;

  /// Features screen: title of the offline privacy feature
  ///
  /// In en, this message translates to:
  /// **'100% Offline-First Privacy'**
  String get featureOfflinePrivacyTitle;

  /// Features screen: description of the offline privacy feature
  ///
  /// In en, this message translates to:
  /// **'Scans, decodes, and analyzes barcodes completely on your phone without sending any data to external servers by default.'**
  String get featureOfflinePrivacyDesc;

  /// Features screen: highlight chip 1 of the offline privacy feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'No Telemetry'**
  String get featureOfflinePrivacyChip1;

  /// Features screen: highlight chip 2 of the offline privacy feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Zero Ads'**
  String get featureOfflinePrivacyChip2;

  /// Features screen: highlight chip 3 of the offline privacy feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Open-Source Safety'**
  String get featureOfflinePrivacyChip3;

  /// Hero header title on the Help Home screen
  ///
  /// In en, this message translates to:
  /// **'Help Center & User Guides'**
  String get helpCenterHeaderTitle;

  /// Hero header subtitle on the Help Home screen
  ///
  /// In en, this message translates to:
  /// **'Browse in-depth guides, step-by-step instructions, and solutions for all features of SreerajP QR Studio.'**
  String get helpCenterHeaderSubtitle;

  /// Button to open the manual decryption tool
  ///
  /// In en, this message translates to:
  /// **'Decrypt Payload'**
  String get decryptPayloadAction;

  /// Title of manual decryption dialog
  ///
  /// In en, this message translates to:
  /// **'Decrypt Scanned Content'**
  String get decryptPayloadTitle;

  /// Description in the manual decryption dialog
  ///
  /// In en, this message translates to:
  /// **'Enter the passphrase or session code to decrypt this ciphertext payload.'**
  String get decryptPayloadDescription;

  /// Label for cipher mode selector
  ///
  /// In en, this message translates to:
  /// **'Cipher Mode'**
  String get cipherModeLabel;

  /// Cipher mode auto-detection option
  ///
  /// In en, this message translates to:
  /// **'Auto-detect / Standard'**
  String get cipherModeAuto;

  /// Cipher mode AES-GCM option
  ///
  /// In en, this message translates to:
  /// **'AES-256-GCM (PBKDF2 SHA-256)'**
  String get cipherModeAesGcm;

  /// Cipher mode AES-CBC option
  ///
  /// In en, this message translates to:
  /// **'AES-256-CBC'**
  String get cipherModeAesCbc;

  /// Label for AirQR session code input
  ///
  /// In en, this message translates to:
  /// **'Session Code / Key'**
  String get airQrCodeLabel;

  /// Hint for AirQR session code input
  ///
  /// In en, this message translates to:
  /// **'e.g. ABC-DEF'**
  String get airQrCodeHint;

  /// Title when an AirQR optical payload is detected
  ///
  /// In en, this message translates to:
  /// **'AirQR Encrypted Transfer'**
  String get airQrDetectedTitle;

  /// Subtitle when an AirQR optical payload is detected
  ///
  /// In en, this message translates to:
  /// **'This QR code carries an encrypted optical transfer. Enter the session code shown on the sending device to unlock.'**
  String get airQrDetectedSubtitle;

  /// Title when an encrypted JSON container is detected
  ///
  /// In en, this message translates to:
  /// **'Encrypted JSON Container'**
  String get jsonEnvelopeDetectedTitle;

  /// Subtitle when an encrypted JSON container is detected
  ///
  /// In en, this message translates to:
  /// **'This QR code contains an encrypted JSON container. Enter the passphrase to decrypt.'**
  String get jsonEnvelopeDetectedSubtitle;

  /// Label above decrypted content
  ///
  /// In en, this message translates to:
  /// **'Decrypted Content:'**
  String get decryptedContentLabel;

  /// Error message when manual decryption fails
  ///
  /// In en, this message translates to:
  /// **'Decryption failed. Please verify the passphrase or cipher settings.'**
  String get manualDecryptionFailed;

  /// Header label on the email action card
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailCardTitle;

  /// Button that opens the default email app to compose a message
  ///
  /// In en, this message translates to:
  /// **'Send Email'**
  String get emailSendButton;

  /// Button that copies the email address to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get emailCopyButton;

  /// Error when the email app cannot be launched
  ///
  /// In en, this message translates to:
  /// **'Could not open email app. Copy the address and open your email app manually.'**
  String get emailLaunchFailed;

  /// Label for the email subject field on the action card
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get emailSubjectLabel;

  /// Label for the email body preview on the action card
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get emailBodyLabel;

  /// Header label on the phone action card
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneCardTitle;

  /// Button that opens the phone dialer with the number
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get phoneCallButton;

  /// Button that copies the phone number to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get phoneCopyButton;

  /// Error when the phone dialer cannot be launched
  ///
  /// In en, this message translates to:
  /// **'Could not open the phone dialer. Copy the number and dial manually.'**
  String get phoneLaunchFailed;

  /// Header label on the SMS action card
  ///
  /// In en, this message translates to:
  /// **'Text Message'**
  String get smsCardTitle;

  /// Button that opens the messaging app with the number and body
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get smsSendButton;

  /// Button that copies the SMS recipient number to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get smsCopyButton;

  /// Error when the messaging app cannot be launched
  ///
  /// In en, this message translates to:
  /// **'Could not open the messaging app. Copy the number and message manually.'**
  String get smsLaunchFailed;

  /// Label for the SMS body preview on the action card
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get smsBodyLabel;

  /// Header label on the app deep link action card
  ///
  /// In en, this message translates to:
  /// **'App Link'**
  String get appLinkCardTitle;

  /// Button that opens the deep link in its native app
  ///
  /// In en, this message translates to:
  /// **'Open in App'**
  String get appLinkOpenButton;

  /// Error when the app deep link cannot be launched
  ///
  /// In en, this message translates to:
  /// **'Could not open this app link. The app may not be installed.'**
  String get appLinkLaunchFailed;

  /// Header label on the product barcode action card
  ///
  /// In en, this message translates to:
  /// **'Product Barcode'**
  String get productBarcodeCardTitle;

  /// Button that searches the barcode on Open Food Facts
  ///
  /// In en, this message translates to:
  /// **'Food Info'**
  String get productSearchFoodButton;

  /// Button that searches the barcode on Google
  ///
  /// In en, this message translates to:
  /// **'Search Web'**
  String get productSearchWebButton;

  /// Button that copies the barcode number to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy Barcode'**
  String get productCopyButton;

  /// Error when the product search URL cannot be launched
  ///
  /// In en, this message translates to:
  /// **'Could not open product search. Try copying the barcode and searching manually.'**
  String get productLaunchFailed;

  /// Header label on the ISBN book action card
  ///
  /// In en, this message translates to:
  /// **'Book (ISBN)'**
  String get isbnCardTitle;

  /// Button that looks up the ISBN on Google Books
  ///
  /// In en, this message translates to:
  /// **'Google Books'**
  String get isbnGoogleBooksButton;

  /// Button that looks up the ISBN on Open Library
  ///
  /// In en, this message translates to:
  /// **'Open Library'**
  String get isbnOpenLibraryButton;

  /// Button that copies the ISBN to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy ISBN'**
  String get isbnCopyButton;

  /// Error when the book lookup URL cannot be launched
  ///
  /// In en, this message translates to:
  /// **'Could not open book lookup. Try copying the ISBN and searching manually.'**
  String get isbnLaunchFailed;

  /// History filter chip label for email scan records
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get historyFilterEmail;

  /// History filter chip label for phone scan records
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get historyFilterPhone;

  /// History filter chip label for SMS scan records
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get historyFilterSms;

  /// History filter chip label for app link scan records
  ///
  /// In en, this message translates to:
  /// **'App Link'**
  String get historyFilterAppLink;

  /// History filter chip label for product barcode scan records
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get historyFilterProductBarcode;

  /// History filter chip label for ISBN book scan records
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get historyFilterIsbn;

  /// Tooltip and status label when the camera flash is off
  ///
  /// In en, this message translates to:
  /// **'Flash: Off'**
  String get scanFlashOff;

  /// Tooltip and status label when the camera flash is on
  ///
  /// In en, this message translates to:
  /// **'Flash: On'**
  String get scanFlashOn;

  /// Tooltip and status label when the camera flash is in automatic ambient mode
  ///
  /// In en, this message translates to:
  /// **'Flash: Auto'**
  String get scanFlashAuto;

  /// Chip label showing auto flash is active with measured ambient lux
  ///
  /// In en, this message translates to:
  /// **'Auto Flash Active ({lux} lux)'**
  String scanFlashAutoActive(String lux);

  /// Warning when light sensor cannot be accessed for auto flash
  ///
  /// In en, this message translates to:
  /// **'Light sensor unavailable on this device'**
  String get scanFlashAutoSensorUnavailable;

  /// Tooltip for camera tuning button in the scanner toolbar
  ///
  /// In en, this message translates to:
  /// **'Camera adjustments'**
  String get cameraTuneTooltip;

  /// Header title of the camera adjustments panel
  ///
  /// In en, this message translates to:
  /// **'Camera Adjustments'**
  String get cameraTuneTitle;

  /// Label for camera brightness adjustment slider
  ///
  /// In en, this message translates to:
  /// **'Brightness'**
  String get cameraBrightnessLabel;

  /// Label for camera contrast adjustment slider
  ///
  /// In en, this message translates to:
  /// **'Contrast'**
  String get cameraContrastLabel;

  /// Switch label for inverted/white-on-black barcode scanning
  ///
  /// In en, this message translates to:
  /// **'Invert Colors (Negative Scan)'**
  String get cameraInvertLabel;

  /// Explanation text below the invert colors toggle
  ///
  /// In en, this message translates to:
  /// **'Optimized for white QR codes on dark screens or metal'**
  String get cameraInvertHint;

  /// Label for camera capture resolution preset selector
  ///
  /// In en, this message translates to:
  /// **'Camera Resolution'**
  String get cameraResolutionLabel;

  /// Resolution preset option for 1080p
  ///
  /// In en, this message translates to:
  /// **'Full HD (1080p - Recommended)'**
  String get cameraResolutionFullHd;

  /// Resolution preset option for maximum available resolution
  ///
  /// In en, this message translates to:
  /// **'Maximum (4K UHD)'**
  String get cameraResolutionMax;

  /// Resolution preset option for 720p
  ///
  /// In en, this message translates to:
  /// **'HD (720p - Battery Saver)'**
  String get cameraResolutionHd;

  /// Button label to reset brightness and contrast to factory defaults
  ///
  /// In en, this message translates to:
  /// **'Reset Adjustments'**
  String get cameraResetAdjustments;

  /// Subtle hint for tap-to-focus and exposure metering
  ///
  /// In en, this message translates to:
  /// **'Tap to focus & meter light'**
  String get cameraFocusTapHint;

  /// Title for the Language settings card
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageTitle;

  /// Subtitle for the Language settings card
  ///
  /// In en, this message translates to:
  /// **'Select application display language'**
  String get settingsLanguageSubtitle;

  /// Option to follow device system language
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystemDefault;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Malayalam language option endonym
  ///
  /// In en, this message translates to:
  /// **'മലയാളം'**
  String get languageMalayalam;

  /// Sanskrit language option endonym
  ///
  /// In en, this message translates to:
  /// **'संस्कृतम्'**
  String get languageSanskrit;

  /// Copyright notice on the About screen
  ///
  /// In en, this message translates to:
  /// **'© {year} Sreeraj P. All rights reserved.'**
  String aboutCopyright(String year);

  /// Usage percentage on Safe Browsing screen
  ///
  /// In en, this message translates to:
  /// **'{percentage}% used'**
  String apiQuotaPercentageUsed(String percentage);

  /// Tooltip for camera flash button
  ///
  /// In en, this message translates to:
  /// **'Toggle flash'**
  String get tooltipToggleFlash;

  /// Tooltip for camera adjustments button
  ///
  /// In en, this message translates to:
  /// **'Camera adjustments'**
  String get tooltipCameraAdjustments;

  /// Tooltip for camera zoom button
  ///
  /// In en, this message translates to:
  /// **'Zoom controls'**
  String get tooltipZoomControls;

  /// Tooltip for camera flip button
  ///
  /// In en, this message translates to:
  /// **'Switch camera'**
  String get tooltipSwitchCamera;

  /// Tooltip for back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get tooltipBack;

  /// Tooltip for password or secret visibility toggle
  ///
  /// In en, this message translates to:
  /// **'Toggle secret visibility'**
  String get tooltipToggleSecretVisibility;

  /// Tooltip for AirQR stream reset button
  ///
  /// In en, this message translates to:
  /// **'Reset stream'**
  String get tooltipResetStream;

  /// Tooltip for switching to AirQR transmitter
  ///
  /// In en, this message translates to:
  /// **'Switch to AirQR Transmitter'**
  String get tooltipAirQrTransmitter;

  /// Label for custom text mode tab in AirQR transmitter
  ///
  /// In en, this message translates to:
  /// **'Custom Text'**
  String get airQrModeText;

  /// Label for device sync mode tab in AirQR transmitter
  ///
  /// In en, this message translates to:
  /// **'Device Sync'**
  String get airQrModeSync;

  /// Checkbox label to include scan history in optical sync
  ///
  /// In en, this message translates to:
  /// **'Include scan history ({count})'**
  String airQrSyncIncludeHistory(int count);

  /// Checkbox label to include app settings in optical sync
  ///
  /// In en, this message translates to:
  /// **'Include app settings'**
  String get airQrSyncIncludeSettings;

  /// Label for sync passphrase input field
  ///
  /// In en, this message translates to:
  /// **'Sync Passphrase / PIN'**
  String get airQrSyncPassphraseLabel;

  /// Hint for sync passphrase input field
  ///
  /// In en, this message translates to:
  /// **'Enter PIN or passphrase to encrypt'**
  String get airQrSyncPassphraseHint;

  /// Button to generate a random 6-digit sync PIN
  ///
  /// In en, this message translates to:
  /// **'Generate PIN'**
  String get airQrSyncGeneratePin;

  /// Button label to package and start optical beam in sync mode
  ///
  /// In en, this message translates to:
  /// **'Beam History & Settings'**
  String get airQrSyncBeamButton;

  /// Warning shown when neither history nor settings are selected for sync
  ///
  /// In en, this message translates to:
  /// **'Select at least history or settings to sync.'**
  String get airQrSyncNoDataWarning;

  /// Title when an AirQR optical sync package is received
  ///
  /// In en, this message translates to:
  /// **'AirQR Encrypted Sync Package'**
  String get airQrSyncPackageDetected;

  /// Summary of detected sync package contents
  ///
  /// In en, this message translates to:
  /// **'Contains {records} scan records and app configuration'**
  String airQrSyncPackageSummary(int records);

  /// Prompt to enter decryption passphrase for sync package
  ///
  /// In en, this message translates to:
  /// **'Enter Passphrase to Decrypt'**
  String get airQrSyncEnterPassphrase;

  /// Checkbox to restore scan history from sync package
  ///
  /// In en, this message translates to:
  /// **'Restore scan history'**
  String get airQrSyncRestoreHistory;

  /// Checkbox to apply app settings from sync package
  ///
  /// In en, this message translates to:
  /// **'Apply app settings'**
  String get airQrSyncApplySettings;

  /// Button to decrypt and apply received sync package
  ///
  /// In en, this message translates to:
  /// **'Decrypt & Sync'**
  String get airQrSyncDecryptButton;

  /// Notification shown when device sync finishes successfully
  ///
  /// In en, this message translates to:
  /// **'Successfully synced {count} records and updated settings!'**
  String airQrSyncSuccess(int count);

  /// Action button in export dialog to beam history via AirQR
  ///
  /// In en, this message translates to:
  /// **'Beam via AirQR'**
  String get airQrSyncBeamAction;

  /// Title of AirQR device sync item in settings
  ///
  /// In en, this message translates to:
  /// **'AirQR Optical Sync'**
  String get airQrSyncSettingsTitle;

  /// Subtitle explaining AirQR device sync item in settings
  ///
  /// In en, this message translates to:
  /// **'Beam history & settings air-gapped to another phone'**
  String get airQrSyncSettingsSubtitle;

  /// Label for the live camera scan tab in main navigation
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get tabScan;

  /// Label for the CodeForge generator tab in main navigation
  ///
  /// In en, this message translates to:
  /// **'CodeForge'**
  String get tabCodeForge;

  /// Label for the scan history tab in main navigation
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get tabHistory;

  /// Title of the CodeForge generator screen
  ///
  /// In en, this message translates to:
  /// **'CodeForge'**
  String get codeForgeTitle;

  /// Subtitle describing the CodeForge studio
  ///
  /// In en, this message translates to:
  /// **'Barcode & QR Studio'**
  String get codeForgeSubtitle;

  /// Section header for selecting barcode format
  ///
  /// In en, this message translates to:
  /// **'Barcode Type'**
  String get codeForgeBarcodeType;

  /// Section header for selecting QR payload preset
  ///
  /// In en, this message translates to:
  /// **'Content Type'**
  String get codeForgePayloadType;

  /// Preset chip for plain text payload
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get codeForgePresetText;

  /// Helper hint text suggesting optimal text length for QR code creation
  ///
  /// In en, this message translates to:
  /// **'Keep text concise for clear and reliable scanning (up to 500 characters)'**
  String get codeForgeTextHint;

  /// Button label to pick and load text from a file into CodeForge
  ///
  /// In en, this message translates to:
  /// **'Read from file'**
  String get codeForgeLoadFromFile;

  /// Tooltip for read from file button
  ///
  /// In en, this message translates to:
  /// **'Read text from a file into the QR code generator'**
  String get codeForgeLoadFromFileTooltip;

  /// Error message when the selected text file is empty
  ///
  /// In en, this message translates to:
  /// **'The selected file is empty.'**
  String get codeForgeFileEmpty;

  /// Notice shown when file text exceeds 500 characters and is trimmed for single QR code sharing
  ///
  /// In en, this message translates to:
  /// **'Text was trimmed to 500 characters to fit in a single, fast-scanning QR code.'**
  String get codeForgeFileTruncated;

  /// Confirmation message when text is loaded from a file
  ///
  /// In en, this message translates to:
  /// **'Text loaded from file successfully.'**
  String get codeForgeFileLoaded;

  /// Error message when file reading fails
  ///
  /// In en, this message translates to:
  /// **'Unable to read the selected file.'**
  String get codeForgeFileReadError;

  /// Preset chip for web link payload
  ///
  /// In en, this message translates to:
  /// **'URL / Link'**
  String get codeForgePresetUrl;

  /// Preset chip for Wi-Fi network payload
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi'**
  String get codeForgePresetWifi;

  /// Preset chip for contact card payload
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get codeForgePresetContact;

  /// Preset chip for UPI payment payload
  ///
  /// In en, this message translates to:
  /// **'UPI Pay'**
  String get codeForgePresetUpi;

  /// Preset chip for SMS text message payload
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get codeForgePresetSms;

  /// Preset chip for email message payload
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get codeForgePresetEmail;

  /// Preset chip for geographic coordinates payload
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get codeForgePresetGeo;

  /// Input field label for Wi-Fi network name
  ///
  /// In en, this message translates to:
  /// **'Network Name (SSID)'**
  String get codeForgeWifiSsid;

  /// Input field label for Wi-Fi password
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get codeForgeWifiPassword;

  /// Label for Wi-Fi security type selector
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get codeForgeWifiSecurity;

  /// Checkbox label for hidden Wi-Fi network
  ///
  /// In en, this message translates to:
  /// **'Hidden Network'**
  String get codeForgeWifiHidden;

  /// Input field label for contact name
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get codeForgeContactName;

  /// Input field label for contact phone
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get codeForgeContactPhone;

  /// Input field label for contact email
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get codeForgeContactEmail;

  /// Input field label for contact organization
  ///
  /// In en, this message translates to:
  /// **'Company / Org'**
  String get codeForgeContactOrg;

  /// Input field label for contact title
  ///
  /// In en, this message translates to:
  /// **'Job Title'**
  String get codeForgeContactTitle;

  /// Input field label for contact website
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get codeForgeContactUrl;

  /// Input field label for UPI virtual payment address
  ///
  /// In en, this message translates to:
  /// **'UPI ID / VPA'**
  String get codeForgeUpiVpa;

  /// Input field label for UPI payee name
  ///
  /// In en, this message translates to:
  /// **'Payee Name'**
  String get codeForgeUpiName;

  /// Input field label for UPI amount
  ///
  /// In en, this message translates to:
  /// **'Amount (INR)'**
  String get codeForgeUpiAmount;

  /// Input field label for UPI transaction note
  ///
  /// In en, this message translates to:
  /// **'Transaction Note'**
  String get codeForgeUpiNote;

  /// Input field label for SMS phone number
  ///
  /// In en, this message translates to:
  /// **'Recipient Phone'**
  String get codeForgeSmsPhone;

  /// Input field label for SMS message body
  ///
  /// In en, this message translates to:
  /// **'Message Body'**
  String get codeForgeSmsMessage;

  /// Input field label for email recipient
  ///
  /// In en, this message translates to:
  /// **'Recipient Email'**
  String get codeForgeEmailTo;

  /// Input field label for email subject
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get codeForgeEmailSubject;

  /// Input field label for email body
  ///
  /// In en, this message translates to:
  /// **'Email Body'**
  String get codeForgeEmailBody;

  /// Input field label for geographic latitude
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get codeForgeGeoLat;

  /// Input field label for geographic longitude
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get codeForgeGeoLng;

  /// Button label to auto-fill GPS coordinates from device location
  ///
  /// In en, this message translates to:
  /// **'Use My Location'**
  String get codeForgeGeoUseMyLocation;

  /// Loading text shown while fetching GPS coordinates
  ///
  /// In en, this message translates to:
  /// **'Getting location…'**
  String get codeForgeGeoFetching;

  /// Error message when GPS location fetch fails
  ///
  /// In en, this message translates to:
  /// **'Could not get location'**
  String get codeForgeGeoFailed;

  /// Error message when user denies location permission
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get codeForgeGeoPermissionDenied;

  /// Header for QR code visual design customization studio
  ///
  /// In en, this message translates to:
  /// **'Design & Structure'**
  String get codeForgeDesignStudio;

  /// Selector label for outer finder pattern corner shape
  ///
  /// In en, this message translates to:
  /// **'Corner Eye Shape'**
  String get codeForgeEyeShape;

  /// Selector label for inner finder pattern pupil shape
  ///
  /// In en, this message translates to:
  /// **'Inner Eye Pupil'**
  String get codeForgeEyeBallShape;

  /// Selector label for data module dot shape
  ///
  /// In en, this message translates to:
  /// **'Data Module Pattern'**
  String get codeForgePatternShape;

  /// Shape option: standard square
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get codeForgeShapeSquare;

  /// Shape option: circular dots
  ///
  /// In en, this message translates to:
  /// **'Dots'**
  String get codeForgeShapeDots;

  /// Shape option: rounded rectangle
  ///
  /// In en, this message translates to:
  /// **'Rounded'**
  String get codeForgeShapeRounded;

  /// Shape option: classy curved corners
  ///
  /// In en, this message translates to:
  /// **'Classy'**
  String get codeForgeShapeClassy;

  /// Shape option: rotated diamond
  ///
  /// In en, this message translates to:
  /// **'Diamond'**
  String get codeForgeShapeDiamond;

  /// Shape option: organic leaf corner
  ///
  /// In en, this message translates to:
  /// **'Leaf'**
  String get codeForgeShapeLeaf;

  /// Shape option: circular ring
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get codeForgeShapeCircle;

  /// Section header for color palette and gradient studio
  ///
  /// In en, this message translates to:
  /// **'Colors & Gradients'**
  String get codeForgeColorStudio;

  /// Label for barcode foreground color
  ///
  /// In en, this message translates to:
  /// **'Foreground'**
  String get codeForgeFgColor;

  /// Label for barcode background color
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get codeForgeBgColor;

  /// Label for finder pattern outer ring color
  ///
  /// In en, this message translates to:
  /// **'Eye Outer Ring'**
  String get codeForgeEyeOuterColor;

  /// Label for finder pattern center pupil color
  ///
  /// In en, this message translates to:
  /// **'Eye Center Ball'**
  String get codeForgeEyeInnerColor;

  /// Gradient option: solid color without gradient
  ///
  /// In en, this message translates to:
  /// **'Solid Color'**
  String get codeForgeGradientNone;

  /// Gradient theme: warm sunset
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get codeForgeGradientSunset;

  /// Gradient theme: cool ocean blue
  ///
  /// In en, this message translates to:
  /// **'Ocean'**
  String get codeForgeGradientOcean;

  /// Gradient theme: vibrant cyan neon
  ///
  /// In en, this message translates to:
  /// **'Neon'**
  String get codeForgeGradientNeon;

  /// Gradient theme: warm royal gold
  ///
  /// In en, this message translates to:
  /// **'Royal Gold'**
  String get codeForgeGradientGold;

  /// Selector label for QR error correction level
  ///
  /// In en, this message translates to:
  /// **'Error Correction'**
  String get codeForgeErrorCorrection;

  /// Selector label for center embedded logo/badge
  ///
  /// In en, this message translates to:
  /// **'Center Badge'**
  String get codeForgeCenterBadge;

  /// Badge option: no center icon
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get codeForgeBadgeNone;

  /// Badge option: icon matching the payload type
  ///
  /// In en, this message translates to:
  /// **'Content Icon'**
  String get codeForgeBadgeIcon;

  /// Badge option: safety verified shield emblem
  ///
  /// In en, this message translates to:
  /// **'Verified Shield'**
  String get codeForgeBadgeShield;

  /// Button to export and share high-resolution PNG image
  ///
  /// In en, this message translates to:
  /// **'Share PNG'**
  String get codeForgeExportPng;

  /// Button to export and share vector SVG file
  ///
  /// In en, this message translates to:
  /// **'Share SVG'**
  String get codeForgeExportSvg;

  /// Button to copy raw barcode content to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy Content'**
  String get codeForgeCopyPayload;

  /// Toast message after copying barcode content
  ///
  /// In en, this message translates to:
  /// **'Barcode content copied to clipboard'**
  String get codeForgeCopied;

  /// Badge label shown when URL passes all safety checks
  ///
  /// In en, this message translates to:
  /// **'Verified Safe by 6-Layer Security Engine'**
  String get codeForgeSafeVerified;

  /// Action tooltip to reset visual styling to defaults
  ///
  /// In en, this message translates to:
  /// **'Reset Styling'**
  String get codeForgeResetStyle;

  /// Checkbox to show human-readable text under 1D barcodes
  ///
  /// In en, this message translates to:
  /// **'Show Text Label'**
  String get codeForgeIncludeText;

  /// Header for live code preview card
  ///
  /// In en, this message translates to:
  /// **'Live Preview'**
  String get codeForgePreview;

  /// Button to skip onboarding and proceed directly to scanner
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// Button to advance to next onboarding slide
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// Button on final onboarding slide to finish and enter scanner
  ///
  /// In en, this message translates to:
  /// **'Start Scanning'**
  String get onboardingGetStarted;

  /// Badge tag for 6-layer URL safety engine slide
  ///
  /// In en, this message translates to:
  /// **'6-Layer Security'**
  String get onboardingSlide1Badge;

  /// Title for first onboarding slide explaining URL safety
  ///
  /// In en, this message translates to:
  /// **'6-Layer URL Safety Engine'**
  String get onboardingSlide1Title;

  /// Description for first onboarding slide explaining URL defense layers
  ///
  /// In en, this message translates to:
  /// **'Every link is inspected across six offline and online defense layers before you open it, protecting you against phishing, malicious redirects, and homograph traps.'**
  String get onboardingSlide1Description;

  /// First highlight bullet for URL safety slide
  ///
  /// In en, this message translates to:
  /// **'Protocol & Homograph Shield'**
  String get onboardingSlide1Bullet1;

  /// Second highlight bullet for URL safety slide
  ///
  /// In en, this message translates to:
  /// **'TLD Entropy & Port Trap Analysis'**
  String get onboardingSlide1Bullet2;

  /// Third highlight bullet for URL safety slide
  ///
  /// In en, this message translates to:
  /// **'Private Probing & Safe Browsing'**
  String get onboardingSlide1Bullet3;

  /// Badge tag for QuishingGuard tamper detection slide
  ///
  /// In en, this message translates to:
  /// **'Computer Vision'**
  String get onboardingSlide2Badge;

  /// Title for second onboarding slide explaining QuishingGuard
  ///
  /// In en, this message translates to:
  /// **'QuishingGuard™ Tamper Detection'**
  String get onboardingSlide2Title;

  /// Description for second onboarding slide explaining sticker tampering
  ///
  /// In en, this message translates to:
  /// **'Criminals paste fraudulent QR stickers over authentic signs. QuishingGuard inspects physical edges, shadows, and surface paper textures before you scan.'**
  String get onboardingSlide2Description;

  /// First highlight bullet for QuishingGuard slide
  ///
  /// In en, this message translates to:
  /// **'Physical sticker overlay detection'**
  String get onboardingSlide2Bullet1;

  /// Second highlight bullet for QuishingGuard slide
  ///
  /// In en, this message translates to:
  /// **'Cut edge & shadow boundary analysis'**
  String get onboardingSlide2Bullet2;

  /// Third highlight bullet for QuishingGuard slide
  ///
  /// In en, this message translates to:
  /// **'Real-time camera frame inspection'**
  String get onboardingSlide2Bullet3;

  /// Badge tag for offline privacy model slide
  ///
  /// In en, this message translates to:
  /// **'Zero Cloud • Zero Tracking'**
  String get onboardingSlide3Badge;

  /// Title for third onboarding slide explaining privacy
  ///
  /// In en, this message translates to:
  /// **'100% Offline Privacy Model'**
  String get onboardingSlide3Title;

  /// Description for third onboarding slide explaining offline architecture
  ///
  /// In en, this message translates to:
  /// **'Your scans and personal data never leave your phone. There are no analytics SDKs, no trackers, and no remote servers watching your habits.'**
  String get onboardingSlide3Description;

  /// First highlight bullet for offline privacy slide
  ///
  /// In en, this message translates to:
  /// **'Encrypted on-device SQLite database'**
  String get onboardingSlide3Bullet1;

  /// Second highlight bullet for offline privacy slide
  ///
  /// In en, this message translates to:
  /// **'AirQR optical air-gap transfers'**
  String get onboardingSlide3Bullet2;

  /// Third highlight bullet for offline privacy slide
  ///
  /// In en, this message translates to:
  /// **'Zero analytics or crash reporting SDKs'**
  String get onboardingSlide3Bullet3;

  /// Settings and Help option to replay the 3-slide onboarding tour
  ///
  /// In en, this message translates to:
  /// **'Welcome Tour'**
  String get settingsOnboardingTourTitle;

  /// Subtitle describing the welcome tour replay action
  ///
  /// In en, this message translates to:
  /// **'Revisit the 3-slide introduction to safety and privacy features'**
  String get settingsOnboardingTourSubtitle;

  /// Title for continuous batch scanning mode
  ///
  /// In en, this message translates to:
  /// **'Batch Scan Mode'**
  String get batchScanMode;

  /// Tooltip for toggling continuous batch scan mode
  ///
  /// In en, this message translates to:
  /// **'Toggle Continuous Batch Scan'**
  String get batchModeTooltip;

  /// Toast message displayed when batch scan mode is turned on
  ///
  /// In en, this message translates to:
  /// **'Continuous Batch Scan enabled'**
  String get batchModeEnabledToast;

  /// Toast message displayed when batch scan mode is turned off
  ///
  /// In en, this message translates to:
  /// **'Continuous Batch Scan disabled'**
  String get batchModeDisabledToast;

  /// Counter badge showing number of barcodes scanned in batch
  ///
  /// In en, this message translates to:
  /// **'{count} Scanned'**
  String batchCounterBadge(int count);

  /// Title of the batch review modal bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Batch Scans'**
  String get batchReviewTitle;

  /// Subtitle of the batch review sheet
  ///
  /// In en, this message translates to:
  /// **'Continuous scanning queue'**
  String get batchReviewSubtitle;

  /// Title shown when batch queue is empty
  ///
  /// In en, this message translates to:
  /// **'No codes in batch'**
  String get batchEmptyTitle;

  /// Description shown when batch queue is empty
  ///
  /// In en, this message translates to:
  /// **'Point your camera at barcodes to scan them continuously without leaving the camera.'**
  String get batchEmptySubtitle;

  /// Button to export the batch scans
  ///
  /// In en, this message translates to:
  /// **'Export Batch'**
  String get batchExport;

  /// Button to clear all scans from the active batch
  ///
  /// In en, this message translates to:
  /// **'Clear Batch'**
  String get batchClear;

  /// Confirmation title to clear the batch queue
  ///
  /// In en, this message translates to:
  /// **'Clear Batch?'**
  String get batchClearConfirmTitle;

  /// Confirmation content to clear the batch queue
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove all scanned codes from this batch?'**
  String get batchClearConfirmContent;

  /// Label for duplicate prevention toggle in batch review sheet
  ///
  /// In en, this message translates to:
  /// **'Prevent Duplicates'**
  String get batchPreventDuplicates;

  /// Toast message displayed in camera viewport when a barcode is scanned in batch mode
  ///
  /// In en, this message translates to:
  /// **'Scanned #{count}: {content}'**
  String batchScannedToast(int count, String content);

  /// Label for verified safe link in batch list
  ///
  /// In en, this message translates to:
  /// **'Safe Link'**
  String get batchSafeUrl;

  /// Label for suspicious link in batch list
  ///
  /// In en, this message translates to:
  /// **'Suspicious Link'**
  String get batchSuspiciousUrl;

  /// Label when 6-layer URL safety check is running in background
  ///
  /// In en, this message translates to:
  /// **'Analyzing link...'**
  String get batchAnalyzingUrl;

  /// Summary of 6-layer URL safety checks across URLs in batch
  ///
  /// In en, this message translates to:
  /// **'{safeCount} safe, {warningCount} suspicious of {totalUrls} links'**
  String batchUrlSafetySummary(int safeCount, int warningCount, int totalUrls);

  /// Title of the bottom sheet displaying details of an individual batch scan item
  ///
  /// In en, this message translates to:
  /// **'Scanned Code Details'**
  String get batchItemDetailsTitle;

  /// Barcode format label in batch item details
  ///
  /// In en, this message translates to:
  /// **'Format: {format}'**
  String batchFormatLabel(String format);

  /// Timestamp label in batch item details
  ///
  /// In en, this message translates to:
  /// **'Scanned at {time}'**
  String batchTimeLabel(String time);

  /// Label for distance-enhanced scanning pipeline toggle in camera settings
  ///
  /// In en, this message translates to:
  /// **'Distance Scan Assist'**
  String get cameraDistanceEnhanceLabel;

  /// Subtitle describing distance-enhanced scanning pipeline
  ///
  /// In en, this message translates to:
  /// **'Zoom-crop & unsharp mask for distant posters & signs'**
  String get cameraDistanceEnhanceHint;

  /// Label for unsharp mask sharpness slider in camera settings
  ///
  /// In en, this message translates to:
  /// **'Edge Sharpness'**
  String get cameraUnsharpLabel;

  /// Label for the digital zoom slider of Distance Scan Assist in camera settings
  ///
  /// In en, this message translates to:
  /// **'Distance Zoom'**
  String get cameraDistanceZoomLabel;

  /// Tooltip for distance scan assist toggle button in camera viewport
  ///
  /// In en, this message translates to:
  /// **'Distance Scan Assist'**
  String get scanDistanceModeTooltip;

  /// HUD badge text displayed when distance scan assist mode is active
  ///
  /// In en, this message translates to:
  /// **'Distance Mode Active'**
  String get scanDistanceModeActive;

  /// Button and tooltip to scan barcode, URL, or image from system clipboard
  ///
  /// In en, this message translates to:
  /// **'Scan from Clipboard'**
  String get scanFromClipboard;

  /// Title for quick scan banner when clipboard has scannable content
  ///
  /// In en, this message translates to:
  /// **'Clipboard content detected'**
  String get clipboardBannerTitle;

  /// Action button to trigger scan of detected clipboard content
  ///
  /// In en, this message translates to:
  /// **'Scan Now'**
  String get clipboardActionScan;

  /// Action button to dismiss the clipboard detection banner
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get clipboardDismiss;

  /// Message shown when clipboard contains no text or image
  ///
  /// In en, this message translates to:
  /// **'Clipboard is empty'**
  String get clipboardEmptyMessage;

  /// Message shown when clipboard content is not recognized as a barcode, URL, or image
  ///
  /// In en, this message translates to:
  /// **'No scannable link, code, or image found in clipboard'**
  String get clipboardNoValidContent;

  /// Type label for detected URL in clipboard
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get clipboardTypeUrl;

  /// Type label for detected barcode payload in clipboard
  ///
  /// In en, this message translates to:
  /// **'Barcode Payload'**
  String get clipboardTypeBarcode;

  /// Type label for detected image in clipboard
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get clipboardTypeImage;

  /// Type label for detected text in clipboard
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get clipboardTypeText;

  /// Banner informing the user that multiple barcodes are visible in the viewfinder and prompting them to tap one to scan
  ///
  /// In en, this message translates to:
  /// **'Multiple codes detected. Tap a code to scan.'**
  String get multiCodeDetectedBanner;

  /// Tooltip and action hint for tapping a visible barcode bounding box
  ///
  /// In en, this message translates to:
  /// **'Tap to scan'**
  String get multiCodeTapToScan;

  /// Settings title for toggling multi-code detection on the main camera scanner
  ///
  /// In en, this message translates to:
  /// **'Multi-Code Selection'**
  String get multiCodeSelectionTitle;

  /// Settings subtitle explaining the multi-code selection behavior
  ///
  /// In en, this message translates to:
  /// **'Outline visible codes and tap to choose when multiple are present'**
  String get multiCodeSelectionSubtitle;

  /// Tooltip for dismissing the multi-code selection banner
  ///
  /// In en, this message translates to:
  /// **'Dismiss selection'**
  String get multiCodeDismissTooltip;

  /// Title of the GhostScan screen content QR detector feature
  ///
  /// In en, this message translates to:
  /// **'GhostScan'**
  String get ghostScanTitle;

  /// Subtitle describing GhostScan capability
  ///
  /// In en, this message translates to:
  /// **'Screen Content QR Detector'**
  String get ghostScanSubtitle;

  /// Explanation of how GhostScan scans screen contents without manual screenshots
  ///
  /// In en, this message translates to:
  /// **'Detect and decode QR codes visible on your screen inside any app without taking manual screenshots.'**
  String get ghostScanDescription;

  /// Label for the Android Quick Settings tile
  ///
  /// In en, this message translates to:
  /// **'GhostScan'**
  String get ghostScanTileLabel;

  /// Button to trigger on-demand screen scanning
  ///
  /// In en, this message translates to:
  /// **'Scan Screen Now'**
  String get ghostScanActionScanNow;

  /// Button to request adding the GhostScan tile to Quick Settings
  ///
  /// In en, this message translates to:
  /// **'Add Quick Settings Tile'**
  String get ghostScanActionAddTile;

  /// Toast confirming the tile addition request was sent to the system
  ///
  /// In en, this message translates to:
  /// **'Quick Settings tile request sent'**
  String get ghostScanTileAdded;

  /// Header for step-by-step instructions on using GhostScan
  ///
  /// In en, this message translates to:
  /// **'How to use GhostScan'**
  String get ghostScanHowItWorksTitle;

  /// First step for using GhostScan via Quick Settings
  ///
  /// In en, this message translates to:
  /// **'Pull down your Quick Settings notification shade from any app.'**
  String get ghostScanStep1;

  /// Second step for using GhostScan via Quick Settings
  ///
  /// In en, this message translates to:
  /// **'Tap the GhostScan tile to capture and decode the screen.'**
  String get ghostScanStep2;

  /// Third step for using GhostScan via Quick Settings
  ///
  /// In en, this message translates to:
  /// **'The code is decoded instantly without saving screenshots to your gallery.'**
  String get ghostScanStep3;

  /// Status message while processing a captured screen image
  ///
  /// In en, this message translates to:
  /// **'Analyzing screen content...'**
  String get ghostScanAnalyzing;

  /// Message shown when no barcode is found in the screen capture
  ///
  /// In en, this message translates to:
  /// **'No QR code or barcode detected on screen'**
  String get ghostScanNoCodeFound;

  /// Help Center hub: group header above the scanning guides
  ///
  /// In en, this message translates to:
  /// **'Scanning & Ingestion Guides'**
  String get helpGuideGroupScanning;

  /// Help Center hub: group header above the security guides
  ///
  /// In en, this message translates to:
  /// **'Security & Threat Defense'**
  String get helpGuideGroupSecurity;

  /// Help Center hub: group header above the payload, storage and privacy guides
  ///
  /// In en, this message translates to:
  /// **'Payloads, Storage & Privacy'**
  String get helpGuideGroupPayloads;

  /// App bar title of the Barcode & Media Scanning help screen. Short label.
  ///
  /// In en, this message translates to:
  /// **'Barcode scanning'**
  String get titleHelpBarcode;

  /// Help Center hub: card title for the Barcode & Media Scanning guide
  ///
  /// In en, this message translates to:
  /// **'Barcode & Media Scanning'**
  String get helpGuideBarcodeName;

  /// Help Center hub: card subtitle for the Barcode & Media Scanning guide
  ///
  /// In en, this message translates to:
  /// **'Live camera controls, gallery photos, and multi-page PDF document scanning.'**
  String get helpGuideBarcodeSummary;

  /// Barcode help screen: intro paragraph
  ///
  /// In en, this message translates to:
  /// **'Scan any 1D or 2D barcode instantly using live camera, photo gallery images, or multi-page PDF documents with high-precision computer vision.'**
  String get helpGuideBarcodeIntro;

  /// Barcode help screen: section heading about the live camera
  ///
  /// In en, this message translates to:
  /// **'Live Camera Viewport'**
  String get helpGuideBarcodeCameraTitle;

  /// Barcode help screen: live camera bullet 1 (supported formats; keep format names as-is)
  ///
  /// In en, this message translates to:
  /// **'Aim your camera at any QR code, Data Matrix, Aztec, PDF417, EAN-13, UPC-A, Code 128, or Codabar symbol.'**
  String get helpGuideBarcodeCameraBullet1;

  /// Barcode help screen: live camera bullet 2 (torch and zoom)
  ///
  /// In en, this message translates to:
  /// **'Torch & Zoom: Tap the Flashlight icon in low light, or use the zoom slider to read high-density micro-QR codes from a distance.'**
  String get helpGuideBarcodeCameraBullet2;

  /// Barcode help screen: live camera bullet 3 (viewfinder overlays in Settings)
  ///
  /// In en, this message translates to:
  /// **'Viewfinder Overlays: Customize the visual scan frame under Settings -> Appearance to suit your preference.'**
  String get helpGuideBarcodeCameraBullet3;

  /// Barcode help screen: section heading about scanning gallery images
  ///
  /// In en, this message translates to:
  /// **'Scanning Gallery Photos & Images'**
  String get helpGuideBarcodeGalleryTitle;

  /// Barcode help screen: gallery bullet 1
  ///
  /// In en, this message translates to:
  /// **'Tap the Gallery icon on the scanner screen to pick any saved image or screenshot from your device.'**
  String get helpGuideBarcodeGalleryBullet1;

  /// Barcode help screen: gallery bullet 2 (photo picker privacy)
  ///
  /// In en, this message translates to:
  /// **'Uses privacy-safe Android Photo Picker without requiring broad storage permissions.'**
  String get helpGuideBarcodeGalleryBullet2;

  /// Barcode help screen: gallery bullet 3
  ///
  /// In en, this message translates to:
  /// **'The scanner analyzes full-resolution image frames to detect and decode multiple barcodes in milliseconds.'**
  String get helpGuideBarcodeGalleryBullet3;

  /// Barcode help screen: section heading about PDF scanning
  ///
  /// In en, this message translates to:
  /// **'Multi-Page PDF Scanning'**
  String get helpGuideBarcodePdfTitle;

  /// Barcode help screen: PDF bullet 1
  ///
  /// In en, this message translates to:
  /// **'Select a PDF document (such as an invoice, ticket, or boarding pass) directly through the file picker.'**
  String get helpGuideBarcodePdfBullet1;

  /// Barcode help screen: PDF bullet 2
  ///
  /// In en, this message translates to:
  /// **'Extracts and renders every page in memory, cataloging all barcodes found across each individual page.'**
  String get helpGuideBarcodePdfBullet2;

  /// Barcode help screen: PDF bullet 3
  ///
  /// In en, this message translates to:
  /// **'Review all detected codes in a dedicated bottom sheet and save them into your scan history in 1 tap.'**
  String get helpGuideBarcodePdfBullet3;

  /// Barcode help screen: tip box at the bottom
  ///
  /// In en, this message translates to:
  /// **'Tip: Barcode recognition operates 100% locally on your device without uploading your camera frames or images to the cloud.'**
  String get helpGuideBarcodeTip;

  /// App bar title of the AR CodeVision help screen. Short label.
  ///
  /// In en, this message translates to:
  /// **'AR CodeVision'**
  String get titleHelpArCodeVision;

  /// Help Center hub: card title for the AR CodeVision guide (keep the trademark name)
  ///
  /// In en, this message translates to:
  /// **'AR CodeVision™ Spatial HUD'**
  String get helpGuideArCodeVisionName;

  /// Help Center hub: card subtitle for the AR CodeVision guide
  ///
  /// In en, this message translates to:
  /// **'Real-time multi-barcode camera tracking, floating chips, and batch actions.'**
  String get helpGuideArCodeVisionSummary;

  /// AR CodeVision help screen: intro paragraph
  ///
  /// In en, this message translates to:
  /// **'AR CodeVision™ transforms your camera viewport into an augmented reality spatial heads-up display that detects, tracks, and analyzes multiple barcodes simultaneously in real time.'**
  String get helpGuideArCodeVisionIntro;

  /// AR CodeVision help screen: section heading about spatial tracking
  ///
  /// In en, this message translates to:
  /// **'Real-Time Spatial Tracking'**
  String get helpGuideArCodeVisionTrackingTitle;

  /// AR CodeVision help screen: tracking bullet 1
  ///
  /// In en, this message translates to:
  /// **'Simultaneously identifies every barcode within the camera frame, locking a spatial 2D/3D tracking anchor onto each code.'**
  String get helpGuideArCodeVisionTrackingBullet1;

  /// AR CodeVision help screen: tracking bullet 2
  ///
  /// In en, this message translates to:
  /// **'Renders floating interactive chips directly above each physical barcode on screen as you move your camera.'**
  String get helpGuideArCodeVisionTrackingBullet2;

  /// AR CodeVision help screen: tracking bullet 3 (color badges)
  ///
  /// In en, this message translates to:
  /// **'Live color-coded security badges immediately indicate if a link is Verified Safe (green) or Phishing Suspicion (red).'**
  String get helpGuideArCodeVisionTrackingBullet3;

  /// AR CodeVision help screen: section heading about multi-select and batch actions
  ///
  /// In en, this message translates to:
  /// **'Interactive Multi-Select & Batch Actions'**
  String get helpGuideArCodeVisionBatchTitle;

  /// AR CodeVision help screen: batch bullet 1
  ///
  /// In en, this message translates to:
  /// **'Tap any floating chip to inspect its payload, trigger contextual actions, or open the detailed AR Action Sheet.'**
  String get helpGuideArCodeVisionBatchBullet1;

  /// AR CodeVision help screen: batch bullet 2
  ///
  /// In en, this message translates to:
  /// **'Select multiple items across warehouse shelves, product catalogs, or event badges for batch processing.'**
  String get helpGuideArCodeVisionBatchBullet2;

  /// AR CodeVision help screen: batch bullet 3
  ///
  /// In en, this message translates to:
  /// **'Copy all selected payload contents or export targets to your history in a single tap.'**
  String get helpGuideArCodeVisionBatchBullet3;

  /// AR CodeVision help screen: section heading about HUD controls
  ///
  /// In en, this message translates to:
  /// **'HUD Controls & Performance'**
  String get helpGuideArCodeVisionHudTitle;

  /// AR CodeVision help screen: HUD bullet 1
  ///
  /// In en, this message translates to:
  /// **'HUD Action Strip: Quick toggles for camera flash, zoom level, front/rear camera flip, and target clearing.'**
  String get helpGuideArCodeVisionHudBullet1;

  /// AR CodeVision help screen: HUD bullet 2
  ///
  /// In en, this message translates to:
  /// **'Optimized hardware frame rate processing prevents thermal throttling and conserves battery during extended scanning sessions.'**
  String get helpGuideArCodeVisionHudBullet2;

  /// AR CodeVision help screen: tip box at the bottom
  ///
  /// In en, this message translates to:
  /// **'Tip: In dense environments with dozens of barcodes, use the zoom slider to isolate specific clusters with surgical precision.'**
  String get helpGuideArCodeVisionTip;

  /// App bar title of the AirQR help screen. Short label.
  ///
  /// In en, this message translates to:
  /// **'AirQR guide'**
  String get titleHelpAirQr;

  /// Help Center hub: card title for the AirQR guide (keep the trademark name)
  ///
  /// In en, this message translates to:
  /// **'AirQR™ Optical Air-Gap Stream'**
  String get helpGuideAirQrName;

  /// Help Center hub: card subtitle for the AirQR guide
  ///
  /// In en, this message translates to:
  /// **'Offline animated QR strobe transmitter and receiver for radio-silent data sharing.'**
  String get helpGuideAirQrSummary;

  /// AirQR help screen: intro paragraph
  ///
  /// In en, this message translates to:
  /// **'AirQR™ establishes a bidirectional, completely offline optical data pipeline between devices using high-speed animated QR strobe frames without needing Wi-Fi, Bluetooth, cellular data, or physical cables.'**
  String get helpGuideAirQrIntro;

  /// AirQR help screen: section heading about how streaming works
  ///
  /// In en, this message translates to:
  /// **'How Optical Streaming Works'**
  String get helpGuideAirQrStreamingTitle;

  /// AirQR help screen: streaming bullet 1 (data frames plus LT fountain-code repair frames)
  ///
  /// In en, this message translates to:
  /// **'Large files, cryptographic keys, or long documents are divided into small data frames, plus extra fountain-code repair frames that let the receiver rebuild frames it missed.'**
  String get helpGuideAirQrStreamingBullet1;

  /// AirQR help screen: streaming bullet 2 (frame rate range 5 to 25 FPS)
  ///
  /// In en, this message translates to:
  /// **'The transmitting device flashes the animated QR code stream at a customizable frame rate (5 to 25 FPS).'**
  String get helpGuideAirQrStreamingBullet2;

  /// AirQR help screen: streaming bullet 3
  ///
  /// In en, this message translates to:
  /// **'The receiving device continuously captures the strobe sequence, reconstructing missing frames on the fly until the full payload is reassembled.'**
  String get helpGuideAirQrStreamingBullet3;

  /// AirQR help screen: section heading about air-gap security
  ///
  /// In en, this message translates to:
  /// **'Air-Gap Security & Privacy'**
  String get helpGuideAirQrSecurityTitle;

  /// AirQR help screen: security bullet 1
  ///
  /// In en, this message translates to:
  /// **'Complete Radio Silence: Zero electromagnetic radio emissions (no RF broadcasts, pairing requests, or network logs).'**
  String get helpGuideAirQrSecurityBullet1;

  /// AirQR help screen: security bullet 2
  ///
  /// In en, this message translates to:
  /// **'Immune to remote network interception, man-in-the-middle attacks, and Bluetooth sniffing vulnerabilities.'**
  String get helpGuideAirQrSecurityBullet2;

  /// AirQR help screen: security bullet 3
  ///
  /// In en, this message translates to:
  /// **'Perfect for air-gapped cryptocurrency cold wallets, confidential credentials, and secure offline data sharing.'**
  String get helpGuideAirQrSecurityBullet3;

  /// AirQR help screen: section heading about transmitter and receiver controls
  ///
  /// In en, this message translates to:
  /// **'Transmitter & Receiver Controls'**
  String get helpGuideAirQrControlsTitle;

  /// AirQR help screen: controls bullet 1 (transmitter has a frame rate control only; no chunk-size control)
  ///
  /// In en, this message translates to:
  /// **'Transmitter Screen: Choose the frame rate (FPS) and see the total number of frames in the stream.'**
  String get helpGuideAirQrControlsBullet1;

  /// AirQR help screen: controls bullet 2
  ///
  /// In en, this message translates to:
  /// **'Receiver Screen: Real-time progress bar, captured frame counter, missing frame indices, and checksum verification.'**
  String get helpGuideAirQrControlsBullet2;

  /// AirQR help screen: tip box at the bottom
  ///
  /// In en, this message translates to:
  /// **'Tip: When receiving an AirQR stream, hold your phone steady and ensure the transmitter screen brightness is set to high for maximum frame capture speed.'**
  String get helpGuideAirQrTip;

  /// App bar title of the URL safety help screen. Short label.
  ///
  /// In en, this message translates to:
  /// **'URL safety'**
  String get titleHelpUrlSafety;

  /// Help Center hub: card title for the URL safety guide
  ///
  /// In en, this message translates to:
  /// **'6-Layer URL Safety Engine'**
  String get helpGuideUrlSafetyName;

  /// Help Center hub: card subtitle for the URL safety guide
  ///
  /// In en, this message translates to:
  /// **'Homograph attacks, punycode defense, suspicious TLDs, and heuristic port traps.'**
  String get helpGuideUrlSafetySummary;

  /// URL safety help screen: intro paragraph
  ///
  /// In en, this message translates to:
  /// **'Before you open any scanned web link, our comprehensive 6-layer forensic safety engine evaluates the URL against modern phishing heuristics, homograph spoofing attacks, and malicious redirect traps.'**
  String get helpGuideUrlSafetyIntro;

  /// URL safety help screen: section heading for the list of 6 layers
  ///
  /// In en, this message translates to:
  /// **'The 6 Safety Layers Explained'**
  String get helpGuideUrlSafetyLayersTitle;

  /// URL safety help screen: layer 1 description
  ///
  /// In en, this message translates to:
  /// **'Layer 1: Protocol & Scheme Guard - Enforces HTTPS encryption and verifies standard protocol formatting while intercepting malformed or zero-width character traps.'**
  String get helpGuideUrlSafetyLayersBullet1;

  /// URL safety help screen: layer 2 description. Keep the Cyrillic example letter as-is.
  ///
  /// In en, this message translates to:
  /// **'Layer 2: Homograph & Unicode Attack Shield - Identifies Cyrillic, Greek, and mixed-script lookalike characters (such as \"а\" instead of \"a\") used by scammers to imitate trusted websites.'**
  String get helpGuideUrlSafetyLayersBullet2;

  /// URL safety help screen: layer 3 description
  ///
  /// In en, this message translates to:
  /// **'Layer 3: Suspicious TLD & Entropy Analysis - Flags high-risk domain endings (.xyz, .top, .work), excessive subdomain nesting, and randomized machine-generated domain names.'**
  String get helpGuideUrlSafetyLayersBullet3;

  /// URL safety help screen: layer 4 description
  ///
  /// In en, this message translates to:
  /// **'Layer 4: Heuristic IP & Non-Standard Port Trap - Detects links connecting directly to numeric IP addresses or weird port numbers often used by botnet malware servers.'**
  String get helpGuideUrlSafetyLayersBullet4;

  /// URL safety help screen: layer 5 description
  ///
  /// In en, this message translates to:
  /// **'Layer 5: Privacy-Safe Online Head Probing - Optionally follows shortened URL redirects (bit.ly, tinyurl) and inspects SSL certificate trust chains without executing malicious JavaScript.'**
  String get helpGuideUrlSafetyLayersBullet5;

  /// URL safety help screen: layer 6 description
  ///
  /// In en, this message translates to:
  /// **'Layer 6: Google Safe Browsing API Integration - Optional cloud-based real-time threat intelligence protecting against phishing sites and malware distribution networks.'**
  String get helpGuideUrlSafetyLayersBullet6;

  /// URL safety help screen: section heading about safety verdicts
  ///
  /// In en, this message translates to:
  /// **'Safety Verdicts & Action Guidance'**
  String get helpGuideUrlSafetyVerdictsTitle;

  /// URL safety help screen: verdict bullet 1 (green)
  ///
  /// In en, this message translates to:
  /// **'Verified Safe (Green): The URL passed all structural and threat checks without triggering any suspicious signals.'**
  String get helpGuideUrlSafetyVerdictsBullet1;

  /// URL safety help screen: verdict bullet 2 (orange/red)
  ///
  /// In en, this message translates to:
  /// **'Caution / Warning (Orange/Red): High risk factors detected. The app displays the full unshortened destination and highlights exactly which rules triggered the alert.'**
  String get helpGuideUrlSafetyVerdictsBullet2;

  /// URL safety help screen: tip box at the bottom
  ///
  /// In en, this message translates to:
  /// **'Tip: Layers 1 through 4 operate 100% offline using on-device heuristics, protecting your privacy wherever you are.'**
  String get helpGuideUrlSafetyTip;

  /// App bar title of the QuishingGuard help screen. Short label.
  ///
  /// In en, this message translates to:
  /// **'QuishingGuard'**
  String get titleHelpQuishing;

  /// Help Center hub: card title for the QuishingGuard guide (keep the trademark name)
  ///
  /// In en, this message translates to:
  /// **'QuishingGuard™ Tamper Detection'**
  String get helpGuideQuishingName;

  /// Help Center hub: card subtitle for the QuishingGuard guide
  ///
  /// In en, this message translates to:
  /// **'On-device computer vision analyzing physical QR sticker overlays and edge cuts.'**
  String get helpGuideQuishingSummary;

  /// QuishingGuard help screen: intro paragraph (explains what quishing is)
  ///
  /// In en, this message translates to:
  /// **'Quishing (QR Phishing) occurs when criminals paste physical fraudulent sticker QR codes over legitimate QR codes on parking meters, restaurant menus, payment counters, or transit signs.'**
  String get helpGuideQuishingIntro;

  /// QuishingGuard help screen: section heading about on-device computer vision
  ///
  /// In en, this message translates to:
  /// **'On-Device Computer Vision Analysis'**
  String get helpGuideQuishingCvTitle;

  /// QuishingGuard help screen: computer vision bullet 1 (edge metric)
  ///
  /// In en, this message translates to:
  /// **'Edge Discontinuity Metric: Detects double edges, cutting misalignment, and micro-shadows along the boundary of pasted overlay stickers.'**
  String get helpGuideQuishingCvBullet1;

  /// QuishingGuard help screen: computer vision bullet 2 (print grain metric)
  ///
  /// In en, this message translates to:
  /// **'Print Grain & Halftone Metric: Identifies inconsistencies in dot pitch, chromatic noise, and print resolution between the code and surrounding background poster.'**
  String get helpGuideQuishingCvBullet2;

  /// QuishingGuard help screen: computer vision bullet 3 (risk score)
  ///
  /// In en, this message translates to:
  /// **'Calculates a combined Tamper Risk Score from 0% (Authentic) to 100% (High Tamper Risk).'**
  String get helpGuideQuishingCvBullet3;

  /// QuishingGuard help screen: section heading about forensic signals
  ///
  /// In en, this message translates to:
  /// **'Forensic Signal Inspection'**
  String get helpGuideQuishingForensicTitle;

  /// QuishingGuard help screen: forensic bullet 1. The quoted text must match the quishingViewSignals button.
  ///
  /// In en, this message translates to:
  /// **'Tap \"View Forensic Analysis\" on any scanned code to view real-time CV confidence levels, border edge metrics, and chromatic noise charts.'**
  String get helpGuideQuishingForensicBullet1;

  /// QuishingGuard help screen: forensic bullet 2
  ///
  /// In en, this message translates to:
  /// **'Helps identify suspicious payment QR codes in public places before sending money or typing credentials.'**
  String get helpGuideQuishingForensicBullet2;

  /// QuishingGuard help screen: tip box at the bottom
  ///
  /// In en, this message translates to:
  /// **'Tip: When scanning outdoor QR codes on parking meters or public kiosks, inspect the code physically with your fingers if QuishingGuard flags an edge discontinuity alert.'**
  String get helpGuideQuishingTip;

  /// App bar title of the Google Safe Browsing setup help screen. Short label.
  ///
  /// In en, this message translates to:
  /// **'Safe Browsing'**
  String get titleHelpSafeBrowsing;

  /// Help Center hub: card title for the Google Safe Browsing setup guide
  ///
  /// In en, this message translates to:
  /// **'Google Safe Browsing Setup'**
  String get helpGuideSafeBrowsingName;

  /// Help Center hub: card subtitle for the Google Safe Browsing setup guide
  ///
  /// In en, this message translates to:
  /// **'Acquiring a Google Cloud API key, hardware keystore storage, and lookup quotas.'**
  String get helpGuideSafeBrowsingSummary;

  /// Safe Browsing help screen: intro paragraph
  ///
  /// In en, this message translates to:
  /// **'Google Safe Browsing enables Layer 6 cloud threat intelligence to check scanned URLs against billions of constantly updated known malware, social engineering, and phishing threat entries.'**
  String get helpGuideSafeBrowsingIntro;

  /// Safe Browsing help screen: section heading for the API key steps
  ///
  /// In en, this message translates to:
  /// **'How to Obtain a Free API Key'**
  String get helpGuideSafeBrowsingKeyTitle;

  /// Safe Browsing help screen: API key step 1 (keep the URL as-is)
  ///
  /// In en, this message translates to:
  /// **'1. Open the Google Cloud Console (console.cloud.google.com) on your computer or mobile browser.'**
  String get helpGuideSafeBrowsingKeyStep1;

  /// Safe Browsing help screen: API key step 2 (the quoted project name is an English example)
  ///
  /// In en, this message translates to:
  /// **'2. Create a new Google Cloud Project (e.g., \"My QR Reader Security\").'**
  String get helpGuideSafeBrowsingKeyStep2;

  /// Safe Browsing help screen: API key step 3. Google Cloud Console menu names stay in English.
  ///
  /// In en, this message translates to:
  /// **'3. Navigate to APIs & Services -> Library and search for \"Web Risk API\" or \"Safe Browsing API\" and click Enable.'**
  String get helpGuideSafeBrowsingKeyStep3;

  /// Safe Browsing help screen: API key step 4. Google Cloud Console menu names stay in English.
  ///
  /// In en, this message translates to:
  /// **'4. Go to APIs & Services -> Credentials and click \"+ CREATE CREDENTIALS\" -> \"API key\".'**
  String get helpGuideSafeBrowsingKeyStep4;

  /// Safe Browsing help screen: API key step 5
  ///
  /// In en, this message translates to:
  /// **'5. Copy your new API key and paste it into the Google Safe Browsing field under Settings.'**
  String get helpGuideSafeBrowsingKeyStep5;

  /// Safe Browsing help screen: section heading about key storage and privacy
  ///
  /// In en, this message translates to:
  /// **'Privacy & Secure Keystore Storage'**
  String get helpGuideSafeBrowsingPrivacyTitle;

  /// Safe Browsing help screen: privacy bullet 1
  ///
  /// In en, this message translates to:
  /// **'Your API key is encrypted using Android Keystore hardware-backed secure storage (FlutterSecureStorage) and never exported or shared.'**
  String get helpGuideSafeBrowsingPrivacyBullet1;

  /// Safe Browsing help screen: privacy bullet 2
  ///
  /// In en, this message translates to:
  /// **'Google Safe Browsing is 100% optional. If no key is provided, the app continues to perform comprehensive offline checks.'**
  String get helpGuideSafeBrowsingPrivacyBullet2;

  /// Safe Browsing help screen: privacy bullet 3 (daily free quota)
  ///
  /// In en, this message translates to:
  /// **'Free Tier Quota: Google provides up to 10,000 free requests per day, and the app resets its local usage counter every 24 hours.'**
  String get helpGuideSafeBrowsingPrivacyBullet3;

  /// Safe Browsing help screen: tip box at the bottom
  ///
  /// In en, this message translates to:
  /// **'Tip: Safe Browsing checks only execute after offline heuristics pass, conserving your daily lookup quota.'**
  String get helpGuideSafeBrowsingTip;

  /// App bar title of the Smart Actions & Payments help screen. Short label.
  ///
  /// In en, this message translates to:
  /// **'Smart actions'**
  String get titleHelpSmartPayloads;

  /// Help Center hub: card title for the Smart Actions & Payments guide
  ///
  /// In en, this message translates to:
  /// **'Smart Actions & Payments'**
  String get helpGuideSmartPayloadsName;

  /// Help Center hub: card subtitle for the Smart Actions & Payments guide
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi connect, UPI & crypto payments, live TOTP 2FA tokens, vCards, and events.'**
  String get helpGuideSmartPayloadsSummary;

  /// Smart Actions help screen: intro paragraph
  ///
  /// In en, this message translates to:
  /// **'SreerajP QR Studio automatically identifies the semantic type of every barcode, presenting contextual, 1-tap actionable cards for Wi-Fi networks, UPI and crypto payments, 2FA tokens, contacts, and calendar events.'**
  String get helpGuideSmartPayloadsIntro;

  /// Smart Actions help screen: section heading about Wi-Fi
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi Network Auto-Connect'**
  String get helpGuideSmartPayloadsWifiTitle;

  /// Smart Actions help screen: Wi-Fi bullet 1. Keep the protocol token WIFI: as-is.
  ///
  /// In en, this message translates to:
  /// **'Scans WIFI: formatted barcodes containing SSID, encryption type (WPA, WPA2, WPA3, WEP, None), and network passwords.'**
  String get helpGuideSmartPayloadsWifiBullet1;

  /// Smart Actions help screen: Wi-Fi bullet 2
  ///
  /// In en, this message translates to:
  /// **'Includes a Password Reveal / Hide button and 1-tap clipboard copy.'**
  String get helpGuideSmartPayloadsWifiBullet2;

  /// Smart Actions help screen: Wi-Fi bullet 3. The quoted text must match the wifiConnectButton label.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Connect to Wi-Fi\" to trigger direct connection or jump straight to system Wi-Fi settings.'**
  String get helpGuideSmartPayloadsWifiBullet3;

  /// Smart Actions help screen: section heading about UPI and crypto payments
  ///
  /// In en, this message translates to:
  /// **'UPI & Cryptocurrency Payments'**
  String get helpGuideSmartPayloadsPaymentsTitle;

  /// Smart Actions help screen: payments bullet 1 (UPI)
  ///
  /// In en, this message translates to:
  /// **'Indian UPI QR Codes: Parses Virtual Payment Addresses (VPA), merchant names, transaction references, and exact amount values.'**
  String get helpGuideSmartPayloadsPaymentsBullet1;

  /// Smart Actions help screen: payments bullet 2 (keep app names as-is)
  ///
  /// In en, this message translates to:
  /// **'1-Tap Dispatch: Launches your installed payment apps (Google Pay, PhonePe, Paytm, or BHIM) with pre-filled transaction parameters.'**
  String get helpGuideSmartPayloadsPaymentsBullet2;

  /// Smart Actions help screen: payments bullet 3 (crypto)
  ///
  /// In en, this message translates to:
  /// **'Crypto QR Codes: Recognizes Bitcoin, Ethereum, and Solana wallet schemes with 1-tap copy and address formatting.'**
  String get helpGuideSmartPayloadsPaymentsBullet3;

  /// Smart Actions help screen: section heading about TOTP 2FA
  ///
  /// In en, this message translates to:
  /// **'TOTP 2FA Authenticator & Tokens'**
  String get helpGuideSmartPayloadsTotpTitle;

  /// Smart Actions help screen: TOTP bullet 1. Keep otpauth:// as-is.
  ///
  /// In en, this message translates to:
  /// **'Scans otpauth:// standard two-factor authentication setup codes used by Google Authenticator and Microsoft Authenticator.'**
  String get helpGuideSmartPayloadsTotpBullet1;

  /// Smart Actions help screen: TOTP bullet 2
  ///
  /// In en, this message translates to:
  /// **'Displays a live, rolling 6-digit one-time passcode with an animated 30-second circular countdown timer on device.'**
  String get helpGuideSmartPayloadsTotpBullet2;

  /// Smart Actions help screen: TOTP bullet 3. The quoted text must match the totpImportButton label.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Import into Authenticator App\" to register the key in your preferred 2FA app.'**
  String get helpGuideSmartPayloadsTotpBullet3;

  /// Smart Actions help screen: section heading about contacts and calendar events
  ///
  /// In en, this message translates to:
  /// **'Contacts & Calendar Events'**
  String get helpGuideSmartPayloadsContactsTitle;

  /// Smart Actions help screen: contacts bullet 1 (vCard and MeCard)
  ///
  /// In en, this message translates to:
  /// **'vCard & MeCard: Parses full name, telephone numbers, email addresses, organization, and job title with 1-tap address book import.'**
  String get helpGuideSmartPayloadsContactsBullet1;

  /// Smart Actions help screen: contacts bullet 2 (iCalendar events)
  ///
  /// In en, this message translates to:
  /// **'iCalendar (VEVENT): Parses event title, start and end date/time, location, and description, offering 1-tap Google/device calendar scheduling.'**
  String get helpGuideSmartPayloadsContactsBullet2;

  /// Smart Actions help screen: tip box at the bottom
  ///
  /// In en, this message translates to:
  /// **'Tip: When paying with UPI QR codes, always verify the merchant name shown on the card matches the physical store counter.'**
  String get helpGuideSmartPayloadsTip;

  /// App bar title of the History, Backups & Privacy help screen. Short label.
  ///
  /// In en, this message translates to:
  /// **'History & privacy'**
  String get titleHelpHistory;

  /// Help Center hub: card title for the History, Backups & Privacy guide
  ///
  /// In en, this message translates to:
  /// **'History, Backups & Privacy'**
  String get helpGuideHistoryName;

  /// Help Center hub: card subtitle for the History, Backups & Privacy guide
  ///
  /// In en, this message translates to:
  /// **'Offline SQLite database, JSON/CSV backups, biometrics, and screenshot guard.'**
  String get helpGuideHistorySummary;

  /// History help screen: intro paragraph
  ///
  /// In en, this message translates to:
  /// **'Your scan records belong solely to you. SreerajP QR Studio stores all history entries in a local SQLite database on your device with biometric authentication safeguards and structured export formats.'**
  String get helpGuideHistoryIntro;

  /// History help screen: section heading about managing scan history
  ///
  /// In en, this message translates to:
  /// **'Scan History Management'**
  String get helpGuideHistoryManageTitle;

  /// History help screen: manage bullet 1 (search and filter)
  ///
  /// In en, this message translates to:
  /// **'Search & Filter: Search scan history in real time by text query or filter by payload type (URLs, Wi-Fi, Contacts, Payments, TOTP).'**
  String get helpGuideHistoryManageBullet1;

  /// History help screen: manage bullet 2 (favorites)
  ///
  /// In en, this message translates to:
  /// **'Star Favorites: Mark important Wi-Fi credentials or loyalty codes as favorites for quick access.'**
  String get helpGuideHistoryManageBullet2;

  /// History help screen: manage bullet 3 (detail sheet)
  ///
  /// In en, this message translates to:
  /// **'Detailed Inspect Sheet: Review the exact raw decoded bytes, safety score breakdown, timestamp, and add custom notes.'**
  String get helpGuideHistoryManageBullet3;

  /// History help screen: section heading about backup and restore
  ///
  /// In en, this message translates to:
  /// **'Backup & Restore (JSON / CSV)'**
  String get helpGuideHistoryBackupTitle;

  /// History help screen: backup bullet 1 (JSON)
  ///
  /// In en, this message translates to:
  /// **'JSON Full Backup: Exports your complete history including custom tags, favorites, and safety results into a portable .json file.'**
  String get helpGuideHistoryBackupBullet1;

  /// History help screen: backup bullet 2 (CSV)
  ///
  /// In en, this message translates to:
  /// **'CSV Spreadsheet: Generates a clean comma-separated values file compatible with Microsoft Excel and Google Sheets.'**
  String get helpGuideHistoryBackupBullet2;

  /// History help screen: backup bullet 3 (restore)
  ///
  /// In en, this message translates to:
  /// **'One-Click Restore: Import previously exported JSON backup files at any time to restore your scan log.'**
  String get helpGuideHistoryBackupBullet3;

  /// History help screen: section heading about biometrics and screenshot guard
  ///
  /// In en, this message translates to:
  /// **'Biometrics & Screenshot Guard'**
  String get helpGuideHistoryBiometricsTitle;

  /// History help screen: biometrics bullet 1
  ///
  /// In en, this message translates to:
  /// **'Biometric Authentication: Protects sensitive StegoQR hidden records using your device fingerprint or facial recognition.'**
  String get helpGuideHistoryBiometricsBullet1;

  /// History help screen: biometrics bullet 2. Keep FLAG_SECURE as-is.
  ///
  /// In en, this message translates to:
  /// **'Screenshot Guard: Prevents malicious background apps or unauthorized shoulder-surfers from capturing screen content (FLAG_SECURE).'**
  String get helpGuideHistoryBiometricsBullet2;

  /// History help screen: tip box at the bottom
  ///
  /// In en, this message translates to:
  /// **'Tip: Back up your history to a JSON file before switching or resetting your phone to preserve your saved scans.'**
  String get helpGuideHistoryTip;

  /// App bar title of the FAQ & Troubleshooting help screen. Short label.
  ///
  /// In en, this message translates to:
  /// **'FAQ & help'**
  String get titleHelpFaq;

  /// Help Center hub: card title for the FAQ & Troubleshooting guide
  ///
  /// In en, this message translates to:
  /// **'FAQ & Troubleshooting'**
  String get helpGuideFaqName;

  /// Help Center hub: card subtitle for the FAQ & Troubleshooting guide
  ///
  /// In en, this message translates to:
  /// **'Common questions, camera focus tips, permission recovery, and offline guarantees.'**
  String get helpGuideFaqSummary;

  /// FAQ help screen: intro paragraph
  ///
  /// In en, this message translates to:
  /// **'Answers to common questions, camera troubleshooting advice, and privacy clarifications for SreerajP QR Studio.'**
  String get helpGuideFaqIntro;

  /// FAQ help screen: section heading for the questions
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get helpGuideFaqQuestionsTitle;

  /// FAQ help screen: question 1 and its answer, split by a line break
  ///
  /// In en, this message translates to:
  /// **'Q: Does the app work without internet?\nYes! 100% of barcode decoding, QuishingGuard CV checks, and URL safety heuristics (Layers 1-4) work completely offline.'**
  String get helpGuideFaqQuestion1;

  /// FAQ help screen: question 2 and its answer, split by a line break
  ///
  /// In en, this message translates to:
  /// **'Q: Is my camera feed sent to any server?\nNo. Camera frames are processed strictly on-device in volatile memory and are never recorded, saved, or uploaded.'**
  String get helpGuideFaqQuestion2;

  /// FAQ help screen: question 3 and its answer, split by a line break
  ///
  /// In en, this message translates to:
  /// **'Q: Why is Google Safe Browsing optional?\nWe believe in privacy-by-default. Offline safety layers protect you immediately, while Google Safe Browsing is an optional opt-in for users with a Google Cloud API key.'**
  String get helpGuideFaqQuestion3;

  /// FAQ help screen: section heading for camera troubleshooting
  ///
  /// In en, this message translates to:
  /// **'Camera Troubleshooting'**
  String get helpGuideFaqCameraTitle;

  /// FAQ help screen: camera bullet 1 (focus problems)
  ///
  /// In en, this message translates to:
  /// **'Camera Fails to Focus: Ensure the lens is clean and hold the device 15-20 cm away. In low light, tap the Flashlight icon.'**
  String get helpGuideFaqCameraBullet1;

  /// FAQ help screen: camera bullet 2 (tiny or dense codes)
  ///
  /// In en, this message translates to:
  /// **'Tiny or Dense QR Code: Use the zoom slider to magnify the QR code rather than bringing the phone too close.'**
  String get helpGuideFaqCameraBullet2;

  /// FAQ help screen: camera bullet 3 (restoring camera permission in Android Settings; the app name in the path is the Android app label)
  ///
  /// In en, this message translates to:
  /// **'Permission Denied: If camera permission was revoked, go to Android Settings -> Apps -> SreerajP QR Studio -> Permissions -> Camera -> Allow.'**
  String get helpGuideFaqCameraBullet3;

  /// FAQ help screen: tip box at the bottom
  ///
  /// In en, this message translates to:
  /// **'Tip: If you encounter an unusual barcode format, take a photo and use the Gallery scan tool to process it in full resolution.'**
  String get helpGuideFaqTip;

  /// Tooltip and sheet title for the menu of extra actions on the scan result screen
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get resultMoreActions;

  /// Shown in the safety summary card while link checks are running
  ///
  /// In en, this message translates to:
  /// **'Checking link safety…'**
  String get verdictChecking;

  /// Safety summary headline when no link check failed
  ///
  /// In en, this message translates to:
  /// **'No issues found'**
  String get verdictNoIssues;

  /// Safety summary headline with the number of failed link checks
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 issue found} other{{count} issues found}}'**
  String verdictIssuesFound(int count);

  /// Safety summary line: how many link checks passed out of all checks
  ///
  /// In en, this message translates to:
  /// **'{passed} of {total} checks passed'**
  String verdictChecksPassed(int passed, int total);

  /// Link in the safety summary card that scrolls to the full safety check list
  ///
  /// In en, this message translates to:
  /// **'See details'**
  String get verdictSeeDetails;

  /// Short label: link checks ran without contacting the site
  ///
  /// In en, this message translates to:
  /// **'Private mode'**
  String get verdictModePrivate;

  /// Short label: link checks contacted the site directly
  ///
  /// In en, this message translates to:
  /// **'Active probing'**
  String get verdictModeActive;

  /// Toggle that shows the folded list of passed safety checks
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Show 1 passed check} other{Show {count} passed checks}}'**
  String safetyShowPassed(int count);

  /// Toggle that folds the list of passed safety checks
  ///
  /// In en, this message translates to:
  /// **'Hide passed checks'**
  String get safetyHidePassed;

  /// One line that groups safety checks that did not run (no API key or service off)
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 check skipped} other{{count} checks skipped}}'**
  String safetySkippedGroup(int count);

  /// Button that opens Settings so the user can turn on skipped safety checks
  ///
  /// In en, this message translates to:
  /// **'Set up in Settings'**
  String get safetySkippedSetup;

  /// Confirm dialog text before opening a link that failed some safety checks
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{This link has 1 issue. Open it anyway?} other{This link has {count} issues. Open it anyway?}}'**
  String openRiskDialogIssues(int count);

  /// Tooltip to unfold the sandboxed page preview
  ///
  /// In en, this message translates to:
  /// **'Show preview'**
  String get sandboxShowPreview;

  /// Tooltip to fold the sandboxed page preview
  ///
  /// In en, this message translates to:
  /// **'Hide preview'**
  String get sandboxHidePreview;

  /// Folded Quishing Guard line when the printed code looks genuine; percent is the tamper risk
  ///
  /// In en, this message translates to:
  /// **'Genuine print · {percent}%'**
  String quishingCompactGenuine(String percent);

  /// Title of the floating Scan bubble feature (settings tile, screen title, menu item). Keep short.
  ///
  /// In en, this message translates to:
  /// **'Scan bubble'**
  String get scanBubbleTitle;

  /// Subtitle of the Scan bubble tile on the Settings screen
  ///
  /// In en, this message translates to:
  /// **'Scan codes shown in other apps'**
  String get scanBubbleSettingsSubtitle;

  /// Switch label that turns the floating Scan bubble on or off
  ///
  /// In en, this message translates to:
  /// **'Show scan bubble'**
  String get scanBubbleSwitchTitle;

  /// Explanation under the Scan bubble on/off switch
  ///
  /// In en, this message translates to:
  /// **'A small button that floats over other apps. Tap it to scan a code on the screen.'**
  String get scanBubbleSwitchSubtitle;

  /// Status shown when the Display over other apps permission is granted
  ///
  /// In en, this message translates to:
  /// **'Allowed'**
  String get scanBubblePermissionGranted;

  /// Status shown when the Display over other apps permission is not granted
  ///
  /// In en, this message translates to:
  /// **'Not allowed yet. Needed for the bubble.'**
  String get scanBubblePermissionMissing;

  /// Button that starts the Display over other apps permission flow
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get scanBubbleAllowButton;

  /// Switch label: show the bubble again after the phone restarts. Keep short.
  ///
  /// In en, this message translates to:
  /// **'Start after restart'**
  String get scanBubbleStartOnBootTitle;

  /// Explanation under the start after restart switch
  ///
  /// In en, this message translates to:
  /// **'If the bubble was on, show it again after the phone restarts. Some phones may block this.'**
  String get scanBubbleStartOnBootSubtitle;

  /// Button that asks Android to add the Scan bubble Quick Settings tile. Keep short.
  ///
  /// In en, this message translates to:
  /// **'Add to Quick Settings'**
  String get scanBubbleAddTileButton;

  /// Message after the request to add the Scan bubble tile was sent
  ///
  /// In en, this message translates to:
  /// **'Quick Settings tile request sent'**
  String get scanBubbleTileAdded;

  /// Message telling the user how to add the Scan bubble tile by hand
  ///
  /// In en, this message translates to:
  /// **'Pull down Quick Settings, tap the edit (pencil) button, and drag the Scan bubble tile in.'**
  String get scanBubbleTileManual;

  /// Title of the dialog that explains the Display over other apps permission
  ///
  /// In en, this message translates to:
  /// **'Allow the bubble'**
  String get scanBubblePermissionDialogTitle;

  /// Body of the dialog that explains the Display over other apps permission
  ///
  /// In en, this message translates to:
  /// **'To float over other apps, the bubble needs the \"Display over other apps\" permission. On the next page, turn it on for this app, then come back.'**
  String get scanBubblePermissionDialogBody;

  /// Button that opens the Android permission page
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get scanBubbleOpenSettings;

  /// Error shown when Android refuses to start the bubble
  ///
  /// In en, this message translates to:
  /// **'Could not start the bubble. Please try again.'**
  String get scanBubbleStartFailed;

  /// Message shown when the screen capture came back black because the app on screen blocks capture
  ///
  /// In en, this message translates to:
  /// **'This app blocks screen capture, so its codes cannot be read.'**
  String get scanBubbleBlockedCapture;

  /// Label on a history item that was read from a picture of the phone screen (GhostScan or Scan bubble)
  ///
  /// In en, this message translates to:
  /// **'From screen'**
  String get historySourceScreen;

  /// Name of the Android permission that lets the Scan bubble float over other apps
  ///
  /// In en, this message translates to:
  /// **'Display over other apps'**
  String get permissionOverlayTitle;

  /// Why the app uses the Display over other apps permission
  ///
  /// In en, this message translates to:
  /// **'Used only by the Scan bubble, and only after you turn it on. Lets the bubble float over other apps.'**
  String get permissionOverlayDesc;

  /// Name of the Android notification permission
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get permissionNotificationTitle;

  /// Why the app uses the notification permission
  ///
  /// In en, this message translates to:
  /// **'Shows \"Scan bubble is on\" with a Turn off button while the bubble is on.'**
  String get permissionNotificationDesc;

  /// Name of the Scan bubble help guide
  ///
  /// In en, this message translates to:
  /// **'Scan bubble'**
  String get helpGuideScanBubbleName;

  /// One-line summary of the Scan bubble help guide
  ///
  /// In en, this message translates to:
  /// **'A floating button to scan QR codes and barcodes shown in other apps.'**
  String get helpGuideScanBubbleSummary;

  /// Intro paragraph of the Scan bubble help guide
  ///
  /// In en, this message translates to:
  /// **'The Scan bubble is a small round button that floats over other apps. When a QR code or barcode is on your screen, tap the bubble and the app reads it, offline, on your phone.'**
  String get helpGuideScanBubbleIntro;

  /// Section title: how to use the Scan bubble
  ///
  /// In en, this message translates to:
  /// **'How to use it'**
  String get helpGuideScanBubbleUseTitle;

  /// How to turn the Scan bubble on
  ///
  /// In en, this message translates to:
  /// **'Turn it on in Settings > Scan bubble, from the Scan bubble tile in Quick Settings, or by long-pressing the app icon.'**
  String get helpGuideScanBubbleUseBullet1;

  /// Second step for using the Scan bubble
  ///
  /// In en, this message translates to:
  /// **'Open any app that shows a QR code or barcode, then tap the bubble.'**
  String get helpGuideScanBubbleUseBullet2;

  /// Third step for using the Scan bubble
  ///
  /// In en, this message translates to:
  /// **'Android asks to allow screen capture. Allow it, and the result opens with the usual safety checks.'**
  String get helpGuideScanBubbleUseBullet3;

  /// How to move and close the Scan bubble
  ///
  /// In en, this message translates to:
  /// **'Drag the bubble to move it. Drag it onto the X at the bottom of the screen to turn it off.'**
  String get helpGuideScanBubbleUseBullet4;

  /// Section title: privacy of the Scan bubble
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get helpGuideScanBubblePrivacyTitle;

  /// Privacy point: capture only on tap
  ///
  /// In en, this message translates to:
  /// **'The screen is captured only when you tap the bubble, and Android always asks you first.'**
  String get helpGuideScanBubblePrivacyBullet1;

  /// Privacy point: offline decoding
  ///
  /// In en, this message translates to:
  /// **'The code is read on your phone. Nothing is sent online for reading.'**
  String get helpGuideScanBubblePrivacyBullet2;

  /// Privacy point: picture deleted
  ///
  /// In en, this message translates to:
  /// **'The screen picture is not saved to your gallery and is deleted right after reading.'**
  String get helpGuideScanBubblePrivacyBullet3;

  /// Section title: limits of the Scan bubble
  ///
  /// In en, this message translates to:
  /// **'Good to know'**
  String get helpGuideScanBubbleLimitsTitle;

  /// Limit: Android 14 asks every time
  ///
  /// In en, this message translates to:
  /// **'On Android 14 and newer, Android asks for screen capture permission on every tap.'**
  String get helpGuideScanBubbleLimitsBullet1;

  /// Limit: some apps block capture
  ///
  /// In en, this message translates to:
  /// **'Banking, payment and some video apps block screen capture. Codes inside them cannot be read.'**
  String get helpGuideScanBubbleLimitsBullet2;

  /// Limit: phone maker settings
  ///
  /// In en, this message translates to:
  /// **'Some phones have extra \"pop-up window\" or battery settings that can hide or stop the bubble.'**
  String get helpGuideScanBubbleLimitsBullet3;

  /// Tip at the end of the Scan bubble help guide
  ///
  /// In en, this message translates to:
  /// **'Tip: Add the Scan bubble tile to Quick Settings. Then one tap turns the bubble on or off from any app.'**
  String get helpGuideScanBubbleTip;

  /// CodeForge: heading above the text box for 1D/2D barcode content.
  ///
  /// In en, this message translates to:
  /// **'Barcode content'**
  String get codeForgeBarcodeContent;

  /// CodeForge: hint text inside the barcode content text box.
  ///
  /// In en, this message translates to:
  /// **'Enter the barcode number or code'**
  String get codeForgeBarcodeContentHint;

  /// CodeForge Wi-Fi form: security option for an open network with no password.
  ///
  /// In en, this message translates to:
  /// **'None (open)'**
  String get codeForgeWifiSecurityNone;

  /// CodeForge UPI form: example hint for the UPI ID field. Keep 'merchant@upi' as an example ID.
  ///
  /// In en, this message translates to:
  /// **'e.g. merchant@upi'**
  String get codeForgeUpiVpaHint;

  /// Hint text inside a form field the user may leave empty.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optionalFieldHint;

  /// CodeForge validation error: the code has no content.
  ///
  /// In en, this message translates to:
  /// **'Content cannot be empty'**
  String get codeForgeContentEmpty;

  /// CodeForge validation error: text is over the length limit.
  ///
  /// In en, this message translates to:
  /// **'Text must not be longer than {max} characters'**
  String codeForgeTextTooLong(String max);

  /// CodeForge validation error: Wi-Fi network name is missing.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi network name (SSID) is required'**
  String get codeForgeWifiSsidRequired;

  /// CodeForge validation error: UPI ID (VPA) is missing.
  ///
  /// In en, this message translates to:
  /// **'UPI ID is required'**
  String get codeForgeUpiVpaRequired;

  /// CodeForge validation error: content does not fit the chosen barcode type. {detail} is a short technical reason from the barcode library, in English.
  ///
  /// In en, this message translates to:
  /// **'Not valid for this barcode type ({detail})'**
  String codeForgeBarcodeInvalid(String detail);

  /// Result screen: card title after an encrypted AirQR payload is decrypted.
  ///
  /// In en, this message translates to:
  /// **'AirQR payload unlocked'**
  String get airQrUnlockedTitle;

  /// Result screen: card title after an encrypted JSON container is decrypted.
  ///
  /// In en, this message translates to:
  /// **'JSON payload unlocked'**
  String get jsonEnvelopeUnlockedTitle;

  /// Result screen: card title after hidden StegoQR content is decrypted.
  ///
  /// In en, this message translates to:
  /// **'StegoQR payload unlocked'**
  String get stegoUnlockedTitle;

  /// Result screen: card title when a StegoQR code with hidden encrypted content is found.
  ///
  /// In en, this message translates to:
  /// **'StegoQR encrypted payload found'**
  String get stegoDetectedTitle;

  /// Decrypt sheet: button that shows the advanced Salt and IV fields. Keep Salt and IV as technical terms.
  ///
  /// In en, this message translates to:
  /// **'Advanced (Salt / IV)'**
  String get decryptShowAdvanced;

  /// Decrypt sheet: button that hides the advanced Salt and IV fields.
  ///
  /// In en, this message translates to:
  /// **'Hide advanced'**
  String get decryptHideAdvanced;

  /// Decrypt sheet: label of the optional Salt field (cryptography term).
  ///
  /// In en, this message translates to:
  /// **'Salt (Base64, optional)'**
  String get decryptSaltLabel;

  /// Decrypt sheet: label of the optional IV / nonce field (cryptography term).
  ///
  /// In en, this message translates to:
  /// **'IV / Nonce (Base64, optional)'**
  String get decryptIvLabel;

  /// History screen: number of scan records shown.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 scan record found} other{{count} scan records found}}'**
  String historyRecordCount(int count);

  /// AR CodeVision: number of codes the user has selected.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item selected} other{{count} items selected}}'**
  String arItemsSelected(int count);

  /// Settings: subtitle of the Appearance card. {themeMode} is the current theme name.
  ///
  /// In en, this message translates to:
  /// **'{themeMode} • Dynamic colors'**
  String settingsAppearanceSummary(String themeMode);

  /// URL safety providers: shown when the OpenPhish list has never been downloaded.
  ///
  /// In en, this message translates to:
  /// **'Feed not downloaded yet'**
  String get openPhishFeedNotDownloaded;

  /// Accent color settings: info box explaining Dynamic Color.
  ///
  /// In en, this message translates to:
  /// **'Dynamic Color builds a matching palette from your Android wallpaper (Android 12+). When it is off, the standard high-contrast security palette is used.'**
  String get accentDynamicColorInfo;

  /// Typography settings: sample line in the text-size preview. Product names stay as they are.
  ///
  /// In en, this message translates to:
  /// **'6-Layer URL Safety Check • 100% Offline QuishingGuard™ CV Engine'**
  String get typographySampleLine;

  /// Typography settings: heading above the text-size slider.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get typographyScaleTitle;

  /// Typography settings: info box explaining how text size works.
  ///
  /// In en, this message translates to:
  /// **'The app follows your Android accessibility text size, while keeping the scan frame and on-screen labels easy to read.'**
  String get typographyScaleInfo;

  /// Sandbox preview: page title when the page could not be loaded. {host} is the site address.
  ///
  /// In en, this message translates to:
  /// **'{host} (offline or network blocked)'**
  String domFetchFailedTitle(String host);

  /// Scanner: tooltip of the button that pauses scanning.
  ///
  /// In en, this message translates to:
  /// **'Pause scanning'**
  String get scanPauseTooltip;

  /// Scanner: tooltip of the button that resumes scanning.
  ///
  /// In en, this message translates to:
  /// **'Resume scanning'**
  String get scanResumeTooltip;

  /// AR CodeVision: switch label for Warehouse mode (price/batch info, select codes, Batch Copy).
  ///
  /// In en, this message translates to:
  /// **'Warehouse'**
  String get arModeWarehouse;

  /// AR CodeVision: switch label for Safety mode (link safety badge on each code).
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get arModeSafety;

  /// AR CodeVision: tooltip of the Warehouse mode switch.
  ///
  /// In en, this message translates to:
  /// **'Show item info and select codes'**
  String get arModeWarehouseTooltip;

  /// AR CodeVision: tooltip of the Safety mode switch.
  ///
  /// In en, this message translates to:
  /// **'Show a safety badge on each link'**
  String get arModeSafetyTooltip;

  /// Camera screens: shown when the camera fails to start.
  ///
  /// In en, this message translates to:
  /// **'Camera could not start'**
  String get cameraStartFailed;

  /// Camera screens: shown when the phone has no usable camera.
  ///
  /// In en, this message translates to:
  /// **'No camera found on this phone'**
  String get cameraNotFound;

  /// Camera screens: button that tries to start the camera again.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get cameraRetryButton;

  /// CodeForge link safety banner: text shown before the link has been checked.
  ///
  /// In en, this message translates to:
  /// **'Check this link before you share it'**
  String get codeForgeSafetyPrompt;

  /// CodeForge link safety banner: button that runs the link safety checks.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get codeForgeSafetyCheckButton;

  /// CodeForge link safety banner: shown when the safety checks found problems.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 problem found in this link} other{{count} problems found in this link}}'**
  String codeForgeSafetyProblems(int count);

  /// CodeForge link safety banner: button that runs the checks again after problems were found.
  ///
  /// In en, this message translates to:
  /// **'Check again'**
  String get codeForgeSafetyCheckAgain;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ml', 'sa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ml':
      return AppLocalizationsMl();
    case 'sa':
      return AppLocalizationsSa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
