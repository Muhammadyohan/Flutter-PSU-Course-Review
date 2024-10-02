import 'package:flutter/material.dart';
import '../pages/event_detail_page.dart';

class PopularEventsWidget extends StatelessWidget {
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
          SizedBox(height: 12),
          _buildEventCard(context),
          SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailPage(eventTitle: 'งานบอล วิทยาการสาสตร์'),
          ),
        );
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFF3E4B92),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'งานบอล วิศวกรรมศาสตร์',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'ปะทะนิเทศศาสตร์',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.white, size: 12),
                        SizedBox(width: 5),
                        Text('Sep 17, 2024', style: TextStyle(color: Colors.white, fontSize: 12)),
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
    );
  }
}
