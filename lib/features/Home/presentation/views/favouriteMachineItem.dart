import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouriteMachineItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const FavouriteMachineItem({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 170,
          padding: const EdgeInsets.symmetric(horizontal: 11),
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: 85,
                height: 85,
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      );
  }
}