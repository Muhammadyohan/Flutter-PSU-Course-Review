import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/pages/pages.dart';
import 'package:flutter_psu_course_review/widgets/widgets.dart';
import '../../blocs/blocs.dart';

class PopularEventsWidget extends StatelessWidget {
  const PopularEventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                    'Popular Events',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E4B92),
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      'My Event',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E4B92),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () {
                      if (context.read<UserBloc>().state
                          is NeedLoginUserState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            action: SnackBarAction(
                                label: 'Go to Login Page',
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                }),
                            content: const Text('You Need to login first.'),
                          ),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyEventPage(),
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
  }

  Widget _buildEventCard(BuildContext context, EventState state) {
    return state is LoadingEventState
        ? const Center(child: CircularProgressIndicator())
        : const PopularEventList();
  }
}
