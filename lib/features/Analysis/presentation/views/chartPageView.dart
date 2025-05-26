import 'package:flutter/material.dart';
import '../../data/models/activityModel.dart';
import 'barChartWidget.dart';
import 'lineChartWidget.dart';

class ChartPageView extends StatelessWidget {
  const ChartPageView({super.key, required this.monthlyProgress, required this.percentageHistory});
  final List<MonthlyProgress> monthlyProgress;
  final List<PercentageHistory> percentageHistory;

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const BouncingScrollPhysics(),
      children: [
        BarChartWidget(monthlyProgress: monthlyProgress,),
        LineChartWidget(percentageHistory: percentageHistory,),
      ],
    );
  }
}