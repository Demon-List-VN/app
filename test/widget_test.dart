import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gdvn/main.dart';

void main() {
  testWidgets('theme selector toggles the app theme', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ForuiApp());

    expect(find.text('ForUI starter'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.dark_mode));
    await tester.pumpAndSettle();
  });
}
