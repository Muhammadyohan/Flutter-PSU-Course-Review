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
  late Future<List<ReviewPostModel>> _postsFuture;
  final ReviewPostMockRepo _repository = ReviewPostMockRepo();

  @override
  void initState() {
    super.initState();
    _postsFuture = _repository.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ReviewPostModel>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts available'));
          }

          final post = widget.post; // Use the post passed to this widget

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
                    elevation: 6, // Increased elevation for shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: const Color.fromARGB(255, 245, 245, 245),
                    margin: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(
                          20.0), // More padding for better spacing
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${post.course_code} - ${post.course_name}\nBy ${post.author_name}',
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
                                'Likes: ${post.like_amount}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Comments: ${post.comment_amount}',
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                child: Text(
                  'Pea: Yeah I think so',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 350,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter comment here',
                          ),
                          onChanged: (text) {
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                          width:
                              8), // Add some space between the TextField and the Button
                      ElevatedButton(
                        onPressed: () {
                          // Add your submit functionality here
                        },
                        child: const Text('Send'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
