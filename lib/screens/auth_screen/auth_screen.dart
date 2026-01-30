import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_the_movie_db/constants/routes.dart';
import 'package:flutter_the_movie_db/widgets/API/base_url.dart';
import 'package:flutter_the_movie_db/widgets/API/constants.dart';
import 'package:flutter_the_movie_db/widgets/buttons/custom_primary_button/custom_primary_button.dart';
import 'package:flutter_the_movie_db/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter_the_movie_db/widgets/inputs/auth_input/auth_input.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _apiKeyController = TextEditingController();
  String _apiKey = '';

  void _handleApiKeyChanged(String value) {
    setState(() {
      _apiKey = value;
    });
  }

  void _handleLoginPressed(BuildContext context) async {
    try {
      await dio.get(
        endpoints['/authentication']!,
        options: Options(headers: {'Authorization': 'Bearer $_apiKey'}),
      );
      setApiKey(_apiKey);
      Navigator.pushNamed(context, Routes.menu);
    } catch (error) {
      // ignore: avoid_print
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'TMDB'),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          AuthInput(
            maxLines: 8,
            controller: _apiKeyController,
            onChanged: _handleApiKeyChanged,
            labelText: 'Access Api Key',
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

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }
}
