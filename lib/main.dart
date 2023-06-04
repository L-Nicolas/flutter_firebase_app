import 'dart:async';
import 'dart:isolate';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_firebase/posts_screen/analytics/analytics_provider.dart';
import 'package:tp_flutter_firebase/posts_screen/analytics/firebase_analytics_handler.dart';
import 'package:tp_flutter_firebase/posts_screen/data_sources/local_posts_data_source.dart';
import 'package:tp_flutter_firebase/posts_screen/data_sources/remote_posts_data_source.dart';
import 'package:tp_flutter_firebase/posts_screen/models/post.dart';
import 'package:tp_flutter_firebase/posts_screen/post_bloc/post_bloc.dart';
import 'package:tp_flutter_firebase/posts_screen/post_detail_screen/post_detail_screen.dart';
import 'package:tp_flutter_firebase/posts_screen/post_form_screen/post_form_screen.dart';
import 'package:tp_flutter_firebase/posts_screen/posts_repository_provider.dart';
import 'package:tp_flutter_firebase/posts_screen/posts_screen.dart';
import 'package:tp_flutter_firebase/posts_screen/repository/posts_repository.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runZonedGuarded<Future<void>>(() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
      );
    }).sendPort);

    runApp(MyApp());
  }, FirebaseCrashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<PostsRepository>(
            create: (context) => PostsRepository(
              localDataSource: LocalPostsDataSource(),
              remoteDataSource: RemotePostsDataSource(),
            ),
            child: BlocProvider<PostBloc>(
              create: (context) => PostBloc(
                repository: context.read<PostsRepository>(),
              )..add(GetAllPosts()),
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
                  PostFormScreen.routeName: (context) => PostFormScreen(),
                },
                onGenerateRoute: (settings) {
                  Widget content = const SizedBox.shrink();

                  switch (settings.name) {
                    case PostDetailScreen.routeName:
                      final arguments = settings.arguments;
                      if (arguments is Post) {
                        content = PostDetailScreen(post: arguments);
                      }
                      break;
                  }

                  return MaterialPageRoute(
                    builder: (context) {
                      return content;
                    },
                  );
                },
              ),
            )

    );
  }
}
