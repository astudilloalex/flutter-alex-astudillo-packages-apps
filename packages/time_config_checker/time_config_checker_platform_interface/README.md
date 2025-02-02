A common platform interface for the time_config_checker

## Usage

To implement a new platform-specific implementation of time_config_checker, extend `TimeConfigCheckerPlatformInterface` with an implementation that performs the platform-specific behavior, and when you register your plugin, set the default `TimeConfigCheckerPlatformInterface` by calling `TimeConfigCheckerPlatformInterface.instance = MyTimeConfigChecker()`

