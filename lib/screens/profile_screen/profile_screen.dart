import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_the_movie_db/constants/routes.dart';
import 'package:flutter_the_movie_db/API/base_url.dart';
import 'package:flutter_the_movie_db/widgets/buttons/custom_outline_button/custom_outline_button.dart';
import 'package:flutter_the_movie_db/widgets/profile_card/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const _storage = FlutterSecureStorage();

  void _handleLogoutPressed(
    BuildContext context,
    BuildContext dialogContext,
  ) async {
    Navigator.of(dialogContext).pop();
    clearApiAccessKey();
    await _storage.delete(key: "apiAccessKey");
    await _storage.delete(key: "sessionId");
    await _storage.delete(key: "requestToken");
    if (context.mounted) {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(Routes.auth, (route) => false);
    }
  }

  void _handleLogoutAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Выход'),
        content: const Text('Вы уверены, что хотите выйти?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              _handleLogoutPressed(context, dialogContext);
            },
            child: const Text('Выйти'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProfileCard(),
        CustomOutlineButton(
          text: 'Logout',
          padding: EdgeInsets.symmetric(horizontal: 13),
          onPressed: () => _handleLogoutAlertDialog(context),
        ),
      ],
    );
  }
}
