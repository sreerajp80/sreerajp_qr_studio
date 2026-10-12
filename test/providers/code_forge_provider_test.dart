import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/safety_check_result.dart';
import 'package:sreerajp_qr_studio/services/code_forge_service.dart';
import 'package:sreerajp_qr_studio/models/code_forge_config.dart';
import 'package:sreerajp_qr_studio/models/location_result.dart';
import 'package:sreerajp_qr_studio/providers/code_forge_provider.dart';
import 'package:sreerajp_qr_studio/services/location_service.dart';

void main() {
  group('CodeForgeProvider Tests', () {
    late CodeForgeProvider provider;

    setUp(() {
      provider = CodeForgeProvider();
    });

    test('Initializes with default configuration and valid QR matrix', () {
      expect(provider.config.barcodeType, CodeForgeBarcodeType.qrCode);
      expect(provider.config.payloadType, CodeForgePayloadType.url);
      expect(provider.isValid, isTrue);
      expect(provider.qrImage, isNotNull);
      expect(provider.validationError, isNull);
    });

    test('Updating barcode type adjusts raw content sample and matrix', () {
      provider.setBarcodeType(CodeForgeBarcodeType.code128);
      expect(provider.config.barcodeType, CodeForgeBarcodeType.code128);
      expect(provider.config.rawContent, contains('SREERAJ-CODE-128'));
      expect(provider.qrImage, isNull);
      expect(provider.isValid, isTrue);
    });

    test('Updating Wi-Fi fields recalculates payload', () {
      provider.setBarcodeType(CodeForgeBarcodeType.qrCode);
      provider.setPayloadType(CodeForgePayloadType.wifi);
      provider.updateWifi(ssid: 'OfficeNet', password: 'SecretPassword');

      expect(provider.config.wifiSsid, 'OfficeNet');
      expect(provider.config.wifiPassword, 'SecretPassword');
      expect(provider.payloadString, contains('WIFI:T:WPA;S:OfficeNet;'));
      expect(provider.isValid, isTrue);
    });

    test('Updating visual design shapes and colors notifies listeners', () {
      int notifyCount = 0;
      provider.addListener(() => notifyCount++);

      provider.setPatternShape(QrPatternShape.dots);
      expect(provider.config.patternShape, QrPatternShape.dots);

      provider.setEyeShape(QrEyeShape.leaf);
      expect(provider.config.eyeShape, QrEyeShape.leaf);

      provider.setEyeBallShape(QrEyeBallShape.circle);
      expect(provider.config.eyeBallShape, QrEyeBallShape.circle);

      provider.setForegroundColor(0xFF004D40);
      expect(provider.config.foregroundColorValue, 0xFF004D40);

      provider.setGradientTheme(QrGradientTheme.sunset);
      expect(provider.config.gradientTheme, QrGradientTheme.sunset);

      provider.setCenterBadge(QrCenterBadge.shieldVerified);
      expect(provider.config.centerBadge, QrCenterBadge.shieldVerified);

      expect(notifyCount, 6);
    });

    test('resetStylingToDefault restores defaults', () {
      provider.setPatternShape(QrPatternShape.classy);
      provider.setEyeShape(QrEyeShape.circle);
      provider.setForegroundColor(0xFFB71C1C);

      provider.resetStylingToDefault();

      expect(provider.config.patternShape, QrPatternShape.square);
      expect(provider.config.eyeShape, QrEyeShape.square);
      expect(provider.config.foregroundColorValue, 0xFF000000);
      expect(provider.config.gradientTheme, QrGradientTheme.none);
    });
  });

  group('CodeForgeProvider location lookup', () {
    CodeForgeProvider providerWith(Future<LocationResult> Function() lookup) {
      return CodeForgeProvider(locationService: _FakeLocationService(lookup));
    }

    test('success fills latitude and longitude with 6 decimals', () async {
      final provider = providerWith(
        () async => const LocationResult.success(
          latitude: 9.9312328,
          longitude: 76.2673041,
        ),
      );

      final result = await provider.fetchCurrentLocation();

      expect(result?.status, LocationStatus.success);
      expect(provider.config.geoLat, '9.931233');
      expect(provider.config.geoLng, '76.267304');
      expect(provider.isFetchingLocation, isFalse);
    });

    test('permission denied leaves the location empty', () async {
      final provider = providerWith(
        () async => const LocationResult.permissionDenied(),
      );

      final result = await provider.fetchCurrentLocation();

      expect(result?.status, LocationStatus.permissionDenied);
      expect(provider.config.geoLat, isEmpty);
      expect(provider.config.geoLng, isEmpty);
    });

    test('failure leaves the location empty', () async {
      final provider = providerWith(() async => const LocationResult.failed());

      final result = await provider.fetchCurrentLocation();

      expect(result?.status, LocationStatus.failed);
      expect(provider.config.geoLat, isEmpty);
    });

    test('isFetchingLocation is true while the lookup runs', () async {
      final completer = Completer<LocationResult>();
      final provider = providerWith(() => completer.future);

      final pending = provider.fetchCurrentLocation();
      expect(provider.isFetchingLocation, isTrue);
      // A second call while busy is ignored.
      expect(await provider.fetchCurrentLocation(), isNull);

      completer.complete(const LocationResult.failed());
      await pending;
      expect(provider.isFetchingLocation, isFalse);
    });
  });

  group('CodeForgeProvider link safety', () {
    test('safetyIssueCount is 0 before any check', () {
      expect(CodeForgeProvider().safetyIssueCount, 0);
    });

    test('safetyIssueCount is 0 when all checks pass or are skipped', () async {
      final provider = CodeForgeProvider(
        service: _FakeSafetyCodeForgeService([
          _check(passed: true),
          _check(passed: true, skipped: true),
        ]),
      );
      await provider.runUrlSafetyCheck();
      expect(provider.isUrlSafe, isTrue);
      expect(provider.safetyIssueCount, 0);
    });

    test('safetyIssueCount counts failed checks', () async {
      final provider = CodeForgeProvider(
        service: _FakeSafetyCodeForgeService([
          _check(passed: false),
          _check(passed: true),
          _check(passed: false),
        ]),
      );
      await provider.runUrlSafetyCheck();
      expect(provider.isUrlSafe, isFalse);
      expect(provider.safetyIssueCount, 2);
    });
  });
}

class _FakeLocationService extends LocationService {
  final Future<LocationResult> Function() _lookup;

  _FakeLocationService(this._lookup);

  @override
  Future<LocationResult> getCurrentLocation() => _lookup();
}

class _FakeSafetyCodeForgeService extends CodeForgeService {
  final List<SafetyCheckResult> results;

  _FakeSafetyCodeForgeService(this.results);

  @override
  Future<List<SafetyCheckResult>> verifyUrlSafety(String url) async => results;
}

SafetyCheckResult _check({required bool passed, bool skipped = false}) =>
    SafetyCheckResult(
      checkName: const AppMessage(AppMessageKey.checkNamePattern),
      passed: passed,
      message: const AppMessage(AppMessageKey.patternNone),
      skipped: skipped,
    );
