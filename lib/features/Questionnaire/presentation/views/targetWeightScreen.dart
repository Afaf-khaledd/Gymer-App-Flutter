import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/features/Questionnaire/presentation/views/genderScreen.dart';
import 'package:simple_ruler_picker/simple_ruler_picker.dart';

import '../../../../core/components/customBlackButton.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/colors.dart';
import '../view model/questionnaireCubit/questionnaire_cubit.dart';
import 'WeightToggleButton.dart';
import 'finalScreen.dart';
import 'onboardingQ.dart';

class TargetWeightScreen extends StatelessWidget {
  const TargetWeightScreen({super.key});

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
                  context.read<QuestionnaireCubit>().skipStep();
                  Navigator.pushReplacement(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) => const FinalScreen(),
                  ),
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

                    BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
                      builder: (context, state) {
                        double targetWeight = 90;
                        bool isMetric = true;

                        if (state is QuestionnaireLoaded) {
                          targetWeight = state.questionnaire.goalWeight?.toDouble() ?? 90;
                          isMetric = true;
                        }
                        return Column(
                          children: [
                            WeightToggleButton(
                              onToggle: (isMetric) {
                                context.read<QuestionnaireCubit>().updateAnswer("isMetric", isMetric);
                              },
                              isMetric: isMetric,
                            ),
                            const SizedBox(height: 10),

                            SimpleRulerPicker(
                              selectedColor: ColorsManager.goldColorO1,
                              labelColor: Colors.black45,
                              initialValue: targetWeight.toInt(),
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
                                context.read<QuestionnaireCubit>().updateAnswer("goalWeight", value);
                              },
                              axis: Axis.horizontal,
                            ),

                            const SizedBox(height: 40),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  targetWeight.toStringAsFixed(0),
                                  style: GoogleFonts.poppins(fontSize: 54, fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  isMetric ? 'KG' : 'LB',
                                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 153),

                    // Next Button
                    CustomBlackButton(
                      label: 'Next',
                      onPressed: () {
                        final questionnaireCubit = context.read<QuestionnaireCubit>();
                        final state = questionnaireCubit.state;
                        if (state is QuestionnaireLoaded && state.questionnaire.goalWeight == null) {
                          questionnaireCubit.updateAnswer("goalWeight", 90);
                        }
                        context.read<QuestionnaireCubit>().goToNextStep();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => OnboardingQ(
                              label: 'About You',
                              number: '3',
                              rightPadding: 20,
                              labelSize: 50,
                              nextScreen: GenderScreen(),
                            ),
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