import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/pages/pages.dart';
import '../widgets/widgets.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/psu-course-review-appbar.jpg',
                    height: 40,
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 55, 70, 152),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(  // ใช้ SingleChildScrollView เพื่อรองรับการ scroll ในกรณีที่ข้อมูลเยอะ
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        CustomTextField(
                          hintText: 'USERNAME',
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          hintText: 'EMAIL',
                          prefixIcon: Icons.email,
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          hintText: 'FIRST NAME',
                          prefixIcon: Icons.person_outline,
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          hintText: 'LAST NAME',
                          prefixIcon: Icons.person_outline,
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          hintText: 'PASSWORD',
                          isPassword: true,
                          prefixIcon: Icons.lock,
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          hintText: 'CONFIRM PASSWORD',
                          isPassword: true,
                          prefixIcon: Icons.lock,
                        ),
                        SizedBox(height: 40),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainPage()));
                            },
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: Color(0xFF3E4B92),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              minimumSize: Size(200, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text(
                              'Already have an account? Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
