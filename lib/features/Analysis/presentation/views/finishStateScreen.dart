import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/features/Analysis/presentation/views/activity_card.dart';
import 'package:gymer/features/Analysis/presentation/views/finishContainer.dart';

class FinishStateScreen extends StatelessWidget {
  const FinishStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          ActivityCard(monthNumber: 1,percentage: 0,points: 8918,),
          SizedBox(height: 40,),
          FinishContainer(),
        ],
      ),
    );
  }
}
