/// Outcome of asking the device for its current location.
enum LocationStatus {
  /// A position was found; [LocationResult.latitude] and
  /// [LocationResult.longitude] are set.
  success,

  /// The user did not grant location permission.
  permissionDenied,

  /// Permission was granted but no position could be read (location off,
  /// timeout, or a plugin error).
  failed,
}

/// Immutable result of a one-time location lookup.
class LocationResult {
  final LocationStatus status;
  final double? latitude;
  final double? longitude;

  const LocationResult._(this.status, {this.latitude, this.longitude});

  const LocationResult.success({
    required double latitude,
    required double longitude,
  }) : this._(LocationStatus.success, latitude: latitude, longitude: longitude);

  const LocationResult.permissionDenied()
    : this._(LocationStatus.permissionDenied);

  const LocationResult.failed() : this._(LocationStatus.failed);

  bool get isSuccess => status == LocationStatus.success;
}
