import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Dotted Border'),
          ),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8,
                  children: <Widget>[
                    rectBorderWidget,
                    roundedRectBorderWidget,
                    customBorder,
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget get rectBorderWidget {
    return DottedBorder(
      dashPattern: [8, 3],
      child: Container(
        height: 200,
        width: 120,
        color: Colors.red,
      ),
    );
  }

  Widget get roundedRectBorderWidget {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          height: 200,
          width: 120,
          color: Colors.yellow,
        ),
      ),
    );
  }

  Widget get customBorder {
    Path customPath = Path()
      ..moveTo(0, 0)
      ..lineTo(60, 100)
      ..lineTo(0, 200)
      ..lineTo(120, 100)
      ..lineTo(0, 0);

    return DottedBorder(
      customPath: customPath,
      color: Colors.indigo,
      dashPattern: [8, 4],
      strokeWidth: 2,
      child: Container(
        height: 200,
        width: 120,
      ),
    );
  }
}
