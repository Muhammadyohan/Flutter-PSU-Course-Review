import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/models/models.dart';
import 'package:flutter_psu_course_review/pages/pages.dart';
import 'package:flutter_psu_course_review/repositories/repositories.dart';

class ReviewPostSearch extends StatefulWidget {
  const ReviewPostSearch({super.key});

  @override
  State<ReviewPostSearch> createState() => _ReviewPostSearchState();
}

class _ReviewPostSearchState extends State<ReviewPostSearch> {
  final ReviewPostMockRepo _repository = ReviewPostMockRepo();
  List<ReviewPostModel> _posts = [];
  List<ReviewPostModel> _filteredPosts = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      final posts = await _repository.fetchTasks();
      setState(() {
        _posts = posts;
        _filteredPosts = [];
      });
    } catch (e) {
      // Handle errors if necessary
    }
  }

  void _searchPosts(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredPosts = [];
      } else {
        _filteredPosts = _posts.where((post) {
          final courseCodeMatches =
              post.courseCode.toLowerCase().contains(query.toLowerCase());
          final courseNameMatches =
              post.courseName.toLowerCase().contains(query.toLowerCase());
          return courseCodeMatches || courseNameMatches;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/psu-course-review-appbar.jpg',
          width: 200,
          height: 200,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(' '),
          const Text(
            '   Search',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search by course name or code...',
              ),
              onChanged: _searchPosts,
            ),
          ),
          Expanded(
            child: _filteredPosts.isEmpty && _searchQuery.isNotEmpty
                ? const Center(child: Text('No posts found'))
                : ListView.builder(
                    itemCount: _filteredPosts.length,
                    itemBuilder: (context, index) {
                      final post = _filteredPosts[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewPostPage(post: post),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 6, // Increased elevation for shadow
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: const Color.fromARGB(255, 245, 245, 245),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${post.courseCode} - ${post.courseName}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  post.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  post.text,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
