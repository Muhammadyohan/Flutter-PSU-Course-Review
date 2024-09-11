import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/models/models.dart';
import 'package:flutter_psu_course_review/repositories/repositories.dart';

class ReviewPostPage extends StatefulWidget {
  final ReviewPostModel post;

  const ReviewPostPage({super.key, required this.post});

  @override
  State<ReviewPostPage> createState() => _ReviewPostPageState();
}

class _ReviewPostPageState extends State<ReviewPostPage> {
  late Future<List<CommentModel>> _commentsFuture;
  final CommentMockRepo _commentRepository = CommentMockRepo();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _commentsFuture = _commentRepository.fetchTasks();
  }

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      final newComment = CommentModel(
        commentText: _commentController.text,
        commentAuthor: 'New User',
      );
      _commentRepository.addComment(newComment);

      setState(() {
        _commentsFuture = _commentRepository.fetchTasks();
      });
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CommentModel>>(
        future: _commentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final post = widget.post;
          final comments = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12.0),
              IconButton(
                icon: const Icon(Icons.arrow_back_sharp),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Center(
                child: SizedBox(
                  width: 360,
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: const Color.fromARGB(255, 245, 245, 245),
                    margin: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(
                          20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${post.courseCode} - ${post.courseName}\nBy ${post.authorName}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            post.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            post.text,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Likes: ${post.likesAmount}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Comments: ${post.commentsAmount}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '${comment.commentAuthor}: ${comment.commentText}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: SizedBox(
                  width: 350,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter comment here',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _addComment,
                        child: const Text('Send'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
            ],
          );
        },
      ),
    );
  }
}
