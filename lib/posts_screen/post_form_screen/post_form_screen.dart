import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post.dart';
import '../post_bloc/post_bloc.dart';
import '../posts_repository_provider.dart';

class PostFormScreen extends StatefulWidget {
  static const String routeName = '/PostFromScreen';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final post = Post(
      title: title,
      description: description,
    );
    final postsRepository = PostsRepositoryProvider.of(context).postsRepository;
    await postsRepository.createPost(post);
    final posteBloc = BlocProvider.of<PostBloc>(context);
    posteBloc.add(GetAllPosts());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer une description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Créer le post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

