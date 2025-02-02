import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';

class OnboardingQ extends StatefulWidget {
  final String label;
  final String number;
  final double rightPadding;
  final double labelSize;
  final Widget nextScreen;
  const OnboardingQ({super.key, required this.label, required this.number, required this.rightPadding, required this.labelSize, required this.nextScreen});

  @override
  State<OnboardingQ> createState() => _OnboardingQState();
}

class _OnboardingQState extends State<OnboardingQ> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerRight,
        children: [
          Positioned(
            right: -widget.rightPadding,
            child: Text(
              widget.number,
              style: GoogleFonts.poppins(
                fontSize: 400,
                fontWeight: FontWeight.w600,
                color: ColorsManager.goldColorO60,
              ),
            ),
          ),
          Positioned(
            right: screenWidth * 0.179,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.label,
                  style: GoogleFonts.poppins(
                    fontSize: widget.labelSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 22.0),
                  child: Container(
                    width: screenWidth * 0.65,
                    height: 15,
                    decoration: BoxDecoration(
                      color: ColorsManager.goldColorO1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    navigateTo();
  }
  void navigateTo() {
    Future.delayed(const Duration(seconds: 2,milliseconds: 30),(){
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (BuildContext context) => widget.nextScreen,
      ),
      );
    });
  }
}
