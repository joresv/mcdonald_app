import 'package:flutter/material.dart';
import 'package:mcdonald_app/pages/home/home.page.dart';
import 'package:mcdonald_app/utils/app.colors.dart';
import 'package:mcdonald_app/utils/app.images.dart';
import 'package:mcdonald_app/widgets/button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Image.asset(
              AppImages.welcomeBurger,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Enjoy your craving",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 30,
                      ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Every bit of it is worth the sip anyday..",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppColors.white,
                        fontSize: 20,
                      ),
                ),
                SizedBox(
                  height: 30,
                ),
                Button(
                  title: "Registed or Log in",
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Button(
                  title: "Continue as Guest",
                  onPressed: () {},
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 56,
          ),
        ],
      ),
    );
  }
}
