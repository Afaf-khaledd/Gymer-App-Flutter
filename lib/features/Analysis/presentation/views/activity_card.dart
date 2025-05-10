import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ActivityCard extends StatelessWidget {
  final int monthNumber;
  final int points;
  final double percentage;
  const ActivityCard({super.key, required this.monthNumber, required this.points, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.goldColorO1.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.emoji_events_outlined, size: 20),
              SizedBox(width: 6),
              Text("Month $monthNumber", style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 22)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Available points",
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "$points pts",
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "This week points",
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4.0,bottom: 6),
                child: CircularPercentIndicator(
                  radius: 40.0,
                  lineWidth: 8.0,
                  percent: percentage,
                  center: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Today\n',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Colors.black45,
                          ),
                        ),
                        TextSpan(
                          text: "${(percentage * 100).toInt()}%",
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  progressColor: Colors.red,
                  backgroundColor: Colors.black12,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
