import 'package:flutter/material.dart';
import 'package:mcdonald_app/utils/app.colors.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.onPressed,
    this.color,
    required this.title,
  });

  final VoidCallback? onPressed;
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 60,
      onPressed: onPressed,
      color: color ?? AppColors.white,
      elevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
