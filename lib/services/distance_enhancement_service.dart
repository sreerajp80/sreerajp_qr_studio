import 'dart:io';
import 'dart:isolate';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/distance_enhanced_scan_result.dart';
import 'package:sreerajp_qr_studio/models/scanned_code.dart';
import 'package:sreerajp_qr_studio/services/barcode_decoder/barcode_decoder_service.dart';

/// Pure-Dart offline service executing the distance-enhanced scanning pipeline.
///
/// Detects distant QR codes/barcodes, crops the region of interest (ROI),
/// applies bilinear digital zoom upscaling, dynamic contrast boost, and
/// unsharp masking before passing to the barcode engine.
class DistanceEnhancementService {
  final BarcodeDecoder? _decoderOverride;

  const DistanceEnhancementService({BarcodeDecoder? decoder})
    : _decoderOverride = decoder;

  BarcodeDecoder get _decoder =>
      _decoderOverride ?? BarcodeDecoderService.instance;

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
      final image = await BarcodeDecoderService.decodeToRgba(
        await file.readAsBytes(),
      );
      if (image == null) return null;

      return ImagePixelBuffer(
        width: image.width,
        height: image.height,
        rgbaBytes: image.rgba,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error decoding image file to pixel buffer: $e');
      }
      return null;
    }
  }

  /// Runs the decoder on an in-memory pixel buffer. Nothing touches disk.
  Future<ScannedCode?> _decodeBuffer(ImagePixelBuffer buffer) async {
    final codes = await _decoder.decodeRgba(
      buffer.rgbaBytes,
      buffer.width,
      buffer.height,
    );
    for (final code in codes) {
      if (code.rawValue != null && code.rawValue!.isNotEmpty) return code;
    }
    return null;
  }

  /// Crops a region of [buffer], enlarges it, boosts contrast and sharpens
  /// module edges, then decodes the result.
  Future<DistanceEnhancedScanResult> processBuffer({
    required ImagePixelBuffer buffer,
    required Stopwatch stopwatch,
    DistanceScanConfig config = const DistanceScanConfig(),
    ui.Rect? roi,
    List<ui.Offset>? corners,
    ui.Offset? tapFocus,
  }) async {
    final region =
        roi ??
        calculateCandidateRoi(
          ui.Size(buffer.width.toDouble(), buffer.height.toDouble()),
          corners: corners,
          tapFocus: tapFocus,
        );
    final enhanced = enhancePixelBuffer(buffer, region, config);
    final code = await _decodeBuffer(enhanced);
    if (code != null) {
      return DistanceEnhancedScanResult(
        success: true,
        rawValue: code.rawValue,
        format: code.type.name,
        roiBounds: region,
        appliedZoom: config.zoomFactor,
        unsharpApplied: true,
        durationMs: stopwatch.elapsedMilliseconds,
      );
    }
    return DistanceEnhancedScanResult.failure(
      durationMs: stopwatch.elapsedMilliseconds,
      roiBounds: region,
      appliedZoom: config.zoomFactor,
    );
  }

  /// Executes distance-enhanced processing on an image file.
  ///
  /// Crops the specified or calculated ROI, enlarges it digitally,
  /// sharpens module edges with unsharp masking, and decodes it.
  Future<DistanceEnhancedScanResult> processImageFile({
    required String imagePath,
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
      return await processBuffer(
        buffer: buffer,
        stopwatch: stopwatch,
        config: config,
        corners: corners,
        tapFocus: tapFocus,
      );
    } catch (e) {
      if (kDebugMode) debugPrint('Error in distance scan pipeline: $e');
      return DistanceEnhancedScanResult.failure(
        durationMs: stopwatch.elapsedMilliseconds,
      );
    }
  }

  /// Multi-scale distance scanning fallback for gallery photos and distant posters:
  ///
  /// 1. Standard scan on full unedited image.
  /// 2. If unreadable, crops center region with the base zoom & unsharp mask.
  /// 3. If still unreadable, zooms one step deeper with stronger contrast
  ///    boost & unsharp mask ([DistanceScanConfig.stronger]).
  /// 4. If still unreadable, inspects quadrants for off-center distant signs.
  ///
  /// The image is read from disk once; every pass works in memory.
  Future<DistanceEnhancedScanResult> runMultiScaleDistanceScan({
    required String imagePath,
    DistanceScanConfig baseConfig = const DistanceScanConfig(),
  }) async {
    final stopwatch = Stopwatch()..start();
    try {
      final buffer = await decodeImageFileToBuffer(imagePath);
      if (buffer == null) {
        return DistanceEnhancedScanResult.failure(
          durationMs: stopwatch.elapsedMilliseconds,
        );
      }

      // Pass 1: Standard unenhanced scan
      final direct = await _decodeBuffer(buffer);
      if (direct != null) {
        return DistanceEnhancedScanResult(
          success: true,
          rawValue: direct.rawValue,
          format: direct.type.name,
          durationMs: stopwatch.elapsedMilliseconds,
        );
      }

      // Pass 2: Center ROI with base digital zoom & unsharp mask
      final pass2 = await processBuffer(
        buffer: buffer,
        stopwatch: stopwatch,
        config: baseConfig,
      );
      if (pass2.success) return pass2;

      // Pass 3: One step deeper zoom and stronger unsharp mask than the base
      final pass3 = await processBuffer(
        buffer: buffer,
        stopwatch: stopwatch,
        config: baseConfig.stronger(),
      );
      if (pass3.success) return pass3;

      // Pass 4: Multi-quadrant search for off-center distant codes
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
        final result = await processBuffer(
          buffer: buffer,
          stopwatch: stopwatch,
          config: baseConfig,
          roi: quadRoi,
        );
        if (result.success) return result;
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Error in distance scan pipeline: $e');
    }

    return DistanceEnhancedScanResult.failure(
      durationMs: stopwatch.elapsedMilliseconds,
    );
  }

  /// Longest side a live camera crop is enlarged to. Keeps memory use and
  /// time bounded on slow phones. A crop already this big is not enlarged.
  static const int liveAssistMaxSide = 2048;

  /// Distance assist for one live camera frame (the grey luminance plane).
  ///
  /// Crops the centre of the frame, then enlarges, boosts contrast and
  /// sharpens it on a background isolate, and decodes the result. Returned
  /// codes have corners in the upright frame space, the same as normal frame
  /// results. The crop is copied before the first await, so the caller may
  /// reuse [luminance] once this returns a future. Never throws.
  Future<List<ScannedCode>> processLuminanceFrame({
    required Uint8List luminance,
    required int width,
    required int height,
    int rowStride = 0,
    int rotationDegrees = 0,
    DistanceScanConfig config = const DistanceScanConfig(),
    List<CodeFormat> formats = CodeFormat.allReadable,
  }) async {
    try {
      if (width <= 0 || height <= 0) return const [];
      final stride = rowStride > 0 ? rowStride : width;
      if (luminance.length < stride * (height - 1) + width) return const [];

      final roi = calculateCandidateRoi(
        ui.Size(width.toDouble(), height.toDouble()),
      );
      final left = roi.left.floor().clamp(0, width - 1);
      final top = roi.top.floor().clamp(0, height - 1);
      final cropW = roi.width.round().clamp(1, width - left);
      final cropH = roi.height.round().clamp(1, height - top);

      final crop = Uint8List(cropW * cropH);
      for (int y = 0; y < cropH; y++) {
        final src = (top + y) * stride + left;
        crop.setRange(y * cropW, (y + 1) * cropW, luminance, src);
      }

      final enhanced = await _enhanceOffThread(
        _LumaCropJob(
          luma: crop,
          width: cropW,
          height: cropH,
          zoomFactor: config.zoomFactor,
          contrastBoost: config.contrastBoost,
          unsharpAmount: config.unsharpAmount,
        ),
      );

      final codes = await _decoder.decodeRgba(
        enhanced.rgbaBytes,
        enhanced.width,
        enhanced.height,
        formats: formats,
      );
      if (codes.isEmpty) return const [];

      final cropRect = ui.Rect.fromLTWH(
        left.toDouble(),
        top.toDouble(),
        cropW.toDouble(),
        cropH.toDouble(),
      );
      final scaleX = enhanced.width / cropW;
      final scaleY = enhanced.height / cropH;
      return [
        for (final code in codes)
          code.copyWith(
            corners: [
              for (final p in code.corners)
                mapCropPointToUprightFrame(
                  p,
                  crop: cropRect,
                  scaleX: scaleX,
                  scaleY: scaleY,
                  frameWidth: width,
                  frameHeight: height,
                  rotationDegrees: rotationDegrees,
                ),
            ],
          ),
      ];
    } catch (e) {
      if (kDebugMode) debugPrint('Error in live distance assist: $e');
      return const [];
    }
  }

  /// Maps a point in an enlarged crop back to the upright camera frame.
  ///
  /// [crop] is the crop area in the sensor frame ([frameWidth] x
  /// [frameHeight], before rotation). [scaleX] and [scaleY] are how much the
  /// crop was enlarged. [rotationDegrees] is the clockwise rotation that makes
  /// the frame upright, as given to the decoder for normal frames.
  static ui.Offset mapCropPointToUprightFrame(
    ui.Offset point, {
    required ui.Rect crop,
    required double scaleX,
    required double scaleY,
    required int frameWidth,
    required int frameHeight,
    int rotationDegrees = 0,
  }) {
    final x = crop.left + point.dx / scaleX;
    final y = crop.top + point.dy / scaleY;
    switch (rotationDegrees % 360) {
      case 90:
        return ui.Offset(frameHeight - y, x);
      case 180:
        return ui.Offset(frameWidth - x, frameHeight - y);
      case 270:
        return ui.Offset(y, frameWidth - x);
      default:
        return ui.Offset(x, y);
    }
  }

  /// Static, so the isolate closure does not capture this service.
  static Future<ImagePixelBuffer> _enhanceOffThread(_LumaCropJob job) {
    return Isolate.run(() => _enhanceLumaCrop(job));
  }
}

/// Plain data for one live assist pass, sent to a background isolate.
class _LumaCropJob {
  final Uint8List luma;
  final int width;
  final int height;
  final double zoomFactor;
  final double contrastBoost;
  final double unsharpAmount;

  const _LumaCropJob({
    required this.luma,
    required this.width,
    required this.height,
    required this.zoomFactor,
    required this.contrastBoost,
    required this.unsharpAmount,
  });
}

/// Grey crop -> RGBA -> zoom (capped at [DistanceEnhancementService.liveAssistMaxSide])
/// -> contrast boost -> unsharp mask.
ImagePixelBuffer _enhanceLumaCrop(_LumaCropJob job) {
  final rgba = Uint8List(job.width * job.height * 4);
  for (int i = 0, j = 0; i < job.luma.length; i++, j += 4) {
    final v = job.luma[i];
    rgba[j] = v;
    rgba[j + 1] = v;
    rgba[j + 2] = v;
    rgba[j + 3] = 255;
  }
  final source = ImagePixelBuffer(
    width: job.width,
    height: job.height,
    rgbaBytes: rgba,
  );
  final maxZoom =
      DistanceEnhancementService.liveAssistMaxSide /
      math.max(job.width, job.height);
  final zoom = math.min(job.zoomFactor, maxZoom);
  return source
      .scaleBilinear(zoom)
      .applyContrast(contrast: job.contrastBoost)
      .applyUnsharpMask(amount: job.unsharpAmount);
}
