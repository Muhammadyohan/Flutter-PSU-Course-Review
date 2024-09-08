class CommentModel {
  String commentText;
  String commentAuthor;
  int likesAmount;
  int reviewPostId;
  int userId;
  int id;

  CommentModel({
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
}

class CommentModelList {
  List<CommentModel> comments;
  int page;
  int pageCount;
  int sizePerPage;

  CommentModelList({
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
}
