# Dotted Border

[![pub package](https://img.shields.io/badge/pub-1.0.0-orange.svg)](https://pub.dev/packages/dotted_border)

A flutter package to easily added dotted borders around widgets.

## Usage

To use this package, add `dotted_border` as a dependency in your `pubspec.yaml` file.

### Example

Wrap `DottedBorder` widget around the child widget

```dart
DottedBorder(
    color: Colors.black,
    strokeWidth: 1,
    child: FlutterLogo(size: 148),
)
```

### BorderTypes

This package supports the following border types at the moment
 * RectBorder
 * RRectBorder
 * CircleBorder
 * OvalBorder

### Dash Pattern

Now you can also specify the Dash Sequence by passing in an Array of Doubles

```
DottedBorder(
    dashPattern: [6, 3, 2, 3] 
    child: ...
);
```

The above code block will render a dashed border with the following pattern:

* 6 pixel wide dash
* 3 pixel wide space
* 2 pixel wide dash
* 3 pixel wide space

### Credits

* [Flutter Path Drawing](https://github.com/dnfield/flutter_path_drawing) - [Dan Field](https://github.com/dnfield)