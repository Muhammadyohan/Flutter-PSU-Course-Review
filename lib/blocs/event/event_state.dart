import 'package:flutter_psu_course_review/models/models.dart';

sealed class EventState {
  final List<EventModel> events;
  final EventModel event;
  final String responseText;
  final bool isMyEvent;
  EventState(
      {required this.events,
      required this.event,
      this.responseText = '',
      this.isMyEvent = false});
}

const List<EventModel> emptyEventList = [];

class LoadingEventState extends EventState {
  LoadingEventState({super.responseText, super.isMyEvent})
      : super(events: emptyEventList, event: EventModel.empty());
}

class ReadyEventState extends EventState {
  ReadyEventState({required super.events, required super.event});
}
