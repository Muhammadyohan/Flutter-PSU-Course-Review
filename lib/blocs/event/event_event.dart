sealed class EventEvent {}

class LoadEventEvent extends EventEvent {
  final int eventId;
  LoadEventEvent({required this.eventId});
}

class LoadEventsEvent extends EventEvent {
  final int page;
  LoadEventsEvent({this.page = 1});
}

class LoadMyEventsEvent extends EventEvent {
  final int page;
  LoadMyEventsEvent({this.page = 1});
}

class SearchCategotyEventsEvent extends EventEvent {
  final String searchQuery;
  final int page;
  SearchCategotyEventsEvent({
    required this.searchQuery,
    this.page = 1,
  });
}

class SearchMyEventsEvent extends EventEvent {
  final String searchQuery;
  final int page;
  SearchMyEventsEvent({
    required this.searchQuery,
    this.page = 1,
  });
}

class SearchClearEvent extends EventEvent {}

class LoadEventsByCategoryEvent extends EventEvent {
  final String category;
  final int page;
  LoadEventsByCategoryEvent({
    required this.category,
    this.page = 1,
  });
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

class SelectCategoryEvent extends EventEvent {
  final String category;
  final int page;
  SelectCategoryEvent({
    required this.category,
    this.page = 1,
  });
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
