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

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
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
        ),
        const SizedBox(height: 40),
        Center(
          child: ElevatedButton(
            onPressed: () {
              _signup();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
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
              Navigator.pushReplacement(context,
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

  void _signup() {
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

    FocusScope.of(context).unfocus();
  }
}