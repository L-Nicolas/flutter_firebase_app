import 'package:flutter/material.dart';
import 'package:tp_flutter_firebase/posts_screen/models/post.dart';
import 'package:tp_flutter_firebase/posts_screen/post_item.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Posts'),
            ),
            body: ListView.builder(
                itemCount: 1,//posts.length,
                itemBuilder: (context, index) {
                  final post = Post(
                    id: "1",
                    description: "ratio",
                    createdAt: DateTime.now(),
                  );
                  return PostItem(
                    post: post,
                    //onTap: () => _onProductTap(context, post),
                  );
                },
            )
          );
        }
    );
  }
}
