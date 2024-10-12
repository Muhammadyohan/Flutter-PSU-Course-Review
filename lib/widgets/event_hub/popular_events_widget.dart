import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/pages/authen/login_page.dart';
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
                      'Add Event',
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
                          const SnackBar(
                            content: Text(
                                'You Need to login first.'),
                          ),
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyEventAddButton(),
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
