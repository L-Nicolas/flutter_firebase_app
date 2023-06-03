import 'package:flutter/material.dart';
import 'package:tp_flutter_firebase/posts_screen/data_sources/local_posts_data_source.dart';
import 'package:tp_flutter_firebase/posts_screen/data_sources/remote_posts_data_source.dart';
import 'package:tp_flutter_firebase/posts_screen/posts_repository_provider.dart';
import 'package:tp_flutter_firebase/posts_screen/posts_screen.dart';
import 'package:tp_flutter_firebase/posts_screen/repository/posts_repository.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  const apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'test');
  debugPrint('API_BASE_URL: $apiBaseUrl');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PostsRepositoryProvider(
        postsRepository: PostsRepository(
        localDataSource: LocalPostsDataSource(),
        remoteDataSource: RemotePostsDataSource(),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: const TextTheme(
            bodySmall: TextStyle(
              fontSize: 20,
              color: Colors.green,
            ),
          ),
        ),
        routes: {
          '/': (context) => const PostsScreen(),
        },
      )
    );
  }
}
