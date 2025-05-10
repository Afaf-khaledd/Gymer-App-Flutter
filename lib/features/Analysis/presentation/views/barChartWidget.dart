import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';

class BarChartWidget extends StatelessWidget {
  final bool isEmpty;
  static const List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'];
  static const List<double> values = [200, 175, 250, 165, 170, 158, 200, 175, 100];

  const BarChartWidget({super.key, required this.isEmpty});

  @override
  Widget build(BuildContext context) {
    const double maxChartHeight = 150;
    final double maxValue = values.reduce((a, b) => a > b ? a : b);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(months.length, (index) {
                final barHeight = (values[index] / maxValue) * maxChartHeight;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
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
                          child: !isEmpty
                              ? Container(
                            width: 17,
                            height: barHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorsManager.goldColorO1,
                            ),
                          )
                              : const SizedBox(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        months[index],
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
        ],
      ),
    );
  }
}