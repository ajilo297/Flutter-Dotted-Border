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
              gap: 3,
              strokeWidth: 1,
              child: FlutterLogo(size: 148),
            ),
          ),
        ),
      ),
    );
  }
}
