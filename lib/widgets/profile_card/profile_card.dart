import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_the_movie_db/API/base_url.dart';
import 'package:flutter_the_movie_db/constants/colors.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  static const _storage = FlutterSecureStorage();

  Map<String, dynamic>? _profileData;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(13),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Row(children: [_buildAvatar(), _buildProfileInfo()]),
      ),
    );
  }

  Widget _buildAvatar() {
    final gravatarHash = _profileData?['avatar']?['gravatar']?['hash'];
    if (gravatarHash != null) {
      final imageUrl = 'https://www.gravatar.com/avatar/$gravatarHash?s=200';
      return CircleAvatar(radius: 30, backgroundImage: NetworkImage(imageUrl));
    } else {
      return CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.person, size: 30, color: Colors.grey[600]),
      );
    }
  }

  void _getProfileInfo() async {
    try {
      final sessionId = await _storage.read(key: 'sessionId');
      final accountResponse = await dio.get(
        '/account',
        queryParameters: {'session_id': sessionId},
      );
      setState(() {
        _profileData = accountResponse.data;
      });
      print('accountResponse: ${accountResponse.data}');
    } catch (error) {
      print('error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _getProfileInfo();
  }

  Widget _buildProfileInfo() {
    final name = _profileData?['username'] ?? 'Loading...';
    final subtitle = _profileData != null
        ? 'ID: ${_profileData!['id']}'
        : 'Loading profile...';

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors['primary'],
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: 14, color: colors['gray_text']),
            ),
          ],
        ),
      ),
    );
  }
}
