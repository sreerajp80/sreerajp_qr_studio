import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreeraj_qr_reader/models/camera_settings.dart';
import 'package:sreeraj_qr_reader/providers/camera_settings_provider.dart';
import 'package:sreeraj_qr_reader/services/light_sensor_service.dart';

class MockLightSensorService extends LightSensorService {
  final StreamController<double> controller =
      StreamController<double>.broadcast();

  @override
  Stream<double> get luxStream => controller.stream;

  void dispose() {
    controller.close();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('CameraSettingsProvider Tests', () {
    test('Initial defaults are correctly configured', () async {
      final mockService = MockLightSensorService();
      final provider = CameraSettingsProvider(lightSensorService: mockService);
      await Future<void>.delayed(Duration.zero);

      expect(provider.flashMode, equals(CameraFlashMode.off));
      expect(provider.resolutionPreset, equals(CameraResolutionPreset.fullHd));
      expect(provider.targetResolution, equals(const Size(1920, 1080)));
      expect(provider.brightness, equals(0.0));
      expect(provider.contrast, equals(1.0));
      expect(provider.invertColors, isFalse);
      expect(provider.shouldTorchBeOn, isFalse);
      expect(provider.colorMatrix.length, equals(20));

      provider.dispose();
      mockService.dispose();
    });

    test('Flash mode cycle transitions: off -> on -> auto -> off', () async {
      final mockService = MockLightSensorService();
      final provider = CameraSettingsProvider(lightSensorService: mockService);
      await Future<void>.delayed(Duration.zero);

      await provider.cycleFlashMode();
      expect(provider.flashMode, equals(CameraFlashMode.on));
      expect(provider.shouldTorchBeOn, isTrue);

      await provider.cycleFlashMode();
      expect(provider.flashMode, equals(CameraFlashMode.auto));

      await provider.cycleFlashMode();
      expect(provider.flashMode, equals(CameraFlashMode.off));
      expect(provider.shouldTorchBeOn, isFalse);

      provider.dispose();
      mockService.dispose();
    });

    test(
      'Auto flash reacts to low lux (< 12) and bright lux (> 28) with hysteresis',
      () async {
        final mockService = MockLightSensorService();
        final provider = CameraSettingsProvider(
          lightSensorService: mockService,
        );
        await Future<void>.delayed(Duration.zero);

        await provider.setFlashMode(CameraFlashMode.auto);
        expect(provider.shouldTorchBeOn, isFalse);

        // Low light condition (< 12 lux)
        mockService.controller.add(5.0);
        await Future<void>.delayed(Duration.zero);

        expect(provider.currentLux, equals(5.0));
        expect(provider.autoTorchActive, isTrue);
        expect(provider.shouldTorchBeOn, isTrue);

        // Borderline light (18 lux) - hysteresis keeps it on
        mockService.controller.add(18.0);
        await Future<void>.delayed(Duration.zero);

        expect(provider.autoTorchActive, isTrue);
        expect(provider.shouldTorchBeOn, isTrue);

        // Bright light (> 28 lux) turns auto torch off
        mockService.controller.add(45.0);
        await Future<void>.delayed(Duration.zero);

        expect(provider.autoTorchActive, isFalse);
        expect(provider.shouldTorchBeOn, isFalse);

        provider.dispose();
        mockService.dispose();
      },
    );

    test(
      'Brightness and contrast adjustments update state and clamp safely',
      () async {
        final mockService = MockLightSensorService();
        final provider = CameraSettingsProvider(
          lightSensorService: mockService,
        );
        await Future<void>.delayed(Duration.zero);

        provider.setBrightness(0.4);
        expect(provider.brightness, equals(0.4));

        provider.setBrightness(5.0);
        expect(provider.brightness, equals(1.0)); // clamped

        provider.setContrast(1.8);
        expect(provider.contrast, equals(1.8));

        provider.setInvertColors(true);
        expect(provider.invertColors, isTrue);

        // Reset to defaults
        provider.resetAdjustments();
        expect(provider.brightness, equals(0.0));
        expect(provider.contrast, equals(1.0));
        expect(provider.invertColors, isFalse);

        provider.dispose();
        mockService.dispose();
      },
    );

    test('Resolution preset changes and persists', () async {
      final mockService = MockLightSensorService();
      final provider = CameraSettingsProvider(lightSensorService: mockService);
      await Future<void>.delayed(Duration.zero);

      await provider.setResolutionPreset(CameraResolutionPreset.max);
      expect(provider.resolutionPreset, equals(CameraResolutionPreset.max));
      expect(provider.targetResolution, equals(const Size(3840, 2160)));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('camera_resolution_preset'), equals('max'));

      provider.dispose();
      mockService.dispose();
    });

    test('Focus point setting and clearing', () async {
      final mockService = MockLightSensorService();
      final provider = CameraSettingsProvider(lightSensorService: mockService);
      await Future<void>.delayed(Duration.zero);

      provider.setFocusPoint(const Offset(120, 240));
      expect(provider.focusPoint, equals(const Offset(120, 240)));
      expect(provider.focusPointTimestamp, isNotNull);

      provider.clearFocusPoint();
      expect(provider.focusPoint, isNull);

      provider.dispose();
      mockService.dispose();
    });

    test(
      'Distance enhancement mode, zoom factor, and unsharp strength update and persist',
      () async {
        final mockService = MockLightSensorService();
        final provider = CameraSettingsProvider(
          lightSensorService: mockService,
        );
        await Future<void>.delayed(Duration.zero);

        // Default checks
        expect(provider.isDistanceEnhanceMode, isFalse);
        expect(provider.distanceZoomFactor, equals(2.5));
        expect(provider.unsharpMaskStrength, equals(1.5));
        expect(provider.autoZoomEnabled, isTrue);

        // Toggle mode
        await provider.toggleDistanceEnhanceMode();
        expect(provider.isDistanceEnhanceMode, isTrue);

        // Set zoom factor & unsharp strength
        await provider.setDistanceZoomFactor(3.5);
        expect(provider.distanceZoomFactor, equals(3.5));

        await provider.setUnsharpMaskStrength(2.0);
        expect(provider.unsharpMaskStrength, equals(2.0));

        provider.setAutoZoomEnabled(false);
        expect(provider.autoZoomEnabled, isFalse);

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getBool('camera_distance_enhance_mode'), isTrue);
        expect(prefs.getDouble('camera_distance_zoom'), equals(3.5));
        expect(prefs.getDouble('camera_unsharp_strength'), equals(2.0));

        // Reset adjustments resets zoom and unsharp to defaults
        provider.resetAdjustments();
        expect(provider.distanceZoomFactor, equals(2.5));
        expect(provider.unsharpMaskStrength, equals(1.5));

        provider.dispose();
        mockService.dispose();
      },
    );
  });
}
