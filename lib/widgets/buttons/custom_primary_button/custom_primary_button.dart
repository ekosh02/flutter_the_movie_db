import 'package:flutter/material.dart';
import 'package:flutter_the_movie_db/constants/colors.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;

  const CustomPrimaryButton({
    super.key,
    this.text = 'Press me',
    this.onPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: colors['primary']),
        child: Text(
          text,
          style: TextStyle(
            color: colors['white'],
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 2.5,
          ),
        ),
      ),
    );
  }
}
