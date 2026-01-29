import 'package:flutter/material.dart';
import 'package:flutter_the_movie_db/constants/colors.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

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
    final imageUrl =
        'https://hips.hearstapps.com/hmg-prod/images/elon-musk-gettyimages-2147789844-web-675b2c17301ea.jpg?crop=0.6666666666666666xw:1xh;center,top&resize=1800:*';

    return CircleAvatar(radius: 30, backgroundImage: NetworkImage(imageUrl));
  }

  Widget _buildProfileInfo() {
    final name = 'ekosha02';
    final subtitle = 'Member since January 2026';
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
