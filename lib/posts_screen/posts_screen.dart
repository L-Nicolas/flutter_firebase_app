import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:tp_flutter_firebase/posts_screen/models/post.dart';
import 'package:tp_flutter_firebase/posts_screen/post_item.dart';

import 'analytics/analytics_provider.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  void _tapPost(BuildContext context, Post post) async {
    await AnalyticsProvider.of(context).setUserProperty('user', 'test');
  }

  void _crash() async {
    try {
      throw Exception('Coucou, ce crash est géré');
    } catch (error, stackTrace) {
      await FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
  }

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
                    id: '1',
                    description: 'description',
                    createdAt: DateTime.now(),
                  );
                  return PostItem(
                    post: post,
                    onTap: () => _crash() //_tapPost(context, post)
                  );
                },
            )
          );
        }
    );
  }
}
