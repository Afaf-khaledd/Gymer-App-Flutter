import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomGreyCard extends StatelessWidget {
  final String text;
  const CustomGreyCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(201, 201, 201, 0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
