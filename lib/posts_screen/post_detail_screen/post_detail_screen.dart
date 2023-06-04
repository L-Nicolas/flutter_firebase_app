import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_firebase/posts_screen/models/post.dart';
import 'package:tp_flutter_firebase/posts_screen/post_bloc/post_bloc.dart';

class PostDetailScreen extends StatelessWidget {
  static const String routeName = '/PostDetailScreen';

  static void navigateTo(BuildContext context, Post post) {
    Navigator.of(context).pushNamed(routeName, arguments: post);
  }

  final Post post;

  const PostDetailScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.description),
            const Spacer(),
            Center(
              child: BlocConsumer<PostBloc, PostState>(
                listener: (context, state) {
                  if (state.status == PostStatus.success/*updated*/) {
                    _showSnackBar(context, 'Produit ajouté au panier');
                    Navigator.of(context).pop();
                  }/* else if (state.status == CartStatus.error) {
                    _showSnackBar(context, state.error ?? '');
                  }*/
                },
                builder: (context, state) {
                  switch (state.status) {
                    case PostStatus.loading:
                      return const CircularProgressIndicator();
                    default:
                      return _buildButton(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //make this fonction onpressed make nothing
  Widget _buildButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Ajouter au panier'),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  /*void _onAddToCart(BuildContext context) {
    BlocProvider.of<PostBloc>(context).add(AddPost(post));
  }*/
}

