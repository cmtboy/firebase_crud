import 'package:firebase_crud/services/api.dart';
import 'package:flutter/material.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;

  PostDetailsScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(post.title),
            SizedBox(height: 16),
            Text(
              'Body:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(post.body),
          ],
        ),
      ),
    );
  }
}
