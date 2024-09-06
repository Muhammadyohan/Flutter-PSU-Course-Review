// ignore_for_file: non_constant_identifier_names

class ReviewPostModel{
  String title;
  String text;
  final String author_name;
  final String course_code;
  final String course_name;
  int like_amount=0;
  int comment_amount = 0;
  int course_id =0;
  int review_post_id=0;

  ReviewPostModel(this.title, this.text, this.author_name, this.course_code, this.course_name);
}

