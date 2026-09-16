import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sreeraj_qr_reader/models/distance_enhanced_scan_result.dart';

/// Pure-Dart offline service executing the distance-enhanced scanning pipeline.
///
/// Detects distant QR codes/barcodes, crops the region of interest (ROI),
/// applies bilinear digital zoom upscaling, dynamic contrast boost, and
/// unsharp masking before passing to the barcode engine.
class DistanceEnhancementService {
  const DistanceEnhancementService();

  /// Calculates a candidate region of interest (ROI) for distant scanning.
  ///
  /// - If [corners] are provided from a weak/distant detection, constructs an expanded bounding box.
  /// - If [tapFocus] is provided, centers a crop area around the user's tapped point.
  /// - Defaults to the central 40% viewport region where distant codes are targeted.
  ui.Rect calculateCandidateRoi(
    ui.Size imageSize, {
    List<ui.Offset>? corners,
    ui.Offset? tapFocus,
    double defaultFraction = 0.45,
    double padding = 0.25,
  }) {
    if (imageSize.width <= 0 || imageSize.height <= 0) {
      return ui.Rect.zero;
    }

    if (corners != null && corners.length >= 2) {
      double minX = corners.first.dx;
      double maxX = corners.first.dx;
      double minY = corners.first.dy;
      double maxY = corners.first.dy;

      for (final pt in corners) {
        if (pt.dx < minX) minX = pt.dx;
        if (pt.dx > maxX) maxX = pt.dx;
        if (pt.dy < minY) minY = pt.dy;
        if (pt.dy > maxY) maxY = pt.dy;
      }

      final boxW = maxX - minX;
      final boxH = maxY - minY;
      final padX = boxW * padding;
      final padY = boxH * padding;

      return ui.Rect.fromLTRB(
        (minX - padX).clamp(0.0, imageSize.width),
        (minY - padY).clamp(0.0, imageSize.height),
        (maxX + padX).clamp(0.0, imageSize.width),
        (maxY + padY).clamp(0.0, imageSize.height),
      );
    }

    if (tapFocus != null) {
      final boxW = imageSize.width * defaultFraction;
      final boxH = imageSize.height * defaultFraction;

      final left = (tapFocus.dx - boxW / 2).clamp(0.0, imageSize.width - boxW);
      final top = (tapFocus.dy - boxH / 2).clamp(0.0, imageSize.height - boxH);

      return ui.Rect.fromLTWH(left, top, boxW, boxH);
    }

    // Default: Center region
    final boxW = imageSize.width * defaultFraction;
    final boxH = imageSize.height * defaultFraction;
    final left = (imageSize.width - boxW) / 2.0;
    final top = (imageSize.height - boxH) / 2.0;

    return ui.Rect.fromLTWH(left, top, boxW, boxH);
  }

  /// Transforms an [ImagePixelBuffer] through the full enhancement pipeline:
  /// Crop ROI -> Bilinear Digital Zoom -> Contrast Boost -> Unsharp Masking.
  ImagePixelBuffer enhancePixelBuffer(
    ImagePixelBuffer source,
    ui.Rect roi,
    DistanceScanConfig config,
  ) {
    // Step 1: Crop candidate ROI
    final cropped = source.crop(roi, padding: config.cropPadding);

    // Step 2: Digital zoom upscaling via bilinear interpolation
    final zoomed = cropped.scaleBilinear(config.zoomFactor);

    // Step 3: Dynamic contrast boost
    final contrastBoosted = zoomed.applyContrast(
      contrast: config.contrastBoost,
    );

    // Step 4: High-pass unsharp masking
    final sharpened = contrastBoosted.applyUnsharpMask(
      amount: config.unsharpAmount,
    );

    return sharpened;
  }

  /// Converts standard raw RGBA bytes into an [ImagePixelBuffer].
  ImagePixelBuffer createPixelBuffer({
    required int width,
    required int height,
    required Uint8List rgbaBytes,
  }) {
    return ImagePixelBuffer(width: width, height: height, rgbaBytes: rgbaBytes);
  }

  /// Decodes an image file into an [ImagePixelBuffer] using Flutter's built-in codec.
  Future<ImagePixelBuffer?> decodeImageFileToBuffer(String imagePath) async {
    try {
      final file = File(imagePath);
      if (!await file.exists()) return null;
      final bytes = await file.readAsBytes();

      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;

      final byteData = await image.toByteData();
      if (byteData == null) return null;

      return ImagePixelBuffer(
        width: image.width,
        height: image.height,
        rgbaBytes: byteData.buffer.asUint8List(),
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error decoding image file to pixel buffer: $e');
      }
      return null;
    }
  }

  /// Writes an [ImagePixelBuffer] as an uncompressed BMP to a temporary file.
  Future<File> writeBufferToTempBmp(ImagePixelBuffer buffer) async {
    final tempDir = await getTemporaryDirectory();
    final fileName =
        'distance_scan_${DateTime.now().microsecondsSinceEpoch}.bmp';
    final tempFile = File('${tempDir.path}/$fileName');
    final bmpBytes = buffer.toBmpBytes();
    await tempFile.writeAsBytes(bmpBytes);
    return tempFile;
  }

  /// Executes distance-enhanced processing on an image file.
  ///
  /// Crops the specified or calculated ROI, enlarges it digitally,
  /// sharpens module edges with unsharp masking, and invokes [controller.analyzeImage].
  Future<DistanceEnhancedScanResult> processImageFile({
    required String imagePath,
    required MobileScannerController controller,
    DistanceScanConfig config = const DistanceScanConfig(),
    List<ui.Offset>? corners,
    ui.Offset? tapFocus,
  }) async {
    final stopwatch = Stopwatch()..start();

    try {
      final buffer = await decodeImageFileToBuffer(imagePath);
      if (buffer == null) {
        return DistanceEnhancedScanResult.failure(
          durationMs: stopwatch.elapsedMilliseconds,
        );
      }

      final imageSize = ui.Size(
        buffer.width.toDouble(),
        buffer.height.toDouble(),
      );
      final roi = calculateCandidateRoi(
        imageSize,
        corners: corners,
        tapFocus: tapFocus,
      );

      final enhanced = enhancePixelBuffer(buffer, roi, config);
      final tempBmpFile = await writeBufferToTempBmp(enhanced);

      try {
        final capture = await controller.analyzeImage(tempBmpFile.path);

        stopwatch.stop();

        if (capture != null && capture.barcodes.isNotEmpty) {
          final first = capture.barcodes.first;
          return DistanceEnhancedScanResult(
            success: true,
            rawValue: first.rawValue,
            format: first.type.name,
            roiBounds: roi,
            appliedZoom: config.zoomFactor,
            unsharpApplied: true,
            durationMs: stopwatch.elapsedMilliseconds,
            enhancedImagePath: tempBmpFile.path,
          );
        }

        return DistanceEnhancedScanResult.failure(
          durationMs: stopwatch.elapsedMilliseconds,
          roiBounds: roi,
          appliedZoom: config.zoomFactor,
        );
      } finally {
        // Clean up temporary BMP file
        try {
          if (await tempBmpFile.exists()) {
            await tempBmpFile.delete();
          }
        } catch (_) {}
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Error in distance scan pipeline: $e');
      stopwatch.stop();
      return DistanceEnhancedScanResult.failure(
        durationMs: stopwatch.elapsedMilliseconds,
      );
    }
  }

  /// Multi-scale distance scanning fallback for gallery photos and distant posters:
  ///
  /// 1. Standard scan on full unedited image.
  /// 2. If unreadable, crops center region with 2.5x digital zoom & unsharp mask.
  /// 3. If still unreadable, zooms to 3.5x with strong contrast boost & unsharp mask.
  /// 4. If still unreadable, inspects quadrants for off-center distant signs.
  Future<DistanceEnhancedScanResult> runMultiScaleDistanceScan({
    required String imagePath,
    required MobileScannerController controller,
    DistanceScanConfig baseConfig = const DistanceScanConfig(),
  }) async {
    final stopwatch = Stopwatch()..start();

    // Pass 1: Standard unenhanced scan
    try {
      final initialCapture = await controller.analyzeImage(imagePath);
      if (initialCapture != null && initialCapture.barcodes.isNotEmpty) {
        final bc = initialCapture.barcodes.first;
        stopwatch.stop();
        return DistanceEnhancedScanResult(
          success: true,
          rawValue: bc.rawValue,
          format: bc.type.name,
          durationMs: stopwatch.elapsedMilliseconds,
        );
      }
    } catch (_) {}

    // Pass 2: Center ROI with base digital zoom & unsharp mask
    final pass2 = await processImageFile(
      imagePath: imagePath,
      controller: controller,
      config: baseConfig,
    );
    if (pass2.success) return pass2;

    // Pass 3: Deeper digital zoom (3.5x) with high unsharp mask
    final pass3Config = baseConfig.copyWith(
      zoomFactor: 3.5,
      unsharpAmount: 2.0,
      contrastBoost: 1.45,
    );
    final pass3 = await processImageFile(
      imagePath: imagePath,
      controller: controller,
      config: pass3Config,
    );
    if (pass3.success) return pass3;

    // Pass 4: Multi-quadrant search for off-center distant codes
    final buffer = await decodeImageFileToBuffer(imagePath);
    if (buffer != null) {
      final w = buffer.width.toDouble();
      final h = buffer.height.toDouble();
      final quadrantW = w * 0.55;
      final quadrantH = h * 0.55;

      final quadrants = <ui.Rect>[
        ui.Rect.fromLTWH(0, 0, quadrantW, quadrantH), // Top-Left
        ui.Rect.fromLTWH(w - quadrantW, 0, quadrantW, quadrantH), // Top-Right
        ui.Rect.fromLTWH(0, h - quadrantH, quadrantW, quadrantH), // Bottom-Left
        ui.Rect.fromLTWH(
          w - quadrantW,
          h - quadrantH,
          quadrantW,
          quadrantH,
        ), // Bottom-Right
      ];

      for (final quadRoi in quadrants) {
        final enhanced = enhancePixelBuffer(buffer, quadRoi, baseConfig);
        final tempFile = await writeBufferToTempBmp(enhanced);
        try {
          final capture = await controller.analyzeImage(tempFile.path);
          if (capture != null && capture.barcodes.isNotEmpty) {
            final bc = capture.barcodes.first;
            stopwatch.stop();
            return DistanceEnhancedScanResult(
              success: true,
              rawValue: bc.rawValue,
              format: bc.type.name,
              roiBounds: quadRoi,
              appliedZoom: baseConfig.zoomFactor,
              unsharpApplied: true,
              durationMs: stopwatch.elapsedMilliseconds,
            );
          }
        } finally {
          try {
            if (await tempFile.exists()) await tempFile.delete();
          } catch (_) {}
        }
      }
    }

    stopwatch.stop();
    return DistanceEnhancedScanResult.failure(
      durationMs: stopwatch.elapsedMilliseconds,
    );
  }
}
