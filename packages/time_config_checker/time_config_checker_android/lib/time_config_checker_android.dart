import 'package:flutter/services.dart' show MethodChannel;
import 'package:time_config_checker_platform_interface/time_config_checker_platform_interface.dart';

class TimeConfigCheckerAndroid extends TimeConfigCheckerPlatformInterface {
  static const MethodChannel _channel = MethodChannel(
    'time_config_checker_android',
  );

  static void registerWith() {
    TimeConfigCheckerPlatformInterface.instance = TimeConfigCheckerAndroid();
  }

  @override
  Future<Map<String, bool>> getTimeConfig() async {
    return await _channel.invokeMethod('getTimeConfig') as Map<String, bool>;
  }

  @override
  Future<bool> isTimeAutomatic() {
    // TODO: implement isTimeAutomatic
    throw UnimplementedError();
  }
}

void _registerTimeConfigPlugin() {
  TimeConfigCheckerAndroid.registerWith();
}

_registerTimeConfigPlugin();
