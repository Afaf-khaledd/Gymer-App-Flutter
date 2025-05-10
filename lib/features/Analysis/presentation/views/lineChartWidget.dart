import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gymer/core/utils/colors.dart';

class LineChartWidget extends StatelessWidget {
  static const List<String> days = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun', 'Mon'];
  static const List<double> data = [800, 1000, 1100, 1200, 950, 1000, 870, 800, 1000, 1100];

  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final chartWidth = data.length * 70.0;

    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: SizedBox(
            width: chartWidth,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                backgroundColor: Colors.transparent,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(),
                  topTitles: AxisTitles(),
                  rightTitles: AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index < 0 || index >= days.length) return const SizedBox();
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            days[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                minY: 600,
                maxY: 1300,
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(data.length, (i) => FlSpot(i.toDouble(), data[i])),
                    isCurved: true,
                    barWidth: 4.0,
                    color: ColorsManager.goldColorO1,
                    dotData: FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
