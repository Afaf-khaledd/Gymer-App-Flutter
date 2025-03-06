import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutItem extends StatelessWidget {
  final String title;
  final String description;
  const WorkoutItem({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 3,
            height: 19,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                //width: 100,
                child: Text(
                  title,
                  style: GoogleFonts.leagueSpartan(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      height: 0.92,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                width: 110,
                child: Text(
                  description,
                  style: GoogleFonts.leagueSpartan(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      height: 0.99,
                      color: Colors.black54),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}