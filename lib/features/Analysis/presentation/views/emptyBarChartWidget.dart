import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gymer/core/utils/colors.dart';

class EmptyBarChartWidget extends StatelessWidget {
  const EmptyBarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 30,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY.round()} sessions',
                const TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false,),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
              reservedSize: 28,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false, horizontalInterval: 5),
        barGroups: _getBarGroups(),
      ),
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    final data = [
      5.0, 7.0, 6.0, 10.0, 8.0, 12.0,
      15.0, 14.0, 13.0, 9.0, 6.0, 11.0
    ]; // Monthly progress data (e.g., workouts per month)

    return List.generate(data.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data[index],
            color: ColorsManager.goldColorO1,
            width: 14,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    final index = value.toInt();
    final text = index >= 0 && index < months.length ? months[index] : '';

    return SideTitleWidget(
      space: 6,
      meta: meta,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
