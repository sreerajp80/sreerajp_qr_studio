import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/air_qr_frame.dart';
import 'package:sreerajp_qr_studio/models/air_qr_progress.dart';
import 'package:sreerajp_qr_studio/services/air_qr_service.dart';

void main() {
  group('AirQrFrame tests', () {
    test('parses v1 systematic frame string correctly', () {
      const raw = 'AIRQR|v1|stream123|5|2|123456|SGVsbG8=';
      final frame = AirQrFrame.parse(raw);

      expect(frame, isNotNull);
      expect(frame!.streamId, equals('stream123'));
      expect(frame.totalBlocks, equals(5));
      expect(frame.sequenceIndex, equals(2));
      expect(frame.isParity, isFalse);
      expect(frame.checksum, equals(123456));
      expect(frame.payloadBytes, equals([72, 101, 108, 108, 111]));
    });

    test('parses LT1 fountain parity frame string correctly', () {
      const raw = 'AIRQR|LT1|stream123|5|3:0,2,4|654321|SGVsbG8=';
      final frame = AirQrFrame.parse(raw);

      expect(frame, isNotNull);
      expect(frame!.streamId, equals('stream123'));
      expect(frame.totalBlocks, equals(5));
      expect(frame.isParity, isTrue);
      expect(frame.degree, equals(3));
      expect(frame.indices, equals([0, 2, 4]));
      expect(frame.checksum, equals(654321));
    });

    test('returns null for invalid string format', () {
      expect(AirQrFrame.parse('INVALID_FRAME'), isNull);
      expect(AirQrFrame.parse('AIRQR|v1|short'), isNull);
    });
  });

  group('AirQrService Stream Decoding & Reassembly', () {
    late AirQrService service;

    setUp(() {
      service = AirQrService();
    });

    test('encodes payload and decodes frames in sequential order', () {
      const payload = 'AirQR High-Speed Optical Air-Gap Test Message';
      final frames = AirQrService.encodePayload(payload, blockSize: 10);

      AirQrProgress progress = const AirQrProgress();
      for (final frame in frames) {
        progress = service.processFrameString(frame.toQrString(), progress);
        if (progress.status == AirQrStatus.completed) break;
      }

      expect(progress.status, equals(AirQrStatus.completed));
      expect(progress.reassembledContent, equals(payload));
    });

    test('decodes frames delivered out of order', () {
      const payload = 'Optical air-gap transfer without wireless pairing.';
      final frames = AirQrService.encodePayload(payload, blockSize: 12);

      final shuffledFrames = List<AirQrFrame>.from(frames)..shuffle();

      AirQrProgress progress = const AirQrProgress();
      for (final frame in shuffledFrames) {
        progress = service.processFrameString(frame.toQrString(), progress);
        if (progress.status == AirQrStatus.completed) break;
      }

      expect(progress.status, equals(AirQrStatus.completed));
      expect(progress.reassembledContent, equals(payload));
    });

    test(
      'recovers missing systematic frame using LT Fountain parity frame',
      () {
        const payload = 'Fountain code error correction demo!';
        final frames = AirQrService.encodePayload(
          payload,
          blockSize: 10,
          extraParityRatioPercent: 100,
          paritySeed: 42,
        );

        // Separate systematic frames and parity frames
        final systematicFrames = frames.where((f) => !f.isParity).toList();
        final parityFrames = frames.where((f) => f.isParity).toList();

        expect(systematicFrames.length, greaterThan(1));

        // Omit frame at index 0 and use parity frames to recover it
        final framesWithMissingIndex0 = <AirQrFrame>[
          ...systematicFrames.sublist(1),
          ...parityFrames,
        ];

        AirQrProgress progress = const AirQrProgress();
        for (final frame in framesWithMissingIndex0) {
          progress = service.processFrameString(frame.toQrString(), progress);
          if (progress.status == AirQrStatus.completed) break;
        }

        expect(progress.status, equals(AirQrStatus.completed));
        expect(progress.reassembledContent, equals(payload));
      },
    );

    test('computeCrc32 produces consistent checksum', () {
      final bytes = [72, 101, 108, 108, 111]; // "Hello"
      final crc1 = AirQrService.computeCrc32(bytes);
      final crc2 = AirQrService.computeCrc32(bytes);

      expect(crc1, equals(crc2));
      expect(crc1, isNot(equals(0)));
    });
  });

  group('AirQR fountain code improvements', () {
    late AirQrService service;

    setUp(() {
      service = AirQrService();
    });

    String longPayload(int length) =>
        List.generate(length, (i) => String.fromCharCode(65 + i % 26)).join();

    test('Robust Soliton degrees are in range and mostly small', () {
      final frames = AirQrService.encodePayload(
        longPayload(50 * 10),
        blockSize: 10,
        extraParityRatioPercent: 0,
      );
      final parity = AirQrService.generateParityFrames(
        frames,
        count: 2000,
        seed: 7,
      );

      expect(parity.length, equals(2000));
      for (final frame in parity) {
        expect(frame.degree, inInclusiveRange(1, 50));
        expect(frame.indices.length, equals(frame.degree));
      }
      // The old uniform choice gave ~4% of frames with degree 1-3 and an
      // average degree of ~26 for 50 blocks.
      final small = parity.where((f) => f.degree <= 3).length;
      expect(small / parity.length, greaterThan(0.5));
      final average =
          parity.map((f) => f.degree).reduce((a, b) => a + b) / parity.length;
      expect(average, lessThan(10));
    });

    test('generateParityFrames gives fresh frames per seed', () {
      final frames = AirQrService.encodePayload(
        longPayload(400),
        blockSize: 10,
        extraParityRatioPercent: 0,
      );
      List<String> make(int seed) => AirQrService.generateParityFrames(
        frames,
        count: 20,
        seed: seed,
      ).map((f) => f.toQrString()).toList();

      expect(make(1), equals(make(1)));
      expect(make(1), isNot(equals(make(2))));
    });

    test('rebuilds payload after losing 30% of data frames', () {
      final payload = longPayload(1200);
      final frames = AirQrService.encodePayload(
        payload,
        blockSize: 20,
        extraParityRatioPercent: 0,
      );
      final rand = Random(3);
      final kept = frames.where((_) => rand.nextDouble() >= 0.3).toList();
      expect(kept.length, lessThan(frames.length));

      AirQrProgress progress = const AirQrProgress();
      for (final frame in kept) {
        progress = service.processFrameString(frame.toQrString(), progress);
      }
      expect(progress.status, equals(AirQrStatus.receiving));

      // Each loop of the transmitter sends a fresh parity set.
      for (int loop = 0; loop < 20; loop++) {
        final parity = AirQrService.generateParityFrames(
          frames,
          count: frames.length ~/ 2,
          seed: 100 + loop,
        );
        for (final frame in parity) {
          progress = service.processFrameString(frame.toQrString(), progress);
          if (progress.status == AirQrStatus.completed) break;
        }
        if (progress.status == AirQrStatus.completed) break;
      }

      expect(progress.status, equals(AirQrStatus.completed));
      expect(progress.reassembledContent, equals(payload));
    });

    test('rejects a parity frame with a corrupted payload', () {
      const payload = 'Corrupted parity frames must be ignored safely.';
      final frames = AirQrService.encodePayload(
        payload,
        blockSize: 10,
        extraParityRatioPercent: 0,
      );
      final missing = frames.first;
      final bad = AirQrFrame(
        streamId: missing.streamId,
        totalBlocks: missing.totalBlocks,
        sequenceIndex: -1,
        isParity: true,
        degree: 1,
        indices: const [0],
        checksum: missing.checksum,
        payloadBytes: List<int>.filled(missing.payloadBytes.length, 0x55),
      );

      AirQrProgress progress = const AirQrProgress();
      progress = service.processFrameString(bad.toQrString(), progress);
      for (final frame in frames.skip(1)) {
        progress = service.processFrameString(frame.toQrString(), progress);
      }
      // The bad frame did not fill block 0, so the stream is still waiting.
      expect(progress.status, equals(AirQrStatus.receiving));
      expect(progress.capturedIndices.contains(0), isFalse);

      progress = service.processFrameString(missing.toQrString(), progress);
      expect(progress.status, equals(AirQrStatus.completed));
      expect(progress.reassembledContent, equals(payload));
    });

    test('ignores a frame with a different totalBlocks in the same stream', () {
      final frames = AirQrService.encodePayload(
        'Stream size must stay the same for one stream id.',
        blockSize: 10,
        extraParityRatioPercent: 0,
      );
      final first = frames.first;

      AirQrProgress progress = const AirQrProgress();
      progress = service.processFrameString(first.toQrString(), progress);
      final odd = AirQrFrame(
        streamId: first.streamId,
        totalBlocks: first.totalBlocks + 5,
        sequenceIndex: 1,
        isParity: false,
        degree: 1,
        indices: const [1],
        checksum: frames[1].checksum,
        payloadBytes: frames[1].payloadBytes,
      );
      progress = service.processFrameString(odd.toQrString(), progress);

      expect(progress.totalBlocks, equals(first.totalBlocks));
      expect(progress.receivedBlockCount, equals(1));
    });

    test('default block size data frames fit QR version 10 level L', () {
      final frames = AirQrService.encodePayload(
        longPayload(AirQrService.defaultBlockSize * 400),
        extraParityRatioPercent: 0,
      );
      for (final frame in frames) {
        expect(frame.toQrString().length, lessThanOrEqualTo(271));
      }
    });
  });
}
