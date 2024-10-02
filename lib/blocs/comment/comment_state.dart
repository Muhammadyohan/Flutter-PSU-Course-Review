import 'package:flutter_psu_course_review/models/models.dart';

sealed class CommentState {
  final List<CommentModel> comments;
  final CommentModel comment;
  final String responseText;
  CommentState(
      {required this.comments,
      required this.comment,
      this.responseText = ''});
}

const List<CommentModel> emptyCommentList = [];

class LoadingCommentState extends CommentState {
  LoadingCommentState({super.responseText})
      : super(
            comments: emptyCommentList,
            comment: CommentModel.empty());
}

class ReadyCommentState extends CommentState {
  ReadyCommentState({required super.comments, required super.comment});
}