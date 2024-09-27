sealed class CommentEvent {}

class LoadCommentEvent extends CommentEvent {
  final int commentId;
  LoadCommentEvent({required this.commentId});
}

class LoadCommentsEvent extends CommentEvent {
  final int page;
  LoadCommentsEvent({this.page = 1});
}

class LoadCommentsByReviewPostIdEvent extends CommentEvent {
  final int page;
  final int reviewPostId;
  LoadCommentsByReviewPostIdEvent({required this.reviewPostId, this.page = 1});
}

class CreateCommentEvent extends CommentEvent {
  final String text;
  final int reviewPostId;
  CreateCommentEvent({required this.text, required this.reviewPostId});
}

class UpdateCommentEvent extends CommentEvent {
  final String text;
  final int likesAmount;
  final int commentId;
  UpdateCommentEvent(
      {required this.commentId, required this.likesAmount, required this.text});
}

class DeleteCommentEvent extends CommentEvent {
  final int commentId;
  DeleteCommentEvent({required this.commentId});
}
