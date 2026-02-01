import 'package:flutter/material.dart';
import 'package:flutter_the_movie_db/constants/routes.dart';
import 'package:flutter_the_movie_db/screens/auth_screen/auth_screen.dart';
import 'package:flutter_the_movie_db/screens/home_screen/home_screen.dart';
import 'package:flutter_the_movie_db/screens/menu_screen/menu_screen.dart';
import 'package:flutter_the_movie_db/screens/profile_screen/profile_screen.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Routes.auth: (context) => const AuthScreen(),
        Routes.menu: (context) => const MenuScreen(),
        Routes.home: (context) => const HomeScreen(),
        Routes.profile: (context) => const ProfileScreen(),
      },
      home: AuthScreen(),
    );
  }
}
