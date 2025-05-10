import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/assets.dart';

import '../../../../core/components/customGoldButton.dart';
import 'goldBoxContainer.dart';

class FinishContainer extends StatelessWidget {
  const FinishContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GoldBoxContainer(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Congrats",
              textAlign: TextAlign.center,
              style: GoogleFonts.leagueSpartan(
                  fontSize: 25, fontWeight: FontWeight.w700),
            ),
            Image.asset(AssetsManager.completeImage,height: 100,),
            Text(
              "On Completing Your Monthly Plan",
              textAlign: TextAlign.center,
              style: GoogleFonts.leagueSpartan(
                  fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter weight',
                      hintStyle:GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13,color: Colors.black54,),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 5,),
                Image.asset(AssetsManager.leftArrowIcon),
                CustomGoldButton(
                  label: 'Submit &\nAsk GymTron',
                  onPressed: () {},
                  width: 120, fontSize: 12,
                )
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'For Editing Any\nOther Information',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14,color: Colors.black54),
                ),
                SizedBox(width: 4,),
                Image.asset(AssetsManager.leftArrowIcon),
                CustomGoldButton(
                  label: 'Edit Profile',
                  onPressed: () {},
                  width: 120, fontSize: 12,
                )
              ],
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
