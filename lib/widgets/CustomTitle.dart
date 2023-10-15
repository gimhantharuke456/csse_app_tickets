import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final TextStyle? style;
  const CustomTitle({super.key, required this.title, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: style ??
          const TextStyle(
            fontSize: 43,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
