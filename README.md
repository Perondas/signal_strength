# signal_strength

[![](http://flutter-badge.zaynjarvis.com/version/{PackageName})](https://pub.dartlang.org/packages/signal_strength)
[![](http://flutter-badge.zaynjarvis.com/score/{PackageName})](https://pub.dartlang.org/packages/signal_strength)

A android flutter plugin to get the current signal strengths.
Only works on Android.

## Usage

Add to pubspec.yaml:
```yaml
signal_strength 0.0.1
```

Import:
```dart
import 'package:signal_strength/signal_strength.dart';
```

Usage:
```dart
var signalStrengthPlugin = SignalStrength();

bool isOnCellular = await signalStrengthPlugin.isOnCellular(),
bool isOnWifi = await signalStrengthPlugin.isOnWifi(),
int? wifiStrength = await signalStrengthPlugin.getWifiSignalStrength(),
List<int>? cellStrength = await signalStrengthPlugin.getCellularSignalStrength());
```

## Todo:
* Ios implementation? 
* Add more methods from the android SDK?