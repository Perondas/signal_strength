import 'signal_strength_platform_interface.dart';

class SignalStrength {
  /// Returns true if the device is using cellular network.
  Future<bool> isOnCellular() async {
    return await SignalStrengthPlatform.instance.getIsOnCellular();
  }

  /// Returns true if the device is using wifi network.
  Future<bool> isOnWifi() async {
    return await SignalStrengthPlatform.instance.getIsOnWifi();
  }

  /// Returns the wifi signal strength.
  Future<int?> getWifiSignalStrength() async {
    return await SignalStrengthPlatform.instance.getWifiSignalStrength();
  }

  /// Return an array of signal strengths from 0 to 4.
  Future<List<int>?> getCellularSignalStrength() async {
    return await SignalStrengthPlatform.instance.getCellularSignalStrength();
  }
}
