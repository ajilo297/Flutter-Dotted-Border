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
        body: Center(
          child: Container(
            child: DottedBorder(
              color: Colors.black,
              gapSpacing: [6, 2, 3, 2],
              strokeWidth: 3,
              padding: EdgeInsets.all(0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: Colors.blueGrey,
                ),
                height: 340,
                width: 340,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
