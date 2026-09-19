/// Technical constants for the application.
/// Values only, no business logic.
class AppConstants {
  static const String buildDate = String.fromEnvironment(
    'BUILD_DATE',
    defaultValue: 'dev',
  );

  /// Maximum character length for plain text QR code to ensure reliable scanning.
  static const int maxCodeForgeTextLength = 500;
}
