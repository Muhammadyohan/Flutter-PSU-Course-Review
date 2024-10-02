import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/pages/pages.dart';
import 'package:flutter_psu_course_review/widgets/widgets.dart';

class MyProfilePage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController(text: "YOHUN");
  final TextEditingController _emailController = TextEditingController(text: "YOHUN@email.com");
  final TextEditingController _firstNameController = TextEditingController(text: "YOHUN");
  final TextEditingController _lastNameController = TextEditingController(text: "KARJEY");
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  MyProfilePage({super.key});

  void _handleLogout(BuildContext context) {
    showLogoutConfirmationDialog(
      context,
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomePage()),
        );
      },
    );
  }

  Widget _buildEditableField(BuildContext context, String label, TextEditingController controller, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF3E4B92),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: controller,
                    obscureText: obscureText,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  if (label == 'Password') {
                    showPasswordEditDialog(
                      context,
                      _oldPasswordController,
                      _newPasswordController,
                      _confirmPasswordController,
                    );
                  } else {
                    showProfileEditDialog(context, label, controller);
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'My Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/psu-course-review-appbar.jpg'),
              ),
            ),
            const SizedBox(height: 24),
            _buildEditableField(context, 'Username', _usernameController),
            _buildEditableField(context, 'Email', _emailController),
            _buildEditableField(context, 'First name', _firstNameController),
            _buildEditableField(context, 'Last name', _lastNameController),
            _buildEditableField(context, 'Password', TextEditingController(text: "********"), obscureText: true),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () => _handleLogout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
