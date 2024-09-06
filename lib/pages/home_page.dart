import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/models/review_post_model.dart';
import 'package:flutter_psu_course_review/pages/review_post_page.dart';
import 'package:flutter_psu_course_review/repositories/review_post/review_post_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ReviewPostRepository repository = ReviewPostRepository();

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/psu-course-review-appbar.jpg',
          width: 200,
          height: 200,
        ),
      ),
      body: FutureBuilder<List<ReviewPostModel>>(
        future: repository.fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts available'));
          }

          final posts = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Popular Post Section
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Popular Posts',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 250, // Set height to manage scrollable area
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            return Container(
                              width: 200, // Adjust width to fit content
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReviewPostPage(post: post),
                                    ),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Course Info
                                        Text(
                                          '${post.course_code} ${post.course_name}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8.0),
                                        // Post Title
                                        Text(
                                          post.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8.0),
                                        // Post Text
                                        Expanded(
                                          child: Text(
                                            post.text,
                                            style: const TextStyle(fontSize: 14),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3, // Limit the number of lines
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        // Author and Stats
                                        Text(
                                          'By ${post.author_name}',
                                          style: const TextStyle(fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Likes: ${post.like_amount}, Comments: ${post.comment_amount}',
                                          style: const TextStyle(fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Trending Courses Section (if needed)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Trending Courses',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 250, // Set height to manage scrollable area
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            return Container(
                              width: 200, // Adjust width to fit content
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReviewPostPage(post: post),
                                    ),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Course Info
                                        Text(
                                          '${post.course_code} ${post.course_name}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8.0),
                                        // Post Title
                                        Text(
                                          post.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8.0),
                                        // Post Text
                                        Expanded(
                                          child: Text(
                                            post.text,
                                            style: const TextStyle(fontSize: 14),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3, // Limit the number of lines
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        // Author and Stats
                                        Text(
                                          'By ${post.author_name}',
                                          style: const TextStyle(fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Likes: ${post.like_amount}, Comments: ${post.comment_amount}',
                                          style: const TextStyle(fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
