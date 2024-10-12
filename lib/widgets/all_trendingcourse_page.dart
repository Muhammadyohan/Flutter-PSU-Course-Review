import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/models/models.dart';
import 'package:flutter_psu_course_review/pages/review_post_page.dart';

class AllTrendingcoursePage extends StatefulWidget {
  final List<ReviewPostModel> posts;

  const AllTrendingcoursePage({super.key, required this.posts});

  @override
  _AllTrendingcoursePageState createState() => _AllTrendingcoursePageState();
}

class _AllTrendingcoursePageState extends State<AllTrendingcoursePage> {
  List<ReviewPostModel> _filteredPosts = [];

  @override
  void initState() {
    super.initState();
    _filteredPosts = widget.posts;
  }

  void _searchPosts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredPosts = widget.posts;
      } else {
        _filteredPosts = widget.posts.where((post) {
          final courseCodeMatches = post.courseCode.toLowerCase().contains(query.toLowerCase());
          final courseNameMatches = post.courseName.toLowerCase().contains(query.toLowerCase());
          return courseCodeMatches || courseNameMatches;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Courses'),
      ),
      body: Column(
        children: [
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
            child: ListView.builder(
              itemCount: _filteredPosts.length,
              itemBuilder: (context, index) {
                final post = _filteredPosts[index];
                return Container(
                  height: 80,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3E4B92),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      '${post.courseCode} ${post.courseName}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewPostPage(post: post),
                        ),
                      );
                    },
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
