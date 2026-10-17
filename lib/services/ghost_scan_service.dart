import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sreerajp_qr_studio/models/ghost_scan_capture.dart';

/// Service interfacing with the native Android GhostScan platform channel.
///
/// Enables on-demand screen content QR code detection via Quick Settings tile,
/// the floating Scan bubble, or in-app trigger, strictly compliant with
/// Google Play Store policies.
///
/// The app uses the one shared [instance]. A method channel has only one
/// handler, so a second service would take over captures, and they would be
/// lost once that service's screen is disposed.
class GhostScanService {
  static const MethodChannel _defaultChannel = MethodChannel(
    'in.sreerajp.qr_studio/ghost_scan',
  );

  /// Shared instance for the whole app. Never disposed; screens only cancel
  /// their own [onCapture] subscriptions.
  static final GhostScanService instance = GhostScanService();

  final MethodChannel _channel;
  final StreamController<GhostScanCapture> _captureController =
      StreamController<GhostScanCapture>.broadcast();

  /// Stream of screen captures delivered from GhostScan.
  Stream<GhostScanCapture> get onCapture => _captureController.stream;

  /// Stream of captured image paths delivered from GhostScan.
  Stream<String> get onGhostScanImage =>
      onCapture.map((capture) => capture.imagePath);

  GhostScanService({MethodChannel? channel})
    : _channel = channel ?? _defaultChannel {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    if (call.method == 'onGhostScanImage') {
      final capture = GhostScanCapture.fromChannel(call.arguments);
      if (capture != null) {
        _captureController.add(capture);
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
  Future<GhostScanCapture?> getInitialCapture() async {
    try {
      final dynamic value = await _channel.invokeMethod<dynamic>(
        'getInitialGhostScanImage',
      );
      return GhostScanCapture.fromChannel(value);
    } catch (_) {
      return null;
    }
  }

  /// Checks if the app was launched with a pending GhostScan capture and
  /// returns only its image path.
  Future<String?> getInitialGhostScanImage() async {
    final capture = await getInitialCapture();
    return capture?.imagePath;
  }

  /// Deletes a captured screen picture from the app cache once it has been
  /// decoded. Errors are ignored: the cache is cleared by Android anyway.
  Future<void> deleteCapture(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {}
  }

  /// Releases resources. Only for services made with a test channel; never
  /// call it on [instance].
  void dispose() {
    _captureController.close();
  }
}
