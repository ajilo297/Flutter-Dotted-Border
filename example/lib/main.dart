import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          appBar: AppBar(title: const Text('Dotted Border')),
          body: SafeArea(
            child: ListView(
              children: const <Widget>[
                _RectDottedBorder(key: Key('rect_dotted_border')),
                _RoundedRectDottedBorder(
                  key: Key('rounded_rect_dotted_border'),
                ),
                _OvalDottedBorder(key: Key('oval_dotted_border')),
                _CircleDottedBorder(key: Key('circle_dotted_border')),
                _CustomPathBorder(key: Key('custom_path_dotted_border')),
                _GradientBorder(key: Key('gradient_dotted_border')),
              ]
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(10),
                      child: e,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
}

class _RectDottedBorder extends StatelessWidget {
  const _RectDottedBorder({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: DottedBorder(
          options: RectDottedBorderOptions(
            dashPattern: [10, 5],
            strokeWidth: 2,
            padding: EdgeInsets.all(16),
          ),
          child: Text(
            'Rectangular Border',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}

class _RoundedRectDottedBorder extends StatelessWidget {
  const _RoundedRectDottedBorder({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            dashPattern: [10, 5],
            strokeWidth: 2,
            radius: Radius.circular(16),
            color: Colors.indigo,
            padding: EdgeInsets.all(16),
          ),
          child: Text(
            'Rounded Rect Border',
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}

class _OvalDottedBorder extends StatelessWidget {
  const _OvalDottedBorder({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: DottedBorder(
          options: OvalDottedBorderOptions(
            dashPattern: [10, 5],
            strokeWidth: 2,
            color: Colors.green,
            padding: EdgeInsets.all(16),
          ),
          child: Text(
            'Oval Border',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}

class _CircleDottedBorder extends StatelessWidget {
  const _CircleDottedBorder({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: DottedBorder(
          options: CircularDottedBorderOptions(
            dashPattern: [10, 5],
            strokeWidth: 4,
            color: Colors.red,
            padding: EdgeInsets.all(4),
          ),
          child: Icon(
            Icons.person,
            size: 64,
            color: Colors.red,
          ),
        ),
      );
}

class _CustomPathBorder extends StatelessWidget {
  const _CustomPathBorder({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: DottedBorder(
          options: CustomPathDottedBorderOptions(
            padding: const EdgeInsets.all(8),
            color: Colors.purple,
            strokeWidth: 2,
            dashPattern: [10, 5],
            customPath: (size) => Path()
              ..moveTo(0, size.height)
              ..relativeLineTo(size.width, 0),
          ),
          child: const Text(
            'Custom Path Border',
            style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}

class _GradientBorder extends StatelessWidget {
  const _GradientBorder({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            dashPattern: [10, 5],
            strokeWidth: 4,
            radius: Radius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.indigo,
                Colors.purple,
              ],
            ),
            padding: EdgeInsets.all(16),
          ),
          child: Text(
            'Rainbow Border',
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
