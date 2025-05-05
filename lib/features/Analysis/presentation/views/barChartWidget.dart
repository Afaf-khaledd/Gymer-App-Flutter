import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';

class BarChartWidget extends StatelessWidget {
  final bool isEmpty;
  static const List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jan', 'Feb', 'Mar'];
  static const List<double> values = [200, 175, 250, 165, 170, 158, 200, 175, 100];

  /*
  final List<String> lastMonths = months.sublist(months.length - 4);
  final List<double> lastValues = values.sublist(values.length - 4);
  */

  const BarChartWidget({super.key, required this.isEmpty});

  @override
  Widget build(BuildContext context) {
    const double maxChartHeight = 100;
    final double maxValue = values.reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 80),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsManager.goldColorO1,
          width: 0.9,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          const SizedBox(height: 15),
          SizedBox(
            height: 150,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(months.length, (index) {
                  final barHeight = (values[index] / maxValue) * maxChartHeight;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              width: 17,
                              height: maxChartHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[300],
                              ),
                            ),
                            !isEmpty ? Container(
                              width: 17,
                              height: barHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorsManager.goldColorO1,
                              ),
                            ):SizedBox()
                          ],
                        ),
                        const SizedBox(height: 11),
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
          ),
        ],
      ),
    );
  }
}
