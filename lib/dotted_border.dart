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
    this.animation,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The dotted border options.
  final DottedBorderOptions options;

  /// Whether the border should ignore pointer events.
  final bool ignoring = true;

  /// The animation for the dotted border.
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    final radius = switch (options) {
      RoundedRectDottedBorderOptions options => options.radius,
      _ => Radius.zero,
    };

    final customPath = switch (options) {
      CustomPathDottedBorderOptions options => options.customPath,
      _ => null,
    };

    return Stack(
      fit: options.stackFit,
      children: <Widget>[
        Padding(padding: options.padding, child: child),
        Positioned.fill(
          child: IgnorePointer(
            ignoring: ignoring,
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
                animation: animation,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
