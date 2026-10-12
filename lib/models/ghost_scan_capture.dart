/// One screen picture taken by GhostScan (from the Quick Settings tile, the
/// in-app button, or the floating Scan bubble).
class GhostScanCapture {
  /// Path of the captured JPEG in the app cache.
  final String imagePath;

  /// True when the capture was started from the floating Scan bubble.
  final bool fromBubble;

  /// True when the picture is almost all black. This usually means the app
  /// on screen blocks screen capture (for example, banking apps).
  final bool blocked;

  const GhostScanCapture({
    required this.imagePath,
    this.fromBubble = false,
    this.blocked = false,
  });

  /// Builds a capture from platform channel arguments.
  ///
  /// Accepts the older plain path string and the newer map form. Returns
  /// null for anything that has no usable image path.
  static GhostScanCapture? fromChannel(Object? value) {
    if (value is String) {
      return value.isEmpty ? null : GhostScanCapture(imagePath: value);
    }
    if (value is Map) {
      final path = value['imagePath'];
      if (path is! String || path.isEmpty) return null;
      final fromBubble = value['fromBubble'];
      final blocked = value['blocked'];
      return GhostScanCapture(
        imagePath: path,
        fromBubble: fromBubble is bool && fromBubble,
        blocked: blocked is bool && blocked,
      );
    }
    return null;
  }
}
