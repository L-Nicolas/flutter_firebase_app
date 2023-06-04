import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_firebase/posts_screen/models/post.dart';
import 'package:tp_flutter_firebase/posts_screen/post_bloc/post_bloc.dart';
import 'package:tp_flutter_firebase/posts_screen/post_detail_screen/post_detail_screen.dart';
import 'package:tp_flutter_firebase/posts_screen/post_form_screen/post_form_screen.dart';
import 'package:tp_flutter_firebase/posts_screen/post_item.dart';

import 'analytics/analytics_provider.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

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
                      onTap: () => _onPostTap(context, post),
                    );
                  },
                );
            }
          },
        ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  //_onDeleteAllTap(context);
                },
                child: Icon(Icons.delete),
                backgroundColor: Colors.grey,
              ),
              SizedBox(width: 16),
              FloatingActionButton(
                onPressed: () {
                  _onActualizeTap(context);
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.refresh),
              ),
              const SizedBox(width: 16),
              FloatingActionButton(
                onPressed: () {
                  _onCrashTap();
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.car_crash),
              ),
              SizedBox(width: 16),
              FloatingActionButton(
                onPressed: () {
                  _onPlusTap(context);
                },
                backgroundColor: Colors.grey,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }


  void _onPostTap(BuildContext context, Post post) {
    //await AnalyticsProvider.of(context).setUserProperty('user', 'test');
    PostDetailScreen.navigateTo(context, post);
  }

  void _onPlusTap(BuildContext context) {
    PostFormScreen.navigateTo(context);
  }

  void _onActualizeTap(BuildContext context) {
    BlocProvider.of<PostBloc>(context).add(GetAllPosts());
  }

  void _onCrashTap() async {
    try {
      throw Exception('Oh le crash de fou');
    } catch (error, stackTrace) {
      await FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
  }
}
