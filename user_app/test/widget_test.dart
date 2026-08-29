import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:user_app/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    // Basic smoke test
    await tester.pumpWidget(const SyStoreApp(initialRoute: '/'));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
