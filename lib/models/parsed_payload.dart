import 'package:flutter/foundation.dart';

/// Enum representing the recognized smart payload types.
enum PayloadType {
  wifi,
  contact,
  geo,
  calendar,
  payment,
  totp,
  email,
  phone,
  sms,
  appLink,
  productBarcode,
  isbn,
  generic,
}

/// Sealed / abstract base class representing a parsed QR code payload.
@immutable
abstract class ParsedPayload {
  final PayloadType type;
  final String rawContent;

  const ParsedPayload({required this.type, required this.rawContent});
}

/// Generic fallback payload when no specific schema is matched.
class GenericPayload extends ParsedPayload {
  const GenericPayload(String rawContent)
    : super(type: PayloadType.generic, rawContent: rawContent);
}

/// Wi-Fi Network Payload (WIFI:S:ssid;T:WPA;P:pass;H:false;;)
class WifiPayload extends ParsedPayload {
  final String ssid;
  final String securityType;
  final String password;
  final bool isHidden;

  const WifiPayload({
    required super.rawContent,
    required this.ssid,
    this.securityType = 'WPA',
    this.password = '',
    this.isHidden = false,
  }) : super(type: PayloadType.wifi);
}

/// Contact field item (label + value)
@immutable
class ContactField {
  final String label;
  final String value;

  const ContactField({required this.label, required this.value});
}

/// Contact Card Payload (vCard / MeCard)
class ContactPayload extends ParsedPayload {
  final String name;
  final List<ContactField> phones;
  final List<ContactField> emails;
  final List<String> addresses;
  final String organization;
  final String title;
  final String url;

  const ContactPayload({
    required super.rawContent,
    required this.name,
    this.phones = const [],
    this.emails = const [],
    this.addresses = const [],
    this.organization = '',
    this.title = '',
    this.url = '',
  }) : super(type: PayloadType.contact);
}

/// Geographic Location Payload (geo:lat,lng?q=query)
class GeoPayload extends ParsedPayload {
  final double latitude;
  final double longitude;
  final String query;
  final String label;

  const GeoPayload({
    required super.rawContent,
    required this.latitude,
    required this.longitude,
    this.query = '',
    this.label = '',
  }) : super(type: PayloadType.geo);
}

/// Calendar Event Payload (BEGIN:VEVENT)
class CalendarPayload extends ParsedPayload {
  final String summary;
  final String description;
  final String location;
  final DateTime? dtStart;
  final DateTime? dtEnd;
  final bool isAllDay;

  const CalendarPayload({
    required super.rawContent,
    required this.summary,
    this.description = '',
    this.location = '',
    this.dtStart,
    this.dtEnd,
    this.isAllDay = false,
  }) : super(type: PayloadType.calendar);
}

/// Supported payment schemes
enum PaymentScheme { upi, sepa, crypto }

/// Payment Code Payload (upi://pay, SEPA BCD, Crypto URIs)
class PaymentPayload extends ParsedPayload {
  final PaymentScheme scheme;
  final String payeeName;
  final String payeeAddress;
  final String amount;
  final String currency;
  final String transactionNote;
  final String refId;

  const PaymentPayload({
    required super.rawContent,
    required this.scheme,
    required this.payeeName,
    required this.payeeAddress,
    this.amount = '',
    this.currency = '',
    this.transactionNote = '',
    this.refId = '',
  }) : super(type: PayloadType.payment);
}

/// Two-Factor Authentication Payload (otpauth://totp/...)
class TotpPayload extends ParsedPayload {
  final String accountName;
  final String issuer;
  final String secret;
  final String algorithm;
  final int digits;
  final int period;

  const TotpPayload({
    required super.rawContent,
    required this.accountName,
    this.issuer = '',
    required this.secret,
    this.algorithm = 'SHA1',
    this.digits = 6,
    this.period = 30,
  }) : super(type: PayloadType.totp);
}

/// Email Payload (mailto:, MATMSG:, or raw email address)
class EmailPayload extends ParsedPayload {
  final String toAddress;
  final String subject;
  final String body;
  final String cc;
  final String bcc;

  const EmailPayload({
    required super.rawContent,
    required this.toAddress,
    this.subject = '',
    this.body = '',
    this.cc = '',
    this.bcc = '',
  }) : super(type: PayloadType.email);
}

/// Phone Number Payload (tel: or raw phone number)
class PhonePayload extends ParsedPayload {
  final String number;
  final String label;

  const PhonePayload({
    required super.rawContent,
    required this.number,
    this.label = '',
  }) : super(type: PayloadType.phone);
}

/// SMS / Text Message Payload (sms:, smsto:, mms:)
class SmsPayload extends ParsedPayload {
  final String number;
  final String body;

  const SmsPayload({
    required super.rawContent,
    required this.number,
    this.body = '',
  }) : super(type: PayloadType.sms);
}

/// Known app store names for deep link detection
enum AppStoreName { playStore, whatsApp, telegram, youTube, generic }

/// App / Deep Link Payload (market://, Play Store URLs, messaging app URIs)
class AppLinkPayload extends ParsedPayload {
  final String appName;
  final String packageId;
  final AppStoreName storeName;
  final String deepLinkUri;

  const AppLinkPayload({
    required super.rawContent,
    required this.appName,
    this.packageId = '',
    this.storeName = AppStoreName.generic,
    required this.deepLinkUri,
  }) : super(type: PayloadType.appLink);
}

/// Product Barcode Payload (EAN-13, UPC-A retail barcodes)
class ProductBarcodePayload extends ParsedPayload {
  final String code;
  final String format;

  const ProductBarcodePayload({
    required super.rawContent,
    required this.code,
    required this.format,
  }) : super(type: PayloadType.productBarcode);
}

/// ISBN Book Payload (ISBN-10 or ISBN-13)
class IsbnPayload extends ParsedPayload {
  final String isbn;
  final bool isIsbn13;

  const IsbnPayload({
    required super.rawContent,
    required this.isbn,
    required this.isIsbn13,
  }) : super(type: PayloadType.isbn);
}
