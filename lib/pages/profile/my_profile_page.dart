import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/pages/pages.dart';
import 'package:flutter_psu_course_review/widgets/widgets.dart';
import '../../blocs/blocs.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(LoadUserEvent());
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final user = context.select((UserBloc bloc) => bloc.state.user);
        return state is NeedLoginUserState
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('You need to login first'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text('Go to Login Page'),
                  )
                ],
              )
            : state is LoadingUserState
                ? const Center(child: CircularProgressIndicator())
                : Scaffold(
                    appBar: AppBar(
                      title: const Text('My Profile'),
                      automaticallyImplyLeading: false,
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfilePage(
                                        username: user.username,
                                        email: user.email,
                                        firstName: user.firstName,
                                        lastName: user.lastName,
                                      )),
                            );
                          },
                        ),
                      ],
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Icon(Icons.person, size: 70),
                          ),
                          const SizedBox(height: 24),
                          _buildProfileInfo('Username', user.username),
                          _buildProfileInfo('Email', user.email),
                          _buildProfileInfo('First name', user.firstName),
                          _buildProfileInfo('Last name', user.lastName),
                          const SizedBox(height: 24),
                          Center(
                            child: ElevatedButton(
                              onPressed: () =>
                                  showLogoutConfirmationDialog(context, () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              }),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.red,
                                side: const BorderSide(color: Colors.red),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                              ),
                              child: const Text('Logout'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
      },
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
