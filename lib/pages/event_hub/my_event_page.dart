import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';
import 'package:flutter_psu_course_review/pages/pages.dart';
import 'package:flutter_psu_course_review/widgets/widgets.dart';

class MyEventPage extends StatelessWidget {
  const MyEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Event'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<EventBloc, EventState>(
            builder: (context, state) {
              if (context.read<UserBloc>().state is NeedLoginUserState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Your token is expired. Login again.'),
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
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<EventBloc, EventState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'My Events',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3E4B92),
                              ),
                            ),
                            TextButton(
                              child: const Text(
                                'Add Event',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3E4B92),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MyEventAddButton(),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildEventCard(context, state),
                        const SizedBox(height: 12),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, EventState state) {
    return state is LoadingEventState
        ? const Center(child: CircularProgressIndicator())
        : const MyEventList();
  }
}
