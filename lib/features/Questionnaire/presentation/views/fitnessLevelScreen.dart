import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/features/Questionnaire/presentation/views/finalScreen.dart';

import '../../../../core/components/customBlackButton.dart';
import '../../../../core/utils/assets.dart';
import 'customSliderActivity.dart';

class FitnessLevelScreen extends StatefulWidget {
  const FitnessLevelScreen({super.key});

  @override
  State<FitnessLevelScreen> createState() => _FitnessLevelScreenState();
}

class _FitnessLevelScreenState extends State<FitnessLevelScreen> {
  double _fitnessLevel = 0;

  final List<String> _labels = [
    "Beginner",
    "Intermediate",
    "Advanced",
  ];

  final List<double> _sizes = [
    0.05,
    0.1,
    0.15,
  ];

  final List<String> _descriptions = [
    "I Never Worked Out Before",
    "I Have Worked Out Before\n But Not Consistently",
    "I Have Worked Consistently\n For A Long Time ",
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    int index = _fitnessLevel.round();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Color.fromRGBO(102, 102, 102, 1)),
        ),
        title: SvgPicture.asset(AssetsManager.forthState,width: 280,),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "What's Your",
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "Fitness Level?",
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(),
            SizedBox(
              height: screenHeight*0.24,
              child: Center(
                child: Text(
                  '🔥',
                  style: TextStyle(
                    fontSize: screenHeight * _sizes[index],
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _labels[index],
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _descriptions[index],
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Expanded(child: SizedBox()),
            CustomSliderActivity(
              value: _fitnessLevel,
              min: 0,
              max: 2,
              divisions: 2,
              onChanged: (value) {
                setState(() {
                  _fitnessLevel = value;
                });
              }, minLabel: 'Beginner', maxLabel: 'Advanced',
            ),
            SizedBox(height: 20,),
            CustomBlackButton(
              label: 'Finish',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => FinalScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
