import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_the_movie_db/API/services/account_service.dart';
import 'package:flutter_the_movie_db/constants/external_urls.dart';
import 'package:flutter_the_movie_db/constants/routes.dart';
import 'package:flutter_the_movie_db/screens/webview_screen/webview_screen.dart';
import 'package:flutter_the_movie_db/API/base_url.dart';
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
  final _apiAccessKeyController = TextEditingController();

  String _apiAccessKey = '';
  bool _externalAuthRequest = false;
  String _currentRequestToken = '';

  @override
  void dispose() {
    _apiAccessKeyController.dispose();
    super.dispose();
  }

  void _handleApiAccessKeyChanged(String value) =>
      setState(() => _apiAccessKey = value);

  Future<void> _handleGetAuthenticationSession(String requestToken) async {
    try {
      final response = await AccountService.createSession(
        apiAccessKey: _apiAccessKey,
        requestToken: requestToken,
      );

      await Future.wait([
        _storage.write(key: 'sessionId', value: response.sessionId),
        _storage.write(key: 'requestToken', value: requestToken),
        _storage.write(key: "apiAccessKey", value: _apiAccessKey),
      ]);

      setApiAccessKey(_apiAccessKey);

      if (mounted) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(Routes.menu, (_) => false);
      }
    } catch (error) {
      if (error is DioException && error.response?.data['status_code'] == 17) {
        await _storage.deleteAll();
        if (mounted) {
          setState(() => _externalAuthRequest = true);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => WebViewScreen(
                url: ExternalUrls.tmdbAuth(requestToken),
                title: 'TMDB Authentication',
              ),
            ),
          );
        }
      }
    }
  }

  Future<void> _handleGetAuthenticationToken() async {
    try {
      final response = await AccountService.createRequestToken(
        apiAccessKey: _apiAccessKey,
      );
      setState(() => _currentRequestToken = response.requestToken);
      await _handleGetAuthenticationSession(response.requestToken);
    } catch (_) {}
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
        padding: const EdgeInsets.symmetric(horizontal: 13),
        children: [
          const SizedBox(height: 24),
          AuthInput(
            maxLines: 8,
            controller: _apiAccessKeyController,
            onChanged: _handleApiAccessKeyChanged,
            labelText: 'Access Api Key',
          ),
          const SizedBox(height: 12),
          CustomPrimaryButton(text: 'Login', onPressed: _handleLogin),
        ],
      ),
    );
  }
}
