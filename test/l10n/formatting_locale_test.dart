import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart' show GlobalMaterialLocalizations;
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:sreerajp_qr_studio/l10n/formatting_locale.dart';

void main() {
  setUpAll(() async {
    // Loads the same date data the app gets from GlobalMaterialLocalizations.
    await GlobalMaterialLocalizations.delegate.load(const Locale('en'));
    await GlobalMaterialLocalizations.delegate.load(const Locale('ml'));
  });

  test('keeps English and Malayalam', () {
    expect(formattingLocale(const Locale('en')), 'en');
    expect(formattingLocale(const Locale('ml')), 'ml');
  });

  test('falls back to English for Sanskrit and unknown locales', () {
    expect(formattingLocale(const Locale('sa')), 'en');
    expect(formattingLocale(const Locale('xx')), 'en');
  });

  test('a regional locale keeps its region or falls back to its language', () {
    final us = formattingLocale(const Locale('en', 'US'));
    expect(us, anyOf('en_US', 'en'));
    expect(us, isNot(contains('-')));
    expect(formattingLocale(const Locale('ml', 'IN')), anyOf('ml_IN', 'ml'));
    expect(formattingLocale(const Locale('sa', 'IN')), 'en');
  });

  test('the result can always be used by DateFormat', () {
    final date = DateTime(2026, 10, 10, 21, 30);
    for (final locale in const [
      Locale('en'),
      Locale('en', 'US'),
      Locale('ml'),
      Locale('ml', 'IN'),
      Locale('sa'),
      Locale('sa', 'IN'),
    ]) {
      expect(
        () => DateFormat.yMMMd(formattingLocale(locale)).format(date),
        returnsNormally,
      );
    }
  });
}
