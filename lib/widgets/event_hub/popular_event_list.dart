import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs.dart';
import '../../pages/event_hub/event_detail_page.dart';

class PopularEventList extends StatelessWidget {
  const PopularEventList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final events = context.select((EventBloc bloc) => bloc.state.events);
    final myUserId = context.select((UserBloc bloc) => bloc.state.user.id);
    return events.isEmpty
        ? const Center(
            child: Text("Nothing to show."),
          )
        : SingleChildScrollView(
            child: LimitedBox(
              maxHeight: 350,
              child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Hero(
                          tag: 'event_${events[index].id}',
                          child: TweenAnimationBuilder(
                            duration: const Duration(milliseconds: 200),
                            tween: Tween<double>(begin: 1, end: 0.95),
                            builder: (context, scale, child) {
                              return Transform.scale(
                                scale: scale,
                                child: child,
                              );
                            },
                            child: GestureDetector(
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
                                    builder: (context) => EventDetailPage(
                                        eventId: events[index].id),
                                  ),
                                );
                              },
                              child: Container(
                                width: 350,
                                height: 100,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF3E4B92),
                                      Color(0xFF5C6BC0)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
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
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                const Icon(Icons.event,
                                                    color: Colors.white70,
                                                    size: 16),
                                                const SizedBox(width: 8),
                                                Text(
                                                  events[index].category,
                                                  style: const TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                const Icon(Icons.calendar_today,
                                                    color: Colors.white70,
                                                    size: 14),
                                                const SizedBox(width: 8),
                                                Text(events[index].eventDate,
                                                    style: const TextStyle(
                                                        color: Colors.white70,
                                                        fontSize: 14)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 120,
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/psu-course-review-appbar.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  }),
            ),
          );
  }
}
