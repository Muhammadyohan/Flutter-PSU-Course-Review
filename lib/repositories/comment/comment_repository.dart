import 'package:flutter_psu_course_review/models/models.dart';

abstract class CommentRepository {
  Future<List<CommentModel>> fetchTasks();

  Future<void> createComment({
    required String text,
    required int reviewPostId,
  });

  Future<List<CommentModel>> getComments({
    int page = 1,
  });

  Future<List<CommentModel>> getCommentsByReviewPostId({
    required int reviewPostId,
    int page = 1,
  });

  Future<CommentModel> getComment({required int commentId});

  Future<void> updateComment({
    required String text,
    required int likesAmount,
    required int commentId,
  });

  Future<void> deleteComment({required int commentId});
}
