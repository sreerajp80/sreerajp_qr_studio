import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreeraj_qr_reader/models/code_forge_config.dart';

void main() {
  group('CodeForgeConfig Tests', () {
    test('Default values are initialized correctly', () {
      const config = CodeForgeConfig();

      expect(config.barcodeType, CodeForgeBarcodeType.qrCode);
      expect(config.payloadType, CodeForgePayloadType.text);
      expect(config.patternShape, QrPatternShape.square);
      expect(config.eyeShape, QrEyeShape.square);
      expect(config.eyeBallShape, QrEyeBallShape.square);
      expect(config.foregroundColorValue, 0xFF000000);
      expect(config.backgroundColorValue, 0xFFFFFFFF);
      expect(config.eyeOuterColor, isNull);
      expect(config.eyeInnerColor, isNull);
      expect(config.gradientTheme, QrGradientTheme.none);
      expect(config.gradientColors, isNull);
      expect(config.errorCorrectionLevel, 0); // M
      expect(config.centerBadge, QrCenterBadge.none);
      expect(config.includeTextLabel, isTrue);
    });

    test('copyWith updates fields immutably', () {
      const config = CodeForgeConfig();

      final updated = config.copyWith(
        barcodeType: CodeForgeBarcodeType.code128,
        payloadType: CodeForgePayloadType.wifi,
        patternShape: QrPatternShape.dots,
        eyeShape: QrEyeShape.leaf,
        eyeBallShape: QrEyeBallShape.circle,
        foregroundColorValue: 0xFF1A237E,
        backgroundColorValue: 0xFFF5F5F5,
        eyeOuterColorValue: 0xFFB71C1C,
        eyeInnerColorValue: 0xFFE65100,
        gradientTheme: QrGradientTheme.sunset,
        errorCorrectionLevel: 2, // H
        centerBadge: QrCenterBadge.shieldVerified,
        wifiSsid: 'TestNet',
        wifiPassword: 'Pass',
      );

      expect(updated.barcodeType, CodeForgeBarcodeType.code128);
      expect(updated.payloadType, CodeForgePayloadType.wifi);
      expect(updated.patternShape, QrPatternShape.dots);
      expect(updated.eyeShape, QrEyeShape.leaf);
      expect(updated.eyeBallShape, QrEyeBallShape.circle);
      expect(updated.foregroundColor, const Color(0xFF1A237E));
      expect(updated.backgroundColor, const Color(0xFFF5F5F5));
      expect(updated.eyeOuterColor, const Color(0xFFB71C1C));
      expect(updated.eyeInnerColor, const Color(0xFFE65100));
      expect(updated.gradientTheme, QrGradientTheme.sunset);
      expect(updated.gradientColors, isNotNull);
      expect(updated.gradientColors!.length, 2);
      expect(updated.errorCorrectionLevel, 2);
      expect(updated.centerBadge, QrCenterBadge.shieldVerified);
      expect(updated.wifiSsid, 'TestNet');
      expect(updated.wifiPassword, 'Pass');

      // Test clearing optional eye colors
      final cleared = updated.copyWith(
        clearEyeOuterColor: true,
        clearEyeInnerColor: true,
      );
      expect(cleared.eyeOuterColor, isNull);
      expect(cleared.eyeInnerColor, isNull);
    });
  });
}
