import 'dart:convert';
import 'dart:math';

import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/models/air_qr_frame.dart';
import 'package:sreerajp_qr_studio/models/air_qr_progress.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';

/// High-performance offline Optical Fountain & Systematic Stream Decoder & Encoder Engine.
class AirQrService {
  /// Bytes per frame. Keeps each data frame near QR version 10 (level L), so
  /// frames stay readable at the transmitter's QR size.
  static const int defaultBlockSize = 150;

  /// Robust Soliton tuning constants (standard LT code values).
  static const double _solitonC = 0.1;
  static const double _solitonDelta = 0.5;

  String? _activeStreamId;
  int _totalBlocks = 0;
  final Map<int, List<int>> _resolvedBlocks = {};
  final List<AirQrFrame> _pendingParityFrames = [];

  DateTime? _lastFrameTime;
  int _frameCountInWindow = 0;
  double _currentFps = 0.0;

  /// Resets the current receiver session.
  void reset() {
    _activeStreamId = null;
    _totalBlocks = 0;
    _resolvedBlocks.clear();
    _pendingParityFrames.clear();
    _lastFrameTime = null;
    _frameCountInWindow = 0;
    _currentFps = 0.0;
  }

  /// Processes an incoming QR raw payload string and updates stream progress state.
  AirQrProgress processFrameString(String raw, AirQrProgress currentProgress) {
    final frame = AirQrFrame.parse(raw);
    if (frame == null) {
      return currentProgress;
    }

    _updateFps();

    // Check if new stream ID detected
    if (_activeStreamId == null || _activeStreamId != frame.streamId) {
      reset();
      _activeStreamId = frame.streamId;
      _totalBlocks = frame.totalBlocks;
    } else if (frame.totalBlocks != _totalBlocks) {
      // Same stream ID but a different size: treat as corrupt and ignore.
      return currentProgress;
    }

    // Insert systematic frame directly
    if (!frame.isParity) {
      final index = frame.sequenceIndex;
      if (!_resolvedBlocks.containsKey(index)) {
        if (_validateChecksum(frame.payloadBytes, frame.checksum)) {
          _resolvedBlocks[index] = frame.payloadBytes;
          _reducePendingParityFrames();
        }
      }
    } else {
      // Process Parity Frame (LT Fountain code frame), dropping misreads
      if (_validateChecksum(frame.payloadBytes, frame.checksum)) {
        _addParityFrame(frame);
      }
    }

    final capturedIndices = Set<int>.from(_resolvedBlocks.keys);
    final isComplete =
        _resolvedBlocks.length >= _totalBlocks && _totalBlocks > 0;

    if (isComplete) {
      final reassembled = _reassemblePayload();
      if (reassembled != null) {
        return AirQrProgress(
          streamId: _activeStreamId,
          totalBlocks: _totalBlocks,
          receivedBlockCount: _resolvedBlocks.length,
          capturedIndices: capturedIndices,
          fps: _currentFps,
          status: AirQrStatus.completed,
          reassembledContent: reassembled,
        );
      } else {
        return AirQrProgress(
          streamId: _activeStreamId,
          totalBlocks: _totalBlocks,
          receivedBlockCount: _resolvedBlocks.length,
          capturedIndices: capturedIndices,
          fps: _currentFps,
          status: AirQrStatus.error,
          errorMessage: const AppMessage(AppMessageKey.airQrChecksumFailed),
        );
      }
    }

    return AirQrProgress(
      streamId: _activeStreamId,
      totalBlocks: _totalBlocks,
      receivedBlockCount: _resolvedBlocks.length,
      capturedIndices: capturedIndices,
      fps: _currentFps,
      status: AirQrStatus.receiving,
    );
  }

  void _addParityFrame(AirQrFrame frame) {
    // Simplify frame using currently resolved blocks
    final List<int> unresolvedIndices = [];
    List<int> payload = List.from(frame.payloadBytes);

    for (final idx in frame.indices) {
      if (_resolvedBlocks.containsKey(idx)) {
        payload = _xorBytes(payload, _resolvedBlocks[idx]!);
      } else {
        unresolvedIndices.add(idx);
      }
    }

    if (unresolvedIndices.length == 1) {
      final singleIdx = unresolvedIndices.first;
      if (!_resolvedBlocks.containsKey(singleIdx)) {
        _resolvedBlocks[singleIdx] = payload;
        _reducePendingParityFrames();
      }
    } else if (unresolvedIndices.length > 1) {
      _pendingParityFrames.add(
        AirQrFrame(
          streamId: frame.streamId,
          totalBlocks: frame.totalBlocks,
          sequenceIndex: -1,
          isParity: true,
          degree: unresolvedIndices.length,
          indices: unresolvedIndices,
          checksum: frame.checksum,
          payloadBytes: payload,
        ),
      );
    }
  }

  void _reducePendingParityFrames() {
    bool progress = true;
    while (progress) {
      progress = false;
      final remaining = <AirQrFrame>[];

      for (final frame in _pendingParityFrames) {
        final List<int> unresolvedIndices = [];
        List<int> payload = List.from(frame.payloadBytes);

        for (final idx in frame.indices) {
          if (_resolvedBlocks.containsKey(idx)) {
            payload = _xorBytes(payload, _resolvedBlocks[idx]!);
          } else {
            unresolvedIndices.add(idx);
          }
        }

        if (unresolvedIndices.length == 1) {
          final singleIdx = unresolvedIndices.first;
          if (!_resolvedBlocks.containsKey(singleIdx)) {
            _resolvedBlocks[singleIdx] = payload;
            progress = true;
          }
        } else if (unresolvedIndices.length > 1) {
          remaining.add(
            AirQrFrame(
              streamId: frame.streamId,
              totalBlocks: frame.totalBlocks,
              sequenceIndex: -1,
              isParity: true,
              degree: unresolvedIndices.length,
              indices: unresolvedIndices,
              checksum: frame.checksum,
              payloadBytes: payload,
            ),
          );
        }
      }
      _pendingParityFrames.clear();
      _pendingParityFrames.addAll(remaining);
    }
  }

  List<int> _xorBytes(List<int> a, List<int> b) {
    final len = min(a.length, b.length);
    final result = List<int>.filled(len, 0);
    for (int i = 0; i < len; i++) {
      result[i] = a[i] ^ b[i];
    }
    return result;
  }

  void _updateFps() {
    final now = DateTime.now();
    if (_lastFrameTime == null) {
      _lastFrameTime = now;
      _frameCountInWindow = 1;
      return;
    }

    _frameCountInWindow++;
    final diffMs = now.difference(_lastFrameTime!).inMilliseconds;
    if (diffMs >= 1000) {
      _currentFps = (_frameCountInWindow * 1000.0) / diffMs;
      _frameCountInWindow = 0;
      _lastFrameTime = now;
    }
  }

  String? _reassemblePayload() {
    try {
      final List<int> fullBytes = [];
      for (int i = 0; i < _totalBlocks; i++) {
        final block = _resolvedBlocks[i];
        if (block == null) return null;
        fullBytes.addAll(block);
      }

      // Trim padding null bytes if any
      while (fullBytes.isNotEmpty && fullBytes.last == 0) {
        fullBytes.removeLast();
      }

      final String result = utf8.decode(fullBytes, allowMalformed: true);
      return result;
    } catch (e, st) {
      AppLogger.error('Payload reassembly error', error: e, stackTrace: st);
      return null;
    }
  }

  /// Computes a standard CRC32 checksum over the payload bytes.
  static int computeCrc32(List<int> bytes) {
    int crc = 0xFFFFFFFF;
    for (final b in bytes) {
      crc ^= b;
      for (int i = 0; i < 8; i++) {
        if ((crc & 1) != 0) {
          crc = (crc >> 1) ^ 0xEDB88320;
        } else {
          crc >>= 1;
        }
      }
    }
    return (crc ^ 0xFFFFFFFF) & 0xFFFFFFFF;
  }

  bool _validateChecksum(List<int> bytes, int expectedChecksum) {
    return computeCrc32(bytes) == expectedChecksum;
  }

  /// Generates a complete sequence of AirQR optical frames (Systematic + LT Fountain parity frames)
  /// for a given raw payload string to broadcast via animated QR codes.
  static List<AirQrFrame> encodePayload(
    String payload, {
    int blockSize = defaultBlockSize,
    int extraParityRatioPercent = 50,
    int? paritySeed,
  }) {
    final bytes = utf8.encode(payload);
    final totalBlocks = (bytes.length / blockSize).ceil();
    final streamId = (Random.secure().nextInt(899999) + 100000).toString();

    final List<List<int>> sourceBlocks = [];
    for (int i = 0; i < totalBlocks; i++) {
      final start = i * blockSize;
      final end = min(start + blockSize, bytes.length);
      final chunk = bytes.sublist(start, end);
      // Pad chunk to fixed block size if needed
      if (chunk.length < blockSize) {
        final padded = List<int>.filled(blockSize, 0);
        padded.setRange(0, chunk.length, chunk);
        sourceBlocks.add(padded);
      } else {
        sourceBlocks.add(chunk);
      }
    }

    final List<AirQrFrame> frames = [];

    // 1. Systematic Frames (v1)
    for (int i = 0; i < totalBlocks; i++) {
      final block = sourceBlocks[i];
      final checksum = computeCrc32(block);
      frames.add(
        AirQrFrame(
          streamId: streamId,
          totalBlocks: totalBlocks,
          sequenceIndex: i,
          isParity: false,
          degree: 1,
          indices: [i],
          checksum: checksum,
          payloadBytes: block,
        ),
      );
    }

    // 2. LT Fountain Parity Frames (LT1)
    final parityCount = ((totalBlocks * extraParityRatioPercent) / 100).ceil();
    frames.addAll(
      generateParityFrames(frames, count: parityCount, seed: paritySeed),
    );

    return frames;
  }

  /// Generates [count] new LT fountain parity frames from the systematic
  /// frames of one stream. Without a [seed], every call gives different frames,
  /// so a looping transmitter can send fresh repair data on each pass.
  static List<AirQrFrame> generateParityFrames(
    List<AirQrFrame> systematicFrames, {
    required int count,
    int? seed,
  }) {
    final dataFrames = systematicFrames.where((f) => !f.isParity).toList()
      ..sort((a, b) => a.sequenceIndex.compareTo(b.sequenceIndex));
    if (dataFrames.isEmpty || count <= 0) return [];

    final streamId = dataFrames.first.streamId;
    final totalBlocks = dataFrames.first.totalBlocks;
    // Needs the full, in-order set of source blocks for one stream.
    if (dataFrames.length != totalBlocks) return [];
    final sourceBlocks = dataFrames.map((f) => f.payloadBytes).toList();
    final blockSize = sourceBlocks.first.length;
    final rand = seed == null ? Random() : Random(seed);
    final cdf = _robustSolitonCdf(totalBlocks);

    final List<AirQrFrame> parityFrames = [];
    for (int p = 0; p < count; p++) {
      final degree = _sampleDegree(cdf, rand);
      final indicesSet = <int>{};
      while (indicesSet.length < degree) {
        indicesSet.add(rand.nextInt(totalBlocks));
      }
      final indicesList = indicesSet.toList()..sort();

      final List<int> combinedPayload = List.filled(blockSize, 0);
      for (final idx in indicesList) {
        final block = sourceBlocks[idx];
        for (int b = 0; b < blockSize; b++) {
          combinedPayload[b] ^= block[b];
        }
      }

      parityFrames.add(
        AirQrFrame(
          streamId: streamId,
          totalBlocks: totalBlocks,
          sequenceIndex: -1,
          isParity: true,
          degree: indicesList.length,
          indices: indicesList,
          checksum: computeCrc32(combinedPayload),
          payloadBytes: combinedPayload,
        ),
      );
    }
    return parityFrames;
  }

  /// Builds the cumulative Robust Soliton distribution for [k] source blocks.
  /// Entry `d - 1` is the chance that a frame's degree is `d` or less.
  static List<double> _robustSolitonCdf(int k) {
    if (k <= 1) return [1.0];

    final r = _solitonC * log(k / _solitonDelta) * sqrt(k);
    final pivot = (k / r).round().clamp(1, k);
    final weights = List<double>.filled(k, 0);

    for (int d = 1; d <= k; d++) {
      // Ideal Soliton part
      final rho = d == 1 ? 1 / k : 1 / (d * (d - 1));
      // Robust extra part
      double tau = 0;
      if (d < pivot) {
        tau = r / (d * k);
      } else if (d == pivot) {
        tau = max(0.0, r * log(r / _solitonDelta) / k);
      }
      weights[d - 1] = rho + tau;
    }

    final total = weights.reduce((a, b) => a + b);
    final cdf = List<double>.filled(k, 0);
    double running = 0;
    for (int i = 0; i < k; i++) {
      running += weights[i] / total;
      cdf[i] = running;
    }
    cdf[k - 1] = 1.0;
    return cdf;
  }

  static int _sampleDegree(List<double> cdf, Random rand) {
    final x = rand.nextDouble();
    for (int i = 0; i < cdf.length; i++) {
      if (x < cdf[i]) return i + 1;
    }
    return cdf.length;
  }
}
