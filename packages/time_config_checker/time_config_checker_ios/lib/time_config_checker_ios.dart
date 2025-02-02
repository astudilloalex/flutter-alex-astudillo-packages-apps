import 'package:flutter/services.dart' show MethodChannel;
import 'package:time_config_checker_platform_interface/time_config_checker_platform_interface.dart';

class TimeConfigCheckerIOS extends TimeConfigCheckerPlatformInterface {
  static const MethodChannel _channel =
      MethodChannel('time_config_checker_ios');

  static void registerWith() {
    TimeConfigCheckerPlatformInterface.instance = TimeConfigCheckerIOS();
  }

  @override
  Future<Map<String, bool>> getTimeConfig() async {
    final Map<Object?, Object?> result =
        await _channel.invokeMethod('getTimeConfig') as Map<Object?, Object?>;
    return result.map(
      (Object? key, Object? value) => MapEntry(key! as String, value! as bool),
    );
  }
}
