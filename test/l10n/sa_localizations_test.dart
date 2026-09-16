import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreeraj_qr_reader/l10n/sa_material_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Sanskrit Localizations Delegates', () {
    test('SaMaterialLocalizationsDelegate supports sa', () {
      const delegate = SaMaterialLocalizationsDelegate();
      expect(delegate.isSupported(const Locale('sa')), isTrue);
      expect(delegate.isSupported(const Locale('en')), isFalse);
    });

    test('SaCupertinoLocalizationsDelegate supports sa', () {
      const delegate = SaCupertinoLocalizationsDelegate();
      expect(delegate.isSupported(const Locale('sa')), isTrue);
      expect(delegate.isSupported(const Locale('en')), isFalse);
    });

    test('SaWidgetsLocalizationsDelegate supports sa', () {
      const delegate = SaWidgetsLocalizationsDelegate();
      expect(delegate.isSupported(const Locale('sa')), isTrue);
      expect(delegate.isSupported(const Locale('en')), isFalse);
    });

    test('SaMaterialLocalizations loads and provides valid values', () async {
      const delegate = SaMaterialLocalizationsDelegate();
      final localizations = await delegate.load(const Locale('sa'));

      expect(localizations, isNotNull);
      expect(localizations.okButtonLabel, isNotEmpty);
      expect(localizations.cancelButtonLabel, isNotEmpty);
      expect(localizations.closeButtonLabel, isNotEmpty);
      expect(localizations.copyButtonLabel, isNotEmpty);
    });

    test('SaCupertinoLocalizations loads and provides valid values', () async {
      const delegate = SaCupertinoLocalizationsDelegate();
      final localizations = await delegate.load(const Locale('sa'));

      expect(localizations, isNotNull);
      expect(localizations.copyButtonLabel, isNotEmpty);
      expect(localizations.selectAllButtonLabel, isNotEmpty);
    });
  });
}
