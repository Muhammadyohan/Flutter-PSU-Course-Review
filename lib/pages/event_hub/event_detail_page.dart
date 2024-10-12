import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';
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
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text(event.eventTitle),
                  backgroundColor: const Color(0xFF3E4B92),
                  actions: [
                    if (isMyEvent)
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventEditButton(),
                              ));
                        },
                        child: const Icon(Icons.edit)),
                    const SizedBox(
                      width: 10,
                    ),
                    if (isMyEvent)
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return EventDeleteButton();
                            },
                          );
                        },
                        child: const Icon(Icons.delete))
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.eventTitle,
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E4B92)),
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Icon(Icons.calendar_today, color: Color(0xFF3E4B92)),
                          SizedBox(width: 8),
                          Text('Sep 17, 2024',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF3E4B92))),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'รายละเอียดของกิจกรรมจะถูกแสดงที่นี่. เช่น สถานที่จัดกิจกรรม เวลา และรายละเอียดเพิ่มเติมอื่น ๆ.',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF3E4B92)),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://www.psu.ac.th/static/images/faculty/science.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
