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
  final CommentMockRepo _commentRepository = CommentMockRepo();
  final TextEditingController _commentController = TextEditingController();
  late Future<List<CommentModel>> _commentsFuture;
  late int _likeCount;

  @override
  void initState() {
    super.initState();
    _commentsFuture = _commentRepository.fetchTasks();
    _likeCount = widget.post.likesAmount;
  }

  void _incrementLike() {
    setState(() {
      _likeCount++;
    });
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

          final comments = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_sharp),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    '${widget.post.courseCode} ${widget.post.courseName}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Center(
                  child: SizedBox(
                    width: 400,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      color: const Color(0xFF3E4B92),
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'By ${widget.post.authorName}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.post.text,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: _incrementLike,
                                  icon: const Icon(Icons.thumb_up),
                                  label: Text(
                                    '$_likeCount',
                                  ),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1),
                            const Text(
                              'Comments',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                final comment = comments[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text(
                                    '${comment.commentAuthor}: ${comment.commentText}',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                );
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _commentController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter comment here',
                                      hintStyle: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton(
                                  onPressed: _addComment,
                                  child: const Text('Send'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
