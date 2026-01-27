import 'package:flutter/material.dart';
import 'package:flutter_the_movie_db/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, this.title = 'TMDB'});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final shouldShowContainer = title == 'TMDB';

    return AppBar(
      backgroundColor: colors['primary'],
      title: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: primaryGradientColors[0],
            ),
          ),
          if (shouldShowContainer)
            Container(
              width: 46,
              height: 21,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: primaryGradientColors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
        ],
      ),
    );
  }
}
