part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class GetAllPosts extends PostEvent {
  GetAllPosts();
}
