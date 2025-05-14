import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/Questionnaire/presentation/view%20model/questionnaireCubit/questionnaire_cubit.dart';

import '../../../../core/components/customBlackButton.dart';
import '../../../../core/utils/assets.dart';
import 'customSliderActivity.dart';
import 'finalScreen.dart';

class FitnessLevelScreen extends StatelessWidget {
  const FitnessLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Color.fromRGBO(102, 102, 102, 1)),
        ),
        title: SvgPicture.asset(AssetsManager.forthState, width: 280),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              context.read<QuestionnaireCubit>().skipStep();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FinalScreen()));
            },
            child: Text(
              'Skip',
              style: GoogleFonts.leagueSpartan(fontSize: 18, fontWeight: FontWeight.w400, color: const Color.fromRGBO(102, 102, 102, 0.7)),
            ),
          ),
          const SizedBox(width: 30),
        ],
      ),
      body: BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
        builder: (context, state) {
          if (state is! QuestionnaireLoaded) return const Center(child: CircularProgressIndicator(color: ColorsManager.goldColorO1,));

          final questionnaire = state.questionnaire;
          double fitnessLevel = _getFitnessLevelIndex(questionnaire.fittnesslevel);
          double screenHeight = MediaQuery.of(context).size.height;
          int index = fitnessLevel.round();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("What's Your", style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w700)),
                Text("Fitness Level?", style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w700)),
                const Spacer(),
                SizedBox(
                  height: screenHeight * 0.24,
                  child: Center(
                    child: Text(
                      '🔥',
                      style: TextStyle(fontSize: screenHeight * _sizes[index], color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(fitness_level[index], style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 5),
                Text(
                  _descriptions[index],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[600]),
                ),
                Expanded(child: SizedBox()),
                CustomSliderActivity(
                  value: fitnessLevel,
                  min: 0,
                  max: 2,
                  divisions: 2,
                  onChanged: (value) {
                    context.read<QuestionnaireCubit>().updateAnswer("fittnesslevel", fitness_level[value.round()]);
                  },
                  minLabel: 'Beginner',
                  maxLabel: 'Advanced',
                ),
                const SizedBox(height: 20),
                CustomBlackButton(
                  label: 'Finish',
                  onPressed: () async {
                    final questionnaireCubit = context.read<QuestionnaireCubit>();
                    final state = questionnaireCubit.state;
                    if (state is QuestionnaireLoaded && state.questionnaire.fittnesslevel == null) {
                      questionnaireCubit.updateAnswer("fittnesslevel", fitness_level[0]);
                    }
                    try {
                      await questionnaireCubit.submitQuestionnaire();

                      final newState = questionnaireCubit.state;
                      if (newState is QuestionnaireSubmitted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const FinalScreen()),
                        );
                      } else if (newState is QuestionnaireError) {
                        Fluttertoast.showToast(
                          msg: newState.message,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: "An error occurred. Please try again.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static const List<String> fitness_level = [
    "Beginner",
    "Intermediate",
    "Advanced",
  ];

  static final List<double> _sizes = [
    0.05,
    0.1,
    0.15,
  ];

  static final List<String> _descriptions = [
    "I Never Worked Out Before",
    "I Have Worked Out Before\n But Not Consistently",
    "I Have Worked Consistently\n For A Long Time",
  ];

  double _getFitnessLevelIndex(String? level) {
    return fitness_level.indexOf(level ?? "Beginner").toDouble();
  }
}
