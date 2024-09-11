import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/pages/my_profile_page.dart';
import '../widgets/widgets.dart';
import 'package:flutter_psu_course_review/pages/pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: HomePage()),
    Center(child: ReviewPostSearch()),
    Center(child: MyPostPage()),
    Center(child: MyProfilePage()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/psu-course-review-appbar.jpg',
          width: 130,
          height: 130,
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Navbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
