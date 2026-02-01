import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_the_movie_db/constants/routes.dart';
import 'package:flutter_the_movie_db/screens/webview_screen/webview_screen.dart';
import 'package:flutter_the_movie_db/API/base_url.dart';
import 'package:flutter_the_movie_db/API/constants.dart';
import 'package:flutter_the_movie_db/widgets/buttons/custom_primary_button/custom_primary_button.dart';
import 'package:flutter_the_movie_db/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter_the_movie_db/widgets/inputs/auth_input/auth_input.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  static const _storage = FlutterSecureStorage();
  final TextEditingController _apiAccessKeyController = TextEditingController();

  String _apiAccessKey = '';
  bool _externalAuthRequest = false;
  String _currentRequestToken = '';

  void _handleApiAccessKeyChanged(String value) {
    setState(() {
      _apiAccessKey = value;
    });
  }

  void _handleGetAuthenticationSession(String requestToken) async {
    try {
      final response = await dio.get(
        endpoints['/authentication/session/new']!,
        queryParameters: {'request_token': requestToken},
        options: Options(headers: {'Authorization': 'Bearer $_apiAccessKey'}),
      );

      final sessionId = response.data['session_id'];

      await _storage.write(key: 'sessionId', value: sessionId);
      await _storage.write(key: 'requestToken', value: requestToken);
      await _storage.write(key: "apiAccessKey", value: _apiAccessKey);

      setApiAccessKey(_apiAccessKey);

      if (mounted) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(Routes.menu, (route) => false);
      }
    } catch (error) {
      // ignore: avoid_print
      final errorResponse = (error as DioException).response;
      print('authentication session error: $errorResponse');

      final isSessionDenied = errorResponse?.data['status_code'] == 17;
      if (isSessionDenied) {
        await _storage.delete(key: 'requestToken');
        await _storage.delete(key: 'sessionId');
        await _storage.delete(key: 'apiAccessKey');
        final url = 'https://www.themoviedb.org/authenticate/$requestToken';
        if (mounted) {
          setState(() {
            _externalAuthRequest = true;
          });
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  WebViewScreen(url: url, title: 'TMDB Authentication'),
            ),
          );
        }
      }
    }
  }

  void _handleGetAuthenticationToken() async {
    await dio
        .get(
          endpoints['/authentication/token/new']!,
          options: Options(headers: {'Authorization': 'Bearer $_apiAccessKey'}),
        )
        .then((response) async {
          final requestToken = response.data['request_token'];
          setState(() {
            _currentRequestToken = requestToken;
          });

          _handleGetAuthenticationSession(requestToken);
        })
        .catchError((error) {
          // ignore: avoid_print
          print(
            'Authentication token error: ${(error as DioException).response}',
          );
        });
  }

  void _handleLogin() {
    if (_externalAuthRequest) {
      _handleGetAuthenticationSession(_currentRequestToken);
      setState(() {
        _externalAuthRequest = false;
        _currentRequestToken = '';
      });
    } else {
      _handleGetAuthenticationToken();
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
            controller: _apiAccessKeyController,
            onChanged: _handleApiAccessKeyChanged,
            labelText: 'Access Api Key',
            padding: const EdgeInsets.symmetric(horizontal: 13),
          ),

          const SizedBox(height: 12),
          CustomPrimaryButton(
            text: 'Login',
            onPressed: () => _handleLogin(),
            padding: const EdgeInsets.symmetric(horizontal: 13),
          ),
        ],
      ),
    );
  }
}
