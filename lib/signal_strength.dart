
import 'signal_strength_platform_interface.dart';

class SignalStrength {
  Future<String?> getPlatformVersion() {
    return SignalStrengthPlatform.instance.getPlatformVersion();
  }
}
