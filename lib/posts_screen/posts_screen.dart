import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_firebase/posts_screen/models/post.dart';
import 'package:tp_flutter_firebase/posts_screen/post_bloc/post_bloc.dart';
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

  /*
  * ListView.builder(
                  itemCount: 1, //posts.length,
                  itemBuilder: (context, index) {
                    final post = Post(
                        id: '1',
                        body: 'description'
                    );
                    return PostItem(
                        post: post,
                        onTap: () => _crash() //_tapPost(context, post)
                    );
                  },
                )
  * */

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc()..add(GetAllPosts(10)),
      child: Builder(
          builder: (context) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Posts'),
                ),
                body: BlocBuilder<PostBloc,PostState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case PostStatus.initial:
                        return const SizedBox();
                      case PostStatus.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case PostStatus.error:
                        return Center(
                          child: Text(state.error),
                        );
                      case PostStatus.success:
                        final posts = state.posts;

                        if (posts.isEmpty) {
                          return const Center(
                            child: Text('Aucun produit'),
                          );
                        }

                        return ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            return PostItem(
                              post: post,
                              //onTap: () => _onProductTap(context, product),
                            );
                          },
                        );
                    }
                  },
                )
            );
          }
      ),
    );
  }
}
