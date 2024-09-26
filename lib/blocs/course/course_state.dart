import 'package:flutter_psu_course_review/models/models.dart';

sealed class CourseState {
  final List<CourseModel> courses;
  final CourseModel course;
  final String responseText;
  CourseState(
      {required this.courses, required this.course, this.responseText = ''});
}

const List<CourseModel> empty = [];

class LoadingCourseState extends CourseState {
  LoadingCourseState({super.responseText})
      : super(courses: empty, course: CourseModel.empty());
}

class ReadyCourseState extends CourseState {
  ReadyCourseState({required super.courses, required super.course});
}
