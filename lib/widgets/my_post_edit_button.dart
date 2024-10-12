import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/models/review_post_model.dart';

class MyPostEditButton extends StatefulWidget {
  final ReviewPostModel post;

  const MyPostEditButton({super.key, required this.post});

  @override
  _MyPostEditButtonState createState() => _MyPostEditButtonState();
}

class _MyPostEditButtonState extends State<MyPostEditButton> {
  late TextEditingController _titleController;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.title);
    _textController = TextEditingController(text: widget.post.text);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Content'),
              //maxLines: 5,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.post.title = _titleController.text;
                  widget.post.text = _textController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}