import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/components/customBlackButton.dart';
import 'package:gymer/features/Home/presentation/views/homeScreen.dart';

import '../../../../core/utils/assets.dart';

class FinalScreen extends StatelessWidget {
  const FinalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(49, 44, 40, 1),
                ),
              ),
            ),
            const Spacer(),
            CustomBlackButton(label: 'Let’s Go', onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
              );
            }),
          ],
        ),
      ),
    );
  }
}
