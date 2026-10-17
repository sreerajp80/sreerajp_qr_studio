/// Build environments of the app (engineering standard §5.2).
enum AppFlavor { dev, prod }

/// Reads the build flavor at compile time.
///
/// Two names are checked, in order:
/// 1. `APP_FLAVOR` — passed by desktop builds with `--dart-define`.
/// 2. `FLUTTER_APP_FLAVOR` — set by Flutter itself when `--flavor` is passed
///    (Android). It cannot be passed with `--dart-define`.
///
/// An unflavored build resolves to [AppFlavor.prod].
class AppFlavorConfig {
  AppFlavorConfig._(this.flavor);

  static const _appFlavorValue = String.fromEnvironment('APP_FLAVOR');

  static const _frameworkFlavorValue = String.fromEnvironment(
    'FLUTTER_APP_FLAVOR',
    defaultValue: 'prod',
  );

  static String _resolved() =>
      _appFlavorValue.isNotEmpty ? _appFlavorValue : _frameworkFlavorValue;

  static final AppFlavorConfig instance = AppFlavorConfig._(parse(_resolved()));

  final AppFlavor flavor;

  /// Maps a flavor name to [AppFlavor]. Unknown names fall back to prod.
  static AppFlavor parse(String value) {
    switch (value.trim().toLowerCase()) {
      case 'dev':
        return AppFlavor.dev;
      case 'prod':
      default:
        return AppFlavor.prod;
    }
  }

  bool get isDev => flavor == AppFlavor.dev;
  bool get isProd => flavor == AppFlavor.prod;

  /// Trace and debug logs are printed only in dev builds (§14.3).
  bool get enableVerboseLogging => isDev;
}
