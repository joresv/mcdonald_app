import 'package:flutter/material.dart';
import 'package:mcdonald_app/utils/app.colors.dart';
import 'package:mcdonald_app/utils/app.images.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            AppImages.welcomeBurger,
          ),
        ],
      ),
    );
  }
}
