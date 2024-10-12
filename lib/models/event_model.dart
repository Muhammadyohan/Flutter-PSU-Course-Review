import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class EventModel extends Equatable {
  String eventTitle;
  String eventDescription;
  String eventDate;
  String category;
  final int likesAmount;
  final String authorName;
  final int userId;
  final int id;

  EventModel({
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.category,
    this.likesAmount = 0,
    required this.authorName,
    this.userId = 0,
    this.id = 0,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventTitle: json['event_title'],
      eventDescription: json['event_description'],
      eventDate: json['event_date'],
      category: json['category'],
      likesAmount: json['likes_amount'],
      authorName: json['author_name'],
      userId: json['user_id'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_title': eventTitle,
      'event_description': eventDescription,
      'event_date': eventDate,
      'category': category,
      'likes_amount': likesAmount,
      'author_name': authorName,
      'user_id': userId,
      'id': id,
    };
  }

  factory EventModel.empty() {
    return EventModel(
      eventTitle: '',
      eventDescription: '',
      eventDate: '',
      category: '',
      likesAmount: 0,
      authorName: '',
      userId: 0,
      id: 0,
    );
  }

  @override
  List<Object?> get props => [
        eventTitle,
        eventDescription,
        eventDate,
        category,
        likesAmount,
        authorName,
        userId,
        id,
      ];
}

class EventModelList extends Equatable {
  final List<EventModel> events;
  final int page;
  final int pageCount;
  final int sizePerPage;

  const EventModelList({
    required this.events,
    required this.page,
    required this.pageCount,
    required this.sizePerPage,
  });

  factory EventModelList.fromJson(Map<String, dynamic> json) {
    List<EventModel> events = [];
    for (var event in json['events']) {
      events.add(EventModel.fromJson(event));
    }
    return EventModelList(
      events: events,
      page: json['page'],
      pageCount: json['page_count'],
      sizePerPage: json['size_per_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'events': events.map((event) => event.toJson()).toList(),
      'page': page,
      'page_count': pageCount,
      'size_per_page': sizePerPage,
    };
  }

  @override
  List<Object?> get props => [
        events,
        page,
        pageCount,
        sizePerPage,
      ];
}
