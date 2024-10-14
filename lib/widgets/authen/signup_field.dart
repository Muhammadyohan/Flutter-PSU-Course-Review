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
    final userBloc = context.read<UserBloc>();
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showSnackBar(scaffoldMessenger, 'Please fill in all fields');
      return;
    } else if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar(scaffoldMessenger, 'Passwords do not match of Confirm Password');
      return;
    }

    _showLoadingDialog(context);

    String username = _usernameController.text;
    String email = _emailController.text;
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String password = _passwordController.text;

    userBloc.add(CreateUserEvent(
        username: username,
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password));

    // Wait for the user to be created and logged in
    await Future.delayed(const Duration(seconds: 4));

    if (!mounted) return;

    navigator.pop(); // Close the loading dialog

    //Check the current response text
    final currentState = userBloc.state;

    if (currentState is NeedLoginUserState) {
      _showSnackBar(scaffoldMessenger, 'This username is exists');
    } else if (currentState is ReadyUserState) {
      _showSnackBar(scaffoldMessenger, 'User created successfully');
      navigator.pop();
      Navigator.pop(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    } else {
      _showSnackBar(scaffoldMessenger, 'An error occurred. Please try again.');
    }

    FocusScope.of(context).unfocus();
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF3E4B92)),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Signing Up...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E4B92),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSnackBar(ScaffoldMessengerState messengerState, String message) {
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
