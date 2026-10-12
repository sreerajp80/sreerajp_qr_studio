import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ScanProvider DomSandbox Tests', () {
    test('checkUrlSafety triggers DomSandboxService analysis and populates domSandboxResult', () async {
      final provider = ScanProvider();

      provider.setScanResult('https://example.com/test', CodeContentType.url);
      expect(provider.isUrl, isTrue);
      expect(provider.domSandboxResult, isNull);

      await provider.checkUrlSafety('https://example.com/test');

      expect(provider.domSandboxResult, isNotNull);
      expect(
        provider.domSandboxResult?.url,
        equals('https://example.com/test'),
      );
      expect(provider.domSandboxResult?.isSanitized, isTrue);

      provider.clearScan();
      expect(provider.domSandboxResult, isNull);
    });
  });
}
