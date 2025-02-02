import 'dart:async';

import 'package:time_config_checker/src/time_config.dart';
import 'package:time_config_checker_platform_interface/time_config_checker_platform_interface.dart';

export 'src/time_config.dart';

class TimeConfigChecker {
  const TimeConfigChecker();

  Future<TimeConfig> getTimeConfig() async {
    final Map<String, bool> timeConfig =
        await TimeConfigCheckerPlatformInterface.instance.getTimeConfig();
    return TimeConfig.fromJson(timeConfig);
  }
}
