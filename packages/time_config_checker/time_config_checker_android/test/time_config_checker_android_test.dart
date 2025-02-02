import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:time_config_checker_android/time_config_checker_android.dart';
import 'package:time_config_checker_android/time_config_checker_android_method_channel.dart';
import 'package:time_config_checker_android/time_config_checker_android_platform_interface.dart';

class MockTimeConfigCheckerAndroidPlatform
    with MockPlatformInterfaceMixin
    implements TimeConfigCheckerAndroidPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TimeConfigCheckerAndroidPlatform initialPlatform =
      TimeConfigCheckerAndroidPlatform.instance;

  test('$MethodChannelTimeConfigCheckerAndroid is the default instance', () {
    expect(
      initialPlatform,
      isInstanceOf<MethodChannelTimeConfigCheckerAndroid>(),
    );
  });

  test('getPlatformVersion', () async {
    final TimeConfigCheckerAndroid timeConfigCheckerAndroidPlugin =
        TimeConfigCheckerAndroid();
    final MockTimeConfigCheckerAndroidPlatform fakePlatform =
        MockTimeConfigCheckerAndroidPlatform();
    TimeConfigCheckerAndroidPlatform.instance = fakePlatform;

    expect(
      await timeConfigCheckerAndroidPlugin.getTimeConfig(),
      {},
    );
  });
}
