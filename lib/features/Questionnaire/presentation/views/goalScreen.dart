import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/components/customBlackButton.dart';
import 'package:gymer/core/components/customWhiteContainer.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:gymer/features/Questionnaire/presentation/views/finalScreen.dart';

import '../view model/questionnaireCubit/questionnaire_cubit.dart';
import 'heightScreen.dart';
import 'onboardingQ.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {

  @override
  void initState() {
    super.initState();
    context.read<QuestionnaireCubit>().initializeQuestionnaire();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SvgPicture.asset(AssetsManager.firstState),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              context.read<QuestionnaireCubit>().skipStep();
              Navigator.pushReplacement(context, MaterialPageRoute<void>(
                builder: (BuildContext context) => const FinalScreen(),
              ),
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

              BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
                builder: (context, state) {
                  String? selectedGoal;
                  if (state is QuestionnaireLoaded) {
                    selectedGoal = state.questionnaire.maingoal;
                  }

                  return Column(
                    children: [
                      CustomWhiteContainer(
                        label: "⬇️  Lose Weight",
                        isSelected: selectedGoal == "Lose Weight",
                        onTap: () => context.read<QuestionnaireCubit>().updateAnswer("maingoal", "Lose Weight"),
                      ),
                      CustomWhiteContainer(
                        label: "⬆️  Gain Weight",
                        isSelected: selectedGoal == "Gain Weight",
                        onTap: () => context.read<QuestionnaireCubit>().updateAnswer("maingoal", "Gain Weight"),
                      ),
                      CustomWhiteContainer(
                        label: "💪🏻  Muscle Gain",
                        isSelected: selectedGoal == "Muscle Gain",
                        onTap: () => context.read<QuestionnaireCubit>().updateAnswer("maingoal", "Muscle Gain"),
                      ),
                      CustomWhiteContainer(
                        label: "🔋  Endurance",
                        isSelected: selectedGoal == "Endurance",
                        onTap: () => context.read<QuestionnaireCubit>().updateAnswer("maingoal", "Endurance"),
                      ),
                    ],
                  );
                },
              ),

              Spacer(),

              BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
                builder: (context, state) {
                  bool isGoalSelected = (state is QuestionnaireLoaded) && state.questionnaire.maingoal != null;

                  return CustomBlackButton(
                    label: 'Next',
                    onPressed: isGoalSelected
                        ? () {
                      context.read<QuestionnaireCubit>().goToNextStep();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => OnboardingQ(
                            label: 'Body Data',
                            number: '2',
                            rightPadding: 20,
                            labelSize: 50,
                            nextScreen: HeightScreen(),
                          ),
                        ),
                      );
                    }
                        : () {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}