import 'package:flutter/material.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/Questionnaire/presentation/views/goalScreen.dart';

import 'features/Questionnaire/presentation/views/onboardingQ.dart';

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
          focusColor: ColorsManager.blackColor,
          primaryColor: ColorsManager.blackColor
      ),
      //home: const OnboardingQ(label: 'Fitness Analysis', number: '4', rightPadding: 40, labelSize: 40,),
      home: const OnboardingQ(label: 'Goal', number: '1', rightPadding: 0, labelSize: 50, nextScreen: GoalScreen(),),
    );
  }
}