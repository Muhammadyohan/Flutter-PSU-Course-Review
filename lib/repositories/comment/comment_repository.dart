import 'package:flutter_psu_course_review/models/comment_model.dart';

abstract class CommentRepository {
  Future<List<CommentModel>> fetchTasks();
}
