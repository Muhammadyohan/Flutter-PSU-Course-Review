import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/widgets/widgets.dart';

class EditProfilePage extends StatelessWidget {
  final int userId;
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  const EditProfilePage(
      {super.key,
      required this.userId,
      required this.username,
      required this.email,
      required this.firstName,
      required this.lastName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PersonalInfoForm(
              userId: userId,
              username: username,
              email: email,
              firstName: firstName,
              lastName: lastName,
            ),
            const SizedBox(height: 16),
            PasswordChangeForm(userId: userId),
          ],
        ),
      ),
    );
  }
}
