import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreeraj_qr_reader/l10n/gen/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Map<String, dynamic> enJson;
  late Map<String, dynamic> mlJson;
  late Map<String, dynamic> saJson;
  late Set<String> messageKeys;

  setUpAll(() {
    final enFile = File('lib/l10n/app_en.arb');
    final mlFile = File('lib/l10n/app_ml.arb');
    final saFile = File('lib/l10n/app_sa.arb');

    expect(enFile.existsSync(), isTrue, reason: 'app_en.arb must exist');
    expect(mlFile.existsSync(), isTrue, reason: 'app_ml.arb must exist');
    expect(saFile.existsSync(), isTrue, reason: 'app_sa.arb must exist');

    enJson = jsonDecode(enFile.readAsStringSync()) as Map<String, dynamic>;
    mlJson = jsonDecode(mlFile.readAsStringSync()) as Map<String, dynamic>;
    saJson = jsonDecode(saFile.readAsStringSync()) as Map<String, dynamic>;

    messageKeys = enJson.keys.where((k) => !k.startsWith('@')).toSet();
  });

  group('Tri-lingual ARB Parity', () {
    test('app_ml.arb has full key parity with app_en.arb', () {
      final mlKeys = mlJson.keys.where((k) => !k.startsWith('@')).toSet();
      final missingInMl = messageKeys.difference(mlKeys);
      final extraInMl = mlKeys.difference(messageKeys);

      expect(missingInMl, isEmpty, reason: 'Keys missing in app_ml.arb');
      expect(extraInMl, isEmpty, reason: 'Extraneous keys in app_ml.arb');
    });

    test('app_sa.arb has full key parity with app_en.arb', () {
      final saKeys = saJson.keys.where((k) => !k.startsWith('@')).toSet();
      final missingInSa = messageKeys.difference(saKeys);
      final extraInSa = saKeys.difference(messageKeys);

      expect(missingInSa, isEmpty, reason: 'Keys missing in app_sa.arb');
      expect(extraInSa, isEmpty, reason: 'Extraneous keys in app_sa.arb');
    });

    test('Placeholders match across all three languages', () {
      final phRegex = RegExp(r'\{([a-zA-Z0-9_]+)\}');

      for (final key in messageKeys) {
        final enVal = enJson[key] as String;
        final mlVal = mlJson[key] as String;
        final saVal = saJson[key] as String;

        final enPhs = phRegex.allMatches(enVal).map((m) => m.group(1)!).toSet();
        final mlPhs = phRegex.allMatches(mlVal).map((m) => m.group(1)!).toSet();
        final saPhs = phRegex.allMatches(saVal).map((m) => m.group(1)!).toSet();

        expect(
          mlPhs,
          equals(enPhs),
          reason: 'Placeholder mismatch in ml for key "$key"',
        );
        expect(
          saPhs,
          equals(enPhs),
          reason: 'Placeholder mismatch in sa for key "$key"',
        );
      }
    });

    test('Sanskrit passes Hindi marker gate (§8.5.1)', () {
      final hindiPattern = RegExp(
        r"""(?:^|[\s"'(\[{<>।,.*_`#|:;~-])(?:था|थे|थी|हो|है|हैं|हूं|और)(?=$|[\s"')\]\}<>।,.\?!*_`#|:;~-])|"""
        r'करें|करना|करके|रहा|रही|रहे|गया|गयी|चाहिए|नहीं|लेकिन|क्या|कृपया|सेटिंग्स|ऐप|\u093C|[\u0958-\u095F]',
      );

      final violations = <String, String>{};
      for (final key in messageKeys) {
        final text = saJson[key] as String;
        final match = hindiPattern.firstMatch(text);
        if (match != null) {
          violations[key] = 'Found "${match.group(0)}" in "$text"';
        }
      }

      expect(
        violations,
        isEmpty,
        reason: 'Sanskrit contains forbidden Hindi markers: $violations',
      );
    });

    test('All three locales load through AppLocalizations delegate', () async {
      final en = await AppLocalizations.delegate.load(const Locale('en'));
      expect(en.appTitle, isNotEmpty);

      final ml = await AppLocalizations.delegate.load(const Locale('ml'));
      expect(ml.appTitle, isNotEmpty);

      final sa = await AppLocalizations.delegate.load(const Locale('sa'));
      expect(sa.appTitle, isNotEmpty);
    });
  });
}
