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
  void addComment(CommentModel comment) {
    _tasks.add(comment);
  }
}
