enum BorderType { Circle, RRect, Rect, Oval }

enum InvalidDashPatternResult {
  nullDashPattern,
  emptyDashPattern,
  negativeDashPattern,
  zeroDashPattern;

  String get message {
    switch (this) {
      case InvalidDashPatternResult.nullDashPattern:
        return 'Dash pattern cannot be null.';
      case InvalidDashPatternResult.emptyDashPattern:
        return 'Dash pattern cannot be empty.';
      case InvalidDashPatternResult.negativeDashPattern:
        return 'Dash pattern cannot have negative values.';
      case InvalidDashPatternResult.zeroDashPattern:
        return 'Dash pattern cannot contain all zeros.';
    }
  }
}
