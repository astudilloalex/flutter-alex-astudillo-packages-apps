import 'dart:async';

import 'package:time_config_checker/src/time_config.dart';
import 'package:time_config_checker_platform_interface/time_config_checker_platform_interface.dart';

export 'src/time_config.dart';

/// [TimeConfigChecker] is a class that provides an interface to retrieve
/// time configuration from the system or a specific platform.
///
/// This class utilizes the [TimeConfigCheckerPlatformInterface] to fetch
/// the configuration and returns an instance of [TimeConfig].
class TimeConfigChecker {
  /// Constant constructor for [TimeConfigChecker].
  ///
  /// This allows creating immutable instances of the class.
  const TimeConfigChecker();

  /// Retrieves the current time configuration from the platform.
  ///
  /// This asynchronous method calls the [TimeConfigCheckerPlatformInterface]
  /// to get the time configuration, which is expected to be a [Map<String, bool>].
  /// It then converts this configuration into a [TimeConfig] instance using
  /// the `fromJson` method.
  ///
  /// Returns a [Future] that resolves to an instance of [TimeConfig].
  Future<TimeConfig> getTimeConfig() async {
    final Map<String, bool> timeConfig =
        await TimeConfigCheckerPlatformInterface.instance.getTimeConfig();
    return TimeConfig.fromJson(timeConfig);
  }
}
