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

  /// Label above the network name on the Wi-Fi action card
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi Network'**
  String get titleWifiCard;

  /// Tooltip on the button that reveals the Wi-Fi password
  ///
  /// In en, this message translates to:
  /// **'Show Password'**
  String get tooltipWifiShowPassword;

  /// Tooltip on the button that hides the Wi-Fi password
  ///
  /// In en, this message translates to:
  /// **'Hide Password'**
  String get tooltipWifiHidePassword;

  /// Tooltip on the button that copies the Wi-Fi password
  ///
  /// In en, this message translates to:
  /// **'Copy Password'**
  String get tooltipWifiCopyPassword;

  /// Button that opens the device Wi-Fi settings to connect
  ///
  /// In en, this message translates to:
  /// **'Connect to Wi-Fi'**
  String get actionWifiConnect;

  /// Message shown after the Wi-Fi password is copied
  ///
  /// In en, this message translates to:
  /// **'Password copied to clipboard'**
  String get bodyWifiPasswordCopied;

  /// Message shown when the app cannot open Wi-Fi settings directly
  ///
  /// In en, this message translates to:
  /// **'Password copied. Open Wi-Fi Settings on your device to connect.'**
  String get bodyWifiOpenSettings;

  /// Message shown when a Wi-Fi direct connection prompt or request is initiated
  ///
  /// In en, this message translates to:
  /// **'Connection requested for {ssid}'**
  String bodyWifiConnectSuccess(String ssid);

  /// Coordinates line on the location action card
  ///
  /// In en, this message translates to:
  /// **'Lat: {latitude}, Lng: {longitude}'**
  String bodyGeoLatLng(String latitude, String longitude);

  /// Search text carried by a scanned location code
  ///
  /// In en, this message translates to:
  /// **'Query: {query}'**
  String bodyGeoQuery(String query);

  /// Button that opens the scanned location in Google Maps
  ///
  /// In en, this message translates to:
  /// **'Open in Maps'**
  String get actionGeoNavigate;

  /// Message shown when Google Maps cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Could not launch Google Maps app'**
  String get errorGeoLaunchFailed;

  /// Label above the event name on the calendar action card
  ///
  /// In en, this message translates to:
  /// **'Calendar Event'**
  String get titleCalendarCard;

  /// Shown in place of a date when the scanned event has none
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get labelCalendarNoDate;

  /// Start date and time of a scanned calendar event
  ///
  /// In en, this message translates to:
  /// **'Start: {dateTime}'**
  String labelCalendarStart(String dateTime);

  /// End date and time of a scanned calendar event. The extra spaces line it up under the start line
  ///
  /// In en, this message translates to:
  /// **'End:   {dateTime}'**
  String labelCalendarEnd(String dateTime);

  /// Button that adds the scanned event to the device calendar
  ///
  /// In en, this message translates to:
  /// **'Add to calendar'**
  String get actionCalendarAdd;

  /// Message shown when the calendar app cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open Calendar app'**
  String get errorCalendarLaunchFailed;

  /// Label above the person's name on the contact action card
  ///
  /// In en, this message translates to:
  /// **'Contact Card'**
  String get titleContactCard;

  /// Single letter shown in the contact avatar when the scanned contact has no name
  ///
  /// In en, this message translates to:
  /// **'C'**
  String get labelContactInitialFallback;

  /// Button that saves the scanned contact to the device
  ///
  /// In en, this message translates to:
  /// **'Save to Contacts'**
  String get actionContactSave;

  /// Message shown when the contacts app cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open Contacts app'**
  String get errorContactLaunchFailed;

  /// Message shown when a phone call cannot be started
  ///
  /// In en, this message translates to:
  /// **'Could not place call to {number}'**
  String errorContactCallFailed(String number);

  /// Message shown when the email app cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open email app for {email}'**
  String errorContactEmailFailed(String email);

  /// Title of the sheet listing codes found in a PDF, with how many were found
  ///
  /// In en, this message translates to:
  /// **'PDF codes ({count})'**
  String titlePdfResults(int count);

  /// Short page badge on a PDF result row, for example P3
  ///
  /// In en, this message translates to:
  /// **'P{page}'**
  String labelPdfPageBadge(int page);

  /// Page number of a code found in a PDF
  ///
  /// In en, this message translates to:
  /// **'Page {page}'**
  String labelPdfPage(int page);

  /// Button that saves every code found in the PDF to history
  ///
  /// In en, this message translates to:
  /// **'Save all ({count})'**
  String actionPdfSaveAll(int count);

  /// Note stored with a history record for a code found in a PDF
  ///
  /// In en, this message translates to:
  /// **'Scanned from PDF (Page {page})'**
  String bodyPdfScanNote(int page);

  /// Message shown after saving all PDF codes to history
  ///
  /// In en, this message translates to:
  /// **'Saved {count} codes to history.'**
  String bodyPdfSavedToHistory(int count);

  /// Shown in place of the issuer name when a scanned 2FA code has none
  ///
  /// In en, this message translates to:
  /// **'2FA Authenticator'**
  String get labelTotpDefaultIssuer;

  /// Label above the rolling one-time passcode, with how many seconds each code lasts
  ///
  /// In en, this message translates to:
  /// **'Live Passcode ({period}s TOTP)'**
  String bodyTotpLivePasscode(int period);

  /// Seconds left before the current one-time passcode changes
  ///
  /// In en, this message translates to:
  /// **'{seconds}s'**
  String labelTotpSecondsLeft(int seconds);

  /// Tooltip on the button that copies the current one-time passcode
  ///
  /// In en, this message translates to:
  /// **'Copy Token'**
  String get tooltipTotpCopyToken;

  /// Label before the 2FA secret key. Keeps a trailing space
  ///
  /// In en, this message translates to:
  /// **'Secret: '**
  String get labelTotpSecret;

  /// Button that sends the scanned 2FA code to an authenticator app
  ///
  /// In en, this message translates to:
  /// **'Add to authenticator'**
  String get actionTotpImport;

  /// Message shown when no authenticator app could be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open Authenticator app'**
  String get errorTotpLaunchFailed;

  /// Message shown after the one-time passcode is copied
  ///
  /// In en, this message translates to:
  /// **'TOTP token copied to clipboard'**
  String get bodyTotpTokenCopied;

  /// Message shown after the 2FA secret key is copied
  ///
  /// In en, this message translates to:
  /// **'Secret key copied to clipboard'**
  String get bodyTotpSecretCopied;

  /// Title of the payment card for an Indian UPI code
  ///
  /// In en, this message translates to:
  /// **'UPI Payment'**
  String get labelPaymentSchemeUpi;

  /// Title of the payment card for a European SEPA transfer code
  ///
  /// In en, this message translates to:
  /// **'SEPA Transfer'**
  String get labelPaymentSchemeSepa;

  /// Title of the payment card for a cryptocurrency code
  ///
  /// In en, this message translates to:
  /// **'Crypto Payment'**
  String get labelPaymentSchemeCrypto;

  /// Shown in place of the payee name when the scanned code has none
  ///
  /// In en, this message translates to:
  /// **'Merchant / Payee'**
  String get labelPaymentPayeeFallback;

  /// Label before the payee address for a UPI code
  ///
  /// In en, this message translates to:
  /// **'VPA / UPI ID:'**
  String get labelPaymentAddressUpi;

  /// Label before the payee address for a SEPA transfer code
  ///
  /// In en, this message translates to:
  /// **'IBAN:'**
  String get labelPaymentAddressSepa;

  /// Label before the payee address for a cryptocurrency code
  ///
  /// In en, this message translates to:
  /// **'Wallet Address:'**
  String get labelPaymentAddressCrypto;

  /// Small button that copies the payee address
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get actionPaymentCopy;

  /// Message shown after a UPI id is copied
  ///
  /// In en, this message translates to:
  /// **'UPI ID copied to clipboard'**
  String get bodyPaymentUpiIdCopied;

  /// Message shown after a payment address is copied
  ///
  /// In en, this message translates to:
  /// **'Address copied to clipboard'**
  String get bodyPaymentAddressCopied;

  /// Transaction note carried by a scanned payment code
  ///
  /// In en, this message translates to:
  /// **'Note: {note}'**
  String bodyPaymentNote(String note);

  /// Button that opens a UPI payment app
  ///
  /// In en, this message translates to:
  /// **'Pay with UPI app'**
  String get actionPaymentPayUpi;

  /// Button that opens a payment app for a non-UPI code
  ///
  /// In en, this message translates to:
  /// **'Pay via App'**
  String get actionPaymentPay;

  /// Message shown when no UPI payment app could be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open UPI app. Make sure GPay, PhonePe, or Paytm is installed.'**
  String get errorPaymentUpiLaunchFailed;

  /// Message shown when no payment app could be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open payment app for this scheme.'**
  String get errorPaymentLaunchFailed;

  /// Action on the failure message that copies the payee address instead
  ///
  /// In en, this message translates to:
  /// **'Copy ID'**
  String get actionPaymentCopyId;

  /// Title of the dialog that asks for an amount when a UPI code has none
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get titlePaymentAmountDialog;

  /// Explains why the amount dialog is shown; payee is the merchant or person being paid
  ///
  /// In en, this message translates to:
  /// **'This QR has no amount. Enter the amount to pay to {payee}.'**
  String bodyPaymentAmountDialog(String payee);

  /// Label of the amount input field in the UPI amount dialog
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get labelPaymentAmountField;

  /// Error under the amount field when the amount is below 1 rupee or badly formatted
  ///
  /// In en, this message translates to:
  /// **'Enter ₹1 or more'**
  String get errorPaymentAmountInvalid;

  /// Button in the UPI amount dialog that opens the UPI app with the entered amount
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get actionPaymentAmountPay;

  /// Name of the feature that reminds the user to check a printed QR code for a fake sticker
  ///
  /// In en, this message translates to:
  /// **'QuishingGuard™'**
  String get titleQuishingGuard;

  /// QuishingGuard card on the result screen: subtitle line. Short label (fake QR sticker check reminder)
  ///
  /// In en, this message translates to:
  /// **'Fake sticker check'**
  String get titleStickerCheck;

  /// QuishingGuard card: tooltip of the button that opens the list of hand checks
  ///
  /// In en, this message translates to:
  /// **'Show checks'**
  String get tooltipStickerCheckExpand;

  /// QuishingGuard card: tooltip of the button that closes the list of hand checks
  ///
  /// In en, this message translates to:
  /// **'Hide checks'**
  String get tooltipStickerCheckCollapse;

  /// QuishingGuard card: explains the sticker scam and that the app cannot see stickers, so the user checks by hand
  ///
  /// In en, this message translates to:
  /// **'Scammers stick their own QR code over the real one. This app cannot spot a sticker in the camera picture, so please check it yourself:'**
  String get bodyStickerCheckIntro;

  /// QuishingGuard card: hand check 1, look at and feel the code for raised sticker edges
  ///
  /// In en, this message translates to:
  /// **'Look at the code and feel it with your finger. A sticker on top often has raised edges or sits crooked.'**
  String get bodyStickerCheckEdges;

  /// QuishingGuard card: hand check 2, check the payee name before paying
  ///
  /// In en, this message translates to:
  /// **'Before you pay, check that the name on the payment screen matches the shop.'**
  String get bodyStickerCheckPayee;

  /// QuishingGuard card: hand check 3, ask staff or type the address yourself
  ///
  /// In en, this message translates to:
  /// **'If in doubt, ask the staff, or type the website address yourself.'**
  String get bodyStickerCheckAsk;

  /// Tooltip on the button that closes the AR detail sheet
  ///
  /// In en, this message translates to:
  /// **'Close Sheet'**
  String get tooltipArCloseSheet;

  /// Price read from a scanned item label in warehouse mode
  ///
  /// In en, this message translates to:
  /// **'Item Price Tag: {price}'**
  String bodyArItemPriceTag(String price);

  /// Message shown after the AR target content is copied
  ///
  /// In en, this message translates to:
  /// **'Copied content to clipboard'**
  String get bodyArContentCopied;

  /// Button that copies the AR target content
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get actionArCopy;

  /// Button that opens the link held by the AR target
  ///
  /// In en, this message translates to:
  /// **'Open URL'**
  String get actionArOpenUrl;

  /// Button that marks an AR target as selected
  ///
  /// In en, this message translates to:
  /// **'Select Item'**
  String get actionArSelect;

  /// Button that clears the selection on an AR target
  ///
  /// In en, this message translates to:
  /// **'Deselect'**
  String get actionArDeselect;

  /// Shown when the AR target link passed the safety checks
  ///
  /// In en, this message translates to:
  /// **'Safety Status: Verified Safe'**
  String get bodyArSafetyStatusSafe;

  /// Shown when the AR target link may be a phishing attempt
  ///
  /// In en, this message translates to:
  /// **'Safety Status: Warning / Phishing Suspicion'**
  String get bodyArSafetyStatusWarning;

  /// Shown while the AR target link is still being checked
  ///
  /// In en, this message translates to:
  /// **'Safety Status: Analyzing link safety...'**
  String get bodyArSafetyStatusUnknown;

  /// Message shown after content is copied, used on several screens
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get bodyCopiedToClipboard;

  /// Date and time of a saved scan, joined by a dot
  ///
  /// In en, this message translates to:
  /// **'{date} • {time}'**
  String bodyHistoryTimestamp(String date, String time);

  /// Tooltip on the button that marks a saved scan as a favourite
  ///
  /// In en, this message translates to:
  /// **'Star favorite'**
  String get tooltipHistoryStar;

  /// Tooltip on the button that removes a saved scan from favourites
  ///
  /// In en, this message translates to:
  /// **'Unstar'**
  String get tooltipHistoryUnstar;

  /// Menu item that opens the notes editor for a saved scan
  ///
  /// In en, this message translates to:
  /// **'Edit Notes'**
  String get actionHistoryEditNotes;

  /// Menu item that copies the saved scan content
  ///
  /// In en, this message translates to:
  /// **'Copy String'**
  String get tooltipHistoryCopyString;

  /// Button and menu item that shares the saved scan content
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get actionHistoryShare;

  /// Menu item that deletes a saved scan
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionHistoryDelete;

  /// Title of the sheet showing one saved scan in full
  ///
  /// In en, this message translates to:
  /// **'Scan Record Details'**
  String get titleHistoryDetail;

  /// Safety score badge on a saved scan
  ///
  /// In en, this message translates to:
  /// **'🛡️ {score}% Safe'**
  String labelHistorySafetyBadge(int score);

  /// Short safety score badge on a history card
  ///
  /// In en, this message translates to:
  /// **'🛡️ {score}%'**
  String labelHistoryScoreBadge(int score);

  /// Label above the raw content of a saved scan
  ///
  /// In en, this message translates to:
  /// **'Scanned Content:'**
  String get labelHistoryScannedContent;

  /// Button that copies the saved scan content
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get actionHistoryCopy;

  /// Label of the field where the user writes their own note
  ///
  /// In en, this message translates to:
  /// **'Custom User Notes'**
  String get labelHistoryNotes;

  /// Hint inside the empty notes field
  ///
  /// In en, this message translates to:
  /// **'Add personal notes or remarks about this scan...'**
  String get helpHistoryNotes;

  /// Label of the field where the user names the place of the scan
  ///
  /// In en, this message translates to:
  /// **'Location (optional)'**
  String get labelHistoryLocation;

  /// Hint inside the empty location field
  ///
  /// In en, this message translates to:
  /// **'e.g. Office Desk, Grocery Store, Conference'**
  String get helpHistoryLocation;

  /// Button that saves the edited note and location
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get actionHistorySaveChanges;

  /// Button that closes a dialog, used on several screens
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get actionClose;

  /// Title of the dialog when it is exporting scan history
  ///
  /// In en, this message translates to:
  /// **'Export & backup'**
  String get titleExportDialog;

  /// Title of the dialog when it is restoring a backup
  ///
  /// In en, this message translates to:
  /// **'Restore backup'**
  String get titleRestoreDialog;

  /// Button that switches the dialog to export mode
  ///
  /// In en, this message translates to:
  /// **'Export Records'**
  String get tabExportRecords;

  /// Button that switches the dialog to restore mode
  ///
  /// In en, this message translates to:
  /// **'Restore Backup'**
  String get tabRestoreBackup;

  /// Heading above the list of export file formats
  ///
  /// In en, this message translates to:
  /// **'Export format:'**
  String get titleExportFormat;

  /// Name of the CSV export option
  ///
  /// In en, this message translates to:
  /// **'CSV Format (.csv)'**
  String get labelExportCsv;

  /// Short explanation of the CSV export option
  ///
  /// In en, this message translates to:
  /// **'Compatible with Excel and Sheets'**
  String get descExportCsv;

  /// Name of the JSON export option
  ///
  /// In en, this message translates to:
  /// **'JSON Dataset (.json)'**
  String get labelExportJson;

  /// Short explanation of the JSON export option
  ///
  /// In en, this message translates to:
  /// **'Structured developer format'**
  String get descExportJson;

  /// Name of the plain text export option
  ///
  /// In en, this message translates to:
  /// **'Text report (.txt)'**
  String get labelExportTxt;

  /// Short explanation of the plain text export option
  ///
  /// In en, this message translates to:
  /// **'Human readable summary document'**
  String get descExportTxt;

  /// Name of the PDF export option
  ///
  /// In en, this message translates to:
  /// **'PDF report (.pdf)'**
  String get labelExportPdf;

  /// Short explanation of the PDF export option
  ///
  /// In en, this message translates to:
  /// **'Formatted printable report table'**
  String get descExportPdf;

  /// Heading above the encrypted backup controls
  ///
  /// In en, this message translates to:
  /// **'Encrypted backup'**
  String get titleExportBackup;

  /// Label of the field for the backup password
  ///
  /// In en, this message translates to:
  /// **'Backup passphrase'**
  String get labelExportPassphrase;

  /// Hint inside the empty backup password field
  ///
  /// In en, this message translates to:
  /// **'Enter secret passphrase...'**
  String get helpExportPassphrase;

  /// Message shown when the user tries to back up without a password
  ///
  /// In en, this message translates to:
  /// **'Please enter a password to encrypt your backup file.'**
  String get errorExportPassphraseRequired;

  /// Button that builds and shares the encrypted backup file
  ///
  /// In en, this message translates to:
  /// **'Create backup'**
  String get actionExportCreateBackup;

  /// Message attached when sharing an exported history file
  ///
  /// In en, this message translates to:
  /// **'SreerajP QR Studio Scan History Export'**
  String get bodyExportShare;

  /// Message attached when sharing the PDF history report
  ///
  /// In en, this message translates to:
  /// **'SreerajP QR Studio Scan History Report (PDF)'**
  String get bodyExportSharePdf;

  /// Message attached when sharing the encrypted backup file
  ///
  /// In en, this message translates to:
  /// **'SreerajP QR Studio Encrypted Backup File'**
  String get bodyExportShareBackup;

  /// Heading above the restore controls
  ///
  /// In en, this message translates to:
  /// **'Restore from backup:'**
  String get titleRestore;

  /// Label of the field for the password that unlocks a backup
  ///
  /// In en, this message translates to:
  /// **'Backup passphrase'**
  String get labelRestorePassphrase;

  /// Label of the field holding the backup file content
  ///
  /// In en, this message translates to:
  /// **'Backup data'**
  String get labelRestorePayload;

  /// Hint inside the empty backup content field
  ///
  /// In en, this message translates to:
  /// **'Paste backup JSON payload string here...'**
  String get helpRestorePayload;

  /// Message shown when a restore is tried with a missing field
  ///
  /// In en, this message translates to:
  /// **'Please provide both the password and backup content.'**
  String get errorRestoreFieldsRequired;

  /// Button that unlocks a backup and restores the scans in it
  ///
  /// In en, this message translates to:
  /// **'Restore history'**
  String get actionRestore;

  /// Message shown after a backup is restored
  ///
  /// In en, this message translates to:
  /// **'Successfully restored {count} scan records!'**
  String bodyRestoreSuccess(int count);

  /// Message shown when a backup could not be restored
  ///
  /// In en, this message translates to:
  /// **'Restore failed: {reason}'**
  String errorRestoreFailed(String reason);

  /// Badge saying the page preview ran with scripts blocked
  ///
  /// In en, this message translates to:
  /// **'SANDBOXED'**
  String get labelDomSandboxedBadge;

  /// Single letter shown in the site avatar when the page has no title
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get labelDomTitleInitialFallback;

  /// Shown in place of the page title when the page has none
  ///
  /// In en, this message translates to:
  /// **'Untitled Web Page'**
  String get labelDomUntitledPage;

  /// Caption under the safe preview image of a scanned web page
  ///
  /// In en, this message translates to:
  /// **'Visual Thumbnail Pre-Render (Script Execution Blocked)'**
  String get bodyDomThumbnailCaption;

  /// Badge counting the scripts and trackers the preview blocked
  ///
  /// In en, this message translates to:
  /// **'Blocked: {scripts} Scripts, {trackers} Trackers'**
  String bodyDomBlockedBadge(int scripts, int trackers);

  /// Badge warning that the site domain was registered very recently
  ///
  /// In en, this message translates to:
  /// **'Newly Registered ({days}d)'**
  String bodyDomNewlyRegistered(int days);

  /// Badge showing how old the site domain is
  ///
  /// In en, this message translates to:
  /// **'Domain Age: {days} days'**
  String bodyDomDomainAge(int days);

  /// Badge warning that the link forwards to another site
  ///
  /// In en, this message translates to:
  /// **'Open Redirect Trap!'**
  String get bodyDomOpenRedirectFound;

  /// Badge saying the link does not forward to another site
  ///
  /// In en, this message translates to:
  /// **'No Open Redirects'**
  String get bodyDomNoOpenRedirect;

  /// Button that opens the detailed page structure sheet
  ///
  /// In en, this message translates to:
  /// **'Inspect page'**
  String get actionDomInspect;

  /// Title of the detailed page structure sheet
  ///
  /// In en, this message translates to:
  /// **'Page structure'**
  String get titleDomInspect;

  /// Row label for the page title
  ///
  /// In en, this message translates to:
  /// **'Page Title'**
  String get labelDomDetailPageTitle;

  /// Shown when the page did not give a title
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get labelDomDetailNotSpecified;

  /// Row label for the page description
  ///
  /// In en, this message translates to:
  /// **'Meta Description'**
  String get labelDomDetailMetaDescription;

  /// Shown when the page did not give a description
  ///
  /// In en, this message translates to:
  /// **'None found'**
  String get labelDomDetailNoneFound;

  /// Row label for how many headings the page had
  ///
  /// In en, this message translates to:
  /// **'Headings Count'**
  String get labelDomDetailHeadingsCount;

  /// How many headings were read from the page
  ///
  /// In en, this message translates to:
  /// **'{count} headings extracted'**
  String bodyDomDetailHeadingsValue(int count);

  /// Row label for how many links the page had
  ///
  /// In en, this message translates to:
  /// **'Links Found'**
  String get labelDomDetailLinksFound;

  /// How many links were read from the page
  ///
  /// In en, this message translates to:
  /// **'{count} URLs extracted'**
  String bodyDomDetailLinksValue(int count);

  /// Row label for blocked scripts
  ///
  /// In en, this message translates to:
  /// **'Blocked Scripts'**
  String get labelDomDetailBlockedScripts;

  /// How many scripts were removed before the preview
  ///
  /// In en, this message translates to:
  /// **'{count} executable script tags/events stripped'**
  String bodyDomDetailBlockedScriptsValue(int count);

  /// Row label for blocked trackers
  ///
  /// In en, this message translates to:
  /// **'Blocked Trackers'**
  String get labelDomDetailBlockedTrackers;

  /// How many trackers were removed before the preview
  ///
  /// In en, this message translates to:
  /// **'{count} tracking pixels stripped'**
  String bodyDomDetailBlockedTrackersValue(int count);

  /// Row label for blocked embedded frames
  ///
  /// In en, this message translates to:
  /// **'Blocked Iframes'**
  String get labelDomDetailBlockedIframes;

  /// How many embedded frames were removed before the preview
  ///
  /// In en, this message translates to:
  /// **'{count} iframe/embed elements removed'**
  String bodyDomDetailBlockedIframesValue(int count);

  /// Heading above the cleaned page source snippet
  ///
  /// In en, this message translates to:
  /// **'Clean HTML preview:'**
  String get titleDomSanitizedSnippet;

  /// Title of the About screen
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get titleAbout;

  /// App version and build number on the About screen
  ///
  /// In en, this message translates to:
  /// **'Version {version}+{build}'**
  String bodyAboutVersion(String version, String build);

  /// Label for the application build date on the About screen
  ///
  /// In en, this message translates to:
  /// **'Build Date'**
  String get labelAboutBuildDate;

  /// Title of the About screen card that opens the list of open-source licences used by the app (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Open-source licences'**
  String get labelAboutOpenSourceLicenses;

  /// Subtitle of the open-source licences card on the About screen. 'zxing-cpp' and 'Apache-2.0' are names and must not be translated.
  ///
  /// In en, this message translates to:
  /// **'Includes zxing-cpp (Apache-2.0) as the barcode decoder. Tap to view all licences.'**
  String get descAboutOpenSourceLicenses;

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

  /// Title of the screen that sends data as a stream of codes
  ///
  /// In en, this message translates to:
  /// **'AirQR transmitter'**
  String get titleAirQrTransmitter;

  /// Sample text that fills the payload box when the transmitter screen opens
  ///
  /// In en, this message translates to:
  /// **'AirQR High-Speed Optical Air-Gap Transfer Test Payload. This payload is split into small chunks with Fountain FEC error correction.'**
  String get bodyAirQrSamplePayload;

  /// Label of the box holding the data to send
  ///
  /// In en, this message translates to:
  /// **'Data to send'**
  String get labelAirQrPayload;

  /// Hint inside the empty payload box
  ///
  /// In en, this message translates to:
  /// **'Enter text, contact, or file payload...'**
  String get helpAirQrPayload;

  /// Label before the slider that sets how fast codes are shown
  ///
  /// In en, this message translates to:
  /// **'Stream Speed:'**
  String get labelAirQrStreamSpeed;

  /// How many code frames are shown per second
  ///
  /// In en, this message translates to:
  /// **'{fps} FPS'**
  String labelAirQrFps(int fps);

  /// Button that starts showing the stream of codes
  ///
  /// In en, this message translates to:
  /// **'Start stream'**
  String get actionAirQrStartStream;

  /// Button that stops showing the stream of codes
  ///
  /// In en, this message translates to:
  /// **'Stop stream'**
  String get actionAirQrStopStream;

  /// Caption under a repair frame of the stream
  ///
  /// In en, this message translates to:
  /// **'Frame {current}/{total} [Fountain PARITY]'**
  String bodyAirQrFrameParity(int current, int total);

  /// Caption under a data frame of the stream
  ///
  /// In en, this message translates to:
  /// **'Frame {current}/{total} [Block {block}]'**
  String bodyAirQrFrameBlock(int current, int total, int block);

  /// Summary of how many frames the stream holds
  ///
  /// In en, this message translates to:
  /// **'Total Stream Frames: {total} ({source} Source + {parity} Fountain FEC)'**
  String bodyAirQrTotalFrames(int total, int source, int parity);

  /// Tooltip on the button that turns the camera light on or off
  ///
  /// In en, this message translates to:
  /// **'Toggle Flashlight'**
  String get tooltipToggleFlashlight;

  /// Button that asks the system for camera permission again
  ///
  /// In en, this message translates to:
  /// **'Allow camera'**
  String get actionGrantCameraPermission;

  /// Title of the screen that marks up live camera view with found codes
  ///
  /// In en, this message translates to:
  /// **'AR CodeVision HUD'**
  String get titleArScreen;

  /// Shown while the live camera view is starting
  ///
  /// In en, this message translates to:
  /// **'Initializing AR HUD Viewport...'**
  String get bodyArInitializing;

  /// Button that unselects every marked code
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get actionArClearSelection;

  /// Button that copies every selected code at once
  ///
  /// In en, this message translates to:
  /// **'Batch Copy'**
  String get actionArBatchCopy;

  /// Message shown after copying several codes at once
  ///
  /// In en, this message translates to:
  /// **'Copied {count} barcodes to clipboard'**
  String bodyArBatchCopied(int count);

  /// Shown when camera permission is missing on the AR screen
  ///
  /// In en, this message translates to:
  /// **'Camera permission is required for AR CodeVision'**
  String get bodyArCameraPermission;

  /// Button that closes a finished step, used on several screens
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get actionDone;

  /// Title of the screen that reads a stream of codes
  ///
  /// In en, this message translates to:
  /// **'AirQR receiver'**
  String get titleAirQrReceiver;

  /// Tooltip on the button that starts the capture again
  ///
  /// In en, this message translates to:
  /// **'Reset Stream'**
  String get tooltipAirQrResetStream;

  /// Shown while the stream reader is starting
  ///
  /// In en, this message translates to:
  /// **'Initializing AirQR Stream Receiver...'**
  String get bodyAirQrInitializing;

  /// Status shown when every part of the stream has been received
  ///
  /// In en, this message translates to:
  /// **'STREAM REASSEMBLED'**
  String get bodyAirQrStatusReassembled;

  /// Status shown while parts of the stream are being read
  ///
  /// In en, this message translates to:
  /// **'CAPTURING OPTICAL STREAM...'**
  String get bodyAirQrStatusCapturing;

  /// Status telling the user to aim the camera at the sending screen
  ///
  /// In en, this message translates to:
  /// **'POINT AT ANIMATED QR STREAM'**
  String get bodyAirQrStatusIdle;

  /// How many parts of the stream have been read so far
  ///
  /// In en, this message translates to:
  /// **'Captured: {received} / {total} Blocks'**
  String bodyAirQrCaptured(int received, int total);

  /// How many parts of the stream are still missing
  ///
  /// In en, this message translates to:
  /// **'Missing: {count}'**
  String bodyAirQrMissing(int count);

  /// Title of the panel shown when the whole stream has been received
  ///
  /// In en, this message translates to:
  /// **'Transfer complete!'**
  String get titleAirQrTransferComplete;

  /// Explanation under the transfer complete title
  ///
  /// In en, this message translates to:
  /// **'Payload reassembled and verified offline via Fountain error correction.'**
  String get bodyAirQrTransferComplete;

  /// Message shown after the received data is copied
  ///
  /// In en, this message translates to:
  /// **'Copied payload to clipboard'**
  String get bodyAirQrPayloadCopied;

  /// Button that closes a dialog without acting, used on several screens
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// Title of the saved scans screen
  ///
  /// In en, this message translates to:
  /// **'Scan History'**
  String get titleHistoryScreen;

  /// Tooltip on the button that opens the export and backup dialog
  ///
  /// In en, this message translates to:
  /// **'Export / Backup'**
  String get tooltipHistoryExport;

  /// Button and tooltip for deleting every saved scan
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get actionHistoryClearAll;

  /// Title of the dialog asking to confirm deleting all saved scans
  ///
  /// In en, this message translates to:
  /// **'Clear Scan History?'**
  String get titleHistoryClear;

  /// Warning shown before all saved scans are deleted
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all persistent scan history? This action cannot be undone unless you have created a backup.'**
  String get bodyHistoryClear;

  /// Hint inside the empty search box on the saved scans screen
  ///
  /// In en, this message translates to:
  /// **'Search history (content, format, notes)...'**
  String get helpHistorySearch;

  /// Filter chip showing every saved scan
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get labelHistoryFilterAll;

  /// Filter chip showing only favourite scans
  ///
  /// In en, this message translates to:
  /// **'Starred'**
  String get labelHistoryFilterStarred;

  /// Filter chip showing only saved links
  ///
  /// In en, this message translates to:
  /// **'URLs'**
  String get labelHistoryFilterUrls;

  /// Filter chip showing only saved Wi-Fi codes
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi'**
  String get labelHistoryFilterWifi;

  /// Filter chip showing only saved contact cards
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get labelHistoryFilterContacts;

  /// Filter chip showing only saved plain text scans
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get labelHistoryFilterText;

  /// Filter chip showing only saved product barcodes
  ///
  /// In en, this message translates to:
  /// **'Barcodes'**
  String get labelHistoryFilterBarcodes;

  /// Title shown when the saved scans list is empty
  ///
  /// In en, this message translates to:
  /// **'No Scan Records Found'**
  String get emptyHistoryTitle;

  /// Explanation shown when no scans have been saved yet
  ///
  /// In en, this message translates to:
  /// **'Scanned barcodes will automatically appear here.'**
  String get emptyHistoryMessage;

  /// Shown when a search over saved scans finds nothing
  ///
  /// In en, this message translates to:
  /// **'No matches for \"{query}\"'**
  String emptyHistoryNoMatches(String query);

  /// Tooltip on the button that opens the overflow menu
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get tooltipMoreOptions;

  /// Menu item that opens the saved scans screen
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get actionMenuHistory;

  /// Menu item that opens the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get actionMenuSettings;

  /// Button that asks the system for a permission again
  ///
  /// In en, this message translates to:
  /// **'Grant Permission'**
  String get actionGrantPermission;

  /// Tooltip on the button that reads a code from a saved picture
  ///
  /// In en, this message translates to:
  /// **'Scan from gallery'**
  String get tooltipScanFromGallery;

  /// Tooltip on the button that reads codes from a PDF file
  ///
  /// In en, this message translates to:
  /// **'Scan PDF Document'**
  String get tooltipScanPdfDocument;

  /// Shown while the pages of a chosen PDF are being read
  ///
  /// In en, this message translates to:
  /// **'Extracting & scanning PDF pages...'**
  String get bodyScanPdfProgress;

  /// Shown while a PDF shared from another app is being read
  ///
  /// In en, this message translates to:
  /// **'Scanning shared PDF document...'**
  String get bodyScanSharedPdfProgress;

  /// Shown while the camera is starting
  ///
  /// In en, this message translates to:
  /// **'Initializing camera...'**
  String get bodyScanInitializingCamera;

  /// Shown while the live camera picture is starting
  ///
  /// In en, this message translates to:
  /// **'Initializing camera feed...'**
  String get bodyScanInitializingFeed;

  /// Tooltip on the button that shows the zoom slider
  ///
  /// In en, this message translates to:
  /// **'Zoom slider'**
  String get tooltipScanZoom;

  /// Tooltip on the button that switches between front and back cameras
  ///
  /// In en, this message translates to:
  /// **'Switch camera'**
  String get tooltipScanFlipCamera;

  /// A zoom level, for example 2.5x
  ///
  /// In en, this message translates to:
  /// **'{value}x'**
  String labelScanZoomValue(String value);

  /// Instruction shown over the camera picture
  ///
  /// In en, this message translates to:
  /// **'Position QR code or barcode within the frame'**
  String get helpScanViewfinder;

  /// Shown when camera permission is missing on the scanner screen
  ///
  /// In en, this message translates to:
  /// **'Camera permission required'**
  String get bodyScanCameraPermissionRequired;

  /// Short confirmation shown on a button right after copying
  ///
  /// In en, this message translates to:
  /// **'Copied!'**
  String get labelCopied;

  /// Tooltip on a button that hides secret text
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get actionHide;

  /// Tooltip on a button that shows secret text
  ///
  /// In en, this message translates to:
  /// **'Reveal'**
  String get actionReveal;

  /// Button that opens a link despite a safety warning
  ///
  /// In en, this message translates to:
  /// **'Open Anyway'**
  String get actionOpenAnyway;

  /// Title of the screen showing what was scanned
  ///
  /// In en, this message translates to:
  /// **'Scan Result'**
  String get titleResultScreen;

  /// Shown when the screen opens with nothing scanned
  ///
  /// In en, this message translates to:
  /// **'No result'**
  String get bodyResultNoResult;

  /// Label above the scanned content
  ///
  /// In en, this message translates to:
  /// **'Content:'**
  String get labelResultContent;

  /// Label above the visible content of a code that also hides a secret
  ///
  /// In en, this message translates to:
  /// **'Decoy content:'**
  String get labelResultDecoyContent;

  /// Label above the kind of code that was scanned
  ///
  /// In en, this message translates to:
  /// **'Detected Type:'**
  String get labelResultDetectedType;

  /// Type name for a code that carries a hidden encrypted layer
  ///
  /// In en, this message translates to:
  /// **'StegoQR (encrypted)'**
  String get labelResultTypeStego;

  /// Button that runs the link safety checks again
  ///
  /// In en, this message translates to:
  /// **'Re-check'**
  String get actionResultRecheck;

  /// Button that opens the scanned link in a browser
  ///
  /// In en, this message translates to:
  /// **'Open in Browser'**
  String get actionResultOpenInBrowser;

  /// Button that copies the scanned content
  ///
  /// In en, this message translates to:
  /// **'Copy Text'**
  String get actionResultCopyText;

  /// Button that copies the visible content of a code hiding a secret
  ///
  /// In en, this message translates to:
  /// **'Copy Decoy Text'**
  String get actionResultCopyDecoyText;

  /// Button that shares the scanned content
  ///
  /// In en, this message translates to:
  /// **'Share Text'**
  String get actionResultShareText;

  /// Button that shares the visible content of a code hiding a secret
  ///
  /// In en, this message translates to:
  /// **'Share Decoy Text'**
  String get actionResultShareDecoyText;

  /// Button that returns to the camera to scan again
  ///
  /// In en, this message translates to:
  /// **'Scan Another Code'**
  String get actionResultScanAnother;

  /// Message shown when a link could not be opened
  ///
  /// In en, this message translates to:
  /// **'Could not launch URL'**
  String get errorResultLaunchFailed;

  /// Shown after the hidden secret layer has been unlocked
  ///
  /// In en, this message translates to:
  /// **'The hidden AES-256 encrypted payload has been decrypted successfully.'**
  String get bodyStegoUnlocked;

  /// Shown when a code hides a secret that is still locked
  ///
  /// In en, this message translates to:
  /// **'This QR code contains a hidden, encrypted secret layer. Authenticate to view the hidden payload.'**
  String get bodyStegoLocked;

  /// Button that unlocks the secret using fingerprint or face
  ///
  /// In en, this message translates to:
  /// **'Biometric Unlock'**
  String get actionStegoBiometricUnlock;

  /// Button and field label for the secret password
  ///
  /// In en, this message translates to:
  /// **'Passphrase'**
  String get labelStegoPassphrase;

  /// Label above the unlocked secret content
  ///
  /// In en, this message translates to:
  /// **'Secret Payload:'**
  String get labelStegoSecretPayload;

  /// Button that copies the unlocked secret
  ///
  /// In en, this message translates to:
  /// **'Copy Secret'**
  String get actionStegoCopySecret;

  /// Button that shares the unlocked secret
  ///
  /// In en, this message translates to:
  /// **'Share Secret'**
  String get actionStegoShareSecret;

  /// Message shown after the secret is copied
  ///
  /// In en, this message translates to:
  /// **'Secret copied to clipboard'**
  String get bodyStegoSecretCopied;

  /// Title of the unlock dialog when fingerprint or face is also used
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock'**
  String get titleStegoDialogBiometric;

  /// Title of the unlock dialog when only the password is used
  ///
  /// In en, this message translates to:
  /// **'Enter Passphrase'**
  String get titleStegoDialogPassphrase;

  /// Explanation in the unlock dialog when fingerprint or face is also used
  ///
  /// In en, this message translates to:
  /// **'Confirm passphrase to authenticate with biometrics and decrypt payload.'**
  String get bodyStegoDialogBiometric;

  /// Explanation in the unlock dialog when only the password is used
  ///
  /// In en, this message translates to:
  /// **'Enter the passphrase used to encrypt the secret payload.'**
  String get bodyStegoDialogPassphrase;

  /// Button that confirms the unlock dialog
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get actionStegoUnlock;

  /// Title shown while the link safety checks are running
  ///
  /// In en, this message translates to:
  /// **'Checking security'**
  String get titleSafetyCheckInProgress;

  /// Title of the link safety result panel
  ///
  /// In en, this message translates to:
  /// **'Link security'**
  String get titleSafetyAnalysis;

  /// Shown under the panel while the checks run
  ///
  /// In en, this message translates to:
  /// **'Analyzing URL security...'**
  String get bodySafetyAnalyzing;

  /// How many safety checks failed
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 security issue detected} other{{count} security issues detected}}'**
  String bodySafetyIssuesDetected(int count);

  /// Shown when every safety check passed
  ///
  /// In en, this message translates to:
  /// **'No issues detected'**
  String get bodySafetyNoIssues;

  /// Advice shown when the link passed the checks but still needs care
  ///
  /// In en, this message translates to:
  /// **'Only open this URL if you trust the source'**
  String get helpSafetyTrustSource;

  /// Heading above the list of individual safety checks
  ///
  /// In en, this message translates to:
  /// **'Check results:'**
  String get titleSafetyResults;

  /// Banner shown when the app contacted the scanned site directly
  ///
  /// In en, this message translates to:
  /// **'Active online checks are ON: SSL, redirect and shortener checks contacted this site directly, exposing your IP address to it. Turn off \"Active online checks\" in Settings to check links privately.'**
  String get bodyProbingBannerActive;

  /// Banner shown when the app checked the link without contacting the site
  ///
  /// In en, this message translates to:
  /// **'Private mode: the site itself was never contacted, so it did not see your IP address or device. Only local rules and the safety services you turned on were used. Turn on \"Active online checks\" in Settings for live SSL and redirect checks.'**
  String get bodyProbingBannerPrivate;

  /// Title of the dialog shown before opening a risky link
  ///
  /// In en, this message translates to:
  /// **'Security Warning'**
  String get titleWarningDialog;

  /// Warning shown before opening a link that failed the checks
  ///
  /// In en, this message translates to:
  /// **'This URL has security issues. Opening it may put your device or data at risk.\n\nAre you sure you want to proceed?'**
  String get bodyWarningDialog;

  /// Title of the dialog shown before opening any scanned link
  ///
  /// In en, this message translates to:
  /// **'Caution'**
  String get titleCautionDialog;

  /// Advice shown before opening a link that passed the checks
  ///
  /// In en, this message translates to:
  /// **'Always verify the source before opening URLs from QR codes.\n\nDo you want to open this URL?'**
  String get bodyCautionDialog;

  /// Name of the laser line scan overlay style
  ///
  /// In en, this message translates to:
  /// **'Laser Line'**
  String get labelOverlayLaserLine;

  /// Name of the pulsing corners scan overlay style
  ///
  /// In en, this message translates to:
  /// **'Pulsing Corners'**
  String get labelOverlayPulsingCorners;

  /// Name of the grid scan overlay style
  ///
  /// In en, this message translates to:
  /// **'Cybernetic Grid'**
  String get labelOverlayCyberneticGrid;

  /// Name of the dot matrix scan overlay style
  ///
  /// In en, this message translates to:
  /// **'Subtle Dot Matrix'**
  String get labelOverlaySubtleDotMatrix;

  /// Explanation of the laser line overlay style
  ///
  /// In en, this message translates to:
  /// **'Scanning box with an animated vertical laser beam and glow line'**
  String get descOverlayLaserLine;

  /// Explanation of the pulsing corners overlay style
  ///
  /// In en, this message translates to:
  /// **'Breathing corner reticles with color glow and scale animation'**
  String get descOverlayPulsingCorners;

  /// Explanation of the grid overlay style
  ///
  /// In en, this message translates to:
  /// **'Sci-fi grid overlay pattern with target crosshair reticle'**
  String get descOverlayCyberneticGrid;

  /// Explanation of the dot matrix overlay style
  ///
  /// In en, this message translates to:
  /// **'Minimalist corner dot matrix pattern with pulsing accents'**
  String get descOverlaySubtleDotMatrix;

  /// Theme setting that follows the device
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get labelThemeSystemDefault;

  /// Light theme setting
  ///
  /// In en, this message translates to:
  /// **'Light Theme'**
  String get labelThemeLight;

  /// Dark theme setting
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get labelThemeDark;

  /// Pure black theme setting for OLED screens
  ///
  /// In en, this message translates to:
  /// **'OLED Pure Black'**
  String get labelThemeOled;

  /// Heading above the theme choice buttons
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get titleThemeMode;

  /// Short theme button that follows the device
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get labelThemeChipSystem;

  /// Short theme button for the light theme
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get labelThemeChipLight;

  /// Short theme button for the dark theme
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get labelThemeChipDark;

  /// Short theme button for the pure black theme
  ///
  /// In en, this message translates to:
  /// **'OLED'**
  String get labelThemeChipOled;

  /// Setting that takes colours from the device wallpaper
  ///
  /// In en, this message translates to:
  /// **'Dynamic colors'**
  String get labelThemeDynamicColors;

  /// Explanation of the wallpaper colour setting
  ///
  /// In en, this message translates to:
  /// **'Sample system wallpaper colors on Android 12+ (Monet engine)'**
  String get descThemeDynamicColors;

  /// Explanation shown for the system theme
  ///
  /// In en, this message translates to:
  /// **'Follow System Settings'**
  String get descThemeSystem;

  /// Explanation shown for the light theme
  ///
  /// In en, this message translates to:
  /// **'Standard Light Mode'**
  String get descThemeLight;

  /// Explanation shown for the dark theme
  ///
  /// In en, this message translates to:
  /// **'Standard Dark Mode'**
  String get descThemeDark;

  /// Explanation shown for the pure black theme
  ///
  /// In en, this message translates to:
  /// **'True OLED Pure Black (Battery Saving)'**
  String get descThemeOled;

  /// Title of the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get titleSettings;

  /// Settings card that opens the vibration and sound options
  ///
  /// In en, this message translates to:
  /// **'Scan feedback'**
  String get labelSettingsFeedback;

  /// Settings card that opens the privacy options
  ///
  /// In en, this message translates to:
  /// **'Privacy & probing'**
  String get labelSettingsPrivacy;

  /// Settings card that opens the permissions overview
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get labelSettingsPermissions;

  /// Explanation under the permissions card
  ///
  /// In en, this message translates to:
  /// **'What the app uses, and why'**
  String get descSettingsPermissions;

  /// Settings card that opens the feature guides
  ///
  /// In en, this message translates to:
  /// **'Help & guides'**
  String get labelSettingsHelp;

  /// Subtitle of the Help card in Settings
  ///
  /// In en, this message translates to:
  /// **'Simple guides for every feature'**
  String get descSettingsHelp;

  /// Explanation under the about card
  ///
  /// In en, this message translates to:
  /// **'App version, developer & license details'**
  String get descSettingsAbout;

  /// Setting that turns scan vibration on or off
  ///
  /// In en, this message translates to:
  /// **'Vibration Feedback'**
  String get labelFeedbackVibration;

  /// Explanation of the vibration setting
  ///
  /// In en, this message translates to:
  /// **'Vibrate phone upon successful barcode recognition'**
  String get descFeedbackVibration;

  /// Setting that turns the scan beep on or off
  ///
  /// In en, this message translates to:
  /// **'Audible Beep Sound'**
  String get labelFeedbackSound;

  /// Explanation of the beep setting
  ///
  /// In en, this message translates to:
  /// **'Play audio beep signal upon successful code recognition'**
  String get descFeedbackSound;

  /// Setting that turns the visual scan confirmation animation on or off
  ///
  /// In en, this message translates to:
  /// **'Success animation'**
  String get labelFeedbackAnimation;

  /// Explanation of the visual animation setting
  ///
  /// In en, this message translates to:
  /// **'Play reticle pulse and checkmark morph upon successful scan'**
  String get descFeedbackAnimation;

  /// Title of the privacy settings screen
  ///
  /// In en, this message translates to:
  /// **'Privacy & probing'**
  String get titlePrivacyScreen;

  /// Setting that allows contacting the scanned site directly
  ///
  /// In en, this message translates to:
  /// **'Active online checks'**
  String get labelPrivacyActiveChecks;

  /// Summary shown on the settings card when online checks are on
  ///
  /// In en, this message translates to:
  /// **'Active online checks enabled'**
  String get descPrivacySummaryOn;

  /// Summary shown on the settings card when online checks are off
  ///
  /// In en, this message translates to:
  /// **'Private offline checks only'**
  String get descPrivacySummaryOff;

  /// Shown when a Safe Browsing key is saved
  ///
  /// In en, this message translates to:
  /// **'Configured'**
  String get labelApiKeyConfigured;

  /// Shown when no Safe Browsing key is saved
  ///
  /// In en, this message translates to:
  /// **'Not configured'**
  String get labelApiKeyNotConfigured;

  /// Title of the dialog and button for deleting the key
  ///
  /// In en, this message translates to:
  /// **'Delete API Key'**
  String get titleApiKeyDelete;

  /// Button that confirms deleting something
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// Button that stores the key
  ///
  /// In en, this message translates to:
  /// **'Save API Key'**
  String get actionApiKeySave;

  /// Title of the permissions screen
  ///
  /// In en, this message translates to:
  /// **'Permissions Overview'**
  String get titlePermissionsScreen;

  /// Introduction at the top of the Permissions screen
  ///
  /// In en, this message translates to:
  /// **'Permissions let an app use parts of your phone, such as the camera. This app asks only for what a feature needs, and only when you use that feature. You can see or change them at any time in Android Settings > Apps > this app > Permissions.'**
  String get helpPermissionsIntro;

  /// Permissions screen group heading: permissions Android asks the user for
  ///
  /// In en, this message translates to:
  /// **'Asked when needed'**
  String get labelPermGroupAsked;

  /// Short note under the "Asked when needed" group heading
  ///
  /// In en, this message translates to:
  /// **'Android asks you before the app can use these. If you say no, the rest of the app still works.'**
  String get helpPermGroupAskedNote;

  /// Permissions screen group heading: permissions Android allows at install without asking
  ///
  /// In en, this message translates to:
  /// **'Allowed at install'**
  String get labelPermGroupInstall;

  /// Short note under the "Allowed at install" group heading
  ///
  /// In en, this message translates to:
  /// **'Android allows these when the app is installed, without asking. Each one is used only for the feature named here.'**
  String get helpPermGroupInstallNote;

  /// Permissions screen group heading: permissions the app does not ask for
  ///
  /// In en, this message translates to:
  /// **'Not asked for'**
  String get labelPermGroupNotUsed;

  /// Short note under the "Not asked for" group heading
  ///
  /// In en, this message translates to:
  /// **'The app does not ask for these, so it cannot use them.'**
  String get helpPermGroupNotUsedNote;

  /// Permission name: camera
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get labelPermCamera;

  /// What the camera permission is used for, in plain words
  ///
  /// In en, this message translates to:
  /// **'Used to scan QR codes and barcodes, and for AR CodeVision and receiving AirQR transfers. Android asks you the first time you open a camera screen. Camera pictures are read on your phone and are never saved or sent. If you say no, you can still scan from pictures and PDFs.'**
  String get helpPermCameraDesc;

  /// Permission name: location
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get labelPermLocation;

  /// What the location permission is used for, in plain words
  ///
  /// In en, this message translates to:
  /// **'Used only when you tap Use My Location in CodeForge, to put your current place into a map QR code. The app reads your position once, does not keep it and never sends it anywhere. It is never used in the background. If you say no, you can type the place yourself.'**
  String get helpPermLocationDesc;

  /// Permission name: fingerprint or face unlock
  ///
  /// In en, this message translates to:
  /// **'Fingerprint or face'**
  String get labelPermBiometric;

  /// What the biometric permission is used for, in plain words
  ///
  /// In en, this message translates to:
  /// **'Used by App lock, and to open locked StegoQR items with your fingerprint, face or screen lock. Android does the check and only tells the app whether it passed. The app never sees your fingerprint or face.'**
  String get helpPermBiometricDesc;

  /// Permission name: notifications
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get labelPermNotifications;

  /// What the notification permission is used for, in plain words
  ///
  /// In en, this message translates to:
  /// **'Used only while the Scan bubble is on, to show that it is on, with a Turn off button. Android asks the first time you turn the bubble on. If you say no, the bubble still works, just without the notice.'**
  String get helpPermNotificationsDesc;

  /// Permission name: display over other apps
  ///
  /// In en, this message translates to:
  /// **'Show over other apps'**
  String get labelPermOverlay;

  /// What the display-over-other-apps permission is used for, in plain words
  ///
  /// In en, this message translates to:
  /// **'Lets the Scan bubble float over other apps, so you can scan a code you see on screen. Used only after you turn the bubble on. The app explains this first, then opens the Android page where you allow it. If you do not allow it, the bubble stays off.'**
  String get helpPermOverlayDesc;

  /// Permission name: screen capture (GhostScan)
  ///
  /// In en, this message translates to:
  /// **'Screen capture'**
  String get labelPermScreenCapture;

  /// What the screen capture permission is used for, in plain words
  ///
  /// In en, this message translates to:
  /// **'Used by GhostScan and the Scan bubble to read a code shown on your screen. Android asks you every time. The app takes one picture of the screen, reads the code on your phone, then throws the picture away. It never records video and never sends the picture anywhere.'**
  String get helpPermScreenCaptureDesc;

  /// Permission name: internet
  ///
  /// In en, this message translates to:
  /// **'Internet'**
  String get labelPermInternet;

  /// What the internet permission is used for, in plain words
  ///
  /// In en, this message translates to:
  /// **'Scanning works fully offline. The internet is used only by the two optional link checks below. Both are off until you turn them on. While they are off, nothing you scan leaves your phone. Opening a link is done by your browser, not by this app.'**
  String get helpPermInternetDesc;

  /// Name of the optional Active Online Probing check on the Permissions screen
  ///
  /// In en, this message translates to:
  /// **'Online link check'**
  String get labelPermProbing;

  /// What Active Online Probing does with the internet, in plain words
  ///
  /// In en, this message translates to:
  /// **'Off unless you turn on Active Online Probing in Settings > Privacy & probing. When on, the app visits the scanned link before you open it, to follow its redirects, check its security certificate and see how old the website is.'**
  String get helpPermProbingDesc;

  /// Name of the optional online link safety services on the Permissions screen
  ///
  /// In en, this message translates to:
  /// **'Link safety services'**
  String get labelPermLinkServices;

  /// What the optional online link safety services do with the internet, in plain words
  ///
  /// In en, this message translates to:
  /// **'Off unless you turn them on in Settings > URL Safety Providers. When on, the scanned link is sent to the services you chose (such as Google Safe Browsing or VirusTotal) to check it against their lists of harmful sites. Some need your own API key, which is kept in the phone\'s secure storage.'**
  String get helpPermLinkServicesDesc;

  /// Permission name: Wi-Fi and network control
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi connect'**
  String get labelPermWifi;

  /// What the Wi-Fi and network permissions are used for, in plain words
  ///
  /// In en, this message translates to:
  /// **'Used only when you tap Connect to Wi-Fi on a scanned Wi-Fi QR code, to add that network to your phone. On newer Android versions, Android asks you to confirm first. The app does not read your saved Wi-Fi passwords.'**
  String get helpPermWifiDesc;

  /// Permission name: keep running in the background (foreground services)
  ///
  /// In en, this message translates to:
  /// **'Keep running'**
  String get labelPermBackground;

  /// What the foreground service permissions are used for, in plain words
  ///
  /// In en, this message translates to:
  /// **'Lets GhostScan and the Scan bubble keep working while you are in another app. Android always shows a notification while this is running, so you know about it.'**
  String get helpPermBackgroundDesc;

  /// Permission name: start after phone restart
  ///
  /// In en, this message translates to:
  /// **'Start after restart'**
  String get labelPermBoot;

  /// What the start-after-restart permission is used for, in plain words
  ///
  /// In en, this message translates to:
  /// **'Brings the Scan bubble back after your phone restarts, but only if the bubble was on and you turned on Start after restart. Otherwise it does nothing.'**
  String get helpPermBootDesc;

  /// Name of the storage permission, which the app does not ask for
  ///
  /// In en, this message translates to:
  /// **'Photos and files'**
  String get labelPermStorage;

  /// Explains that the app has no storage permission and uses the system picker
  ///
  /// In en, this message translates to:
  /// **'The app has no storage permission. When you scan from a picture or a PDF, Android\'s own picker opens, and the app gets only the file you choose.'**
  String get helpPermStorageDesc;

  /// Name of the microphone permission, which the app does not ask for
  ///
  /// In en, this message translates to:
  /// **'Microphone'**
  String get labelPermMicrophone;

  /// Explains that the app does not use the microphone
  ///
  /// In en, this message translates to:
  /// **'The app does not use the microphone. The camera always opens with sound turned off.'**
  String get helpPermMicrophoneDesc;

  /// Name of the vibration permission, which the app does not need
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get labelPermVibration;

  /// Explains that scan vibration needs no permission
  ///
  /// In en, this message translates to:
  /// **'Scan vibrations use Android\'s built-in touch feedback, which needs no permission.'**
  String get helpPermVibrationDesc;

  /// Word shown when a setting is turned on
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get labelOn;

  /// Word shown when a setting is turned off
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get labelOff;

  /// Explanation under the active online checks switch
  ///
  /// In en, this message translates to:
  /// **'Off: scanned links are checked privately — the destination server is never contacted.'**
  String get descPrivacyActiveChecks;

  /// Longer explanation shown when active online checks are on
  ///
  /// In en, this message translates to:
  /// **'When on, the SSL, redirect and shortener checks connect directly to the scanned site. This exposes your IP address (and therefore your approximate location and mobile carrier) to that server before you open the link.'**
  String get bodyPrivacyExplainerOn;

  /// Longer explanation shown on Settings > Privacy when active online checks are off. Must match the code: SSL, redirect and shortener checks are local only, and a link goes to a safety service (Google Safe Browsing, VirusTotal, etc.) only when the user has turned that service on.
  ///
  /// In en, this message translates to:
  /// **'SSL, redirect and shortener checks use local rules only, so the scanned site is never contacted. A link is sent to a safety service, such as Google Safe Browsing, only if you turned that service on in Settings.'**
  String get bodyPrivacyExplainerOff;

  /// Warning shown before the Safe Browsing key is deleted
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your Google Safe Browsing API key? URL malicious content checking will be disabled.'**
  String get bodyApiKeyDelete;

  /// Summary of the scan feedback settings shown on the settings card
  ///
  /// In en, this message translates to:
  /// **'Vibration: {vibration} • Sound: {sound}'**
  String descFeedbackSummary(String vibration, String sound);

  /// Type label shown when the scanned code is plain text
  ///
  /// In en, this message translates to:
  /// **'TEXT'**
  String get labelResultTypeTextFallback;

  /// Name of the check that looks for an encrypted connection
  ///
  /// In en, this message translates to:
  /// **'HTTPS Connection'**
  String get labelCheckNameHttps;

  /// Name of the check that inspects the site certificate
  ///
  /// In en, this message translates to:
  /// **'SSL/TLS Certificate'**
  String get labelCheckNameSsl;

  /// Name of the check that follows link forwarding
  ///
  /// In en, this message translates to:
  /// **'Redirect Analysis'**
  String get labelCheckNameRedirect;

  /// Name of the check that looks for suspicious link patterns
  ///
  /// In en, this message translates to:
  /// **'Pattern Detection'**
  String get labelCheckNamePattern;

  /// Name of the check that spots shortened links
  ///
  /// In en, this message translates to:
  /// **'URL Shortener Check'**
  String get labelCheckNameShortener;

  /// Name of the check that spots lookalike characters
  ///
  /// In en, this message translates to:
  /// **'Homograph check'**
  String get labelCheckNameHomograph;

  /// Name of the Google Safe Browsing lookup
  ///
  /// In en, this message translates to:
  /// **'Malicious content'**
  String get labelCheckNameMalicious;

  /// Result when the link is not encrypted
  ///
  /// In en, this message translates to:
  /// **'URL uses unencrypted HTTP connection'**
  String get bodyHttpsNotUsed;

  /// Result when only the scheme was checked, to protect privacy
  ///
  /// In en, this message translates to:
  /// **'Uses HTTPS (live certificate not checked in private mode)'**
  String get bodySslPrivateModeOk;

  /// Result when the site certificate is good
  ///
  /// In en, this message translates to:
  /// **'Valid SSL certificate'**
  String get bodySslValid;

  /// Result when the site certificate has run out
  ///
  /// In en, this message translates to:
  /// **'SSL certificate has expired'**
  String get bodySslExpired;

  /// Result when the site certificate starts in the future
  ///
  /// In en, this message translates to:
  /// **'SSL certificate not yet valid'**
  String get bodySslNotYetValid;

  /// Result when the site certificate is self-signed, for another site, or from an unknown issuer
  ///
  /// In en, this message translates to:
  /// **'SSL certificate is not trusted'**
  String get bodySslUntrusted;

  /// Result when the certificate could not be read
  ///
  /// In en, this message translates to:
  /// **'Unable to verify certificate'**
  String get bodySslUnverifiable;

  /// Result when the certificate check itself failed
  ///
  /// In en, this message translates to:
  /// **'Certificate check failed'**
  String get bodySslCheckFailed;

  /// Result when redirects were not followed, to protect privacy
  ///
  /// In en, this message translates to:
  /// **'Skipped in private mode (destination server not contacted)'**
  String get bodyRedirectSkippedPrivate;

  /// Result when the link forwards round in a circle
  ///
  /// In en, this message translates to:
  /// **'Redirect loop detected'**
  String get bodyRedirectLoop;

  /// Result when the link goes straight to its target
  ///
  /// In en, this message translates to:
  /// **'No redirects detected'**
  String get bodyRedirectNone;

  /// Result when link forwarding could not be checked
  ///
  /// In en, this message translates to:
  /// **'Unable to check redirects'**
  String get bodyRedirectUnavailable;

  /// Result when the link looks ordinary
  ///
  /// In en, this message translates to:
  /// **'No suspicious patterns found'**
  String get bodyPatternNone;

  /// Result when the pattern check could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to analyze patterns'**
  String get bodyPatternUnavailable;

  /// Result when only local rules could be used to spot a shortened link
  ///
  /// In en, this message translates to:
  /// **'Unable to perform full check (offline) - heuristics only'**
  String get bodyShortenerOfflineHeuristics;

  /// Result when the link is not shortened
  ///
  /// In en, this message translates to:
  /// **'No URL shortener detected'**
  String get bodyShortenerNone;

  /// Result when the shortener check could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to check for shorteners'**
  String get bodyShortenerUnavailable;

  /// Result when a domain mixes alphabets, a common trick
  ///
  /// In en, this message translates to:
  /// **'Mixed character scripts detected'**
  String get bodyHomographMixedScripts;

  /// Result when the domain uses one alphabet
  ///
  /// In en, this message translates to:
  /// **'No lookalike characters detected'**
  String get bodyHomographNone;

  /// Result when the lookalike check could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to check for homographs'**
  String get bodyHomographUnavailable;

  /// Result when no Safe Browsing key is saved
  ///
  /// In en, this message translates to:
  /// **'Skipped (API key not configured)'**
  String get bodyMaliciousSkippedNoKey;

  /// Result when the free daily lookups are used up
  ///
  /// In en, this message translates to:
  /// **'Daily API limit reached (resets tomorrow)'**
  String get bodyMaliciousDailyLimit;

  /// Result when Safe Browsing reports nothing
  ///
  /// In en, this message translates to:
  /// **'No known threats detected'**
  String get bodyMaliciousNone;

  /// Result when Safe Browsing rejects the key
  ///
  /// In en, this message translates to:
  /// **'Invalid API key or request'**
  String get bodyMaliciousInvalidKey;

  /// Result when Safe Browsing asks us to slow down
  ///
  /// In en, this message translates to:
  /// **'Rate limit exceeded'**
  String get bodyMaliciousRateLimited;

  /// Result when the Safe Browsing lookup could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to check for malicious content'**
  String get bodyMaliciousUnavailable;

  /// Shown when the secret could not be unlocked
  ///
  /// In en, this message translates to:
  /// **'Decryption failed. Invalid passphrase or corrupted data.'**
  String get errorStegoWrongPassphrase;

  /// Shown when a received stream did not rebuild correctly
  ///
  /// In en, this message translates to:
  /// **'Checksum verification failed during reassembly.'**
  String get errorAirQrChecksumFailed;

  /// Result when a link forwards many times
  ///
  /// In en, this message translates to:
  /// **'Suspicious redirect chain ({count} redirects)'**
  String bodyRedirectSuspiciousChain(String count);

  /// Result when a link forwards an ordinary number of times
  ///
  /// In en, this message translates to:
  /// **'{count} redirect(s) - within normal range'**
  String bodyRedirectWithinRange(String count);

  /// Result listing the suspicious patterns found in a link
  ///
  /// In en, this message translates to:
  /// **'Detected: {patterns}'**
  String bodyPatternDetected(String patterns);

  /// Result naming the shortening service used by a link
  ///
  /// In en, this message translates to:
  /// **'Known URL shortener detected ({shortener})'**
  String bodyShortenerKnown(String shortener);

  /// Result naming where a shortened link actually goes
  ///
  /// In en, this message translates to:
  /// **'Detected URL shortener (redirects to {host})'**
  String bodyShortenerRedirect(String host);

  /// Result listing the lookalike characters found in a domain
  ///
  /// In en, this message translates to:
  /// **'Lookalike characters detected: {characters}'**
  String bodyHomographLookalikes(String characters);

  /// Result listing the threat types Safe Browsing reported
  ///
  /// In en, this message translates to:
  /// **'Threats detected: {threats}'**
  String bodyMaliciousThreats(String threats);

  /// Result when Safe Browsing returned an unexpected status
  ///
  /// In en, this message translates to:
  /// **'API error (status: {status})'**
  String bodyMaliciousApiError(String status);

  /// Label for the VirusTotal URL safety check row
  ///
  /// In en, this message translates to:
  /// **'VirusTotal'**
  String get labelCheckNameVirusTotal;

  /// Result when no VirusTotal key is saved
  ///
  /// In en, this message translates to:
  /// **'Skipped (API key not configured)'**
  String get bodyVirusTotalSkippedNoKey;

  /// Result when the VirusTotal free daily quota is exhausted
  ///
  /// In en, this message translates to:
  /// **'Daily limit reached (500/day — resets tomorrow)'**
  String get bodyVirusTotalDailyLimit;

  /// Result when VirusTotal reports malicious votes
  ///
  /// In en, this message translates to:
  /// **'Threats detected by {engines} engine(s)'**
  String bodyVirusTotalThreats(String engines);

  /// Result when VirusTotal reports the URL is clean
  ///
  /// In en, this message translates to:
  /// **'No threats detected (VirusTotal)'**
  String get bodyVirusTotalNone;

  /// Result when VirusTotal rejects the key
  ///
  /// In en, this message translates to:
  /// **'Invalid API key or request (VirusTotal)'**
  String get bodyVirusTotalInvalidKey;

  /// Result when VirusTotal asks us to slow down
  ///
  /// In en, this message translates to:
  /// **'Rate limit exceeded (VirusTotal)'**
  String get bodyVirusTotalRateLimited;

  /// Result when VirusTotal returned an unexpected HTTP status
  ///
  /// In en, this message translates to:
  /// **'API error (status: {status})'**
  String bodyVirusTotalApiError(String status);

  /// Result when the VirusTotal lookup could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to check (VirusTotal)'**
  String get bodyVirusTotalUnavailable;

  /// Label for the URLhaus URL safety check row
  ///
  /// In en, this message translates to:
  /// **'URLhaus'**
  String get labelCheckNameUrlhaus;

  /// Result when no URLhaus key is saved
  ///
  /// In en, this message translates to:
  /// **'Skipped (API key not configured)'**
  String get bodyUrlhausSkippedNoKey;

  /// Result when URLhaus flags the URL as a malware host
  ///
  /// In en, this message translates to:
  /// **'Malware URL detected: {tags}'**
  String bodyUrlhausMalware(String tags);

  /// Result when URLhaus reports the URL is offline or clean
  ///
  /// In en, this message translates to:
  /// **'No known malware hosting (URLhaus)'**
  String get bodyUrlhausClean;

  /// Result when URLhaus has no record of this URL
  ///
  /// In en, this message translates to:
  /// **'Not in URLhaus database'**
  String get bodyUrlhausNotFound;

  /// Result when URLhaus rejects the auth key
  ///
  /// In en, this message translates to:
  /// **'Invalid API key (URLhaus)'**
  String get bodyUrlhausInvalidKey;

  /// Result when URLhaus returned an unexpected HTTP status
  ///
  /// In en, this message translates to:
  /// **'API error (status: {status})'**
  String bodyUrlhausApiError(String status);

  /// Result when the URLhaus lookup could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to check (URLhaus)'**
  String get bodyUrlhausUnavailable;

  /// Label for the PhishTank URL safety check row
  ///
  /// In en, this message translates to:
  /// **'PhishTank'**
  String get labelCheckNamePhishTank;

  /// Result when PhishTank is toggled off in settings
  ///
  /// In en, this message translates to:
  /// **'Skipped (PhishTank disabled)'**
  String get bodyPhishTankSkippedDisabled;

  /// Result when PhishTank confirms the URL is a phishing site
  ///
  /// In en, this message translates to:
  /// **'Known phishing site (PhishTank)'**
  String get bodyPhishTankPhishing;

  /// Result when PhishTank says the URL is valid / not phishing
  ///
  /// In en, this message translates to:
  /// **'Not a known phishing site (PhishTank)'**
  String get bodyPhishTankClean;

  /// Result when PhishTank has no record of this URL
  ///
  /// In en, this message translates to:
  /// **'Not in PhishTank database'**
  String get bodyPhishTankNotInDatabase;

  /// Result when PhishTank returned an unexpected HTTP status
  ///
  /// In en, this message translates to:
  /// **'API error (status: {status})'**
  String bodyPhishTankApiError(String status);

  /// Result when the PhishTank lookup could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to check (PhishTank)'**
  String get bodyPhishTankUnavailable;

  /// Label for the OpenPhish offline URL safety check row
  ///
  /// In en, this message translates to:
  /// **'OpenPhish'**
  String get labelCheckNameOpenPhish;

  /// Result when OpenPhish is toggled off in settings
  ///
  /// In en, this message translates to:
  /// **'Skipped (OpenPhish disabled)'**
  String get bodyOpenPhishSkippedDisabled;

  /// Result when the URL appears in the cached OpenPhish feed
  ///
  /// In en, this message translates to:
  /// **'Known phishing site (OpenPhish)'**
  String get bodyOpenPhishPhishing;

  /// Result when the URL does not appear in the OpenPhish feed
  ///
  /// In en, this message translates to:
  /// **'Not in phishing feed (OpenPhish)'**
  String get bodyOpenPhishClean;

  /// Result when no cached feed exists and network is unavailable
  ///
  /// In en, this message translates to:
  /// **'Feed unavailable — offline check skipped'**
  String get bodyOpenPhishFeedStale;

  /// Result when the OpenPhish check could not run
  ///
  /// In en, this message translates to:
  /// **'Unable to check (OpenPhish)'**
  String get bodyOpenPhishUnavailable;

  /// Settings card that opens the URL safety providers page
  ///
  /// In en, this message translates to:
  /// **'URL Safety Providers'**
  String get labelSettingsUrlSafetyProviders;

  /// Summary under the URL safety providers card
  ///
  /// In en, this message translates to:
  /// **'{count} provider(s) active'**
  String descSettingsUrlSafetyProviders(String count);

  /// Help text at the top of the URL safety providers settings screen
  ///
  /// In en, this message translates to:
  /// **'Configure optional online URL safety checks. Each provider is independent. Non-commercial providers require your own free account and API key.'**
  String get helpUrlSafetyProviders;

  /// Section header for providers that require the user to supply a key
  ///
  /// In en, this message translates to:
  /// **'Your API Keys'**
  String get titleUrlSafetyUserSupplied;

  /// Note below the user-supplied section header
  ///
  /// In en, this message translates to:
  /// **'Non-commercial use only'**
  String get descUrlSafetyUserSupplied;

  /// Section header for providers that are built in and just need a toggle
  ///
  /// In en, this message translates to:
  /// **'Built-In Providers'**
  String get titleUrlSafetyBuiltIn;

  /// Note below the built-in providers section header
  ///
  /// In en, this message translates to:
  /// **'No account needed — just toggle on'**
  String get descUrlSafetyBuiltIn;

  /// Label for the optional custom API endpoint URL field
  ///
  /// In en, this message translates to:
  /// **'API Endpoint URL'**
  String get labelProviderEndpoint;

  /// Hint text inside the API key text field
  ///
  /// In en, this message translates to:
  /// **'Paste your API key'**
  String get labelProviderApiKey;

  /// Prefix label before the registration URL link
  ///
  /// In en, this message translates to:
  /// **'Get a free key at:'**
  String get bodyProviderGetKeyAt;

  /// Shows how many daily requests have been used out of the limit
  ///
  /// In en, this message translates to:
  /// **'{used} / {max} requests today'**
  String bodyProviderDailyUsage(String used, String max);

  /// Shows when the OpenPhish feed was last downloaded
  ///
  /// In en, this message translates to:
  /// **'Last updated: {datetime}'**
  String bodyOpenPhishLastUpdated(String datetime);

  /// Button to manually refresh the OpenPhish phishing feed
  ///
  /// In en, this message translates to:
  /// **'Refresh feed now'**
  String get actionOpenPhishRefresh;

  /// Snackbar after a successful OpenPhish feed refresh
  ///
  /// In en, this message translates to:
  /// **'Feed updated ({count} URLs)'**
  String bodyOpenPhishFeedRefreshed(String count);

  /// Snackbar when the OpenPhish feed download fails
  ///
  /// In en, this message translates to:
  /// **'Feed refresh failed'**
  String get errorOpenPhishFeedFailed;

  /// Toggle switch label for the PhishTank built-in provider
  ///
  /// In en, this message translates to:
  /// **'Enable PhishTank'**
  String get labelPhishTankToggle;

  /// Toggle switch label for the OpenPhish built-in provider
  ///
  /// In en, this message translates to:
  /// **'Use OpenPhish feed'**
  String get labelOpenPhishToggle;

  /// Badge when the link is not a normal web address
  ///
  /// In en, this message translates to:
  /// **'Invalid URL scheme'**
  String get bodyDomSslInvalidScheme;

  /// Badge when the site uses an encrypted connection
  ///
  /// In en, this message translates to:
  /// **'Uses encrypted HTTPS protocol'**
  String get bodyDomSslHttps;

  /// Badge when the site connection is not encrypted
  ///
  /// In en, this message translates to:
  /// **'Unencrypted HTTP connection (High Risk)'**
  String get bodyDomSslHttp;

  /// Status when the link cannot be understood
  ///
  /// In en, this message translates to:
  /// **'Invalid or unsupported web URL format.'**
  String get bodyDomStatusInvalidUrl;

  /// Status when the site connection is not encrypted
  ///
  /// In en, this message translates to:
  /// **'⚠️ Caution: Unencrypted HTTP site'**
  String get bodyDomStatusHttpCaution;

  /// Status when the preview was built with nothing risky left in
  ///
  /// In en, this message translates to:
  /// **'✅ Zero-Trust DOM Sandbox: HTML preview sanitized safely.'**
  String get bodyDomStatusSafe;

  /// Status naming where a hidden forward would send the user
  ///
  /// In en, this message translates to:
  /// **'⚠️ Warning: Open Redirect Trap detected pointing to {target}'**
  String bodyDomStatusOpenRedirect(String target);

  /// Status naming how new the site domain is
  ///
  /// In en, this message translates to:
  /// **'⚠️ Warning: Newly registered domain ({days} days old)'**
  String bodyDomStatusNewDomain(String days);

  /// Shown when the unlock box was left blank
  ///
  /// In en, this message translates to:
  /// **'Passphrase cannot be empty'**
  String get errorStegoPassphraseEmpty;

  /// Text shown in the system fingerprint or face unlock dialog
  ///
  /// In en, this message translates to:
  /// **'Authenticate to view StegoQR secret payload'**
  String get bodyStegoBiometricReason;

  /// Shown when a chosen picture holds no code
  ///
  /// In en, this message translates to:
  /// **'No barcodes or QR codes detected in image.'**
  String get errorMediaNoCodeInImage;

  /// Shown when a chosen PDF holds no code
  ///
  /// In en, this message translates to:
  /// **'No barcodes or QR codes found in PDF document.'**
  String get errorMediaNoCodeInPdf;

  /// Shown when a picture could not be opened or read
  ///
  /// In en, this message translates to:
  /// **'Failed to pick or scan image: {error}'**
  String errorMediaImagePickFailed(String error);

  /// Shown when a picture could not be analysed
  ///
  /// In en, this message translates to:
  /// **'Error analyzing image: {error}'**
  String errorMediaImageAnalyzeFailed(String error);

  /// Shown when a PDF could not be opened or read
  ///
  /// In en, this message translates to:
  /// **'Failed to pick or parse PDF: {error}'**
  String errorMediaPdfPickFailed(String error);

  /// Shown when a picked, shared or pasted image file is over the size limit; maxMb is the limit in megabytes
  ///
  /// In en, this message translates to:
  /// **'This image is too large to scan (over {maxMb} MB).'**
  String errorMediaImageTooLarge(String maxMb);

  /// Shown when a picked or shared PDF file is over the size limit; maxMb is the limit in megabytes
  ///
  /// In en, this message translates to:
  /// **'This PDF is too large to scan (over {maxMb} MB).'**
  String errorMediaPdfTooLarge(String maxMb);

  /// Short note after scanning a PDF that has more pages than the page limit
  ///
  /// In en, this message translates to:
  /// **'Only the first {count} pages were checked.'**
  String bodyPdfPagesSkipped(int count);

  /// Shown when a PDF could not be scanned
  ///
  /// In en, this message translates to:
  /// **'Failed to scan PDF document: {error}'**
  String errorMediaPdfScanFailed(String error);

  /// Shown when fingerprint or face unlock was cancelled or did not work
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication canceled or failed.'**
  String get errorStegoBiometricCanceled;

  /// Label for a QR code holding a web link
  ///
  /// In en, this message translates to:
  /// **'QR (URL)'**
  String get labelFormatQrUrl;

  /// Label for a QR code holding an email address
  ///
  /// In en, this message translates to:
  /// **'QR (Email)'**
  String get labelFormatQrEmail;

  /// Label for a QR code holding a phone number
  ///
  /// In en, this message translates to:
  /// **'QR (Phone)'**
  String get labelFormatQrPhone;

  /// Label for a QR code holding a text message
  ///
  /// In en, this message translates to:
  /// **'QR (SMS)'**
  String get labelFormatQrSms;

  /// Label for a QR code holding Wi-Fi details
  ///
  /// In en, this message translates to:
  /// **'QR (Wi-Fi)'**
  String get labelFormatQrWifi;

  /// Label for a QR code holding a place
  ///
  /// In en, this message translates to:
  /// **'QR (Location)'**
  String get labelFormatQrLocation;

  /// Label for a QR code holding a contact card
  ///
  /// In en, this message translates to:
  /// **'QR (Contact)'**
  String get labelFormatQrContact;

  /// Label for a book barcode
  ///
  /// In en, this message translates to:
  /// **'ISBN'**
  String get labelFormatIsbn;

  /// Label for a product barcode
  ///
  /// In en, this message translates to:
  /// **'EAN/UPC'**
  String get labelFormatEanUpc;

  /// Label for a plain QR code
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get labelFormatQrCode;

  /// Label for a shop product barcode
  ///
  /// In en, this message translates to:
  /// **'EAN/UPC Product'**
  String get labelFormatEanUpcProduct;

  /// Label for any other barcode
  ///
  /// In en, this message translates to:
  /// **'Barcode'**
  String get labelFormatBarcode;

  /// Shown in place of the network name when a Wi-Fi code hides it
  ///
  /// In en, this message translates to:
  /// **'Hidden Network'**
  String get labelWifiHiddenNetwork;

  /// Shown in place of the account name when a 2FA code has none
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get labelTotpDefaultAccount;

  /// Shown when a backup file cannot be read at all
  ///
  /// In en, this message translates to:
  /// **'Invalid backup file format.'**
  String get errorBackupInvalidFormat;

  /// Shown when a backup file is not one this app wrote
  ///
  /// In en, this message translates to:
  /// **'Unrecognized or corrupted backup file header.'**
  String get errorBackupBadHeader;

  /// Shown when a backup could not be unlocked
  ///
  /// In en, this message translates to:
  /// **'Incorrect passphrase or corrupted backup payload.'**
  String get errorBackupWrongPassphrase;

  /// Heading at the top of the exported history report
  ///
  /// In en, this message translates to:
  /// **'SREERAJP QR STUDIO - SCAN HISTORY'**
  String get bodyReportHeading;

  /// Title inside the exported PDF report
  ///
  /// In en, this message translates to:
  /// **'Scan History Export'**
  String get bodyReportTitle;

  /// Label before the date the report was made
  ///
  /// In en, this message translates to:
  /// **'Export Date'**
  String get labelReportExportDate;

  /// Label before how many scans the report covers
  ///
  /// In en, this message translates to:
  /// **'Total Scans'**
  String get labelReportTotalScans;

  /// Label before the number of each scan in the text report
  ///
  /// In en, this message translates to:
  /// **'Scan #'**
  String get labelReportScanNumber;

  /// Row label for the scan id, padded to line up
  ///
  /// In en, this message translates to:
  /// **'ID           '**
  String get labelReportId;

  /// Row label for the scan time, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Timestamp    '**
  String get labelReportTimestamp;

  /// Row label for the code format, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Format       '**
  String get labelReportFormat;

  /// Row label for the scan category, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Category     '**
  String get labelReportCategory;

  /// Row label for the safety score, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Safety Score '**
  String get labelReportSafetyScore;

  /// Row label for whether the scan is a favourite, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Starred      '**
  String get labelReportStarred;

  /// Shown when a scan is a favourite
  ///
  /// In en, this message translates to:
  /// **'⭐ Yes'**
  String get labelReportStarredYes;

  /// Shown when a scan is not a favourite
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get labelReportStarredNo;

  /// Row label for the place of the scan, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Location     '**
  String get labelReportLocation;

  /// Row label for the user note, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Notes        '**
  String get labelReportNotes;

  /// Row label for the scanned content, padded to line up
  ///
  /// In en, this message translates to:
  /// **'Content      '**
  String get labelReportContent;

  /// PDF table column for the scan time
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get labelReportColumnDateTime;

  /// PDF table column for the code format
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get labelReportColumnFormat;

  /// PDF table column for the scan category
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get labelReportColumnCategory;

  /// PDF table column for the safety score
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get labelReportColumnSafety;

  /// PDF table column for a short piece of the content
  ///
  /// In en, this message translates to:
  /// **'Content Snippet'**
  String get labelReportColumnContent;

  /// PDF table column for the user note
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get labelReportColumnNotes;

  /// Suspicious pattern: the link uses a raw IP address
  ///
  /// In en, this message translates to:
  /// **'IP Address'**
  String get labelPatternIpAddress;

  /// Suspicious pattern: a long run of digits
  ///
  /// In en, this message translates to:
  /// **'Long Number Sequence'**
  String get labelPatternLongNumbers;

  /// Suspicious pattern: many dashes or underscores
  ///
  /// In en, this message translates to:
  /// **'Many dashes'**
  String get labelPatternManyDashes;

  /// Suspicious pattern: words often used in phishing links
  ///
  /// In en, this message translates to:
  /// **'Phishing Keywords'**
  String get labelPatternPhishingKeywords;

  /// Suspicious pattern: the link embeds data directly
  ///
  /// In en, this message translates to:
  /// **'Data URI'**
  String get labelPatternDataUri;

  /// Suspicious pattern: unusually many subdomains
  ///
  /// In en, this message translates to:
  /// **'Multiple Subdomains'**
  String get labelPatternManySubdomains;

  /// Result when a link looks shortened by its shape
  ///
  /// In en, this message translates to:
  /// **'Possible URL shortener: short domain with minimal path'**
  String get bodyShortenerPossibleShortDomain;

  /// Result when a link path looks machine-generated
  ///
  /// In en, this message translates to:
  /// **'Possible URL shortener: random character pattern in short path'**
  String get bodyShortenerPossibleRandomPath;

  /// Result naming the domain ending that suggests a shortened link
  ///
  /// In en, this message translates to:
  /// **'Possible URL shortener: short domain with common shortener ending ({tld})'**
  String bodyShortenerPossibleTld(String tld);

  /// Title of the Features settings card
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get titleSettingsFeatures;

  /// Subtitle of the Features settings card
  ///
  /// In en, this message translates to:
  /// **'Explore all features of SreerajP QR Studio'**
  String get descSettingsFeatures;

  /// Title of the Appearance preferences hub screen
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get titleAppearanceHub;

  /// Title of the Theme Mode card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get labelAppearanceThemeModeCard;

  /// Subtitle of the Theme Mode card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'Choose between System, Light, Dark, or OLED mode'**
  String get descAppearanceThemeModeCard;

  /// Title of the Scan Overlay Style card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'Scan Overlay Style'**
  String get labelAppearanceOverlayCard;

  /// Subtitle of the Scan Overlay Style card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'Laser line, pulsing corners, cybernetic grid, or dot matrix'**
  String get descAppearanceOverlayCard;

  /// Title of the Accent Color card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'Accent & colors'**
  String get labelAppearanceAccentCard;

  /// Subtitle of the Accent Color card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'Material You dynamic color and custom accent palettes'**
  String get descAppearanceAccentCard;

  /// Title of the Typography & Text Size card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'Text size & font'**
  String get labelAppearanceTypographyCard;

  /// Subtitle of the Typography & Text Size card in Appearance hub
  ///
  /// In en, this message translates to:
  /// **'App font family and text scale preferences'**
  String get descAppearanceTypographyCard;

  /// Hero header title on the Features screen
  ///
  /// In en, this message translates to:
  /// **'All features'**
  String get titleFeaturesHeader;

  /// Hero header subtitle on the Features screen
  ///
  /// In en, this message translates to:
  /// **'Explore every intelligent scanning tool, 6-layer URL safety engine, AR CodeVision, and offline feature designed for you.'**
  String get descFeaturesHeader;

  /// Features screen: name of the core scanning category
  ///
  /// In en, this message translates to:
  /// **'Scanning'**
  String get titleFeaturesCatScanning;

  /// Features screen: subtitle of the core scanning category
  ///
  /// In en, this message translates to:
  /// **'Lightning-fast 1D/2D barcode engine with multi-source media support'**
  String get descFeaturesCatScanning;

  /// Features screen: name of the URL safety engine category
  ///
  /// In en, this message translates to:
  /// **'6-layer link safety'**
  String get titleFeaturesCatSafety;

  /// Features screen: subtitle of the URL safety engine category
  ///
  /// In en, this message translates to:
  /// **'Zero-trust forensic analysis defending you against malicious QR phishing & scams'**
  String get descFeaturesCatSafety;

  /// Features screen: name of the QuishingGuard and AI vision category
  ///
  /// In en, this message translates to:
  /// **'Vision tools'**
  String get titleFeaturesCatVision;

  /// Features screen: subtitle of the QuishingGuard and AI vision category
  ///
  /// In en, this message translates to:
  /// **'Cutting-edge on-device computer vision and optical air-gap data streaming'**
  String get descFeaturesCatVision;

  /// Features screen: name of the smart payloads category
  ///
  /// In en, this message translates to:
  /// **'Smart actions'**
  String get titleFeaturesCatPayloads;

  /// Features screen: subtitle of the smart payloads category
  ///
  /// In en, this message translates to:
  /// **'Instant parsing and contextual native actions for everyday barcodes'**
  String get descFeaturesCatPayloads;

  /// Features screen: name of the history and privacy category
  ///
  /// In en, this message translates to:
  /// **'History & privacy'**
  String get titleFeaturesCatHistory;

  /// Features screen: subtitle of the history and privacy category
  ///
  /// In en, this message translates to:
  /// **'Your personal scan history protected by biometric security and offline storage'**
  String get descFeaturesCatHistory;

  /// Features screen: title of the barcode engine feature
  ///
  /// In en, this message translates to:
  /// **'Barcode engine'**
  String get titleFeatureBarcodeEngine;

  /// Features screen: description of the barcode engine feature
  ///
  /// In en, this message translates to:
  /// **'Instantly decodes 1D barcodes (EAN-13, UPC-A, Code 128, Code 39, Codabar, ITF) and 2D codes (QR, Data Matrix, Aztec, PDF417) in milliseconds.'**
  String get descFeatureBarcodeEngine;

  /// Features screen: highlight chip 1 of the barcode engine feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'QR & Data Matrix'**
  String get labelFeatureBarcodeEngineChip1;

  /// Features screen: highlight chip 2 of the barcode engine feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Aztec & PDF417'**
  String get labelFeatureBarcodeEngineChip2;

  /// Features screen: highlight chip 3 of the barcode engine feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'EAN & Code 128'**
  String get labelFeatureBarcodeEngineChip3;

  /// Features screen: title of the multi-source media feature
  ///
  /// In en, this message translates to:
  /// **'Images & PDF'**
  String get titleFeatureMediaSources;

  /// Features screen: description of the multi-source media feature
  ///
  /// In en, this message translates to:
  /// **'Scan barcodes from live camera feed, select existing images from your gallery, or extract and parse barcodes across multi-page PDF documents.'**
  String get descFeatureMediaSources;

  /// Features screen: highlight chip 1 of the multi-source media feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Gallery Photos'**
  String get labelFeatureMediaSourcesChip1;

  /// Features screen: highlight chip 2 of the multi-source media feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Multi-Page PDF'**
  String get labelFeatureMediaSourcesChip2;

  /// Features screen: highlight chip 3 of the multi-source media feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Live Viewport'**
  String get labelFeatureMediaSourcesChip3;

  /// Features screen: title of the GhostScan feature
  ///
  /// In en, this message translates to:
  /// **'GhostScan'**
  String get titleFeatureGhostScan;

  /// Features screen: description of the GhostScan feature
  ///
  /// In en, this message translates to:
  /// **'Detects and decodes QR codes visible on your screen inside messaging apps, social feeds, and web browsers via Quick Settings tile, the floating Scan bubble, or on-demand trigger without saving screenshots.'**
  String get descFeatureGhostScan;

  /// Features screen: highlight chip 1 of the GhostScan feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Quick Settings Tile'**
  String get labelFeatureGhostScanChip1;

  /// Features screen: highlight chip 2 of the GhostScan feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Floating Scan Bubble'**
  String get labelFeatureGhostScanChip2;

  /// Features screen: highlight chip 3 of the GhostScan feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'No Screenshots Saved'**
  String get labelFeatureGhostScanChip3;

  /// Features screen: title of the camera controls feature
  ///
  /// In en, this message translates to:
  /// **'Camera controls'**
  String get titleFeatureCameraControls;

  /// Features screen: description of the camera controls feature
  ///
  /// In en, this message translates to:
  /// **'Smooth zoom slider, torch flashlight toggle, front and rear camera switching, and continuous autofocus for low-light scanning.'**
  String get descFeatureCameraControls;

  /// Features screen: highlight chip 1 of the camera controls feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Flashlight Torch'**
  String get labelFeatureCameraControlsChip1;

  /// Features screen: highlight chip 2 of the camera controls feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Zoom Control'**
  String get labelFeatureCameraControlsChip2;

  /// Features screen: highlight chip 3 of the camera controls feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Front/Back Flip'**
  String get labelFeatureCameraControlsChip3;

  /// Features screen: title of the scan overlays feature
  ///
  /// In en, this message translates to:
  /// **'Scan overlays'**
  String get titleFeatureScanOverlays;

  /// Features screen: description of the scan overlays feature
  ///
  /// In en, this message translates to:
  /// **'Choose between Laser Line, Pulsing Corners, Cybernetic Grid, or Subtle Dot Matrix viewfinder overlays with live feedback.'**
  String get descFeatureScanOverlays;

  /// Features screen: highlight chip 1 of the scan overlays feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'4 Overlay Styles'**
  String get labelFeatureScanOverlaysChip1;

  /// Features screen: highlight chip 2 of the scan overlays feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Live Animation'**
  String get labelFeatureScanOverlaysChip2;

  /// Features screen: highlight chip 3 of the scan overlays feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'OLED Compatible'**
  String get labelFeatureScanOverlaysChip3;

  /// Features screen: title of the haptic and audio feedback feature
  ///
  /// In en, this message translates to:
  /// **'Haptic & sound'**
  String get titleFeatureFeedback;

  /// Features screen: description of the haptic and audio feedback feature
  ///
  /// In en, this message translates to:
  /// **'Customizable vibration pulses and audible beep tones confirm successful recognition even in noisy environments.'**
  String get descFeatureFeedback;

  /// Features screen: highlight chip 1 of the haptic and audio feedback feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Haptic Pulse'**
  String get labelFeatureFeedbackChip1;

  /// Features screen: highlight chip 2 of the haptic and audio feedback feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Audio Beep'**
  String get labelFeatureFeedbackChip2;

  /// Features screen: highlight chip 3 of the haptic and audio feedback feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Independent Toggles'**
  String get labelFeatureFeedbackChip3;

  /// Features screen: title of the protocol guard (layer 1) feature
  ///
  /// In en, this message translates to:
  /// **'1. Protocol guard'**
  String get titleFeatureProtocolGuard;

  /// Features screen: description of the protocol guard (layer 1) feature
  ///
  /// In en, this message translates to:
  /// **'Validates scheme authenticity, checks for encrypted HTTPS connections, and flags plain HTTP or unsupported schemes.'**
  String get descFeatureProtocolGuard;

  /// Features screen: highlight chip 1 of the protocol guard (layer 1) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'HTTPS Validation'**
  String get labelFeatureProtocolGuardChip1;

  /// Features screen: highlight chip 2 of the protocol guard (layer 1) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Scheme Checking'**
  String get labelFeatureProtocolGuardChip2;

  /// Features screen: highlight chip 3 of the protocol guard (layer 1) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Zero-Width Char Trap'**
  String get labelFeatureProtocolGuardChip3;

  /// Features screen: title of the homograph shield (layer 2) feature
  ///
  /// In en, this message translates to:
  /// **'2. Homograph shield'**
  String get titleFeatureHomographShield;

  /// Features screen: description of the homograph shield (layer 2) feature
  ///
  /// In en, this message translates to:
  /// **'Detects lookalike Cyrillic, Greek, and Unicode spoofing characters used to disguise fraudulent domain names (IDN punycode defense).'**
  String get descFeatureHomographShield;

  /// Features screen: highlight chip 1 of the homograph shield (layer 2) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Punycode Defense'**
  String get labelFeatureHomographShieldChip1;

  /// Features screen: highlight chip 2 of the homograph shield (layer 2) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Cyrillic Lookalikes'**
  String get labelFeatureHomographShieldChip2;

  /// Features screen: highlight chip 3 of the homograph shield (layer 2) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Mixed-Script Trap'**
  String get labelFeatureHomographShieldChip3;

  /// Features screen: title of the TLD and entropy analysis (layer 3) feature
  ///
  /// In en, this message translates to:
  /// **'3. TLD & entropy'**
  String get titleFeatureTldEntropy;

  /// Features screen: description of the TLD and entropy analysis (layer 3) feature
  ///
  /// In en, this message translates to:
  /// **'Flags high-risk top-level domains, excessive subdomains, and evaluates domain name character entropy to catch algorithmic domains.'**
  String get descFeatureTldEntropy;

  /// Features screen: highlight chip 1 of the TLD and entropy analysis (layer 3) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'High-Risk TLDs'**
  String get labelFeatureTldEntropyChip1;

  /// Features screen: highlight chip 2 of the TLD and entropy analysis (layer 3) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Entropy Scoring'**
  String get labelFeatureTldEntropyChip2;

  /// Features screen: highlight chip 3 of the TLD and entropy analysis (layer 3) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Subdomain Depth'**
  String get labelFeatureTldEntropyChip3;

  /// Features screen: title of the IP and port flagging (layer 4) feature
  ///
  /// In en, this message translates to:
  /// **'4. IP & port check'**
  String get titleFeatureIpPort;

  /// Features screen: description of the IP and port flagging (layer 4) feature
  ///
  /// In en, this message translates to:
  /// **'Flags links pointing directly to raw IP addresses or non-standard HTTP/HTTPS network ports designed to bypass firewalls.'**
  String get descFeatureIpPort;

  /// Features screen: highlight chip 1 of the IP and port flagging (layer 4) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Raw IP Traps'**
  String get labelFeatureIpPortChip1;

  /// Features screen: highlight chip 2 of the IP and port flagging (layer 4) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Non-Standard Ports'**
  String get labelFeatureIpPortChip2;

  /// Features screen: highlight chip 3 of the IP and port flagging (layer 4) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Embedded Userinfo'**
  String get labelFeatureIpPortChip3;

  /// Features screen: title of the online HEAD probing (layer 5) feature
  ///
  /// In en, this message translates to:
  /// **'5. Online probe'**
  String get titleFeatureHeadProbe;

  /// Features screen: description of the online HEAD probing (layer 5) feature
  ///
  /// In en, this message translates to:
  /// **'Optional opt-in lightweight HTTP HEAD probing to resolve URL shorteners, uncover hidden redirect chains, and verify TLS certificates.'**
  String get descFeatureHeadProbe;

  /// Features screen: highlight chip 1 of the online HEAD probing (layer 5) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Redirect Chains'**
  String get labelFeatureHeadProbeChip1;

  /// Features screen: highlight chip 2 of the online HEAD probing (layer 5) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Shortener Unrolling'**
  String get labelFeatureHeadProbeChip2;

  /// Features screen: highlight chip 3 of the online HEAD probing (layer 5) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Opt-In Privacy'**
  String get labelFeatureHeadProbeChip3;

  /// Features screen: title of the Google Safe Browsing (layer 6) feature
  ///
  /// In en, this message translates to:
  /// **'6. Safe Browsing'**
  String get titleFeatureSafeBrowsing;

  /// Features screen: description of the Google Safe Browsing (layer 6) feature
  ///
  /// In en, this message translates to:
  /// **'Optional cloud threat intelligence against millions of known malicious URLs, malware distribution hubs, and social engineering sites.'**
  String get descFeatureSafeBrowsing;

  /// Features screen: highlight chip 1 of the Google Safe Browsing (layer 6) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Google Threat DB'**
  String get labelFeatureSafeBrowsingChip1;

  /// Features screen: highlight chip 2 of the Google Safe Browsing (layer 6) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Local Key Storage'**
  String get labelFeatureSafeBrowsingChip2;

  /// Features screen: highlight chip 3 of the Google Safe Browsing (layer 6) feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Daily Quota Meter'**
  String get labelFeatureSafeBrowsingChip3;

  /// Features screen: title of the QuishingGuard fake sticker check feature
  ///
  /// In en, this message translates to:
  /// **'QuishingGuard™'**
  String get titleFeatureQuishingGuard;

  /// Features screen: description of QuishingGuard, a reminder to check printed QR codes for fake stickers by hand (the app does not analyse the image)
  ///
  /// In en, this message translates to:
  /// **'Reminds you to check printed QR codes for fake stickers before you open a link or pay. It gives you quick checks to do by hand; it does not examine the picture.'**
  String get descFeatureQuishingGuard;

  /// Features screen: QuishingGuard chip 1 (fake stickers)
  ///
  /// In en, this message translates to:
  /// **'Fake stickers'**
  String get labelFeatureQuishingGuardChip1;

  /// Features screen: QuishingGuard chip 2 (checks done by hand)
  ///
  /// In en, this message translates to:
  /// **'Hand checks'**
  String get labelFeatureQuishingGuardChip2;

  /// Features screen: QuishingGuard chip 3 (payment safety tips)
  ///
  /// In en, this message translates to:
  /// **'Payment tips'**
  String get labelFeatureQuishingGuardChip3;

  /// Features screen: title of the AR CodeVision feature
  ///
  /// In en, this message translates to:
  /// **'AR CodeVision™'**
  String get titleFeatureArCodeVision;

  /// Features screen: description of the AR CodeVision feature
  ///
  /// In en, this message translates to:
  /// **'Augmented Reality multi-barcode scanner displaying floating interactive chips over all detected codes with live safety badges and batch selection.'**
  String get descFeatureArCodeVision;

  /// Features screen: highlight chip 1 of the AR CodeVision feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Spatial Tracking'**
  String get labelFeatureArCodeVisionChip1;

  /// Features screen: highlight chip 2 of the AR CodeVision feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Multi-Code HUD'**
  String get labelFeatureArCodeVisionChip2;

  /// Features screen: highlight chip 3 of the AR CodeVision feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Batch Select'**
  String get labelFeatureArCodeVisionChip3;

  /// Features screen: title of the AirQR feature
  ///
  /// In en, this message translates to:
  /// **'AirQR™ transfer'**
  String get titleFeatureAirQr;

  /// Features screen: description of the AirQR feature
  ///
  /// In en, this message translates to:
  /// **'High-speed animated strobe QR transmitter & receiver pipeline transferring encrypted text, files, and keys completely offline without Wi-Fi or Bluetooth.'**
  String get descFeatureAirQr;

  /// Features screen: highlight chip 1 of the AirQR feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Animated Strobe QR'**
  String get labelFeatureAirQrChip1;

  /// Features screen: highlight chip 2 of the AirQR feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Reed-Solomon FEC'**
  String get labelFeatureAirQrChip2;

  /// Features screen: highlight chip 3 of the AirQR feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'100% Offline Air-Gap'**
  String get labelFeatureAirQrChip3;

  /// Features screen: title of the StegoQR feature
  ///
  /// In en, this message translates to:
  /// **'StegoQR™ scanner'**
  String get titleFeatureStegoQr;

  /// Features screen: description of the StegoQR feature
  ///
  /// In en, this message translates to:
  /// **'Discovers and extracts hidden encrypted payloads and watermarked data layers invisibly embedded within custom QR codes.'**
  String get descFeatureStegoQr;

  /// Features screen: highlight chip 1 of the StegoQR feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Decoy QR Parsing'**
  String get labelFeatureStegoQrChip1;

  /// Features screen: highlight chip 2 of the StegoQR feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'AES Decryption'**
  String get labelFeatureStegoQrChip2;

  /// Features screen: highlight chip 3 of the StegoQR feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Biometric Auth'**
  String get labelFeatureStegoQrChip3;

  /// Features screen: title of the Wi-Fi auto connect feature
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi auto connect'**
  String get titleFeatureWifi;

  /// Features screen: description of the Wi-Fi auto connect feature
  ///
  /// In en, this message translates to:
  /// **'Parses WPA/WPA2/WPA3 network credentials, displays network info, copies passwords, and opens Wi-Fi settings in 1 tap.'**
  String get descFeatureWifi;

  /// Features screen: highlight chip 1 of the Wi-Fi auto connect feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'WPA3 & WPA2'**
  String get labelFeatureWifiChip1;

  /// Features screen: highlight chip 2 of the Wi-Fi auto connect feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'1-Tap Connect'**
  String get labelFeatureWifiChip2;

  /// Features screen: highlight chip 3 of the Wi-Fi auto connect feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Password Reveal/Copy'**
  String get labelFeatureWifiChip3;

  /// Features screen: title of the UPI and crypto payments feature
  ///
  /// In en, this message translates to:
  /// **'UPI & crypto pay'**
  String get titleFeaturePayments;

  /// Features screen: description of the UPI and crypto payments feature
  ///
  /// In en, this message translates to:
  /// **'Parses Indian UPI QR codes (dispatching to GPay, PhonePe, Paytm) and Bitcoin/Ethereum/Solana crypto payment addresses with amount detection.'**
  String get descFeaturePayments;

  /// Features screen: highlight chip 1 of the UPI and crypto payments feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'UPI App Dispatch'**
  String get labelFeaturePaymentsChip1;

  /// Features screen: highlight chip 2 of the UPI and crypto payments feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Crypto Wallets'**
  String get labelFeaturePaymentsChip2;

  /// Features screen: highlight chip 3 of the UPI and crypto payments feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'SEPA Transfer'**
  String get labelFeaturePaymentsChip3;

  /// Features screen: title of the TOTP authenticator feature
  ///
  /// In en, this message translates to:
  /// **'TOTP authenticator'**
  String get titleFeatureTotp;

  /// Features screen: description of the TOTP authenticator feature
  ///
  /// In en, this message translates to:
  /// **'Scans 2FA setup codes, renders live rolling 6-digit OTP passcodes with circular countdown timers, and imports into authenticator apps.'**
  String get descFeatureTotp;

  /// Features screen: highlight chip 1 of the TOTP authenticator feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Live Passcodes'**
  String get labelFeatureTotpChip1;

  /// Features screen: highlight chip 2 of the TOTP authenticator feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Visual Countdown'**
  String get labelFeatureTotpChip2;

  /// Features screen: highlight chip 3 of the TOTP authenticator feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'App Importer'**
  String get labelFeatureTotpChip3;

  /// Features screen: title of the contacts and vCard feature
  ///
  /// In en, this message translates to:
  /// **'Contacts & vCard'**
  String get titleFeatureContacts;

  /// Features screen: description of the contacts and vCard feature
  ///
  /// In en, this message translates to:
  /// **'Parses vCard 2.1/3.0/4.0 and MeCard contact barcodes with 1-tap phone dialing, email composition, and saving to your address book.'**
  String get descFeatureContacts;

  /// Features screen: highlight chip 1 of the contacts and vCard feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'vCard 4.0'**
  String get labelFeatureContactsChip1;

  /// Features screen: highlight chip 2 of the contacts and vCard feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'1-Tap Save'**
  String get labelFeatureContactsChip2;

  /// Features screen: highlight chip 3 of the contacts and vCard feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Direct Call & Email'**
  String get labelFeatureContactsChip3;

  /// Features screen: title of the calendar events feature
  ///
  /// In en, this message translates to:
  /// **'Calendar events'**
  String get titleFeatureCalendar;

  /// Features screen: description of the calendar events feature
  ///
  /// In en, this message translates to:
  /// **'Reads iCalendar VEVENT formats with start/end time ranges, locations, and descriptions, adding them directly to your device calendar.'**
  String get descFeatureCalendar;

  /// Features screen: highlight chip 1 of the calendar events feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'iCal Parsing'**
  String get labelFeatureCalendarChip1;

  /// Features screen: highlight chip 2 of the calendar events feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Start/End Time'**
  String get labelFeatureCalendarChip2;

  /// Features screen: highlight chip 3 of the calendar events feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Device Calendar Add'**
  String get labelFeatureCalendarChip3;

  /// Features screen: title of the geo location feature
  ///
  /// In en, this message translates to:
  /// **'Location & maps'**
  String get titleFeatureGeo;

  /// Features screen: description of the geo location feature
  ///
  /// In en, this message translates to:
  /// **'Parses geo: coordinates and search queries, offering instant navigation directions via Google Maps.'**
  String get descFeatureGeo;

  /// Features screen: highlight chip 1 of the geo location feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Lat/Long Parsing'**
  String get labelFeatureGeoChip1;

  /// Features screen: highlight chip 2 of the geo location feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Google Maps Link'**
  String get labelFeatureGeoChip2;

  /// Features screen: highlight chip 3 of the geo location feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Search Queries'**
  String get labelFeatureGeoChip3;

  /// Features screen: title of the scan history feature
  ///
  /// In en, this message translates to:
  /// **'Offline scan history'**
  String get titleFeatureScanHistory;

  /// Features screen: description of the scan history feature
  ///
  /// In en, this message translates to:
  /// **'Stores every scan locally with payload categorization, safety scores, timestamp tracking, favorite stars, and real-time full-text search.'**
  String get descFeatureScanHistory;

  /// Features screen: highlight chip 1 of the scan history feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Full-Text Search'**
  String get labelFeatureScanHistoryChip1;

  /// Features screen: highlight chip 2 of the scan history feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Category Filtering'**
  String get labelFeatureScanHistoryChip2;

  /// Features screen: highlight chip 3 of the scan history feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Favorite Stars'**
  String get labelFeatureScanHistoryChip3;

  /// Features screen: title of the backups feature
  ///
  /// In en, this message translates to:
  /// **'JSON & CSV backups'**
  String get titleFeatureBackups;

  /// Features screen: description of the backups feature
  ///
  /// In en, this message translates to:
  /// **'Export your complete scan history to standard CSV spreadsheets or encrypted JSON backup files with one-click restore.'**
  String get descFeatureBackups;

  /// Features screen: highlight chip 1 of the backups feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'CSV Spreadsheet'**
  String get labelFeatureBackupsChip1;

  /// Features screen: highlight chip 2 of the backups feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'JSON Backup'**
  String get labelFeatureBackupsChip2;

  /// Features screen: highlight chip 3 of the backups feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'One-Click Restore'**
  String get labelFeatureBackupsChip3;

  /// Features screen: title of the biometric and screen guard feature
  ///
  /// In en, this message translates to:
  /// **'App & screen lock'**
  String get titleFeatureBiometricGuard;

  /// Features screen: description of the biometric and screen guard feature
  ///
  /// In en, this message translates to:
  /// **'Optional app lock with fingerprint, face or your screen lock. Screens that show scans, history, secrets or API keys block screenshots and screen recording (FLAG_SECURE). You can turn this off in Settings › Privacy & probing. Hidden StegoQR messages can also ask for biometrics.'**
  String get descFeatureBiometricGuard;

  /// Features screen: highlight chip 1 of the biometric and screen guard feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Biometric Prompt'**
  String get labelFeatureBiometricGuardChip1;

  /// Features screen: highlight chip 2 of the biometric and screen guard feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Screenshot Guard'**
  String get labelFeatureBiometricGuardChip2;

  /// Features screen: highlight chip 3 of the biometric and screen guard feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Encrypted Storage'**
  String get labelFeatureBiometricGuardChip3;

  /// Features screen: title of the offline privacy feature
  ///
  /// In en, this message translates to:
  /// **'100% offline privacy'**
  String get titleFeatureOfflinePrivacy;

  /// Features screen: description of the offline privacy feature
  ///
  /// In en, this message translates to:
  /// **'Scans, decodes, and analyzes barcodes completely on your phone without sending any data to external servers by default.'**
  String get descFeatureOfflinePrivacy;

  /// Features screen: highlight chip 1 of the offline privacy feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'No Telemetry'**
  String get labelFeatureOfflinePrivacyChip1;

  /// Features screen: highlight chip 2 of the offline privacy feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Zero Ads'**
  String get labelFeatureOfflinePrivacyChip2;

  /// Features screen: highlight chip 3 of the offline privacy feature (max 22 characters)
  ///
  /// In en, this message translates to:
  /// **'Open-Source Safety'**
  String get labelFeatureOfflinePrivacyChip3;

  /// Heading of the card at the top of the Help hub
  ///
  /// In en, this message translates to:
  /// **'How to use this app'**
  String get helpCenterHeaderTitle;

  /// Text under the heading at the top of the Help hub
  ///
  /// In en, this message translates to:
  /// **'Simple guides for every part of the app. Pick a topic to see what it does and how to use it.'**
  String get helpCenterHeaderSubtitle;

  /// Button to open the manual decryption tool
  ///
  /// In en, this message translates to:
  /// **'Decrypt Payload'**
  String get actionDecryptPayload;

  /// Title of manual decryption dialog
  ///
  /// In en, this message translates to:
  /// **'Decrypt content'**
  String get titleDecryptPayload;

  /// Description in the manual decryption dialog
  ///
  /// In en, this message translates to:
  /// **'Enter the passphrase or session code to decrypt this ciphertext payload.'**
  String get descDecryptPayload;

  /// Label for cipher mode selector
  ///
  /// In en, this message translates to:
  /// **'Cipher Mode'**
  String get labelCipherMode;

  /// Cipher mode auto-detection option
  ///
  /// In en, this message translates to:
  /// **'Auto / Standard'**
  String get labelCipherModeAuto;

  /// Cipher mode AES-GCM option
  ///
  /// In en, this message translates to:
  /// **'AES-256-GCM (PBKDF2)'**
  String get labelCipherModeAesGcm;

  /// Cipher mode AES-CBC option
  ///
  /// In en, this message translates to:
  /// **'AES-256-CBC'**
  String get labelCipherModeAesCbc;

  /// Label for AirQR session code input
  ///
  /// In en, this message translates to:
  /// **'Session Code / Key'**
  String get labelAirQrCode;

  /// Hint for AirQR session code input
  ///
  /// In en, this message translates to:
  /// **'e.g. ABC-DEF'**
  String get helpAirQrCode;

  /// Title when an AirQR optical payload is detected
  ///
  /// In en, this message translates to:
  /// **'AirQR transfer'**
  String get titleAirQrDetected;

  /// Subtitle when an AirQR optical payload is detected
  ///
  /// In en, this message translates to:
  /// **'This QR code carries an encrypted optical transfer. Enter the session code shown on the sending device to unlock.'**
  String get bodyAirQrDetected;

  /// Title when an encrypted JSON container is detected
  ///
  /// In en, this message translates to:
  /// **'Encrypted JSON'**
  String get titleJsonEnvelopeDetected;

  /// Subtitle when an encrypted JSON container is detected
  ///
  /// In en, this message translates to:
  /// **'This QR code contains an encrypted JSON container. Enter the passphrase to decrypt.'**
  String get bodyJsonEnvelopeDetected;

  /// Label above decrypted content
  ///
  /// In en, this message translates to:
  /// **'Decrypted Content:'**
  String get labelDecryptedContent;

  /// Error message when manual decryption fails
  ///
  /// In en, this message translates to:
  /// **'Decryption failed. Please verify the passphrase or cipher settings.'**
  String get errorManualDecryptionFailed;

  /// Header label on the email action card
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get titleEmailCard;

  /// Button that opens the default email app to compose a message
  ///
  /// In en, this message translates to:
  /// **'Send Email'**
  String get actionEmailSend;

  /// Button that copies the email address to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get actionEmailCopy;

  /// Error when the email app cannot be launched
  ///
  /// In en, this message translates to:
  /// **'Could not open email app. Copy the address and open your email app manually.'**
  String get errorEmailLaunchFailed;

  /// Label for the email subject field on the action card
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get labelEmailSubject;

  /// Label for the email body preview on the action card
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get labelEmailBody;

  /// Header label on the phone action card
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get titlePhoneCard;

  /// Button that opens the phone dialer with the number
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get actionPhoneCall;

  /// Button that copies the phone number to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get actionPhoneCopy;

  /// Error when the phone dialer cannot be launched
  ///
  /// In en, this message translates to:
  /// **'Could not open the phone dialer. Copy the number and dial manually.'**
  String get errorPhoneLaunchFailed;

  /// Header label on the SMS action card
  ///
  /// In en, this message translates to:
  /// **'Text Message'**
  String get titleSmsCard;

  /// Button that opens the messaging app with the number and body
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get actionSmsSend;

  /// Button that copies the SMS recipient number to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get actionSmsCopy;

  /// Error when the messaging app cannot be launched
  ///
  /// In en, this message translates to:
  /// **'Could not open the messaging app. Copy the number and message manually.'**
  String get errorSmsLaunchFailed;

  /// Label for the SMS body preview on the action card
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get labelSmsBody;

  /// Header label on the app deep link action card
  ///
  /// In en, this message translates to:
  /// **'App Link'**
  String get titleAppLinkCard;

  /// Button that opens the deep link in its native app
  ///
  /// In en, this message translates to:
  /// **'Open in App'**
  String get actionAppLinkOpen;

  /// Error when the app deep link cannot be launched
  ///
  /// In en, this message translates to:
  /// **'Could not open this app link. The app may not be installed.'**
  String get errorAppLinkLaunchFailed;

  /// Header label on the product barcode action card
  ///
  /// In en, this message translates to:
  /// **'Product Barcode'**
  String get titleProductBarcodeCard;

  /// Button that searches the barcode on Open Food Facts
  ///
  /// In en, this message translates to:
  /// **'Food Info'**
  String get actionProductSearchFood;

  /// Button that searches the barcode on Google
  ///
  /// In en, this message translates to:
  /// **'Search Web'**
  String get actionProductSearchWeb;

  /// Button that copies the barcode number to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy Barcode'**
  String get actionProductCopy;

  /// Error when the product search URL cannot be launched
  ///
  /// In en, this message translates to:
  /// **'Could not open product search. Try copying the barcode and searching manually.'**
  String get errorProductLaunchFailed;

  /// Header label on the ISBN book action card
  ///
  /// In en, this message translates to:
  /// **'Book (ISBN)'**
  String get titleIsbnCard;

  /// Button that looks up the ISBN on Google Books
  ///
  /// In en, this message translates to:
  /// **'Google Books'**
  String get actionIsbnGoogleBooks;

  /// Button that looks up the ISBN on Open Library
  ///
  /// In en, this message translates to:
  /// **'Open Library'**
  String get actionIsbnOpenLibrary;

  /// Button that copies the ISBN to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy ISBN'**
  String get actionIsbnCopy;

  /// Error when the book lookup URL cannot be launched
  ///
  /// In en, this message translates to:
  /// **'Could not open book lookup. Try copying the ISBN and searching manually.'**
  String get errorIsbnLaunchFailed;

  /// History filter chip label for email scan records
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get labelHistoryFilterEmail;

  /// History filter chip label for phone scan records
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get labelHistoryFilterPhone;

  /// History filter chip label for SMS scan records
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get labelHistoryFilterSms;

  /// History filter chip label for app link scan records
  ///
  /// In en, this message translates to:
  /// **'App Link'**
  String get labelHistoryFilterAppLink;

  /// History filter chip label for product barcode scan records
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get labelHistoryFilterProductBarcode;

  /// History filter chip label for ISBN book scan records
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get labelHistoryFilterIsbn;

  /// Tooltip and status label when the camera flash is off
  ///
  /// In en, this message translates to:
  /// **'Flash: Off'**
  String get tooltipScanFlashOff;

  /// Tooltip and status label when the camera flash is on
  ///
  /// In en, this message translates to:
  /// **'Flash: On'**
  String get tooltipScanFlashOn;

  /// Tooltip and status label when the camera flash is in automatic ambient mode
  ///
  /// In en, this message translates to:
  /// **'Flash: Auto'**
  String get tooltipScanFlashAuto;

  /// Chip label showing auto flash is active with measured ambient lux
  ///
  /// In en, this message translates to:
  /// **'Auto Flash Active ({lux} lux)'**
  String bodyScanFlashAutoActive(String lux);

  /// Tooltip for camera tuning button in the scanner toolbar
  ///
  /// In en, this message translates to:
  /// **'Camera adjustments'**
  String get tooltipCameraTune;

  /// Header title of the camera adjustments panel
  ///
  /// In en, this message translates to:
  /// **'Camera Adjustments'**
  String get titleCameraTune;

  /// Label for camera brightness adjustment slider
  ///
  /// In en, this message translates to:
  /// **'Brightness'**
  String get labelCameraBrightness;

  /// Label for camera contrast adjustment slider
  ///
  /// In en, this message translates to:
  /// **'Contrast'**
  String get labelCameraContrast;

  /// Switch label for inverted/white-on-black barcode scanning
  ///
  /// In en, this message translates to:
  /// **'Invert colors'**
  String get labelCameraInvert;

  /// Explanation text below the invert colors toggle
  ///
  /// In en, this message translates to:
  /// **'Optimized for white QR codes on dark screens or metal'**
  String get descCameraInvert;

  /// Label for camera capture resolution preset selector
  ///
  /// In en, this message translates to:
  /// **'Camera Resolution'**
  String get labelCameraResolution;

  /// Resolution preset option for 1080p
  ///
  /// In en, this message translates to:
  /// **'1080p, recommended'**
  String get tooltipCameraResolutionFullHd;

  /// Resolution preset option for maximum available resolution
  ///
  /// In en, this message translates to:
  /// **'Maximum (4K UHD)'**
  String get tooltipCameraResolutionMax;

  /// Resolution preset option for 720p
  ///
  /// In en, this message translates to:
  /// **'720p, saves battery'**
  String get tooltipCameraResolutionHd;

  /// Button label to reset brightness and contrast to factory defaults
  ///
  /// In en, this message translates to:
  /// **'Reset Adjustments'**
  String get actionCameraReset;

  /// Title for the Language settings card
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get labelSettingsLanguage;

  /// Option to follow device system language
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get labelLanguageSystemDefault;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get labelLanguageEnglish;

  /// Malayalam language option endonym
  ///
  /// In en, this message translates to:
  /// **'മലയാളം'**
  String get labelLanguageMalayalam;

  /// Sanskrit language option endonym
  ///
  /// In en, this message translates to:
  /// **'संस्कृतम्'**
  String get labelLanguageSanskrit;

  /// Copyright notice on the About screen
  ///
  /// In en, this message translates to:
  /// **'© {year} Sreeraj P. All rights reserved.'**
  String bodyAboutCopyright(String year);

  /// Tooltip for camera flash button
  ///
  /// In en, this message translates to:
  /// **'Toggle flash'**
  String get tooltipToggleFlash;

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
  /// **'Show or hide secret'**
  String get tooltipToggleSecretVisibility;

  /// Checkbox label to include scan history in optical sync
  ///
  /// In en, this message translates to:
  /// **'History ({count})'**
  String labelAirQrSyncIncludeHistory(int count);

  /// Checkbox label to include app settings in optical sync
  ///
  /// In en, this message translates to:
  /// **'Include app settings'**
  String get labelAirQrSyncIncludeSettings;

  /// Label for sync passphrase input field
  ///
  /// In en, this message translates to:
  /// **'Passphrase / PIN'**
  String get labelAirQrSyncPassphrase;

  /// Hint for sync passphrase input field
  ///
  /// In en, this message translates to:
  /// **'Enter PIN or passphrase to encrypt'**
  String get helpAirQrSyncPassphrase;

  /// Button to generate a random 6-digit sync PIN
  ///
  /// In en, this message translates to:
  /// **'Generate PIN'**
  String get tooltipAirQrSyncGeneratePin;

  /// Warning shown when neither history nor settings are selected for sync
  ///
  /// In en, this message translates to:
  /// **'Select at least history or settings to sync.'**
  String get errorAirQrSyncNoData;

  /// Title when an AirQR optical sync package is received
  ///
  /// In en, this message translates to:
  /// **'AirQR sync package'**
  String get titleAirQrSyncPackage;

  /// Summary of detected sync package contents
  ///
  /// In en, this message translates to:
  /// **'Contains {records} scan records and app configuration'**
  String bodyAirQrSyncPackageSummary(int records);

  /// Prompt to enter decryption passphrase for sync package
  ///
  /// In en, this message translates to:
  /// **'Sync passphrase'**
  String get labelAirQrSyncEnterPassphrase;

  /// Checkbox to restore scan history from sync package
  ///
  /// In en, this message translates to:
  /// **'Restore scan history'**
  String get labelAirQrSyncRestoreHistory;

  /// Checkbox to apply app settings from sync package
  ///
  /// In en, this message translates to:
  /// **'Apply app settings'**
  String get labelAirQrSyncApplySettings;

  /// Button to decrypt and apply received sync package
  ///
  /// In en, this message translates to:
  /// **'Decrypt & Sync'**
  String get actionAirQrSyncDecrypt;

  /// Notification shown when device sync finishes successfully
  ///
  /// In en, this message translates to:
  /// **'Successfully synced {count} records and updated settings!'**
  String bodyAirQrSyncSuccess(int count);

  /// Action button in export dialog to beam history via AirQR
  ///
  /// In en, this message translates to:
  /// **'Beam via AirQR'**
  String get actionAirQrSyncBeam;

  /// Title of AirQR device sync item in settings
  ///
  /// In en, this message translates to:
  /// **'AirQR Optical Sync'**
  String get titleAirQrSyncSettings;

  /// Subtitle explaining AirQR device sync item in settings
  ///
  /// In en, this message translates to:
  /// **'Beam history & settings air-gapped to another phone'**
  String get descAirQrSyncSettings;

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
  String get titleCodeForge;

  /// Subtitle describing the CodeForge studio
  ///
  /// In en, this message translates to:
  /// **'Barcode & QR Studio'**
  String get labelCodeForgeSubtitle;

  /// Preset chip for plain text payload
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get labelCodeForgePresetText;

  /// Helper hint text suggesting optimal text length for QR code creation
  ///
  /// In en, this message translates to:
  /// **'Keep text concise for clear and reliable scanning (up to 500 characters)'**
  String get helpCodeForgeText;

  /// Button label to pick and load text from a file into CodeForge
  ///
  /// In en, this message translates to:
  /// **'Read from file'**
  String get actionCodeForgeLoadFromFile;

  /// Tooltip for read from file button
  ///
  /// In en, this message translates to:
  /// **'Read text from file'**
  String get tooltipCodeForgeLoadFromFile;

  /// Error message when the selected text file is empty
  ///
  /// In en, this message translates to:
  /// **'The selected file is empty.'**
  String get errorCodeForgeFileEmpty;

  /// Notice shown when file text exceeds 500 characters and is trimmed for single QR code sharing
  ///
  /// In en, this message translates to:
  /// **'Text was trimmed to 500 characters to fit in a single, fast-scanning QR code.'**
  String get bodyCodeForgeFileTruncated;

  /// Confirmation message when text is loaded from a file
  ///
  /// In en, this message translates to:
  /// **'Text loaded from file successfully.'**
  String get bodyCodeForgeFileLoaded;

  /// Error message when file reading fails
  ///
  /// In en, this message translates to:
  /// **'Unable to read the selected file.'**
  String get errorCodeForgeFileReadError;

  /// Preset chip for web link payload
  ///
  /// In en, this message translates to:
  /// **'URL / Link'**
  String get labelCodeForgePresetUrl;

  /// Preset chip for Wi-Fi network payload
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi'**
  String get labelCodeForgePresetWifi;

  /// Preset chip for contact card payload
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get labelCodeForgePresetContact;

  /// Preset chip for UPI payment payload
  ///
  /// In en, this message translates to:
  /// **'UPI Pay'**
  String get labelCodeForgePresetUpi;

  /// Preset chip for SMS text message payload
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get labelCodeForgePresetSms;

  /// Preset chip for email message payload
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get labelCodeForgePresetEmail;

  /// Preset chip for geographic coordinates payload
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get labelCodeForgePresetGeo;

  /// Input field label for Wi-Fi network name
  ///
  /// In en, this message translates to:
  /// **'Network Name (SSID)'**
  String get labelCodeForgeWifiSsid;

  /// Input field label for Wi-Fi password
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get labelCodeForgeWifiPassword;

  /// Label for Wi-Fi security type selector
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get labelCodeForgeWifiSecurity;

  /// Checkbox label for hidden Wi-Fi network
  ///
  /// In en, this message translates to:
  /// **'Hidden Network'**
  String get labelCodeForgeWifiHidden;

  /// Input field label for contact name
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get labelCodeForgeContactName;

  /// Input field label for contact phone
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get labelCodeForgeContactPhone;

  /// Input field label for contact email
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get labelCodeForgeContactEmail;

  /// Input field label for contact organization
  ///
  /// In en, this message translates to:
  /// **'Company / Org'**
  String get labelCodeForgeContactOrg;

  /// Input field label for UPI virtual payment address
  ///
  /// In en, this message translates to:
  /// **'UPI ID / VPA'**
  String get labelCodeForgeUpiVpa;

  /// Input field label for UPI payee name
  ///
  /// In en, this message translates to:
  /// **'Payee Name'**
  String get labelCodeForgeUpiName;

  /// Input field label for UPI amount
  ///
  /// In en, this message translates to:
  /// **'Amount (INR)'**
  String get labelCodeForgeUpiAmount;

  /// Input field label for UPI transaction note
  ///
  /// In en, this message translates to:
  /// **'Transaction Note'**
  String get labelCodeForgeUpiNote;

  /// Input field label for SMS phone number
  ///
  /// In en, this message translates to:
  /// **'Recipient Phone'**
  String get labelCodeForgeSmsPhone;

  /// Input field label for SMS message body
  ///
  /// In en, this message translates to:
  /// **'Message Body'**
  String get labelCodeForgeSmsMessage;

  /// Input field label for email recipient
  ///
  /// In en, this message translates to:
  /// **'Recipient Email'**
  String get labelCodeForgeEmailTo;

  /// Input field label for email subject
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get labelCodeForgeEmailSubject;

  /// Input field label for email body
  ///
  /// In en, this message translates to:
  /// **'Email Body'**
  String get labelCodeForgeEmailBody;

  /// Input field label for geographic latitude
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get labelCodeForgeGeoLat;

  /// Input field label for geographic longitude
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get labelCodeForgeGeoLng;

  /// Button label to auto-fill GPS coordinates from device location
  ///
  /// In en, this message translates to:
  /// **'Use My Location'**
  String get actionCodeForgeGeoUseMyLocation;

  /// Loading text shown while fetching GPS coordinates
  ///
  /// In en, this message translates to:
  /// **'Getting location…'**
  String get labelCodeForgeGeoFetching;

  /// Error message when GPS location fetch fails
  ///
  /// In en, this message translates to:
  /// **'Could not get location'**
  String get errorCodeForgeGeoFailed;

  /// Error message when user denies location permission
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get errorCodeForgeGeoPermissionDenied;

  /// Header for QR code visual design customization studio
  ///
  /// In en, this message translates to:
  /// **'Design & Structure'**
  String get titleCodeForgeDesignStudio;

  /// Selector label for outer finder pattern corner shape
  ///
  /// In en, this message translates to:
  /// **'Corner Eye Shape'**
  String get titleCodeForgeEyeShape;

  /// Selector label for inner finder pattern pupil shape
  ///
  /// In en, this message translates to:
  /// **'Inner Eye Pupil'**
  String get titleCodeForgeEyeBallShape;

  /// Selector label for data module dot shape
  ///
  /// In en, this message translates to:
  /// **'Data Module Pattern'**
  String get titleCodeForgePatternShape;

  /// Shape option: standard square
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get labelCodeForgeShapeSquare;

  /// Shape option: circular dots
  ///
  /// In en, this message translates to:
  /// **'Dots'**
  String get labelCodeForgeShapeDots;

  /// Shape option: rounded rectangle
  ///
  /// In en, this message translates to:
  /// **'Rounded'**
  String get labelCodeForgeShapeRounded;

  /// Shape option: classy curved corners
  ///
  /// In en, this message translates to:
  /// **'Classy'**
  String get labelCodeForgeShapeClassy;

  /// Shape option: rotated diamond
  ///
  /// In en, this message translates to:
  /// **'Diamond'**
  String get labelCodeForgeShapeDiamond;

  /// Shape option: organic leaf corner
  ///
  /// In en, this message translates to:
  /// **'Leaf'**
  String get labelCodeForgeShapeLeaf;

  /// Shape option: circular ring
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get labelCodeForgeShapeCircle;

  /// Section header for color palette and gradient studio
  ///
  /// In en, this message translates to:
  /// **'Colors & Gradients'**
  String get titleCodeForgeColorStudio;

  /// Label for barcode foreground color
  ///
  /// In en, this message translates to:
  /// **'Foreground'**
  String get titleCodeForgeFgColor;

  /// Label for barcode background color
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get titleCodeForgeBgColor;

  /// Gradient option: solid color without gradient
  ///
  /// In en, this message translates to:
  /// **'Solid Color'**
  String get labelCodeForgeGradientNone;

  /// Gradient theme: warm sunset
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get labelCodeForgeGradientSunset;

  /// Gradient theme: cool ocean blue
  ///
  /// In en, this message translates to:
  /// **'Ocean'**
  String get labelCodeForgeGradientOcean;

  /// Gradient theme: vibrant cyan neon
  ///
  /// In en, this message translates to:
  /// **'Neon'**
  String get labelCodeForgeGradientNeon;

  /// Gradient theme: warm royal gold
  ///
  /// In en, this message translates to:
  /// **'Royal Gold'**
  String get labelCodeForgeGradientGold;

  /// Selector label for QR error correction level
  ///
  /// In en, this message translates to:
  /// **'Error Correction'**
  String get titleCodeForgeErrorCorrection;

  /// Selector label for center embedded logo/badge
  ///
  /// In en, this message translates to:
  /// **'Center Badge'**
  String get titleCodeForgeCenterBadge;

  /// Badge option: no center icon
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get labelCodeForgeBadgeNone;

  /// Badge option: icon matching the payload type
  ///
  /// In en, this message translates to:
  /// **'Content Icon'**
  String get labelCodeForgeBadgeIcon;

  /// Badge option: safety verified shield emblem
  ///
  /// In en, this message translates to:
  /// **'Verified Shield'**
  String get labelCodeForgeBadgeShield;

  /// Button to export and share high-resolution PNG image
  ///
  /// In en, this message translates to:
  /// **'Share PNG'**
  String get actionCodeForgeExportPng;

  /// Button to export and share vector SVG file
  ///
  /// In en, this message translates to:
  /// **'Share SVG'**
  String get actionCodeForgeExportSvg;

  /// Tooltip of the CodeForge app bar share icon; it opens a menu with Share PNG and Share SVG
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get tooltipCodeForgeShare;

  /// Button to copy raw barcode content to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy Content'**
  String get tooltipCodeForgeCopyPayload;

  /// Toast message after copying barcode content
  ///
  /// In en, this message translates to:
  /// **'Barcode content copied to clipboard'**
  String get bodyCodeForgeCopied;

  /// Badge label shown when URL passes all safety checks
  ///
  /// In en, this message translates to:
  /// **'Verified Safe by 6-Layer Security Engine'**
  String get bodyCodeForgeSafeVerified;

  /// Action tooltip to reset visual styling to defaults
  ///
  /// In en, this message translates to:
  /// **'Reset Styling'**
  String get tooltipCodeForgeResetStyle;

  /// Checkbox to show human-readable text under 1D barcodes
  ///
  /// In en, this message translates to:
  /// **'Show Text Label'**
  String get labelCodeForgeIncludeText;

  /// Header for live code preview card
  ///
  /// In en, this message translates to:
  /// **'Live Preview'**
  String get titleCodeForgePreview;

  /// Button to skip onboarding and proceed directly to scanner
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get actionOnboardingSkip;

  /// Button to advance to next onboarding slide
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get actionOnboardingNext;

  /// Button on final onboarding slide to finish and enter scanner
  ///
  /// In en, this message translates to:
  /// **'Start Scanning'**
  String get actionOnboardingGetStarted;

  /// Badge tag for 6-layer URL safety engine slide
  ///
  /// In en, this message translates to:
  /// **'6-Layer Security'**
  String get labelOnboardingSlide1Badge;

  /// Title for first onboarding slide explaining URL safety
  ///
  /// In en, this message translates to:
  /// **'6-layer link safety'**
  String get titleOnboardingSlide1;

  /// Description for first onboarding slide explaining URL defense layers
  ///
  /// In en, this message translates to:
  /// **'Every link is inspected across six offline and online defense layers before you open it, protecting you against phishing, malicious redirects, and homograph traps.'**
  String get bodyOnboardingSlide1;

  /// First highlight bullet for URL safety slide
  ///
  /// In en, this message translates to:
  /// **'Protocol & Homograph Shield'**
  String get bodyOnboardingSlide1Bullet1;

  /// Second highlight bullet for URL safety slide
  ///
  /// In en, this message translates to:
  /// **'TLD Entropy & Port Trap Analysis'**
  String get bodyOnboardingSlide1Bullet2;

  /// Third highlight bullet for URL safety slide
  ///
  /// In en, this message translates to:
  /// **'Private Probing & Safe Browsing'**
  String get bodyOnboardingSlide1Bullet3;

  /// Badge tag for the QuishingGuard fake-sticker slide of the welcome tour
  ///
  /// In en, this message translates to:
  /// **'Scam stickers'**
  String get labelOnboardingSlide2Badge;

  /// Title for second onboarding slide explaining QuishingGuard
  ///
  /// In en, this message translates to:
  /// **'Fake sticker check'**
  String get titleOnboardingSlide2;

  /// Description for second onboarding slide explaining the fake sticker check
  ///
  /// In en, this message translates to:
  /// **'Scammers paste fake QR stickers over real ones. When you scan a link or a payment code with the camera, QuishingGuard reminds you what to check before you open it or pay.'**
  String get bodyOnboardingSlide2;

  /// First highlight bullet for QuishingGuard slide
  ///
  /// In en, this message translates to:
  /// **'Feel for raised sticker edges'**
  String get bodyOnboardingSlide2Bullet1;

  /// Second highlight bullet for QuishingGuard slide
  ///
  /// In en, this message translates to:
  /// **'Check the payee name'**
  String get bodyOnboardingSlide2Bullet2;

  /// Third highlight bullet for QuishingGuard slide
  ///
  /// In en, this message translates to:
  /// **'Ask the staff when in doubt'**
  String get bodyOnboardingSlide2Bullet3;

  /// Badge tag for offline privacy model slide
  ///
  /// In en, this message translates to:
  /// **'Zero tracking'**
  String get labelOnboardingSlide3Badge;

  /// Title for third onboarding slide explaining privacy
  ///
  /// In en, this message translates to:
  /// **'100% offline privacy'**
  String get titleOnboardingSlide3;

  /// Description for third onboarding slide explaining offline architecture
  ///
  /// In en, this message translates to:
  /// **'Your scans and personal data never leave your phone. There are no analytics SDKs, no trackers, and no remote servers watching your habits.'**
  String get bodyOnboardingSlide3;

  /// First highlight bullet for offline privacy slide
  ///
  /// In en, this message translates to:
  /// **'Encrypted on-device SQLite database'**
  String get bodyOnboardingSlide3Bullet1;

  /// Second highlight bullet for offline privacy slide
  ///
  /// In en, this message translates to:
  /// **'AirQR optical air-gap transfers'**
  String get bodyOnboardingSlide3Bullet2;

  /// Third highlight bullet for offline privacy slide
  ///
  /// In en, this message translates to:
  /// **'Zero analytics or crash reporting SDKs'**
  String get bodyOnboardingSlide3Bullet3;

  /// Settings and Help option to replay the 3-slide onboarding tour
  ///
  /// In en, this message translates to:
  /// **'Welcome Tour'**
  String get labelSettingsOnboardingTour;

  /// Subtitle describing the welcome tour replay action
  ///
  /// In en, this message translates to:
  /// **'Revisit the 3-slide introduction to safety and privacy features'**
  String get descSettingsOnboardingTour;

  /// Tooltip for toggling continuous batch scan mode
  ///
  /// In en, this message translates to:
  /// **'Batch scan mode'**
  String get tooltipBatchMode;

  /// Toast message displayed when batch scan mode is turned on
  ///
  /// In en, this message translates to:
  /// **'Continuous Batch Scan enabled'**
  String get bodyBatchModeEnabled;

  /// Toast message displayed when batch scan mode is turned off
  ///
  /// In en, this message translates to:
  /// **'Continuous Batch Scan disabled'**
  String get bodyBatchModeDisabled;

  /// Counter badge showing number of barcodes scanned in batch
  ///
  /// In en, this message translates to:
  /// **'{count} Scanned'**
  String labelBatchCounter(int count);

  /// Title of the batch review modal bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Batch Scans'**
  String get labelBatchReview;

  /// Subtitle of the batch review sheet
  ///
  /// In en, this message translates to:
  /// **'Continuous scanning queue'**
  String get descBatchReview;

  /// Title shown when batch queue is empty
  ///
  /// In en, this message translates to:
  /// **'No codes in batch'**
  String get emptyBatchTitle;

  /// Description shown when batch queue is empty
  ///
  /// In en, this message translates to:
  /// **'Point your camera at barcodes to scan them continuously without leaving the camera.'**
  String get emptyBatchBody;

  /// Button to export the batch scans
  ///
  /// In en, this message translates to:
  /// **'Export Batch'**
  String get titleBatchExport;

  /// Button to clear all scans from the active batch
  ///
  /// In en, this message translates to:
  /// **'Clear Batch'**
  String get actionBatchClear;

  /// Confirmation title to clear the batch queue
  ///
  /// In en, this message translates to:
  /// **'Clear Batch?'**
  String get titleBatchClearConfirm;

  /// Confirmation content to clear the batch queue
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove all scanned codes from this batch?'**
  String get bodyBatchClearConfirm;

  /// Label for duplicate prevention toggle in batch review sheet
  ///
  /// In en, this message translates to:
  /// **'Prevent Duplicates'**
  String get labelBatchPreventDuplicates;

  /// Toast message displayed in camera viewport when a barcode is scanned in batch mode
  ///
  /// In en, this message translates to:
  /// **'Scanned #{count}: {content}'**
  String bodyBatchScanned(int count, String content);

  /// Label when 6-layer URL safety check is running in background
  ///
  /// In en, this message translates to:
  /// **'Analyzing link...'**
  String get bodyBatchAnalyzingUrl;

  /// Summary of 6-layer URL safety checks across URLs in batch
  ///
  /// In en, this message translates to:
  /// **'{safeCount} safe, {warningCount} suspicious of {totalUrls} links'**
  String bodyBatchUrlSafetySummary(
    int safeCount,
    int warningCount,
    int totalUrls,
  );

  /// Title of the bottom sheet displaying details of an individual batch scan item
  ///
  /// In en, this message translates to:
  /// **'Scanned Code Details'**
  String get titleBatchItemDetails;

  /// Label for distance-enhanced scanning pipeline toggle in camera settings
  ///
  /// In en, this message translates to:
  /// **'Distance Scan Assist'**
  String get labelCameraDistanceEnhance;

  /// Subtitle describing distance-enhanced scanning pipeline
  ///
  /// In en, this message translates to:
  /// **'Zoom-crop & unsharp mask for distant posters & signs'**
  String get descCameraDistanceEnhance;

  /// Label for unsharp mask sharpness slider in camera settings
  ///
  /// In en, this message translates to:
  /// **'Edge Sharpness'**
  String get labelCameraUnsharp;

  /// Label for the digital zoom slider of Distance Scan Assist in camera settings
  ///
  /// In en, this message translates to:
  /// **'Distance Zoom'**
  String get labelCameraDistanceZoom;

  /// Button and tooltip to scan barcode, URL, or image from system clipboard
  ///
  /// In en, this message translates to:
  /// **'Scan from Clipboard'**
  String get tooltipScanFromClipboard;

  /// Title for quick scan banner when clipboard has scannable content
  ///
  /// In en, this message translates to:
  /// **'Clipboard content detected'**
  String get bodyClipboardBanner;

  /// Action button to trigger scan of detected clipboard content
  ///
  /// In en, this message translates to:
  /// **'Scan Now'**
  String get actionClipboardScan;

  /// Action button to dismiss the clipboard detection banner
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get tooltipClipboardDismiss;

  /// Message shown when clipboard content is not recognized as a barcode, URL, or image
  ///
  /// In en, this message translates to:
  /// **'No scannable link, code, or image found in clipboard'**
  String get errorClipboardNoValidContent;

  /// Type label for detected URL in clipboard
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get labelClipboardTypeUrl;

  /// Type label for detected barcode payload in clipboard
  ///
  /// In en, this message translates to:
  /// **'Barcode Payload'**
  String get labelClipboardTypeBarcode;

  /// Type label for detected image in clipboard
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get labelClipboardTypeImage;

  /// Type label for detected text in clipboard
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get labelClipboardTypeText;

  /// Banner informing the user that multiple barcodes are visible in the viewfinder and prompting them to tap one to scan
  ///
  /// In en, this message translates to:
  /// **'Multiple codes detected. Tap a code to scan.'**
  String get bodyMultiCodeDetected;

  /// Tooltip and action hint for tapping a visible barcode bounding box
  ///
  /// In en, this message translates to:
  /// **'Tap to scan'**
  String get tooltipMultiCodeTapToScan;

  /// Settings title for toggling multi-code detection on the main camera scanner
  ///
  /// In en, this message translates to:
  /// **'Multi-Code Selection'**
  String get labelMultiCodeSelection;

  /// Settings subtitle explaining the multi-code selection behavior
  ///
  /// In en, this message translates to:
  /// **'Outline visible codes and tap to choose when multiple are present'**
  String get descMultiCodeSelection;

  /// Tooltip for dismissing the multi-code selection banner
  ///
  /// In en, this message translates to:
  /// **'Dismiss selection'**
  String get tooltipMultiCodeDismiss;

  /// Title of the GhostScan screen content QR detector feature
  ///
  /// In en, this message translates to:
  /// **'GhostScan'**
  String get labelGhostScan;

  /// Subtitle describing GhostScan capability
  ///
  /// In en, this message translates to:
  /// **'Screen Content QR Detector'**
  String get descGhostScan;

  /// Explanation of how GhostScan scans screen contents without manual screenshots
  ///
  /// In en, this message translates to:
  /// **'Detect and decode QR codes visible on your screen inside any app without taking manual screenshots.'**
  String get bodyGhostScan;

  /// Button to trigger on-demand screen scanning
  ///
  /// In en, this message translates to:
  /// **'Scan Screen Now'**
  String get actionGhostScanNow;

  /// Button to request adding the GhostScan tile to Quick Settings
  ///
  /// In en, this message translates to:
  /// **'Add Settings tile'**
  String get actionGhostScanAddTile;

  /// Toast confirming the tile addition request was sent to the system
  ///
  /// In en, this message translates to:
  /// **'Quick Settings tile request sent'**
  String get bodyGhostScanTileAdded;

  /// Header for step-by-step instructions on using GhostScan
  ///
  /// In en, this message translates to:
  /// **'How to use GhostScan'**
  String get titleGhostScanHowItWorks;

  /// First step for using GhostScan via Quick Settings
  ///
  /// In en, this message translates to:
  /// **'Pull down your Quick Settings notification shade from any app.'**
  String get helpGhostScanStep1;

  /// Second step for using GhostScan via Quick Settings
  ///
  /// In en, this message translates to:
  /// **'Tap the GhostScan tile to capture and decode the screen.'**
  String get helpGhostScanStep2;

  /// Third step for using GhostScan via Quick Settings
  ///
  /// In en, this message translates to:
  /// **'The code is decoded instantly without saving screenshots to your gallery.'**
  String get helpGhostScanStep3;

  /// Status message while processing a captured screen image
  ///
  /// In en, this message translates to:
  /// **'Analyzing screen content...'**
  String get bodyGhostScanAnalyzing;

  /// Help hub group heading for the scanning guides
  ///
  /// In en, this message translates to:
  /// **'Scanning'**
  String get helpGuideGroupScanning;

  /// Help hub group heading for the guides on making and sending codes
  ///
  /// In en, this message translates to:
  /// **'Making and sending codes'**
  String get helpGuideGroupCreate;

  /// Help hub group heading for the safety guides
  ///
  /// In en, this message translates to:
  /// **'Staying safe'**
  String get helpGuideGroupSecurity;

  /// Help hub group heading for the guides on using scanned content
  ///
  /// In en, this message translates to:
  /// **'Using what you scan'**
  String get helpGuideGroupPayloads;

  /// Help hub group heading for the settings guide and FAQ
  ///
  /// In en, this message translates to:
  /// **'Your app and settings'**
  String get helpGuideGroupApp;

  /// Help hub card title for the scanning guide
  ///
  /// In en, this message translates to:
  /// **'Scanning codes'**
  String get helpGuideBarcodeName;

  /// Help hub card summary for the scanning guide
  ///
  /// In en, this message translates to:
  /// **'Scan with the camera, or from photos, PDF files and copied text. Scan many codes in a row.'**
  String get helpGuideBarcodeSummary;

  /// Opening paragraph of the scanning guide
  ///
  /// In en, this message translates to:
  /// **'Point your camera at a code and the app reads it at once. You can also read codes from photos, PDF files and copied text. All reading happens on your phone, with no internet needed.'**
  String get helpGuideBarcodeIntro;

  /// Scanning guide section heading: scanning with the camera
  ///
  /// In en, this message translates to:
  /// **'Scan with the camera'**
  String get helpGuideBarcodeCameraTitle;

  /// Scanning guide: how to scan with the camera
  ///
  /// In en, this message translates to:
  /// **'Open the Scan tab and hold the code inside the frame. The app reads it by itself. You do not need to tap anything.'**
  String get helpGuideBarcodeCameraBullet1;

  /// Scanning guide: list of code types the app can read
  ///
  /// In en, this message translates to:
  /// **'It reads QR codes (also the small Micro QR and rMQR kinds), Data Matrix, Aztec, PDF417 and MaxiCode. It also reads shop and parcel barcodes such as EAN, UPC, Code 128, Code 39, Code 93, Codabar, ITF and DataBar.'**
  String get helpGuideBarcodeCameraBullet2;

  /// Scanning guide: the flash button and its three modes
  ///
  /// In en, this message translates to:
  /// **'Flash: tap the flash button to switch between Off, On and Auto. In Auto, the flash comes on by itself when it is dark.'**
  String get helpGuideBarcodeCameraBullet3;

  /// Scanning guide: the zoom slider
  ///
  /// In en, this message translates to:
  /// **'Zoom: use the zoom slider for small or far-away codes. This works better than moving the phone very close.'**
  String get helpGuideBarcodeCameraBullet4;

  /// Scanning guide: the switch camera button
  ///
  /// In en, this message translates to:
  /// **'Switch camera: change between the back and the front camera.'**
  String get helpGuideBarcodeCameraBullet5;

  /// Scanning guide: pausing and resuming the scanner
  ///
  /// In en, this message translates to:
  /// **'Pause: tap Pause scanning to stop for a moment, and Resume scanning to start again.'**
  String get helpGuideBarcodeCameraBullet6;

  /// Scanning guide section heading: scanning a photo
  ///
  /// In en, this message translates to:
  /// **'Scan a photo or screenshot'**
  String get helpGuideBarcodeGalleryTitle;

  /// Scanning guide: how to scan a photo from the gallery
  ///
  /// In en, this message translates to:
  /// **'Tap the gallery button at the top of the Scan screen and pick a photo or screenshot.'**
  String get helpGuideBarcodeGalleryBullet1;

  /// Scanning guide: the photo picker sees only the chosen picture
  ///
  /// In en, this message translates to:
  /// **'Android\'s own picker opens. The app sees only the one picture you choose.'**
  String get helpGuideBarcodeGalleryBullet2;

  /// Scanning guide: a photo can contain several codes
  ///
  /// In en, this message translates to:
  /// **'If the picture has more than one code, the app finds them all.'**
  String get helpGuideBarcodeGalleryBullet3;

  /// Scanning guide section heading: scanning a PDF file
  ///
  /// In en, this message translates to:
  /// **'Scan a PDF file'**
  String get helpGuideBarcodePdfTitle;

  /// Scanning guide: how to pick a PDF file
  ///
  /// In en, this message translates to:
  /// **'Tap the PDF button and choose a file, such as a ticket, bill or boarding pass.'**
  String get helpGuideBarcodePdfBullet1;

  /// Scanning guide: every page of the PDF is checked
  ///
  /// In en, this message translates to:
  /// **'The app checks every page and lists each code it finds, with its page number.'**
  String get helpGuideBarcodePdfBullet2;

  /// Scanning guide: saving all PDF codes to history
  ///
  /// In en, this message translates to:
  /// **'Tap Save all to keep them all in your history at once.'**
  String get helpGuideBarcodePdfBullet3;

  /// Scanning guide: a PDF can be shared to the app from another app
  ///
  /// In en, this message translates to:
  /// **'You can also share a PDF to this app from another app, such as your email or files app.'**
  String get helpGuideBarcodePdfBullet4;

  /// Scanning guide section heading: scanning copied text or pictures
  ///
  /// In en, this message translates to:
  /// **'Scan copied text or pictures'**
  String get helpGuideBarcodeClipboardTitle;

  /// Scanning guide: the clipboard button
  ///
  /// In en, this message translates to:
  /// **'If you copied a link, a code\'s text or a picture, tap the clipboard button at the top of the Scan screen to check it.'**
  String get helpGuideBarcodeClipboardBullet1;

  /// Scanning guide: the clipboard bar that appears when the app opens
  ///
  /// In en, this message translates to:
  /// **'When you come back to the app with something copied, a small bar may offer to check it. Tap Scan Now, or close the bar.'**
  String get helpGuideBarcodeClipboardBullet2;

  /// Scanning guide: copied links get the same safety check
  ///
  /// In en, this message translates to:
  /// **'Copied links get the same safety check as scanned links.'**
  String get helpGuideBarcodeClipboardBullet3;

  /// Scanning guide section heading: batch scan mode
  ///
  /// In en, this message translates to:
  /// **'Scan many codes in a row'**
  String get helpGuideBarcodeBatchTitle;

  /// Scanning guide: turning on batch mode
  ///
  /// In en, this message translates to:
  /// **'Tap the batch button to turn on batch mode. The camera keeps scanning, and each new code is added to a list.'**
  String get helpGuideBarcodeBatchBullet1;

  /// Scanning guide: the batch counter opens the list
  ///
  /// In en, this message translates to:
  /// **'A counter shows how many codes you have scanned. Tap it to open the list.'**
  String get helpGuideBarcodeBatchBullet2;

  /// Scanning guide: what you can do in the batch list
  ///
  /// In en, this message translates to:
  /// **'In the list you can look at each code, turn on Prevent Duplicates, and export the list as CSV, JSON, text or PDF.'**
  String get helpGuideBarcodeBatchBullet3;

  /// Scanning guide: turning off batch mode
  ///
  /// In en, this message translates to:
  /// **'Tap the batch button again to go back to normal scanning.'**
  String get helpGuideBarcodeBatchBullet4;

  /// Scanning guide section heading: the camera adjustments sheet
  ///
  /// In en, this message translates to:
  /// **'When a code is hard to read'**
  String get helpGuideBarcodeTuneTitle;

  /// Scanning guide: opening camera adjustments
  ///
  /// In en, this message translates to:
  /// **'Tap the Camera adjustments button. Your changes show on the camera picture at once.'**
  String get helpGuideBarcodeTuneBullet1;

  /// Scanning guide: the brightness and contrast sliders
  ///
  /// In en, this message translates to:
  /// **'Brightness and Contrast: make a dark or faded code clearer.'**
  String get helpGuideBarcodeTuneBullet2;

  /// Scanning guide: the invert colors switch
  ///
  /// In en, this message translates to:
  /// **'Invert colors: for a light code on a dark background, such as on a dark screen or on metal.'**
  String get helpGuideBarcodeTuneBullet3;

  /// Scanning guide: the camera resolution choices
  ///
  /// In en, this message translates to:
  /// **'Camera Resolution: 1080p suits most phones. 720p saves battery. Maximum helps with very small codes.'**
  String get helpGuideBarcodeTuneBullet4;

  /// Scanning guide: Distance Scan Assist and its sliders
  ///
  /// In en, this message translates to:
  /// **'Distance Scan Assist: helps read codes far away, such as on posters and signs. Fine-tune it with Distance Zoom and Edge Sharpness.'**
  String get helpGuideBarcodeTuneBullet5;

  /// Scanning guide: Multi-Code Selection
  ///
  /// In en, this message translates to:
  /// **'Multi-Code Selection: when more than one code is in view, each one gets an outline. Tap the one you want.'**
  String get helpGuideBarcodeTuneBullet6;

  /// Scanning guide: the reset adjustments button
  ///
  /// In en, this message translates to:
  /// **'Reset Adjustments puts everything back to normal.'**
  String get helpGuideBarcodeTuneBullet7;

  /// Tip at the end of the scanning guide
  ///
  /// In en, this message translates to:
  /// **'Tip: Codes are read on your phone. Camera pictures are never saved or sent anywhere.'**
  String get helpGuideBarcodeTip;

  /// Help hub card title for the AR CodeVision guide
  ///
  /// In en, this message translates to:
  /// **'AR CodeVision'**
  String get helpGuideArCodeVisionName;

  /// Help hub card summary for the AR CodeVision guide
  ///
  /// In en, this message translates to:
  /// **'See and use many codes at once, right on the camera picture.'**
  String get helpGuideArCodeVisionSummary;

  /// Opening paragraph of the AR CodeVision guide
  ///
  /// In en, this message translates to:
  /// **'AR CodeVision finds every code the camera can see, all at the same time. A small label floats over each code on the screen, so you can see what it is before you tap it.'**
  String get helpGuideArCodeVisionIntro;

  /// AR CodeVision guide section heading: how to open it
  ///
  /// In en, this message translates to:
  /// **'How to open it'**
  String get helpGuideArCodeVisionOpenTitle;

  /// AR CodeVision guide: where to find it in the menu
  ///
  /// In en, this message translates to:
  /// **'On the Scan screen, tap More options (the three dots) and choose AR CodeVision HUD.'**
  String get helpGuideArCodeVisionOpenBullet1;

  /// AR CodeVision guide: allowing the camera
  ///
  /// In en, this message translates to:
  /// **'Allow the camera if Android asks.'**
  String get helpGuideArCodeVisionOpenBullet2;

  /// AR CodeVision guide section heading: the two modes
  ///
  /// In en, this message translates to:
  /// **'The two modes'**
  String get helpGuideArCodeVisionTrackingTitle;

  /// AR CodeVision guide: the Safety mode and its colour badges
  ///
  /// In en, this message translates to:
  /// **'Safety: each link gets a colour badge. Green means no problems were found. Red means the link looks unsafe.'**
  String get helpGuideArCodeVisionTrackingBullet1;

  /// AR CodeVision guide: the Warehouse mode
  ///
  /// In en, this message translates to:
  /// **'Warehouse: shows item details, such as a price tag, and lets you select codes.'**
  String get helpGuideArCodeVisionTrackingBullet2;

  /// AR CodeVision guide section heading: using the floating labels
  ///
  /// In en, this message translates to:
  /// **'Using the labels'**
  String get helpGuideArCodeVisionBatchTitle;

  /// AR CodeVision guide: tapping a label
  ///
  /// In en, this message translates to:
  /// **'Tap a label to see its full content. From there you can copy it, open the link, or select it.'**
  String get helpGuideArCodeVisionBatchBullet1;

  /// AR CodeVision guide: copying many codes in Warehouse mode
  ///
  /// In en, this message translates to:
  /// **'In Warehouse mode, select several codes, then tap Batch Copy to copy them all together. Tap Clear to start again.'**
  String get helpGuideArCodeVisionBatchBullet2;

  /// AR CodeVision guide: the flashlight button
  ///
  /// In en, this message translates to:
  /// **'Tap the flashlight button when it is dark.'**
  String get helpGuideArCodeVisionBatchBullet3;

  /// Tip at the end of the AR CodeVision guide
  ///
  /// In en, this message translates to:
  /// **'Tip: Move the phone slowly. The labels follow the codes as you move.'**
  String get helpGuideArCodeVisionTip;

  /// Help hub card title for the guide on scanning codes shown in other apps
  ///
  /// In en, this message translates to:
  /// **'Scan from other apps'**
  String get helpGuideScanBubbleName;

  /// Help hub card summary for the guide on scanning codes shown in other apps
  ///
  /// In en, this message translates to:
  /// **'Read a code that is on your screen in another app, with GhostScan or the Scan bubble.'**
  String get helpGuideScanBubbleSummary;

  /// Opening paragraph of the guide on scanning codes shown in other apps
  ///
  /// In en, this message translates to:
  /// **'Sometimes a code is on your screen, in a chat, a web page or an email. You can read it without taking a screenshot, in two ways: GhostScan and the Scan bubble. Both read the code on your phone, with no internet.'**
  String get helpGuideScanBubbleIntro;

  /// Section heading: GhostScan, which scans the screen once
  ///
  /// In en, this message translates to:
  /// **'GhostScan: scan the screen once'**
  String get helpGuideScanBubbleGhostTitle;

  /// GhostScan: where to find it
  ///
  /// In en, this message translates to:
  /// **'On the Scan screen, tap More options and choose GhostScan.'**
  String get helpGuideScanBubbleGhostBullet1;

  /// GhostScan: adding the Quick Settings tile
  ///
  /// In en, this message translates to:
  /// **'Tap Add Settings tile to put a GhostScan button in your Quick Settings (the panel you pull down from the top of the screen).'**
  String get helpGuideScanBubbleGhostBullet2;

  /// GhostScan: using the tile from any app
  ///
  /// In en, this message translates to:
  /// **'Then, in any app, pull down Quick Settings and tap the GhostScan tile. The app reads the code on your screen.'**
  String get helpGuideScanBubbleGhostBullet3;

  /// Section heading: how to use the Scan bubble
  ///
  /// In en, this message translates to:
  /// **'How to use the Scan bubble'**
  String get helpGuideScanBubbleUseTitle;

  /// Scan bubble: the ways to turn it on
  ///
  /// In en, this message translates to:
  /// **'Turn it on in Settings > Scan bubble, from the Scan bubble tile in Quick Settings, or by long-pressing the app icon.'**
  String get helpGuideScanBubbleUseBullet1;

  /// Scan bubble: tapping the bubble over another app
  ///
  /// In en, this message translates to:
  /// **'Open any app that shows a QR code or barcode, then tap the bubble.'**
  String get helpGuideScanBubbleUseBullet2;

  /// Scan bubble: Android asks to allow screen capture
  ///
  /// In en, this message translates to:
  /// **'Android asks to allow screen capture. Allow it, and the result opens with the usual safety checks.'**
  String get helpGuideScanBubbleUseBullet3;

  /// Scan bubble: moving it and turning it off
  ///
  /// In en, this message translates to:
  /// **'Drag the bubble to move it. Drag it onto the X at the bottom of the screen to turn it off.'**
  String get helpGuideScanBubbleUseBullet4;

  /// Scan bubble: the Start after restart switch
  ///
  /// In en, this message translates to:
  /// **'Turn on Start after restart if you want the bubble to come back after the phone restarts.'**
  String get helpGuideScanBubbleUseBullet5;

  /// Section heading: privacy of GhostScan and the Scan bubble
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get helpGuideScanBubblePrivacyTitle;

  /// Privacy: the screen is captured only when you ask
  ///
  /// In en, this message translates to:
  /// **'The screen is captured only when you tap the bubble or the GhostScan tile, and Android asks you first.'**
  String get helpGuideScanBubblePrivacyBullet1;

  /// Privacy: the code is read on the phone
  ///
  /// In en, this message translates to:
  /// **'The code is read on your phone. Nothing is sent online for reading.'**
  String get helpGuideScanBubblePrivacyBullet2;

  /// Privacy: the screen picture is deleted after reading
  ///
  /// In en, this message translates to:
  /// **'The screen picture is not saved to your gallery and is deleted right after reading.'**
  String get helpGuideScanBubblePrivacyBullet3;

  /// Section heading: limits of GhostScan and the Scan bubble
  ///
  /// In en, this message translates to:
  /// **'Good to know'**
  String get helpGuideScanBubbleLimitsTitle;

  /// Limits: Android 14 asks on every tap
  ///
  /// In en, this message translates to:
  /// **'On Android 14 and newer, Android asks for screen capture permission on every tap.'**
  String get helpGuideScanBubbleLimitsBullet1;

  /// Limits: some apps block screen capture
  ///
  /// In en, this message translates to:
  /// **'Banking, payment and some video apps block screen capture. Codes inside them cannot be read.'**
  String get helpGuideScanBubbleLimitsBullet2;

  /// Limits: some phones have extra settings that stop the bubble
  ///
  /// In en, this message translates to:
  /// **'Some phones have extra \"pop-up window\" or battery settings that can hide or stop the bubble.'**
  String get helpGuideScanBubbleLimitsBullet3;

  /// Tip at the end of the guide on scanning codes shown in other apps
  ///
  /// In en, this message translates to:
  /// **'Tip: Add the Scan bubble tile to Quick Settings. Then one tap turns the bubble on or off from any app.'**
  String get helpGuideScanBubbleTip;

  /// Help hub card title for the CodeForge guide
  ///
  /// In en, this message translates to:
  /// **'Making codes (CodeForge)'**
  String get helpGuideCodeForgeName;

  /// Help hub card summary for the CodeForge guide
  ///
  /// In en, this message translates to:
  /// **'Make your own QR codes and barcodes, change their look, and share them.'**
  String get helpGuideCodeForgeSummary;

  /// Opening paragraph of the CodeForge guide
  ///
  /// In en, this message translates to:
  /// **'CodeForge lets you make your own QR code or barcode: for your Wi-Fi, your contact details, a link, a UPI payment and more. You can change its colours and shapes, and share it as a picture.'**
  String get helpGuideCodeForgeIntro;

  /// CodeForge guide section heading: choosing what the code holds
  ///
  /// In en, this message translates to:
  /// **'1. Choose what to put in it'**
  String get helpGuideCodeForgeTypeTitle;

  /// CodeForge guide: opening the CodeForge tab
  ///
  /// In en, this message translates to:
  /// **'Open the CodeForge tab at the bottom of the screen.'**
  String get helpGuideCodeForgeTypeBullet1;

  /// CodeForge guide: choosing a QR code or a barcode type
  ///
  /// In en, this message translates to:
  /// **'Pick the code type: QR Code, or a barcode such as Code 128, EAN-13, EAN-8, UPC-A, Code 39, PDF417 or Data Matrix.'**
  String get helpGuideCodeForgeTypeBullet2;

  /// CodeForge guide: the kinds of content a QR code can hold
  ///
  /// In en, this message translates to:
  /// **'For a QR code, pick what it holds: Text, URL / Link, Wi-Fi, Contact, UPI Pay, SMS, Email or Location.'**
  String get helpGuideCodeForgeTypeBullet3;

  /// CodeForge guide: filling in the boxes and the live preview
  ///
  /// In en, this message translates to:
  /// **'Fill in the boxes. The preview changes as you type.'**
  String get helpGuideCodeForgeTypeBullet4;

  /// CodeForge guide: reading text from a file
  ///
  /// In en, this message translates to:
  /// **'For text, you can also tap Read from file to load text from a file (up to 500 characters).'**
  String get helpGuideCodeForgeTypeBullet5;

  /// CodeForge guide: filling a location with the current place
  ///
  /// In en, this message translates to:
  /// **'For a location, tap Use My Location to fill in where you are. The app asks for your location only at that moment and does not keep it.'**
  String get helpGuideCodeForgeTypeBullet6;

  /// CodeForge guide section heading: changing the look of the code
  ///
  /// In en, this message translates to:
  /// **'2. Change the look'**
  String get helpGuideCodeForgeStyleTitle;

  /// CodeForge guide: the shape choices
  ///
  /// In en, this message translates to:
  /// **'Design & Structure: choose the shape of the big corner squares, their centres, and the small dots.'**
  String get helpGuideCodeForgeStyleBullet1;

  /// CodeForge guide: the colour choices
  ///
  /// In en, this message translates to:
  /// **'Colors & Gradients: choose the code colour and the background, or a colour blend such as Sunset or Ocean.'**
  String get helpGuideCodeForgeStyleBullet2;

  /// CodeForge guide: keep strong contrast so the code scans
  ///
  /// In en, this message translates to:
  /// **'Keep strong contrast. A dark code on a light background scans best.'**
  String get helpGuideCodeForgeStyleBullet3;

  /// CodeForge guide: the centre badge
  ///
  /// In en, this message translates to:
  /// **'Center Badge: put a small icon in the middle of the code.'**
  String get helpGuideCodeForgeStyleBullet4;

  /// CodeForge guide: error correction levels explained simply
  ///
  /// In en, this message translates to:
  /// **'Error Correction: how much damage the code can take and still scan. L survives about 7%, M 15%, Q 25% and H 30%. Higher levels make the code busier. Choose H when you add a centre badge.'**
  String get helpGuideCodeForgeStyleBullet5;

  /// CodeForge guide: the text label under a barcode and the reset button
  ///
  /// In en, this message translates to:
  /// **'Show Text Label prints the text under a barcode. Reset Styling puts the look back to normal.'**
  String get helpGuideCodeForgeStyleBullet6;

  /// CodeForge guide section heading: checking and sharing the code
  ///
  /// In en, this message translates to:
  /// **'3. Check and share'**
  String get helpGuideCodeForgeShareTitle;

  /// CodeForge guide: checking a link before sharing
  ///
  /// In en, this message translates to:
  /// **'For a link, tap Check to test the link for safety before you share it.'**
  String get helpGuideCodeForgeShareBullet1;

  /// CodeForge guide: sharing as PNG or SVG
  ///
  /// In en, this message translates to:
  /// **'Tap Share PNG to share it as a normal picture, or Share SVG for a sharp picture that prints well at any size.'**
  String get helpGuideCodeForgeShareBullet2;

  /// CodeForge guide: copying the content of the code
  ///
  /// In en, this message translates to:
  /// **'Tap Copy Content to copy the text inside the code.'**
  String get helpGuideCodeForgeShareBullet3;

  /// Tip at the end of the CodeForge guide
  ///
  /// In en, this message translates to:
  /// **'Tip: Before you print many copies, scan your new code once with this app to make sure it reads well.'**
  String get helpGuideCodeForgeTip;

  /// Help hub card title for the AirQR guide
  ///
  /// In en, this message translates to:
  /// **'AirQR: send data with no network'**
  String get helpGuideAirQrName;

  /// Help hub card summary for the AirQR guide
  ///
  /// In en, this message translates to:
  /// **'Send text, or move your app data to another phone, using moving QR codes. No Wi-Fi, Bluetooth or cables.'**
  String get helpGuideAirQrSummary;

  /// Opening paragraph of the AirQR guide
  ///
  /// In en, this message translates to:
  /// **'AirQR sends data from one phone to another using only the screen and the camera. The sending phone shows a fast series of QR codes. The receiving phone watches them and joins them back together. No network is used at all.'**
  String get helpGuideAirQrIntro;

  /// AirQR guide section heading: how to send
  ///
  /// In en, this message translates to:
  /// **'How to send'**
  String get helpGuideAirQrStreamingTitle;

  /// AirQR guide: opening the transmitter
  ///
  /// In en, this message translates to:
  /// **'On the sending phone, open Scan > More options > AirQR receiver, then tap the AirQR transmitter button at the top.'**
  String get helpGuideAirQrStreamingBullet1;

  /// AirQR guide: entering the data to send
  ///
  /// In en, this message translates to:
  /// **'Type or paste what you want to send under Data to send.'**
  String get helpGuideAirQrStreamingBullet2;

  /// AirQR guide: choosing the speed and starting
  ///
  /// In en, this message translates to:
  /// **'Choose the Stream Speed (5 to 25 frames a second), then tap Start stream.'**
  String get helpGuideAirQrStreamingBullet3;

  /// AirQR guide: keep the sending screen bright and still
  ///
  /// In en, this message translates to:
  /// **'Keep the sending screen bright and hold it still.'**
  String get helpGuideAirQrStreamingBullet4;

  /// AirQR guide section heading: how to receive
  ///
  /// In en, this message translates to:
  /// **'How to receive'**
  String get helpGuideAirQrControlsTitle;

  /// AirQR guide: opening the receiver
  ///
  /// In en, this message translates to:
  /// **'On the other phone, open Scan > More options > AirQR receiver and point the camera at the sending screen.'**
  String get helpGuideAirQrControlsBullet1;

  /// AirQR guide: the progress bar
  ///
  /// In en, this message translates to:
  /// **'A progress bar shows how many parts have arrived and how many are still missing.'**
  String get helpGuideAirQrControlsBullet2;

  /// AirQR guide: missed parts are repaired by extra frames
  ///
  /// In en, this message translates to:
  /// **'Missed parts are no problem. AirQR also sends extra repair parts, so the receiver can fill in the gaps.'**
  String get helpGuideAirQrControlsBullet3;

  /// AirQR guide: the transfer complete screen
  ///
  /// In en, this message translates to:
  /// **'When all parts arrive, the app checks the data and shows Transfer complete! You can copy the data from there.'**
  String get helpGuideAirQrControlsBullet4;

  /// AirQR guide section heading: moving app data to a new phone
  ///
  /// In en, this message translates to:
  /// **'Move your data to a new phone'**
  String get helpGuideAirQrSyncTitle;

  /// AirQR guide: starting a device sync on the old phone
  ///
  /// In en, this message translates to:
  /// **'On the old phone, go to Settings > AirQR Optical Sync. Choose your history, your app settings, or both.'**
  String get helpGuideAirQrSyncBullet1;

  /// AirQR guide: locking the sync with a passphrase or PIN
  ///
  /// In en, this message translates to:
  /// **'Type a passphrase or PIN, or tap Generate PIN. This locks the data, so only someone with the PIN can open it.'**
  String get helpGuideAirQrSyncBullet2;

  /// AirQR guide: sending the sync package
  ///
  /// In en, this message translates to:
  /// **'Tap Beam via AirQR, and receive it on the new phone with the AirQR receiver.'**
  String get helpGuideAirQrSyncBullet3;

  /// AirQR guide: opening the sync package on the new phone
  ///
  /// In en, this message translates to:
  /// **'On the new phone, type the same passphrase or PIN and tap Decrypt & Sync.'**
  String get helpGuideAirQrSyncBullet4;

  /// AirQR guide section heading: why AirQR is private
  ///
  /// In en, this message translates to:
  /// **'Why it is private'**
  String get helpGuideAirQrSecurityTitle;

  /// AirQR guide: no radio signals are used
  ///
  /// In en, this message translates to:
  /// **'No radio signals are used: no Wi-Fi, Bluetooth, mobile data or internet.'**
  String get helpGuideAirQrSecurityBullet1;

  /// AirQR guide: only a camera that sees the screen can read it
  ///
  /// In en, this message translates to:
  /// **'Nobody can catch the data over a network. Only a camera that can see the screen can read it.'**
  String get helpGuideAirQrSecurityBullet2;

  /// AirQR guide: good for private data
  ///
  /// In en, this message translates to:
  /// **'Useful for passwords, keys and other private data you do not want to send online.'**
  String get helpGuideAirQrSecurityBullet3;

  /// Tip at the end of the AirQR guide
  ///
  /// In en, this message translates to:
  /// **'Tip: Turn the sending phone\'s brightness up and hold the receiving phone steady. If parts keep going missing, lower the speed.'**
  String get helpGuideAirQrTip;

  /// Help hub card title for the link safety guide
  ///
  /// In en, this message translates to:
  /// **'Link safety checks'**
  String get helpGuideUrlSafetyName;

  /// Help hub card summary for the link safety guide
  ///
  /// In en, this message translates to:
  /// **'How the app checks every link before you open it, and what the result means.'**
  String get helpGuideUrlSafetySummary;

  /// Opening paragraph of the link safety guide
  ///
  /// In en, this message translates to:
  /// **'Scam QR codes often lead to fake websites. So before you open any link, the app checks it in up to six ways. The first four checks always run on your phone, with no internet.'**
  String get helpGuideUrlSafetyIntro;

  /// Link safety guide section heading: the six checks
  ///
  /// In en, this message translates to:
  /// **'The six checks'**
  String get helpGuideUrlSafetyLayersTitle;

  /// Link safety check 1: secure connection and hidden characters
  ///
  /// In en, this message translates to:
  /// **'1. Safe connection: is the link using secure HTTPS? Does it hide strange or invisible characters?'**
  String get helpGuideUrlSafetyLayersBullet1;

  /// Link safety check 2: lookalike letters from other alphabets
  ///
  /// In en, this message translates to:
  /// **'2. Lookalike letters: some fake sites use letters from other alphabets that look the same, for example a Cyrillic \"а\" in place of a normal \"a\".'**
  String get helpGuideUrlSafetyLayersBullet2;

  /// Link safety check 3: odd web addresses
  ///
  /// In en, this message translates to:
  /// **'3. Odd web addresses: risky endings (such as .xyz or .top), too many parts in the name, or names made of random letters.'**
  String get helpGuideUrlSafetyLayersBullet3;

  /// Link safety check 4: number addresses and odd ports
  ///
  /// In en, this message translates to:
  /// **'4. Number addresses and odd ports: links that use a raw number (an IP address) or an unusual port, which normal shops and banks do not use.'**
  String get helpGuideUrlSafetyLayersBullet4;

  /// Link safety check 5: optional online check of the site
  ///
  /// In en, this message translates to:
  /// **'5. Online check of the site (optional): follows short links (like bit.ly) to see where they really go, and checks the site\'s security certificate. Runs only if you turn on Active online checks.'**
  String get helpGuideUrlSafetyLayersBullet5;

  /// Link safety check 6: optional lists of known bad sites
  ///
  /// In en, this message translates to:
  /// **'6. Known-bad lists (optional): asks services such as Google Safe Browsing whether the link is a known scam or virus site. Runs only if you set it up.'**
  String get helpGuideUrlSafetyLayersBullet6;

  /// Link safety guide section heading: reading the result
  ///
  /// In en, this message translates to:
  /// **'Reading the result'**
  String get helpGuideUrlSafetyVerdictsTitle;

  /// Link safety guide: what No issues found means
  ///
  /// In en, this message translates to:
  /// **'No issues found: the link passed every check that ran. Still, trust only sources you know.'**
  String get helpGuideUrlSafetyVerdictsBullet1;

  /// Link safety guide: what issues found means and See details
  ///
  /// In en, this message translates to:
  /// **'Issues found: the app shows which checks failed. Tap See details to read why.'**
  String get helpGuideUrlSafetyVerdictsBullet2;

  /// Link safety guide: opening a risky link asks first
  ///
  /// In en, this message translates to:
  /// **'If you still open a risky link, the app asks you first. Tap Open Anyway only if you trust the source.'**
  String get helpGuideUrlSafetyVerdictsBullet3;

  /// Link safety guide: the Re-check button
  ///
  /// In en, this message translates to:
  /// **'Tap Re-check to run the checks again, for example after you go online.'**
  String get helpGuideUrlSafetyVerdictsBullet4;

  /// Link safety guide section heading: private mode and active online checks
  ///
  /// In en, this message translates to:
  /// **'Private mode and online checks'**
  String get helpGuideUrlSafetyPrivacyTitle;

  /// Link safety guide: by default the site itself is never contacted
  ///
  /// In en, this message translates to:
  /// **'By default, the app never contacts the website itself. The site cannot see your phone or your IP address (your internet address).'**
  String get helpGuideUrlSafetyPrivacyBullet1;

  /// Link safety guide: what turning on active online checks does
  ///
  /// In en, this message translates to:
  /// **'If you turn on Active online checks in Settings > Privacy & probing, the app visits the site to follow short links and check its certificate. This finds more, but the site can see your IP address.'**
  String get helpGuideUrlSafetyPrivacyBullet2;

  /// Link safety guide: the safe page preview
  ///
  /// In en, this message translates to:
  /// **'With Active online checks on, the result can also show a safe preview of the page. Scripts and trackers are removed first, so nothing on the page can run. Tap Show preview or Inspect page.'**
  String get helpGuideUrlSafetyPrivacyBullet3;

  /// Link safety guide section heading: extra online checkers
  ///
  /// In en, this message translates to:
  /// **'Extra online checkers'**
  String get helpGuideUrlSafetyProvidersTitle;

  /// Link safety guide: checkers that need no account
  ///
  /// In en, this message translates to:
  /// **'In Settings > URL Safety Providers you can turn on more checkers. PhishTank and OpenPhish need no account.'**
  String get helpGuideUrlSafetyProvidersBullet1;

  /// Link safety guide: checkers that need your own key
  ///
  /// In en, this message translates to:
  /// **'Google Safe Browsing, VirusTotal and URLhaus need your own free key. See the guide \"Online checker setup\".'**
  String get helpGuideUrlSafetyProvidersBullet2;

  /// Link safety guide: what the online checkers receive
  ///
  /// In en, this message translates to:
  /// **'These checkers get only the link you scanned. OpenPhish works differently: the app downloads its list and checks on your phone. All of them are off until you turn them on.'**
  String get helpGuideUrlSafetyProvidersBullet3;

  /// Tip at the end of the link safety guide
  ///
  /// In en, this message translates to:
  /// **'Tip: A good result is not a promise. Scammers make new sites every day. If a payment or login page looks odd, close it.'**
  String get helpGuideUrlSafetyTip;

  /// Help hub card title for the QuishingGuard guide
  ///
  /// In en, this message translates to:
  /// **'QuishingGuard: fake sticker codes'**
  String get helpGuideQuishingName;

  /// Help hub card summary for the QuishingGuard guide
  ///
  /// In en, this message translates to:
  /// **'Spot QR codes that may be fake stickers placed over real ones.'**
  String get helpGuideQuishingSummary;

  /// Opening paragraph of the QuishingGuard guide
  ///
  /// In en, this message translates to:
  /// **'\"Quishing\" means QR phishing. Scammers stick their own QR code over the real one, on parking meters, menus, shop counters and posters, so that your payment or login goes to them.'**
  String get helpGuideQuishingIntro;

  /// QuishingGuard guide section heading: what QuishingGuard shows
  ///
  /// In en, this message translates to:
  /// **'What QuishingGuard shows'**
  String get helpGuideQuishingCvTitle;

  /// QuishingGuard guide: when and where the fake-sticker check card appears
  ///
  /// In en, this message translates to:
  /// **'When you scan a link or a payment code with the camera, the result screen shows a small QuishingGuard card: Fake sticker check.'**
  String get helpGuideQuishingCvBullet1;

  /// QuishingGuard guide: the card lists hand checks; no image check and no score
  ///
  /// In en, this message translates to:
  /// **'Tap it to open a short list of checks. The app does not look for stickers in the picture and gives no score, so it cannot tell you that a code is safe.'**
  String get helpGuideQuishingCvBullet2;

  /// QuishingGuard guide: the card is not shown for photos, clipboard, screen scans or plain text
  ///
  /// In en, this message translates to:
  /// **'The card does not appear for photos, the clipboard, screen scans or plain text, because those codes are not stuck on a wall.'**
  String get helpGuideQuishingCvBullet3;

  /// QuishingGuard guide section heading: what you should do
  ///
  /// In en, this message translates to:
  /// **'What you should do'**
  String get helpGuideQuishingForensicTitle;

  /// QuishingGuard guide: look at and feel the code
  ///
  /// In en, this message translates to:
  /// **'Look at the code and feel it with your finger. A sticker on top often has raised edges or sits crooked.'**
  String get helpGuideQuishingForensicBullet1;

  /// QuishingGuard guide: check the payee name before paying
  ///
  /// In en, this message translates to:
  /// **'Before you pay, check that the name on the payment screen matches the shop.'**
  String get helpGuideQuishingForensicBullet2;

  /// QuishingGuard guide: ask the staff or type the address yourself
  ///
  /// In en, this message translates to:
  /// **'If in doubt, ask the staff, or type the website address yourself instead.'**
  String get helpGuideQuishingForensicBullet3;

  /// Tip at the end of the QuishingGuard guide
  ///
  /// In en, this message translates to:
  /// **'Tip: QuishingGuard is a helper, not a promise. Your own eyes and fingers are the best check.'**
  String get helpGuideQuishingTip;

  /// Help hub card title for the online checker setup guide
  ///
  /// In en, this message translates to:
  /// **'Online checker setup'**
  String get helpGuideSafeBrowsingName;

  /// Help hub card summary for the online checker setup guide
  ///
  /// In en, this message translates to:
  /// **'Turn on extra link checks, and get a free key for Google Safe Browsing.'**
  String get helpGuideSafeBrowsingSummary;

  /// Opening paragraph of the online checker setup guide
  ///
  /// In en, this message translates to:
  /// **'Online checkers compare a scanned link with lists of known scam and virus sites. They are optional. The app\'s own checks work without them.'**
  String get helpGuideSafeBrowsingIntro;

  /// Online checker guide section heading: checkers with no account
  ///
  /// In en, this message translates to:
  /// **'No account needed'**
  String get helpGuideSafeBrowsingBuiltInTitle;

  /// Online checker guide: where the checkers are
  ///
  /// In en, this message translates to:
  /// **'Open Settings > URL Safety Providers.'**
  String get helpGuideSafeBrowsingBuiltInBullet1;

  /// Online checker guide: turning on PhishTank
  ///
  /// In en, this message translates to:
  /// **'Turn on Enable PhishTank to check links against PhishTank\'s list of scam sites.'**
  String get helpGuideSafeBrowsingBuiltInBullet2;

  /// Online checker guide: turning on and refreshing OpenPhish
  ///
  /// In en, this message translates to:
  /// **'Turn on Use OpenPhish feed. The app downloads OpenPhish\'s list and checks links on your phone. Tap Refresh feed now to get the latest list.'**
  String get helpGuideSafeBrowsingBuiltInBullet3;

  /// Online checker guide section heading: getting a Google Safe Browsing key
  ///
  /// In en, this message translates to:
  /// **'Get a free Google Safe Browsing key'**
  String get helpGuideSafeBrowsingKeyTitle;

  /// Safe Browsing key step 1: open the Google Cloud console
  ///
  /// In en, this message translates to:
  /// **'1. In a browser, open console.cloud.google.com and sign in with a Google account.'**
  String get helpGuideSafeBrowsingKeyStep1;

  /// Safe Browsing key step 2: create a project
  ///
  /// In en, this message translates to:
  /// **'2. Create a new project. Any name is fine, for example \"QR safety\".'**
  String get helpGuideSafeBrowsingKeyStep2;

  /// Safe Browsing key step 3: turn on the Safe Browsing API
  ///
  /// In en, this message translates to:
  /// **'3. Go to APIs & Services > Library, search for \"Safe Browsing API\" and tap Enable.'**
  String get helpGuideSafeBrowsingKeyStep3;

  /// Safe Browsing key step 4: create an API key
  ///
  /// In en, this message translates to:
  /// **'4. Go to APIs & Services > Credentials, tap Create credentials and choose API key.'**
  String get helpGuideSafeBrowsingKeyStep4;

  /// Safe Browsing key step 5: paste the key into the app
  ///
  /// In en, this message translates to:
  /// **'5. Copy the key. In the app, open Settings > URL Safety Providers, paste it into the Google Safe Browsing box and tap Save API Key.'**
  String get helpGuideSafeBrowsingKeyStep5;

  /// Online checker guide section heading: other services that need a key
  ///
  /// In en, this message translates to:
  /// **'Other services with a key'**
  String get helpGuideSafeBrowsingOtherTitle;

  /// Online checker guide: VirusTotal and URLhaus keys
  ///
  /// In en, this message translates to:
  /// **'VirusTotal and URLhaus work the same way. Make a free account on their website, copy your key, and paste it under Your API Keys. The app shows where to get each key.'**
  String get helpGuideSafeBrowsingOtherBullet1;

  /// Online checker guide: free keys are for personal use
  ///
  /// In en, this message translates to:
  /// **'These free keys are for personal, non-commercial use.'**
  String get helpGuideSafeBrowsingOtherBullet2;

  /// Online checker guide: daily limits and the usage counter
  ///
  /// In en, this message translates to:
  /// **'Each service has a daily limit, and the app shows how many checks you have used today. In this app, Safe Browsing allows up to 10,000 a day and VirusTotal 500 a day.'**
  String get helpGuideSafeBrowsingOtherBullet3;

  /// Online checker guide section heading: your keys are safe
  ///
  /// In en, this message translates to:
  /// **'Your keys are safe'**
  String get helpGuideSafeBrowsingPrivacyTitle;

  /// Online checker guide: keys are kept in secure storage
  ///
  /// In en, this message translates to:
  /// **'Your keys are kept in Android\'s secure, locked storage on this phone, and are never shared.'**
  String get helpGuideSafeBrowsingPrivacyBullet1;

  /// Online checker guide: only the scanned link is sent
  ///
  /// In en, this message translates to:
  /// **'Only the link you scanned is sent to the service. Nothing else about you is sent.'**
  String get helpGuideSafeBrowsingPrivacyBullet2;

  /// Online checker guide: deleting a key
  ///
  /// In en, this message translates to:
  /// **'You can delete a key at any time. The app then simply skips that check.'**
  String get helpGuideSafeBrowsingPrivacyBullet3;

  /// Tip at the end of the online checker setup guide
  ///
  /// In en, this message translates to:
  /// **'Tip: You do not need any key to stay safe. The app\'s own checks always run, even with no internet.'**
  String get helpGuideSafeBrowsingTip;

  /// Help hub card title for the smart actions guide
  ///
  /// In en, this message translates to:
  /// **'Smart actions'**
  String get helpGuideSmartPayloadsName;

  /// Help hub card summary for the smart actions guide
  ///
  /// In en, this message translates to:
  /// **'One-tap buttons for Wi-Fi, payments, contacts, events, phone numbers, products and more.'**
  String get helpGuideSmartPayloadsSummary;

  /// Opening paragraph of the smart actions guide
  ///
  /// In en, this message translates to:
  /// **'The app understands what a code holds and shows a card with the right buttons. For example, a Wi-Fi code gets a Connect button, and a phone number gets a Call button.'**
  String get helpGuideSmartPayloadsIntro;

  /// Smart actions guide section heading: Wi-Fi codes
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi'**
  String get helpGuideSmartPayloadsWifiTitle;

  /// Smart actions guide: what a Wi-Fi card shows
  ///
  /// In en, this message translates to:
  /// **'Shows the network name and its type of security. Tap the eye button to show or hide the password, or copy it.'**
  String get helpGuideSmartPayloadsWifiBullet1;

  /// Smart actions guide: connecting to a Wi-Fi network
  ///
  /// In en, this message translates to:
  /// **'Tap Connect to Wi-Fi. Android may ask you to confirm. If your phone does not allow a direct connection, the password is copied so you can paste it in your Wi-Fi settings.'**
  String get helpGuideSmartPayloadsWifiBullet2;

  /// Smart actions guide section heading: payment codes
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get helpGuideSmartPayloadsPaymentsTitle;

  /// Smart actions guide: paying with a UPI code
  ///
  /// In en, this message translates to:
  /// **'UPI codes show who you are paying and the amount. Tap Pay with UPI app to open your UPI app (such as Google Pay, PhonePe, Paytm or BHIM) with the details filled in.'**
  String get helpGuideSmartPayloadsPaymentsBullet1;

  /// Smart actions guide: codes with no amount
  ///
  /// In en, this message translates to:
  /// **'If the code has no amount, the app asks you to type it first.'**
  String get helpGuideSmartPayloadsPaymentsBullet2;

  /// Smart actions guide: the app never moves money itself
  ///
  /// In en, this message translates to:
  /// **'This app never takes or sends money by itself. You confirm every payment in your UPI app.'**
  String get helpGuideSmartPayloadsPaymentsBullet3;

  /// Smart actions guide: crypto and SEPA payment codes
  ///
  /// In en, this message translates to:
  /// **'Crypto wallet codes (Bitcoin, Ethereum, Solana) and SEPA bank transfer codes show the address, which you can copy.'**
  String get helpGuideSmartPayloadsPaymentsBullet4;

  /// Smart actions guide section heading: two-step login codes
  ///
  /// In en, this message translates to:
  /// **'Two-step login codes (2FA)'**
  String get helpGuideSmartPayloadsTotpTitle;

  /// Smart actions guide: what a 2FA setup code shows
  ///
  /// In en, this message translates to:
  /// **'Websites often show a QR code when you turn on two-step login. Scanning it shows a 6-digit code that changes every 30 seconds, with a timer.'**
  String get helpGuideSmartPayloadsTotpBullet1;

  /// Smart actions guide: adding the code to an authenticator app
  ///
  /// In en, this message translates to:
  /// **'Tap Add to authenticator to save it in your authenticator app, such as Google or Microsoft Authenticator.'**
  String get helpGuideSmartPayloadsTotpBullet2;

  /// Smart actions guide: keep 2FA setup codes private
  ///
  /// In en, this message translates to:
  /// **'Keep this kind of code private. Anyone who scans it can make your login codes.'**
  String get helpGuideSmartPayloadsTotpBullet3;

  /// Smart actions guide section heading: contacts and events
  ///
  /// In en, this message translates to:
  /// **'Contacts and events'**
  String get helpGuideSmartPayloadsContactsTitle;

  /// Smart actions guide: contact codes
  ///
  /// In en, this message translates to:
  /// **'Contact codes (vCard or MeCard) show the name, phone, email and company. Tap Save to Contacts, or call or email straight away.'**
  String get helpGuideSmartPayloadsContactsBullet1;

  /// Smart actions guide: event codes
  ///
  /// In en, this message translates to:
  /// **'Event codes show the title, time and place. Tap Add to calendar.'**
  String get helpGuideSmartPayloadsContactsBullet2;

  /// Smart actions guide section heading: phone, messages, email, maps, products and books
  ///
  /// In en, this message translates to:
  /// **'Phone, messages, maps and more'**
  String get helpGuideSmartPayloadsOtherTitle;

  /// Smart actions guide: phone, SMS and email codes
  ///
  /// In en, this message translates to:
  /// **'Phone number: tap Call. Text message: tap Send Message, and the message is filled in for you. Email: tap Send Email.'**
  String get helpGuideSmartPayloadsOtherBullet1;

  /// Smart actions guide: location codes
  ///
  /// In en, this message translates to:
  /// **'Location: tap Open in Maps to see the place or get directions.'**
  String get helpGuideSmartPayloadsOtherBullet2;

  /// Smart actions guide: app link codes
  ///
  /// In en, this message translates to:
  /// **'App link: tap Open in App to open the matching app, if it is installed.'**
  String get helpGuideSmartPayloadsOtherBullet3;

  /// Smart actions guide: product barcodes
  ///
  /// In en, this message translates to:
  /// **'Product barcode: tap Food Info to look up food details, or Search Web.'**
  String get helpGuideSmartPayloadsOtherBullet4;

  /// Smart actions guide: book (ISBN) barcodes
  ///
  /// In en, this message translates to:
  /// **'Book (ISBN) barcode: look the book up on Google Books or Open Library.'**
  String get helpGuideSmartPayloadsOtherBullet5;

  /// Smart actions guide: links open only after the safety check
  ///
  /// In en, this message translates to:
  /// **'Web links open in your browser only after the safety check has run.'**
  String get helpGuideSmartPayloadsOtherBullet6;

  /// Tip at the end of the smart actions guide
  ///
  /// In en, this message translates to:
  /// **'Tip: Before you pay with a UPI code, check that the name on the card matches the shop or person you want to pay.'**
  String get helpGuideSmartPayloadsTip;

  /// Help hub card title for the guide on hidden and locked codes
  ///
  /// In en, this message translates to:
  /// **'Hidden and locked codes'**
  String get helpGuideHiddenName;

  /// Help hub card summary for the guide on hidden and locked codes
  ///
  /// In en, this message translates to:
  /// **'Open QR codes that carry a secret message or locked data.'**
  String get helpGuideHiddenSummary;

  /// Opening paragraph of the guide on hidden and locked codes
  ///
  /// In en, this message translates to:
  /// **'Some QR codes carry private data that is locked with a passphrase. The app spots these codes and lets you unlock them, right on your phone.'**
  String get helpGuideHiddenIntro;

  /// Locked codes guide section heading: StegoQR codes
  ///
  /// In en, this message translates to:
  /// **'StegoQR: a code with a hidden message'**
  String get helpGuideHiddenStegoTitle;

  /// Locked codes guide: what a StegoQR code is
  ///
  /// In en, this message translates to:
  /// **'A StegoQR code shows ordinary public text to everyone, and hides a second, secret message inside it.'**
  String get helpGuideHiddenStegoBullet1;

  /// Locked codes guide: what you see when you scan a StegoQR code
  ///
  /// In en, this message translates to:
  /// **'When you scan one, the result shows StegoQR found. The public text is shown as usual.'**
  String get helpGuideHiddenStegoBullet2;

  /// Locked codes guide: unlocking with the passphrase
  ///
  /// In en, this message translates to:
  /// **'To see the secret, type the passphrase and tap Unlock. The person who made the code must give you the passphrase.'**
  String get helpGuideHiddenStegoBullet3;

  /// Locked codes guide: biometric unlock
  ///
  /// In en, this message translates to:
  /// **'Biometric Unlock asks for your fingerprint or face as well as the passphrase.'**
  String get helpGuideHiddenStegoBullet4;

  /// Locked codes guide: copying or sharing the secret
  ///
  /// In en, this message translates to:
  /// **'After unlocking, you can copy or share the secret.'**
  String get helpGuideHiddenStegoBullet5;

  /// Locked codes guide section heading: other locked codes
  ///
  /// In en, this message translates to:
  /// **'Other locked codes'**
  String get helpGuideHiddenOtherTitle;

  /// Locked codes guide: AirQR transfer codes and the session code
  ///
  /// In en, this message translates to:
  /// **'AirQR transfer codes: type the session code shown on the sending phone.'**
  String get helpGuideHiddenOtherBullet1;

  /// Locked codes guide: encrypted JSON and other locked text
  ///
  /// In en, this message translates to:
  /// **'Encrypted JSON codes and other locked text: tap Decrypt Payload and type the passphrase.'**
  String get helpGuideHiddenOtherBullet2;

  /// Locked codes guide: the advanced salt and IV fields
  ///
  /// In en, this message translates to:
  /// **'Advanced (Salt / IV) is only for codes made by other tools that need extra settings. Most people never need it.'**
  String get helpGuideHiddenOtherBullet3;

  /// Locked codes guide section heading: good to know
  ///
  /// In en, this message translates to:
  /// **'Good to know'**
  String get helpGuideHiddenSafetyTitle;

  /// Locked codes guide: unlocking happens on the phone
  ///
  /// In en, this message translates to:
  /// **'Unlocking happens on your phone. The passphrase and the secret are never sent anywhere.'**
  String get helpGuideHiddenSafetyBullet1;

  /// Locked codes guide: what to do after a wrong passphrase
  ///
  /// In en, this message translates to:
  /// **'A wrong passphrase just shows an error. Check the spelling, capital letters and spaces, and try again.'**
  String get helpGuideHiddenSafetyBullet2;

  /// Locked codes guide: the app reads these codes but cannot make them
  ///
  /// In en, this message translates to:
  /// **'This app can open these codes, but it does not make them.'**
  String get helpGuideHiddenSafetyBullet3;

  /// Tip at the end of the guide on hidden and locked codes
  ///
  /// In en, this message translates to:
  /// **'Tip: Share the passphrase in a different way from the code, for example by phone call. Never write it next to the code.'**
  String get helpGuideHiddenTip;

  /// Help hub card title for the history guide
  ///
  /// In en, this message translates to:
  /// **'History, backups and privacy'**
  String get helpGuideHistoryName;

  /// Help hub card summary for the history guide
  ///
  /// In en, this message translates to:
  /// **'Find old scans, add notes, export or back up your history, and lock the app.'**
  String get helpGuideHistorySummary;

  /// Opening paragraph of the history guide
  ///
  /// In en, this message translates to:
  /// **'Every scan is saved in the History tab on your phone, in a locked (encrypted) store. Nothing is uploaded.'**
  String get helpGuideHistoryIntro;

  /// History guide section heading: finding and managing scans
  ///
  /// In en, this message translates to:
  /// **'Find and manage scans'**
  String get helpGuideHistoryManageTitle;

  /// History guide: the search box
  ///
  /// In en, this message translates to:
  /// **'Type in the search box to find scans by their content, type or notes.'**
  String get helpGuideHistoryManageBullet1;

  /// History guide: filter chips and starring a scan
  ///
  /// In en, this message translates to:
  /// **'Use the filter chips to show only links, Wi-Fi, contacts, products and so on. Tap the star on a scan to add it to Starred.'**
  String get helpGuideHistoryManageBullet2;

  /// History guide: the details sheet of a scan
  ///
  /// In en, this message translates to:
  /// **'Tap a scan to see all its details: full content, safety score and time. You can add notes and a place, or copy, share or delete it.'**
  String get helpGuideHistoryManageBullet3;

  /// History guide: clearing all history
  ///
  /// In en, this message translates to:
  /// **'Clear All deletes your whole history. This cannot be undone, so make a backup first.'**
  String get helpGuideHistoryManageBullet4;

  /// History guide section heading: export and backup
  ///
  /// In en, this message translates to:
  /// **'Export and backup'**
  String get helpGuideHistoryBackupTitle;

  /// History guide: opening export and backup
  ///
  /// In en, this message translates to:
  /// **'Tap the Export / Backup button at the top of the History tab.'**
  String get helpGuideHistoryBackupBullet1;

  /// History guide: plain exports are not locked
  ///
  /// In en, this message translates to:
  /// **'Export Records saves a copy as CSV (for Excel or Sheets), JSON, text or PDF. These files are not locked: anyone with the file can read your scans, so the app asks you first.'**
  String get helpGuideHistoryBackupBullet2;

  /// History guide: making an encrypted backup
  ///
  /// In en, this message translates to:
  /// **'Encrypted backup is the safe way to keep a copy. Type a passphrase and tap Create backup, then save or share the file.'**
  String get helpGuideHistoryBackupBullet3;

  /// History guide: restoring an encrypted backup
  ///
  /// In en, this message translates to:
  /// **'To restore, open Restore Backup, paste the text from your backup file, type the same passphrase and tap Restore history.'**
  String get helpGuideHistoryBackupBullet4;

  /// History guide section heading: app lock and screenshot guard
  ///
  /// In en, this message translates to:
  /// **'App lock and screenshot guard'**
  String get helpGuideHistoryBiometricsTitle;

  /// History guide: the app lock
  ///
  /// In en, this message translates to:
  /// **'App lock: turn it on in Settings > Privacy & probing. The app then asks for your fingerprint, face or screen lock when it opens, and after you have been away for 30 seconds.'**
  String get helpGuideHistoryBiometricsBullet1;

  /// History guide: the screenshot guard
  ///
  /// In en, this message translates to:
  /// **'Screenshot guard: stops screenshots and screen recording on screens with scans, history, secrets or keys. These screens also look blank in the recent apps list. Turn it on or off in Settings > Privacy & probing.'**
  String get helpGuideHistoryBiometricsBullet2;

  /// History guide: moving history to a new phone
  ///
  /// In en, this message translates to:
  /// **'To move your history to a new phone, use AirQR Optical Sync. See the AirQR guide.'**
  String get helpGuideHistoryBiometricsBullet3;

  /// Tip at the end of the history guide
  ///
  /// In en, this message translates to:
  /// **'Tip: Make an encrypted backup before you reset or change your phone. Keep the passphrase somewhere safe. Without it, the backup cannot be opened.'**
  String get helpGuideHistoryTip;

  /// Help hub card title for the settings guide
  ///
  /// In en, this message translates to:
  /// **'Settings and personal touch'**
  String get helpGuideSettingsName;

  /// Help hub card summary for the settings guide
  ///
  /// In en, this message translates to:
  /// **'Change the look, language and sounds, see permissions, save battery, and delete your data.'**
  String get helpGuideSettingsSummary;

  /// Opening paragraph of the settings guide
  ///
  /// In en, this message translates to:
  /// **'To open Settings, go to the Scan screen, tap More options and choose Settings. Here is what each part does.'**
  String get helpGuideSettingsIntro;

  /// Settings guide section heading: look and language
  ///
  /// In en, this message translates to:
  /// **'Look and language'**
  String get helpGuideSettingsLookTitle;

  /// Settings guide: theme mode choices
  ///
  /// In en, this message translates to:
  /// **'Appearance > Theme Mode: System, Light, Dark or OLED. OLED is pure black and saves battery on OLED screens.'**
  String get helpGuideSettingsLookBullet1;

  /// Settings guide: accent colour and dynamic colours
  ///
  /// In en, this message translates to:
  /// **'Accent & colors: pick a main colour, or turn on Dynamic colors to match your wallpaper (Android 12 and newer).'**
  String get helpGuideSettingsLookBullet2;

  /// Settings guide: font and text size
  ///
  /// In en, this message translates to:
  /// **'Text size & font: choose the font. The text size follows the text size you set for your phone.'**
  String get helpGuideSettingsLookBullet3;

  /// Settings guide: scan frame style
  ///
  /// In en, this message translates to:
  /// **'Scan Overlay Style: choose how the scan frame looks.'**
  String get helpGuideSettingsLookBullet4;

  /// Settings guide: the language picker
  ///
  /// In en, this message translates to:
  /// **'Language: choose System default, English, Malayalam (മലയാളം) or Sanskrit (संस्कृतम्). The app changes at once, with no restart.'**
  String get helpGuideSettingsLookBullet5;

  /// Settings guide section heading: scan feedback
  ///
  /// In en, this message translates to:
  /// **'Scan feedback'**
  String get helpGuideSettingsFeedbackTitle;

  /// Settings guide: vibration, beep and animation after a scan
  ///
  /// In en, this message translates to:
  /// **'Choose whether the phone vibrates, beeps, or plays a short animation when a code is read.'**
  String get helpGuideSettingsFeedbackBullet1;

  /// Settings guide section heading: privacy and probing
  ///
  /// In en, this message translates to:
  /// **'Privacy & probing'**
  String get helpGuideSettingsPrivacyTitle;

  /// Settings guide: the active online checks switch
  ///
  /// In en, this message translates to:
  /// **'Active online checks: off unless you turn it on. See the Link safety guide.'**
  String get helpGuideSettingsPrivacyBullet1;

  /// Settings guide: app lock and screenshot guard
  ///
  /// In en, this message translates to:
  /// **'App lock and Screenshot guard: see the History, backups and privacy guide.'**
  String get helpGuideSettingsPrivacyBullet2;

  /// Settings guide: delete all data
  ///
  /// In en, this message translates to:
  /// **'Delete all data: removes your scan history, saved keys and all settings from this phone. This cannot be undone.'**
  String get helpGuideSettingsPrivacyBullet3;

  /// Settings guide section heading: other settings
  ///
  /// In en, this message translates to:
  /// **'Other settings'**
  String get helpGuideSettingsOtherTitle;

  /// Settings guide: URL safety providers
  ///
  /// In en, this message translates to:
  /// **'URL Safety Providers: turn on extra online link checkers.'**
  String get helpGuideSettingsOtherBullet1;

  /// Settings guide: AirQR optical sync
  ///
  /// In en, this message translates to:
  /// **'AirQR Optical Sync: move your history and settings to another phone.'**
  String get helpGuideSettingsOtherBullet2;

  /// Settings guide: the scan bubble
  ///
  /// In en, this message translates to:
  /// **'Scan bubble: a floating button to scan codes in other apps.'**
  String get helpGuideSettingsOtherBullet3;

  /// Settings guide: the permissions screen
  ///
  /// In en, this message translates to:
  /// **'Permissions: a plain list of what the app may use, and why. The app asks for each one only when a feature needs it.'**
  String get helpGuideSettingsOtherBullet4;

  /// Settings guide: features, welcome tour and about
  ///
  /// In en, this message translates to:
  /// **'Features lists everything the app can do. Welcome Tour shows the first-start introduction again. About shows the app version and licences.'**
  String get helpGuideSettingsOtherBullet5;

  /// Settings guide section heading: saving battery
  ///
  /// In en, this message translates to:
  /// **'Saving battery'**
  String get helpGuideSettingsBatteryTitle;

  /// Settings guide: the camera turns off on its own
  ///
  /// In en, this message translates to:
  /// **'The camera turns off as soon as you leave the Scan screen or the app.'**
  String get helpGuideSettingsBatteryBullet1;

  /// Settings guide: choose 720p to use less power
  ///
  /// In en, this message translates to:
  /// **'Choose 720p in Camera adjustments to use less power.'**
  String get helpGuideSettingsBatteryBullet2;

  /// Settings guide: turn off the scan bubble when not needed
  ///
  /// In en, this message translates to:
  /// **'Turn off the Scan bubble when you do not need it.'**
  String get helpGuideSettingsBatteryBullet3;

  /// Settings guide: the OLED theme saves battery
  ///
  /// In en, this message translates to:
  /// **'Use the OLED theme on phones with an OLED screen.'**
  String get helpGuideSettingsBatteryBullet4;

  /// Tip at the end of the settings guide
  ///
  /// In en, this message translates to:
  /// **'Tip: Not sure where something is? Every guide here names the button to tap.'**
  String get helpGuideSettingsTip;

  /// Help hub card title for the FAQ
  ///
  /// In en, this message translates to:
  /// **'FAQ and problems'**
  String get helpGuideFaqName;

  /// Help hub card summary for the FAQ
  ///
  /// In en, this message translates to:
  /// **'Answers to common questions, and fixes when something does not work.'**
  String get helpGuideFaqSummary;

  /// Opening paragraph of the FAQ
  ///
  /// In en, this message translates to:
  /// **'Quick answers to common questions, and what to do when something does not work.'**
  String get helpGuideFaqIntro;

  /// FAQ section heading: common questions
  ///
  /// In en, this message translates to:
  /// **'Common questions'**
  String get helpGuideFaqQuestionsTitle;

  /// FAQ question and answer: does the app work offline (question, newline, answer)
  ///
  /// In en, this message translates to:
  /// **'Does the app work without internet?\nYes. Reading codes, the first four link checks and QuishingGuard all work offline. Only the optional online checks need the internet.'**
  String get helpGuideFaqQuestion1;

  /// FAQ question and answer: are camera pictures sent anywhere
  ///
  /// In en, this message translates to:
  /// **'Are my camera pictures sent anywhere?\nNo. Pictures are read on your phone and are never saved or uploaded.'**
  String get helpGuideFaqQuestion2;

  /// FAQ question and answer: does the app collect data about the user
  ///
  /// In en, this message translates to:
  /// **'Does the app collect data about me?\nNo. There are no ads, no tracking and no analytics. Your history stays on your phone.'**
  String get helpGuideFaqQuestion3;

  /// FAQ question and answer: why the app asks for a permission
  ///
  /// In en, this message translates to:
  /// **'Why does the app ask for a permission?\nOnly when you use a feature that needs it, such as the camera for scanning. See Settings > Permissions for the full list.'**
  String get helpGuideFaqQuestion4;

  /// FAQ question and answer: how to change the language
  ///
  /// In en, this message translates to:
  /// **'How do I change the language?\nGo to Settings > Language. The app changes at once.'**
  String get helpGuideFaqQuestion5;

  /// FAQ question and answer: how to delete everything
  ///
  /// In en, this message translates to:
  /// **'How do I delete everything?\nGo to Settings > Privacy & probing > Delete all data. You can also delete single scans in History.'**
  String get helpGuideFaqQuestion6;

  /// FAQ question and answer: why a trusted link is marked unsafe
  ///
  /// In en, this message translates to:
  /// **'A link I trust is marked unsafe. Why?\nThe checks look for warning signs, and some real sites have them too. If you are sure about the source, you can still open it.'**
  String get helpGuideFaqQuestion7;

  /// FAQ question and answer: battery use
  ///
  /// In en, this message translates to:
  /// **'Does the app use a lot of battery?\nNo. The camera stops as soon as you leave the Scan screen. See the Settings guide for more battery tips.'**
  String get helpGuideFaqQuestion8;

  /// FAQ section heading: when a code will not scan
  ///
  /// In en, this message translates to:
  /// **'When a code will not scan'**
  String get helpGuideFaqCameraTitle;

  /// FAQ: clean the lens and hold the phone at the right distance
  ///
  /// In en, this message translates to:
  /// **'Clean the camera lens and hold the phone about 15 to 20 cm (6 to 8 inches) from the code.'**
  String get helpGuideFaqCameraBullet1;

  /// FAQ: dark places and shiny codes
  ///
  /// In en, this message translates to:
  /// **'In a dark place, turn on the flash. For a shiny code, tilt the phone a little to remove the glare.'**
  String get helpGuideFaqCameraBullet2;

  /// FAQ: small or far-away codes
  ///
  /// In en, this message translates to:
  /// **'For a small or far-away code, use the zoom slider or Distance Scan Assist, instead of moving very close.'**
  String get helpGuideFaqCameraBullet3;

  /// FAQ: light codes on a dark background
  ///
  /// In en, this message translates to:
  /// **'For a light code on a dark background, turn on Invert colors in Camera adjustments.'**
  String get helpGuideFaqCameraBullet4;

  /// FAQ: damaged or faded codes
  ///
  /// In en, this message translates to:
  /// **'For a damaged or faded code, try Brightness and Contrast in Camera adjustments, or take a photo and scan it from the gallery.'**
  String get helpGuideFaqCameraBullet5;

  /// FAQ section heading: other problems
  ///
  /// In en, this message translates to:
  /// **'Other problems'**
  String get helpGuideFaqFixTitle;

  /// FAQ: the camera does not open because permission was refused
  ///
  /// In en, this message translates to:
  /// **'Camera does not open: if you said no to the camera, go to Android Settings > Apps > SreerajP QR Studio > Permissions > Camera and choose Allow.'**
  String get helpGuideFaqFixBullet1;

  /// FAQ: Wi-Fi will not connect
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi will not connect: copy the password and join the network in your phone\'s Wi-Fi settings.'**
  String get helpGuideFaqFixBullet2;

  /// FAQ: the payment app does not open
  ///
  /// In en, this message translates to:
  /// **'Payment app does not open: make sure a UPI app is installed. You can also copy the UPI ID.'**
  String get helpGuideFaqFixBullet3;

  /// FAQ: the scan bubble keeps disappearing
  ///
  /// In en, this message translates to:
  /// **'Scan bubble keeps disappearing: some phones stop apps in the background. Allow this app in your phone\'s battery settings.'**
  String get helpGuideFaqFixBullet4;

  /// FAQ: an online check shows as skipped
  ///
  /// In en, this message translates to:
  /// **'An online check says Skipped: that checker is turned off, or has no key. Tap Set up in Settings on the result to fix it.'**
  String get helpGuideFaqFixBullet5;

  /// Tip at the end of the FAQ
  ///
  /// In en, this message translates to:
  /// **'Tip: Still stuck? Take a clear photo of the code and scan it from the gallery.'**
  String get helpGuideFaqTip;

  /// App bar title of the scanning guide
  ///
  /// In en, this message translates to:
  /// **'Scanning codes'**
  String get titleHelpBarcode;

  /// App bar title of the AR CodeVision help screen. Short label.
  ///
  /// In en, this message translates to:
  /// **'AR CodeVision'**
  String get titleHelpArCodeVision;

  /// App bar title of the AirQR help screen. Short label.
  ///
  /// In en, this message translates to:
  /// **'AirQR guide'**
  String get titleHelpAirQr;

  /// App bar title of the link safety guide
  ///
  /// In en, this message translates to:
  /// **'Link safety'**
  String get titleHelpUrlSafety;

  /// App bar title of the QuishingGuard help screen. Short label.
  ///
  /// In en, this message translates to:
  /// **'QuishingGuard'**
  String get titleHelpQuishing;

  /// App bar title of the online checker setup guide
  ///
  /// In en, this message translates to:
  /// **'Online checkers'**
  String get titleHelpSafeBrowsing;

  /// App bar title of the Smart Actions & Payments help screen. Short label.
  ///
  /// In en, this message translates to:
  /// **'Smart actions'**
  String get titleHelpSmartPayloads;

  /// App bar title of the History, Backups & Privacy help screen. Short label.
  ///
  /// In en, this message translates to:
  /// **'History & privacy'**
  String get titleHelpHistory;

  /// App bar title of the FAQ & Troubleshooting help screen. Short label.
  ///
  /// In en, this message translates to:
  /// **'FAQ & help'**
  String get titleHelpFaq;

  /// App bar title of the guide on scanning codes shown in other apps
  ///
  /// In en, this message translates to:
  /// **'Scan from other apps'**
  String get titleHelpScanBubble;

  /// App bar title of the CodeForge guide (making your own codes)
  ///
  /// In en, this message translates to:
  /// **'Making codes'**
  String get titleHelpCodeForge;

  /// App bar title of the guide on hidden and locked codes
  ///
  /// In en, this message translates to:
  /// **'Locked codes'**
  String get titleHelpHiddenCodes;

  /// App bar title of the settings guide
  ///
  /// In en, this message translates to:
  /// **'Settings guide'**
  String get titleHelpSettings;

  /// Tooltip and sheet title for the menu of extra actions on the scan result screen
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get tooltipResultMoreActions;

  /// Shown in the safety summary card while link checks are running
  ///
  /// In en, this message translates to:
  /// **'Checking link safety…'**
  String get bodyVerdictChecking;

  /// Safety summary headline when no link check failed
  ///
  /// In en, this message translates to:
  /// **'No issues found'**
  String get bodyVerdictNoIssues;

  /// Safety summary headline with the number of failed link checks
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 issue found} other{{count} issues found}}'**
  String bodyVerdictIssuesFound(int count);

  /// Safety summary line: how many link checks passed out of all checks
  ///
  /// In en, this message translates to:
  /// **'{passed} of {total} checks passed'**
  String bodyVerdictChecksPassed(int passed, int total);

  /// Link in the safety summary card that scrolls to the full safety check list
  ///
  /// In en, this message translates to:
  /// **'See details'**
  String get actionVerdictSeeDetails;

  /// Short label: link checks ran without contacting the site
  ///
  /// In en, this message translates to:
  /// **'Private mode'**
  String get labelVerdictModePrivate;

  /// Short label: link checks contacted the site directly
  ///
  /// In en, this message translates to:
  /// **'Active probing'**
  String get labelVerdictModeActive;

  /// Toggle that shows the folded list of passed safety checks
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Show 1 passed} other{Show {count} passed}}'**
  String actionSafetyShowPassed(int count);

  /// Toggle that folds the list of passed safety checks
  ///
  /// In en, this message translates to:
  /// **'Hide passed checks'**
  String get actionSafetyHidePassed;

  /// One line that groups safety checks that did not run (no API key or service off)
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 check skipped} other{{count} skipped}}'**
  String actionSafetySkippedGroup(int count);

  /// Button that opens Settings so the user can turn on skipped safety checks
  ///
  /// In en, this message translates to:
  /// **'Set up in Settings'**
  String get actionSafetySkippedSetup;

  /// Confirm dialog text before opening a link that failed some safety checks
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{This link has 1 issue. Open it anyway?} other{This link has {count} issues. Open it anyway?}}'**
  String bodyOpenRiskDialogIssues(int count);

  /// Tooltip to unfold the sandboxed page preview
  ///
  /// In en, this message translates to:
  /// **'Show preview'**
  String get tooltipSandboxShowPreview;

  /// Tooltip to fold the sandboxed page preview
  ///
  /// In en, this message translates to:
  /// **'Hide preview'**
  String get tooltipSandboxHidePreview;

  /// Title of the floating Scan bubble feature (settings tile, screen title, menu item). Keep short.
  ///
  /// In en, this message translates to:
  /// **'Scan bubble'**
  String get labelScanBubble;

  /// Subtitle of the Scan bubble tile on the Settings screen
  ///
  /// In en, this message translates to:
  /// **'Scan codes shown in other apps'**
  String get descScanBubbleSettings;

  /// Switch label that turns the floating Scan bubble on or off
  ///
  /// In en, this message translates to:
  /// **'Show scan bubble'**
  String get labelScanBubbleSwitch;

  /// Explanation under the Scan bubble on/off switch
  ///
  /// In en, this message translates to:
  /// **'A small button that floats over other apps. Tap it to scan a code on the screen.'**
  String get descScanBubbleSwitch;

  /// Status shown when the Display over other apps permission is granted
  ///
  /// In en, this message translates to:
  /// **'Allowed'**
  String get descScanBubblePermissionGranted;

  /// Status shown when the Display over other apps permission is not granted
  ///
  /// In en, this message translates to:
  /// **'Not allowed yet. Needed for the bubble.'**
  String get descScanBubblePermissionMissing;

  /// Button that starts the Display over other apps permission flow
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get actionScanBubbleAllow;

  /// Switch label: show the bubble again after the phone restarts. Keep short.
  ///
  /// In en, this message translates to:
  /// **'Start after restart'**
  String get labelScanBubbleStartOnBoot;

  /// Explanation under the start after restart switch
  ///
  /// In en, this message translates to:
  /// **'If the bubble was on, show it again after the phone restarts. Some phones may block this.'**
  String get descScanBubbleStartOnBoot;

  /// Button that asks Android to add the Scan bubble Quick Settings tile. Keep short.
  ///
  /// In en, this message translates to:
  /// **'Add Settings tile'**
  String get actionScanBubbleAddTile;

  /// Message after the request to add the Scan bubble tile was sent
  ///
  /// In en, this message translates to:
  /// **'Quick Settings tile request sent'**
  String get bodyScanBubbleTileAdded;

  /// Message telling the user how to add the Scan bubble tile by hand
  ///
  /// In en, this message translates to:
  /// **'Pull down Quick Settings, tap the edit (pencil) button, and drag the Scan bubble tile in.'**
  String get bodyScanBubbleTileManual;

  /// Title of the dialog that explains the Display over other apps permission
  ///
  /// In en, this message translates to:
  /// **'Allow the bubble'**
  String get titleScanBubblePermissionDialog;

  /// Body of the dialog that explains the Display over other apps permission
  ///
  /// In en, this message translates to:
  /// **'To float over other apps, the bubble needs the \"Display over other apps\" permission. On the next page, turn it on for this app, then come back.'**
  String get bodyScanBubblePermissionDialog;

  /// Button that opens the Android permission page
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get actionScanBubbleOpenSettings;

  /// Error shown when Android refuses to start the bubble
  ///
  /// In en, this message translates to:
  /// **'Could not start the bubble. Please try again.'**
  String get errorScanBubbleStartFailed;

  /// Message shown when the screen capture came back black because the app on screen blocks capture
  ///
  /// In en, this message translates to:
  /// **'This app blocks screen capture, so its codes cannot be read.'**
  String get errorScanBubbleBlockedCapture;

  /// Label on a history item that was read from a picture of the phone screen (GhostScan or Scan bubble)
  ///
  /// In en, this message translates to:
  /// **'From screen'**
  String get labelHistorySourceScreen;

  /// CodeForge: heading above the text box for 1D/2D barcode content.
  ///
  /// In en, this message translates to:
  /// **'Barcode content'**
  String get labelCodeForgeBarcodeContent;

  /// CodeForge: hint text inside the barcode content text box.
  ///
  /// In en, this message translates to:
  /// **'Enter the barcode number or code'**
  String get helpCodeForgeBarcodeContent;

  /// CodeForge Wi-Fi form: security option for an open network with no password.
  ///
  /// In en, this message translates to:
  /// **'None (open)'**
  String get labelCodeForgeWifiSecurityNone;

  /// CodeForge UPI form: example hint for the UPI ID field. Keep 'merchant@upi' as an example ID.
  ///
  /// In en, this message translates to:
  /// **'e.g. merchant@upi'**
  String get helpCodeForgeUpiVpa;

  /// Hint text inside a form field the user may leave empty.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get labelOptionalField;

  /// CodeForge validation error: the code has no content.
  ///
  /// In en, this message translates to:
  /// **'Content cannot be empty'**
  String get errorCodeForgeContentEmpty;

  /// CodeForge validation error: text is over the length limit.
  ///
  /// In en, this message translates to:
  /// **'Text must not be longer than {max} characters'**
  String errorCodeForgeTextTooLong(String max);

  /// CodeForge validation error: Wi-Fi network name is missing.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi network name (SSID) is required'**
  String get errorCodeForgeWifiSsidRequired;

  /// CodeForge validation error: UPI ID (VPA) is missing.
  ///
  /// In en, this message translates to:
  /// **'UPI ID is required'**
  String get errorCodeForgeUpiVpaRequired;

  /// CodeForge validation error: content does not fit the chosen barcode type. {detail} is a short technical reason from the barcode library, in English.
  ///
  /// In en, this message translates to:
  /// **'Not valid for this barcode type ({detail})'**
  String errorCodeForgeBarcodeInvalid(String detail);

  /// Result screen: card title after an encrypted AirQR payload is decrypted.
  ///
  /// In en, this message translates to:
  /// **'AirQR unlocked'**
  String get titleAirQrUnlocked;

  /// Result screen: card title after an encrypted JSON container is decrypted.
  ///
  /// In en, this message translates to:
  /// **'JSON unlocked'**
  String get titleJsonEnvelopeUnlocked;

  /// Result screen: card title after hidden StegoQR content is decrypted.
  ///
  /// In en, this message translates to:
  /// **'StegoQR unlocked'**
  String get titleStegoUnlocked;

  /// Result screen: card title when a StegoQR code with hidden encrypted content is found.
  ///
  /// In en, this message translates to:
  /// **'StegoQR found'**
  String get titleStegoDetected;

  /// Decrypt sheet: button that shows the advanced Salt and IV fields. Keep Salt and IV as technical terms.
  ///
  /// In en, this message translates to:
  /// **'Advanced (Salt / IV)'**
  String get actionDecryptShowAdvanced;

  /// Decrypt sheet: button that hides the advanced Salt and IV fields.
  ///
  /// In en, this message translates to:
  /// **'Hide advanced'**
  String get actionDecryptHideAdvanced;

  /// Decrypt sheet: label of the optional Salt field (cryptography term).
  ///
  /// In en, this message translates to:
  /// **'Salt (Base64)'**
  String get labelDecryptSalt;

  /// Decrypt sheet: label of the optional IV / nonce field (cryptography term).
  ///
  /// In en, this message translates to:
  /// **'IV / Nonce (Base64)'**
  String get labelDecryptIv;

  /// History screen: number of scan records shown.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 scan record found} other{{count} scan records found}}'**
  String bodyHistoryRecordCount(int count);

  /// AR CodeVision: number of codes the user has selected.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item selected} other{{count} items selected}}'**
  String bodyArItemsSelected(int count);

  /// Settings: subtitle of the Appearance card. {themeMode} is the current theme name.
  ///
  /// In en, this message translates to:
  /// **'{themeMode} • Dynamic colors'**
  String descSettingsAppearanceSummary(String themeMode);

  /// URL safety providers: shown when the OpenPhish list has never been downloaded.
  ///
  /// In en, this message translates to:
  /// **'Feed not downloaded yet'**
  String get bodyOpenPhishFeedNotDownloaded;

  /// Accent color settings: info box explaining Dynamic Color.
  ///
  /// In en, this message translates to:
  /// **'Dynamic Color builds a matching palette from your Android wallpaper (Android 12+). When it is off, the standard high-contrast security palette is used.'**
  String get helpAccentDynamicColor;

  /// Typography settings: sample line in the text-size preview. Product names stay as they are.
  ///
  /// In en, this message translates to:
  /// **'6-Layer URL Safety Check • 100% Offline QuishingGuard™ CV Engine'**
  String get bodyTypographySample;

  /// Typography settings: heading above the text-size slider.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get labelTypographyScale;

  /// Typography settings: info box explaining how text size works.
  ///
  /// In en, this message translates to:
  /// **'The app follows your Android accessibility text size, while keeping the scan frame and on-screen labels easy to read.'**
  String get helpTypographyScale;

  /// Sandbox preview: page title when the page could not be loaded. {host} is the site address.
  ///
  /// In en, this message translates to:
  /// **'{host} (offline or network blocked)'**
  String bodyDomFetchFailed(String host);

  /// Scanner: tooltip of the button that pauses scanning.
  ///
  /// In en, this message translates to:
  /// **'Pause scanning'**
  String get tooltipScanPause;

  /// Scanner: tooltip of the button that resumes scanning.
  ///
  /// In en, this message translates to:
  /// **'Resume scanning'**
  String get tooltipScanResume;

  /// AR CodeVision: switch label for Warehouse mode (price/batch info, select codes, Batch Copy).
  ///
  /// In en, this message translates to:
  /// **'Warehouse'**
  String get labelArModeWarehouse;

  /// AR CodeVision: switch label for Safety mode (link safety badge on each code).
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get labelArModeSafety;

  /// AR CodeVision: tooltip of the Warehouse mode switch.
  ///
  /// In en, this message translates to:
  /// **'Item info & select'**
  String get tooltipArModeWarehouse;

  /// AR CodeVision: tooltip of the Safety mode switch.
  ///
  /// In en, this message translates to:
  /// **'Link safety badges'**
  String get tooltipArModeSafety;

  /// Camera screens: shown when the camera fails to start.
  ///
  /// In en, this message translates to:
  /// **'Camera could not start'**
  String get errorCameraStartFailed;

  /// Camera screens: shown when the phone has no usable camera.
  ///
  /// In en, this message translates to:
  /// **'No camera found on this phone'**
  String get errorCameraNotFound;

  /// Camera screens: button that tries to start the camera again.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get actionCameraRetry;

  /// CodeForge link safety banner: text shown before the link has been checked.
  ///
  /// In en, this message translates to:
  /// **'Check this link before you share it'**
  String get bodyCodeForgeSafetyPrompt;

  /// CodeForge link safety banner: button that runs the link safety checks.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get actionCodeForgeSafetyCheck;

  /// CodeForge link safety banner: shown when the safety checks found problems.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 problem found in this link} other{{count} problems found in this link}}'**
  String bodyCodeForgeSafetyProblems(int count);

  /// CodeForge link safety banner: button that runs the checks again after problems were found.
  ///
  /// In en, this message translates to:
  /// **'Check again'**
  String get actionCodeForgeSafetyCheckAgain;

  /// Settings tile that deletes all app data. Keep short.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get labelDeleteAllData;

  /// Subtitle under the "Delete all data" tile.
  ///
  /// In en, this message translates to:
  /// **'Remove scan history, saved API keys and all settings from this phone.'**
  String get descDeleteAllData;

  /// Title of the dialog that confirms deleting all data.
  ///
  /// In en, this message translates to:
  /// **'Delete all data?'**
  String get titleDeleteAllDataConfirm;

  /// Body of the dialog that confirms deleting all data: lists what is deleted.
  ///
  /// In en, this message translates to:
  /// **'This deletes your scan history, saved API keys, all settings, Scan bubble settings and temporary files. This cannot be undone.'**
  String get bodyDeleteAllDataConfirm;

  /// Destructive confirm button in the delete-all-data dialog. Keep short.
  ///
  /// In en, this message translates to:
  /// **'Delete all'**
  String get actionDeleteAll;

  /// Shown while all data is being deleted.
  ///
  /// In en, this message translates to:
  /// **'Deleting all data…'**
  String get bodyDeletingAllData;

  /// Snackbar when one or more stores could not be deleted.
  ///
  /// In en, this message translates to:
  /// **'Some data could not be deleted.'**
  String get errorDeleteAllDataPartial;

  /// Shown on the History screen when the saved history cannot be read.
  ///
  /// In en, this message translates to:
  /// **'History could not be loaded.'**
  String get errorHistoryLoadFailed;

  /// Button that retries a failed action. Keep short.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get actionTryAgain;

  /// About screen row label for the privacy policy link.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get aboutDetailPrivacyPolicy;

  /// Shown while the encrypted backup is being made (takes a few seconds).
  ///
  /// In en, this message translates to:
  /// **'Protecting your backup…'**
  String get bodyEncryptingBackup;

  /// Shown while an encrypted backup is being opened for restore (takes a few seconds).
  ///
  /// In en, this message translates to:
  /// **'Opening the backup…'**
  String get bodyOpeningBackup;

  /// Shown while the encrypted AirQR sync package is being made (takes a few seconds).
  ///
  /// In en, this message translates to:
  /// **'Protecting the sync package…'**
  String get bodyEncryptingSync;

  /// Title of the warning shown before a plain-text (CSV, JSON, TXT, PDF) export. Keep short.
  ///
  /// In en, this message translates to:
  /// **'Export unencrypted?'**
  String get titlePlainExport;

  /// Body of the warning shown before a plain-text export.
  ///
  /// In en, this message translates to:
  /// **'This file is not encrypted. Anyone who gets it can read your scans.'**
  String get bodyPlainExport;

  /// Extra line in the plain-text export warning on the history export dialog, pointing to the encrypted backup.
  ///
  /// In en, this message translates to:
  /// **'To keep it private, use the encrypted backup instead.'**
  String get bodyPlainExportBackupHint;

  /// Button that continues a plain-text export after the warning. Keep short.
  ///
  /// In en, this message translates to:
  /// **'Export anyway'**
  String get actionExportAnyway;

  /// Settings switch label for the optional app lock. Keep short.
  ///
  /// In en, this message translates to:
  /// **'App lock'**
  String get labelAppLock;

  /// Settings switch description for the optional app lock.
  ///
  /// In en, this message translates to:
  /// **'Ask for fingerprint, face or screen lock when the app opens, and after 30 seconds away.'**
  String get descAppLock;

  /// Privacy settings switch label: block screenshots and screen recording (FLAG_SECURE) on sensitive screens. Keep short.
  ///
  /// In en, this message translates to:
  /// **'Screenshot guard'**
  String get labelScreenshotGuard;

  /// Privacy settings switch description for the screenshot guard.
  ///
  /// In en, this message translates to:
  /// **'Block screenshots and screen recording on screens that show scans, history, secrets or API keys. These screens also stay blank in recent apps.'**
  String get descScreenshotGuard;

  /// Title on the lock screen. Keep short.
  ///
  /// In en, this message translates to:
  /// **'App locked'**
  String get titleAppLocked;

  /// Text on the lock screen.
  ///
  /// In en, this message translates to:
  /// **'Unlock with your fingerprint, face or screen lock to continue.'**
  String get bodyAppLocked;

  /// Lock screen button that opens the system unlock prompt. Keep short.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get actionUnlock;

  /// Reason text shown inside the Android fingerprint / screen lock prompt for the app lock.
  ///
  /// In en, this message translates to:
  /// **'Unlock SreerajP QR Studio'**
  String get bodyAppLockReason;

  /// Shown when the app lock cannot be turned on because the phone has no screen lock or biometrics.
  ///
  /// In en, this message translates to:
  /// **'Set up a screen lock or fingerprint on this phone first.'**
  String get errorAppLockUnavailable;

  /// Shown when fingerprint, face or screen lock authentication fails or is cancelled.
  ///
  /// In en, this message translates to:
  /// **'Could not confirm it is you. Try again.'**
  String get errorAppLockFailed;

  /// Title of the result card for a scanned driving licence or ID card barcode (max 20 characters)
  ///
  /// In en, this message translates to:
  /// **'ID card'**
  String get titleIdCard;

  /// ID card result: label for the card holder's full name
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get labelIdCardName;

  /// ID card result: label for the card holder's date of birth
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get labelIdCardBirthDate;

  /// ID card result: label for the date the card stops being valid
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get labelIdCardExpiry;

  /// ID card result: label for the licence or ID number (shown masked until the user taps Show)
  ///
  /// In en, this message translates to:
  /// **'Document number'**
  String get labelIdCardNumber;

  /// ID card result: label for the state or province (and country) that issued the card
  ///
  /// In en, this message translates to:
  /// **'Issued by'**
  String get labelIdCardIssuer;

  /// ID card result: label for the card holder's home address
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get labelIdCardAddress;

  /// ID card result: button that reveals the masked document number
  ///
  /// In en, this message translates to:
  /// **'Show number'**
  String get actionIdCardShowNumber;

  /// ID card result: button that masks the document number again
  ///
  /// In en, this message translates to:
  /// **'Hide number'**
  String get actionIdCardHideNumber;

  /// ID card result: button that copies the shown card details to the clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy details'**
  String get actionIdCardCopy;

  /// ID card result: note that scans of ID cards are never stored in the scan history
  ///
  /// In en, this message translates to:
  /// **'ID card data is not saved to history.'**
  String get bodyIdCardNotSaved;

  /// Smart actions guide: what the ID card result shows, and that it is not saved to history
  ///
  /// In en, this message translates to:
  /// **'ID card (US or Canadian driving licence): see the name, dates and address. The number stays hidden until you tap Show. ID cards are never saved to history.'**
  String get helpGuideSmartPayloadsOtherBullet7;
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
