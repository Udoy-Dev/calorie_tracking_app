import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calorie_tracking_app/main.dart';

void main() {
  Widget buildTestApp() {
    return CalorieTrackerApp(notifier: createCalorieTrackerNotifier());
  }

  testWidgets('Calorie Tracker initial state test', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());

    // Verify app title
    expect(find.text('Calorie Tracker'), findsOneWidget);

    // Verify summary card labels
    expect(find.text('Total Calories'), findsOneWidget);
    expect(find.text('Daily Goal'), findsOneWidget);
    expect(find.text('Remaining'), findsOneWidget);
    // Initial Daily Goal (2000) & Remaining (2000)
    expect(find.text('2000'), findsNWidgets(2));
    expect(find.text('0'), findsOneWidget); // Total Calories = 0

    // Empty state message
    expect(find.text('No food items added yet!'), findsOneWidget);
  });

  testWidgets('Add food validation test', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());

    // Tap Add Food FAB
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Verify dialog opens
    expect(find.text('Add Food Item'), findsOneWidget);

    final dialogAddButton = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.widgetWithText(ElevatedButton, 'Add Food'),
    );

    // Tap Add Food in dialog without filling fields
    await tester.tap(dialogAddButton);
    await tester.pumpAndSettle();

    // Verify validation errors
    expect(find.text('Please enter a food name'), findsOneWidget);
    expect(find.text('Please enter calorie amount'), findsOneWidget);

    // Enter invalid calorie amount (0)
    await tester.enterText(find.bySemanticsLabel('Food Name'), 'Apple');
    await tester.enterText(find.bySemanticsLabel('Calorie Amount (kcal)'), '0');
    await tester.tap(dialogAddButton);
    await tester.pumpAndSettle();

    expect(find.text('Calorie amount must be a valid positive number'), findsOneWidget);
  });

  testWidgets('Add and delete food items test', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());

    // Open Add Food dialog via header button
    final headerAddButton = find.descendant(
      of: find.byType(SafeArea),
      matching: find.widgetWithText(ElevatedButton, 'Add Food'),
    );
    await tester.tap(headerAddButton);
    await tester.pumpAndSettle();

    final dialogAddButton = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.widgetWithText(ElevatedButton, 'Add Food'),
    );

    // Fill valid food details
    await tester.enterText(find.bySemanticsLabel('Food Name'), 'Apple');
    await tester.enterText(find.bySemanticsLabel('Calorie Amount (kcal)'), '95');
    await tester.tap(dialogAddButton);
    await tester.pumpAndSettle();

    // Verify item added
    expect(find.text('Apple'), findsOneWidget);
    expect(find.text('95 kcal'), findsOneWidget);
    expect(find.text('95'), findsOneWidget); // Total calories
    expect(find.text('1905'), findsOneWidget); // Remaining calories (2000 - 95)

    // Add second food item via FAB
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.bySemanticsLabel('Food Name'), 'Sandwich');
    await tester.enterText(find.bySemanticsLabel('Calorie Amount (kcal)'), '350');
    await tester.tap(dialogAddButton);
    await tester.pumpAndSettle();

    // Verify second item added
    expect(find.text('Sandwich'), findsOneWidget);
    expect(find.text('350 kcal'), findsOneWidget);
    expect(find.text('445'), findsOneWidget); // Total calories (95 + 350)
    expect(find.text('1555'), findsOneWidget); // Remaining (2000 - 445)

    // Delete first item ('Apple')
    final deleteButtons = find.byIcon(Icons.delete_outline);
    await tester.tap(deleteButtons.first);
    await tester.pumpAndSettle();

    // Verify Apple is removed and total updated
    expect(find.text('Apple'), findsNothing);
    expect(find.text('Sandwich'), findsOneWidget);
    expect(find.text('350'), findsOneWidget); // Total calories updated to 350
    expect(find.text('1650'), findsOneWidget); // Remaining updated to 1650 (2000 - 350)
  });
}
