import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';
import 'package:flutter_psu_course_review/widgets/widgets.dart';

class EventCategoryPage extends StatelessWidget {
  final String category;

  const EventCategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '$category Events',
            style: const TextStyle(color: Colors.white),
          ),
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
                    if (state is LoadingEventState) {
                      return const Center(child: CircularProgressIndicator());
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
                                    const EventCategorySearchBar(),
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
        ));
  }

  Widget _buildEventCard(BuildContext context) {
    return const EventCategoryList();
  }
}
