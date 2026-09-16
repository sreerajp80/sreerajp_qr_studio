/// A config text that may be language-independent (one string) or translated
/// (one string per locale code). Resolution order: exact locale → 'en' → any.
class LocalizedText {
  final Map<String, String> _byLocale;
  final String _plain;

  const LocalizedText.plain(String value)
    : _plain = value,
      _byLocale = const {};

  const LocalizedText.byLocale(Map<String, String> byLocale)
    : _plain = '',
      _byLocale = byLocale;

  bool get isEmpty => _plain.trim().isEmpty && _byLocale.isEmpty;

  /// [languageCode] is the active app language: 'en', 'ml' or 'sa'.
  String resolve(String languageCode) {
    if (_byLocale.isEmpty) return _plain;
    return _byLocale[languageCode] ??
        _byLocale['en'] ??
        (_byLocale.values.isEmpty ? '' : _byLocale.values.first);
  }

  /// Accepts a JSON string or a {"en": ..., "ml": ..., "sa": ...} map.
  factory LocalizedText.fromJson(Object? raw, {String fallback = ''}) {
    if (raw is String) return LocalizedText.plain(raw);
    if (raw is Map) {
      final out = <String, String>{};
      raw.forEach((k, v) {
        if (k is String && v is String) out[k] = v;
      });
      if (out.isNotEmpty) return LocalizedText.byLocale(out);
    }
    return LocalizedText.plain(fallback);
  }
}

/// Typed values for the About screen, loaded from `assets/config/app_config.json`.
/// Changing About content is a config edit, not a code change.
class AppConfig {
  final String appName;
  final LocalizedText description;
  final String version;
  final String build;
  final Map<String, LocalizedText> details;

  const AppConfig({
    required this.appName,
    required this.description,
    required this.version,
    required this.build,
    this.details = const {},
  });

  /// Safe built-in value used when the config file is missing or malformed,
  /// so the app never crashes on a bad config.
  static const AppConfig fallback = AppConfig(
    appName: 'SreerajP QR Reader',
    description: LocalizedText.plain(
      'A privacy-first QR and barcode scanner with 6-layer URL safety checks.',
    ),
    version: '2.8.1',
    build: '21',
    details: {
      'author': LocalizedText.plain('Sreeraj P'),
      'email': LocalizedText.plain('sreerajp@zohomail.in'),
      'license': LocalizedText.plain('All libraries used are open source.'),
      'aiUsed': LocalizedText.plain(
        'Anthropic Claude, Gemini 3.6, ChatGPT 5.4',
      ),
      'ideUsed': LocalizedText.plain('VS Code / Gemini Antigravity IDE'),
    },
  );

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    String str(String key, String fallbackValue) {
      final value = json[key];
      return value is String ? value : fallbackValue;
    }

    Map<String, LocalizedText> parseDetails(String key) {
      final raw = json[key];
      if (raw is! Map) return const {};
      final out = <String, LocalizedText>{};
      raw.forEach((k, v) {
        if (k is String) {
          final text = LocalizedText.fromJson(v);
          if (!text.isEmpty) out[k] = text;
        }
      });
      return out;
    }

    return AppConfig(
      appName: str('appName', fallback.appName),
      description: LocalizedText.fromJson(
        json['description'],
        fallback: fallback.description.resolve('en'),
      ),
      version: str('version', fallback.version),
      build: str('build', fallback.build),
      details: parseDetails('details'),
    );
  }
}
