import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/models/review_post_model.dart';

class MyPostAddButton extends StatefulWidget {
  final Function(ReviewPostModel) onPostAdded;

  const MyPostAddButton({super.key, required this.onPostAdded});

  @override
  // ignore: library_private_types_in_public_api
  _MyPostAddButtonState createState() => _MyPostAddButtonState();
}

class _MyPostAddButtonState extends State<MyPostAddButton> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _textController = TextEditingController();
  final _authorController = TextEditingController();
  final _courseCodeController = TextEditingController();
  final _courseNameController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    _authorController.dispose();
    _courseCodeController.dispose();
    _courseNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _textController,
                decoration: const InputDecoration(labelText: 'Text'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Author Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the author name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _courseCodeController,
                decoration: const InputDecoration(labelText: 'Course Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the course code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _courseNameController,
                decoration: const InputDecoration(labelText: 'Course Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the course name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newPost = ReviewPostModel(
                        title: _titleController.text,
                        text: _textController.text,
                        authorName: _authorController.text,
                        courseCode: _courseCodeController.text,
                        courseName: _courseNameController.text,
                      );

                      widget.onPostAdded(newPost);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
