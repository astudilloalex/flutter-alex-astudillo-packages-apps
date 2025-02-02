# Time Config Checker
A Flutter plugin that allows you to check if a device's time and time zone settings are configured automatically or manually. This is especially useful for applications that require accurate time settings for security or synchronization purposes.

## Features
* Retrieve device time configuration settings.
* Check if the device's time is set automatically.
* Check if the device's time zone is set automatically.

## Getting Started
### Installation
Add the following to your `pubspec.yaml` file:
```yaml
dependencies:
  time_config_checker: ^latest
```
Then run:
```
flutter pub get
```
### Platform Support
* **Android**: Uses the `time_config_checker_android` package.
* **iOS**: Uses the `time_config_checker_ios` package.
## Contributing
Contributions are welcome! Please submit a pull request or open an issue to discuss potential changes.