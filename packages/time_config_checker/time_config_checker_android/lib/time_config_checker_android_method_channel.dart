import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'time_config_checker_android_platform_interface.dart';

/// An implementation of [TimeConfigCheckerAndroidPlatform] that uses method channels.
class MethodChannelTimeConfigCheckerAndroid extends TimeConfigCheckerAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('time_config_checker_android');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
