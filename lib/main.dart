import 'package:flutter/material.dart';
import 'package:itemtracker/provider/item_provider.dart';
import 'package:provider/provider.dart';

import 'itemTracker/item_tracker_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Item Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), useMaterial3: true),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => ItemProvider()),
      ], child: ItemTrackerScreen()),
    );
  }
}
