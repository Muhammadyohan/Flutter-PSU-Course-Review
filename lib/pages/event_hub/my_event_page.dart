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
        title: const Text('My Events', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3E4B92), Color(0xFF5C6BC0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFE8EAF6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  if (context.read<UserBloc>().state is NeedLoginUserState) {
                    return _tokenExpiredUiDisplay(context);
                  }
                  return state is LoadingEventState
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: BlocBuilder<EventBloc, EventState>(
                            builder: (context, state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'My Events',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3E4B92),
                                    ),
                                  ),
                                  const MyEventsSearchBar(),
                                  _buildEventCard(context),
                                ],
                              );
                            },
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _addEventButton(context),
    );
  }

  FloatingActionButton _addEventButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyEventAddButton()),
        );
      },
      backgroundColor: const Color(0xFF3E4B92),
      child: const Icon(Icons.add),
    );
  }

  Widget _tokenExpiredUiDisplay(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Color(0xFF3E4B92)),
          const SizedBox(height: 16),
          const Text(
            'Your token has expired.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Please log in again to continue.'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3E4B92),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Go to Login Page'),
          )
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context) {
    return const MyEventList();
  }
}
