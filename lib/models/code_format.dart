/// Barcode symbologies understood by the app's own decoder.
///
/// [nativeBit] must match the `SRB_FMT_*` bits in
/// `native/sreeraj_barcode/sreeraj_barcode.h`. Enum names are stable: they are
/// used in multi-code ids and must not be renamed.
enum CodeFormat {
  unknown(0),
  qrCode(1 << 0),
  microQrCode(1 << 1),
  rmqrCode(1 << 2),
  dataMatrix(1 << 3),
  aztec(1 << 4),
  pdf417(1 << 5),
  maxiCode(1 << 6),
  code128(1 << 7),
  code39(1 << 8),
  code93(1 << 9),
  codabar(1 << 10),
  ean8(1 << 11),
  ean13(1 << 12),
  upcA(1 << 13),
  upcE(1 << 14),
  itf(1 << 15),
  dataBar(1 << 16);

  const CodeFormat(this.nativeBit);

  /// Bit used by the native bridge for this format.
  final int nativeBit;

  /// The formats the main scanner and AR CodeVision look for.
  static const List<CodeFormat> standardScanFormats = [
    CodeFormat.qrCode,
    CodeFormat.code128,
    CodeFormat.code39,
    CodeFormat.code93,
    CodeFormat.ean8,
    CodeFormat.ean13,
    CodeFormat.upcA,
    CodeFormat.upcE,
    CodeFormat.pdf417,
    CodeFormat.dataMatrix,
  ];

  /// Every format the decoder can read (used for gallery, PDF and shared images).
  static const List<CodeFormat> allReadable = [
    CodeFormat.qrCode,
    CodeFormat.microQrCode,
    CodeFormat.rmqrCode,
    CodeFormat.dataMatrix,
    CodeFormat.aztec,
    CodeFormat.pdf417,
    CodeFormat.maxiCode,
    CodeFormat.code128,
    CodeFormat.code39,
    CodeFormat.code93,
    CodeFormat.codabar,
    CodeFormat.ean8,
    CodeFormat.ean13,
    CodeFormat.upcA,
    CodeFormat.upcE,
    CodeFormat.itf,
    CodeFormat.dataBar,
  ];

  /// Retail product formats (EAN / UPC).
  bool get isRetail =>
      this == CodeFormat.ean8 ||
      this == CodeFormat.ean13 ||
      this == CodeFormat.upcA ||
      this == CodeFormat.upcE;

  /// Returns the format for a native bit, or [CodeFormat.unknown].
  static CodeFormat fromNativeBit(int bit) {
    for (final format in CodeFormat.values) {
      if (format.nativeBit == bit && format != CodeFormat.unknown) {
        return format;
      }
    }
    return CodeFormat.unknown;
  }

  /// Combines [formats] into a native format mask.
  static int maskOf(Iterable<CodeFormat> formats) {
    var mask = 0;
    for (final format in formats) {
      mask |= format.nativeBit;
    }
    return mask;
  }
}
