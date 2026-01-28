import 'package:flutter/material.dart';
import 'package:flutter_the_movie_db/constants/routes.dart';
import 'package:flutter_the_movie_db/widgets/buttons/custom_primary_button/custom_primary_button.dart';
import 'package:flutter_the_movie_db/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter_the_movie_db/widgets/inputs/auth_input/auth_input.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  void _handleLoginPressed(BuildContext context) {
    Navigator.pushNamed(context, Routes.menu);
  }

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
          const SizedBox(height: 12),
          CustomPrimaryButton(
            text: 'Login',
            onPressed: () => _handleLoginPressed(context),
            padding: const EdgeInsets.symmetric(horizontal: 13),
          ),
        ],
      ),
    );
  }
}
