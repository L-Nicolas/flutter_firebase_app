import '../data_sources/posts_data_source.dart';

class PostsRepository {
  final PostsDataSource remoteDataSource;
  final PostsDataSource localDataSource;

  PostsRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<List<String>> getFruits() async {
    try {
      final posts = await remoteDataSource.getPosts();
      return posts;
    } catch (e) {
      final posts = await localDataSource.getPosts();
      return posts;
    }
  }
}
