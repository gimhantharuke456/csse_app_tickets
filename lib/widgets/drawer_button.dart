import 'package:csse_app/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomDrawerButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Icon icon;
  const CustomDrawerButton(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(
                  width: 16,
                ),
                Text(title),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}
