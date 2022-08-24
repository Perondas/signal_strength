import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'signal_strength_platform_interface.dart';

/// An implementation of [SignalStrengthPlatform] that uses method channels.
class MethodChannelSignalStrength extends SignalStrengthPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('signal_strength');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
