import 'package:flutter_psu_course_review/models/course_model.dart';

abstract class CourseRepository {
  Future<void> createCourse({
    required String courseCode,
    required String courseName,
    required String courseDescription,
  });

  Future<CourseModel> getCourse({required String courseId});

  Future<List<CourseModel>> getCourses({int page = 1});

  Future<void> updateCourse({
    required String courseId,
    required String courseCode,
    required String courseName,
    required String courseDescription,
    required String reviewPostAmounts,
  });

  Future<void> deleteCourse({required String courseId});
}
