part of 'post_bloc.dart';

enum PostStatus {
  initial,
  loading,
  success,
  error,
}

class PostState {
  final PostStatus status;
  final List<Post> posts;
  final String error;

  PostState({
    this.status = PostStatus.initial,
    this.posts = const [],
    this.error = '',
  });

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    String? error,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }
}
