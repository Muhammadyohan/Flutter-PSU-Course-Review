// ignore_for_file: non_constant_identifier_names

class CommentModel{
  String comment_text;
  final String comment_author;
  int like_amount=0;
  int review_post_id=0;
  int user_id=0;

  CommentModel(this.comment_text, this.comment_author);
}