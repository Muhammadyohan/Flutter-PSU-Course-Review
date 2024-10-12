import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../pages/event_detail_page.dart';

class PopularEventsWidget extends StatelessWidget {
  const PopularEventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular Events',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3E4B92),
            ),
          ),
          const SizedBox(height: 12),
          _buildEventCard(context),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        return state is LoadingEventState
            ? const Center(child: CircularProgressIndicator())
            : const PopularEventList();
      },
    );
  }
}

class PopularEventList extends StatelessWidget {
  const PopularEventList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final events = context.select((EventBloc bloc) => bloc.state.events);
    return events.isEmpty
        ? const Center(
            child: Text("Nothing to show."),
          )
        : SingleChildScrollView(
            child: LimitedBox(
              maxHeight: 340,
              child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EventDetailPage(
                                    eventTitle: 'งานบอล วิทยาการสาสตร์'),
                              ),
                            );
                          },
                          child: Container(
                            width: 350,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3E4B92),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          events[index].eventTitle,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(Icons.calendar_today,
                                                color: Colors.white, size: 12),
                                            const SizedBox(width: 5),
                                            Text(events[index].eventDate,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    child: Image.asset(
                                      'assets/psu-course-review-appbar.jpg',
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  }),
            ),
          );
  }
}
