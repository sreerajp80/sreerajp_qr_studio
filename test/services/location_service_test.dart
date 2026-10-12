import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/location_result.dart';
import 'package:sreerajp_qr_studio/services/location_service.dart';

void main() {
  group('LocationService.getCurrentLocation', () {
    test('returns the position when permission is granted', () async {
      final service = LocationService(
        requestPermission: () async => true,
        readPosition: () async => (latitude: 10.5, longitude: 76.25),
      );

      final result = await service.getCurrentLocation();

      expect(result.status, LocationStatus.success);
      expect(result.latitude, 10.5);
      expect(result.longitude, 76.25);
    });

    test('returns permissionDenied and does not read the position', () async {
      var positionRead = false;
      final service = LocationService(
        requestPermission: () async => false,
        readPosition: () async {
          positionRead = true;
          return (latitude: 0.0, longitude: 0.0);
        },
      );

      final result = await service.getCurrentLocation();

      expect(result.status, LocationStatus.permissionDenied);
      expect(positionRead, isFalse);
    });

    test('returns failed when reading the position throws', () async {
      final service = LocationService(
        requestPermission: () async => true,
        readPosition: () async => throw Exception('timeout'),
      );

      final result = await service.getCurrentLocation();

      expect(result.status, LocationStatus.failed);
      expect(result.latitude, isNull);
    });

    test('returns failed when the permission request throws', () async {
      final service = LocationService(
        requestPermission: () async => throw Exception('no plugin'),
        readPosition: () async => (latitude: 1.0, longitude: 1.0),
      );

      final result = await service.getCurrentLocation();

      expect(result.status, LocationStatus.failed);
    });
  });
}
