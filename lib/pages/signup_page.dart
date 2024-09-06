import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(hintText: 'Username', prefixIcon: (Icons.person)),
            CustomTextField(hintText: 'Email', prefixIcon: (Icons.email)),
            CustomTextField(
                hintText: 'First Name', prefixIcon: (Icons.person_outline)),
            CustomTextField(
                hintText: 'Last Name', prefixIcon: (Icons.person_outline)),
            CustomTextField(
                hintText: 'Password',
                isPassword: true,
                prefixIcon: (Icons.lock)),
            CustomTextField(
                hintText: 'Confirm Password',
                isPassword: true,
                prefixIcon: (Icons.lock)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
              },
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Text('Already have an account? Login'),
            )
          ],
        ),
      ),
    );
  }
}
