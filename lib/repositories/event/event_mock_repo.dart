import 'package:flutter_psu_course_review/models/event_model.dart';
import 'package:flutter_psu_course_review/repositories/event/event_repository.dart';

class EventMockRepo extends EventRepository{
  final List<EventModel> _task = [
    EventModel('งานชกมวย', 'สนามบอล', 'ได้ชั่วโมง 2 ชั่วโมง', '17/08/68', '14.00', '18.00', 'Sports', 'Pea'),
    EventModel('งานฟุตบอล', 'สนามบอล', 'ได้ชั่วโมง 2 ชั่วโมง', '17/08/68', '14.00', '18.00', 'Sports', 'Pea'),
    EventModel('งานร้องเพลง', 'BSC', 'ได้ชั่วโมง 2 ชั่วโมง', '17/08/68', '14.00', '18.00', 'Concert', 'Pea'),
    
  ];
  @override
  Future<List<EventModel>> fetchTasks() async{
    await Future.delayed(const Duration(seconds: 2));
    return _task;
  }
}