// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PostListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> posts;

  const PostListWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListTile(
          title: Text(post['message'] ?? 'No Message'),
          subtitle: Text('By ${post['username'] ?? 'Anonymous'}',style: const TextStyle(fontWeight: FontWeight.bold),),
        );
      },
    );
  }
}
