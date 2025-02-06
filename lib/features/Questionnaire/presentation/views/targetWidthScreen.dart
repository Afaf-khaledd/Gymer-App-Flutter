import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/features/Questionnaire/presentation/views/genderScreen.dart';
import 'package:gymer/features/Questionnaire/presentation/views/onboardingQ.dart';
import 'package:simple_ruler_picker/simple_ruler_picker.dart';

import '../../../../core/components/customBlackButton.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/colors.dart';
import 'WeightToggleButton.dart';
import 'finalScreen.dart';

class TargetWidthScreen extends StatefulWidget {
  const TargetWidthScreen({super.key});

  @override
  State<TargetWidthScreen> createState() => _TargetWidthScreenState();
}

class _TargetWidthScreenState extends State<TargetWidthScreen> {
  double _weight = 90;
  bool _isMetric = true;

  void _toggleWeightUnit(bool isMetric) {
    setState(() {
      _isMetric = isMetric;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
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
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => FinalScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
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
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "What Is Your ",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 30
                            ),
                          ),
                          TextSpan(
                            text: "Target",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              color: ColorsManager.goldColorO1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Weight?",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 30
                      ),
                    ),
                    const SizedBox(height: 30),
                    WeightToggleButton(
                      onToggle: _toggleWeightUnit,
                      isMetric: _isMetric,
                    ),
                    const SizedBox(height: 10),
                    SimpleRulerPicker(
                      selectedColor: ColorsManager.goldColorO1,
                      labelColor: Colors.black45,
                      initialValue: _weight.toInt(),
                      minValue: 0,
                      maxValue: 500,
                      lineStroke: 2,
                      longLineHeight: 50,
                      shortLineHeight: 25,
                      scaleItemWidth: 25,
                      scaleLabelSize: 30,
                      scaleLabelWidth: 50,
                      lineColor: Colors.grey,
                      height: 200,
                      onValueChanged: (value) {
                        setState(() {
                          _weight = value.toDouble();
                        });
                      },
                      axis: Axis.horizontal,
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _weight.toStringAsFixed(0),
                          style: GoogleFonts.poppins(fontSize: 54, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          _isMetric?'KG':'LB',
                          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),

                    const SizedBox(height: 153),
                    CustomBlackButton(
                      label: 'Next',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) => OnboardingQ(label: 'About You', number: '3', rightPadding: 20, labelSize: 50, nextScreen: GenderScreen(),),
                        ),
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