import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:sreerajp_qr_studio/l10n/date_format_locale.dart';

void main() {
  setUpAll(() async {
    // Loads the same date data the app gets from GlobalMaterialLocalizations.
    await GlobalMaterialLocalizations.delegate.load(const Locale('en'));
    await GlobalMaterialLocalizations.delegate.load(const Locale('ml'));
  });

  test('keeps English and Malayalam', () {
    expect(dateFormatLocale('en'), 'en');
    expect(dateFormatLocale('ml'), 'ml');
  });

  test('falls back to English for Sanskrit and unknown locales', () {
    expect(dateFormatLocale('sa'), 'en');
    expect(dateFormatLocale('xx'), 'en');
  });

  test('the result can always be used by DateFormat', () {
    final date = DateTime(2026, 10, 10, 21, 30);
    for (final name in ['en', 'ml', 'sa']) {
      expect(
        () => DateFormat.yMMMd(dateFormatLocale(name)).format(date),
        returnsNormally,
      );
    }
  });
}
