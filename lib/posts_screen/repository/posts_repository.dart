import '../data_sources/posts_data_source.dart';
import '../models/post.dart';

class PostsRepository {
  final PostsDataSource remoteDataSource;
  //final PostsDataSource localDataSource;

  PostsRepository({
    required this.remoteDataSource,
    //required this.localDataSource,
  });

  Future<List<Post>> getPost() async {
    try {
      final posts = await remoteDataSource.getPosts();
      return posts;
    } catch (e) {
      //final posts = await localDataSource.getPosts();
      print("PostRepository: " + e.toString());
      return [];//posts;
    }
  }
}
