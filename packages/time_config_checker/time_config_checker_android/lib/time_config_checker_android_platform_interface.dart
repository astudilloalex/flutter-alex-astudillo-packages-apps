import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'time_config_checker_android_method_channel.dart';

abstract class TimeConfigCheckerAndroidPlatform extends PlatformInterface {
  /// Constructs a TimeConfigCheckerAndroidPlatform.
  TimeConfigCheckerAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static TimeConfigCheckerAndroidPlatform _instance = MethodChannelTimeConfigCheckerAndroid();

  /// The default instance of [TimeConfigCheckerAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelTimeConfigCheckerAndroid].
  static TimeConfigCheckerAndroidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TimeConfigCheckerAndroidPlatform] when
  /// they register themselves.
  static set instance(TimeConfigCheckerAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
