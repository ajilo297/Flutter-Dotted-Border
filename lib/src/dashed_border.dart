import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'dash_path.dart';

/// {@template DashedBorder}
/// A border of a box that is drawn with dashes instead of a solid line.
///
/// You apply this border to a [DecoratedBox] or a [Container] widget.
///
/// Example:
/// ```dart
/// Container(
///  decoration: BoxDecoration(
///   border: DashedBorder(dashPattern: [5, 3]),
///  ),
/// ),
/// ```
/// 
/// The [dashPattern] defines the lengths of the dashes and gaps in the border.
/// {@endtemplate}
class DashedBorder extends Border {
  /// {@macro DashedBorder}
  const DashedBorder({this.dashPattern = const <double>[3, 1], BorderSide side = BorderSide.none})
    : super.fromBorderSide(side);

  /// The pattern of dashes and gaps to use when drawing the border.
  /// The pattern is a list of numbers where each number represents the length of a dash or gap.
  /// For example, [3, 1] means a dash of 3 pixels followed by a gap of 1 pixel.
  /// The pattern is repeated to fill the entire border.
  final List<double> dashPattern;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    assert(isUniform, 'DashedBorder can only paint uniform borders');
    switch (top.style) {
      case BorderStyle.none:
        return;
      case BorderStyle.solid:
        switch (shape) {
          case BoxShape.circle:
            assert(
              borderRadius == null,
              'A borderRadius cannot be given when shape is a BoxShape.circle.',
            );
            super.paint(canvas, rect, textDirection: textDirection, shape: shape);
          case BoxShape.rectangle:
            final borderPath = Path();
            if (borderRadius != null && borderRadius != BorderRadius.zero) {
              borderPath.addRRect(borderRadius.toRRect(rect).inflate(top.strokeOffset));
            } else {
              borderPath.addRect(rect.inflate(top.strokeOffset));
            }
            DashedBorder._paintUniformBorderWithPath(canvas, top, borderPath, dashPattern);
        }
    }
  }

  static void _paintUniformBorderWithPath(
    Canvas canvas,
    BorderSide side,
    Path basePath,
    List<double> dashPattern,
  ) {
    assert(side.style != BorderStyle.none, 'Cannot paint a dashed border with BorderStyle.none');
    final paint =
        Paint()
          ..color = side.color
          ..strokeWidth = side.width
          ..style = PaintingStyle.stroke;
    final width = side.width;
    if (width != 0.0) {
      canvas.drawPath(dashPath(basePath, dashArray: CircularIntervalList(dashPattern)), paint);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DashedBorder && other.top == top && listEquals(other.dashPattern, dashPattern);
  }

  @override
  int get hashCode => Object.hash(top, Object.hashAll(dashPattern));
}
