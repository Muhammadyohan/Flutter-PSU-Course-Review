import 'package:flutter_psu_course_review/models/models.dart';
import 'package:flutter_psu_course_review/repositories/repositories.dart';
import 'package:flutter_psu_course_review/services/api_service.dart';

class CourseRepoFromDB extends CourseRepository {
  late List<CourseModel> courses = [];

  late CourseModel courseModel;
  late CourseModelList courseModelList;

  final ApiService apiService = ApiService();
  final String baseUri = '/courses';

  @override
  Future<String> createCourse({
    required String courseCode,
    required String courseName,
    required String courseDescription,
  }) async {
    final Map<String, dynamic> courseData = {
      'course_code': courseCode,
      'course_name': courseName,
      'course_description': courseDescription,
    };
    final response = await apiService.post(baseUri, data: courseData);

    if (response.statusCode == 200) {
      return ('Course created successfully');
    } else {
      throw Exception('Failed to create course');
    }
  }

  @override
  Future<CourseModel> getCourse({required String courseId}) async {
    final response = await apiService.get('$baseUri/$courseId');

    if (response.statusCode == 200) {
      courseModel = CourseModel.fromJson(response.data);
      return courseModel;
    } else {
      throw Exception('Failed to getcourse');
    }
  }

  @override
  Future<List<CourseModel>> getCourses({int page = 1}) async {
    final response = await apiService.get(baseUri, queryParameters: {
      'page': page,
    });

    if (response.statusCode == 200) {
      courseModelList = CourseModelList.fromJson(response.data);
      courses = courseModelList.courses;
      return courses;
    } else {
      throw Exception('Failed to getcourses');
    }
  }

  @override
  Future<String> updateCourse({
    required String courseId,
    required String courseCode,
    required String courseName,
    required String courseDescription,
    required String reviewPostAmounts,
  }) async {
    final Map<String, dynamic> courseDataUpdated = {
      'course_code': courseCode,
      'course_name': courseName,
      'course_description': courseDescription,
      'review_posts_amount': reviewPostAmounts,
    };

    final response =
        await apiService.put('$baseUri/$courseId', data: courseDataUpdated);

    if (response.statusCode == 200) {
      return 'Course updated successfully';
    } else {
      throw Exception('Failed to update course');
    }
  }

  @override
  Future<String> deleteCourse({required String courseId}) async {
    final response = await apiService.delete('$baseUri/$courseId');
    if (response.statusCode == 200) {
      return response.data['message'];
    } else {
      throw Exception('Failed to delete course');
    }
  }
}
