library dotted_border;

import 'package:flutter/material.dart';

import 'src/dashed_painter.dart';
import 'src/dotted_border_options.dart';

export 'src/dotted_border_options.dart';

/// A widget that draws a dotted border around its child.
///
/// The [child] is painted on top of the border.
/// Customization of the border is achieved by specifying the desired [options].
class DottedBorder extends StatelessWidget {
  const DottedBorder({
    super.key,
    required this.child,
    this.options = const RectDottedBorderOptions(),
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The dotted border options.
  final DottedBorderOptions options;

  @override
  Widget build(BuildContext context) {
    final radius = options is RoundedRectDottedBorderOptions
        ? (options as RoundedRectDottedBorderOptions).radius
        : Radius.zero;

    final customPath = options is CustomPathDottedBorderOptions
        ? (options as CustomPathDottedBorderOptions).customPath
        : null;

    return Stack(
      fit: options.stackFit,
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: DashedPainter(
              padding: options.borderPadding,
              strokeWidth: options.strokeWidth,
              radius: radius,
              color: options.color,
              gradient: options.gradient,
              borderType: options.borderType,
              dashPattern: options.dashPattern,
              customPath: customPath,
              strokeCap: options.strokeCap,
            ),
          ),
        ),
        Padding(
          padding: options.padding,
          child: child,
        ),
      ],
    );
  }
}
