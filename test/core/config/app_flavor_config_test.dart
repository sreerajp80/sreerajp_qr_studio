import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/core/config/app_flavor_config.dart';

void main() {
  group('AppFlavorConfig', () {
    test('an unflavored test build resolves to prod', () {
      expect(AppFlavorConfig.instance.flavor, AppFlavor.prod);
      expect(AppFlavorConfig.instance.isProd, isTrue);
      expect(AppFlavorConfig.instance.enableVerboseLogging, isFalse);
    });

    test('parse is case-insensitive and trims spaces', () {
      expect(AppFlavorConfig.parse('dev'), AppFlavor.dev);
      expect(AppFlavorConfig.parse(' DEV '), AppFlavor.dev);
      expect(AppFlavorConfig.parse('Prod'), AppFlavor.prod);
    });

    test('unknown or empty names fall back to prod', () {
      expect(AppFlavorConfig.parse('staging'), AppFlavor.prod);
      expect(AppFlavorConfig.parse(''), AppFlavor.prod);
    });
  });
}
