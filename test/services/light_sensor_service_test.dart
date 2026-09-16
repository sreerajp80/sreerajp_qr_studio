import 'package:flutter_test/flutter_test.dart';
import 'package:sreeraj_qr_reader/services/light_sensor_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LightSensorService Tests', () {
    test('LightSensorService initializes with luxStream', () {
      final service = LightSensorService();
      expect(service.luxStream, isNotNull);
    });
  });
}
