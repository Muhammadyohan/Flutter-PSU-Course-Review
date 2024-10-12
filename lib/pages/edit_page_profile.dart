import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/widgets/personal_info_form.dart';
import 'package:flutter_psu_course_review/widgets/password_change_form.dart';

class EditProfilePage extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const EditProfilePage({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
  });

  void _saveProfile(BuildContext context) {
    Navigator.pop(context, {
      'username': usernameController.text,
      'email': emailController.text,
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
    });
  }

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
              usernameController: usernameController,
              emailController: emailController,
              firstNameController: firstNameController,
              lastNameController: lastNameController,
            ),
            const SizedBox(height: 16),
            const PasswordChangeForm(),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () => _saveProfile(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E4B92),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
