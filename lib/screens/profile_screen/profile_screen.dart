import 'package:flutter/material.dart';
import 'package:flutter_the_movie_db/widgets/profile_card/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [ProfileCard()]);
  }
}
