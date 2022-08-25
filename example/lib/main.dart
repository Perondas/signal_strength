import 'package:flutter/material.dart';
import 'dart:async';

import 'package:signal_strength/signal_strength.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _signalStrengthPlugin = SignalStrength();

  NetworkStats? _stats;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 1), _getNetworkStats);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getNetworkStats() async {
    _timer?.cancel();
    var stats = NetworkStats(
        await _signalStrengthPlugin.isOnCellular(),
        await _signalStrengthPlugin.isOnWifi(),
        await _signalStrengthPlugin.getWifiSignalStrength(),
        await _signalStrengthPlugin.getCellularSignalStrength());
    setState(() {
      _stats = stats;
    });
    _timer = Timer(const Duration(seconds: 1), _getNetworkStats);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              if (_stats != null) ...[
                Text('Cell strength: ${_stats?.cellularSignalStrength}'),
                Text('Wifi strength: ${_stats?.wifiSignalStrength}'),
                Text('On cellular: ${_stats?.hasCellular}'),
                Text('On wifi: ${_stats?.hasWifi}'),
              ] else ...[
                const Text('No stats available')
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class NetworkStats {
  NetworkStats(this.hasCellular, this.hasWifi, this.wifiSignalStrength,
      this.cellularSignalStrength);
  bool hasCellular;
  bool hasWifi;
  int? wifiSignalStrength;
  List<int>? cellularSignalStrength;
}
