import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class DottedUnderlineInputBorder extends InputBorder {
  @override
  final BorderSide borderSide;
  final BorderRadius borderRadius;
  final List<double> dashPattern;
  final StrokeCap strokeCap;

  const DottedUnderlineInputBorder({
    required this.borderSide,
    this.dashPattern = const <double>[3, 1],
    this.strokeCap = StrokeCap.butt,
    required this.borderRadius,
  });

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(0.0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _createDottedPath(rect);
  }

  Path _createDottedPath(Rect rect) {
    final Path path = Path();

    final double bottom = rect.bottom - borderSide.width / 2.0;
    final double left = rect.left;
    final double right = rect.right;
    return dashPath(
      path
        ..moveTo(left, bottom)
        ..lineTo(right, bottom),
      dashArray: CircularIntervalList<double>(dashPattern),
    );
  }

  @override
  void paint(Canvas canvas, Rect rect,
      {double gapExtent = 0.0,
      double gapPercentage = 0.0,
      double? gapStart,
      TextDirection? textDirection}) {
    final Path path = getOuterPath(rect, textDirection: textDirection);
    final Paint paint = borderSide.toPaint()..strokeCap = strokeCap;

    canvas.drawPath(path, paint);
  }

  @override
  InputBorder copyWith({BorderSide? borderSide}) {
    return DottedUnderlineInputBorder(
      borderSide: borderSide ?? this.borderSide,
      // borderType: borderType,
      borderRadius: borderRadius,
    );
  }

  @override
  bool get isOutline => true;

  @override
  InputBorder scale(double t) {
    return DottedUnderlineInputBorder(
      borderSide: borderSide.scale(t),
      // borderType: borderType,
      borderRadius: borderRadius,
    );
  }
}
