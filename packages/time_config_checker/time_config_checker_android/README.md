# Time Config Checker Android Plugin

A Flutter plugin for Android that allows you to check the device's time and time zone configuration settings. This plugin helps you determine whether the device is set to automatically update the time and time zone based on network-provided values.

## Features

- Check if automatic time update is enabled.
- Check if automatic time zone update is enabled.

## Getting Started

### Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  time_config_checker_android: ^latest
```

Then, run:

`flutter pub get`

#### Import the Package

```dart
import 'package:time_config_checker_android/time_config_checker_android.dart';
```

### Usage

To check the device's time and time zone configuration, use the following code:
```dart
void main() async {
  final timeConfig = await TimeConfigCheckerAndroid().getTimeConfig();

  bool isAutomaticTime = timeConfig['isAutomaticTime'] ?? false;
  bool isAutomaticTimeZone = timeConfig['isAutomaticTimeZone'] ?? false;

  print('Automatic Time: \$isAutomaticTime');
  print('Automatic Time Zone: \$isAutomaticTimeZone');
}
```

#### Output Example
```
Automatic Time: true
Automatic Time Zone: false
```

## Platform-Specific Implementation
The plugin uses Android's native APIs to access time configuration settings.
### Native Android Implementation
* AUTO_TIME: Checks if automatic time is enabled using `Settings.Global.AUTO_TIME`
* AUTO_TIME_ZONE: Checks if automatic time zone is enabled using `Settings.Global.AUTO_TIME_ZONE`
## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any bugs, feature requests, or improvements.