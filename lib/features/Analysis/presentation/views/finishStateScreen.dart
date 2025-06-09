import 'package:flutter/material.dart';
import 'package:gymer/features/Analysis/data/models/activityModel.dart';
import 'package:gymer/features/Analysis/presentation/views/activity_card.dart';
import 'package:gymer/features/Analysis/presentation/views/finishContainer.dart';

class FinishStateScreen extends StatelessWidget {
  const FinishStateScreen({super.key, required this.data});
  final ActivityModel data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            ActivityCard(month: data.month,percentage: data.lastPercentage,points: data.points,),
            SizedBox(height: 40,),
            FinishContainer(),
          ],
        ),
      ),
    );
  }
}
