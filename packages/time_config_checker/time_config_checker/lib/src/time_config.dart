/// A model class representing the time configuration settings of a device.
///
/// This class holds information about whether the device's time and
/// time zone settings are set automatically.
class TimeConfig {
  /// Creates a [TimeConfig] instance with the given settings.
  ///
  /// [isAutomaticTime] indicates if the device is set to update its
  /// time automatically. Defaults to `true`.
  ///
  /// [isAutomaticTimeZone] indicates if the device is set to update
  /// its time zone automatically. Defaults to `true`.
  const TimeConfig({
    this.isAutomaticTime = true,
    this.isAutomaticTimeZone = true,
  });

  /// Indicates whether the device's time is set automatically.
  ///
  /// Defaults to `true` if not specified.
  final bool isAutomaticTime;

  /// Indicates whether the device's time zone is set automatically.
  ///
  /// Defaults to `true` if not specified.
  final bool isAutomaticTimeZone;

  /// Returns a copy of this [TimeConfig] with the given fields replaced
  /// by new values.
  ///
  /// [isAutomaticTime] and [isAutomaticTimeZone] are optional and will
  /// fall back to the current values if not provided.
  ///
  /// Example:
  /// ```dart
  /// final config = TimeConfig(isAutomaticTime: false);
  /// final updatedConfig = config.copyWith(isAutomaticTimeZone: false);
  /// ```
  TimeConfig copyWith({
    bool? isAutomaticTime,
    bool? isAutomaticTimeZone,
  }) {
    return TimeConfig(
      isAutomaticTime: isAutomaticTime ?? this.isAutomaticTime,
      isAutomaticTimeZone: isAutomaticTimeZone ?? this.isAutomaticTimeZone,
    );
  }

  /// Creates a [TimeConfig] instance from a JSON map.
  ///
  /// The [json] map should contain keys `isAutomaticTime` and
  /// `isAutomaticTimeZone`. If these keys are missing, they default
  /// to `true`.
  ///
  /// Example:
  /// ```dart
  /// final json = {'isAutomaticTime': false, 'isAutomaticTimeZone': true};
  /// final config = TimeConfig.fromJson(json);
  /// ```
  factory TimeConfig.fromJson(Map<String, dynamic> json) {
    return TimeConfig(
      isAutomaticTime: json['isAutomaticTime'] as bool? ?? true,
      isAutomaticTimeZone: json['isAutomaticTimeZone'] as bool? ?? true,
    );
  }
}
