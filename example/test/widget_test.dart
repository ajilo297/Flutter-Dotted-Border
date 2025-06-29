import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(FlutterLogo), findsOneWidget);
    expect(find.byType(DottedBorder), findsOneWidget);
  });
}
