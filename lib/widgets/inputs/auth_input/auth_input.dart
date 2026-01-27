import 'package:flutter/material.dart';
import 'package:flutter_the_movie_db/constants/colors.dart';

class AuthInput extends StatelessWidget {
  final String labelText;
  final EdgeInsetsGeometry? padding;

  const AuthInput({
    super.key,
    this.labelText = 'Enter something',
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: colors['gray_text']),
          floatingLabelStyle: TextStyle(color: colors['accent'], fontSize: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: colors['border']!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: colors['accent']!),
          ),
        ),
      ),
    );
  }
}
