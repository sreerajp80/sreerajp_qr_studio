import 'package:sreerajp_qr_studio/models/parsed_payload.dart';

/// Robust service that parses raw QR barcode strings into structured [ParsedPayload] objects.
class PayloadParserService {
  /// Parses any scanned string content safely without throwing errors.
  ParsedPayload parse(String content) {
    final trimmed = content.trim();
    if (trimmed.isEmpty) {
      return GenericPayload(content);
    }

    try {
      // 1. Wi-Fi QR
      if (trimmed.toUpperCase().startsWith('WIFI:')) {
        final wifi = _parseWifi(trimmed);
        if (wifi != null) return wifi;
      }

      // 2. 2FA / TOTP
      if (trimmed.toLowerCase().startsWith('otpauth://')) {
        final totp = _parseTotp(trimmed);
        if (totp != null) return totp;
      }

      // 3. Geographic Location
      if (trimmed.toLowerCase().startsWith('geo:')) {
        final geo = _parseGeo(trimmed);
        if (geo != null) return geo;
      }

      // 4. Payment Code (UPI, Crypto, SEPA)
      if (trimmed.toLowerCase().startsWith('upi://pay') ||
          trimmed.toLowerCase().startsWith('bitcoin:') ||
          trimmed.toLowerCase().startsWith('ethereum:') ||
          trimmed.toLowerCase().startsWith('solana:') ||
          trimmed.toUpperCase().startsWith('BCD\n') ||
          trimmed.toLowerCase().startsWith('sepa:')) {
        final payment = _parsePayment(trimmed);
        if (payment != null) return payment;
      }

      // 5. Calendar Event (iCalendar / VEVENT)
      if (trimmed.toUpperCase().contains('BEGIN:VEVENT') ||
          trimmed.toUpperCase().contains('BEGIN:VCALENDAR')) {
        final calendar = _parseCalendar(trimmed);
        if (calendar != null) return calendar;
      }

      // 6. Contact Card (vCard / MeCard)
      if (trimmed.toUpperCase().contains('BEGIN:VCARD') ||
          trimmed.toUpperCase().startsWith('MECARD:')) {
        final contact = _parseContact(trimmed);
        if (contact != null) return contact;
      }

      // 7. Email (mailto:, MATMSG:, or raw email address)
      if (trimmed.toLowerCase().startsWith('mailto:') ||
          trimmed.toUpperCase().startsWith('MATMSG:')) {
        final email = _parseEmail(trimmed);
        if (email != null) return email;
      }

      // 8. SMS (sms:, smsto:, mms:)
      if (trimmed.toLowerCase().startsWith('sms:') ||
          trimmed.toLowerCase().startsWith('smsto:') ||
          trimmed.toLowerCase().startsWith('mms:')) {
        final sms = _parseSms(trimmed);
        if (sms != null) return sms;
      }

      // 9. Phone (tel:, TEL:)
      if (trimmed.toLowerCase().startsWith('tel:')) {
        final phone = _parsePhone(trimmed);
        if (phone != null) return phone;
      }

      // 10. App / Deep Link (Play Store, WhatsApp, Telegram, YouTube, custom schemes)
      {
        final appLink = _parseAppLink(trimmed);
        if (appLink != null) return appLink;
      }

      // 11. ISBN (10 or 13 digit book codes)
      {
        final isbn = _parseIsbn(trimmed);
        if (isbn != null) return isbn;
      }

      // 12. Product Barcode (EAN-13, UPC-A retail barcodes)
      {
        final product = _parseProductBarcode(trimmed);
        if (product != null) return product;
      }

      // 13. Raw email address (fallback: user@domain.com without mailto:)
      if (_emailRegex.hasMatch(trimmed)) {
        return EmailPayload(rawContent: content, toAddress: trimmed);
      }

      // 14. Raw phone number (fallback: +1234567890 or similar)
      if (_phoneRegex.hasMatch(trimmed)) {
        return PhonePayload(rawContent: content, number: trimmed);
      }
    } catch (_) {
      // Safe fallback on any unexpected format
    }

    return GenericPayload(content);
  }

  // --- Wi-Fi Parser ---
  WifiPayload? _parseWifi(String raw) {
    final body = raw.substring(5);
    String ssid = '';
    String securityType = 'WPA';
    String password = '';
    bool isHidden = false;

    final tokens = _splitEscaped(body, ';');
    for (final token in tokens) {
      if (token.startsWith('S:')) {
        ssid = _unescape(token.substring(2));
      } else if (token.startsWith('T:')) {
        securityType = _unescape(token.substring(2));
      } else if (token.startsWith('P:')) {
        password = _unescape(token.substring(2));
      } else if (token.startsWith('H:')) {
        isHidden = _unescape(token.substring(2)).toLowerCase() == 'true';
      }
    }

    if (ssid.isEmpty && password.isEmpty) return null;
    return WifiPayload(
      rawContent: raw,
      ssid: ssid,
      securityType: securityType.isEmpty ? 'WPA' : securityType,
      password: password,
      isHidden: isHidden,
    );
  }

  // --- 2FA TOTP Parser ---
  TotpPayload? _parseTotp(String raw) {
    final uri = Uri.tryParse(raw);
    if (uri == null || !uri.hasScheme || uri.scheme != 'otpauth') return null;

    final host = uri.host.toLowerCase(); // totp or hotp
    if (host != 'totp') return null;

    String path = Uri.decodeComponent(uri.path);
    if (path.startsWith('/')) path = path.substring(1);

    String accountName = path;
    String issuer = uri.queryParameters['issuer'] ?? '';

    if (path.contains(':')) {
      final parts = path.split(':');
      if (issuer.isEmpty) issuer = parts[0].trim();
      accountName = parts.sublist(1).join(':').trim();
    }

    final secret = uri.queryParameters['secret'] ?? '';
    if (secret.isEmpty) return null;

    final algorithm = uri.queryParameters['algorithm']?.toUpperCase() ?? 'SHA1';
    final digits = int.tryParse(uri.queryParameters['digits'] ?? '6') ?? 6;
    final period = int.tryParse(uri.queryParameters['period'] ?? '30') ?? 30;

    return TotpPayload(
      rawContent: raw,
      accountName: accountName,
      issuer: issuer,
      secret: secret,
      algorithm: algorithm,
      digits: digits,
      period: period,
    );
  }

  // --- Geo Parser ---
  GeoPayload? _parseGeo(String raw) {
    // geo:37.7749,-122.4194?q=San+Francisco
    final schemeBody = raw.substring(4);
    final parts = schemeBody.split('?');
    final coordsPart = parts[0];

    final coordTokens = coordsPart.split(',');
    if (coordTokens.length < 2) return null;

    final lat = double.tryParse(coordTokens[0].trim());
    final lng = double.tryParse(coordTokens[1].trim());

    if (lat == null || lng == null) return null;

    String query = '';
    String label = '';

    if (parts.length > 1) {
      final queryParams = Uri.splitQueryString(parts[1]);
      query = queryParams['q'] ?? '';
      label = queryParams['label'] ?? query;
    }

    return GeoPayload(
      rawContent: raw,
      latitude: lat,
      longitude: lng,
      query: query,
      label: label,
    );
  }

  // --- Payment Parser ---
  PaymentPayload? _parsePayment(String raw) {
    if (raw.toLowerCase().startsWith('upi://pay')) {
      final uri = Uri.tryParse(raw);
      if (uri != null) {
        final qp = uri.queryParameters;
        return PaymentPayload(
          rawContent: raw,
          scheme: PaymentScheme.upi,
          payeeName: qp['pn'] ?? qp['pa'] ?? '',
          payeeAddress: qp['pa'] ?? '',
          amount: qp['am'] ?? '',
          currency: qp['cu'] ?? 'INR',
          transactionNote: qp['tn'] ?? '',
          refId: qp['tr'] ?? qp['refUrl'] ?? '',
        );
      }
    }

    if (raw.toLowerCase().startsWith('bitcoin:') ||
        raw.toLowerCase().startsWith('ethereum:') ||
        raw.toLowerCase().startsWith('solana:')) {
      final schemeStr = raw.split(':')[0].toLowerCase();
      final uri = Uri.tryParse(raw);
      String address = '';
      String amount = '';
      String note = '';

      if (uri != null) {
        address = uri.path;
        amount = uri.queryParameters['amount'] ?? '';
        note =
            uri.queryParameters['label'] ??
            uri.queryParameters['message'] ??
            '';
      }

      return PaymentPayload(
        rawContent: raw,
        scheme: PaymentScheme.crypto,
        payeeName: '${schemeStr.toUpperCase()} Wallet',
        payeeAddress: address,
        amount: amount,
        currency: schemeStr.toUpperCase(),
        transactionNote: note,
      );
    }

    if (raw.toUpperCase().startsWith('BCD\n') ||
        raw.toLowerCase().startsWith('sepa:')) {
      final lines = raw.split('\n');
      String payee = '';
      String iban = '';

      for (final line in lines) {
        if (line.startsWith('IBAN:') ||
            line.startsWith('DE') ||
            line.startsWith('FR')) {
          iban = line.replaceFirst('IBAN:', '').trim();
        } else if (line.length > 5 && payee.isEmpty) {
          payee = line.trim();
        }
      }

      return PaymentPayload(
        rawContent: raw,
        scheme: PaymentScheme.sepa,
        payeeName: payee,
        payeeAddress: iban,
        currency: 'EUR',
      );
    }

    return null;
  }

  // --- Calendar Event Parser ---
  CalendarPayload? _parseCalendar(String raw) {
    String summary = '';
    String description = '';
    String location = '';
    DateTime? dtStart;
    DateTime? dtEnd;

    final lines = raw.split(RegExp(r'\r?\n'));
    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.startsWith('SUMMARY:')) {
        summary = trimmed.substring(8);
      } else if (trimmed.startsWith('DESCRIPTION:')) {
        description = trimmed.substring(12);
      } else if (trimmed.startsWith('LOCATION:')) {
        location = trimmed.substring(9);
      } else if (trimmed.startsWith('DTSTART:')) {
        dtStart = _parseICalDate(trimmed.substring(8));
      } else if (trimmed.startsWith('DTSTART;VALUE=DATE:')) {
        dtStart = _parseICalDate(trimmed.substring(19));
      } else if (trimmed.startsWith('DTEND:')) {
        dtEnd = _parseICalDate(trimmed.substring(6));
      } else if (trimmed.startsWith('DTEND;VALUE=DATE:')) {
        dtEnd = _parseICalDate(trimmed.substring(17));
      }
    }

    if (summary.isEmpty && dtStart == null) return null;

    return CalendarPayload(
      rawContent: raw,
      summary: summary,
      description: description,
      location: location,
      dtStart: dtStart,
      dtEnd: dtEnd,
      isAllDay: dtStart != null && dtStart.hour == 0 && dtStart.minute == 0,
    );
  }

  // --- Contact Card Parser ---
  ContactPayload? _parseContact(String raw) {
    if (raw.toUpperCase().startsWith('MECARD:')) {
      final body = raw.substring(7);
      String name = '';
      final List<ContactField> phones = [];
      final List<ContactField> emails = [];
      final List<String> addresses = [];
      String note = '';

      final tokens = _splitEscaped(body, ';');
      for (final token in tokens) {
        if (token.startsWith('N:')) {
          name = _unescape(token.substring(2)).replaceAll(',', ' ');
        } else if (token.startsWith('TEL:')) {
          phones.add(
            ContactField(label: 'Phone', value: _unescape(token.substring(4))),
          );
        } else if (token.startsWith('EMAIL:')) {
          emails.add(
            ContactField(label: 'Email', value: _unescape(token.substring(6))),
          );
        } else if (token.startsWith('ADR:')) {
          addresses.add(_unescape(token.substring(4)));
        } else if (token.startsWith('NOTE:')) {
          note = _unescape(token.substring(5));
        }
      }

      return ContactPayload(
        rawContent: raw,
        name: name,
        phones: phones,
        emails: emails,
        addresses: addresses,
        title: note,
      );
    }

    if (raw.toUpperCase().contains('BEGIN:VCARD')) {
      String name = '';
      final List<ContactField> phones = [];
      final List<ContactField> emails = [];
      final List<String> addresses = [];
      String org = '';
      String title = '';
      String url = '';

      final lines = raw.split(RegExp(r'\r?\n'));
      for (final line in lines) {
        final trimmed = line.trim();
        if (trimmed.startsWith('FN:')) {
          name = trimmed.substring(3);
        } else if (name.isEmpty && trimmed.startsWith('N:')) {
          name = trimmed
              .substring(2)
              .split(';')
              .where((s) => s.isNotEmpty)
              .join(' ');
        } else if (trimmed.contains('TEL')) {
          final idx = trimmed.indexOf(':');
          if (idx != -1) {
            phones.add(
              ContactField(label: 'Phone', value: trimmed.substring(idx + 1)),
            );
          }
        } else if (trimmed.contains('EMAIL')) {
          final idx = trimmed.indexOf(':');
          if (idx != -1) {
            emails.add(
              ContactField(label: 'Email', value: trimmed.substring(idx + 1)),
            );
          }
        } else if (trimmed.startsWith('ORG:')) {
          org = trimmed.substring(4);
        } else if (trimmed.startsWith('TITLE:')) {
          title = trimmed.substring(6);
        } else if (trimmed.startsWith('URL:')) {
          url = trimmed.substring(4);
        } else if (trimmed.startsWith('ADR')) {
          final idx = trimmed.indexOf(':');
          if (idx != -1) {
            addresses.add(
              trimmed.substring(idx + 1).replaceAll(';', ' ').trim(),
            );
          }
        }
      }

      return ContactPayload(
        rawContent: raw,
        name: name.isEmpty ? 'vCard Contact' : name,
        phones: phones,
        emails: emails,
        addresses: addresses,
        organization: org,
        title: title,
        url: url,
      );
    }

    return null;
  }

  // --- Utility Helpers ---
  DateTime? _parseICalDate(String rawStr) {
    final clean = rawStr.replaceAll(RegExp(r'[^0-9T]'), '');
    if (clean.length >= 8) {
      try {
        final year = int.parse(clean.substring(0, 4));
        final month = int.parse(clean.substring(4, 6));
        final day = int.parse(clean.substring(6, 8));

        int hour = 0;
        int minute = 0;
        int second = 0;

        if (clean.length >= 13 && clean.contains('T')) {
          final tIdx = clean.indexOf('T');
          hour = int.parse(clean.substring(tIdx + 1, tIdx + 3));
          minute = int.parse(clean.substring(tIdx + 3, tIdx + 5));
          if (clean.length >= tIdx + 7) {
            second = int.parse(clean.substring(tIdx + 5, tIdx + 7));
          }
        }

        return DateTime(year, month, day, hour, minute, second);
      } catch (_) {}
    }
    return null;
  }

  List<String> _splitEscaped(String source, String delimiter) {
    final List<String> result = [];
    final sb = StringBuffer();
    bool escaped = false;

    for (int i = 0; i < source.length; i++) {
      final char = source[i];
      if (escaped) {
        sb.write(char);
        escaped = false;
      } else if (char == '\\') {
        escaped = true;
      } else if (char == delimiter) {
        result.add(sb.toString());
        sb.clear();
      } else {
        sb.write(char);
      }
    }
    if (sb.isNotEmpty) result.add(sb.toString());
    return result;
  }

  String _unescape(String val) {
    return val
        .replaceAll(r'\;', ';')
        .replaceAll(r'\:', ':')
        .replaceAll(r'\,', ',')
        .replaceAll(r'\\', '\\');
  }

  // --- Regex Constants ---
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  static final _phoneRegex = RegExp(r'^\+?[0-9\s\-\(\)]{7,20}$');

  // --- Email Parser ---
  EmailPayload? _parseEmail(String raw) {
    if (raw.toLowerCase().startsWith('mailto:')) {
      final uri = Uri.tryParse(raw);
      if (uri == null) return null;
      final to = uri.path.isNotEmpty ? uri.path : '';
      if (to.isEmpty) return null;
      return EmailPayload(
        rawContent: raw,
        toAddress: to,
        subject: uri.queryParameters['subject'] ?? '',
        body: uri.queryParameters['body'] ?? '',
        cc: uri.queryParameters['cc'] ?? '',
        bcc: uri.queryParameters['bcc'] ?? '',
      );
    }

    // MATMSG:TO:user@example.com;SUB:Hello;BODY:World;;
    if (raw.toUpperCase().startsWith('MATMSG:')) {
      final body = raw.substring(7);
      String to = '';
      String subject = '';
      String messageBody = '';
      final tokens = _splitEscaped(body, ';');
      for (final token in tokens) {
        if (token.toUpperCase().startsWith('TO:')) {
          to = token.substring(3).trim();
        } else if (token.toUpperCase().startsWith('SUB:')) {
          subject = token.substring(4).trim();
        } else if (token.toUpperCase().startsWith('BODY:')) {
          messageBody = token.substring(5).trim();
        }
      }
      if (to.isEmpty) return null;
      return EmailPayload(
        rawContent: raw,
        toAddress: to,
        subject: subject,
        body: messageBody,
      );
    }
    return null;
  }

  // --- Phone Parser ---
  PhonePayload? _parsePhone(String raw) {
    // tel:+1234567890 or tel:1234567890
    String number = raw;
    if (raw.toLowerCase().startsWith('tel:')) {
      number = raw.substring(4).trim();
    }
    if (number.isEmpty) return null;
    return PhonePayload(rawContent: raw, number: number);
  }

  // --- SMS Parser ---
  SmsPayload? _parseSms(String raw) {
    final lower = raw.toLowerCase();
    String numberPart = '';
    String body = '';

    if (lower.startsWith('sms:') || lower.startsWith('mms:')) {
      final uri = Uri.tryParse(raw);
      if (uri != null) {
        numberPart = uri.path;
        body = uri.queryParameters['body'] ?? '';
      } else {
        // Fallback manual parse: sms:+123?body=hello
        final afterScheme = raw.substring(raw.indexOf(':') + 1);
        final qIdx = afterScheme.indexOf('?');
        if (qIdx != -1) {
          numberPart = afterScheme.substring(0, qIdx);
          final queryStr = afterScheme.substring(qIdx + 1);
          final params = Uri.splitQueryString(queryStr);
          body = params['body'] ?? '';
        } else {
          numberPart = afterScheme;
        }
      }
    } else if (lower.startsWith('smsto:')) {
      // SMSTO:+1234567890:Hello World
      final afterScheme = raw.substring(6);
      final colonIdx = afterScheme.indexOf(':');
      if (colonIdx != -1) {
        numberPart = afterScheme.substring(0, colonIdx).trim();
        body = afterScheme.substring(colonIdx + 1).trim();
      } else {
        numberPart = afterScheme.trim();
      }
    }

    if (numberPart.isEmpty) return null;
    return SmsPayload(rawContent: raw, number: numberPart, body: body);
  }

  // --- App Link Parser ---
  static final _playStorePatterns = [
    RegExp(r'^market://details\?id=(.+)$', caseSensitive: false),
    RegExp(
      r'^https?://play\.google\.com/store/apps/details\?id=([^&]+)',
      caseSensitive: false,
    ),
  ];
  static final _whatsAppPatterns = [
    RegExp(r'^https?://wa\.me/', caseSensitive: false),
    RegExp(r'^whatsapp://', caseSensitive: false),
  ];
  static final _telegramPatterns = [
    RegExp(r'^tg://', caseSensitive: false),
    RegExp(r'^https?://t\.me/', caseSensitive: false),
  ];
  static final _youTubePatterns = [
    RegExp(
      r'^https?://(www\.)?(youtube\.com|youtu\.be)/',
      caseSensitive: false,
    ),
    RegExp(r'^youtube://', caseSensitive: false),
    RegExp(r'^vnd\.youtube:', caseSensitive: false),
  ];

  AppLinkPayload? _parseAppLink(String raw) {
    // Play Store
    for (final pattern in _playStorePatterns) {
      final match = pattern.firstMatch(raw);
      if (match != null) {
        final packageId = match.group(1) ?? '';
        return AppLinkPayload(
          rawContent: raw,
          appName: packageId.split('.').last,
          packageId: packageId,
          storeName: AppStoreName.playStore,
          deepLinkUri: raw,
        );
      }
    }

    // WhatsApp
    for (final pattern in _whatsAppPatterns) {
      if (pattern.hasMatch(raw)) {
        return AppLinkPayload(
          rawContent: raw,
          appName: 'WhatsApp',
          storeName: AppStoreName.whatsApp,
          deepLinkUri: raw,
        );
      }
    }

    // Telegram
    for (final pattern in _telegramPatterns) {
      if (pattern.hasMatch(raw)) {
        return AppLinkPayload(
          rawContent: raw,
          appName: 'Telegram',
          storeName: AppStoreName.telegram,
          deepLinkUri: raw,
        );
      }
    }

    // YouTube
    for (final pattern in _youTubePatterns) {
      if (pattern.hasMatch(raw)) {
        return AppLinkPayload(
          rawContent: raw,
          appName: 'YouTube',
          storeName: AppStoreName.youTube,
          deepLinkUri: raw,
        );
      }
    }

    return null;
  }

  // --- ISBN Parser ---
  static final _isbn13Regex = RegExp(r'^97[89]\d{10}$');
  static final _isbn10Regex = RegExp(r'^\d{9}[\dXx]$');

  IsbnPayload? _parseIsbn(String raw) {
    final cleaned = raw.replaceAll(RegExp(r'[\s\-]'), '');

    if (_isbn13Regex.hasMatch(cleaned)) {
      if (_validateIsbn13(cleaned)) {
        return IsbnPayload(rawContent: raw, isbn: cleaned, isIsbn13: true);
      }
    }

    if (_isbn10Regex.hasMatch(cleaned)) {
      if (_validateIsbn10(cleaned)) {
        return IsbnPayload(rawContent: raw, isbn: cleaned, isIsbn13: false);
      }
    }

    return null;
  }

  bool _validateIsbn13(String isbn) {
    int sum = 0;
    for (int i = 0; i < 13; i++) {
      final digit = int.parse(isbn[i]);
      sum += (i.isEven) ? digit : digit * 3;
    }
    return sum % 10 == 0;
  }

  bool _validateIsbn10(String isbn) {
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(isbn[i]) * (10 - i);
    }
    final lastChar = isbn[9].toUpperCase();
    sum += lastChar == 'X' ? 10 : int.parse(lastChar);
    return sum % 11 == 0;
  }

  // --- Product Barcode Parser ---
  static final _ean13Regex = RegExp(r'^\d{13}$');
  static final _upcARegex = RegExp(r'^\d{12}$');
  static final _ean8Regex = RegExp(r'^\d{8}$');

  ProductBarcodePayload? _parseProductBarcode(String raw) {
    final cleaned = raw.trim();
    if (_ean13Regex.hasMatch(cleaned)) {
      // Exclude ISBN-13 (already handled above)
      if (!cleaned.startsWith('978') && !cleaned.startsWith('979')) {
        return ProductBarcodePayload(
          rawContent: raw,
          code: cleaned,
          format: 'EAN-13',
        );
      }
    }
    if (_upcARegex.hasMatch(cleaned)) {
      return ProductBarcodePayload(
        rawContent: raw,
        code: cleaned,
        format: 'UPC-A',
      );
    }
    if (_ean8Regex.hasMatch(cleaned)) {
      return ProductBarcodePayload(
        rawContent: raw,
        code: cleaned,
        format: 'EAN-8',
      );
    }
    return null;
  }
}
