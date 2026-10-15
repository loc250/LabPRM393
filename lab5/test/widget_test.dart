import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab5/main.dart';

void main() {
  testWidgets('Movie Explorer displays movie list and navigation test',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MovieDetailApp());
    await tester.pump();

    // Verify App title is displayed
    expect(find.text('Movie Explorer'), findsOneWidget);

    // Verify Inception is present in sample data
    expect(find.text('Inception'), findsOneWidget);

    // Tap on Inception to navigate to details
    await tester.tap(find.text('Inception'));
    await tester.pumpAndSettle();

    // Verify detail screen components
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Rate'), findsOneWidget);
    expect(find.text('Share'), findsOneWidget);
    expect(find.byIcon(Icons.video_library_outlined), findsOneWidget);
  });
}

