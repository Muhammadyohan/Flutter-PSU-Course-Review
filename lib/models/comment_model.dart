import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  final String commentText;
  final String commentAuthor;
  final int likesAmount;
  final int reviewPostId;
  final int userId;
  final int id;

  const CommentModel({
    required this.commentText,
    required this.commentAuthor,
    this.likesAmount = 0,
    this.reviewPostId = 0,
    this.userId = 0,
    this.id = 0,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentText: json['comment_text'],
      commentAuthor: json['comment_author'],
      likesAmount: json['likes_amount'],
      reviewPostId: json['review_post_id'],
      userId: json['user_id'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment_text': commentText,
      'comment_author': commentAuthor,
      'likes_amount': likesAmount,
      'review_post_id': reviewPostId,
      'user_id': userId,
      'id': id,
    };
  }

  factory CommentModel.empty() {
    return const CommentModel(
      commentText: '',
      commentAuthor: '',
      likesAmount: 0,
      reviewPostId: 0,
      userId: 0,
      id: 0,
    );
  }

  @override
  List<Object?> get props =>
      [commentText, commentAuthor, likesAmount, reviewPostId, userId, id];
}

class CommentModelList extends Equatable {
  final List<CommentModel> comments;
  final int page;
  final int pageCount;
  final int sizePerPage;

  const CommentModelList({
    required this.comments,
    required this.page,
    required this.pageCount,
    required this.sizePerPage,
  });

  factory CommentModelList.fromJson(Map<String, dynamic> json) {
    List<CommentModel> comments = [];
    for (var comment in json['comments']) {
      comments.add(CommentModel.fromJson(comment));
    }
    return CommentModelList(
      comments: comments,
      page: json['page'],
      pageCount: json['page_count'],
      sizePerPage: json['size_per_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'page': page,
      'page_count': pageCount,
      'size_per_page': sizePerPage,
    };
  }

  @override
  List<Object?> get props => [comments, page, pageCount, sizePerPage];
}
