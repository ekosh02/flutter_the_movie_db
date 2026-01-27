import 'package:flutter/material.dart';
import 'package:flutter_the_movie_db/screens/auth_screen/auth_screen.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: AuthScreen()));
  }
}
