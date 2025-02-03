import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/components/customBlackButton.dart';
import 'package:gymer/core/components/customWhiteContainer.dart';
import 'package:gymer/core/utils/assets.dart';

import 'finalScreen.dart';
import 'heightScreen.dart';
import 'onboardingQ.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  String? selectedGoal;
  void toggleSelection(String goal) {
    setState(() {
      if (selectedGoal == goal) {
        selectedGoal = null;
      } else {
        selectedGoal = goal;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(AssetsManager.firstState),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (BuildContext context) => FinalScreen()),
              );
            },
            child: Text(
              'Skip',
              style: GoogleFonts.leagueSpartan(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(102, 102, 102, 0.7),
              ),
            ),
          ),
          SizedBox(width: 30),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("What Is Your Main", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
              SizedBox(height: 10),
              Text("Goal?", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
              SizedBox(height: 50),
              CustomWhiteContainer(
                label: "⬇️  Lose Weight",
                isSelected: selectedGoal == "Lose Weight",
                onTap: () => toggleSelection("Lose Weight"),
              ),
              CustomWhiteContainer(
                label: "⬆️  Gain Weight",
                isSelected: selectedGoal == "Gain Weight",
                onTap: () => toggleSelection("Gain Weight"),
              ),
              CustomWhiteContainer(
                label: "💪🏻  Muscle Gain",
                isSelected: selectedGoal == "Muscle Gain",
                onTap: () => toggleSelection("Muscle Gain"),

              ),
              CustomWhiteContainer(
                label: "🔋  Endurance",
                isSelected: selectedGoal == "Endurance",
                onTap: () => toggleSelection("Endurance"),
              ),
              Spacer(),
              CustomBlackButton(label: 'Next', onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) => OnboardingQ(label: 'Body Data', number: '2', rightPadding: 20, labelSize: 50, nextScreen: HeightScreen(),),
              ),
              );}),
            ],
          ),
        ),
      ),
    );
  }
}