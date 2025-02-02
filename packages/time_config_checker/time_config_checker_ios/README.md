# Time Config Checker for iOS

This Flutter plugin allows you to check if the date and time settings on an iOS device are configured to update automatically. It provides information about both automatic time updates and automatic time zone updates.

## Features
* Detect if the device's time is set to update automatically.
* Detect if the device's time zone is set to update automatically.

## Important Note

Please note that determining whether the time is set to update automatically is not entirely precise. iOS does not expose a public API for this information. The plugin attempts to infer this setting using available methods, but the result may not always be accurate.

## Installation
Add the following to your `pubspec.yaml`:
```yaml
dependencies:
  time_config_checker_ios: ^latest
```
Then run:
```
flutter pub get
```

### Usage
Import the package in your Dart code:
```dart
import 'package:time_config_checker_ios/time_config_checker_ios.dart';
```

### Example
```dart
void main() async {
  final timeConfig = await TimeConfigCheckerIOS().getTimeConfig();

  print('Is Automatic Time: \${timeConfig['isAutomaticTime']}');
  print('Is Automatic Time Zone: \${timeConfig['isAutomaticTimeZone']}');
}
```

## API
`Future<Map<String, bool>> getTimeConfig()`
* **Returns**: A map with two keys:
    * `isAutomaticTime`: `true` if the time is inferred to be set to update automatically.
    * `isAutomaticTimeZone`: `true` if the time zone is set to update automatically.

## Platform-Specific Implementation
### iOS
The iOS implementation uses `FlutterMethodChannel` to communicate with native Swift code. The native code attempts to infer whether automatic time and time zone settings are enabled:
* **Automatic Time**: Since iOS does not expose a direct API, it checks for user defaults or assumes true. The result may not always be accurate.
* **Automatic Time Zone**: Compares `TimeZone.autoupdatingCurrent` with `TimeZone.current`.
## Contributing
Contributions are welcome! Please open an issue or submit a pull request with any features, fixes, or improvements.