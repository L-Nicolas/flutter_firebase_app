import 'package:flutter/material.dart';
import 'package:tp_flutter_firebase/posts_screen/repository/posts_repository.dart';

class PostsRepositoryProvider extends InheritedWidget {
  const PostsRepositoryProvider({
    Key? key,
    required Widget child,
    required this.postsRepository,
  }) : super(key: key, child: child);


  final PostsRepository postsRepository;

  static PostsRepositoryProvider of(BuildContext context) {
    final PostsRepositoryProvider? result = context.dependOnInheritedWidgetOfExactType<PostsRepositoryProvider>();
    assert(result != null, 'No PostsRepositoryProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(PostsRepositoryProvider old) {
    return true;
  }
}
