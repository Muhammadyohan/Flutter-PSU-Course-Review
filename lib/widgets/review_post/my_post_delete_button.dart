import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/models/review_post_model.dart';

class MyPostDeleteButton extends StatelessWidget {
  final ReviewPostModel post;
  final VoidCallback onDelete;

  const MyPostDeleteButton({
    super.key,
    required this.post,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Post'),
      content: Text('Are you sure you want to delete the post "${post.title}"?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onDelete();
          },
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
