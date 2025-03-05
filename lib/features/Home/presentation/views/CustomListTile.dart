import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  final String text;
  final String? imagePath;
  final IconData? icon;
  final Color iconColor;
  final double iconSize;
  final Widget? trailing;

  const CustomListTile({
    super.key,
    required this.text,
    this.imagePath,
    this.icon,
    this.iconColor = Colors.red,
    this.iconSize = 28.0,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null)
              Icon(icon, color: iconColor, size: iconSize)
            else if (imagePath != null)
              Image.asset(imagePath!, width: 24, height: 24),
            const SizedBox(width: 8),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 17,
                height: 1.5,
                color: Colors.black,
              ),
            ),
          ],
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}