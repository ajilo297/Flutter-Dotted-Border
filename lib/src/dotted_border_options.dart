import 'package:flutter/material.dart';

import 'enums.dart';

typedef PathBuilder = Path Function(Size size);

/// Provides options for customising the dotted border.
///
/// Allowed border options:
/// - [CustomPathDottedBorderOptions]
/// - [RoundedRectDottedBorderOptions]
/// - [RectDottedBorderOptions]
/// - [CircularDottedBorderOptions]
/// - [OvalDottedBorderOptions]
sealed class DottedBorderOptions {
  const DottedBorderOptions({
    required this.borderType,
    this.padding = const EdgeInsets.all(2),
    this.borderPadding = EdgeInsets.zero,
    this.strokeWidth = 1,
    this.color = Colors.black,
    this.dashPattern = const <double>[3, 1],
    this.strokeCap = StrokeCap.butt,
    this.stackFit = StackFit.loose,
    this.gradient,
  });

  /// The padding between the dotted border and the child
  final EdgeInsets padding;

  /// The padding between the dotted border and parent widget
  final EdgeInsets borderPadding;

  /// The thickness of the dotted border
  final double strokeWidth;

  /// The color of the dotted border.
  /// Will be overridden by [gradient] if provided
  final Color color;

  /// The gradient of the dotted border.
  final Gradient? gradient;

  /// The dash pattern to be drawn.
  /// `[1, 1]` will draw a dash and a gap of 1 unit each.
  final List<double> dashPattern;

  /// The [strokeCap] will determine the shape of the line endings for the
  /// border
  final StrokeCap strokeCap;

  /// The fit provided to the parent stack
  final StackFit stackFit;

  /// The type of border to be drawn
  /// - [BorderType.Circle]
  /// - [BorderType.RRect]
  /// - [BorderType.Rect]
  /// - [BorderType.Oval]
  /// - [null] for custom path
  final BorderType? borderType;
}

/// Provides options for drawing a dotted border with a custom path.
final class CustomPathDottedBorderOptions extends DottedBorderOptions {
  const CustomPathDottedBorderOptions({
    required this.customPath,
    super.borderPadding,
    super.padding,
    super.strokeWidth,
    super.color,
    super.gradient,
    super.dashPattern,
    super.stackFit,
    super.strokeCap,
  }) : super(borderType: null);

  /// The custom path to be drawn
  final PathBuilder customPath;
}

/// Provides options for drawing a dotted border with a rounded rectangle.
final class RoundedRectDottedBorderOptions extends DottedBorderOptions {
  const RoundedRectDottedBorderOptions({
    required this.radius,
    super.borderPadding,
    super.padding,
    super.strokeWidth,
    super.color,
    super.gradient,
    super.dashPattern,
    super.stackFit,
    super.strokeCap,
  }) : super(borderType: BorderType.RRect);

  /// The radius of the rounded rectangle
  final Radius radius;
}

/// Provides options for drawing a dotted border with a rectangle.
final class RectDottedBorderOptions extends DottedBorderOptions {
  const RectDottedBorderOptions({
    super.borderPadding,
    super.padding,
    super.strokeWidth,
    super.color,
    super.gradient,
    super.dashPattern,
    super.stackFit,
    super.strokeCap,
  }) : super(borderType: BorderType.Rect);
}

/// Provides options for drawing a dotted border with a circle.
final class CircularDottedBorderOptions extends DottedBorderOptions {
  const CircularDottedBorderOptions({
    super.borderPadding,
    super.padding,
    super.strokeWidth,
    super.color,
    super.gradient,
    super.dashPattern,
    super.stackFit,
    super.strokeCap,
  }) : super(borderType: BorderType.Circle);
}

/// Provides options for drawing a dotted border with an oval.
final class OvalDottedBorderOptions extends DottedBorderOptions {
  const OvalDottedBorderOptions({
    super.borderPadding,
    super.padding,
    super.strokeWidth,
    super.color,
    super.gradient,
    super.dashPattern,
    super.stackFit,
    super.strokeCap,
  }) : super(borderType: BorderType.Oval);
}
