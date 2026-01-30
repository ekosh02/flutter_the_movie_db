import 'package:flutter/material.dart';
import 'package:flutter_the_movie_db/constants/colors.dart';

class AuthInput extends StatelessWidget {
  final String labelText;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final int? maxLines;

  const AuthInput({
    super.key,
    this.labelText = 'Enter something',
    this.padding,
    this.controller,
    this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: colors['gray_text']),
          floatingLabelStyle: TextStyle(color: colors['accent'], fontSize: 20),
          floatingLabelBehavior: maxLines! > 1
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto,
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
