import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/post.dart';
import 'posts_data_source.dart';

class RemotePostsDataSource extends PostsDataSource {
  @override
  Future<List<Post>> getPosts() async {
    final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('post');

    QuerySnapshot querySnapshot = await collectionReference.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;

    List<Post> posts = [];

    for (var document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      String title = data['title'];
      String description = data['description'];

      Post post = Post(title: title, description: description);
      posts.add(post);
    }

    return posts;
  }

  Future<void> createPost(Post post) async {
    try {
      final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

      await postsCollection.add({
        'title': post.title,
        'description': post.description,
      });

      print('Post envoyé avec succès à Firestore');
    } catch (e) {
      print('Erreur lors de l\'envoi du post à Firestore: $e');
    }
  }

}
