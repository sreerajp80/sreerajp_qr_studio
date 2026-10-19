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

  group('ScanCameraController.frameGapFor', () {
    const minGap = ScanCameraController.defaultMinFrameGap;
    const idleGap = ScanCameraController.defaultIdleFrameGap;
    const idleAfter = ScanCameraController.defaultIdleAfter;

    test('uses the short gap while a code or user action is recent', () {
      expect(
        ScanCameraController.frameGapFor(
          sinceActivity: const Duration(seconds: 2),
          minGap: minGap,
          idleGap: idleGap,
          idleAfter: idleAfter,
        ),
        minGap,
      );
    });

    test('uses the longer gap after the idle time', () {
      expect(
        ScanCameraController.frameGapFor(
          sinceActivity: idleAfter,
          minGap: minGap,
          idleGap: idleGap,
          idleAfter: idleAfter,
        ),
        idleGap,
      );
    });

    test('zero gaps decode every frame (AirQR)', () {
      expect(
        ScanCameraController.frameGapFor(
          sinceActivity: const Duration(minutes: 5),
          minGap: Duration.zero,
          idleGap: Duration.zero,
          idleAfter: idleAfter,
        ),
        Duration.zero,
      );
    });

    test('defaults cap decoding at about 15 and 5 a second', () {
      expect(minGap.inMilliseconds, lessThanOrEqualTo(70));
      expect(idleGap.inMilliseconds, greaterThan(minGap.inMilliseconds));
    });
  });
}
