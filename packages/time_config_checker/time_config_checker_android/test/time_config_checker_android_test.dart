import 'package:flutter/services.dart' show MethodChannel, PlatformException;
import 'package:flutter_test/flutter_test.dart';
import 'package:time_config_checker_android/time_config_checker_android.dart';

const MethodChannel _channel = MethodChannel('time_config_checker_android');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final TimeConfigCheckerAndroid timeConfigChecker = TimeConfigCheckerAndroid();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_channel, (call) async {
      if (call.method == 'getTimeConfig') {
        return {
          'isAutomaticTime': true,
          'isAutomaticTimeZone': false,
        };
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_channel, null);
  });

  test('getTimeConfig should return correct map from platform', () async {
    final Map<String, bool> result = await timeConfigChecker.getTimeConfig();

    expect(result, {'isAutomaticTime': true, 'isAutomaticTimeZone': false});
  });

  test('getTimeConfig should handle empty response', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_channel, (call) async {
      return {};
    });

    final result = await timeConfigChecker.getTimeConfig();
    expect(result, {});
  });

  test('getTimeConfig should throw an exception on error', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_channel, (call) async {
      throw PlatformException(code: 'ERROR', message: 'Error occurred');
    });

    expect(
      () async => await timeConfigChecker.getTimeConfig(),
      throwsA(isA<PlatformException>()),
    );
  });
}
