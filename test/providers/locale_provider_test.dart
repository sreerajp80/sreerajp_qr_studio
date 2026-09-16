import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreeraj_qr_reader/providers/locale_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('LocaleProvider Unit Tests', () {
    test('Initial defaults follow system default', () async {
      final provider = LocaleProvider();
      await Future<void>.delayed(Duration.zero);

      expect(provider.locale, isNull);
      expect(provider.languageCode, equals('system'));
      expect(provider.isSystem, isTrue);
    });

    test('Loads persisted language from SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({LocaleProvider.prefKey: 'ml'});

      final provider = LocaleProvider();
      await Future<void>.delayed(Duration.zero);

      expect(provider.locale, equals(const Locale('ml')));
      expect(provider.languageCode, equals('ml'));
      expect(provider.isSystem, isFalse);
    });

    test('Switching to English updates state and persists', () async {
      final provider = LocaleProvider();
      await Future<void>.delayed(Duration.zero);

      await provider.setLanguage('en');
      expect(provider.locale, equals(const Locale('en')));
      expect(provider.languageCode, equals('en'));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(LocaleProvider.prefKey), equals('en'));
    });

    test('Switching to Malayalam updates state and persists', () async {
      final provider = LocaleProvider();
      await Future<void>.delayed(Duration.zero);

      await provider.setLanguage('ml');
      expect(provider.locale, equals(const Locale('ml')));
      expect(provider.languageCode, equals('ml'));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(LocaleProvider.prefKey), equals('ml'));
    });

    test('Switching to Sanskrit updates state and persists', () async {
      final provider = LocaleProvider();
      await Future<void>.delayed(Duration.zero);

      await provider.setLanguage('sa');
      expect(provider.locale, equals(const Locale('sa')));
      expect(provider.languageCode, equals('sa'));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(LocaleProvider.prefKey), equals('sa'));
    });

    test(
      'Switching to System sets null locale and languageCode system',
      () async {
        SharedPreferences.setMockInitialValues({LocaleProvider.prefKey: 'sa'});

        final provider = LocaleProvider();
        await Future<void>.delayed(Duration.zero);
        expect(provider.languageCode, equals('sa'));

        await provider.setLanguage('system');
        expect(provider.locale, isNull);
        expect(provider.languageCode, equals('system'));
        expect(provider.isSystem, isTrue);

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString(LocaleProvider.prefKey), equals('system'));
      },
    );
  });
}
