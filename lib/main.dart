import 'package:flutter/material.dart';
import 'package:puzzle_dot/screens/home_screen.dart';

void main() {
  runApp(const PuzzleDotApp());
}

class PuzzleDotApp extends StatelessWidget {
  const PuzzleDotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PuzzleDot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF00AEEF),
        scaffoldBackgroundColor: const Color(0xFFF5FAFF),
      ),
      home: const MainNavigationScreen(),
    );
  }
}