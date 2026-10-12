import 'package:intl/intl.dart';

/// The locale to pass to `intl`'s [DateFormat] for the app language
/// [localeName].
///
/// `intl` has no date data for Sanskrit (`sa`), and `DateFormat` throws for a
/// locale it does not know. In that case English is used, the same fallback
/// the Sanskrit Material delegates use for dates.
String dateFormatLocale(String localeName) =>
    DateFormat.localeExists(localeName) ? localeName : 'en';
