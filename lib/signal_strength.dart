import 'signal_strength_platform_interface.dart';

class SignalStrength {
  Future<bool> isOnCellular() async {
    return await SignalStrengthPlatform.instance.getIsOnCellular();
  }

  Future<bool> isOnWifi() async {
    return await SignalStrengthPlatform.instance.getIsOnWifi();
  }

  Future<int?> getWifiSignalStrength() async {
    return await SignalStrengthPlatform.instance.getWifiSignalStrength();
  }

  Future<List<int>?> getCellularSignalStrength() async {
    return await SignalStrengthPlatform.instance.getCellularSignalStrength();
  }
}
