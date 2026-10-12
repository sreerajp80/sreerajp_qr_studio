import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';

/// Works out what kind of data a decoded code carries, fully offline.
///
/// The decoder only returns text. This classifier gives the same broad
/// categories the rest of the app already works with (URL, Wi-Fi, contact,
/// product, …). It never throws: any unexpected input is [CodeContentType.text]
/// or [CodeContentType.unknown].
class BarcodeContentClassifier {
  const BarcodeContentClassifier();

  static final RegExp _emailPattern = RegExp(
    r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$',
  );
  static final RegExp _bareWebPattern = RegExp(
    r'^www\.[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)*\.[A-Za-z]{2,}([/?#]\S*)?$',
    caseSensitive: false,
  );
  static final RegExp _digitsOnly = RegExp(r'^\d+$');

  /// Classifies [rawValue] decoded from a code of [format].
  CodeContentType classify(String? rawValue, CodeFormat format) {
    if (rawValue == null) return CodeContentType.unknown;
    final value = rawValue.trim();
    if (value.isEmpty) return CodeContentType.unknown;

    if (format.isRetail) {
      if (format == CodeFormat.ean13 &&
          _digitsOnly.hasMatch(value) &&
          (value.startsWith('978') || value.startsWith('979'))) {
        return CodeContentType.isbn;
      }
      return CodeContentType.product;
    }

    if (format == CodeFormat.pdf417 && _isDriverLicense(value)) {
      return CodeContentType.driverLicense;
    }

    final lower = value.toLowerCase();

    if (lower.startsWith('http://') ||
        lower.startsWith('https://') ||
        lower.startsWith('urlto:') ||
        lower.startsWith('mebkm:') ||
        _bareWebPattern.hasMatch(value)) {
      return CodeContentType.url;
    }
    if (lower.startsWith('wifi:')) return CodeContentType.wifi;
    if (lower.startsWith('begin:vcard') ||
        lower.startsWith('mecard:') ||
        lower.startsWith('bizcard:')) {
      return CodeContentType.contactInfo;
    }
    if (lower.startsWith('begin:vevent') ||
        (lower.startsWith('begin:vcalendar') &&
            lower.contains('begin:vevent'))) {
      return CodeContentType.calendarEvent;
    }
    if (lower.startsWith('mailto:') ||
        lower.startsWith('matmsg:') ||
        _emailPattern.hasMatch(value)) {
      return CodeContentType.email;
    }
    if (lower.startsWith('tel:')) return CodeContentType.phone;
    if (lower.startsWith('sms:') ||
        lower.startsWith('smsto:') ||
        lower.startsWith('mms:') ||
        lower.startsWith('mmsto:')) {
      return CodeContentType.sms;
    }
    if (lower.startsWith('geo:')) return CodeContentType.geo;

    return CodeContentType.text;
  }

  /// AAMVA driver licence / ID card data (PDF417 on the back of US/CA IDs).
  bool _isDriverLicense(String value) {
    if (!value.startsWith('@')) return false;
    final head = value.length > 40 ? value.substring(0, 40) : value;
    return head.contains('ANSI ') || head.contains('AAMVA');
  }
}
