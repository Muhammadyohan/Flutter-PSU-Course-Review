import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/models/event_model.dart';
import 'package:flutter_psu_course_review/repositories/event/event_mock_repo.dart';
import 'package:flutter_psu_course_review/repositories/event/event_repository.dart';

class EventCategoryPage extends StatefulWidget {
  final String category;

  const EventCategoryPage({super.key, required this.category});

  @override
  _EventCategoryPageState createState() => _EventCategoryPageState();
}

class _EventCategoryPageState extends State<EventCategoryPage> {
  final EventRepository _eventRepository = EventMockRepo();
  List<EventModel> _posts = [];
  List<EventModel> _filteredPosts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      final posts = await _eventRepository.fetchTasks();
      setState(() {
        _posts =
            posts.where((post) => post.category == widget.category).toList();
        _filteredPosts = _posts;
      });
    } catch (e) {
      // Handle error
    }
  }

  void _searchPosts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredPosts = _posts;
      } else {
        _filteredPosts = _posts.where((post) {
          final titleMatches =
              post.eventTitle.toLowerCase().contains(query.toLowerCase());
          return titleMatches;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Events'),
        backgroundColor: const Color(0xFF3E4B92),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _searchPosts,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredPosts.length,
              itemBuilder: (context, index) {
                final event = _filteredPosts[index];
                return _buildEventCard(context, event);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, EventModel event) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => EventDetailPage(eventTitle: event.title),
        //   ),
        // );
      },
      child: Container(
        height: 120,
        margin: const EdgeInsets.only(bottom: 12),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      event.eventTitle,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            color: Colors.white, size: 12),
                        const SizedBox(width: 5),
                        Text(event.eventDate,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12)),
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
  }
}
