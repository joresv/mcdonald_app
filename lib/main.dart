import 'package:flutter/material.dart';
import 'package:mcdonald_app/pages/welcome/welcome.page.dart';
import 'package:mcdonald_app/utils/app.colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
          fontFamily: "Inter",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(
            displaySmall: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
            ),
            displayMedium: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            displayLarge: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          )),
      home: const WelcomePage(),
    );
  }
}
