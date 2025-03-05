import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutItem extends StatelessWidget {
  const WorkoutItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Chest Press",
                style: GoogleFonts.leagueSpartan(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    height: 0.92,
                    color: Colors.black),
              ),
              Text(
                "3 Sets Of 8-12 Reps\n30-60 Seconds Rest",
                style: GoogleFonts.leagueSpartan(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 0.92,
                    color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}