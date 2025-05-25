// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_homepage/main.dart';

void main() {
  testWidgets('Personal homepage smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PersonalHomepage());

    // Wait for any async operations to complete
    await tester.pumpAndSettle();

    // Verify that the app loads without crashing
    expect(find.byType(Scaffold), findsOneWidget);
    
    // Check if loading indicator appears initially
    expect(find.byType(CircularProgressIndicator), findsAny);
  });
}
