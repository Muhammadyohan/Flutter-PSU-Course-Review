import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';
import 'package:flutter_psu_course_review/pages/pages.dart';

class SignupField extends StatefulWidget {
  const SignupField({
    super.key,
  });

  @override
  State<SignupField> createState() => _SignupFieldState();
}

class _SignupFieldState extends State<SignupField> {
  bool _obscureText = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          'SIGN UP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        _customTextField(
          hintText: 'USERNAME',
          prefixIcon: Icons.person,
          controller: _usernameController,
        ),
        const SizedBox(height: 20),
        _customTextField(
          hintText: 'EMAIL',
          prefixIcon: Icons.email,
          controller: _emailController,
        ),
        const SizedBox(height: 20),
        _customTextField(
          hintText: 'FIRST NAME',
          prefixIcon: Icons.person_outline,
          controller: _firstNameController,
        ),
        const SizedBox(height: 20),
        _customTextField(
          hintText: 'LAST NAME',
          prefixIcon: Icons.person_outline,
          controller: _lastNameController,
        ),
        const SizedBox(height: 20),
        _customTextField(
          hintText: 'PASSWORD',
          isPassword: true,
          prefixIcon: Icons.lock,
          controller: _passwordController,
        ),
        const SizedBox(height: 20),
        _customTextField(
          hintText: 'CONFIRM PASSWORD',
          isConfirmPassword: true,
          prefixIcon: Icons.lock,
          controller: _confirmPasswordController,
        ),
        const SizedBox(height: 40),
        Center(
          child: ElevatedButton(
            onPressed: () {
              _signup();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: const Size(200, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'SIGN UP',
              style: TextStyle(
                color: Color(0xFF3E4B92),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text(
              'Already have an account? Login',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _customTextField({
    String? hintText,
    bool isPassword = false,
    bool isConfirmPassword = false,
    IconData? prefixIcon,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword || isConfirmPassword ? _obscureText : false,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: isPassword || isConfirmPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<void> _signup() async {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showSnackBar('Please fill in all fields');
      return;
    } else if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar('Passwords do not match of Confirm Password');
      return;
    }

    String username = _usernameController.text;
    String email = _emailController.text;
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String password = _passwordController.text;

    context.read<UserBloc>().add(CreateUserEvent(
        username: username,
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password));

    // Wait for the user to be created and logged in
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    //Check the current response text
    final currentState = context.read<UserBloc>().state;

    if (currentState is NeedLoginUserState) {
      _showSnackBar('This username is exists');
    } else if (currentState is ReadyUserState) {
      _showSnackBar('User created successfully');
      Navigator.pop(context);
      Navigator.pop(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    } else {
      _showSnackBar('An error occurred. Please try again.');
    }

    FocusScope.of(context).unfocus();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color(0xFF3E4B92),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
