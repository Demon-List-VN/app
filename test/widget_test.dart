import 'package:flutter_test/flutter_test.dart';

import 'package:gdvn/main.dart';

void main() {
  testWidgets('none', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ForuiApp());

    await tester.pumpAndSettle();
  });
}
