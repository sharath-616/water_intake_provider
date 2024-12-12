import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake_provider/provider/water_intake_provider.dart';
import 'package:water_intake_provider/screens/homepage.dart';

void main() => runApp(
      MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => WaterIntakeProvider()),
          
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Intake App',
      home: Homepage(),
    );
  }
}
