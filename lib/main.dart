import 'package:flutter/material.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/Splash/presentation/views/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: ColorsManager.BGColor,
          focusColor: ColorsManager.mainGoldColor,
          primaryColor: ColorsManager.mainGoldColor
      ),
      home: const SplashScreen(),
    );
  }
}