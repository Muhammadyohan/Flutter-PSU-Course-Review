import 'package:flutter_psu_course_review/models/models.dart';

abstract class ReviewPostRepository {
  Future<List<ReviewPostModel>> fetchTasks();

  Future<void> createReviewPost({
    required String title,
    required String text,
    required int courseId,
  });

  Future<List<ReviewPostModel>> getReviewPosts({
    int page = 1,
  });

  Future<List<ReviewPostModel>> getReviewPostsByCourseId({
    required int courseId,
    int page = 1,
  });

  Future<ReviewPostModel> getReviewPost({required int reviewPostId});

  Future<void> updateReviewPost({
    required String title,
    required String text,
    required int likesAmount,
    required int reviewPostId,
  });

  Future<void> deleteReviewPost({required int reviewPostId});
}
