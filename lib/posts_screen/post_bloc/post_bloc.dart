import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../models/post.dart';
import '../repository/posts_repository.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostsRepository repository;

  PostBloc({required this.repository}) : super(PostState()) {
    on<GetAllPosts>((event, emit) async {
      emit(state.copyWith(status: PostStatus.loading));

      //await Future.delayed(const Duration(seconds: 2));

      //final count = event.count;

      //debugPrint('Get All Posts ($count)');

      try {
        final posts = await repository.getPost(); /* List.generate(count, (index) {
          return Post(
            id: '$index',
            title: 'Post $index',
            description: 'Description $index',
          );
        });*/

        emit(state.copyWith(status: PostStatus.success, posts: posts));
      } catch (error) {
        emit(state.copyWith(status: PostStatus.error, error: error.toString()));
      }
    });
  }
}
