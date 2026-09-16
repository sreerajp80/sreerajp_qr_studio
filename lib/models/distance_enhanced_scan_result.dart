import 'dart:typed_data';
import 'dart:ui';

/// Configuration parameters for the Distance-Enhanced Scanning Pipeline.
class DistanceScanConfig {
  /// Digital zoom upscaling factor applied to candidate ROI (e.g. 2.0x to 4.0x).
  final double zoomFactor;

  /// Sharpening strength for unsharp masking (typically 1.0 to 2.5).
  final double unsharpAmount;

  /// Local contrast boost factor (typically 1.1 to 1.6).
  final double contrastBoost;

  /// Fractional padding margin added around candidate bounding box (e.g. 0.25 = 25%).
  final double cropPadding;

  /// Whether Android native MLKit auto-zoom is active on the camera controller.
  final bool autoZoom;

  const DistanceScanConfig({
    this.zoomFactor = 2.5,
    this.unsharpAmount = 1.5,
    this.contrastBoost = 1.3,
    this.cropPadding = 0.25,
    this.autoZoom = true,
  });

  DistanceScanConfig copyWith({
    double? zoomFactor,
    double? unsharpAmount,
    double? contrastBoost,
    double? cropPadding,
    bool? autoZoom,
  }) {
    return DistanceScanConfig(
      zoomFactor: zoomFactor ?? this.zoomFactor,
      unsharpAmount: unsharpAmount ?? this.unsharpAmount,
      contrastBoost: contrastBoost ?? this.contrastBoost,
      cropPadding: cropPadding ?? this.cropPadding,
      autoZoom: autoZoom ?? this.autoZoom,
    );
  }
}

/// Result of executing the distance-enhanced scan pipeline on a camera frame or photo.
class DistanceEnhancedScanResult {
  /// Whether a barcode was successfully detected and parsed.
  final bool success;

  /// Decoded raw string payload.
  final String? rawValue;

  /// Human-readable barcode format (e.g. 'QR Code', 'Code 128').
  final String? format;

  /// Region of interest bounding box cropped from original frame.
  final Rect? roiBounds;

  /// Digital zoom factor applied during enhancement.
  final double appliedZoom;

  /// Whether unsharp masking was applied.
  final bool unsharpApplied;

  /// Processing duration in milliseconds.
  final int durationMs;

  /// Path to the temporary enhanced image file (if generated).
  final String? enhancedImagePath;

  const DistanceEnhancedScanResult({
    required this.success,
    this.rawValue,
    this.format,
    this.roiBounds,
    this.appliedZoom = 1.0,
    this.unsharpApplied = false,
    this.durationMs = 0,
    this.enhancedImagePath,
  });

  factory DistanceEnhancedScanResult.failure({
    int durationMs = 0,
    Rect? roiBounds,
    double appliedZoom = 1.0,
  }) {
    return DistanceEnhancedScanResult(
      success: false,
      durationMs: durationMs,
      roiBounds: roiBounds,
      appliedZoom: appliedZoom,
    );
  }
}

/// Fast in-memory pure-Dart RGBA pixel buffer supporting ROI cropping,
/// bilinear digital zoom interpolation, contrast stretch, unsharp masking,
/// and BMP byte encoding.
class ImagePixelBuffer {
  final int width;
  final int height;
  final Uint8List rgbaBytes;

  ImagePixelBuffer({
    required this.width,
    required this.height,
    required this.rgbaBytes,
  }) : assert(
         rgbaBytes.length == width * height * 4,
         'RGBA bytes length must match width * height * 4',
       );

  /// Creates a black empty buffer.
  factory ImagePixelBuffer.empty(int width, int height) {
    return ImagePixelBuffer(
      width: width,
      height: height,
      rgbaBytes: Uint8List(width * height * 4),
    );
  }

  /// Crops a region of interest with optional fractional padding.
  ImagePixelBuffer crop(Rect roi, {double padding = 0.0}) {
    final padX = roi.width * padding;
    final padY = roi.height * padding;

    final startX = (roi.left - padX).clamp(0, width - 1).floor();
    final startY = (roi.top - padY).clamp(0, height - 1).floor();
    final endX = (roi.right + padX).clamp(1, width).ceil();
    final endY = (roi.bottom + padY).clamp(1, height).ceil();

    final targetW = endX - startX;
    final targetH = endY - startY;

    if (targetW <= 0 || targetH <= 0) {
      return ImagePixelBuffer.empty(1, 1);
    }

    final outBytes = Uint8List(targetW * targetH * 4);

    for (int y = 0; y < targetH; y++) {
      final srcOffset = ((startY + y) * width + startX) * 4;
      final dstOffset = (y * targetW) * 4;
      final length = targetW * 4;
      outBytes.setRange(dstOffset, dstOffset + length, rgbaBytes, srcOffset);
    }

    return ImagePixelBuffer(
      width: targetW,
      height: targetH,
      rgbaBytes: outBytes,
    );
  }

  /// Upscales the pixel buffer using bilinear digital zoom interpolation.
  ImagePixelBuffer scaleBilinear(double factor) {
    if (factor <= 1.0 || width <= 1 || height <= 1) {
      return ImagePixelBuffer(
        width: width,
        height: height,
        rgbaBytes: Uint8List.fromList(rgbaBytes),
      );
    }

    final newW = (width * factor).round();
    final newH = (height * factor).round();
    final outBytes = Uint8List(newW * newH * 4);

    final xRatio = (width - 1) / (newW - 1);
    final yRatio = (height - 1) / (newH - 1);

    for (int y = 0; y < newH; y++) {
      final srcY = y * yRatio;
      final y0 = srcY.floor();
      final y1 = (y0 + 1 < height) ? y0 + 1 : y0;
      final yWeight = srcY - y0;

      for (int x = 0; x < newW; x++) {
        final srcX = x * xRatio;
        final x0 = srcX.floor();
        final x1 = (x0 + 1 < width) ? x0 + 1 : x0;
        final xWeight = srcX - x0;

        final idx00 = (y0 * width + x0) * 4;
        final idx10 = (y0 * width + x1) * 4;
        final idx01 = (y1 * width + x0) * 4;
        final idx11 = (y1 * width + x1) * 4;

        final dstIdx = (y * newW + x) * 4;

        for (int c = 0; c < 4; c++) {
          final top =
              rgbaBytes[idx00 + c] * (1.0 - xWeight) +
              rgbaBytes[idx10 + c] * xWeight;
          final bottom =
              rgbaBytes[idx01 + c] * (1.0 - xWeight) +
              rgbaBytes[idx11 + c] * xWeight;
          final pixelVal = (top * (1.0 - yWeight) + bottom * yWeight)
              .round()
              .clamp(0, 255);
          outBytes[dstIdx + c] = pixelVal;
        }
      }
    }

    return ImagePixelBuffer(width: newW, height: newH, rgbaBytes: outBytes);
  }

  /// Stretches dynamic contrast and applies brightness adjustment to separate barcode modules.
  ImagePixelBuffer applyContrast({
    double contrast = 1.3,
    double brightness = 0.0,
  }) {
    final outBytes = Uint8List(rgbaBytes.length);
    final bOffset = brightness * 255.0;

    for (int i = 0; i < rgbaBytes.length; i += 4) {
      for (int c = 0; c < 3; c++) {
        final v = rgbaBytes[i + c];
        final adjusted = ((v - 128.0) * contrast + 128.0 + bOffset)
            .round()
            .clamp(0, 255);
        outBytes[i + c] = adjusted;
      }
      outBytes[i + 3] = rgbaBytes[i + 3]; // preserve alpha
    }

    return ImagePixelBuffer(width: width, height: height, rgbaBytes: outBytes);
  }

  /// Applies unsharp masking via separable box-filtered high-pass edge emphasis.
  ///
  /// equation: sharpened = original + amount * (original - blurred)
  ImagePixelBuffer applyUnsharpMask({double amount = 1.5, int radius = 1}) {
    if (amount <= 0.0 || width < 3 || height < 3) {
      return ImagePixelBuffer(
        width: width,
        height: height,
        rgbaBytes: Uint8List.fromList(rgbaBytes),
      );
    }

    // Step 1: Separable horizontal blur pass
    final tempBytes = Uint8List(rgbaBytes.length);
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        int rSum = 0, gSum = 0, bSum = 0, count = 0;
        for (int k = -radius; k <= radius; k++) {
          final sampleX = (x + k).clamp(0, width - 1);
          final idx = (y * width + sampleX) * 4;
          rSum += rgbaBytes[idx];
          gSum += rgbaBytes[idx + 1];
          bSum += rgbaBytes[idx + 2];
          count++;
        }
        final outIdx = (y * width + x) * 4;
        tempBytes[outIdx] = (rSum / count).round();
        tempBytes[outIdx + 1] = (gSum / count).round();
        tempBytes[outIdx + 2] = (bSum / count).round();
        tempBytes[outIdx + 3] = rgbaBytes[outIdx + 3];
      }
    }

    // Step 2: Vertical blur pass & unsharp mask application
    final sharpenedBytes = Uint8List(rgbaBytes.length);
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        int rSum = 0, gSum = 0, bSum = 0, count = 0;
        for (int k = -radius; k <= radius; k++) {
          final sampleY = (y + k).clamp(0, height - 1);
          final idx = (sampleY * width + x) * 4;
          rSum += tempBytes[idx];
          gSum += tempBytes[idx + 1];
          bSum += tempBytes[idx + 2];
          count++;
        }
        final outIdx = (y * width + x) * 4;
        final blurredR = rSum / count;
        final blurredG = gSum / count;
        final blurredB = bSum / count;

        final origR = rgbaBytes[outIdx];
        final origG = rgbaBytes[outIdx + 1];
        final origB = rgbaBytes[outIdx + 2];

        sharpenedBytes[outIdx] = (origR + amount * (origR - blurredR))
            .round()
            .clamp(0, 255);
        sharpenedBytes[outIdx + 1] = (origG + amount * (origG - blurredG))
            .round()
            .clamp(0, 255);
        sharpenedBytes[outIdx + 2] = (origB + amount * (origB - blurredB))
            .round()
            .clamp(0, 255);
        sharpenedBytes[outIdx + 3] = rgbaBytes[outIdx + 3];
      }
    }

    return ImagePixelBuffer(
      width: width,
      height: height,
      rgbaBytes: sharpenedBytes,
    );
  }

  /// Encodes this pixel buffer into standard 24-bit uncompressed BMP bytes.
  /// Fully supported by Android BitmapFactory and MLKit analyzeImage without dependencies.
  Uint8List toBmpBytes() {
    final rowSize = ((width * 3 + 3) ~/ 4) * 4;
    final pixelDataSize = rowSize * height;
    final fileSize = 54 + pixelDataSize;

    final bmp = Uint8List(fileSize);
    final data = ByteData.sublistView(bmp);

    // 14-byte Bitmap File Header
    bmp[0] = 0x42; // 'B'
    bmp[1] = 0x4D; // 'M'
    data.setUint32(2, fileSize, Endian.little);
    data.setUint16(6, 0, Endian.little); // Reserved1
    data.setUint16(8, 0, Endian.little); // Reserved2
    data.setUint32(10, 54, Endian.little); // Pixel data offset

    // 40-byte DIB Header (BITMAPINFOHEADER)
    data.setUint32(14, 40, Endian.little); // Header size
    data.setInt32(18, width, Endian.little); // Width
    data.setInt32(
      22,
      height,
      Endian.little,
    ); // Height (positive: bottom-to-top)
    data.setUint16(26, 1, Endian.little); // Planes
    data.setUint16(28, 24, Endian.little); // Bits per pixel (24-bit BGR)
    data.setUint32(30, 0, Endian.little); // Compression BI_RGB (0)
    data.setUint32(34, pixelDataSize, Endian.little); // Image size
    data.setInt32(38, 2835, Endian.little); // X pixels per meter (72 DPI)
    data.setInt32(42, 2835, Endian.little); // Y pixels per meter (72 DPI)
    data.setUint32(46, 0, Endian.little); // Colors used
    data.setUint32(50, 0, Endian.little); // Important colors

    // Pixel data: BMP expects bottom-to-top row order with BGR colors
    int dstPos = 54;
    for (int y = height - 1; y >= 0; y--) {
      for (int x = 0; x < width; x++) {
        final srcIdx = (y * width + x) * 4;
        final r = rgbaBytes[srcIdx];
        final g = rgbaBytes[srcIdx + 1];
        final b = rgbaBytes[srcIdx + 2];

        bmp[dstPos++] = b;
        bmp[dstPos++] = g;
        bmp[dstPos++] = r;
      }
      // Row padding to multiple of 4 bytes
      final paddingCount = rowSize - (width * 3);
      for (int p = 0; p < paddingCount; p++) {
        bmp[dstPos++] = 0;
      }
    }

    return bmp;
  }
}
