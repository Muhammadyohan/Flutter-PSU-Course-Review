sealed class EventEvent {}

class LoadEventEvent extends EventEvent {
  final int eventId;
  LoadEventEvent({required this.eventId});
}

class LoadEventsEvent extends EventEvent {
  final int page;
  LoadEventsEvent({this.page = 1});
}

class SelectEventEvent extends EventEvent {
  final int eventId;
  final int eventUserId;
  final int myUserId;
  SelectEventEvent(
      {required this.eventId,
      required this.eventUserId,
      required this.myUserId});
}

class CreateEventEvent extends EventEvent {
  final String eventTitle;
  final String eventDescription;
  final String eventDate;
  final String category;
  CreateEventEvent({
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.category,
  });
}

class UpdateEventEvent extends EventEvent {
  final String eventTitle;
  final String eventDescription;
  final String eventDate;
  final String category;
  final int likesAmount;
  final int eventId;
  UpdateEventEvent({
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.category,
    required this.likesAmount,
    required this.eventId,
  });
}

class DeleteEventEvent extends EventEvent {
  final int eventId;
  DeleteEventEvent({required this.eventId});
}
