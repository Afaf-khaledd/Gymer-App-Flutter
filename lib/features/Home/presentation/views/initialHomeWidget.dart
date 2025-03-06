import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/colors.dart';
import 'goldBorderContainer.dart';

class InitialHomeWidget extends StatelessWidget {
  const InitialHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: GoldBorderContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(AssetsManager.chatbotIcon,
                height: 90, width: 90),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      " Ask ",
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        height: 1.2,
                        color: Colors.black,
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          const LinearGradient(
                            colors: [
                              ColorsManager.goldColorO1,
                              Color.fromRGBO(3, 19, 20, 1)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                      child: Text(
                        "GymTron",
                        style: GoogleFonts.dmSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "to create your\n workout plan",
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    height: 1.2,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}