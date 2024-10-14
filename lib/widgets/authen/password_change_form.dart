import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';

class PasswordChangeForm extends StatefulWidget {
  final int userId;

  const PasswordChangeForm({super.key, required this.userId});

  @override
  State<PasswordChangeForm> createState() => _PasswordChangeFormState();
}

class _PasswordChangeFormState extends State<PasswordChangeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  bool _isPasswordChangeVisible = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isPasswordChangeVisible = !_isPasswordChangeVisible;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF3E4B92).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E4B92),
                    ),
                  ),
                  Icon(
                    _isPasswordChangeVisible
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: const Color(0xFF3E4B92),
                  ),
                ],
              ),
            ),
          ),
          if (_isPasswordChangeVisible) _buildPasswordFields(),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _changePassword(context, widget.userId);
    }
  }

  Future<void> _changePassword(BuildContext context, int userId) async {
    final userBloc = context.read<UserBloc>();
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    userBloc.add(ChangePasswordUserEvent(
        userId: userId,
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text));

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    final currentState = userBloc.state;

    if (currentState is ErrorUserState) {
      _showSnackBar(scaffoldMessenger, 'Incorrect current password');
    } else if (currentState is ReadyUserState) {
      navigator.pop();
      _showSnackBar(scaffoldMessenger, 'Password changed successfully');
    }
  }

  Widget _buildPasswordFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        _buildPasswordField('Current Password', _currentPasswordController),
        _buildPasswordField('New Password', _newPasswordController),
        const SizedBox(height: 24),
        Center(
          child: ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3E4B92),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Change Password',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E4B92),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3E4B92)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3E4B92), width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter ${label.toLowerCase()}';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showSnackBar(ScaffoldMessengerState messengerState, String message) {
    messengerState.showSnackBar(
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
            messengerState.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
