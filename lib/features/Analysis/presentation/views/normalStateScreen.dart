import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/features/Analysis/presentation/views/activity_card.dart';
import 'package:gymer/features/Analysis/presentation/views/chartPageView.dart';
import 'package:gymer/features/Analysis/presentation/views/checklistWidget.dart';

class NormalStateScreen extends StatelessWidget {
  const NormalStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ActivityCard(monthNumber: 1,percentage: 0.55,points: 8918,),
          SizedBox(height: 20,),
          ChecklistWidget(),
          Expanded(
              child: ChartPageView()
          ),
        ],
      ),
    );
  }
}
