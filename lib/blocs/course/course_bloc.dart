import 'package:bloc/bloc.dart';
import 'package:flutter_psu_course_review/blocs/course/course_event.dart';
import 'package:flutter_psu_course_review/blocs/course/course_state.dart';
import 'package:flutter_psu_course_review/models/course_model.dart';
import 'package:flutter_psu_course_review/repositories/course/course_repository.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository courseRepository;
  final List<CourseModel> emptyCourseList = [];

  CourseBloc({required this.courseRepository}) : super(LoadingCourseState()) {
    on<LoadCourseEvent>(_onLoadedCourse);
    on<LoadCoursesEvent>(_onLoadedCourses);
    on<CreateCourseEvent>(_onCreatedCourse);
    on<UpdateCourseEvent>(_onUpdatedCourse);
    on<DeleteCourseEvent>(_onDeletedCourse);
  }

  _onLoadedCourse(LoadCourseEvent event, Emitter<CourseState> emit) async {
    if (state is LoadingCourseState) {
      final course = await courseRepository.getCourse(courseId: event.courseId);
      emit(ReadyCourseState(course: course, courses: emptyCourseList));
    }
  }

  _onLoadedCourses(LoadCoursesEvent event, Emitter<CourseState> emit) async {
    if (state is LoadingCourseState) {
      final courses = await courseRepository.getCourses(page: event.page);
      emit(ReadyCourseState(course: CourseModel.empty(), courses: courses));
    }
  }

  _onCreatedCourse(CreateCourseEvent event, Emitter<CourseState> emit) async {
    if (state is ReadyCourseState) {
      final response = await courseRepository.createCourse(
        courseCode: event.courseCode,
        courseName: event.courseName,
        courseDescription: event.courseDescription,
      );
      emit(LoadingCourseState(responseText: response));
      add(LoadCoursesEvent());
    }
  }

  _onUpdatedCourse(UpdateCourseEvent event, Emitter<CourseState> emit) async {
    if (state is ReadyCourseState) {
      final response = await courseRepository.updateCourse(
        courseId: event.courseId,
        courseCode: event.courseCode,
        courseName: event.courseName,
        courseDescription: event.courseDescription,
      );
      emit(LoadingCourseState(responseText: response));
      add(LoadCoursesEvent());
    }
  }

  _onDeletedCourse(DeleteCourseEvent event, Emitter<CourseState> emit) async {
    if (state is ReadyCourseState) {
      final response =
          await courseRepository.deleteCourse(courseId: event.courseId);
      emit(LoadingCourseState(responseText: response));
      add(LoadCoursesEvent());
    }
  }
}
