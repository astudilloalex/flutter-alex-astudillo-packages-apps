import 'package:flutter/services.dart' show MethodChannel;
import 'package:time_config_checker_platform_interface/time_config_checker_platform_interface.dart';

/// A platform-specific implementation of [TimeConfigCheckerPlatformInterface]
/// for Android, responsible for retrieving time configuration settings
/// from the native Android environment.
class TimeConfigCheckerAndroid extends TimeConfigCheckerPlatformInterface {
  /// The [MethodChannel] used to communicate with the native Android code.
  ///
  /// This channel listens for method calls with the identifier
  /// 'time_config_checker_android'.
  static const MethodChannel _channel = MethodChannel(
    'time_config_checker_android',
  );

  /// Registers this class as the default instance of
  /// [TimeConfigCheckerPlatformInterface].
  ///
  /// This method should be called during the plugin initialization
  /// to ensure that Android-specific implementations are used
  /// when running on Android devices.
  static void registerWith() {
    TimeConfigCheckerPlatformInterface.instance = TimeConfigCheckerAndroid();
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
