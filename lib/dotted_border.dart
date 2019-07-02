library dotted_border;

import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

part 'dash_painter.dart';

class DottedBorder extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double strokeWidth;
  final Color color;
  final List<double> dashPattern;
  final BorderType borderType;
  final Radius radius;

  DottedBorder({
    @required this.child,
    this.color,
    this.strokeWidth = 1,
    this.borderType = BorderType.Rect,
    this.dashPattern = const <double>[3, 1],
    this.padding = const EdgeInsets.all(2),
    this.radius = const Radius.circular(0),
  }) {
    assert(child != null);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: _DashPainter(
              strokeWidth: strokeWidth,
              radius: radius,
              color: color,
              borderType: borderType,
              dashPattern: dashPattern,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

enum BorderType { Circle, RRect, Rect, Oval }
