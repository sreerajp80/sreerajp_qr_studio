import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';

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

    test('Sanskrit passes Hindi marker gate (language pack §4.1)', () {
      final hindiPattern = RegExp(
        r"""(?:^|[\s"'(\[{<>।,.*_`#|:;~-])(?:था|थे|थी|हो|है|हैं|हूं|और)(?=$|[\s"')\]\}<>।,.\?!*_`#|:;~-])|"""
        r'करें|करना|करके|रहा|रही|रहे|गया|गयी|चाहिए|नहीं|लेकिन|क्या|आपका|आपकी|आपके|हमारा|मेरा|कृपया|सेटिंग्स|ऐप|\u093C|[\u0958-\u095F]',
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
      expect(en.titleApp, isNotEmpty);

      final ml = await AppLocalizations.delegate.load(const Locale('ml'));
      expect(ml.titleApp, isNotEmpty);

      final sa = await AppLocalizations.delegate.load(const Locale('sa'));
      expect(sa.titleApp, isNotEmpty);
    });
  });

  group('Translation completeness (§8.7)', () {
    // Values allowed to equal English: placeholders and symbols, product and
    // standard names, and the language endonyms. Keep this list short.
    const sameAsTemplateAllowed = <String, Set<String>>{
      'ml': {
        'labelPercentValue',
        'bodyHistoryTimestamp',
        'labelHistoryScoreBadge',
        'labelAirQrFps',
        'labelScanZoomValue',
        'labelThemeChipOled',
        'labelCheckNameVirusTotal',
        'labelCheckNameUrlhaus',
        'labelCheckNamePhishTank',
        'labelCheckNameOpenPhish',
        'labelFormatIsbn',
        'labelFormatEanUpc',
        'labelFeatureAirQrChip2',
        'labelFeatureContactsChip1',
        'labelCipherModeAesGcm',
        'labelCipherModeAesCbc',
        'labelLanguageEnglish',
        'labelLanguageMalayalam',
        'labelLanguageSanskrit',
      },
      'sa': {
        'labelPercentValue',
        'bodyHistoryTimestamp',
        'labelHistoryScoreBadge',
        'labelAirQrFps',
        'labelScanZoomValue',
        'labelCheckNameUrlhaus',
        'labelCheckNamePhishTank',
        'labelCheckNameOpenPhish',
        'labelFormatIsbn',
        'labelFormatEanUpc',
        'labelFeatureAirQrChip2',
        'labelFeatureContactsChip1',
        'labelCipherModeAesGcm',
        'labelCipherModeAesCbc',
        'labelLanguageEnglish',
        'labelLanguageMalayalam',
        'labelLanguageSanskrit',
      },
    };

    test('no translation is a copy of the English value', () {
      final problems = <String>[];
      for (final MapEntry(key: locale, value: other) in {
        'ml': mlJson,
        'sa': saJson,
      }.entries) {
        for (final key in messageKeys) {
          if (sameAsTemplateAllowed[locale]!.contains(key)) continue;
          final value = other[key];
          if (value is String &&
              value.trim().isNotEmpty &&
              value == enJson[key]) {
            problems.add('app_$locale.arb: $key is untranslated');
          }
        }
      }
      expect(problems, isEmpty, reason: problems.join('\n'));
    });

    test('every key starts with a standard prefix (§8.6)', () {
      // The signature badge pair keeps its fixed names (guideline.md §1.7).
      const fixedNames = {'madeWithLove', 'madeWithLoveA11y'};
      final prefix = RegExp(
        r'^(action|label|title|tab|nav|tooltip|desc|help|empty|error|body|aboutDetail)[A-Z0-9]',
      );
      final unprefixed = messageKeys
          .where((k) => !fixedNames.contains(k) && !prefix.hasMatch(k))
          .toList();
      expect(unprefixed, isEmpty, reason: unprefixed.join('\n'));
    });

    test('the About badge keeps its {heart} marker in every language', () {
      for (final MapEntry(key: locale, value: arb) in {
        'en': enJson,
        'ml': mlJson,
        'sa': saJson,
      }.entries) {
        final text = arb['madeWithLove'] as String?;
        expect(text, isNotNull, reason: 'app_$locale.arb has no madeWithLove');
        expect(
          text!.contains('{heart}'),
          isTrue,
          reason: 'app_$locale.arb madeWithLove is missing {heart}',
        );
      }
    });

    test('app_config.json has every language and a label per detail', () {
      final json = jsonDecode(
        File('assets/config/app_config.json').readAsStringSync(),
      ) as Map<String, dynamic>;
      final problems = <String>[];

      void checkLanguages(String path, Object? value) {
        if (value is! Map<String, dynamic>) return;
        for (final lang in ['en', 'ml', 'sa']) {
          final text = value[lang]?.toString().trim() ?? '';
          if (text.isEmpty) problems.add('$path.$lang is missing or empty');
        }
      }

      for (final field in ['appName', 'description']) {
        expect(
          json[field],
          isA<Map<String, dynamic>>(),
          reason: '$field must be per-language',
        );
        checkLanguages(field, json[field]);
      }
      final details = json['details'] as Map<String, dynamic>;
      for (final MapEntry(key: id, value: value) in details.entries) {
        checkLanguages('details.$id', value);
        final labelKey = 'aboutDetail${id[0].toUpperCase()}${id.substring(1)}';
        if (!messageKeys.contains(labelKey)) {
          problems.add('details.$id has no ARB key "$labelKey"');
        }
      }
      expect(problems, isEmpty, reason: problems.join('\n'));
    });

    test('every English content asset has a Malayalam and Sanskrit twin', () {
      final problems = <String>[];
      final templateFiles = Directory('assets')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => RegExp(r'_en\.[^.]+$').hasMatch(f.path));
      for (final file in templateFiles) {
        for (final lang in ['ml', 'sa']) {
          final twin = file.path.replaceAllMapped(
            RegExp(r'_en(\.[^.]+)$'),
            (m) => '_$lang${m[1]}',
          );
          if (!File(twin).existsSync()) problems.add('Missing $twin');
        }
      }
      expect(problems, isEmpty, reason: problems.join('\n'));
    });
  });
}
