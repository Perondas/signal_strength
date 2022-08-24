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

  @override
  Future<List<int>?> getCellularSignalStrength() {
    // TODO: implement getCellularSignalStrength
    throw UnimplementedError();
  }

  @override
  Future<bool> getIsOnCellular() {
    // TODO: implement getIsOnCellular
    throw UnimplementedError();
  }

  @override
  Future<bool> getIsOnWifi() {
    // TODO: implement getIsOnWifi
    throw UnimplementedError();
  }

  @override
  Future<int?> getWifiSignalStrength() {
    // TODO: implement getWifiSignalStrength
    throw UnimplementedError();
  }
}

void main() {
  final SignalStrengthPlatform initialPlatform =
      SignalStrengthPlatform.instance;

  test('$MethodChannelSignalStrength is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSignalStrength>());
  });

  test('getPlatformVersion', () async {
    SignalStrength signalStrengthPlugin = SignalStrength();
    MockSignalStrengthPlatform fakePlatform = MockSignalStrengthPlatform();
    SignalStrengthPlatform.instance = fakePlatform;
  });
}
