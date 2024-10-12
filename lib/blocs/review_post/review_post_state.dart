import 'package:flutter_psu_course_review/models/models.dart';

sealed class ReviewPostState {
  final List<ReviewPostModel> reviewPosts;
  final ReviewPostModel reviewPost;
  final String responseText;
  ReviewPostState(
      {required this.reviewPosts,
      required this.reviewPost,
      this.responseText = ''});
}

const List<ReviewPostModel> emptyReviewPostList = [];

class LoadingReviewPostState extends ReviewPostState {
  LoadingReviewPostState({super.responseText})
      : super(
            reviewPosts: emptyReviewPostList,
            reviewPost: ReviewPostModel.empty());
}

class ReadyReviewPostState extends ReviewPostState {
  ReadyReviewPostState({required super.reviewPosts, required super.reviewPost});
}
