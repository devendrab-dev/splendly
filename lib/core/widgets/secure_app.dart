import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

class DeviceLockAuth {
  static final LocalAuthentication auth = LocalAuthentication();

  static Future<bool> authenticate() async {
    debugPrint("🔒 [AUTH] authenticate() called (v3.x API)");

    try {
      final bool canCheck = await auth.canCheckBiometrics;
      debugPrint("📍 [AUTH] canCheckBiometrics: $canCheck");

      final bool isDeviceSupported = await auth.isDeviceSupported();
      debugPrint("📍 [AUTH] isDeviceSupported: $isDeviceSupported");

      final List<BiometricType> available = await auth.getAvailableBiometrics();
      debugPrint("📍 [AUTH] availableBiometrics: $available");

      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Unlock your app',
        biometricOnly: false,
        persistAcrossBackgrounding: true,
      );

      debugPrint("✅ [AUTH] didAuthenticate: $didAuthenticate");
      return didAuthenticate;
    } on LocalAuthException catch (e, st) {
      debugPrint("❌ [AUTH] LocalAuthException: ${e.code} - ${e.description}");
      debugPrint("❌ [AUTH] Stack: $st");
      return false;
    } catch (e, st) {
      debugPrint("❌ [AUTH] Unknown error: $e");
      debugPrint("❌ [AUTH] Stack: $st");
      return false;
    }
  }
}
