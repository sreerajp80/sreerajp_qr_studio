import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/decode_profile.dart';
import 'package:sreerajp_qr_studio/models/scan_frame_result.dart';
import 'package:sreerajp_qr_studio/models/scanned_code.dart';
import 'package:sreerajp_qr_studio/screens/widgets/scan_camera_view.dart';
import 'package:sreerajp_qr_studio/services/barcode_decoder/barcode_decoder_service.dart';
import 'package:sreerajp_qr_studio/services/scan_camera/scan_camera_controller.dart';

/// Decoder that never finds anything; the view never decodes in these tests.
class _NoDecoder implements BarcodeDecoder {
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

  @override
  Future<List<ScannedCode>> decodeEncodedImage(
    Uint8List encoded, {
    List<CodeFormat> formats = CodeFormat.allReadable,
    DecodeProfile profile = DecodeProfile.thorough,
    int maxSymbols = 8,
  }) async => const [];

  @override
  Future<List<ScannedCode>> decodeImageFile(
    String path, {
    List<CodeFormat> formats = CodeFormat.allReadable,
    DecodeProfile profile = DecodeProfile.thorough,
    int maxSymbols = 8,
  }) async => const [];
}

/// Controller with no real camera: start() is only counted, and results are
/// pushed by the test.
class _FakeController extends ScanCameraController {
  _FakeController() : super(decoder: _NoDecoder());

  final StreamController<ScanFrameResult> results =
      StreamController<ScanFrameResult>.broadcast();
  int startCalls = 0;

  @override
  Stream<ScanFrameResult> get barcodes => results.stream;

  @override
  Future<void> start() async => startCalls++;

  void closeResults() => results.close();
}

void main() {
  late _FakeController controller;

  setUp(() => controller = _FakeController());
  tearDown(() => controller.closeResults());

  Widget host({
    void Function(ScanFrameResult)? onDetect,
    bool autoStart = true,
  }) {
    return MaterialApp(
      home: ScanCameraView(
        controller: controller,
        onDetect: onDetect,
        autoStart: autoStart,
        placeholderBuilder: (_) => const Text('placeholder'),
        errorBuilder: (_, error) => Text('error: ${error.name}'),
      ),
    );
  }

  testWidgets('starts the camera once when autoStart is on', (tester) async {
    await tester.pumpWidget(host());

    expect(controller.startCalls, 1);
    expect(find.text('placeholder'), findsOneWidget);
  });

  testWidgets('does not start the camera when autoStart is off', (
    tester,
  ) async {
    await tester.pumpWidget(host(autoStart: false));

    expect(controller.startCalls, 0);
  });

  testWidgets('shows the error builder when the camera fails', (tester) async {
    await tester.pumpWidget(host());

    controller.value = const ScanCameraState(
      error: ScanCameraError.permissionDenied,
    );
    await tester.pump();

    expect(find.text('error: permissionDenied'), findsOneWidget);
    expect(find.text('placeholder'), findsNothing);
  });

  testWidgets('passes found codes to onDetect until removed', (tester) async {
    final found = <ScanFrameResult>[];
    await tester.pumpWidget(host(onDetect: found.add));

    controller.results.add(const ScanFrameResult());
    await tester.pump();
    expect(found, hasLength(1));

    await tester.pumpWidget(const MaterialApp(home: SizedBox()));
    controller.results.add(const ScanFrameResult());
    await tester.pump();
    expect(found, hasLength(1));
    expect(tester.takeException(), isNull);
  });
}
