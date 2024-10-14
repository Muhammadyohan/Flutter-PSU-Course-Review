import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

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
                    'assets/psu_event_hub.png',
                    height: 40,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 55, 70, 152),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    // ใช้ SingleChildScrollView เพื่อรองรับการ scroll ในกรณีที่ข้อมูลเยอะ
                    child: SignupField(),
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
