import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/decode_profile.dart';
import 'package:sreerajp_qr_studio/models/scanned_code.dart';
import 'package:sreerajp_qr_studio/services/barcode_decoder/barcode_ffi_bindings.dart';
import 'package:sreerajp_qr_studio/services/barcode_decoder/native_barcode_reader.dart';

export 'package:sreerajp_qr_studio/services/barcode_decoder/native_barcode_reader.dart'
    show DecodeRequest;

/// Decodes barcodes and QR codes from pixels or image files, fully offline.
abstract interface class BarcodeDecoder {
  /// Decodes a raw pixel buffer.
  Future<List<ScannedCode>> decodePixels(DecodeRequest request);

  /// Decodes RGBA pixels (4 bytes per pixel, tightly packed).
  Future<List<ScannedCode>> decodeRgba(
    Uint8List rgba,
    int width,
    int height, {
    List<CodeFormat> formats,
    DecodeProfile profile,
    int maxSymbols,
  });

  /// Decodes an encoded image (JPEG, PNG, WebP, BMP, GIF…).
  Future<List<ScannedCode>> decodeEncodedImage(
    Uint8List encoded, {
    List<CodeFormat> formats,
    DecodeProfile profile,
    int maxSymbols,
  });

  /// Decodes an image file on disk.
  Future<List<ScannedCode>> decodeImageFile(
    String path, {
    List<CodeFormat> formats,
    DecodeProfile profile,
    int maxSymbols,
  });
}

/// The app's own barcode decoder: zxing-cpp (vendored in `native/`) called
/// through dart:ffi on a long-lived background isolate.
///
/// Never throws. Any failure gives an empty result.
class BarcodeDecoderService implements BarcodeDecoder {
  BarcodeDecoderService._();

  /// Shared instance: one worker isolate for the whole app.
  static final BarcodeDecoderService instance = BarcodeDecoderService._();

  /// Largest side an encoded image is decoded at. Bigger photos are scaled
  /// down first to keep memory use bounded.
  static const int maxImageDimension = 4096;

  Future<_DecoderWorker?>? _worker;

  /// Whether the native decoder can run on this platform.
  bool get isSupported => Platform.isAndroid;

  Future<_DecoderWorker?> _getWorker() {
    return _worker ??= _DecoderWorker.spawn()
        .then<_DecoderWorker?>((worker) => worker)
        .catchError((Object e) {
          if (kDebugMode) {
            debugPrint('Barcode decoder worker failed to start: $e');
          }
          _worker = null;
          return null;
        });
  }

  /// Starts the worker early so the first camera frame is not delayed.
  Future<void> warmUp() async {
    if (isSupported) await _getWorker();
  }

  @override
  Future<List<ScannedCode>> decodePixels(DecodeRequest request) async {
    if (!isSupported) return const [];
    try {
      final worker = await _getWorker();
      if (worker == null) return const [];
      return await worker.decode(request);
    } catch (e) {
      if (kDebugMode) debugPrint('Barcode decode failed: $e');
      return const [];
    }
  }

  @override
  Future<List<ScannedCode>> decodeRgba(
    Uint8List rgba,
    int width,
    int height, {
    List<CodeFormat> formats = CodeFormat.allReadable,
    DecodeProfile profile = DecodeProfile.thorough,
    int maxSymbols = 8,
  }) {
    if (width <= 0 || height <= 0 || rgba.length < width * height * 4) {
      return Future.value(const []);
    }
    return decodePixels(
      DecodeRequest(
        pixels: rgba,
        width: width,
        height: height,
        imageFormat: SrbImageFormat.rgba,
        formatMask: CodeFormat.maskOf(formats),
        profile: profile,
        maxSymbols: maxSymbols,
      ),
    );
  }

  @override
  Future<List<ScannedCode>> decodeEncodedImage(
    Uint8List encoded, {
    List<CodeFormat> formats = CodeFormat.allReadable,
    DecodeProfile profile = DecodeProfile.thorough,
    int maxSymbols = 8,
  }) async {
    if (!isSupported || encoded.isEmpty) return const [];
    final image = await decodeToRgba(encoded);
    if (image == null) return const [];
    return decodeRgba(
      image.rgba,
      image.width,
      image.height,
      formats: formats,
      profile: profile,
      maxSymbols: maxSymbols,
    );
  }

  @override
  Future<List<ScannedCode>> decodeImageFile(
    String path, {
    List<CodeFormat> formats = CodeFormat.allReadable,
    DecodeProfile profile = DecodeProfile.thorough,
    int maxSymbols = 8,
  }) async {
    try {
      final file = File(path);
      if (!await file.exists()) return const [];
      return await decodeEncodedImage(
        await file.readAsBytes(),
        formats: formats,
        profile: profile,
        maxSymbols: maxSymbols,
      );
    } catch (e) {
      if (kDebugMode) debugPrint('Could not read image file: $e');
      return const [];
    }
  }

  /// Decodes an encoded image to RGBA with Flutter's built-in codecs,
  /// scaling it down so no side exceeds [maxDimension].
  static Future<RgbaImage?> decodeToRgba(
    Uint8List encoded, {
    int maxDimension = maxImageDimension,
  }) async {
    ui.ImmutableBuffer? buffer;
    ui.ImageDescriptor? descriptor;
    ui.Codec? codec;
    ui.Image? image;
    try {
      buffer = await ui.ImmutableBuffer.fromUint8List(encoded);
      descriptor = await ui.ImageDescriptor.encoded(buffer);
      final w = descriptor.width;
      final h = descriptor.height;
      if (w <= 0 || h <= 0) return null;
      final scale = w > h ? maxDimension / w : maxDimension / h;
      codec = scale < 1.0
          ? await descriptor.instantiateCodec(
              targetWidth: (w * scale).round(),
              targetHeight: (h * scale).round(),
            )
          : await descriptor.instantiateCodec();
      final frame = await codec.getNextFrame();
      image = frame.image;
      final data = await image.toByteData();
      if (data == null) return null;
      return RgbaImage(
        rgba: data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        width: image.width,
        height: image.height,
      );
    } catch (e) {
      if (kDebugMode) debugPrint('Could not decode image: $e');
      return null;
    } finally {
      image?.dispose();
      codec?.dispose();
      descriptor?.dispose();
      buffer?.dispose();
    }
  }
}

/// Decoded RGBA pixels of an image.
@immutable
class RgbaImage {
  final Uint8List rgba;
  final int width;
  final int height;

  const RgbaImage({
    required this.rgba,
    required this.width,
    required this.height,
  });
}

/// Owns the background isolate that runs [NativeBarcodeReader].
class _DecoderWorker {
  final SendPort _commands;
  final Map<int, Completer<List<ScannedCode>>> _pending = {};
  int _nextId = 0;

  static Future<_DecoderWorker> spawn() async {
    final responses = ReceivePort('barcode-decoder-responses');
    final broadcast = responses.asBroadcastStream();
    await Isolate.spawn(
      _workerMain,
      responses.sendPort,
      debugName: 'barcode-decoder',
      errorsAreFatal: false,
    );
    final commands = await broadcast
        .firstWhere((message) => message is SendPort)
        .timeout(const Duration(seconds: 10));
    return _DecoderWorker._(commands as SendPort, broadcast);
  }

  _DecoderWorker._(this._commands, Stream<dynamic> responses) {
    responses.listen((message) {
      if (message is (int, List<ScannedCode>)) {
        _pending.remove(message.$1)?.complete(message.$2);
      }
    });
  }

  Future<List<ScannedCode>> decode(DecodeRequest request) {
    final id = _nextId++;
    final completer = Completer<List<ScannedCode>>();
    _pending[id] = completer;
    _commands.send((id, request));
    return completer.future;
  }
}

void _workerMain(SendPort responses) {
  final commands = ReceivePort('barcode-decoder-commands');
  responses.send(commands.sendPort);

  NativeBarcodeReader? reader;
  try {
    reader = NativeBarcodeReader(BarcodeFfiBindings.open());
  } catch (_) {
    reader = null;
  }

  commands.listen((message) {
    if (message is! (int, DecodeRequest)) return;
    var codes = const <ScannedCode>[];
    try {
      codes = reader?.read(message.$2) ?? const [];
    } catch (_) {
      codes = const [];
    }
    responses.send((message.$1, codes));
  });
}
