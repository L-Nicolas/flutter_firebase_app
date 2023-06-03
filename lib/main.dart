import 'package:flutter/material.dart';
import 'package:tp_flutter_firebase/posts_screen/posts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
    );
  }
}
