import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          appBar: AppBar(
          title: Text('Dotted Border'),
          actions: [
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Switch(
                  value: controller.isAnimating,
                  onChanged: (value) {
                    if(value) {
                      controller.repeat();
                    } else {
                      controller.stop();
                    }
                  }
                );
              },
            ),
          ],
        ),
          body: SafeArea(
            child: ListView(
              children: <Widget>[
                _RectDottedBorder(
                  key: Key('rect_dotted_border'),
                  animation: controller,
                ),
                _RoundedRectDottedBorder(
                  key: Key('rounded_rect_dotted_border'),
                  animation: controller,
                ),
                _OvalDottedBorder(
                  key: Key('oval_dotted_border'),
                  animation: controller,
                ),
                _CircleDottedBorder(
                  key: Key('circle_dotted_border'),
                  animation: controller,
                ),
                _CustomPathBorder(
                  key: Key('custom_path_dotted_border'),
                  animation: controller,
                ),
                _GradientBorder(
                  key: Key('gradient_dotted_border'),
                  animation: controller,
                ),
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
  const _RectDottedBorder({super.key, this.animation});

  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) => Center(
        child: DottedBorder(
          animation: animation,
          options: const RectDottedBorderOptions(
            dashPattern: [10, 5],
            strokeWidth: 2,
            padding: EdgeInsets.all(16),
          ),
          child: const Text(
            'Rectangular Border',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}

class _RoundedRectDottedBorder extends StatelessWidget {
  const _RoundedRectDottedBorder({super.key, this.animation});

  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) => Center(
        child: DottedBorder(
          animation: animation,
          options: const RoundedRectDottedBorderOptions(
            dashPattern: [10, 5],
            strokeWidth: 2,
            radius: Radius.circular(16),
            color: Colors.indigo,
            padding: EdgeInsets.all(16),
          ),
          child: const Text(
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
  const _OvalDottedBorder({super.key, this.animation});

  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) => Center(
        child: DottedBorder(
          animation: animation,
          options: const OvalDottedBorderOptions(
            dashPattern: [10, 5],
            strokeWidth: 2,
            color: Colors.green,
            padding: EdgeInsets.all(16),
          ),
          child: const Text(
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
  const _CircleDottedBorder({super.key, this.animation});

  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) => Center(
        child: DottedBorder(
          animation: animation,
          options: const CircularDottedBorderOptions(
            dashPattern: [10, 5],
            strokeWidth: 4,
            color: Colors.red,
            padding: EdgeInsets.all(4),
          ),
          child: const Icon(
            Icons.person,
            size: 64,
            color: Colors.red,
          ),
        ),
      );
}

class _CustomPathBorder extends StatelessWidget {
  const _CustomPathBorder({super.key, this.animation});

  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) => Center(
        child: DottedBorder(
          animation: animation,
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
  const _GradientBorder({super.key, this.animation});

  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) => Center(
        child: DottedBorder(
          animation: animation,
          options: const RoundedRectDottedBorderOptions(
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
          child: const Text(
            'Rainbow Border',
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
