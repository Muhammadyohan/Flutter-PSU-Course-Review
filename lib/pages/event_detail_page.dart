import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  final String eventTitle;

  EventDetailPage({required this.eventTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventTitle),
        backgroundColor: Color(0xFF3E4B92),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventTitle,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF3E4B92)),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.calendar_today, color: Color(0xFF3E4B92)),
                SizedBox(width: 8),
                Text('Sep 17, 2024', style: TextStyle(fontSize: 16, color: Color(0xFF3E4B92))),
              ],
            ),
            SizedBox(height: 20),
            const Text(
              'รายละเอียดของกิจกรรมจะถูกแสดงที่นี่. เช่น สถานที่จัดกิจกรรม เวลา และรายละเอียดเพิ่มเติมอื่น ๆ.',
              style: TextStyle(fontSize: 16, color: Color(0xFF3E4B92)),
            ),
            SizedBox(height: 20),
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