import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const Navbar({super.key, 
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.reviews), label: 'CourseReview'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      backgroundColor: const Color(0xFF3E4B92),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.6),
      type: BottomNavigationBarType.fixed,
    );
  }
}