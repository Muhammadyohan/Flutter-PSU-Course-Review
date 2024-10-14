import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/pages/pages.dart';
import 'package:flutter_psu_course_review/widgets/widgets.dart';
import '../../blocs/blocs.dart';

class PopularEventsWidget extends StatelessWidget {
  const PopularEventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
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
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E4B92),
                      ),
                    ),
                    _myEventButton(context)
                  ],
                ),
                const Divider(thickness: 1, height: 24),
                _buildEventCard(context, state),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _myEventButton(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF3E4B92),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 3,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.event, size: 18),
          SizedBox(width: 8),
          Text(
            'My Events',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onPressed: () {
        userBloc.add(LoadUserEvent());
        if (userBloc.state is NeedLoginUserState) {
          ScaffoldMessenger.of(context).showSnackBar(
            _showLoginRequiredScnackBar(context),
          );
          return;
        }
        context.read<EventBloc>().add(SearchClearEvent());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyEventPage(),
          ),
        );
      },
    );
  }

  SnackBar _showLoginRequiredScnackBar(BuildContext context) {
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.info_outline, color: Colors.white),
          const Text(
            'Login required',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            ),
            child: const Text(
              'LOGIN',
              style:
                  TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF3E4B92),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(8),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget _buildEventCard(BuildContext context, EventState state) {
    return state is LoadingEventState
        ? const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3E4B92)),
            ),
          )
        : const PopularEventList();
  }
}
