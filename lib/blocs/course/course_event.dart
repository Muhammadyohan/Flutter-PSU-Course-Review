sealed class CourseEvent {}

class LoadCourseEvent extends CourseEvent {
  final int courseId;
  LoadCourseEvent({required this.courseId});
}

class LoadCoursesEvent extends CourseEvent {
  final int page;
  LoadCoursesEvent({this.page = 1});
}

class CreateCourseEvent extends CourseEvent {
  final String courseCode;
  final String courseName;
  final String courseDescription;

  CreateCourseEvent({
    required this.courseCode,
    required this.courseName,
    required this.courseDescription,
  });
}

class UpdateCourseEvent extends CourseEvent {
  final int courseId;
  final String courseCode;
  final String courseName;
  final String courseDescription;

  UpdateCourseEvent({
    required this.courseId,
    required this.courseCode,
    required this.courseName,
    required this.courseDescription,
  });
}

class DeleteCourseEvent extends CourseEvent {
  final int courseId;
  DeleteCourseEvent({required this.courseId});
}
