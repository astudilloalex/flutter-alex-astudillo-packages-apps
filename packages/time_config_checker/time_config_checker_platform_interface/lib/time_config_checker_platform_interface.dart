import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class TimeConfigCheckerPlatformInterface extends PlatformInterface {
  TimeConfigCheckerPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static TimeConfigCheckerPlatformInterface _instance =
      DefaultTimeConfigChecker();

  static TimeConfigCheckerPlatformInterface get instance => _instance;

  static set instance(TimeConfigCheckerPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isTimeAutomatic();
}

class DefaultTimeConfigChecker extends TimeConfigCheckerPlatformInterface {
  @override
  Future<bool> isTimeAutomatic() {
    throw UnimplementedError('isTimeAutomatic() has not been implemented.');
  }
}
