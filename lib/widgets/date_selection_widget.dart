import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // ใช้ TableCalendar สำหรับแสดงปฏิทิน

class DateSelectionWidget extends StatefulWidget {
  @override
  _DateSelectionWidgetState createState() => _DateSelectionWidgetState();
}

class _DateSelectionWidgetState extends State<DateSelectionWidget> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  void _showCalendar() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          child: TableCalendar(
            focusedDay: focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            calendarFormat: CalendarFormat.month,
            availableGestures: AvailableGestures.all,
            headerVisible: true,
            daysOfWeekVisible: true,
            selectedDayPredicate: (day) => false,
            onDaySelected: (selected, focused) {
            },
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: true,
              selectedDecoration: BoxDecoration(),
              todayDecoration: BoxDecoration(),
              selectedTextStyle: TextStyle(),
              todayTextStyle: TextStyle(),
            ),
            formatAnimationCurve: Curves.easeInOut,
            formatAnimationDuration: Duration(milliseconds: 200),
          ),
        );
      },
    );
  }  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: GestureDetector(
        onTap: _showCalendar,
        child: Container(
          height: 80,
          child: Center(
            child: Text(
              'Today is : ${selectedDay.day}/${selectedDay.month}/${selectedDay.year}',
              style: TextStyle(fontSize: 18, color: const Color(0xFF3E4B92)),
            ),
          ),
        ),
      ),
    );
  }
}
