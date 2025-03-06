import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/assets.dart';
import 'goldBorderContainer.dart';

class FreeWorkoutWidget extends StatelessWidget {
  const FreeWorkoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0,top: 6),
      child: GoldBorderContainer(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              AssetsManager.restDayImage,
              width: 130,
              height: 130,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "No Workout Today!",
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  " Enjoy your rest day!\n Recovery is important too. 💪",
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
