import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:qr/qr.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/code_forge_config.dart';
import 'package:sreerajp_qr_studio/models/location_result.dart';
import 'package:sreerajp_qr_studio/models/safety_check_result.dart';
import 'package:sreerajp_qr_studio/services/code_forge_service.dart';
import 'package:sreerajp_qr_studio/services/location_service.dart';

/// State management provider for CodeForge barcode generator.
class CodeForgeProvider extends ChangeNotifier {
  final CodeForgeService _service;
  final LocationService _locationService;

  CodeForgeConfig _config = const CodeForgeConfig(
    rawContent: 'https://example.com',
    payloadType: CodeForgePayloadType.url,
  );

  QrImage? _cachedQrImage;
  List<SafetyCheckResult>? _safetyResults;
  bool _isCheckingSafety = false;
  bool _isExporting = false;
  bool _isFetchingLocation = false;

  CodeForgeProvider({
    CodeForgeService? service,
    LocationService? locationService,
  }) : _service = service ?? CodeForgeService(),
       _locationService = locationService ?? LocationService() {
    _refreshQrMatrix();
  }

  CodeForgeConfig get config => _config;
  QrImage? get qrImage => _cachedQrImage;
  List<SafetyCheckResult>? get safetyResults => _safetyResults;
  bool get isUrlSafe =>
      _safetyResults != null && _safetyResults!.every((r) => r.passed);
  bool get isCheckingSafety => _isCheckingSafety;

  /// Number of link safety checks that did not pass in the last check.
  /// Skipped checks count as passed, the same as [isUrlSafe].
  int get safetyIssueCount =>
      _safetyResults?.where((r) => !r.passed).length ?? 0;
  bool get isExporting => _isExporting;
  bool get isFetchingLocation => _isFetchingLocation;

  String get payloadString => _service.buildPayloadString(_config);
  AppMessage? get validationError => _service.validateContent(_config);
  bool get isValid => validationError == null;

  void _refreshQrMatrix() {
    if (_config.barcodeType == CodeForgeBarcodeType.qrCode) {
      final payload = payloadString;
      if (payload.isNotEmpty) {
        _cachedQrImage = _service.generateQrMatrix(
          payload,
          _config.errorCorrectionLevel,
        );
      } else {
        _cachedQrImage = null;
      }
    } else {
      _cachedQrImage = null;
    }
  }

  void setBarcodeType(CodeForgeBarcodeType type) {
    if (_config.barcodeType == type) return;
    _config = _config.copyWith(
      barcodeType: type,
      // If switching to 1D barcodes and payload is complex/empty, provide a clean sample
      rawContent: _getSampleForBarcodeType(type),
    );
    _safetyResults = null;
    _refreshQrMatrix();
    notifyListeners();
  }

  String _getSampleForBarcodeType(CodeForgeBarcodeType type) {
    switch (type) {
      case CodeForgeBarcodeType.code128:
        return 'SREERAJ-CODE-128';
      case CodeForgeBarcodeType.ean13:
        return '890123456789'; // 12 digits, EAN will calculate checksum
      case CodeForgeBarcodeType.ean8:
        return '9638507';
      case CodeForgeBarcodeType.upcA:
        return '01234567890';
      case CodeForgeBarcodeType.code39:
        return 'CODE39';
      case CodeForgeBarcodeType.pdf417:
        return 'PDF417-SAMPLE-DOCUMENT-PAYLOAD';
      case CodeForgeBarcodeType.dataMatrix:
        return 'DATA-MATRIX-SAMPLE';
      case CodeForgeBarcodeType.qrCode:
        return _config.rawContent.isNotEmpty
            ? _config.rawContent
            : 'https://example.com';
    }
  }

  void setPayloadType(CodeForgePayloadType type) {
    if (_config.payloadType == type) return;
    _config = _config.copyWith(payloadType: type);
    _safetyResults = null;
    _refreshQrMatrix();
    notifyListeners();
  }

  void updateRawContent(String content) {
    _config = _config.copyWith(rawContent: content);
    _safetyResults = null;
    _refreshQrMatrix();
    notifyListeners();
  }

  void updateWifi({
    String? ssid,
    String? password,
    String? security,
    bool? hidden,
  }) {
    _config = _config.copyWith(
      wifiSsid: ssid,
      wifiPassword: password,
      wifiSecurity: security,
      wifiHidden: hidden,
    );
    _refreshQrMatrix();
    notifyListeners();
  }

  void updateContact({
    String? name,
    String? phone,
    String? email,
    String? org,
    String? title,
    String? url,
  }) {
    _config = _config.copyWith(
      contactName: name,
      contactPhone: phone,
      contactEmail: email,
      contactOrg: org,
      contactTitle: title,
      contactUrl: url,
    );
    _refreshQrMatrix();
    notifyListeners();
  }

  void updateUpi({String? vpa, String? name, String? amount, String? note}) {
    _config = _config.copyWith(
      upiVpa: vpa,
      upiName: name,
      upiAmount: amount,
      upiNote: note,
    );
    _refreshQrMatrix();
    notifyListeners();
  }

  void updateSms({String? phone, String? message}) {
    _config = _config.copyWith(smsPhone: phone, smsMessage: message);
    _refreshQrMatrix();
    notifyListeners();
  }

  void updateEmail({String? to, String? subject, String? body}) {
    _config = _config.copyWith(
      emailTo: to,
      emailSubject: subject,
      emailBody: body,
    );
    _refreshQrMatrix();
    notifyListeners();
  }

  void updateGeo({String? lat, String? lng}) {
    _config = _config.copyWith(geoLat: lat, geoLng: lng);
    _refreshQrMatrix();
    notifyListeners();
  }

  /// Fills the location code with the device's current position.
  ///
  /// Returns the lookup result so the screen can update its text fields or
  /// show the matching message. Does nothing if a lookup is already running.
  Future<LocationResult?> fetchCurrentLocation() async {
    if (_isFetchingLocation) return null;
    _isFetchingLocation = true;
    notifyListeners();
    try {
      final result = await _locationService.getCurrentLocation();
      if (result.isSuccess) {
        updateGeo(
          lat: result.latitude!.toStringAsFixed(6),
          lng: result.longitude!.toStringAsFixed(6),
        );
      }
      return result;
    } finally {
      _isFetchingLocation = false;
      notifyListeners();
    }
  }

  void setPatternShape(QrPatternShape shape) {
    _config = _config.copyWith(patternShape: shape);
    notifyListeners();
  }

  void setEyeShape(QrEyeShape shape) {
    _config = _config.copyWith(eyeShape: shape);
    notifyListeners();
  }

  void setEyeBallShape(QrEyeBallShape shape) {
    _config = _config.copyWith(eyeBallShape: shape);
    notifyListeners();
  }

  void setForegroundColor(int colorValue) {
    _config = _config.copyWith(foregroundColorValue: colorValue);
    notifyListeners();
  }

  void setBackgroundColor(int colorValue) {
    _config = _config.copyWith(backgroundColorValue: colorValue);
    notifyListeners();
  }

  void setEyeOuterColor(int? colorValue) {
    if (colorValue == null) {
      _config = _config.copyWith(clearEyeOuterColor: true);
    } else {
      _config = _config.copyWith(eyeOuterColorValue: colorValue);
    }
    notifyListeners();
  }

  void setEyeInnerColor(int? colorValue) {
    if (colorValue == null) {
      _config = _config.copyWith(clearEyeInnerColor: true);
    } else {
      _config = _config.copyWith(eyeInnerColorValue: colorValue);
    }
    notifyListeners();
  }

  void setGradientTheme(QrGradientTheme theme) {
    _config = _config.copyWith(gradientTheme: theme);
    notifyListeners();
  }

  void setErrorCorrectionLevel(int level) {
    _config = _config.copyWith(errorCorrectionLevel: level);
    _refreshQrMatrix();
    notifyListeners();
  }

  void setCenterBadge(QrCenterBadge badge) {
    _config = _config.copyWith(centerBadge: badge);
    notifyListeners();
  }

  void setIncludeTextLabel(bool include) {
    _config = _config.copyWith(includeTextLabel: include);
    notifyListeners();
  }

  void resetStylingToDefault() {
    _config = _config.copyWith(
      patternShape: QrPatternShape.square,
      eyeShape: QrEyeShape.square,
      eyeBallShape: QrEyeBallShape.square,
      foregroundColorValue: 0xFF000000,
      backgroundColorValue: 0xFFFFFFFF,
      clearEyeOuterColor: true,
      clearEyeInnerColor: true,
      gradientTheme: QrGradientTheme.none,
      errorCorrectionLevel: 0,
      centerBadge: QrCenterBadge.none,
      includeTextLabel: true,
    );
    _refreshQrMatrix();
    notifyListeners();
  }

  /// Runs the URL through the URL safety engine.
  Future<void> runUrlSafetyCheck() async {
    final payload = payloadString;
    if (payload.isEmpty) return;

    _isCheckingSafety = true;
    notifyListeners();

    try {
      _safetyResults = await _service.verifyUrlSafety(payload);
    } catch (_) {
      _safetyResults = null;
    } finally {
      _isCheckingSafety = false;
      notifyListeners();
    }
  }

  /// Copies the raw payload to the system clipboard.
  Future<void> copyPayloadToClipboard() async {
    final payload = payloadString;
    if (payload.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: payload));
    }
  }

  /// Exports high-res PNG and opens system share sheet.
  ///
  /// [paintQr] draws the QR matrix; the screen passes `CodeForgeQrPainter`.
  Future<void> exportPngAndShare({required QrCanvasPainter paintQr}) async {
    if (!isValid) return;
    _isExporting = true;
    notifyListeners();

    try {
      final bytes = await _service.renderQrToPngBytes(
        _config,
        paintQr: paintQr,
      );
      if (bytes != null) {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        await _service.shareImage(
          bytes,
          'codeforge_$timestamp.png',
          subject: 'CodeForge Generated QR Code',
        );
      }
    } finally {
      _isExporting = false;
      notifyListeners();
    }
  }

  /// Exports vector SVG and opens system share sheet.
  Future<void> exportSvgAndShare() async {
    if (!isValid) return;
    _isExporting = true;
    notifyListeners();

    try {
      String svgString;
      if (_config.barcodeType == CodeForgeBarcodeType.qrCode) {
        svgString = _service.generateQrSvg(_config, size: 600);
      } else {
        svgString = _service.generateBarcodeSvg(
          _config,
          width: 600,
          height: 300,
        );
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      await _service.shareSvg(
        svgString,
        'codeforge_$timestamp.svg',
        subject: 'CodeForge Generated Vector Barcode',
      );
    } finally {
      _isExporting = false;
      notifyListeners();
    }
  }
}
