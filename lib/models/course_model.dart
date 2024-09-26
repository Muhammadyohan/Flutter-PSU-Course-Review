import 'package:equatable/equatable.dart';

class CourseModel extends Equatable {
  final String courseCode;
  final String courseName;
  final String courseDescription;
  final int reviewPostsAmount;
  final int userId;
  final int id;

  const CourseModel({
    required this.courseCode,
    required this.courseName,
    required this.courseDescription,
    this.reviewPostsAmount = 0,
    this.userId = 0,
    this.id = 0,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      courseCode: json['course_code'],
      courseName: json['course_name'],
      courseDescription: json['course_description'],
      reviewPostsAmount: json['review_posts_amount'],
      userId: json['user_id'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_code': courseCode,
      'course_name': courseName,
      'course_description': courseDescription,
      'review_post_amount': reviewPostsAmount,
      'user_id': userId,
      'id': id,
    };
  }

  factory CourseModel.empty() {
    return const CourseModel(
      courseCode: '',
      courseName: '',
      courseDescription: '',
      reviewPostsAmount: 0,
      userId: 0,
      id: 0,
    );
  }

  @override
  List<Object?> get props => [
        courseCode,
        courseName,
        courseDescription,
        reviewPostsAmount,
        userId,
        id
      ];
}

class CourseModelList extends Equatable {
  final List<CourseModel> courses;
  final int page;
  final int pageCount;
  final int sizePerPage;

  const CourseModelList({
    required this.courses,
    required this.page,
    required this.pageCount,
    required this.sizePerPage,
  });

  factory CourseModelList.fromJson(Map<String, dynamic> json) {
    List<CourseModel> courses = [];
    for (var course in json['courses']) {
      courses.add(CourseModel.fromJson(course));
    }
    return CourseModelList(
      courses: courses,
      page: json['page'],
      pageCount: json['page_count'],
      sizePerPage: json['size_per_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courses': courses.map((course) => course.toJson()).toList(),
      'page': page,
      'page_count': pageCount,
      'size_per_page': sizePerPage,
    };
  }

  @override
  List<Object?> get props => [courses, page, pageCount, sizePerPage];
}
