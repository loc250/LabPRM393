import 'package:flutter_test/flutter_test.dart';
import 'package:lab4/main.dart';

void main() {
  testWidgets('Lab4App smoke test - verifies exercises are listed',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Lab4App());

    // Verify title and exercises are displayed
    expect(find.text('Lab 4: Flutter UI Fundamentals'), findsOneWidget);
    expect(find.text('Exercise 1: Core Widgets'), findsOneWidget);
    expect(find.text('Exercise 2: Input Controls'), findsOneWidget);
    expect(find.text('Exercise 3: Layout Basics'), findsOneWidget);
    expect(find.text('Exercise 4: Scaffold & Theme'), findsOneWidget);
    expect(find.text('Exercise 5: Debug UI Errors'), findsOneWidget);
  });
}
