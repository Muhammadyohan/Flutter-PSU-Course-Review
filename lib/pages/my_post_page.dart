import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/models/models.dart';
import 'package:flutter_psu_course_review/pages/pages.dart';
import 'package:flutter_psu_course_review/repositories/repositories.dart';
import 'package:flutter_psu_course_review/widgets/widgets.dart';

class MyPostPage extends StatefulWidget {
  const MyPostPage({super.key});

  @override
  State<MyPostPage> createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPage> {
  final ReviewPostMockRepo repository = ReviewPostMockRepo();
  late Future<List<ReviewPostModel>> _postsFuture;
  List<ReviewPostModel> _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  void _fetchPosts() async {
    _postsFuture = repository.fetchTasks();
    _posts = await _postsFuture;
  }

  void _addNewPost(ReviewPostModel post) {
    setState(() {
      _posts.add(post);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReviewPostModel>>(
      future: _postsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final posts = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Posts'),
          ),
          body: Column(
            children: [
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Card(
                      color: const Color(0xFF3E4B92),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        title: Text(
                          '${post.courseCode} ${post.courseName}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8.0),
                            Text(
                              post.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(post.text,style: const TextStyle(color: Colors.white),),
                            const SizedBox(height: 8.0),
                            Text('By ${post.authorName}',style: const TextStyle(color: Colors.white),),
                            Text(
                                'Likes: ${post.likesAmount}, Comments: ${post.commentsAmount}',style: const TextStyle(color: Colors.white),),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit,color: Colors.white,),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MyPostEditButton(post: post),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,color: Colors.white,),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return MyPostDeleteButton(
                                      post: post,
                                      onDelete: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyPostAddButton(
                              onPostAdded: _addNewPost,
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.add,),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
