import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/models/event_model.dart';
import 'package:flutter_psu_course_review/widgets/my_event_add_button.dart';
import '../widgets/greeting_widget.dart';
import '../widgets/date_selection_widget.dart';
import '../widgets/all_events_widget.dart';
import '../widgets/popular_events_widget.dart';

class PSUEventHub extends StatefulWidget {
  const PSUEventHub({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PSUEventHubState createState() => _PSUEventHubState();
}

class _PSUEventHubState extends State<PSUEventHub> {
  final List<EventModel> _events = [];

  void _addEvent(EventModel newEvent) {
    setState(() {
      _events.add(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GreetingWidget(),
              const DateSelectionWidget(),
              const AllEventsWidget(),
              const PopularEventsWidget(),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: const Icon(Icons.add,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyEventAddButton(onEventAdded: _addEvent),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
