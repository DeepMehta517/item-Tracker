import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:itemtracker/provider/item_provider.dart';
import 'package:provider/provider.dart';
import 'package:itemtracker/itemTracker/item_tracker_screen.dart';

void main() {
  testWidgets('Add button displays dialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ItemProvider(),
        child: const MaterialApp(home: ItemTrackerScreen()),
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
