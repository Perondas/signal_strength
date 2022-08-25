import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'signal_strength_platform_interface.dart';

/// An implementation of [SignalStrengthPlatform] that uses method channels.
class MethodChannelSignalStrength extends SignalStrengthPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('signal_strength');

  @override
  Future<List<int>?> getCellularSignalStrength() async {
    var res = await methodChannel
        .invokeMethod<List<dynamic>>('getCellSignalStrengths');
    return res?.map((e) => e as int).toList();
  }

  @override
  Future<bool> getIsOnCellular() async {
    var res = await methodChannel.invokeMethod<bool>('getIsOnCellular');
    return res!;
  }

  @override
  Future<bool> getIsOnWifi() async {
    var res = await methodChannel.invokeMethod<bool>('getIsOnWifi');
    return res!;
  }

  @override
  Future<int?> getWifiSignalStrength() async {
    return await methodChannel.invokeMethod<int>('getWifiSignalStrength');
  }
}
