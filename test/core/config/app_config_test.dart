import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sreeraj_qr_reader/core/config/app_config.dart';
import 'package:sreeraj_qr_reader/core/config/config_service.dart';

void main() {
  group('LocalizedText', () {
    test('plain text resolves identically for all locales', () {
      const text = LocalizedText.plain('Hello');
      expect(text.isEmpty, isFalse);
      expect(text.resolve('en'), 'Hello');
      expect(text.resolve('ml'), 'Hello');
      expect(text.resolve('sa'), 'Hello');
    });

    test('byLocale resolves matching locale or falls back to en', () {
      const text = LocalizedText.byLocale({
        'en': 'English Text',
        'ml': 'Malayalam Text',
      });
      expect(text.isEmpty, isFalse);
      expect(text.resolve('en'), 'English Text');
      expect(text.resolve('ml'), 'Malayalam Text');
      expect(text.resolve('sa'), 'English Text');
      expect(text.resolve('fr'), 'English Text');
    });

    test('fromJson handles string, locale map, and invalid types', () {
      final fromStr = LocalizedText.fromJson('Simple');
      expect(fromStr.resolve('en'), 'Simple');

      final fromMap = LocalizedText.fromJson({
        'en': 'Eng',
        'ml': 'Mal',
        'sa': 'San',
      });
      expect(fromMap.resolve('en'), 'Eng');
      expect(fromMap.resolve('ml'), 'Mal');
      expect(fromMap.resolve('sa'), 'San');

      final fromInvalid = LocalizedText.fromJson(12345, fallback: 'Default');
      expect(fromInvalid.resolve('en'), 'Default');
    });
  });

  group('AppConfig', () {
    test('fallback returns non-empty defaults', () {
      expect(AppConfig.fallback.appName, isNotEmpty);
      expect(AppConfig.fallback.description.resolve('en'), isNotEmpty);
      expect(AppConfig.fallback.version, isNotEmpty);
      expect(AppConfig.fallback.build, isNotEmpty);
      expect(AppConfig.fallback.details, isNotEmpty);
    });

    test('fromJson parses valid JSON map correctly with localized text', () {
      final json = {
        'appName': 'Test App',
        'description': {
          'en': 'Test Description EN',
          'ml': 'Test Description ML',
        },
        'version': '2.0.0',
        'build': '10',
        'details': {
          'author': 'Test Author',
          'license': {'en': 'Open Source', 'ml': 'ഓപ്പൺ സോഴ്സ്'},
        },
      };

      final config = AppConfig.fromJson(json);
      expect(config.appName, 'Test App');
      expect(config.description.resolve('en'), 'Test Description EN');
      expect(config.description.resolve('ml'), 'Test Description ML');
      expect(config.version, '2.0.0');
      expect(config.build, '10');
      expect(config.details['author']?.resolve('en'), 'Test Author');
      expect(config.details['license']?.resolve('en'), 'Open Source');
      expect(config.details['license']?.resolve('ml'), 'ഓപ്പൺ സോഴ്സ്');
    });

    test('fromJson falls back gracefully on missing or malformed fields', () {
      final json = {
        'appName': 123, // invalid type
        'details': 'not a map', // invalid type
      };

      final config = AppConfig.fromJson(json);
      expect(config.appName, AppConfig.fallback.appName);
      expect(
        config.description.resolve('en'),
        AppConfig.fallback.description.resolve('en'),
      );
      expect(config.version, AppConfig.fallback.version);
      expect(config.build, AppConfig.fallback.build);
      expect(config.details, isEmpty);
    });
  });

  group('ConfigService', () {
    test('load returns parsed AppConfig when asset loading succeeds', () async {
      Future<String> mockLoader(String path) async {
        return '''
        {
          "appName": "Mock App",
          "description": "Mock Desc",
          "version": "1.4.3",
          "build": "1",
          "details": {
            "author": "Mock Author"
          }
        }
        ''';
      }

      final service = ConfigService(loadAsset: mockLoader);
      final config = await service.load();

      expect(config.appName, 'Mock App');
      expect(config.version, '1.4.3');
      expect(config.details['author']?.resolve('en'), 'Mock Author');
    });

    test('load returns AppConfig.fallback on asset loading error', () async {
      Future<String> mockLoader(String path) async {
        throw Exception('Asset not found');
      }

      final service = ConfigService(loadAsset: mockLoader);
      final config = await service.load();

      expect(config.appName, AppConfig.fallback.appName);
      expect(config.version, AppConfig.fallback.version);
    });

    test(
      'loadAndVerify completes without error even on version mismatch',
      () async {
        Future<String> mockLoader(String path) async {
          return '''
        {
          "appName": "Mock App",
          "description": "Mock Desc",
          "version": "1.0.0",
          "build": "1",
          "details": {}
        }
        ''';
        }

        final service = ConfigService(loadAsset: mockLoader);
        final mockInfo = PackageInfo(
          appName: 'Mock App',
          packageName: 'in.sreeraj.qr_reader',
          version: '1.4.3',
          buildNumber: '2',
        );

        final config = await service.loadAndVerify(packageInfo: mockInfo);
        expect(config.version, '1.0.0');
      },
    );
  });
}
