import 'package:flutter_psu_course_review/models/models.dart';
import 'package:flutter_psu_course_review/repositories/repositories.dart';
import 'package:flutter_psu_course_review/services/services.dart';

class CommentRepoFromDB extends CommentRepository {
  late List<CommentModel> comments = [];

  late CommentModel commentModel;
  late CommentModelList commentModelList;

  final ApiService apiService = ApiService();
  final String baseUri = '/comments';

  @override
  Future<List<CommentModel>> fetchTasks() {
    throw UnimplementedError();
  }

  @override
  Future<String> createComment({
    required String text,
    required int reviewPostId,
  }) async {
    final response = await apiService.post(baseUri, data: {
      'comment_text': text,
      'review_post_id': reviewPostId,
    });

    if (response.statusCode == 200) {
      return 'Comment created successfully';
    } else {
      throw Exception('Failed to create comment');
    }
  }

  @override
  Future<List<CommentModel>> getComments({
    int page = 1,
  }) async {
    final response = await apiService.get(baseUri, queryParameters: {
      'page': page,
    });

    if (response.statusCode == 200) {
      commentModelList = CommentModelList.fromJson(response.data);
      comments = commentModelList.comments;
      return comments;
    } else {
      throw Exception('Failed to fetch comments');
    }
  }

  @override
  Future<List<CommentModel>> getCommentsByReviewPostId({
    required int reviewPostId,
    int page = 1,
  }) async {
    final response = await apiService.get(
      '$baseUri/review_post_id/$reviewPostId',
      queryParameters: {
        'page': page,
      },
    );

    if (response.statusCode == 200) {
      commentModelList = CommentModelList.fromJson(response.data);
      comments = commentModelList.comments;
      return comments;
    } else {
      throw Exception('Failed to fetch comments');
    }
  }

  @override
  Future<CommentModel> getComment({required int commentId}) async {
    final response = await apiService.get('$baseUri/$commentId');

    if (response.statusCode == 200) {
      commentModel = CommentModel.fromJson(response.data);
      return commentModel;
    } else {
      throw Exception('Failed to fetch comment');
    }
  }

  @override
  Future<String> updateComment({
    required String text,
    required int likesAmount,
    required int commentId,
  }) async {
    final response = await apiService.put(
      '$baseUri/$commentId',
      data: {
        'comment_text': text,
        'likes_amount': likesAmount,
      },
    );

    if (response.statusCode == 200) {
      return 'Comment updated successfully';
    } else {
      throw Exception('Failed to update comment');
    }
  }

  @override
  Future<String> deleteComment({required int commentId}) async {
    final response = await apiService.delete('$baseUri/$commentId');

    if (response.statusCode == 200) {
      return response.data['message'];
    } else {
      throw Exception('Failed to delete comment');
    }
  }
}
