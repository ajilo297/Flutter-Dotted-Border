import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'dash_path.dart';
import 'enums.dart';
import 'validators.dart';

/// A painter that draws a dashed line.
class DashedPainter extends CustomPainter {
  const DashedPainter({
    this.strokeWidth = 2,
    this.dashPattern = const <double>[3, 1],
    this.color = Colors.black,
    this.gradient,
    this.borderType,
    this.radius = const Radius.circular(0),
    this.strokeCap = StrokeCap.butt,
    this.customPath,
    this.padding = EdgeInsets.zero,
    this.animation,
  }) : super(repaint: animation);

  /// The thickness of the dashed line
  final double strokeWidth;

  /// The dash pattern to be drawn.
  final List<double> dashPattern;

  /// The color of the dashed line.
  final Color color;

  /// The gradient of the dashed line. Will override [color] if provided.
  final Gradient? gradient;

  /// The type of border to be drawn
  final BorderType? borderType;

  /// The radius of the rounded corners
  final Radius radius;

  /// The stroke cap of the dashed line
  final StrokeCap strokeCap;

  /// Provides the custom path to be drawn
  /// Will override [borderType] if provided.
  final PathBuilder? customPath;

  /// The padding between the dashed line and the child
  final EdgeInsets padding;

  /// The animation for the dash pattern.
  final Animation<double>? animation;

  @override
  void paint(Canvas canvas, Size originalSize) {
    final Size size;

    canvas.translate(padding.left, padding.top);
    size = Size(
      originalSize.width - padding.horizontal,
      originalSize.height - padding.vertical,
    );

    Paint paint =
        Paint()
          ..strokeWidth = strokeWidth
          ..strokeCap = strokeCap
          ..style = PaintingStyle.stroke;

    if (gradient != null) {
      final rect = Offset.zero & size;
      paint.shader = gradient!.createShader(rect);
    } else {
      paint.color = color;
    }

    Path _path = customPath?.call(size) ?? _getPath(size);

    final result = Validators.validateDashPattern(dashPattern);
    if (result != null) {
      throw ArgumentError(result.message);
    }

    canvas.drawPath(
      dashPath(
        _path,
        dashArray: CircularIntervalList(dashPattern),
        animationValue: animation?.value,
      ),
      paint,
    );
  }

  /// Returns the path to be drawn based on the [borderType]
  Path _getPath(Size size) => switch (borderType) {
    BorderType.RRect => size.toRoundedRectangularPath(radius),
    BorderType.Oval => size.toOvalPath(),
    BorderType.Circle => size.toCirclePath(),
    _ => size.toRectangularPath(),
  };

  @override
  bool shouldRepaint(DashedPainter oldDelegate) =>
      oldDelegate.strokeWidth != this.strokeWidth ||
      oldDelegate.dashPattern != this.dashPattern ||
      oldDelegate.color != this.color ||
      oldDelegate.gradient != this.gradient ||
      oldDelegate.borderType != this.borderType ||
      oldDelegate.radius != this.radius ||
      oldDelegate.strokeCap != this.strokeCap ||
      oldDelegate.customPath != this.customPath ||
      oldDelegate.padding != this.padding;
}

/// Provides extension methods on [Size] to convert it to a path.
extension _SizeToPathExtension on Size {
  /// Returns a rectangular path of the given size.
  Path toRectangularPath() =>
      Path()..addRect(Rect.fromLTWH(0, 0, width, height));

  /// Returns a rounded rectangular path of the given size and radius.
  Path toRoundedRectangularPath(Radius radius) =>
      Path()..addRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, width, height), radius),
      );

  /// Returns an oval path of the given size.
  Path toOvalPath() => Path()..addOval(Rect.fromLTWH(0, 0, width, height));

  /// Returns a circular path of the given size.
  Path toCirclePath() =>
      Path()..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            width > shortestSide ? (width - shortestSide) / 2 : 0,
            height > shortestSide ? (height - shortestSide) / 2 : 0,
            shortestSide,
            shortestSide,
          ),
          Radius.circular(shortestSide / 2),
        ),
      );
}
