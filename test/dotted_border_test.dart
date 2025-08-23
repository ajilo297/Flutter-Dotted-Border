import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dotted_border/dotted_border.dart';

void main() {
  testWidgets('Basic DottedBorder test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: DottedBorder(child: Text('test')))),
    );

    expect(find.byType(DottedBorder), findsOneWidget);
  });

  testWidgets('Dot-Dash-Dot pattern test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              patternType: BorderPatternType.DotDashDot,
              strokeWidth: 2,
              radius: Radius.circular(8),
              color: Colors.blue,
              padding: EdgeInsets.all(8),
            ),
            child: Text('test'),
          ),
        ),
      ),
    );

    expect(find.byType(DottedBorder), findsOneWidget);
  });

  testWidgets('Dashed pattern test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              patternType: BorderPatternType.Dashed,
              strokeWidth: 2,
              radius: Radius.circular(8),
              color: Colors.green,
              padding: EdgeInsets.all(8),
            ),
            child: Text('test'),
          ),
        ),
      ),
    );

    expect(find.byType(DottedBorder), findsOneWidget);
  });

  testWidgets('Custom pattern test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              patternType: BorderPatternType.Custom,
              dashPattern: [5, 3, 5, 3],
              strokeWidth: 2,
              radius: Radius.circular(8),
              color: Colors.red,
              padding: EdgeInsets.all(8),
            ),
            child: Text('test'),
          ),
        ),
      ),
    );

    expect(find.byType(DottedBorder), findsOneWidget);
  });
}
