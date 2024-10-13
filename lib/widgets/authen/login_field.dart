import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';
import 'package:flutter_psu_course_review/pages/pages.dart';

class LoginField extends StatefulWidget {
  const LoginField({
    super.key,
  });

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  bool _obscureText = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'LOGIN',
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
            hintText: 'PASSWORD',
            isPassword: true,
            prefixIcon: Icons.lock,
            controller: _passwordController,
          ),
          const SizedBox(height: 40),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _login();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'LOGIN',
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupPage()));
              },
              child: const Text(
                'Don\'t have an account? Sign up',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MainPage()));
              },
              child: const Text(
                'Back to Home Page',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decorationColor: Colors.white,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customTextField({
    String? hintText,
    bool isPassword = false,
    IconData? prefixIcon,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? _obscureText : false,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: isPassword
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

  Future<void> _login() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar('Please fill in all fields');
      return;
    }

    String username = _usernameController.text;
    String password = _passwordController.text;

    context
        .read<UserBloc>()
        .add(LoginUserEvent(username: username, password: password));

    // Wait for the UserBloc to process the login event
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    // Check the current state of UserBloc
    final currentState = context.read<UserBloc>().state;

    if (currentState is NeedLoginUserState) {
      _showSnackBar('Invalid username or password');
    } else if (currentState is LoadingUserState) {
      context.read<EventBloc>().add(LoadEventsEvent());
      context.read<EventBloc>().add(LoadMyEventsEvent());
      context.read<UserBloc>().add(LoadUserEvent());
      _showSnackBar('Logged in successfully');
      FocusScope.of(context).unfocus();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    } else {
      _showSnackBar('An error occurred. Please try again.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
