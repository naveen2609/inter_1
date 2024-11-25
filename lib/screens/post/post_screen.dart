import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inter_1/logic/bloc/auth_bloc/auth_bloc.dart';
import 'package:inter_1/logic/bloc/post_bloc/post_bloc.dart';
import 'package:inter_1/logic/controller/post_controller.dart';
import 'package:inter_1/utils/post_widget.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController postController = TextEditingController();

  // initState() {
  //   BlocProvider.of<PostBloc>(context).add(PostLoadEvent());
  // }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    PostController postRepository = PostController();

    BlocProvider.of<PostBloc>(context);
    final user = (authBloc.state as AuthAuthenticated).user;
    final username = user.displayName ?? 'Anonymous';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const PostScreen()),
              );

             
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: postController,
                    decoration: const InputDecoration(
                      hintText: 'Write your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (postController.text.isNotEmpty) {
                      BlocProvider.of<PostBloc>(context).add(
                        PostMessageEvent(postController.text, username),
                      );
                      postController.clear();
                    }
                  },
                  child: const Text('Post'),
                ),
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder<Object>(
                  stream: postRepository.getPosts(),
                  builder: (context, snapshot) {
                    log(snapshot.data.toString());
                    log(snapshot.connectionState.toString());

                    if (snapshot.connectionState == ConnectionState.active) {
                      return PostListWidget(
                          posts: snapshot.data as List<Map<String, dynamic>>);
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      return const SizedBox();
                    }
                  }))
        ],
      ),
    );
  }
}
