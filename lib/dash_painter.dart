part of 'dotted_border.dart';

typedef PathBuilder = Path Function(Size);

class DashedPainter extends CustomPainter {
  final double strokeWidth;
  final List<double> dashPattern;
  final Color color;
  final Gradient? gradient;
  final BorderType borderType;
  final BorderRadius borderRadius;
  final StrokeCap strokeCap;
  final PathBuilder? customPath;
  final EdgeInsets padding;
  final BorderPattern borderStyle;

  DashedPainter({
    this.strokeWidth = 2,
    this.dashPattern = const <double>[3, 1],
    this.color = Colors.black,
    this.gradient,
    this.borderType = BorderType.Rect,
    this.borderRadius = const BorderRadius.all(Radius.zero),
    this.strokeCap = StrokeCap.butt,
    this.customPath,
    this.padding = EdgeInsets.zero,
    this.borderStyle =
        BorderPattern.dashed, // Add borderStyle with default value
  }) {
    assert(dashPattern.isNotEmpty, 'Dash Pattern cannot be empty');
  }

  @override
  void paint(Canvas canvas, Size originalSize) {
    final Size size;
    if (padding == EdgeInsets.zero) {
      size = originalSize;
    } else {
      canvas.translate(padding.left, padding.top);
      size = Size(
        originalSize.width - padding.horizontal,
        originalSize.height - padding.vertical,
      );
    }

    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap
      ..style = PaintingStyle.stroke;

    if (gradient != null) {
      final rect = Offset.zero & size;
      paint.shader = gradient!.createShader(rect);
    } else {
      paint.color = color;
    }

    Path path;
    if (customPath != null) {
      path = customPath!(size);
    } else {
      path = _getPath(size);
    }

    if (borderStyle == BorderPattern.dotted) {
      path = _createDottedPath(path);
    } else if (borderStyle == BorderPattern.dashed) {
      path = _createDashedPath(path);
    }

    canvas.drawPath(path, paint);
  }

  Path _createDashedPath(Path path) {
    return dashPath(path, dashArray: CircularIntervalList(dashPattern));
  }

  Path _createDottedPath(Path path) {
    final Path dottedPath = Path();
    final double dashWidth = strokeWidth; // Each dot's diameter
    final double dashSpacing = strokeWidth * 2; // Space between dots

    // Iterate over the entire path and add circular dots
    final PathMetrics pathMetrics = path.computeMetrics();
    for (final PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;

      while (distance < pathMetric.length) {
        final Tangent? tangent = pathMetric.getTangentForOffset(distance);

        if (tangent != null) {
          // Add a circular dot at the current tangent position
          dottedPath.addOval(Rect.fromCircle(
            center: tangent.position,
            radius: dashWidth / 2,
          ));
        }

        // Move the distance forward by the width of the dot + the spacing
        distance += dashWidth + dashSpacing;
      }
    }

    return dottedPath;
  }

  // Path _createDottedPath(Path path) {
  //   final List<double> dotPattern = [strokeWidth, strokeWidth * 2];
  //   return dashPath(path, dashArray: CircularIntervalList(dotPattern));
  // }

  Path _getPath(Size size) {
    Path path;
    switch (borderType) {
      case BorderType.Circle:
        path = _getCirclePath(size);
        break;
      case BorderType.RRect:
        path = _getRRectPath(size, borderRadius);
        break;
      case BorderType.Rect:
        path = _getRectPath(size);
        break;
      case BorderType.Oval:
        path = _getOvalPath(size);
        break;
    }
    return path;
  }

  Path _getCirclePath(Size size) {
    double w = size.width;
    double h = size.height;
    double s = size.shortestSide;

    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            w > s ? (w - s) / 2 : 0,
            h > s ? (h - s) / 2 : 0,
            s,
            s,
          ),
          Radius.circular(s / 2),
        ),
      );
  }

  Path _getRRectPath(Size size, BorderRadius borderRadius) {
    return Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
            0,
            0,
            size.width,
            size.height,
          ),
          topLeft: borderRadius.topLeft,
          topRight: borderRadius.topRight,
          bottomLeft: borderRadius.bottomLeft,
          bottomRight: borderRadius.bottomRight,
        ),
      );
  }

  Path _getRectPath(Size size) {
    return Path()
      ..addRect(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );
  }

  Path _getOvalPath(Size size) {
    return Path()
      ..addOval(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );
  }

  @override
  bool shouldRepaint(DashedPainter oldDelegate) {
    return oldDelegate.strokeWidth != this.strokeWidth ||
        oldDelegate.color != this.color ||
        oldDelegate.dashPattern != this.dashPattern ||
        oldDelegate.padding != this.padding ||
        oldDelegate.borderType != this.borderType ||
        oldDelegate.borderStyle != this.borderStyle;
  }
}
