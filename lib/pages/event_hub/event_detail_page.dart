import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';
import 'package:flutter_psu_course_review/models/models.dart';
import 'package:flutter_psu_course_review/widgets/widgets.dart';

class EventDetailPage extends StatelessWidget {
  final int eventId;

  const EventDetailPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final event = context.select((EventBloc bloc) => bloc.state.event);
    final myUserId = context.select((UserBloc bloc) => bloc.state.user.id);
    final isMyEvent = event.userId == myUserId;

    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        return state is LoadingEventState
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: _appBar(isMyEvent, context, event),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 16.0, 5.0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(event.authorName),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                          child: Text(
                            event.eventTitle,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3E4B92),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 5, 16.0, 16.0),
                          child: Text(
                            event.eventDescription,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: Color(0xFF3E4B92)),
                              const SizedBox(width: 8),
                              Text('Event Date: ${event.eventDate}'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton.icon(
                              icon: const Icon(Icons.thumb_up),
                              label: const Text('Like'),
                              onPressed: () {},
                            ),
                            TextButton.icon(
                              icon: const Icon(Icons.comment),
                              label: const Text('Comment'),
                              onPressed: () {},
                            ),
                            TextButton.icon(
                              icon: const Icon(Icons.share),
                              label: const Text('Share'),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  AppBar _appBar(bool isMyEvent, BuildContext context, EventModel event) {
    return AppBar(
      title: const Text(
        'Event Details',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF3E4B92),
      actions: [
        if (isMyEvent)
          IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventEditButton(
                      eventTitle: event.eventTitle,
                      eventDescription: event.eventDescription,
                      eventDate: event.eventDate,
                      category: event.category,
                      likesAmount: event.likesAmount,
                      eventId: event.id),
                ),
              );
            },
          ),
        if (isMyEvent)
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.white,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => EventDeleteButton(
                  eventId: event.id,
                ),
              );
            },
          ),
      ],
    );
  }
}
