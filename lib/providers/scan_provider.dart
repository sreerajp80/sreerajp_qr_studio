import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/models/dom_sandbox_result.dart';
import 'package:sreerajp_qr_studio/models/encrypted_payload_data.dart';
import 'package:sreerajp_qr_studio/models/parsed_payload.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/safety_check_result.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/models/stego_qr_data.dart';
import 'package:sreerajp_qr_studio/services/biometric_service.dart';
import 'package:sreerajp_qr_studio/services/dom_sandbox_service.dart';
import 'package:sreerajp_qr_studio/services/encrypted_payload_service.dart';
import 'package:sreerajp_qr_studio/services/payload_parser_service.dart';
import 'package:sreerajp_qr_studio/services/stego_qr_service.dart';
import 'package:sreerajp_qr_studio/services/url_safety_service.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';

/// Provider managing scan results, URL safety checks, StegoQR & AirQR state, Smart Payload parsing, QuishingGuard fake-sticker reminder, Zero-Trust DOM Sandboxing, and Scan Feedback preferences.
class ScanProvider extends ChangeNotifier {
  static const String vibrationPrefKey = 'scan_feedback_vibration';
  static const String soundPrefKey = 'scan_feedback_sound';
  static const String animationPrefKey = 'scan_feedback_animation';

  String? _scanResult;
  CodeContentType? _scanType;
  bool _isUrl = false;
  bool _isSafeUrl = true;
  bool _isLoading = false;
  bool _activeProbingEnabled = false;
  bool _isVibrationEnabled = true;
  bool _isSoundEnabled = true;
  bool _isAnimationEnabled = true;
  List<SafetyCheckResult> _safetyChecks = [];
  StegoQrData? _stegoQrData;
  EncryptedPayloadData? _encryptedPayloadData;
  ParsedPayload? _parsedPayload;
  bool _scannedWithCamera = false;
  DomSandboxResult? _domSandboxResult;

  final UrlSafetyService _urlSafetyService;
  final StegoQrService _stegoQrService;
  final EncryptedPayloadService _encryptedPayloadService;
  final BiometricService _biometricService;
  final PayloadParserService _payloadParserService;
  final DomSandboxService _domSandboxService;

  ScanProvider({
    UrlSafetyService? urlSafetyService,
    StegoQrService? stegoQrService,
    EncryptedPayloadService? encryptedPayloadService,
    BiometricService? biometricService,
    PayloadParserService? payloadParserService,
    DomSandboxService? domSandboxService,
  }) : _urlSafetyService = urlSafetyService ?? UrlSafetyService(),
       _stegoQrService = stegoQrService ?? StegoQrService(),
       _encryptedPayloadService =
           encryptedPayloadService ??
           EncryptedPayloadService(
             stegoQrService: stegoQrService ?? StegoQrService(),
           ),
       _biometricService = biometricService ?? BiometricService(),
       _payloadParserService = payloadParserService ?? PayloadParserService(),
       _domSandboxService = domSandboxService ?? DomSandboxService() {
    _loadFeedbackSettings();
  }

  String? get scanResult => _scanResult;
  CodeContentType? get scanType => _scanType;
  bool get isUrl => _isUrl;
  bool get isSafeUrl => _isSafeUrl;
  bool get isLoading => _isLoading;
  bool get isVibrationEnabled => _isVibrationEnabled;
  bool get isSoundEnabled => _isSoundEnabled;
  bool get isAnimationEnabled => _isAnimationEnabled;
  ParsedPayload? get parsedPayload => _parsedPayload;

  /// Whether the result screen should show the QuishingGuard fake-sticker
  /// reminder: the code was read live by the camera (so it may be printed in
  /// a public place) and it holds a link or a payment request.
  ///
  /// The app does not look at the image for stickers; it only reminds the
  /// user to check by hand.
  bool get showStickerReminder =>
      _scannedWithCamera &&
      (_isUrl || _parsedPayload?.type == PayloadType.payment);
  DomSandboxResult? get domSandboxResult => _domSandboxResult;

  Future<void> _loadFeedbackSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isVibrationEnabled = prefs.getBool(vibrationPrefKey) ?? true;
      _isSoundEnabled = prefs.getBool(soundPrefKey) ?? true;
      _isAnimationEnabled = prefs.getBool(animationPrefKey) ?? true;
      notifyListeners();
    } catch (e, st) {
      AppLogger.error(
        'Error loading scan feedback settings',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> setVibrationEnabled(bool enabled) async {
    _isVibrationEnabled = enabled;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(vibrationPrefKey, enabled);
    } catch (e, st) {
      AppLogger.error(
        'Error persisting vibration setting',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> setSoundEnabled(bool enabled) async {
    _isSoundEnabled = enabled;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(soundPrefKey, enabled);
    } catch (e, st) {
      AppLogger.error(
        'Error persisting sound setting',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> setAnimationEnabled(bool enabled) async {
    _isAnimationEnabled = enabled;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(animationPrefKey, enabled);
    } catch (e, st) {
      AppLogger.error(
        'Error persisting animation setting',
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Whether the scanned code contains an encrypted or StegoQR payload.
  bool get isStegoQr => _stegoQrData != null || _encryptedPayloadData != null;

  /// The StegoQR data model if current scan is StegoQR.
  StegoQrData? get stegoQrData => _stegoQrData;

  /// The universal encrypted payload data model if detected.
  EncryptedPayloadData? get encryptedPayloadData => _encryptedPayloadData;

  /// Whether the last safety run used active online probing.
  bool get activeProbingEnabled => _activeProbingEnabled;
  List<SafetyCheckResult> get safetyChecks => List.unmodifiable(_safetyChecks);

  /// Message keys that mean a check could not finish because the network or
  /// the remote server was unavailable. Used to offer a re-check button.
  static const Set<AppMessageKey> _networkErrorKeys = {
    AppMessageKey.sslUnverifiable,
    AppMessageKey.sslCheckFailed,
    AppMessageKey.redirectUnavailable,
    AppMessageKey.patternUnavailable,
    AppMessageKey.shortenerUnavailable,
    AppMessageKey.shortenerOfflineHeuristics,
    AppMessageKey.homographUnavailable,
    AppMessageKey.maliciousUnavailable,
    AppMessageKey.maliciousApiError,
    AppMessageKey.maliciousRateLimited,
  };

  bool get hasNetworkError =>
      _safetyChecks.any((c) => _networkErrorKeys.contains(c.message.key));

  void setScanResult(
    String result,
    CodeContentType type, {
    bool fromCamera = false,
  }) {
    _scanResult = result;
    _scanType = type;
    _scannedWithCamera = fromCamera;

    // 1. Detect universal encrypted container (AirQR, StegoQR, JSON container, PGP)
    _encryptedPayloadData = _encryptedPayloadService.detectEncryptedPayload(
      result,
    );

    if (_stegoQrService.isStegoQr(result)) {
      _stegoQrData = _stegoQrService.parseStegoQr(result);
      _parsedPayload = _payloadParserService.parse(_stegoQrData!.decoyText);
      _isUrl = _checkIfUrl(_stegoQrData!.decoyText);
    } else if (_encryptedPayloadData != null) {
      _stegoQrData = null;
      _parsedPayload = _payloadParserService.parse(
        _encryptedPayloadData!.publicDisplay,
      );
      _isUrl = _checkIfUrl(_encryptedPayloadData!.publicDisplay);
    } else {
      _stegoQrData = null;
      _parsedPayload = _payloadParserService.parse(result);
      _isUrl = _checkIfUrl(result);
    }

    notifyListeners();
  }

  bool _checkIfUrl(String text) {
    final urlRegex = RegExp(
      r'^https?://[\w\-]+(\.[\w\-]+)+[/#?]?.*$',
      caseSensitive: false,
    );
    return urlRegex.hasMatch(text);
  }

  Future<void> checkUrlSafety(String url) async {
    if (!_isUrl) return;

    _isLoading = true;
    _safetyChecks = [];
    _activeProbingEnabled = await _urlSafetyService.isActiveProbingEnabled();
    notifyListeners();

    try {
      _safetyChecks = await _urlSafetyService.runAllChecks(url);
      _domSandboxResult = await _domSandboxService.analyzeAndRender(
        url,
        activeProbing: _activeProbingEnabled,
      );

      final failedChecks = _safetyChecks.where((check) => !check.passed).length;
      _isSafeUrl = failedChecks == 0 && (_domSandboxResult?.isSafe ?? true);
    } catch (e, st) {
      _isSafeUrl = false;
      AppLogger.error('Error checking URL safety', error: e, stackTrace: st);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Unlocks the encrypted / StegoQR payload using biometric authentication and a passphrase/code.
  Future<bool> unlockStegoWithBiometrics({
    required String passphrase,
    required String biometricReason,
  }) async {
    if (_stegoQrData == null && _encryptedPayloadData == null) return false;

    final authenticated = await _biometricService.authenticate(
      localizedReason: biometricReason,
    );

    if (authenticated) {
      return unlockStegoWithPassphrase(passphrase);
    } else {
      if (_stegoQrData != null) {
        _stegoQrData = _stegoQrData!.copyWith(
          error: const AppMessage(AppMessageKey.stegoBiometricCanceled),
        );
      }
      if (_encryptedPayloadData != null) {
        _encryptedPayloadData = _encryptedPayloadData!.copyWith(
          error: const AppMessage(AppMessageKey.stegoBiometricCanceled),
        );
      }
      notifyListeners();
      return false;
    }
  }

  /// Unlocks the StegoQR or universal encrypted payload directly using a passphrase or session code.
  bool unlockStegoWithPassphrase(String passphrase) {
    if (_encryptedPayloadData != null) {
      _encryptedPayloadData = _encryptedPayloadService.decrypt(
        _encryptedPayloadData!,
        passphrase,
      );
      if (_encryptedPayloadData!.decryptedPayload != null) {
        _parsedPayload = _payloadParserService.parse(
          _encryptedPayloadData!.decryptedPayload!,
        );
      }
    }

    if (_stegoQrData != null) {
      _stegoQrData = _stegoQrService.decryptPayload(_stegoQrData!, passphrase);
      if (_stegoQrData!.decryptedPayload != null) {
        _parsedPayload = _payloadParserService.parse(
          _stegoQrData!.decryptedPayload!,
        );
      }
    }

    notifyListeners();
    return (_encryptedPayloadData?.isUnlocked ?? false) ||
        (_stegoQrData?.isUnlocked ?? false);
  }

  /// Decrypts raw or custom ciphertext on-demand.
  String? decryptManualCipher({
    required String passphrase,
    String? mode,
    String? salt,
    String? iv,
  }) {
    if (_scanResult == null) return null;
    return _encryptedPayloadService.decryptRaw(
      rawCipher: _scanResult!,
      passphrase: passphrase,
      mode: mode,
      salt: salt,
      iv: iv,
    );
  }

  /// Creates a ScanRecord representation of the current scan state.
  ScanRecord? createScanRecord({
    String? notes,
    String? locationTag,
    bool isFavorite = false,
    String? source,
  }) {
    if (_scanResult == null) return null;

    String category = 'text';
    if (_parsedPayload != null && _parsedPayload!.type != PayloadType.generic) {
      category = _parsedPayload!.type.name;
    } else if (_isUrl) {
      category = 'url';
    } else if (_scanType != null && _scanType != CodeContentType.unknown) {
      category = 'barcode';
    }

    int score = 100;
    if (_isUrl && _safetyChecks.isNotEmpty) {
      final passedCount = _safetyChecks.where((c) => c.passed).length;
      score = ((passedCount / _safetyChecks.length) * 100).round();
    }

    return ScanRecord(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      timestamp: DateTime.now(),
      rawContent: _scanResult!,
      barcodeFormat: _scanType?.name ?? 'qrCode',
      category: category,
      safetyScore: score,
      notes: notes,
      locationTag: locationTag,
      isFavorite: isFavorite,
      metadata: {
        'isStego': isStegoQr,
        'isSafeUrl': _isSafeUrl,
        'source': ?source,
      },
    );
  }

  void clearScan() {
    _scanResult = null;
    _scanType = null;
    _isUrl = false;
    _isSafeUrl = true;
    _isLoading = false;
    _safetyChecks = [];
    _stegoQrData = null;
    _encryptedPayloadData = null;
    _parsedPayload = null;
    _scannedWithCamera = false;
    _domSandboxResult = null;
    notifyListeners();
  }
}
