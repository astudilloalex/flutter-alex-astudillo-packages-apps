import 'package:flutter/services.dart' show MethodChannel;
import 'package:time_config_checker_platform_interface/time_config_checker_platform_interface.dart';

/// iOS-specific implementation of the TimeConfigChecker.
///
/// This class extends [TimeConfigCheckerPlatformInterface] and provides
/// the iOS-specific functionality. It uses a [MethodChannel] to communicate
/// with the native iOS code.
class TimeConfigCheckerIOS extends TimeConfigCheckerPlatformInterface {
  /// The method channel used for communication with the native iOS code.
  ///
  /// The channel is identified by the name `'time_config_checker_ios'`.
  static const MethodChannel _channel =
      MethodChannel('time_config_checker_ios');

  /// Registers this class as the default implementation for iOS.
  ///
  /// This method should be called during the plugin initialization to ensure
  /// that [TimeConfigCheckerIOS] is used when the app runs on iOS devices.
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
