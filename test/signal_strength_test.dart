import 'package:flutter_test/flutter_test.dart';
import 'package:signal_strength/signal_strength.dart';
import 'package:signal_strength/signal_strength_platform_interface.dart';
import 'package:signal_strength/signal_strength_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSignalStrengthPlatform 
    with MockPlatformInterfaceMixin
    implements SignalStrengthPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SignalStrengthPlatform initialPlatform = SignalStrengthPlatform.instance;

  test('$MethodChannelSignalStrength is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSignalStrength>());
  });

  test('getPlatformVersion', () async {
    SignalStrength signalStrengthPlugin = SignalStrength();
    MockSignalStrengthPlatform fakePlatform = MockSignalStrengthPlatform();
    SignalStrengthPlatform.instance = fakePlatform;
  
    expect(await signalStrengthPlugin.getPlatformVersion(), '42');
  });
}
