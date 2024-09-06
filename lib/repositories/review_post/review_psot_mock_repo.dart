import 'package:flutter_psu_course_review/models/review_post_model.dart';

abstract class ReviewPostItemRepository{
  Future<List<ReviewPostModel>> fetchTasks();
}