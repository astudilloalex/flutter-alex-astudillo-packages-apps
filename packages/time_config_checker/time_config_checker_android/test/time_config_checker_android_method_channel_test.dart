import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_config_checker_android/time_config_checker_android_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MethodChannelTimeConfigCheckerAndroid platform =
      MethodChannelTimeConfigCheckerAndroid();
  const MethodChannel channel = MethodChannel('time_config_checker_android');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
