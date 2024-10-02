import 'package:flutter_psu_course_review/models/models.dart';
import 'package:flutter_psu_course_review/repositories/repositories.dart';
import 'package:flutter_psu_course_review/services/services.dart';

class ReviewPostRepoFromDB extends ReviewPostRepository {
  late List<ReviewPostModel> reviewPosts = [];

  late ReviewPostModel reviewPostModel;
  late ReviewPostModelList reviewPostModelList;

  final ApiService apiService = ApiService();
  final String baseUri = '/review_posts';

  @override
  Future<List<ReviewPostModel>> fetchTasks() {
    throw UnimplementedError();
  }

  @override
  Future<String> createReviewPost({
    required String title,
    required String text,
    required int courseId,
  }) async {
    final response = await apiService.post(baseUri, data: {
      'review_post_title': title,
      'review_post_text': text,
      'course_id': courseId,
    });

    if (response.statusCode == 200) {
      return 'Review post created successfully';
    } else if (response.statusCode == 401) {
      return response.data['detail'];
    } else {
      throw Exception('Failed to create review post');
    }
  }

  @override
  Future<List<ReviewPostModel>> getReviewPosts({
    int page = 1,
  }) async {
    final response = await apiService.get(baseUri, queryParameters: {
      'page': page,
    });

    if (response.statusCode == 200) {
      reviewPostModelList = ReviewPostModelList.fromJson(response.data);
      reviewPosts = reviewPostModelList.reviewPosts;
      return reviewPosts;
    } else {
      throw Exception('Failed to get review posts');
    }
  }

  @override
  Future<List<ReviewPostModel>> getReviewPostsByCourseId({
    required int courseId,
    int page = 1,
  }) async {
    final response = await apiService.get(
      '$baseUri/course/$courseId',
      queryParameters: {
        'page': page,
      },
    );

    if (response.statusCode == 200) {
      reviewPostModelList = ReviewPostModelList.fromJson(response.data);
      reviewPosts = reviewPostModelList.reviewPosts;
      return reviewPosts;
    } else {
      throw Exception('Failed to get review posts');
    }
  }

  @override
  Future<ReviewPostModel> getReviewPost({required int reviewPostId}) async {
    final response = await apiService.get('$baseUri/$reviewPostId');

    if (response.statusCode == 200) {
      reviewPostModel = ReviewPostModel.fromJson(response.data);
      return reviewPostModel;
    } else {
      throw Exception('Failed to get review post');
    }
  }

  @override
  Future<String> updateReviewPost({
    required String title,
    required String text,
    required int likesAmount,
    required int reviewPostId,
  }) async {
    final response = await apiService.put(
      '$baseUri/$reviewPostId',
      data: {
        'review_post_title': title,
        'review_post_text': text,
        'likes_amount': likesAmount,
      },
    );

    if (response.statusCode == 200) {
      return 'Review post updated successfully';
    } else if (response.statusCode == 401) {
      return response.data['detail'];
    } else {
      throw Exception('Failed to update review post');
    }
  }

  @override
  Future<String> deleteReviewPost({required int reviewPostId}) async {
    final response = await apiService.delete('$baseUri/$reviewPostId');

    if (response.statusCode == 200) {
      return response.data['message'];
    } else if (response.statusCode == 401) {
      return response.data['detail'];
    } else {
      throw Exception('Failed to delete review post');
    }
  }
}
