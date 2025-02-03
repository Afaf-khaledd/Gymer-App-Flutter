import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/Questionnaire/presentation/views/weightScreen.dart';
import 'package:simple_ruler_picker/simple_ruler_picker.dart';

import '../../../../core/components/customBlackButton.dart';
import '../../../../core/utils/assets.dart';
import 'finalScreen.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  double _height = 150;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            expandedHeight: 30,
            titleSpacing: 0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsetsDirectional.only(start: 60, end: 60, top: 35),
              title: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  AssetsManager.secondState,
                  height: 30,
                ),
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new, color: Color.fromRGBO(102, 102, 102, 1)),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => FinalScreen()),
                    );
                  },
                  child: Text(
                    'Skip',
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 18, fontWeight: FontWeight.w400, color: Color.fromRGBO(102, 102, 102, 0.7),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    Text(
                      "What Is Your Height?",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _height.toStringAsFixed(0),
                          style: GoogleFonts.poppins(fontSize: 54, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Cm',
                          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: screenHeight*0.48,
                      width: 170,
                      child: SimpleRulerPicker(
                        selectedColor: ColorsManager.goldColorO1,
                        labelColor: Colors.black45,
                        initialValue: _height.toInt(),
                        minValue: 0,
                        maxValue: 250,
                        lineStroke: 2,
                        longLineHeight: 50,
                        shortLineHeight: 25,
                        scaleItemWidth: 25,
                        scaleLabelSize: 24,
                       // scaleLabelWidth: 30,
                        lineColor: Colors.grey,
                        height: 400,
                        onValueChanged: (value) {
                          setState(() {
                            _height = value.toDouble();
                          });
                        },
                        axis: Axis.vertical,
                      ),
                    ),

                    const SizedBox(height: 80),
                    CustomBlackButton(
                      label: 'Next',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => WeightScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}