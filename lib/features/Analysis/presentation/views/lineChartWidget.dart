import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';

import '../../data/models/activityModel.dart';

class LineChartWidget extends StatefulWidget {
  final List<PercentageHistory> percentageHistory;

  const LineChartWidget({super.key, required this.percentageHistory});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final data = widget.percentageHistory;
    final days = data.map((e) => e.day).toList();

    final numericValues = data
        .map((e) => e.percentage)
        .whereType<num>()
        .map((e) => e.toDouble())
        .toList();

    final double minY = numericValues.isEmpty ? 0.0 : (numericValues.reduce((a, b) => a < b ? a : b)) - 50;
    final double maxY = numericValues.isEmpty ? 100.0 : (numericValues.reduce((a, b) => a > b ? a : b)) + 50;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (touchedIndex != null)
          Center(
            child: Text(
              data[touchedIndex!].percentage is num
                  ? "${(data[touchedIndex!].percentage as num).toInt().toString()}%"
                  : 'Your rest day 😌',
              style: GoogleFonts.leagueSpartan(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 30,),
              SizedBox(
                width: data.length * 100.0,
                height: 180,
                child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      backgroundColor: Colors.transparent,
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false,), // Disable Y-axis numbers
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false), // No top titles
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false), // No right titles
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            reservedSize: 48,
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index < 0 || index >= days.length) return const SizedBox();
                              return Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Text(
                                  days[index],
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      minY: minY,
                      maxY: maxY,
                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(
                            data.length,
                                (i) {
                              final val = data[i].percentage;
                              final yValue = val is num ? val.toDouble() : minY;
                              return FlSpot(i.toDouble(), yValue);
                            },
                          ),
                          isCurved: true,
                          barWidth: 4.0,
                          color: ColorsManager.goldColorO1,
                          dotData: FlDotData(show: numericValues.length == 1 ? true : false),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((touchedSpot) {
                              final index = touchedSpot.x.toInt();
                              final val = data[index].percentage;
                              return LineTooltipItem(
                                val.toString(),
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }).toList();
                          },
                        ),
                        handleBuiltInTouches: true,
                        touchCallback: (event, response) {
                          if (response == null || response.lineBarSpots == null) {
                            setState(() => touchedIndex = null);
                            return;
                          }
                          setState(() {
                            touchedIndex = response.lineBarSpots![0].x.toInt();
                          });
                        },
                      ),
                    ),
                  ),
              ),
              SizedBox(width: 30,),
            ],
          ),
        ),
      ],
    );
  }
}
