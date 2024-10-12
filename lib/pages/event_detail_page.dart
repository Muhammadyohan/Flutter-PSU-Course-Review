import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/widgets/event_delete_button.dart';
import 'package:flutter_psu_course_review/widgets/event_edit_button.dart';

class EventDetailPage extends StatelessWidget {
  final String eventTitle;

  const EventDetailPage({super.key, required this.eventTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventTitle),
        backgroundColor: const Color(0xFF3E4B92),
        actions: [
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
              eventTitle,
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
                    style: TextStyle(fontSize: 16, color: Color(0xFF3E4B92))),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'รายละเอียดของกิจกรรมจะถูกแสดงที่นี่. เช่น สถานที่จัดกิจกรรม เวลา และรายละเอียดเพิ่มเติมอื่น ๆ.',
              style: TextStyle(fontSize: 16, color: Color(0xFF3E4B92)),
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
  }
}
