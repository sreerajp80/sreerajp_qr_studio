import 'dart:async';
import 'package:flutter/services.dart';

/// Service interfacing with native device ambient light sensors (lux).
class LightSensorService {
  static const EventChannel _eventChannel = EventChannel(
    'in.sreeraj.qr_reader/ambient_light',
  );

  Stream<double>? _luxStream;

  LightSensorService({EventChannel? channel}) {
    final activeChannel = channel ?? _eventChannel;
    _luxStream = activeChannel.receiveBroadcastStream().map((event) {
      if (event is num) {
        return event.toDouble();
      }
      return 0.0;
    }).distinct();
  }

  /// Stream of ambient light illuminance values in lux.
  Stream<double> get luxStream => _luxStream ?? const Stream<double>.empty();
}
