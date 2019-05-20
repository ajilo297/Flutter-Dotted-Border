import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dotted_border/dotted_border.dart';

void main() {
  testWidgets('Run test', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DottedBorder(
          child: Text('test'),
        ),
      ),
    ));

    expect(find.byType(DottedBorder), findsOneWidget);
  });
}
