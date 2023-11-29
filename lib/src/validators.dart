import 'enums.dart';

class Validators {
  /// Validates the given [dashPattern].
  ///
  /// Returns `null` if the given [dashPattern] is valid.
  /// [dashPattern] is invalid if
  /// - it is null
  /// - it is empty
  /// - it has a negative element
  /// - it has a single element with value of 0
  static InvalidDashPatternResult? validateDashPattern(
    List<double>? dashPattern,
  ) {
    final dashSet = dashPattern?.toSet();
    if (dashSet == null) return InvalidDashPatternResult.nullDashPattern;
    if (dashSet.isEmpty) return InvalidDashPatternResult.emptyDashPattern;

    if (dashSet.any((element) => element < 0.0)) {
      return InvalidDashPatternResult.negativeDashPattern;
    }

    if (dashSet.length == 1 && dashSet.elementAt(0) == 0.0) {
      return InvalidDashPatternResult.zeroDashPattern;
    }

    return null;
  }
}
