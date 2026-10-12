import 'package:sreerajp_qr_studio/models/code_content_type.dart';

/// The category of content detected in the system clipboard.
enum ClipboardContentType {
  /// Web URL or deep link (e.g. http://, https://, market://).
  url,

  /// Structured barcode data payload (e.g. Wi-Fi, vCard, UPI, ISBN, retail barcode).
  barcodePayload,

  /// Image file path or decoded image data.
  image,

  /// Plain generic text payload.
  text,
}

/// Represents scannable data extracted from the system clipboard.
class ClipboardScanData {
  /// The classified type of the clipboard content.
  final ClipboardContentType type;

  /// The raw string content, URL, or local image file path.
  final String content;

  /// The associated barcode type (e.g. [CodeContentType.url], [CodeContentType.wifi], [CodeContentType.text]).
  final CodeContentType barcodeType;

  /// A shortened representation suitable for quick display in UI pills or chips.
  final String preview;

  const ClipboardScanData({
    required this.type,
    required this.content,
    required this.barcodeType,
    required this.preview,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClipboardScanData &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          content == other.content &&
          barcodeType == other.barcodeType &&
          preview == other.preview;

  @override
  int get hashCode => Object.hash(type, content, barcodeType, preview);

  @override
  String toString() =>
      'ClipboardScanData(type: $type, barcodeType: $barcodeType, preview: $preview)';
}
