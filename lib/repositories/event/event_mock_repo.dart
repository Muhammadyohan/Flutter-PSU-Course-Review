import 'package:flutter_psu_course_review/models/event_model.dart';
import 'package:flutter_psu_course_review/repositories/event/event_repository.dart';

class EventMockRepo extends EventRepository {
  final List<EventModel> _task = [
    EventModel(
        eventTitle: 'งานชกมวย',
        eventDescription: 'สนามบอล',
        eventDate: '17/08/68',
        category: 'Sports',
        authorName: 'Pea'),
    EventModel(
        eventTitle: 'งานฟุตบอล',
        eventDescription: 'สนามบอล',
        eventDate: '17/08/68',
        category: 'Sports',
        authorName: 'Pea'),
    EventModel(
        eventTitle: 'งานร้องเพลง',
        eventDescription: 'BSC',
        eventDate: '17/08/68',
        category: 'Concert',
        authorName: 'Pea'),
  ];
  @override
  Future<List<EventModel>> fetchTasks() async {
    await Future.delayed(const Duration(seconds: 2));
    return _task;
  }

  @override
  Future<String> createEvent(
      {required String eventTitle,
      required String eventDescription,
      required String eventDate,
      required String catagory}) {
    throw UnimplementedError();
  }

  @override
  Future<String> deleteEvent({required int eventId}) {
    throw UnimplementedError();
  }

  @override
  Future<EventModel> getEvent({required int eventId}) {
    throw UnimplementedError();
  }

  @override
  Future<List<EventModel>> getEvents({int page = 1}) {
    throw UnimplementedError();
  }

  @override
  Future<String> updateEvent(
      {required String eventTitle,
      required String eventDescription,
      required String eventDate,
      required String catagory,
      required int likesAmount,
      required int eventId}) {
    throw UnimplementedError();
  }
}
