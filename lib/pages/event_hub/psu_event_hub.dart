import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

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
