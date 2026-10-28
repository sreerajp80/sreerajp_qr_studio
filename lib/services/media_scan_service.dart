import 'dart:io';
import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sreerajp_qr_studio/core/constants/app_constants.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:pdfx/pdfx.dart';

import 'package:sreerajp_qr_studio/services/barcode_decoder/barcode_decoder_service.dart';
import 'package:sreerajp_qr_studio/services/distance_enhancement_service.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/distance_enhanced_scan_result.dart';
import 'package:sreerajp_qr_studio/models/scanned_code.dart';

/// Represents a barcode found on a specific page of a PDF document.
class PdfPageBarcode {
  final int pageNumber;
  final String rawValue;
  final CodeContentType format;

  const PdfPageBarcode({
    required this.pageNumber,
    required this.rawValue,
    required this.format,
  });
}

/// Holds the result of an image or PDF media barcode scan.
class MediaScanResult {
  final List<ScannedCode> barcodes;
  final List<PdfPageBarcode> pdfBarcodes;
  final AppMessage? errorMessage;
  final bool isPdf;

  /// PDF pages that were not checked because of the page limit.
  final int pagesSkipped;

  const MediaScanResult({
    this.barcodes = const [],
    this.pdfBarcodes = const [],
    this.errorMessage,
    this.isPdf = false,
    this.pagesSkipped = 0,
  });

  bool get hasBarcodes => barcodes.isNotEmpty || pdfBarcodes.isNotEmpty;
}

/// Service handling image gallery selection, multi-page PDF rendering, and barcode extraction.
class MediaScanService {
  final ImagePicker _imagePicker;
  final DistanceEnhancementService _distanceEnhancementService;
  final BarcodeDecoder _decoder;
  final int maxImageBytes;
  final int maxPdfBytes;

  /// [maxImageBytes] and [maxPdfBytes] default to the app limits; tests pass
  /// small values.
  MediaScanService({
    ImagePicker? imagePicker,
    DistanceEnhancementService? distanceEnhancementService,
    BarcodeDecoder? decoder,
    this.maxImageBytes = AppConstants.maxImportImageBytes,
    this.maxPdfBytes = AppConstants.maxImportPdfBytes,
  }) : _imagePicker = imagePicker ?? ImagePicker(),
       _decoder = decoder ?? BarcodeDecoderService.instance,
       _distanceEnhancementService =
           distanceEnhancementService ??
           DistanceEnhancementService(decoder: decoder);

  /// Pick an image from gallery and analyze it for barcodes.
  Future<MediaScanResult> pickAndScanImage({
    bool enableDistanceEnhancement = true,
    DistanceScanConfig distanceConfig = const DistanceScanConfig(),
  }) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) {
        return const MediaScanResult();
      }
      return await scanImageFile(
        image.path,
        enableDistanceEnhancement: enableDistanceEnhancement,
        distanceConfig: distanceConfig,
      );
    } catch (e, st) {
      AppLogger.error('Error picking image', error: e, stackTrace: st);
      return MediaScanResult(
        errorMessage: AppMessage(
          AppMessageKey.mediaImagePickFailed,
          args: {'error': '$e'},
        ),
      );
    }
  }

  /// Scan a specific image file by path with automated distance enhancement fallback.
  ///
  /// [distanceConfig] is the base zoom and sharpening used by the fallback.
  Future<MediaScanResult> scanImageFile(
    String filePath, {
    bool enableDistanceEnhancement = true,
    DistanceScanConfig distanceConfig = const DistanceScanConfig(),
  }) async {
    try {
      // A file over the limit is never read, so it cannot use up memory.
      if (await _isLargerThan(filePath, maxImageBytes)) {
        return MediaScanResult(
          errorMessage: AppMessage(
            AppMessageKey.mediaImageTooLarge,
            args: {'maxMb': '${maxImageBytes ~/ (1024 * 1024)}'},
          ),
        );
      }

      final codes = await _decoder.decodeImageFile(filePath);
      if (codes.isNotEmpty) {
        return MediaScanResult(barcodes: codes);
      }

      // If initial scan finds no barcode and distance enhancement is enabled,
      // run the multi-scale distance enhancement pipeline (ROI crop, digital zoom, unsharp mask).
      if (enableDistanceEnhancement) {
        final distanceResult = await _distanceEnhancementService
            .runMultiScaleDistanceScan(
              imagePath: filePath,
              baseConfig: distanceConfig,
            );
        if (distanceResult.success && distanceResult.rawValue != null) {
          final syntheticBarcode = ScannedCode(
            rawValue: distanceResult.rawValue,
            type: CodeContentType.fromName(distanceResult.format),
          );
          return MediaScanResult(barcodes: [syntheticBarcode]);
        }
      }

      return const MediaScanResult(
        errorMessage: AppMessage(AppMessageKey.mediaNoCodeInImage),
      );
    } catch (e, st) {
      AppLogger.error('Error scanning image file', error: e, stackTrace: st);
      return MediaScanResult(
        errorMessage: AppMessage(
          AppMessageKey.mediaImageAnalyzeFailed,
          args: {'error': '$e'},
        ),
      );
    }
  }

  /// Pick a PDF document and analyze each page for embedded barcodes.
  Future<MediaScanResult> pickAndScanPdf({
    void Function(int current, int total)? onProgress,
  }) async {
    try {
      final picked = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      final path = picked?.path;
      if (path == null) {
        return const MediaScanResult(isPdf: true);
      }
      return await scanPdfFile(path, onProgress: onProgress);
    } catch (e, st) {
      AppLogger.error('Error picking PDF', error: e, stackTrace: st);
      return MediaScanResult(
        isPdf: true,
        errorMessage: AppMessage(
          AppMessageKey.mediaPdfPickFailed,
          args: {'error': '$e'},
        ),
      );
    }
  }

  /// Scan a PDF file by path page-by-page.
  Future<MediaScanResult> scanPdfFile(
    String pdfPath, {
    void Function(int current, int total)? onProgress,
  }) async {
    final pdfBarcodes = <PdfPageBarcode>[];

    try {
      if (await _isLargerThan(pdfPath, maxPdfBytes)) {
        return MediaScanResult(
          isPdf: true,
          errorMessage: AppMessage(
            AppMessageKey.mediaPdfTooLarge,
            args: {'maxMb': '${maxPdfBytes ~/ (1024 * 1024)}'},
          ),
        );
      }

      final document = await PdfDocument.openFile(pdfPath);
      final totalPages = document.pagesCount;
      final pagesToScan = math.min(totalPages, AppConstants.maxPdfPagesScanned);
      final pagesSkipped = totalPages - pagesToScan;

      for (int i = 1; i <= pagesToScan; i++) {
        onProgress?.call(i, pagesToScan);
        final page = await document.getPage(i);

        try {
          final (width, height) = pdfRenderSize(page.width, page.height);
          final pageImage = await page.render(
            width: width,
            height: height,
            format: PdfPageImageFormat.png,
            backgroundColor: '#FFFFFF',
          );
          if (pageImage != null) {
            // Pages are decoded in memory; nothing is written to disk.
            final codes = await _decoder.decodeEncodedImage(pageImage.bytes);
            for (final bc in codes) {
              if (bc.rawValue != null && bc.rawValue!.isNotEmpty) {
                pdfBarcodes.add(
                  PdfPageBarcode(
                    pageNumber: i,
                    rawValue: bc.rawValue!,
                    format: bc.type,
                  ),
                );
              }
            }
          }
        } catch (e, st) {
          AppLogger.error(
            'Error analyzing page $i image',
            error: e,
            stackTrace: st,
          );
        } finally {
          await page.close();
        }
      }
      await document.close();

      if (pdfBarcodes.isEmpty) {
        return MediaScanResult(
          isPdf: true,
          pagesSkipped: pagesSkipped,
          errorMessage: const AppMessage(AppMessageKey.mediaNoCodeInPdf),
        );
      }

      return MediaScanResult(
        isPdf: true,
        pdfBarcodes: pdfBarcodes,
        pagesSkipped: pagesSkipped,
      );
    } catch (e, st) {
      AppLogger.error('Error scanning PDF file', error: e, stackTrace: st);
      return MediaScanResult(
        isPdf: true,
        errorMessage: AppMessage(
          AppMessageKey.mediaPdfScanFailed,
          args: {'error': '$e'},
        ),
      );
    }
  }

  /// The size a PDF page is drawn at: twice its own size, but no side over
  /// [maxDimension] pixels, so a page that claims a huge size cannot use up
  /// memory.
  static (double, double) pdfRenderSize(
    double pageWidth,
    double pageHeight, {
    int maxDimension = AppConstants.maxPdfRenderDimension,
  }) {
    final width = pageWidth * 2;
    final height = pageHeight * 2;
    final longest = math.max(width, height);
    if (longest <= maxDimension || longest <= 0) return (width, height);
    final scale = maxDimension / longest;
    return (width * scale, height * scale);
  }

  /// True when the file exists and is larger than [maxBytes].
  static Future<bool> _isLargerThan(String path, int maxBytes) async {
    final file = File(path);
    if (!await file.exists()) return false;
    return await file.length() > maxBytes;
  }
}
