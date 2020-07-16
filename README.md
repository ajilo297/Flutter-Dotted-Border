# Dotted Border

[![pub package](https://img.shields.io/badge/pub-1.0.6-blue.svg)](https://pub.dev/packages/dotted_border)

A flutter package to easily added dotted borders around widgets.

### Installing

To use this package, add `dotted_border` as a dependency in your `pubspec.yaml` file.

### Usage

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

#### Example

```dart
return DottedBorder(
  borderType: BorderType.RRect,
  radius: Radius.circular(12),
  padding: EdgeInsets.all(6),
  child: ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    child: Container(
      height: 200,
      width: 120,
      color: Colors.amber,
    ),
  ),
);
```

### Dash Pattern

Now you can also specify the Dash Sequence by passing in an Array of Doubles

#### Example
```dart
DottedBorder(
    dashPattern: [6, 3, 2, 3], 
    child: ...
);
```

The above code block will render a dashed border with the following pattern:

* 6 pixel wide dash
* 3 pixel wide space
* 2 pixel wide dash
* 3 pixel wide space

### Custom Path Border

You can also specify any path as the `customPath` property when initializing the DottedBorderWidget, and it will draw it for you using the provided dash pattern.

#### Example

```dart
Path customPath = Path()
  ..moveTo(20, 20)
  ..lineTo(50, 100)
  ..lineTo(20, 200)
  ..lineTo(100, 100)
  ..lineTo(20, 20);

return DottedBorder(
  customPath: (size) => customPath, // PathBuilder
  color: Colors.indigo,
  dashPattern: [8, 4],
  strokeWidth: 2,
  child: Container(
    height: 220,
    width: 120,
    color: Colors.green.withAlpha(20),
  ),
);
```

### Stroke Cap

> PR submitted by [Tarekk Mohamed Abdalla](https://github.com/TarekkMA)

You can set a [`StrokeCap`](https://api.flutter.dev/flutter/dart-ui/StrokeCap-class.html) to the border line endings. It can take three values

* StrokeCap.Round
* StrokeCap.Square
* StrokeCap.Butt

#### Output

![Flutter dotted border image](assets/image.png?raw=true "Flutter Dotted Border Image" )

### Credits

* [Flutter Path Drawing](https://github.com/dnfield/flutter_path_drawing) - [Dan Field](https://github.com/dnfield)
