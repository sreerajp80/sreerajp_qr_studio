import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/decode_profile.dart';
import 'package:sreerajp_qr_studio/models/distance_enhanced_scan_result.dart';
import 'package:sreerajp_qr_studio/models/scanned_code.dart';
import 'package:sreerajp_qr_studio/services/barcode_decoder/barcode_decoder_service.dart';
import 'package:sreerajp_qr_studio/services/distance_enhancement_service.dart';
import 'package:sreerajp_qr_studio/services/media_scan_service.dart';

/// Records the config the image fallback is run with.
class _SpyDistanceService extends DistanceEnhancementService {
  DistanceScanConfig? baseConfig;

  _SpyDistanceService();

  @override
  Future<DistanceEnhancedScanResult> runMultiScaleDistanceScan({
    required String imagePath,
    DistanceScanConfig baseConfig = const DistanceScanConfig(),
  }) async {
    this.baseConfig = baseConfig;
    return DistanceEnhancedScanResult.failure();
  }
}

/// Test double for the native decoder.
class _FakeDecoder implements BarcodeDecoder {
  final List<ScannedCode> fileResult;
  final List<String> decodedPaths = [];

  _FakeDecoder(this.fileResult);

  @override
  Future<List<ScannedCode>> decodeImageFile(
    String path, {
    List<CodeFormat> formats = CodeFormat.allReadable,
    DecodeProfile profile = DecodeProfile.thorough,
    int maxSymbols = 8,
  }) async {
    decodedPaths.add(path);
    return fileResult;
  }

  @override
  Future<List<ScannedCode>> decodeEncodedImage(
    Uint8List encoded, {
    List<CodeFormat> formats = CodeFormat.allReadable,
    DecodeProfile profile = DecodeProfile.thorough,
    int maxSymbols = 8,
  }) async => const [];

  @override
  Future<List<ScannedCode>> decodePixels(DecodeRequest request) async =>
      const [];

  @override
  Future<List<ScannedCode>> decodeRgba(
    Uint8List rgba,
    int width,
    int height, {
    List<CodeFormat> formats = CodeFormat.allReadable,
    DecodeProfile profile = DecodeProfile.thorough,
    int maxSymbols = 8,
  }) async => const [];
}

void main() {
  group('MediaScanService size limits', () {
    late Directory tempDir;

    setUp(() => tempDir = Directory.systemTemp.createTempSync('media_limit'));
    tearDown(() => tempDir.deleteSync(recursive: true));

    File writeFile(String name, int bytes) =>
        File('${tempDir.path}/$name')..writeAsBytesSync(Uint8List(bytes));

    test('an image over the limit is not read', () async {
      final file = writeFile('big.jpg', 2 * 1024 * 1024);
      final decoder = _FakeDecoder(const []);
      final service = MediaScanService(
        decoder: decoder,
        maxImageBytes: 1024 * 1024,
      );

      final result = await service.scanImageFile(file.path);

      expect(decoder.decodedPaths, isEmpty);
      expect(result.errorMessage?.key, AppMessageKey.mediaImageTooLarge);
      expect(result.errorMessage?.args['maxMb'], '1');
    });

    test('an image at the limit is still read', () async {
      final file = writeFile('ok.jpg', 1024);
      final decoder = _FakeDecoder(const []);
      final service = MediaScanService(decoder: decoder, maxImageBytes: 1024);

      await service.scanImageFile(file.path, enableDistanceEnhancement: false);

      expect(decoder.decodedPaths, [file.path]);
    });

    test('a PDF over the limit is not opened', () async {
      final file = writeFile('big.pdf', 2 * 1024 * 1024);
      final service = MediaScanService(
        decoder: _FakeDecoder(const []),
        maxPdfBytes: 1024 * 1024,
      );

      final result = await service.scanPdfFile(file.path);

      expect(result.isPdf, isTrue);
      expect(result.errorMessage?.key, AppMessageKey.mediaPdfTooLarge);
      expect(result.errorMessage?.args['maxMb'], '1');
    });

    test('default limits are the app limits', () {
      final service = MediaScanService(decoder: _FakeDecoder(const []));
      expect(service.maxImageBytes, 50 * 1024 * 1024);
      expect(service.maxPdfBytes, 100 * 1024 * 1024);
    });
  });

  group('MediaScanService.pdfRenderSize', () {
    test('a normal A4 page is drawn at twice its size', () {
      expect(MediaScanService.pdfRenderSize(595, 842), (1190.0, 1684.0));
    });

    test('a huge page is capped at 4096 px on its longest side', () {
      final (w, h) = MediaScanService.pdfRenderSize(14400, 7200);
      expect(w, 4096);
      expect(h, 2048);
    });

    test('a tall page keeps its shape', () {
      final (w, h) = MediaScanService.pdfRenderSize(1000, 10000);
      expect(h, 4096);
      expect(w, closeTo(409.6, 0.001));
    });
  });

  group('MediaScanService with the own decoder', () {
    test('returns codes found in an image file', () async {
      const code = ScannedCode(
        rawValue: 'https://example.com',
        format: CodeFormat.qrCode,
        type: CodeContentType.url,
      );
      final decoder = _FakeDecoder(const [code]);
      final service = MediaScanService(decoder: decoder);

      final result = await service.scanImageFile('photo.jpg');

      expect(decoder.decodedPaths, ['photo.jpg']);
      expect(result.hasBarcodes, isTrue);
      expect(result.barcodes.single, code);
      expect(result.errorMessage, isNull);
    });

    test('reports a friendly message when no code is found', () async {
      final service = MediaScanService(decoder: _FakeDecoder(const []));

      final result = await service.scanImageFile(
        'missing.jpg',
        enableDistanceEnhancement: false,
      );

      expect(result.hasBarcodes, isFalse);
      expect(result.errorMessage?.key, AppMessageKey.mediaNoCodeInImage);
    });

    test('distance fallback uses the given zoom and sharpness', () async {
      final spy = _SpyDistanceService();
      final service = MediaScanService(
        decoder: _FakeDecoder(const []),
        distanceEnhancementService: spy,
      );

      await service.scanImageFile(
        'photo.jpg',
        distanceConfig: const DistanceScanConfig(
          zoomFactor: 3.0,
          unsharpAmount: 0.8,
        ),
      );

      expect(spy.baseConfig?.zoomFactor, 3.0);
      expect(spy.baseConfig?.unsharpAmount, 0.8);
    });

    test('distance fallback defaults when no config is given', () async {
      final spy = _SpyDistanceService();
      final service = MediaScanService(
        decoder: _FakeDecoder(const []),
        distanceEnhancementService: spy,
      );

      await service.scanImageFile('photo.jpg');

      expect(spy.baseConfig?.zoomFactor, 2.5);
      expect(spy.baseConfig?.unsharpAmount, 1.5);
    });

    test('distance fallback on an unreadable file never throws', () async {
      final service = MediaScanService(decoder: _FakeDecoder(const []));

      final result = await service.scanImageFile('does-not-exist.jpg');

      expect(result.hasBarcodes, isFalse);
      expect(result.errorMessage?.key, AppMessageKey.mediaNoCodeInImage);
    });
  });

  group('BarcodeDecoderService off-device', () {
    test('returns empty results instead of failing on the host', () async {
      final service = BarcodeDecoderService.instance;
      expect(service.isSupported, isFalse);
      expect(await service.decodeRgba(Uint8List(16), 2, 2), isEmpty);
      expect(await service.decodeImageFile('nothing.png'), isEmpty);
    });

    test('rejects a buffer that is too small', () async {
      expect(
        await BarcodeDecoderService.instance.decodeRgba(Uint8List(3), 10, 10),
        isEmpty,
      );
    });
  });
}
