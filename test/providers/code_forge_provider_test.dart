import 'package:flutter_test/flutter_test.dart';
import 'package:sreeraj_qr_reader/models/code_forge_config.dart';
import 'package:sreeraj_qr_reader/providers/code_forge_provider.dart';

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
}
