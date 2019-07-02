library dotted_border;

import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

import 'dart:math' as math;

class DottedBorder extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final List<double> gapSpacing;
  final Widget child;
  final EdgeInsets padding;

  DottedBorder({
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.gapSpacing = const [4, 2, 2, 2],
    this.padding = const EdgeInsets.all(8.0),
    @required this.child,
  }) {
    assert(child != null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(strokeWidth / 2),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: CustomPaint(
                painter: _DashRectPainter(
                  color: color,
                  strokeWidth: strokeWidth,
                  gapSpacing: gapSpacing,
                ),
              ),
            ),
            Padding(
              padding: padding,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class _DashRectPainter extends CustomPainter {
  double strokeWidth;
  List<double> gapSpacing;
  Color color;

  _DashRectPainter({
    this.strokeWidth = 3.0,
    this.gapSpacing,
    this.color = Colors.black,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path topPath = getPath(
      a: math.Point(0, 0),
      b: math.Point(x, 0),
      gapSpacing: CircularIntervalList(gapSpacing),
    );
    Path rightPath = getPath(
      a: math.Point(x, 0),
      b: math.Point(x, y),
      gapSpacing: CircularIntervalList(gapSpacing),
    );
    Path bottomPath = getPath(
      a: math.Point(x, y),
      b: math.Point(0, y),
      gapSpacing: CircularIntervalList(gapSpacing),
    );
    Path leftPath = getPath(
      a: math.Point(0, y),
      b: math.Point(0, 0),
      gapSpacing: CircularIntervalList(gapSpacing),
    );

    canvas.drawPath(topPath, paint);
    canvas.drawPath(rightPath, paint);
    canvas.drawPath(bottomPath, paint);
    canvas.drawPath(leftPath, paint);
  }

  Path getPath({
    @required math.Point<double> a,
    @required math.Point<double> b,
    CircularIntervalList<double> gapSpacing,
  }) {
    Path path = Path()
      ..moveTo(a.x, a.y)
      ..lineTo(b.x, b.y);

    return getDashedPath(path, gapSpacing);
  }

  Path getDashedPath(Path source, CircularIntervalList<double> gapSpacing) {
    return dashPath(source, dashArray: gapSpacing);
  }

  @override
  bool shouldRepaint(_DashRectPainter oldDelegate) {
    return oldDelegate.strokeWidth != this.strokeWidth ||
        oldDelegate.color != this.color ||
        oldDelegate.gapSpacing != this.gapSpacing;
  }
}
