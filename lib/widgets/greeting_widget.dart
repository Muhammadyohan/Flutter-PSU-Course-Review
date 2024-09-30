import 'package:flutter/material.dart';

class GreetingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Yohun!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E4B92),
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Let's explore what's happening nearby",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3E4B92),
                ),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: Color(0xFF3E4B92),
            radius: 20,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
