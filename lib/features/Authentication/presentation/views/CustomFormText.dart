import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFormText extends StatelessWidget {
  final String text;
  const CustomFormText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      "  $text",
      style: GoogleFonts.leagueSpartan(fontWeight: FontWeight.w400, fontSize: 18),
    );
  }
}