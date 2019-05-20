import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byType(FlutterLogo), findsOneWidget);
    expect(find.byType(DottedBorder), findsOneWidget);
  });
}
