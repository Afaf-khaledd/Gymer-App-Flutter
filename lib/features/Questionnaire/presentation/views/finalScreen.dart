import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/components/customBlackButton.dart';

import '../../../../core/utils/assets.dart';

class FinalScreen extends StatelessWidget {
  const FinalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Color.fromRGBO(102, 102, 102, 1)),
        ),
        title: SvgPicture.asset(AssetsManager.finalState,width: 280,),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(AssetsManager.consistencyImage),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                "Consistency Is\nThe Key To Progress.\nDon't Give Up!",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 33,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            CustomBlackButton(label: 'Let’s Go', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
