import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: WelcomePage(), // Set the WelcomePage as the initial page
    );
  }
}
