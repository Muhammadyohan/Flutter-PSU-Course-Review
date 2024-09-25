import 'package:flutter/material.dart';

class EventCategoryPage extends StatelessWidget {
  final String category;

  EventCategoryPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category Events'),
        backgroundColor: Color(0xFF3E4B92),
      ),
      body: Center(
        child: Text(
          'List of $category events will be shown here.',
          style: const TextStyle(fontSize: 18, color: Color(0xFF3E4B92)),
        ),
      ),
    );
  }
}
