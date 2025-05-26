import 'dart:ui';

/// Creates a new path that is drawn from the segments of `source`.
///
/// Dash intervals are controlled by the `dashArray` - see
/// [CircularIntervalList] for examples.
///
/// `dashOffset` specifies an initial starting point for the dashing.
///
/// Passing a `source` that is an empty path will return an empty path.
///
/// Passing a non-null `animationValue` makes the path shift along its length by
/// an amount equal to the length of a `dashArray` times `animationValue`.
Path dashPath(
  Path source, {
  required CircularIntervalList<double> dashArray,
  double? animationValue,
  DashOffset? dashOffset,
}) {
  dashOffset = dashOffset ?? const DashOffset.absolute(0.0);

  final Path dest = Path();
  for (final PathMetric metric in source.computeMetrics()) {
    double distance = dashOffset._calculate(metric.length);
    // distance is decreased by the length of the last dash that is clipped. This ensures a smooth animation
    final totalDashes = (metric.length / dashArray.total * dashArray._vals.length).ceil();
    final clippedLength = totalDashes * dashArray.total - metric.length;
    distance -= clippedLength;

    bool draw = true;
    bool appliedAnimation = false;

    // calculate a new value for dashArray that fits exactly in the length of the path. This avoids an abrupt clip where the path's end meets it's beginning
    final totalArrays = metric.length / dashArray.total;
    final neededArrays = totalArrays.ceil();
    final neededArrayLength = metric.length / neededArrays;
    final dashCorrection = (dashArray.total - neededArrayLength) / dashArray._vals.length;
    final adjustedDashArray =
        CircularIntervalList(dashArray._vals.map((e) => e - dashCorrection).toList());

    while (distance < metric.length) {
      final double len = adjustedDashArray.next;

      // add some empty space at the beginning to shift the whole path
      if (!appliedAnimation && animationValue != null) {
        distance += adjustedDashArray.total * animationValue;
        appliedAnimation = true;
      }

      if (draw) {
        dest.addPath(metric.extractPath(distance, distance + len), Offset.zero);
      }
      distance += len;
      draw = !draw;
    }
  }

  return dest;
}

enum _DashOffsetType { Absolute, Percentage }

/// Specifies the starting position of a dash array on a path, either as a
/// percentage or absolute value.
///
/// The internal value will be guaranteed to not be null.
class DashOffset {
  /// Create a DashOffset that will be measured as a percentage of the length
  /// of the segment being dashed.
  ///
  /// `percentage` will be clamped between 0.0 and 1.0.
  DashOffset.percentage(double percentage)
      : _rawVal = percentage.clamp(0.0, 1.0),
        _dashOffsetType = _DashOffsetType.Percentage;

  /// Create a DashOffset that will be measured in terms of absolute pixels
  /// along the length of a [Path] segment.
  const DashOffset.absolute(double start)
      : _rawVal = start,
        _dashOffsetType = _DashOffsetType.Absolute;

  final double _rawVal;
  final _DashOffsetType _dashOffsetType;

  double _calculate(double length) {
    return _dashOffsetType == _DashOffsetType.Absolute ? _rawVal : length * _rawVal;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is DashOffset &&
        other._rawVal == _rawVal &&
        other._dashOffsetType == _dashOffsetType;
  }

  @override
  int get hashCode => _rawVal.hashCode ^ _dashOffsetType.hashCode;
}

/// A circular array of dash offsets and lengths.
///
/// For example, the array `[5, 10]` would result in dashes 5 pixels long
/// followed by blank spaces 10 pixels long.  The array `[5, 10, 5]` would
/// result in a 5 pixel dash, a 10 pixel gap, a 5 pixel dash, a 5 pixel gap,
/// a 10 pixel dash, etc.
///
/// Note that this does not quite conform to an [Iterable<T>], because it does
/// not have a moveNext.
class CircularIntervalList<T extends num> {
  // if the interval is not symmetric, we make it so
  CircularIntervalList(List<T> vals) : _vals = vals.length.isEven ? vals : [...vals, ...vals];

  final List<T> _vals;
  int _idx = 0;
  late final T total = _vals.reduce((value, element) => value + element as T);

  T get next {
    if (_idx >= _vals.length) {
      _idx = 0;
    }
    return _vals[_idx++];
  }
}
