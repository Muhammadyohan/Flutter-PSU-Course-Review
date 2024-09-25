import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar View'),
        backgroundColor: Color(0xFF3E4B92),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime(2020),
          lastDay: DateTime(2030),
          calendarFormat: CalendarFormat.month,
          availableGestures: AvailableGestures.none,
          headerVisible: false,
          daysOfWeekVisible: false,
          calendarStyle: const CalendarStyle(
            outsideDaysVisible: false,
            selectedDecoration: BoxDecoration(),
            todayDecoration: BoxDecoration(),
            selectedTextStyle: TextStyle(),
            todayTextStyle: TextStyle(),
          ),
          onDaySelected: (selectedDay, focusedDay) {
          },
          selectedDayPredicate: (day) => false,
        ),
      ),
    );
  }
}
