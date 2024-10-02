import 'package:flutter_psu_course_review/models/event_model.dart';

abstract class EventRepository{
  Future<List<EventModel>> fetchTasks();
}