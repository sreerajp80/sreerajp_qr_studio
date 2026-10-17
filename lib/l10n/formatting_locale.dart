import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Locale to hand to `intl` (engineering standard §8.3.2).
///
/// `intl` has no date or number data for some languages (Sanskrit `sa`), and
/// `DateFormat` throws for a locale it does not know. Those are formatted with
/// the template language's patterns, while the UI text stays translated.
String formattingLocale(Locale locale) =>
    DateFormat.localeExists(locale.toLanguageTag())
    ? locale.toLanguageTag()
    : 'en';
