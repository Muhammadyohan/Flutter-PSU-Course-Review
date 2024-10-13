import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/pages/pages.dart';

import '../../blocs/blocs.dart';

class MyEventList extends StatelessWidget {
  const MyEventList({super.key});

  @override
  Widget build(BuildContext context) {
    final events = context.select((EventBloc bloc) => bloc.state.myEvents);
    final myUserId = context.select((UserBloc bloc) => bloc.state.user.id);
    return events.isEmpty
        ? const Center(
            child: Text("You don't have event yet. "),
          )
        : SingleChildScrollView(
            child: LimitedBox(
              maxHeight: 650,
              child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<EventBloc>().add(
                                  SelectEventEvent(
                                      eventId: events[index].id,
                                      eventUserId: events[index].userId,
                                      myUserId: myUserId),
                                );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EventDetailPage(eventId: events[index].id),
                              ),
                            );
                          },
                          child: Container(
                            width: 350,
                            height: 110,
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
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF3E4B92), //Colors.grey[300]
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        child: Image.asset(
                                          'assets/psu-course-review-appbar.jpg',
                                          height: 40,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.edit),
                                            color: Colors.white,
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.delete),
                                            color: Colors.white,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  }),
            ),
          );
    ;
  }
}
