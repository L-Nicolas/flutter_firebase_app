import 'package:flutter/widgets.dart';
import 'package:tp_flutter_firebase/posts_screen/data_sources/posts_data_source.dart';

class LocalPostsDataSource extends PostsDataSource {
  @override
  Future<List<String>> getPosts() {
    debugPrint('Getting posts from local data source');
    return Future.value(['Apple', 'Banana', 'Orange']);
  }
}
