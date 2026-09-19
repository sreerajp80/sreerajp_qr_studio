import 'dart:async';
import 'package:flutter/services.dart';

/// Service interfacing with the native Android GhostScan platform channel.
///
/// Enables on-demand screen content QR code detection via Quick Settings tile
/// or in-app trigger, strictly compliant with Google Play Store policies.
class GhostScanService {
  static const MethodChannel _defaultChannel = MethodChannel(
    'in.sreeraj.qr_reader/ghost_scan',
  );

  final MethodChannel _channel;
  final StreamController<String> _ghostScanImageController =
      StreamController<String>.broadcast();

  /// Stream of captured image paths delivered from GhostScan.
  Stream<String> get onGhostScanImage => _ghostScanImageController.stream;

  GhostScanService({MethodChannel? channel})
    : _channel = channel ?? _defaultChannel {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    if (call.method == 'onGhostScanImage') {
      final dynamic arg = call.arguments;
      if (arg is String && arg.isNotEmpty) {
        _ghostScanImageController.add(arg);
      }
    }
  }

  /// Returns true if the device supports GhostScan (Android 7.0+ / API 24+).
  Future<bool> isSupported() async {
    try {
      final bool? supported = await _channel.invokeMethod<bool>('isSupported');
      return supported ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Returns true if the device supports programmatic Quick Settings tile addition (Android 13+ / API 33+).
  Future<bool> isTileRequestSupported() async {
    try {
      final bool? supported = await _channel.invokeMethod<bool>(
        'isTileRequestSupported',
      );
      return supported ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Requests the system to prompt the user to add the GhostScan Quick Settings tile (Android 13+).
  Future<bool> requestAddTile() async {
    try {
      final bool? result = await _channel.invokeMethod<bool>('requestAddTile');
      return result ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Minimizes the app and triggers an on-demand screen capture of the underlying screen.
  Future<bool> startGhostScan() async {
    try {
      final bool? result = await _channel.invokeMethod<bool>('startGhostScan');
      return result ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Checks if the app was launched with a pending GhostScan capture.
  Future<String?> getInitialGhostScanImage() async {
    try {
      return await _channel.invokeMethod<String>('getInitialGhostScanImage');
    } catch (_) {
      return null;
    }
  }

  /// Releases resources.
  void dispose() {
    _ghostScanImageController.close();
  }
}
