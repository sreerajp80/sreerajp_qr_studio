/// What kind of data a scanned code carries (URL, Wi-Fi, contact, …).
///
/// Enum names are stored in the scan history database (`barcodeFormat` column
/// of batch scans) and must not be renamed. They intentionally match the names
/// that earlier app versions stored.
enum CodeContentType {
  unknown,
  contactInfo,
  email,
  isbn,
  phone,
  product,
  sms,
  text,
  url,
  wifi,
  geo,
  calendarEvent,
  driverLicense;

  /// Returns the content type with [name], or [CodeContentType.unknown].
  static CodeContentType fromName(String? name) {
    if (name == null) return CodeContentType.unknown;
    for (final type in CodeContentType.values) {
      if (type.name == name) return type;
    }
    return CodeContentType.unknown;
  }
}
