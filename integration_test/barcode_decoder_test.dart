// On-device tests for the app's own native barcode decoder (zxing-cpp via FFI).
//
// Run on a connected Android device:
//   flutter test integration_test/barcode_decoder_test.dart --flavor dev
//
// Test images are drawn in memory from the `barcode` package, so no image
// files with unknown licences are needed.

import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:barcode/barcode.dart' as gen;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/decode_profile.dart';
import 'package:sreerajp_qr_studio/services/barcode_decoder/barcode_decoder_service.dart';
import 'package:sreerajp_qr_studio/services/barcode_decoder/barcode_ffi_bindings.dart';

/// A grey (1 byte per pixel) image.
class _Gray {
  final int width;
  final int height;
  final Uint8List pixels;

  _Gray(this.width, this.height, [int fill = 255])
    : pixels = Uint8List(width * height)..fillRange(0, width * height, fill);

  void fillRect(int left, int top, int w, int h, int value) {
    final x0 = left.clamp(0, width);
    final x1 = (left + w).clamp(0, width);
    final y0 = top.clamp(0, height);
    final y1 = (top + h).clamp(0, height);
    for (var y = y0; y < y1; y++) {
      pixels.fillRange(y * width + x0, y * width + x1, value);
    }
  }

  /// Draws [code] with its top-left at (x, y), [w]×[h] pixels in size.
  void draw(gen.Barcode code, String data, int x, int y, double w, double h) {
    for (final element in code.make(data, width: w, height: h)) {
      if (element is gen.BarcodeBar && element.black) {
        // Round the edges, not the width, so module sizes stay even.
        final left = (x + element.left).round();
        final top = (y + element.top).round();
        fillRect(
          left,
          top,
          (x + element.left + element.width).round() - left,
          (y + element.top + element.height).round() - top,
          0,
        );
      }
    }
  }

  _Gray inverted() {
    final out = _Gray(width, height);
    for (var i = 0; i < pixels.length; i++) {
      out.pixels[i] = 255 - pixels[i];
    }
    return out;
  }

  /// Rotated 90° counter-clockwise, so a clockwise turn makes it upright.
  _Gray rotatedCcw() {
    final out = _Gray(height, width);
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        out.pixels[(width - 1 - x) * height + y] = pixels[y * width + x];
      }
    }
    return out;
  }

  void addNoise(math.Random random, int amount) {
    for (var i = 0; i < pixels.length; i++) {
      final v = pixels[i] + random.nextInt(amount * 2 + 1) - amount;
      pixels[i] = v.clamp(0, 255);
    }
  }
}

Future<List<dynamic>> _decode(
  _Gray image, {
  List<CodeFormat> formats = CodeFormat.allReadable,
  DecodeProfile profile = DecodeProfile.thorough,
  int rotation = 0,
  bool tryInvert = false,
  int maxSymbols = 8,
}) {
  return BarcodeDecoderService.instance.decodePixels(
    DecodeRequest(
      pixels: image.pixels,
      width: image.width,
      height: image.height,
      imageFormat: SrbImageFormat.lum,
      rotationDegrees: rotation,
      formatMask: CodeFormat.maskOf(formats),
      profile: profile,
      tryInvert: tryInvert,
      maxSymbols: maxSymbols,
    ),
  );
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final decoder = BarcodeDecoderService.instance;

  group('Native decoder: every supported format', () {
    final cases =
        <(String, gen.Barcode, String, CodeFormat, double, double, String?)>[
          (
            'QR',
            gen.Barcode.qrCode(),
            'https://sreeraj.in/qr?x=1',
            CodeFormat.qrCode,
            400,
            400,
            null,
          ),
          (
            'Data Matrix',
            gen.Barcode.dataMatrix(),
            'DM-12345-ABC',
            CodeFormat.dataMatrix,
            300,
            300,
            null,
          ),
          (
            'Aztec',
            gen.Barcode.aztec(),
            'AZTEC TEST 42',
            CodeFormat.aztec,
            300,
            300,
            null,
          ),
          (
            'Code 128',
            gen.Barcode.code128(),
            'CODE128-Test-42',
            CodeFormat.code128,
            700,
            200,
            null,
          ),
          (
            'Code 39',
            gen.Barcode.code39(),
            'CODE39 TEST',
            CodeFormat.code39,
            800,
            200,
            null,
          ),
          (
            'Code 93',
            gen.Barcode.code93(),
            'CODE93TEST',
            CodeFormat.code93,
            700,
            200,
            null,
          ),
          (
            'Codabar',
            gen.Barcode.codabar(),
            '1234567890',
            CodeFormat.codabar,
            700,
            200,
            // Codabar keeps its start/stop characters (A…B), as zxing-cpp reports them.
            'A1234567890B',
          ),
          (
            'ITF',
            gen.Barcode.itf(),
            '12345678901231',
            CodeFormat.itf,
            700,
            200,
            null,
          ),
          (
            'EAN-13',
            gen.Barcode.ean13(),
            '400638133393',
            CodeFormat.ean13,
            600,
            200,
            '4006381333931',
          ),
          (
            'EAN-8',
            gen.Barcode.ean8(),
            '9638507',
            CodeFormat.ean8,
            500,
            200,
            '96385074',
          ),
          (
            'UPC-A',
            gen.Barcode.upcA(),
            '03600029145',
            CodeFormat.upcA,
            600,
            200,
            '036000291452',
          ),
          (
            'UPC-E',
            gen.Barcode.upcE(),
            '0123456',
            CodeFormat.upcE,
            500,
            200,
            '01234565',
          ),
        ];

    for (final (name, symbology, data, format, w, h, expected) in cases) {
      testWidgets('$name decodes with the right text and format', (_) async {
        final image = _Gray(w.toInt() + 160, h.toInt() + 160);
        image.draw(symbology, data, 80, 80, w, h);
        final codes = await _decode(image);
        expect(codes, isNotEmpty, reason: '$name was not found');
        expect(codes.first.format, format);
        expect(codes.first.rawValue, expected ?? data);
        expect(codes.first.corners, hasLength(4));
      });
    }
  });

  // The `barcode` package draws some PDF417 layouts that are not readable by
  // zxing-cpp, so PDF417 uses a reference PNG made by an independent encoder
  // (pdf417gen, MIT). This also covers the encoded-image (PNG) path.
  testWidgets('PDF417 reference PNG decodes', (_) async {
    final codes = await decoder.decodeEncodedImage(base64.decode(_pdf417Png));
    expect(codes, isNotEmpty);
    expect(codes.first.format, CodeFormat.pdf417);
    expect(codes.first.rawValue, 'PDF417 sample text 0123456789');
  });

  group('Native decoder: behaviour', () {
    testWidgets('content type is classified (Wi-Fi, ISBN)', (_) async {
      final wifi = _Gray(560, 560)
        ..draw(
          gen.Barcode.qrCode(),
          'WIFI:T:WPA;S:Home;P:pw123;;',
          80,
          80,
          400,
          400,
        );
      expect((await _decode(wifi)).first.type, CodeContentType.wifi);

      final isbn = _Gray(760, 360)
        ..draw(gen.Barcode.isbn(), '978030640615', 80, 80, 600, 200);
      final codes = await _decode(isbn);
      expect(codes.first.format, CodeFormat.ean13);
      expect(codes.first.type, CodeContentType.isbn);
    });

    testWidgets('multiple codes in one frame are all found', (_) async {
      final image = _Gray(1000, 520)
        ..draw(gen.Barcode.qrCode(), 'first', 60, 60, 400, 400)
        ..draw(gen.Barcode.qrCode(), 'second', 540, 60, 400, 400);
      final values = (await _decode(image)).map((c) => c.rawValue).toSet();
      expect(values, {'first', 'second'});
    });

    testWidgets('only requested formats are returned', (_) async {
      final image = _Gray(860, 360)
        ..draw(gen.Barcode.code128(), 'ONLY128', 80, 80, 700, 200);
      expect(await _decode(image, formats: const [CodeFormat.qrCode]), isEmpty);
      expect(
        await _decode(image, formats: const [CodeFormat.code128]),
        hasLength(1),
      );
    });

    testWidgets('rotation turns a sideways 1D barcode upright', (_) async {
      final upright = _Gray(860, 360)
        ..draw(gen.Barcode.code128(), 'ROTATE-ME', 80, 80, 700, 200);
      final sideways = upright.rotatedCcw();
      final codes = await _decode(
        sideways,
        formats: const [CodeFormat.code128],
        profile: DecodeProfile.fast,
        rotation: 90,
      );
      expect(codes.single.rawValue, 'ROTATE-ME');
      // Corners are reported in the upright (860 x 360) space.
      for (final corner in codes.single.corners) {
        expect(corner.dx, inInclusiveRange(0, 860));
        expect(corner.dy, inInclusiveRange(0, 360));
      }
    });

    testWidgets('inverted (light on dark) QR needs tryInvert', (_) async {
      final image = (_Gray(
        560,
        560,
      )..draw(gen.Barcode.qrCode(), 'inverted', 80, 80, 400, 400)).inverted();
      expect(await _decode(image, profile: DecodeProfile.fast), isEmpty);
      expect(
        (await _decode(
          image,
          profile: DecodeProfile.fast,
          tryInvert: true,
        )).single.rawValue,
        'inverted',
      );
    });

    testWidgets('noisy image still decodes', (_) async {
      final image = _Gray(560, 560)
        ..draw(gen.Barcode.qrCode(), 'noisy', 80, 80, 400, 400)
        ..addNoise(math.Random(7), 50);
      expect((await _decode(image)).single.rawValue, 'noisy');
    });

    testWidgets('UTF-8 text survives the round trip', (_) async {
      const text = 'മലയാളം संस्कृतम् ✓';
      final image = _Gray(560, 560)
        ..draw(gen.Barcode.qrCode(), text, 80, 80, 400, 400);
      expect((await _decode(image)).single.rawValue, text);
    });
  });

  group('Native decoder: hostile and broken input never crashes', () {
    testWidgets('random noise gives no codes', (_) async {
      final random = math.Random(1);
      final image = _Gray(640, 480);
      for (var i = 0; i < image.pixels.length; i++) {
        image.pixels[i] = random.nextInt(256);
      }
      expect(await _decode(image), isEmpty);
    });

    testWidgets('buffer shorter than the stated size is rejected', (_) async {
      final codes = await decoder.decodePixels(
        DecodeRequest(
          pixels: Uint8List(100),
          width: 640,
          height: 480,
          imageFormat: SrbImageFormat.lum,
          formatMask: CodeFormat.maskOf(CodeFormat.allReadable),
        ),
      );
      expect(codes, isEmpty);
    });

    testWidgets('bad arguments are rejected', (_) async {
      final pixels = Uint8List(64 * 64);
      for (final request in [
        DecodeRequest(
          pixels: pixels,
          width: 0,
          height: 64,
          imageFormat: 0,
          formatMask: 1,
        ),
        DecodeRequest(
          pixels: pixels,
          width: 64,
          height: -1,
          imageFormat: 0,
          formatMask: 1,
        ),
        DecodeRequest(
          pixels: pixels,
          width: 64,
          height: 64,
          imageFormat: 9,
          formatMask: 1,
        ),
        DecodeRequest(
          pixels: pixels,
          width: 64,
          height: 64,
          imageFormat: 0,
          formatMask: 1,
          rotationDegrees: 45,
        ),
        DecodeRequest(
          pixels: pixels,
          width: 64,
          height: 64,
          rowStride: 10,
          imageFormat: 0,
          formatMask: 1,
        ),
        DecodeRequest(
          pixels: pixels,
          width: 64,
          height: 64,
          imageFormat: 0,
          formatMask: 1 << 30,
        ),
        DecodeRequest(
          pixels: pixels,
          width: 64,
          height: 64,
          imageFormat: 0,
          formatMask: 1,
          maxSymbols: 9999,
        ),
      ]) {
        expect(await decoder.decodePixels(request), isEmpty);
      }
    });

    testWidgets('corrupt encoded image gives no codes', (_) async {
      final random = math.Random(3);
      final junk = Uint8List.fromList(
        List.generate(4096, (_) => random.nextInt(256)),
      );
      expect(await decoder.decodeEncodedImage(junk), isEmpty);
      expect(await decoder.decodeEncodedImage(Uint8List(0)), isEmpty);
    });
  });

  group('Native decoder: speed', () {
    Future<Map<String, double>> measure(
      _Gray frame,
      DecodeProfile profile,
      List<CodeFormat> formats, {
      int rotation = 0,
      int runs = 40,
    }) async {
      // Warm-up.
      await _decode(
        frame,
        profile: profile,
        formats: formats,
        rotation: rotation,
      );
      final times = <int>[];
      for (var i = 0; i < runs; i++) {
        final sw = Stopwatch()..start();
        await _decode(
          frame,
          profile: profile,
          formats: formats,
          rotation: rotation,
        );
        times.add(sw.elapsedMicroseconds);
      }
      times.sort();
      return {
        'median_ms': times[times.length ~/ 2] / 1000.0,
        'p90_ms': times[(times.length * 0.9).floor()] / 1000.0,
      };
    }

    testWidgets('decode time per camera-sized frame', (_) async {
      final random = math.Random(11);

      // 1280x720 sensor frame (landscape) holding a QR code, like the live
      // scanner sees it before rotation.
      final hd = _Gray(1280, 720, 180)
        ..draw(
          gen.Barcode.qrCode(),
          'https://example.com/speed',
          490,
          210,
          300,
          300,
        )
        ..addNoise(random, 20);
      final hdEmpty = _Gray(1280, 720, 180)..addNoise(random, 40);
      final fullHd = _Gray(1920, 1080, 180)
        ..draw(
          gen.Barcode.qrCode(),
          'airqr-frame-000123-payload',
          710,
          290,
          500,
          500,
        )
        ..addNoise(random, 20);
      final ean = _Gray(1280, 720, 200)
        ..draw(gen.Barcode.ean13(), '400638133393', 340, 260, 600, 200)
        ..addNoise(random, 15);

      final results = <String, Map<String, double>>{
        'live_720p_qr': await measure(
          hd,
          DecodeProfile.live,
          CodeFormat.standardScanFormats,
          rotation: 90,
        ),
        'live_720p_no_code': await measure(
          hdEmpty,
          DecodeProfile.live,
          CodeFormat.standardScanFormats,
          rotation: 90,
        ),
        'live_720p_ean13': await measure(
          ean,
          DecodeProfile.live,
          CodeFormat.standardScanFormats,
        ),
        'airqr_1080p_fast_qr': await measure(fullHd, DecodeProfile.fast, const [
          CodeFormat.qrCode,
        ], rotation: 90),
        'thorough_1080p_qr': await measure(
          fullHd,
          DecodeProfile.thorough,
          CodeFormat.allReadable,
          runs: 15,
        ),
      };
      binding.reportData = {'decoder_speed': results};
      // Printed so the numbers show up in the test log.
      // ignore: avoid_print
      print('DECODER_SPEED $results');

      // A live frame must decode well within one camera frame interval budget.
      expect(results['live_720p_qr']!['median_ms']!, lessThan(100));
      expect(results['airqr_1080p_fast_qr']!['median_ms']!, lessThan(100));
    });
  });
}

const _pdf417Png =
    'iVBORw0KGgoAAAANSUhEUgAAAikAAABVAQAAAACkl0kgAAABOklEQVR42u3YMW7CMBiG4c+xJbOU0KEDaiIicQky4Y2xZ4GyQmImpsA9egK2eiqXQCKNJdSphA4lEibdegEidej/TZ6e4R3+waxGA9MeGhkxxBBDzL9lSsb82NYsnBgBY3XM0kroOFqAecbqll1DoAo945IWFnCJEiULJxXzGfOVXW8pMTG3Mxay8hC1ZT2Bq1eYKZ4NouTVTRCcJDCU3sACOG0D4BAqfqTExNw28fsavDx6vavpFpr5H8XdU86v4VEGZVykZieG+6lyVxPNIdi3mMqHcqk6lJiYxhjHz3kqi86QvyMA9jPFk9au94Y5uN7A31y+6ksbRSb7Kbivarp+xDTGbHkyuqwrgaqbwa10Xy/z+01/PHYsYc6P9OiQVfZk4k+Wp3DP54gSE3PjGH0DEUMMMcT8OfMDdHpwgaVyx0oAAAAASUVORK5CYII=';
