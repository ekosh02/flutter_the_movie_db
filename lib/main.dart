import 'package:flutter/material.dart';
import 'package:flutter_the_movie_db/constants/routes.dart';
import 'package:flutter_the_movie_db/screens/auth_screen/auth_screen.dart';
import 'package:flutter_the_movie_db/screens/home_screen/home_screen.dart';
import 'package:flutter_the_movie_db/screens/menu_screen/menu_screen.dart';
import 'package:flutter_the_movie_db/screens/profile_screen/profile_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_the_movie_db/API/base_url.dart';
import 'package:flutter_the_movie_db/API/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  bool _loading = true;
  String? _initialRoute;
  static const _storage = FlutterSecureStorage();

  void _handleGetAuthenticationSession(String requestToken) async {
    try {
      final apiAccessKey = await _storage.read(key: 'apiAccessKey');
      setApiAccessKey(apiAccessKey ?? '');

      final response = await dio.get(
        endpoints['/authentication/session/new']!,
        queryParameters: {'request_token': requestToken},
      );
      final sessionId = response.data['session_id'];

      await _storage.write(key: 'sessionId', value: sessionId);
      await _storage.write(key: 'requestToken', value: requestToken);
      setState(() {
        _loading = false;
        _initialRoute = Routes.menu;
      });
    } catch (error) {
      final errorResponse = (error as DioException).response;
      // ignore: avoid_print
      print('authentication session error: $errorResponse');

      await _storage.delete(key: 'requestToken');
      await _storage.delete(key: 'sessionId');
      await _storage.delete(key: 'apiAccessKey');
      clearApiAccessKey();

      setState(() {
        _loading = false;
        _initialRoute = Routes.auth;
      });
    }
  }

  void _handleGetUser() async {
    final requestToken = await _storage.read(key: 'requestToken');
    if (requestToken != null) {
      _handleGetAuthenticationSession(requestToken);
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _loading = false;
            _initialRoute = Routes.auth;
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _handleGetUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Routes.auth: (context) => const AuthScreen(),
        Routes.menu: (context) => const MenuScreen(),
        Routes.home: (context) => const HomeScreen(),
        Routes.profile: (context) => const ProfileScreen(),
      },
      home: _loading
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : _initialRoute == Routes.menu
          ? const MenuScreen()
          : const AuthScreen(),
    );
  }
}
