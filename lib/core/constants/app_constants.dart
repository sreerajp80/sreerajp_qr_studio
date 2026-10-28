/// Technical constants for the application.
/// Values only, no business logic.
class AppConstants {
  static const String buildDate = String.fromEnvironment(
    'BUILD_DATE',
    defaultValue: 'dev',
  );

  /// Maximum character length for plain text QR code to ensure reliable scanning.
  static const int maxCodeForgeTextLength = 500;

  // --- Limits for images and PDFs from outside the app (docs/security.md §3.1) ---

  /// Largest image file (gallery, file picker, share, clipboard) that is read.
  static const int maxImportImageMb = 50;
  static const int maxImportImageBytes = maxImportImageMb * 1024 * 1024;

  /// Largest PDF file that is read.
  static const int maxImportPdfMb = 100;
  static const int maxImportPdfBytes = maxImportPdfMb * 1024 * 1024;

  /// Only this many PDF pages are checked for codes; later pages are skipped.
  static const int maxPdfPagesScanned = 100;

  /// Longest side, in pixels, a PDF page is drawn at.
  static const int maxPdfRenderDimension = 4096;

  /// Longest clipboard `data:image/...;base64,` text that is decoded
  /// (base64 is 4/3 of the image size, so this matches the image limit).
  static const int maxClipboardDataUriChars = maxImportImageBytes * 4 ~/ 3 + 64;
}
