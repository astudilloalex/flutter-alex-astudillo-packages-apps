import 'time_config_checker_android_platform_interface.dart';

class TimeConfigCheckerAndroid {
  Future<String?> getPlatformVersion() {
    return TimeConfigCheckerAndroidPlatform.instance.getPlatformVersion();
  }
}
