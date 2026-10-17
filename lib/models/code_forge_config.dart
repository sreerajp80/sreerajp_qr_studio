import 'package:material_ui/material_ui.dart';

/// Supported barcode types in CodeForge.
enum CodeForgeBarcodeType {
  qrCode,
  code128,
  ean13,
  ean8,
  upcA,
  code39,
  pdf417,
  dataMatrix,
}

/// Supported structured payload presets for QR codes.
enum CodeForgePayloadType {
  text,
  url,
  wifi,
  contactVCard,
  upiPayment,
  sms,
  email,
  geo,
}

/// Visual shape of data modules / dots in the QR code body.
enum QrPatternShape { square, dots, rounded, classy, diamond }

/// Visual shape of the 3 corner outer finder pattern frames.
enum QrEyeShape { square, rounded, circle, leaf }

/// Visual shape of the 3 corner inner finder pattern balls (pupils).
enum QrEyeBallShape { square, rounded, circle, diamond }

/// Optional center icon / emblem embedded in the QR code.
enum QrCenterBadge { none, payloadIcon, shieldVerified }

/// Preset color gradient themes across QR data modules.
enum QrGradientTheme { none, sunset, ocean, neon, royalGold }

/// Immutable configuration model defining barcode content, type, and visual styling.
@immutable
class CodeForgeConfig {
  final CodeForgeBarcodeType barcodeType;
  final CodeForgePayloadType payloadType;
  final String rawContent;

  // Wi-Fi fields
  final String wifiSsid;
  final String wifiPassword;
  final String wifiSecurity; // 'WPA', 'WEP', 'nopass'
  final bool wifiHidden;

  // Contact vCard fields
  final String contactName;
  final String contactPhone;
  final String contactEmail;
  final String contactOrg;
  final String contactTitle;
  final String contactUrl;

  // UPI fields
  final String upiVpa;
  final String upiName;
  final String upiAmount;
  final String upiNote;

  // SMS fields
  final String smsPhone;
  final String smsMessage;

  // Email fields
  final String emailTo;
  final String emailSubject;
  final String emailBody;

  // Geo fields
  final String geoLat;
  final String geoLng;

  // QR Visual Customization
  final QrPatternShape patternShape;
  final QrEyeShape eyeShape;
  final QrEyeBallShape eyeBallShape;
  final int foregroundColorValue;
  final int backgroundColorValue;
  final int? eyeOuterColorValue;
  final int? eyeInnerColorValue;
  final QrGradientTheme gradientTheme;
  final int errorCorrectionLevel; // 1 = L, 0 = M, 3 = Q, 2 = H
  final QrCenterBadge centerBadge;
  final bool includeTextLabel;

  const CodeForgeConfig({
    this.barcodeType = CodeForgeBarcodeType.qrCode,
    this.payloadType = CodeForgePayloadType.text,
    this.rawContent = '',
    this.wifiSsid = '',
    this.wifiPassword = '',
    this.wifiSecurity = 'WPA',
    this.wifiHidden = false,
    this.contactName = '',
    this.contactPhone = '',
    this.contactEmail = '',
    this.contactOrg = '',
    this.contactTitle = '',
    this.contactUrl = '',
    this.upiVpa = '',
    this.upiName = '',
    this.upiAmount = '',
    this.upiNote = '',
    this.smsPhone = '',
    this.smsMessage = '',
    this.emailTo = '',
    this.emailSubject = '',
    this.emailBody = '',
    this.geoLat = '',
    this.geoLng = '',
    this.patternShape = QrPatternShape.square,
    this.eyeShape = QrEyeShape.square,
    this.eyeBallShape = QrEyeBallShape.square,
    this.foregroundColorValue = 0xFF000000,
    this.backgroundColorValue = 0xFFFFFFFF,
    this.eyeOuterColorValue,
    this.eyeInnerColorValue,
    this.gradientTheme = QrGradientTheme.none,
    this.errorCorrectionLevel = 0, // M default
    this.centerBadge = QrCenterBadge.none,
    this.includeTextLabel = true,
  });

  Color get foregroundColor => Color(foregroundColorValue);
  Color get backgroundColor => Color(backgroundColorValue);
  Color? get eyeOuterColor =>
      eyeOuterColorValue != null ? Color(eyeOuterColorValue!) : null;
  Color? get eyeInnerColor =>
      eyeInnerColorValue != null ? Color(eyeInnerColorValue!) : null;

  List<Color>? get gradientColors {
    switch (gradientTheme) {
      case QrGradientTheme.none:
        return null;
      case QrGradientTheme.sunset:
        return const [Color(0xFFFF512F), Color(0xFFDD2476)];
      case QrGradientTheme.ocean:
        return const [Color(0xFF2193B0), Color(0xFF6DD5ED)];
      case QrGradientTheme.neon:
        return const [Color(0xFF00F2FE), Color(0xFF4FACFE)];
      case QrGradientTheme.royalGold:
        return const [Color(0xFFF7971E), Color(0xFFFFD200)];
    }
  }

  CodeForgeConfig copyWith({
    CodeForgeBarcodeType? barcodeType,
    CodeForgePayloadType? payloadType,
    String? rawContent,
    String? wifiSsid,
    String? wifiPassword,
    String? wifiSecurity,
    bool? wifiHidden,
    String? contactName,
    String? contactPhone,
    String? contactEmail,
    String? contactOrg,
    String? contactTitle,
    String? contactUrl,
    String? upiVpa,
    String? upiName,
    String? upiAmount,
    String? upiNote,
    String? smsPhone,
    String? smsMessage,
    String? emailTo,
    String? emailSubject,
    String? emailBody,
    String? geoLat,
    String? geoLng,
    QrPatternShape? patternShape,
    QrEyeShape? eyeShape,
    QrEyeBallShape? eyeBallShape,
    int? foregroundColorValue,
    int? backgroundColorValue,
    int? eyeOuterColorValue,
    bool clearEyeOuterColor = false,
    int? eyeInnerColorValue,
    bool clearEyeInnerColor = false,
    QrGradientTheme? gradientTheme,
    int? errorCorrectionLevel,
    QrCenterBadge? centerBadge,
    bool? includeTextLabel,
  }) {
    return CodeForgeConfig(
      barcodeType: barcodeType ?? this.barcodeType,
      payloadType: payloadType ?? this.payloadType,
      rawContent: rawContent ?? this.rawContent,
      wifiSsid: wifiSsid ?? this.wifiSsid,
      wifiPassword: wifiPassword ?? this.wifiPassword,
      wifiSecurity: wifiSecurity ?? this.wifiSecurity,
      wifiHidden: wifiHidden ?? this.wifiHidden,
      contactName: contactName ?? this.contactName,
      contactPhone: contactPhone ?? this.contactPhone,
      contactEmail: contactEmail ?? this.contactEmail,
      contactOrg: contactOrg ?? this.contactOrg,
      contactTitle: contactTitle ?? this.contactTitle,
      contactUrl: contactUrl ?? this.contactUrl,
      upiVpa: upiVpa ?? this.upiVpa,
      upiName: upiName ?? this.upiName,
      upiAmount: upiAmount ?? this.upiAmount,
      upiNote: upiNote ?? this.upiNote,
      smsPhone: smsPhone ?? this.smsPhone,
      smsMessage: smsMessage ?? this.smsMessage,
      emailTo: emailTo ?? this.emailTo,
      emailSubject: emailSubject ?? this.emailSubject,
      emailBody: emailBody ?? this.emailBody,
      geoLat: geoLat ?? this.geoLat,
      geoLng: geoLng ?? this.geoLng,
      patternShape: patternShape ?? this.patternShape,
      eyeShape: eyeShape ?? this.eyeShape,
      eyeBallShape: eyeBallShape ?? this.eyeBallShape,
      foregroundColorValue: foregroundColorValue ?? this.foregroundColorValue,
      backgroundColorValue: backgroundColorValue ?? this.backgroundColorValue,
      eyeOuterColorValue: clearEyeOuterColor
          ? null
          : (eyeOuterColorValue ?? this.eyeOuterColorValue),
      eyeInnerColorValue: clearEyeInnerColor
          ? null
          : (eyeInnerColorValue ?? this.eyeInnerColorValue),
      gradientTheme: gradientTheme ?? this.gradientTheme,
      errorCorrectionLevel: errorCorrectionLevel ?? this.errorCorrectionLevel,
      centerBadge: centerBadge ?? this.centerBadge,
      includeTextLabel: includeTextLabel ?? this.includeTextLabel,
    );
  }
}
