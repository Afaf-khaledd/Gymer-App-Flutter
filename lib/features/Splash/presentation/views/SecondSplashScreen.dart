import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/Boarding/presentation/views/OnBoardingPage.dart';

class SecondSplashScreen extends StatefulWidget {
  const SecondSplashScreen({super.key});
  @override
  State<SecondSplashScreen> createState() => _SecondSplashScreenState();
}

class _SecondSplashScreenState extends State<SecondSplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnBoardingPage()));
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.BGColor,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "LET'S",
                      style: GoogleFonts.leagueSpartan(
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                          color: ColorsManager.blackColor,
                          height: 0.5),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'WORK',
                      style: GoogleFonts.leagueSpartan(
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                          color: ColorsManager.blackColor,
                          height: 0.5),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'OUT TOGETHER',
                      style: GoogleFonts.leagueSpartan(
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                          color: ColorsManager.blackColor,
                          height: 0.5),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          'GYMER',
                          style: GoogleFonts.poppins(
                              fontSize: 54,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.italic,
                              color: ColorsManager.blackColor,
                              height: 1.5),
                        )
                      ],
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 5,
              child: SvgPicture.asset(
                AssetsManager.splashImage,
                fit: BoxFit.contain,
              ))
        ],
      )),
    );
  }
}
