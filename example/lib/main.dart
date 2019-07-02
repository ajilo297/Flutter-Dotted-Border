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
              dashPattern: [6, 3, 1, 2],
              strokeWidth: 1,
              borderType: BorderType.Oval,
              radius: Radius.circular(40),
              padding: EdgeInsets.all(8),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: Colors.blueGrey,
                ),
                height: 150,
                width: 250,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
