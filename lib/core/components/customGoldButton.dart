import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class CustomGoldButton extends StatelessWidget {
  final String label;
  final double width;
  final double fontSize;
  final VoidCallback onPressed;
  const CustomGoldButton({super.key, required this.label, required this.onPressed, required this.width, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 13.0,left: 13,),
      child: SizedBox(
        width: width,
        //height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.goldColorO1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            shadowColor: Color.fromRGBO(3, 19, 20, 1),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}