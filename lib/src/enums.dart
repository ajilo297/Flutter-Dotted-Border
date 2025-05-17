enum BorderType { Circle, RRect, Rect, Oval }

enum InvalidDashPatternResult {
  nullDashPattern,
  emptyDashPattern,
  negativeDashPattern,
  zeroDashPattern;

  String get message => switch (this) {
        InvalidDashPatternResult.nullDashPattern =>
          'Dash pattern cannot be null.',
        InvalidDashPatternResult.emptyDashPattern =>
          'Dash pattern cannot be empty.',
        InvalidDashPatternResult.negativeDashPattern =>
          'Dash pattern cannot have negative values.',
        InvalidDashPatternResult.zeroDashPattern =>
          'Dash pattern cannot contain all zeros.'
      };
}
