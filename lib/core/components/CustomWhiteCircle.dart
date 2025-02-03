import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';

class CustomWhiteCircle extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;

  const CustomWhiteCircle({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 163,
            height: 163,
            decoration: BoxDecoration(
              color: isSelected ? ColorsManager.goldColorO60 : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: isSelected ? ColorsManager.goldColorO60 : Colors.grey.withOpacity(0.4),
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 90,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
