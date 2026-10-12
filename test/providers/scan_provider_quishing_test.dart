import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/quishing_analysis_result.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';

void main() {
  group('ScanProvider QuishingGuard Integration', () {
    late ScanProvider provider;

    setUp(() {
      provider = ScanProvider();
    });

    test('setScanResult populates quishingResult automatically', () {
      expect(provider.quishingResult, isNull);

      provider.setScanResult(
        'https://example-parking.com/pay',
        CodeContentType.url,
      );

      expect(provider.quishingResult, isNotNull);
      expect(
        provider.quishingResult!.riskLevel,
        equals(QuishingRiskLevel.authentic),
      );
      expect(provider.quishingResult!.overallRiskScore, lessThan(0.35));
    });

    test(
      'setScanResult forwards quishingMetadata for overlay sticker detection',
      () {
        provider.setScanResult(
          'https://fake-phishing-sticker.com',
          CodeContentType.url,
          quishingMetadata: {
            'simulatedRiskLevel': QuishingRiskLevel.highWarning,
            'simulatedEdgeScore': 0.90,
            'simulatedTextureScore': 0.85,
          },
        );

        expect(provider.quishingResult, isNotNull);
        expect(
          provider.quishingResult!.riskLevel,
          equals(QuishingRiskLevel.highWarning),
        );
        expect(provider.quishingResult!.overallRiskScore, equals(0.88));
        expect(
          provider.quishingResult!.statusLabel.key,
          AppMessageKey.quishingStatusHighWarning,
        );
      },
    );

    test('runQuishingAnalysis updates quishingResult for active scan', () {
      provider.setScanResult(
        'https://test-restaurant.com/menu',
        CodeContentType.url,
      );

      provider.runQuishingAnalysis(
        metadata: {'simulatedRiskLevel': QuishingRiskLevel.wearAndTear},
      );

      expect(provider.quishingResult, isNotNull);
      expect(
        provider.quishingResult!.riskLevel,
        equals(QuishingRiskLevel.wearAndTear),
      );
    });

    test('clearScan resets quishingResult state', () {
      provider.setScanResult('https://example.com', CodeContentType.url);
      expect(provider.quishingResult, isNotNull);

      provider.clearScan();
      expect(provider.quishingResult, isNull);
    });
  });
}
