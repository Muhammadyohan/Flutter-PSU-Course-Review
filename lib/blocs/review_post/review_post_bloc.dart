import 'package:bloc/bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';
import 'package:flutter_psu_course_review/models/review_post_model.dart';
import 'package:flutter_psu_course_review/repositories/review_post/review_post_repository.dart';

class ReviewPostBloc extends Bloc<ReviewPostEvent, ReviewPostState> {
  final ReviewPostRepository reviewPostRepository;
  final List<ReviewPostModel> emptyReviewPostList = [];

  ReviewPostBloc({required this.reviewPostRepository})
      : super(LoadingReviewPostState()) {
    on<LoadReviewPostEvent>(_onLoadedReviewPost);
    on<LoadReviewPostsEvent>(_onLoadedReviewPosts);
    on<CreateReviewPostEvent>(_onCreatedReviewPost);
    on<UpdateReviewPostEvent>(_onUpdatedReviewPost);
    on<DeleteReviewPostEvent>(_onDeletedReviewPost);
  }

  _onLoadedReviewPost(
      LoadReviewPostEvent event, Emitter<ReviewPostState> emit) async {
    if (state is LoadingReviewPostState) {
      final reviewPost = await reviewPostRepository.getReviewPost(
          reviewPostId: event.reviewPostId);
      emit(ReadyReviewPostState(
          reviewPost: reviewPost, reviewPosts: emptyReviewPostList));
    }
  }

  _onLoadedReviewPosts(
      LoadReviewPostsEvent event, Emitter<ReviewPostState> emit) async {
    if (state is LoadingReviewPostState) {
      final reviewPosts =
          await reviewPostRepository.getReviewPosts(page: event.page);
      emit(ReadyReviewPostState(
          reviewPost: ReviewPostModel.empty(), reviewPosts: reviewPosts));
    }
  }

  _onCreatedReviewPost(
      CreateReviewPostEvent event, Emitter<ReviewPostState> emit) async {
    if (state is ReadyReviewPostState) {
      final response = await reviewPostRepository.createReviewPost(
        title: event.title,
        text: event.text,
        courseId: event.courseId,
      );
      emit(LoadingReviewPostState(responseText: response));
      add(LoadReviewPostsEvent());
    }
  }

  _onUpdatedReviewPost(
      UpdateReviewPostEvent event, Emitter<ReviewPostState> emit) async {
    if (state is ReadyReviewPostState) {
      final response = await reviewPostRepository.updateReviewPost(
        reviewPostId: event.reviewPostId,
        title: event.title,
        text: event.text,
        likesAmount: event.likesAmount,
      );
      emit(LoadingReviewPostState(responseText: response));
      add(LoadReviewPostsEvent());
    }
  }

  _onDeletedReviewPost(
      DeleteReviewPostEvent event, Emitter<ReviewPostState> emit) async {
    if (state is ReadyReviewPostState) {
      final response = await reviewPostRepository.deleteReviewPost(
        reviewPostId: event.reviewPostId,
      );
      emit(LoadingReviewPostState(responseText: response));
      add(LoadReviewPostsEvent());
    }
  }
}
