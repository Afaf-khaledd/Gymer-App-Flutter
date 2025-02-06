import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/features/Questionnaire/presentation/views/workoutTime.dart';

import '../../../../core/components/customBlackButton.dart';
import '../../../../core/components/customWhiteContainer.dart';
import '../../../../core/utils/assets.dart';
import 'finalScreen.dart';

class WorkoutDaysScreen extends StatefulWidget {
  const WorkoutDaysScreen({super.key});

  @override
  State<WorkoutDaysScreen> createState() => _WorkoutDaysScreenState();
}

class _WorkoutDaysScreenState extends State<WorkoutDaysScreen> {
  Set<String> selectedDays = {};

  void toggleSelection(String day) {
    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      } else {
        selectedDays.add(day);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("On which days", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
            const SizedBox(height: 6),
            Text("can you workout?", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
            const SizedBox(height: 18),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomWhiteContainer(label: "Sunday", isSelected: selectedDays.contains("Sunday"), onTap: () => toggleSelection("Sunday")),
                    CustomWhiteContainer(label: "Monday", isSelected: selectedDays.contains("Monday"), onTap: () => toggleSelection("Monday")),
                    CustomWhiteContainer(label: "Tuesday", isSelected: selectedDays.contains("Tuesday"), onTap: () => toggleSelection("Tuesday")),
                    CustomWhiteContainer(label: "Wednesday", isSelected: selectedDays.contains("Wednesday"), onTap: () => toggleSelection("Wednesday")),
                    CustomWhiteContainer(label: "Thursday", isSelected: selectedDays.contains("Thursday"), onTap: () => toggleSelection("Thursday")),
                    CustomWhiteContainer(label: "Friday", isSelected: selectedDays.contains("Friday"), onTap: () => toggleSelection("Friday")),
                    CustomWhiteContainer(label: "Saturday", isSelected: selectedDays.contains("Saturday"), onTap: () => toggleSelection("Saturday")),
                  ],
                ),
              ),
            ),
            CustomBlackButton(
              label: 'Next',
              onPressed: selectedDays.isNotEmpty
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => WorkoutTimeScreen()),
                );
              }
                  : () {},
            ),
          ],
        ),
      ),
    );
  }
}