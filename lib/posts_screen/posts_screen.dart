import 'package:flutter/material.dart';
import 'package:tp_flutter_firebase/posts_screen/models/product.dart';
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
                itemCount: 0,//posts.length,
                itemBuilder: (context, index) {
                  final post = new Post(id: "1", description: "description");//posts[index];
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
