import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/scanned_code.dart';
import 'package:sreerajp_qr_studio/services/barcode_decoder/barcode_decoder_service.dart';
import 'package:sreerajp_qr_studio/services/barcode_decoder/barcode_ffi_bindings.dart';

/// A worker whose isolate side is played by the test: commands land in
/// [sent], and the test pushes answers or exit messages into [responses].
class _FakeWorker {
  final ReceivePort commands = ReceivePort();
  final StreamController<dynamic> responses = StreamController<dynamic>();
  final List<dynamic> sent = [];
  late final DecoderWorker worker;
  int deadCalls = 0;

  _FakeWorker({Duration timeout = const Duration(milliseconds: 50)}) {
    commands.listen(sent.add);
    worker = DecoderWorker(
      commands.sendPort,
      responses.stream,
      timeout: timeout,
    )..onDead = () => deadCalls++;
  }

  void dispose() {
    commands.close();
    responses.close();
  }
}

DecodeRequest _request() => DecodeRequest(
  pixels: Uint8List(4),
  width: 1,
  height: 1,
  imageFormat: SrbImageFormat.rgba,
  formatMask: 0,
);

void main() {
  test('a decode that gets no answer returns an empty result', () async {
    final fake = _FakeWorker();
    addTearDown(fake.dispose);

    final codes = await fake.worker.decode(_request());

    expect(codes, isEmpty);
    expect(fake.worker.pendingCount, 0);
    expect(fake.worker.isDead, isFalse);
  });

  test('an answer completes the decode', () async {
    final fake = _FakeWorker(timeout: const Duration(seconds: 5));
    addTearDown(fake.dispose);

    final future = fake.worker.decode(_request());
    await Future<void>.delayed(Duration.zero);
    final id = (fake.sent.single as (int, DecodeRequest)).$1;
    fake.responses.add((id, const <ScannedCode>[]));

    expect(await future, isEmpty);
    expect(fake.worker.pendingCount, 0);
  });

  test('worker exit finishes waiting decodes and marks it dead', () async {
    final fake = _FakeWorker(timeout: const Duration(seconds: 5));
    addTearDown(fake.dispose);

    final first = fake.worker.decode(_request());
    final second = fake.worker.decode(_request());
    expect(fake.worker.pendingCount, 2);

    // The isolate's exit listener sends null.
    fake.responses.add(null);

    expect(await first, isEmpty);
    expect(await second, isEmpty);
    expect(fake.worker.isDead, isTrue);
    expect(fake.deadCalls, 1);
    // A dead worker answers at once, without sending anything.
    await Future<void>.delayed(Duration.zero);
    final sentBefore = fake.sent.length;
    expect(await fake.worker.decode(_request()), isEmpty);
    await Future<void>.delayed(Duration.zero);
    expect(fake.sent.length, sentBefore);
  });

  test('an error report alone does not mark the worker dead', () async {
    final fake = _FakeWorker();
    addTearDown(fake.dispose);

    fake.responses.add(['boom', 'stack']);
    await Future<void>.delayed(Duration.zero);

    expect(fake.worker.isDead, isFalse);
    expect(fake.deadCalls, 0);
  });

  test('repeated timeouts mark the worker dead', () async {
    final fake = _FakeWorker();
    addTearDown(fake.dispose);

    for (var i = 0; i < DecoderWorker.maxTimeoutsInARow; i++) {
      expect(await fake.worker.decode(_request()), isEmpty);
    }

    expect(fake.worker.isDead, isTrue);
    expect(fake.deadCalls, 1);
  });
}
