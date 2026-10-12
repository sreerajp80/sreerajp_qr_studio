import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sreerajp_qr_studio/models/parsed_payload.dart';

/// Helper service for performing native 1-tap actions on parsed QR payloads.
class PayloadActionService {
  /// Opens system Wi-Fi settings or Wi-Fi configuration screen.
  static Future<bool> openWifiSettings() async {
    try {
      final intentUri = Uri.parse(
        'intent:#Intent;action=android.settings.WIFI_SETTINGS;end',
      );
      if (await canLaunchUrl(intentUri)) {
        return await launchUrl(intentUri, mode: LaunchMode.externalApplication);
      }
      // Fallback to settings URI
      final settingsUri = Uri.parse('android.settings.WIFI_SETTINGS');
      if (await canLaunchUrl(settingsUri)) {
        return await launchUrl(
          settingsUri,
          mode: LaunchMode.externalApplication,
        );
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Opens Google Maps with coordinates.
  static Future<bool> openGoogleMaps(GeoPayload geo) async {
    final mapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${geo.latitude},${geo.longitude}',
    );
    if (await canLaunchUrl(mapsUrl)) {
      return await launchUrl(mapsUrl, mode: LaunchMode.externalApplication);
    }
    final geoUri = Uri.parse('geo:${geo.latitude},${geo.longitude}');
    if (await canLaunchUrl(geoUri)) {
      return await launchUrl(geoUri, mode: LaunchMode.externalApplication);
    }
    return false;
  }

  /// Launches device contact card insertion or phone/email intents.
  static Future<bool> saveContact(ContactPayload contact) async {
    // Android Insert Contact Intent
    final nameEncoded = Uri.encodeComponent(contact.name);
    final phoneEncoded = contact.phones.isNotEmpty
        ? Uri.encodeComponent(contact.phones.first.value)
        : '';
    final emailEncoded = contact.emails.isNotEmpty
        ? Uri.encodeComponent(contact.emails.first.value)
        : '';

    final intentUri = Uri.parse(
      'intent:#Intent;action=android.intent.action.INSERT;type=vnd.android.cursor.dir/contact;'
      's.name=$nameEncoded;s.phone=$phoneEncoded;s.email=$emailEncoded;end',
    );

    if (await canLaunchUrl(intentUri)) {
      return await launchUrl(intentUri, mode: LaunchMode.externalApplication);
    }

    if (contact.phones.isNotEmpty) {
      final telUri = Uri.parse('tel:${contact.phones.first.value}');
      if (await canLaunchUrl(telUri)) {
        return await launchUrl(telUri, mode: LaunchMode.externalApplication);
      }
    }
    return false;
  }

  /// Adds event to device calendar via Google Calendar template URL or system intent.
  static Future<bool> addToCalendar(CalendarPayload calendar) async {
    String formatCalDate(DateTime? dt) {
      if (dt == null) return '';
      return '${dt.toUtc().toString().replaceAll(RegExp(r'[^0-9]'), '').substring(0, 15)}Z';
    }

    final startStr = formatCalDate(calendar.dtStart ?? DateTime.now());
    final endStr = formatCalDate(
      calendar.dtEnd ??
          (calendar.dtStart ?? DateTime.now()).add(const Duration(hours: 1)),
    );

    final calUrl = Uri.parse(
      'https://calendar.google.com/calendar/render?action=TEMPLATE'
      '&text=${Uri.encodeComponent(calendar.summary)}'
      '&details=${Uri.encodeComponent(calendar.description)}'
      '&location=${Uri.encodeComponent(calendar.location)}'
      '&dates=$startStr/$endStr',
    );

    if (await canLaunchUrl(calUrl)) {
      return await launchUrl(calUrl, mode: LaunchMode.externalApplication);
    }
    return false;
  }

  static final RegExp _upiAmountPattern = RegExp(r'^\d{1,7}(\.\d{1,2})?$');
  static final RegExp _upiAmParam = RegExp(
    r'([?&])am=[^&#]*',
    caseSensitive: false,
  );

  /// True when a UPI payload carries no usable amount (missing, empty,
  /// unparseable, or zero/negative). Some UPI apps reject such links when they
  /// are opened from another app, so the user must supply the amount first.
  static bool upiNeedsAmount(PaymentPayload payment) {
    if (payment.scheme != PaymentScheme.upi) return false;
    final value = double.tryParse(payment.amount.trim());
    return value == null || value <= 0;
  }

  /// True when [text] is a valid UPI amount: digits with up to 2 decimal
  /// places and a value of at least 1. The UPI app applies its own upper limit.
  static bool isValidUpiAmount(String text) {
    final trimmed = text.trim();
    if (!_upiAmountPattern.hasMatch(trimmed)) return false;
    final value = double.tryParse(trimmed);
    return value != null && value >= 1;
  }

  /// Returns [raw] with its `am` parameter set to [amount] (formatted to 2
  /// decimal places). An existing `am` value is replaced; otherwise `am` is
  /// appended. The rest of the link is kept byte-for-byte as scanned.
  static String withUpiAmount(String raw, String amount) {
    final formatted = double.parse(amount.trim()).toStringAsFixed(2);
    if (_upiAmParam.hasMatch(raw)) {
      return raw.replaceFirstMapped(
        _upiAmParam,
        (m) => '${m.group(1)}am=$formatted',
      );
    }
    final separator = raw.contains('?') ? '&' : '?';
    return '$raw${separator}am=$formatted';
  }

  /// Launches payment app deep link (UPI, Crypto, SEPA).
  ///
  /// For UPI, a user-entered [amount] is written into the link's `am` value.
  static Future<bool> payViaApp(
    PaymentPayload payment, {
    String? amount,
  }) async {
    final link = amount != null && payment.scheme == PaymentScheme.upi
        ? withUpiAmount(payment.rawContent, amount)
        : payment.rawContent;
    final uri = Uri.tryParse(link);
    if (uri == null) return false;
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      // Fallback direct launch attempt for custom deep link schemes
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  /// Imports TOTP payload into an authenticator app (Google Authenticator, Authy, etc.).
  static Future<bool> importToAuthenticator(TotpPayload totp) async {
    final uri = Uri.tryParse(totp.rawContent);
    if (uri == null) return false;
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  /// Opens the default email app to compose an email.
  static Future<bool> sendEmail(EmailPayload email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email.toAddress,
      queryParameters: <String, String>{
        if (email.subject.isNotEmpty) 'subject': email.subject,
        if (email.body.isNotEmpty) 'body': email.body,
        if (email.cc.isNotEmpty) 'cc': email.cc,
        if (email.bcc.isNotEmpty) 'bcc': email.bcc,
      },
    );
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  /// Opens the phone dialer with the given number.
  static Future<bool> dialPhone(PhonePayload phone) async {
    final uri = Uri.parse('tel:${phone.number}');
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  /// Opens the messaging app with the given number and optional body.
  static Future<bool> sendSms(SmsPayload sms) async {
    final uri = Uri(
      scheme: 'sms',
      path: sms.number,
      queryParameters: <String, String>{
        if (sms.body.isNotEmpty) 'body': sms.body,
      },
    );
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  /// Opens an app deep link in its native app.
  static Future<bool> openAppLink(AppLinkPayload appLink) async {
    final uri = Uri.tryParse(appLink.deepLinkUri);
    if (uri == null) return false;
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  /// Opens a product search for the given barcode on Open Food Facts and Google.
  static Future<bool> searchProduct(
    ProductBarcodePayload product, {
    bool useOpenFoodFacts = true,
  }) async {
    final String searchUrl;
    if (useOpenFoodFacts) {
      searchUrl = 'https://world.openfoodfacts.org/product/${product.code}';
    } else {
      searchUrl =
          'https://www.google.com/search?q=${Uri.encodeComponent(product.code)}+barcode';
    }
    final uri = Uri.parse(searchUrl);
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Opens a book lookup for the given ISBN on Google Books or Open Library.
  static Future<bool> lookupBook(
    IsbnPayload isbn, {
    bool useGoogleBooks = true,
  }) async {
    final String lookupUrl;
    if (useGoogleBooks) {
      lookupUrl = 'https://books.google.com/books?vid=ISBN${isbn.isbn}';
    } else {
      lookupUrl = 'https://openlibrary.org/isbn/${isbn.isbn}';
    }
    final uri = Uri.parse(lookupUrl);
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  static const MethodChannel _wifiChannel = MethodChannel(
    'in.sreerajp.qr_studio/wifi',
  );

  /// Connects to a Wi-Fi network using Android's native Wi-Fi suggestion or configuration API.
  /// Falls back to openWifiSettings() only if native connection fails or is unavailable.
  static Future<bool> connectToWifi(WifiPayload wifi) async {
    try {
      final bool? success = await _wifiChannel.invokeMethod<bool>(
        'connectWifi',
        {
          'ssid': wifi.ssid,
          'password': wifi.password,
          'securityType': wifi.securityType,
          'isHidden': wifi.isHidden,
        },
      );
      if (success == true) {
        return true;
      }
    } catch (_) {
      // MethodChannel not available or failed on platform
    }
    return openWifiSettings();
  }
}
