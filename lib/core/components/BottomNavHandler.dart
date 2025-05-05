import 'package:flutter/material.dart';
import 'package:gymer/features/Analysis/presentation/views/analysisScreen.dart';
import 'package:gymer/features/Chatbot/presentation/views/initChatbotScreen.dart';
import 'package:gymer/features/Authentication/presentation/views/editProfileScreen.dart';
import 'package:gymer/core/components/CustomBottomNavBar.dart';

import '../../features/Home/presentation/views/homeScreen.dart';

class BottomNavHandler extends StatelessWidget {
  final int currentIndex;
  final Function(int) onImagePicked;

  const BottomNavHandler({super.key, required this.currentIndex, required this.onImagePicked});

  void _onItemTapped(BuildContext context, int index) {
    if (index == 2) {
      onImagePicked(index);
      return;
    }

    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const HomeScreen();
        break;
      case 1:
        nextScreen = const InitChatbotScreen();
        break;
      case 3:
        nextScreen = const AnalysisScreen();
        break;
      case 4:
        nextScreen = const EditProfileScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavBar(
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
    );
  }
}
