import 'package:flutter/material.dart';
import 'package:flutter_the_movie_db/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter_the_movie_db/widgets/inputs/auth_input/auth_input.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'TMDB'),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          AuthInput(
            labelText: 'Username',
            padding: const EdgeInsets.symmetric(horizontal: 13),
          ),
          const SizedBox(height: 12),
          AuthInput(
            labelText: 'Password',
            padding: const EdgeInsets.symmetric(horizontal: 13),
          ),
        ],
      ),
    );
  }
}
