import 'package:flutter/material.dart';
import 'package:grocery_store/src/screens/intro_screen.dart';
import 'package:grocery_store/src/shared/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Grocery Store",
      home: const IntroScreen(),
      theme: themeLight,
    );
  }
}
