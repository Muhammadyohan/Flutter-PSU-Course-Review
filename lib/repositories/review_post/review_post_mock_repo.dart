import 'package:flutter_psu_course_review/models/review_post_model.dart';
import 'package:flutter_psu_course_review/repositories/review_post/review_post_repository.dart';

class ReviewPostMockRepo extends ReviewPostRepository {
  final List<ReviewPostModel> _tasks = [
    ReviewPostModel(
        'This course is so good',
        'This course is about mobile app developer. It is good to learn and give me good grade',
        'Pea',
        '240-001',
        'Mobile app developer'),
    ReviewPostModel(
        'This course is so bad', 'This course is bad', 'X', '240-002', 'Maew'),
    ReviewPostModel(
        'I love this course', 'yqekqe', 'Maew', '240-003', 'Web developer'),
  ];

  @override
  Future<List<ReviewPostModel>> fetchTasks() async {
    await Future.delayed(const Duration(seconds: 2));
    return _tasks;
  }
}
