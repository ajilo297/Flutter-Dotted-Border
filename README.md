# Dotted Border

[![pub package](https://img.shields.io/badge/pub-0.1.1-orange.svg)](https://pub.dev/packages/dotted_border)

A flutter package to easily added dotted borders around widgets.

## Usage

To use this package, add `dotted_border` as a dependency in your `pubspec.yaml` file.

### Example

Wrap `DottedBorder` widget around the child widget

```dart
DottedBorder(
    color: Colors.black,
    gap: 3,
    strokeWidth: 1,
    child: FlutterLogo(size: 148),
)
```
