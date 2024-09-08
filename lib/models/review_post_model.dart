class ReviewPostModel {
  String title;
  String text;
  int likesAmount;
  String authorName;
  int commentsAmount;
  String courseCode;
  String courseName;
  int courseId;
  int userId;
  int id;

  ReviewPostModel({
    required this.title,
    required this.text,
    this.likesAmount = 0,
    required this.authorName,
    this.commentsAmount = 0,
    required this.courseCode,
    required this.courseName,
    this.courseId = 0,
    this.userId = 0,
    this.id = 0,
  });

  factory ReviewPostModel.fromJson(Map<String, dynamic> json) {
    return ReviewPostModel(
      title: json['review_post_title'],
      text: json['review_post_text'],
      likesAmount: json['likes_amount'],
      authorName: json['author_name'],
      commentsAmount: json['comments_amount'],
      courseCode: json['course_code'],
      courseName: json['course_name'],
      courseId: json['course_id'],
      userId: json['user_id'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'review_post_title': title,
      'review_post_text': text,
      'likes_amount': likesAmount,
      'author_name': authorName,
      'comments_amount': commentsAmount,
      'course_code': courseCode,
      'course_name': courseName,
      'course_id': courseId,
      'user_id': userId,
      'id': id,
    };
  }
}

class ReviewPostModelList {
  List<ReviewPostModel> reviewPosts;
  int page;
  int pageCount;
  int sizePerPage;

  ReviewPostModelList({
    required this.reviewPosts,
    required this.page,
    required this.pageCount,
    required this.sizePerPage,
  });

  factory ReviewPostModelList.fromJson(Map<String, dynamic> json) {
    final List<ReviewPostModel> reviewPosts = [];
    for (var reviewPost in json['review_posts']) {
      reviewPosts.add(ReviewPostModel.fromJson(reviewPost));
    }
    return ReviewPostModelList(
      reviewPosts: reviewPosts,
      page: json['page'],
      pageCount: json['page_count'],
      sizePerPage: json['size_per_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'review_posts':
          reviewPosts.map((reviewPost) => reviewPost.toJson()).toList(),
      'page': page,
      'page_count': pageCount,
      'size_per_page': sizePerPage,
    };
  }
}
