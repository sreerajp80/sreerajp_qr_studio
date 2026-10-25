import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
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

  Future<DecoderWorker?>? _worker;

  /// Whether the native decoder can run on this platform.
  bool get isSupported => Platform.isAndroid;

  Future<DecoderWorker?> _getWorker() {
    final existing = _worker;
    if (existing != null) return existing;
    late final Future<DecoderWorker?> started;
    started = DecoderWorker.spawn()
        .then<DecoderWorker?>((worker) {
          // A dead worker is dropped, so the next call starts a new one.
          worker.onDead = () {
            if (identical(_worker, started)) _worker = null;
          };
          return worker;
        })
        .catchError((Object e) {
          AppLogger.error('Barcode decoder worker failed to start', error: e);
          if (identical(_worker, started)) _worker = null;
          return null;
        });
    return _worker = started;
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
    } catch (e, st) {
      AppLogger.error('Barcode decode failed', error: e, stackTrace: st);
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
    } catch (e, st) {
      AppLogger.error('Could not read image file', error: e, stackTrace: st);
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
    } catch (e, st) {
      AppLogger.error('Could not decode image', error: e, stackTrace: st);
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
///
/// If the isolate exits, or keeps failing to answer, the worker marks itself
/// dead: every waiting decode gets an empty result and [onDead] runs, so the
/// service starts a fresh worker on the next call. A decode never waits
/// forever, so a caller's "busy" flag is always reset.
@visibleForTesting
class DecoderWorker {
  /// Longest a single decode may take before it gives an empty result.
  static const Duration defaultTimeout = Duration(seconds: 10);

  /// Timeouts in a row after which the worker is treated as stuck.
  static const int maxTimeoutsInARow = 3;

  final SendPort _commands;
  final Duration _timeout;
  final Isolate? _isolate;
  final Map<int, Completer<List<ScannedCode>>> _pending = {};
  int _nextId = 0;
  int _timeoutsInARow = 0;
  bool _dead = false;
  void Function()? _onClosed;

  /// Called once, when the worker becomes unusable.
  void Function()? onDead;

  static Future<DecoderWorker> spawn() async {
    final responses = ReceivePort('barcode-decoder-responses');
    final broadcast = responses.asBroadcastStream();
    final isolate = await Isolate.spawn(
      _workerMain,
      responses.sendPort,
      debugName: 'barcode-decoder',
      errorsAreFatal: false,
      onExit: responses.sendPort,
      onError: responses.sendPort,
    );
    final commands = await broadcast
        .firstWhere((message) => message is SendPort)
        .timeout(const Duration(seconds: 10));
    return DecoderWorker(
      commands as SendPort,
      broadcast,
      isolate: isolate,
      onClosed: responses.close,
    );
  }

  DecoderWorker(
    this._commands,
    Stream<dynamic> responses, {
    this._timeout = defaultTimeout,
    this._isolate,
    this._onClosed,
  }) {
    responses.listen((message) {
      if (message is (int, List<ScannedCode>)) {
        _timeoutsInARow = 0;
        _pending.remove(message.$1)?.complete(message.$2);
      } else if (message == null) {
        // The isolate's exit listener sends null.
        AppLogger.warning('Barcode decoder worker exited');
        markDead();
      } else if (message is List && message.length == 2) {
        // An uncaught error inside the worker; it keeps running.
        AppLogger.warning('Barcode decoder worker error: ${message.first}');
      }
    });
  }

  /// Whether the worker can no longer decode.
  bool get isDead => _dead;

  /// Number of decodes still waiting for an answer.
  @visibleForTesting
  int get pendingCount => _pending.length;

  Future<List<ScannedCode>> decode(DecodeRequest request) {
    if (_dead) return Future.value(const []);
    final id = _nextId++;
    final completer = Completer<List<ScannedCode>>();
    _pending[id] = completer;
    _commands.send((id, request));
    return completer.future.timeout(
      _timeout,
      onTimeout: () {
        _pending.remove(id);
        _timeoutsInARow++;
        AppLogger.warning('Barcode decode timed out');
        if (_timeoutsInARow >= maxTimeoutsInARow) markDead();
        return const [];
      },
    );
  }

  /// Gives every waiting decode an empty result and stops the worker.
  void markDead() {
    if (_dead) return;
    _dead = true;
    for (final completer in _pending.values) {
      if (!completer.isCompleted) completer.complete(const []);
    }
    _pending.clear();
    _isolate?.kill(priority: Isolate.immediate);
    _onClosed?.call();
    _onClosed = null;
    onDead?.call();
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
