import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/providers/onboarding_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OnboardingProvider', () {
    test('defaults to false when preference is absent', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final provider = OnboardingProvider(prefs: prefs);

      expect(provider.isInitialized, isTrue);
      expect(provider.hasSeenOnboarding, isFalse);
    });

    test('loads true when preference is saved', () async {
      SharedPreferences.setMockInitialValues({
        OnboardingProvider.prefHasSeenOnboardingKey: true,
      });
      final prefs = await SharedPreferences.getInstance();

      final provider = OnboardingProvider(prefs: prefs);

      expect(provider.isInitialized, isTrue);
      expect(provider.hasSeenOnboarding, isTrue);
    });

    test('completeOnboarding sets flag and notifies listeners', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final provider = OnboardingProvider(prefs: prefs);

      bool notified = false;
      provider.addListener(() {
        notified = true;
      });

      await provider.completeOnboarding();

      expect(provider.hasSeenOnboarding, isTrue);
      expect(notified, isTrue);
      expect(
        prefs.getBool(OnboardingProvider.prefHasSeenOnboardingKey),
        isTrue,
      );
    });

    test('resetOnboarding clears flag and notifies listeners', () async {
      SharedPreferences.setMockInitialValues({
        OnboardingProvider.prefHasSeenOnboardingKey: true,
      });
      final prefs = await SharedPreferences.getInstance();

      final provider = OnboardingProvider(prefs: prefs);
      expect(provider.hasSeenOnboarding, isTrue);

      bool notified = false;
      provider.addListener(() {
        notified = true;
      });

      await provider.resetOnboarding();

      expect(provider.hasSeenOnboarding, isFalse);
      expect(notified, isTrue);
      expect(
        prefs.getBool(OnboardingProvider.prefHasSeenOnboardingKey),
        isFalse,
      );
    });
  });
}
