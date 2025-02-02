import 'package:flutter_test/flutter_test.dart';
import 'package:time_config_checker_platform_interface/time_config_checker_platform_interface.dart';

/// A mock implementation of [TimeConfigCheckerPlatformInterface].
///
/// This class is used primarily for testing purposes or during development
/// when you need to simulate the behavior of the platform-specific time
/// configuration checker without relying on actual device settings.
///
/// The [getTimeConfig] method returns a predefined set of time configuration
/// values:
/// - `'isAutomaticTime'`: Indicates whether automatic time setting is enabled.
///   In this mock, it is set to `true`.
/// - `'isAutomaticTimeZone'`: Indicates whether automatic time zone setting is
///   enabled. In this mock, it is set to `false`.
///
/// Example usage:
/// ```dart
/// final timeChecker = MockTimeChecker();
/// final config = await timeChecker.getTimeConfig();
/// print(config['isAutomaticTime']); // true
/// print(config['isAutomaticTimeZone']); // false
/// ```
class MockTimeChecker extends TimeConfigCheckerPlatformInterface {
  /// Creates an instance of [MockTimeChecker].
  ///
  /// Calls the constructor of the superclass [TimeConfigCheckerPlatformInterface].
  MockTimeChecker() : super();

  @override
  Future<Map<String, bool>> getTimeConfig() async {
    return {
      'isAutomaticTime': true,
      'isAutomaticTimeZone': false,
    };
  }
}

void main() {
  group('TimeConfigCheckerPlatformInterface', () {
    test('The default instance is DefaultTimeConfigChecker.', () {
      expect(
        TimeConfigCheckerPlatformInterface.instance,
        isA<DefaultTimeConfigChecker>(),
      );
    });

    test('getTimeConfig on default instance throws error.', () {
      expect(
        () => TimeConfigCheckerPlatformInterface.instance.getTimeConfig(),
        throwsA(isA<UnimplementedError>()),
      );
    });

    test('Setting a valid instance does not throw errors.', () {
      final mock = MockTimeChecker();
      TimeConfigCheckerPlatformInterface.instance = mock;
      expect(TimeConfigCheckerPlatformInterface.instance, mock);
    });

    test('Calling getTimeConfig on the mocked instance works.', () async {
      final mock = MockTimeChecker();
      TimeConfigCheckerPlatformInterface.instance = mock;

      final result = await mock.getTimeConfig();
      expect(result, {
        'isAutomaticTime': true,
        'isAutomaticTimeZone': false,
      });
    });
  });
}
