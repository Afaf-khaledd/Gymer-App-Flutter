import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/features/Splash/presentation/views/SplashScreen.dart';

import '../../../../core/components/customBlackButton.dart';
import '../../../../core/components/customWhiteContainer.dart';
import '../../../../core/utils/assets.dart';
import 'activityLevelScreen.dart';
import 'finalScreen.dart';
import 'onboardingQ.dart';

class WorkoutTimeScreen extends StatefulWidget {
  const WorkoutTimeScreen({super.key});

  @override
  State<WorkoutTimeScreen> createState() => _WorkoutTimeScreenState();
}

class _WorkoutTimeScreenState extends State<WorkoutTimeScreen> {
  String? selectedTime;
  void toggleSelection(String choice) {
    setState(() {
      if (selectedTime == choice) {
        selectedTime = null;
      } else {
        selectedTime = choice;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Navigator.pop(context);},
          icon: Icon(Icons.arrow_back_ios_new, color: Color.fromRGBO(102, 102, 102, 1)),
        ),
        title: SvgPicture.asset(AssetsManager.thirdState),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (BuildContext context) => FinalScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                'Skip',
                style: GoogleFonts.leagueSpartan(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(102, 102, 102, 0.7),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("How long can", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
              SizedBox(height: 10),
              Text("you workout?", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
              SizedBox(height: 50),
              CustomWhiteContainer(
                label: "About 15 minutes",
                isSelected: selectedTime == "About 15 minutes",
                onTap: () => toggleSelection("About 15 minutes"),
              ),
              CustomWhiteContainer(
                label: "About 30 minutes",
                isSelected: selectedTime == "About 30 minutes",
                onTap: () => toggleSelection("About 30 minutes"),
              ),
              CustomWhiteContainer(
                label: "About 1 hour",
                isSelected: selectedTime == "About 1 hour",
                onTap: () => toggleSelection("About 1 hour"),

              ),
              CustomWhiteContainer(
                label: "More than 1 hour",
                isSelected: selectedTime == "More than 1 hour",
                onTap: () => toggleSelection("More than 1 hour"),
              ),
              Spacer(),
              CustomBlackButton(label: 'Next', onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (BuildContext context) => OnboardingQ(label: 'Fitness Analysis', number: '4', rightPadding: 40, labelSize: 40, nextScreen: ActivityLevelScreen(),),
                ),
                );}),
            ],
          ),
        ),
      ),
    );
  }
}
