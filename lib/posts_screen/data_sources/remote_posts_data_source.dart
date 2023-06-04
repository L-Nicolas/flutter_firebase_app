import 'package:flutter/material.dart';
import '../models/post.dart';
import 'posts_data_source.dart';

class RemotePostsDataSource extends PostsDataSource {
  @override
  Future<List<Post>> getPosts() async {
    debugPrint('Getting posts from remote data source');
    await Future.delayed(const Duration(seconds: 2));
    return [];
  }
}
