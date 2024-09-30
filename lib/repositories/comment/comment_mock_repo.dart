import 'package:flutter_psu_course_review/models/comment_model.dart';
import 'package:flutter_psu_course_review/repositories/comment/comment_repository.dart';

class CommentMockRepo extends CommentRepository {
  final List<CommentModel> _tasks = [
    const CommentModel(commentText: 'Yeah, I think so', commentAuthor: 'pea'),
    const CommentModel(commentText: 'no', commentAuthor: 'x')
  ];

  @override
  Future<List<CommentModel>> fetchTasks() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _tasks;
  }

  @override
  Future<void> createComment({
    required String text,
    required int reviewPostId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<List<CommentModel>> getComments({
    int page = 1,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<List<CommentModel>> getCommentsByReviewPostId({
    required int reviewPostId,
    int page = 1,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<CommentModel> getComment({required int commentId}) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateComment({
    required String text,
    required int likesAmount,
    required int commentId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteComment({required int commentId}) {
    throw UnimplementedError();
  }

  void addComment(CommentModel comment) {
    _tasks.add(comment);
  }
}
