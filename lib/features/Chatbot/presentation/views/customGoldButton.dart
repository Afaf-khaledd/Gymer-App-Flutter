import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/colors.dart';

class CustomGoldButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const CustomGoldButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 254,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.goldColorO1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          shadowColor: const Color.fromRGBO(3, 19, 20, 1),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}