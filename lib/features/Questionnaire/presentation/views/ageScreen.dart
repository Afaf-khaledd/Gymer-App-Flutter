import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/features/Questionnaire/presentation/views/workoutDays.dart';

import '../../../../core/components/customBlackButton.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/colors.dart';
import 'finalScreen.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  TextEditingController ageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    ageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
       // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Text("What Is Your Age", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
          Spacer(),
          SizedBox(
            width: screenWidth * 0.6,
            child: TextField(
              controller: ageController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 50),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.6), width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorsManager.goldColorO60, width: 1),
                ),
                contentPadding: EdgeInsets.zero,
              ),
              cursorWidth: 0,
            ),
          ),
          Spacer(),
          CustomBlackButton(label: 'Next', onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => WorkoutDaysScreen(),
            ),
            );}),
        ],
      ),
    );
  }
}