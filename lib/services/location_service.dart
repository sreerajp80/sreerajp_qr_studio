import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/models/location_result.dart';

/// Asks for location permission; returns true when it is granted.
typedef LocationPermissionRequest = Future<bool> Function();

/// Reads the current position as latitude and longitude.
typedef PositionReader =
    Future<({double latitude, double longitude})> Function();

/// One-time device location lookup (used to fill a CodeForge location code).
///
/// Permission is requested only when this is called (point of use). The
/// service never throws and holds no user-visible text; the screen picks the
/// wording from the returned [LocationResult].
class LocationService {
  final LocationPermissionRequest _requestPermission;
  final PositionReader _readPosition;

  LocationService({
    LocationPermissionRequest? requestPermission,
    PositionReader? readPosition,
  }) : _requestPermission = requestPermission ?? _defaultRequestPermission,
       _readPosition = readPosition ?? _defaultReadPosition;

  static Future<bool> _defaultRequestPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  static Future<({double latitude, double longitude})>
  _defaultReadPosition() async {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 15),
      ),
    );
    return (latitude: position.latitude, longitude: position.longitude);
  }

  /// Asks for permission, then reads the current position.
  Future<LocationResult> getCurrentLocation() async {
    try {
      final granted = await _requestPermission();
      if (!granted) return const LocationResult.permissionDenied();
    } catch (e, st) {
      AppLogger.error(
        'Location permission request failed',
        error: e,
        stackTrace: st,
      );
      return const LocationResult.failed();
    }

    try {
      final position = await _readPosition();
      return LocationResult.success(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e, st) {
      AppLogger.error(
        'Reading current position failed',
        error: e,
        stackTrace: st,
      );
      return const LocationResult.failed();
    }
  }
}
