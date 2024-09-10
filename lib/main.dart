import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/pages/pages.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter App',
      home: HomePage(), // Set the WelcomePage as the initial page
    );
  }
}
