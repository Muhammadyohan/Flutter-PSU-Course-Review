import 'package:flutter/material.dart';
import '../widgets/greeting_widget.dart';
import '../widgets/date_selection_widget.dart';
import '../widgets/all_events_widget.dart';
import '../widgets/popular_events_widget.dart';

class PSUEventHub extends StatelessWidget {
  const PSUEventHub({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingWidget(),
              DateSelectionWidget(),
              AllEventsWidget(),
              PopularEventsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
