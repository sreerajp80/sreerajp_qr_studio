import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/decode_profile.dart';
import 'package:sreerajp_qr_studio/services/scan_camera/scan_camera_controller.dart';

void main() {
  group('ScanCameraController.profileForFrame', () {
    test('live uses a quick pass on most frames and live every 3rd', () {
      final profiles = List.generate(
        6,
        (i) => ScanCameraController.profileForFrame(i, DecodeProfile.live),
      );
      expect(profiles, [
        DecodeProfile.fast,
        DecodeProfile.fast,
        DecodeProfile.live,
        DecodeProfile.fast,
        DecodeProfile.fast,
        DecodeProfile.live,
      ]);
    });

    test('other profiles are used on every frame', () {
      for (var i = 0; i < 6; i++) {
        expect(
          ScanCameraController.profileForFrame(i, DecodeProfile.fast),
          DecodeProfile.fast,
        );
        expect(
          ScanCameraController.profileForFrame(i, DecodeProfile.thorough),
          DecodeProfile.thorough,
        );
      }
    });
  });
}
