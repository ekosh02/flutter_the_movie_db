import 'package:flutter/material.dart';
import 'package:flutter_the_movie_db/constants/colors.dart';

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;

  const CustomOutlineButton({
    super.key,
    this.text = 'Press me',
    this.onPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: colors['primary'],
          side: BorderSide(color: colors['primary']!),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: colors['primary'],
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 2.5,
          ),
        ),
      ),
    );
  }
}
