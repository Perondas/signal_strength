import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'signal_strength_method_channel.dart';

abstract class SignalStrengthPlatform extends PlatformInterface {
  /// Constructs a SignalStrengthPlatform.
  SignalStrengthPlatform() : super(token: _token);

  static final Object _token = Object();

  static SignalStrengthPlatform _instance = MethodChannelSignalStrength();

  /// The default instance of [SignalStrengthPlatform] to use.
  ///
  /// Defaults to [MethodChannelSignalStrength].
  static SignalStrengthPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SignalStrengthPlatform] when
  /// they register themselves.
  static set instance(SignalStrengthPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
