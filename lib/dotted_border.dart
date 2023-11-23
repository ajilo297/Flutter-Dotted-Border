library dotted_border;

import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

part 'dash_painter.dart';

/// Add a dotted border around any [child] widget. The [strokeWidth] property
/// defines the width of the dashed border and [color] determines the stroke
/// paint color. [CircularIntervalList] is populated with the [dashPattern] to
/// render the appropriate pattern. The [radius] property is taken into account
/// only if the [borderType] is [BorderType.RRect]. A [customPath] can be passed in
/// as a parameter if you want to draw a custom shaped border.
class DottedBorder extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets borderPadding;
  final double strokeWidth;
  final Color color;
  final Gradient? gradient;
  final List<double> dashPattern;
  final BorderType borderType;
  final Radius radius;
  final BorderRadius? borderRadius;
  final StrokeCap strokeCap;
  final PathBuilder? customPath;
  final StackFit stackFit;

  DottedBorder({
    required this.child,
    this.color = Colors.black,
    this.gradient,
    this.strokeWidth = 1,
    this.borderType = BorderType.Rect,
    this.dashPattern = const <double>[3, 1],
    this.padding = const EdgeInsets.all(2),
    this.borderPadding = EdgeInsets.zero,
    this.radius = const Radius.circular(0),
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.strokeCap = StrokeCap.butt,
    this.customPath,
    this.stackFit = StackFit.loose,
  }) {
    assert(_isValidDashPattern(dashPattern), 'Invalid dash pattern');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: stackFit,
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: DashedPainter(
              padding: borderPadding,
              strokeWidth: strokeWidth,
              radius: radius,
              borderRadius: borderRadius,
              color: color,
              gradient: gradient,
              borderType: borderType,
              dashPattern: dashPattern,
              customPath: customPath,
              strokeCap: strokeCap,
            ),
          ),
        ),
        Padding(
          padding: padding,
          child: child,
        ),
      ],
    );
  }

  /// Compute if [dashPattern] is valid. The following conditions need to be met
  /// * Cannot be null or empty
  /// * If [dashPattern] has only 1 element, it cannot be 0
  bool _isValidDashPattern(List<double>? dashPattern) {
    Set<double>? _dashSet = dashPattern?.toSet();
    if (_dashSet == null) return false;
    if (_dashSet.length == 1 && _dashSet.elementAt(0) == 0.0) return false;
    if (_dashSet.length == 0) return false;
    return true;
  }
}

/// The different supported BorderTypes
enum BorderType { Circle, RRect, Rect, Oval }
