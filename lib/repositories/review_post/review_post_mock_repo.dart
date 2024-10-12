import 'package:flutter_psu_course_review/models/review_post_model.dart';
import 'package:flutter_psu_course_review/repositories/review_post/review_post_repository.dart';

class ReviewPostMockRepo extends ReviewPostRepository {
  final List<ReviewPostModel> _tasks = [
    ReviewPostModel(
        title: 'This course is so good',
        text:
            'This course is about mobile app developer. It is good to learn and give me good grade',
        authorName: 'Pea',
        courseCode: '240-001',
        courseName: 'Mobile app developer'),
    ReviewPostModel(
        title: 'This course is so bad',
        text: 'This course is bad',
        authorName: 'X',
        courseCode: '240-002',
        courseName: 'Maew'),
    ReviewPostModel(
        title: 'I love this course',
        text: 'yqekqe',
        authorName: 'Maew',
        courseCode: '240-003',
        courseName: 'Web developer'),
    ReviewPostModel(
        title: '1',
        text: 'yqekqe',
        authorName: 'Maew',
        courseCode: '240-0004',
        courseName: 'maew'),
    ReviewPostModel(
        title: '2',
        text: 'yqekqe',
        authorName: 'Maew',
        courseCode: '240-005',
        courseName: 'Web wqweqe'),
    ReviewPostModel(
        title: '3',
        text: 'yqekqe',
        authorName: 'Maew',
        courseCode: '240-006',
        courseName: 'maew developer'),
  ];

  @override
  Future<List<ReviewPostModel>> fetchTasks() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _tasks;
  }

  @override
  Future<String> createReviewPost({
    required String title,
    required String text,
    required int courseId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<List<ReviewPostModel>> getReviewPosts({
    int page = 1,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<ReviewPostModel> getReviewPost({required int reviewPostId}) {
    throw UnimplementedError();
  }

  @override
  Future<String> updateReviewPost({
    required String title,
    required String text,
    required int likesAmount,
    required int reviewPostId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<String> deleteReviewPost({required int reviewPostId}) {
    throw UnimplementedError();
  }
}
