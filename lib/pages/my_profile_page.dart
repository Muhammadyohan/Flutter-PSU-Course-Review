import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/pages/edit_page_profile.dart';
import 'package:flutter_psu_course_review/widgets/logout_confirmation_dialog.dart';

class MyProfilePage extends StatefulWidget {
  final TextEditingController _usernameController = TextEditingController(text: "YOHUN");
  final TextEditingController _emailController = TextEditingController(text: "YOHUN@email.com");
  final TextEditingController _firstNameController = TextEditingController(text: "YOHUN");
  final TextEditingController _lastNameController = TextEditingController(text: "KARJEY");
  

  MyProfilePage({super.key});

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> with RouteAware {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage(
                  usernameController: widget._usernameController,
                  emailController: widget._emailController,
                  firstNameController: widget._firstNameController,
                  lastNameController: widget._lastNameController,
                )),
              );
              if (result != null) {
                setState(() {
                  widget._usernameController.text = result['username'];
                  widget._emailController.text = result['email'];
                  widget._firstNameController.text = result['firstName'];
                  widget._lastNameController.text = result['lastName'];
                });
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/psu-course-review-appbar.jpg'),
              ),
            ),
            const SizedBox(height: 24),
            _buildProfileInfo('Username', widget._usernameController.text),
            _buildProfileInfo('Email', widget._emailController.text),
            _buildProfileInfo('First name', widget._firstNameController.text),
            _buildProfileInfo('Last name', widget._lastNameController.text),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () => showLogoutConfirmationDialog(context, () {
                  Navigator.pop(context);
                }),
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

  Widget _buildProfileInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF3E4B92),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
