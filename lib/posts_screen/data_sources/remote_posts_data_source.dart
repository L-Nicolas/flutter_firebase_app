import 'package:flutter/material.dart';
import 'posts_data_source.dart';

class RemotePostsDataSource extends PostsDataSource {
  @override
  Future<List<String>> getPosts() async {
    debugPrint('Getting posts from remote data source');
    await Future.delayed(const Duration(seconds: 2));
    return ['Apple', 'Banana', 'Orange'];
  }
}
