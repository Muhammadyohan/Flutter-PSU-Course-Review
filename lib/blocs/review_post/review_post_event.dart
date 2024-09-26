sealed class ReviewPostEvent {}

class LoadReviewPostEvent extends ReviewPostEvent {
  final int reviewPostId;
  LoadReviewPostEvent({required this.reviewPostId});
}

class LoadReviewPostsEvent extends ReviewPostEvent {
  final int page;
  LoadReviewPostsEvent({this.page = 1});
}

class LoadReviewPostsByCourseIdEvent extends ReviewPostEvent {
  final int courseId;
  final int page;

  LoadReviewPostsByCourseIdEvent({required this.courseId, this.page = 1});
}

class CreateReviewPostEvent extends ReviewPostEvent {
  final String title;
  final String text;
  final int courseId;

  CreateReviewPostEvent({
    required this.title,
    required this.text,
    required this.courseId,
  });
}

class UpdateReviewPostEvent extends ReviewPostEvent {
  final String title;
  final String text;
  final int likesAmount;
  final int reviewPostId;

  UpdateReviewPostEvent({
    required this.title,
    required this.text,
    required this.likesAmount,
    required this.reviewPostId,
  });
}

class DeleteReviewPostEvent extends ReviewPostEvent {
  final int reviewPostId;
  DeleteReviewPostEvent({required this.reviewPostId});
}
