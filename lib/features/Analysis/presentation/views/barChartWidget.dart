import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';
import '../../data/models/activityModel.dart';

class BarChartWidget extends StatelessWidget {
  final List<MonthlyProgress> monthlyProgress;
  static const double maxChartHeight = 150;

  const BarChartWidget({super.key, required this.monthlyProgress});

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = monthlyProgress.isEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress:',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: ColorsManager.goldColorO1,
            ),
          ),
          const SizedBox(height: 11),
          SizedBox(
            height: maxChartHeight + 56,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text('100', style: TextStyle(fontSize: 12)),
                    Text('50', style: TextStyle(fontSize: 12)),
                    Text('0', style: TextStyle(fontSize: 12)),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(monthlyProgress.length, (index) {
                        final monthData = monthlyProgress[index];
                        final double barHeight = (monthData.percentage / 100) * maxChartHeight;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 20,
                                height: maxChartHeight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: !isEmpty
                                      ? Container(
                                    width: 20,
                                    height: barHeight.isNaN ? 0 : barHeight,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorsManager.goldColorO1,
                                    ),
                                  )
                                      : const SizedBox(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                monthData.month,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(162, 132, 94, 1),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*
children: List.generate(monthlyProgress.length, (index) {
  final monthData = monthlyProgress[index];
  final double barHeight = (monthData.percentage / 100) * maxChartHeight;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 17,
          height: maxChartHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 17,
              height: barHeight.isNaN ? 0 : barHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorsManager.goldColorO1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          monthData.month,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(162, 132, 94, 1),
          ),
        ),
      ],
    ),
  );
}),
*/