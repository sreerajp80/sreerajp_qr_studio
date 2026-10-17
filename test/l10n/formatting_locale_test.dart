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

  test('the result can always be used by DateFormat', () {
    final date = DateTime(2026, 10, 10, 21, 30);
    for (final code in ['en', 'ml', 'sa']) {
      expect(
        () => DateFormat.yMMMd(formattingLocale(Locale(code))).format(date),
        returnsNormally,
      );
    }
  });
}
