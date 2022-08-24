import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signal_strength/signal_strength_method_channel.dart';

void main() {
  MethodChannelSignalStrength platform = MethodChannelSignalStrength();
  const MethodChannel channel = MethodChannel('signal_strength');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
