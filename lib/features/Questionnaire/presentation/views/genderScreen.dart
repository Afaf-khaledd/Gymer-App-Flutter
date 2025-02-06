import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/features/Questionnaire/presentation/views/ageScreen.dart';

import '../../../../core/components/CustomWhiteCircle.dart';
import '../../../../core/components/customBlackButton.dart';
import '../../../../core/utils/assets.dart';
import 'finalScreen.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? _selectedGender;

  void _selectGender(String gender) {
    setState(() {
      if (_selectedGender == gender) {
        _selectedGender = null;
      } else {
        _selectedGender = gender;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15,),
          Text("What Is Your Gender", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
          SizedBox(height: 40),
          CustomWhiteCircle(
            label: "Male",
            icon: Icons.male,
            isSelected: _selectedGender == "Male",
            onTap: () => _selectGender("Male"),
          ),
          const SizedBox(height: 40),
          CustomWhiteCircle(
            label: "Female",
            icon: Icons.female,
            isSelected: _selectedGender == "Female",
            onTap: () => _selectGender("Female"),
          ),

          Spacer(),
          CustomBlackButton(
            label: 'Next',
            onPressed: _selectedGender != null
                ? () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) => AgeScreen(),
              ),
              );
            }
                : () {},
          ),
        ],
      ),
    );
  }
}
