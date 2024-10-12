import 'package:bloc/bloc.dart';
import 'package:flutter_psu_course_review/blocs/comment/comment_event.dart';
import 'package:flutter_psu_course_review/blocs/comment/comment_state.dart';
import 'package:flutter_psu_course_review/models/comment_model.dart';
import 'package:flutter_psu_course_review/repositories/comment/comment_repository.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;
  final List<CommentModel> emptyCommentList = [];

  CommentBloc({required this.commentRepository})
      : super(LoadingCommentState()) {
    on<LoadCommentEvent>(_onLoadedComment);
    on<LoadCommentsEvent>(_onLoadedComments);
    on<LoadCommentsByReviewPostIdEvent>(_onLoadedCommentsByReviewPostId);
    on<CreateCommentEvent>(_onCreatedComment);
    on<UpdateCommentEvent>(_onUpdatedComment);
    on<DeleteCommentEvent>(_onDeletedComment);
  }

  _onLoadedComment(LoadCommentEvent event, Emitter<CommentState> emit) async {
    if (state is LoadingCommentState) {
      final comment =
          await commentRepository.getComment(commentId: event.commentId);
      emit(ReadyCommentState(comment: comment, comments: emptyCommentList));
    }
  }

  _onLoadedComments(LoadCommentsEvent event, Emitter<CommentState> emit) async {
    if (state is LoadingCommentState) {
      final comments = await commentRepository.getComments(page: event.page);
      emit(
          ReadyCommentState(comment: CommentModel.empty(), comments: comments));
    }
  }

  _onLoadedCommentsByReviewPostId(
      LoadCommentsByReviewPostIdEvent event, Emitter<CommentState> emit) async {
    if (state is LoadingCommentState) {
      final comments = await commentRepository.getCommentsByReviewPostId(
          reviewPostId: event.reviewPostId, page: event.page);
      emit(
          ReadyCommentState(comment: CommentModel.empty(), comments: comments));
    }
  }

  _onCreatedComment(
      CreateCommentEvent event, Emitter<CommentState> emit) async {
    if (state is ReadyCommentState) {
      final response = await commentRepository.createComment(
          text: event.text, reviewPostId: event.reviewPostId);
      emit(LoadingCommentState(responseText: response));
    }
  }

  _onUpdatedComment(
      UpdateCommentEvent event, Emitter<CommentState> emit) async {
    if (state is ReadyCommentState) {
      final response = await commentRepository.updateComment(
          text: event.text,
          commentId: event.commentId,
          likesAmount: event.likesAmount);
      emit(LoadingCommentState(responseText: response));
    }
  }

  _onDeletedComment(
      DeleteCommentEvent event, Emitter<CommentState> emit) async {
    if (state is ReadyCommentState) {
      final response =
          await commentRepository.deleteComment(commentId: event.commentId);
      emit(LoadingCommentState(responseText: response));
    }
  }
}
