import 'package:flutter_psu_course_review/models/course_model.dart';

abstract class CourseRepository {
  Future<String> createCourse({
    required String courseCode,
    required String courseName,
    required String courseDescription,
  });

  Future<CourseModel> getCourse({required int courseId});

  Future<List<CourseModel>> getCourses({int page = 1});

  Future<String> updateCourse({
    required int courseId,
    required String courseCode,
    required String courseName,
    required String courseDescription,
  });

  Future<String> deleteCourse({required int courseId});
}
