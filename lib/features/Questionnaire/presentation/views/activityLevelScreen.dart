import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:gymer/features/Questionnaire/presentation/views/customSliderActivity.dart';
import 'package:gymer/features/Questionnaire/presentation/views/fitnessLevelScreen.dart';

import '../../../../core/components/customBlackButton.dart';
import 'finalScreen.dart';

class ActivityLevelScreen extends StatefulWidget {
  const ActivityLevelScreen({super.key});

  @override
  State<ActivityLevelScreen> createState() => _ActivityLevelScreenState();
}

class _ActivityLevelScreenState extends State<ActivityLevelScreen> {
  double _activityLevel = 0;

  final List<String> _labels = [
    "Sedentary",
    "Lightly Active",
    "Moderately Active",
    "Very Active",
  ];

  final List<String> _descriptions = [
    "I Seldom Exercise And Spend\n Most Of My Time Sitting",
    "I Engage In Occasional\n Walks Or Light Exercises",
    "I Do Moderate Exercises\n Several Times A Week ",
    "I Am Involved In Physical Activity For\n Several Hours Every Day",
  ];

  final List<String> _images = [
    AssetsManager.notActiveImage,
    AssetsManager.lightlyActiveImage,
    AssetsManager.moderatelyActiveImage,
    AssetsManager.veryActiveImage,
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    int index = _activityLevel.round();

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
            );},
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
              "Activity Level?",
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(),
            Image.asset(_images[index],height: screenHeight*0.18,),
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
            //const SizedBox(height: 50),
            Expanded(child: SizedBox()),
            CustomSliderActivity(
              value: _activityLevel,
              min: 0,
              max: 3,
              divisions: 3,
              onChanged: (value) {
                setState(() {
                  _activityLevel = value;
                });
              }, minLabel: 'Not Active', maxLabel: 'Very Active',
            ),
            SizedBox(height: 20,),
            CustomBlackButton(
              label: 'Next',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => FitnessLevelScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
