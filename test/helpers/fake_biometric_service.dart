import 'package:sreerajp_qr_studio/services/biometric_service.dart';

/// Biometric stand-in for tests: answers with fixed results and counts the
/// prompts.
class FakeBiometricService extends BiometricService {
  FakeBiometricService({this.available = true, this.succeeds = true});

  bool available;
  bool succeeds;
  int prompts = 0;

  @override
  Future<bool> isBiometricAvailable() async => available;

  @override
  Future<bool> authenticate({required String localizedReason}) async {
    prompts++;
    return succeeds;
  }
}
