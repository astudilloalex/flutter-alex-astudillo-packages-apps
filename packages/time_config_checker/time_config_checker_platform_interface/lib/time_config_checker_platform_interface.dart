import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Base interface for checking time configuration on different platforms.
///
/// The [TimeConfigCheckerPlatformInterface] extends [PlatformInterface] to ensure
/// that platform implementations are valid and secure. Any platform-specific
/// implementation that wants to provide time configuration checking functionality
/// must extend this class.
abstract class TimeConfigCheckerPlatformInterface extends PlatformInterface {
  /// Constructor that initializes the interface with a unique token.
  ///
  /// The token is used to verify the authenticity of the implementation.
  TimeConfigCheckerPlatformInterface() : super(token: _token);

  /// Unique token used to verify that the implementation is valid.
  static final Object _token = Object();

  /// Default instance of [TimeConfigCheckerPlatformInterface].
  ///
  /// By default, it is set to an instance of [DefaultTimeConfigChecker],
  /// which should be overridden by a concrete platform-specific implementation.
  static TimeConfigCheckerPlatformInterface _instance =
      DefaultTimeConfigChecker();

  /// Gets the current instance of [TimeConfigCheckerPlatformInterface].
  ///
  /// This instance is used to access the platform-specific time configuration functions.
  static TimeConfigCheckerPlatformInterface get instance => _instance;

  /// Sets a new instance of [TimeConfigCheckerPlatformInterface].
  ///
  /// Before assignment, the instance's token is verified to ensure the
  /// implementation is valid.
  static set instance(TimeConfigCheckerPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Retrieves a map of time configuration settings.
  ///
  /// Returns a [Future<Map<String, bool>>] where the keys represent
  /// different settings (e.g., `'isTimeAutomatic'`) and the values
  /// indicate the state of those settings.
  /// This method must be implemented by each platform.
  Future<Map<String, bool>> getTimeConfig();
}

/// Default implementation of [TimeConfigCheckerPlatformInterface].
///
/// This class throws an [UnimplementedError] for each of its methods,
/// indicating that a concrete implementation must be provided for each platform.
class DefaultTimeConfigChecker extends TimeConfigCheckerPlatformInterface {
  @override
  Future<Map<String, bool>> getTimeConfig() {
    throw UnimplementedError(
        'DefaultTimeConfigChecker.getTimeConfig() has not been implemented.');
  }
}
