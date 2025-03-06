import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouriteMachineItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  final int index;

  const FavouriteMachineItem(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.onTap,
      required this.index});

  static const List<Color> colors = [
    Color.fromRGBO(3, 19, 20, 0.33),
    Color.fromRGBO(76, 137, 141, 0.66)
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors[index % colors.length],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                height: 1.5,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Center(
                child: Image.network(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
