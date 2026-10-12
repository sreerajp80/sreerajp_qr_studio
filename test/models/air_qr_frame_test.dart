import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/air_qr_frame.dart';

void main() {
  group('AirQrFrame.parse safety checks', () {
    test('rejects totalBlocks of zero or less', () {
      expect(AirQrFrame.parse('AIRQR|v1|s1|0|0|1|SGVsbG8='), isNull);
      expect(AirQrFrame.parse('AIRQR|v1|s1|-3|0|1|SGVsbG8='), isNull);
    });

    test('rejects out-of-range systematic index', () {
      expect(AirQrFrame.parse('AIRQR|v1|s1|5|5|1|SGVsbG8='), isNull);
      expect(AirQrFrame.parse('AIRQR|v1|s1|5|-1|1|SGVsbG8='), isNull);
    });

    test('rejects out-of-range parity indices', () {
      expect(AirQrFrame.parse('AIRQR|LT1|s1|5|2:1,5|1|SGVsbG8='), isNull);
      expect(AirQrFrame.parse('AIRQR|LT1|s1|5|2:-1,2|1|SGVsbG8='), isNull);
    });

    test('rejects degree that does not match the index list', () {
      expect(AirQrFrame.parse('AIRQR|LT1|s1|5|3:0,1|1|SGVsbG8='), isNull);
    });

    test('rejects an empty or repeated index list', () {
      expect(AirQrFrame.parse('AIRQR|LT1|s1|5|0:|1|SGVsbG8='), isNull);
      expect(AirQrFrame.parse('AIRQR|LT1|s1|5|2:1,1|1|SGVsbG8='), isNull);
    });

    test('rejects garbage numbers without throwing', () {
      expect(AirQrFrame.parse('AIRQR|LT1|s1|five|x:y|z|!!'), isNull);
    });

    test('still accepts a valid parity frame', () {
      final frame = AirQrFrame.parse('AIRQR|LT1|s1|5|2:1,4|1|SGVsbG8=');
      expect(frame, isNotNull);
      expect(frame!.indices, equals([1, 4]));
    });
  });
}
