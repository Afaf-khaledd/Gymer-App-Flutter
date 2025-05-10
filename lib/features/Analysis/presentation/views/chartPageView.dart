import 'package:flutter/material.dart';
import 'barChartWidget.dart';
import 'lineChartWidget.dart';

class ChartPageView extends StatelessWidget {
  const ChartPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const BouncingScrollPhysics(),
      children: const [
        BarChartWidget(isEmpty: false),
        LineChartWidget(),
      ],
    );
  }
}