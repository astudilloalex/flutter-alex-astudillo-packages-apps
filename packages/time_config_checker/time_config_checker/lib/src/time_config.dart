class TimeConfig {
  const TimeConfig({
    this.isAutomaticTime = true,
    this.isAutomaticTimeZone = true,
  });

  final bool isAutomaticTime;
  final bool isAutomaticTimeZone;

  TimeConfig copyWith({
    bool? isAutomaticTime,
    bool? isAutomaticTimeZone,
  }) {
    return TimeConfig(
      isAutomaticTime: isAutomaticTime ?? this.isAutomaticTime,
      isAutomaticTimeZone: isAutomaticTimeZone ?? this.isAutomaticTimeZone,
    );
  }

  factory TimeConfig.fromJson(Map<String, dynamic> json) {
    return TimeConfig(
      isAutomaticTime: json['isAutomaticTime'] as bool? ?? true,
      isAutomaticTimeZone: json['isAutomaticTimeZone'] as bool? ?? true,
    );
  }
}
