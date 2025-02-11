import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/components/customBlackButton.dart';
import 'package:gymer/core/components/customWhiteContainer.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:gymer/features/Questionnaire/presentation/views/finalScreen.dart';

import '../view model/questionnaireCubit/questionnaire_cubit.dart';
import 'activityLevelScreen.dart';
import 'onboardingQ.dart';

class WorkoutTimeScreen extends StatelessWidget {
  const WorkoutTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Color.fromRGBO(102, 102, 102, 1)),
        ),
        title: SvgPicture.asset(AssetsManager.thirdState),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              context.read<QuestionnaireCubit>().skipStep();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FinalScreen()),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("How long can", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
              const SizedBox(height: 10),
              Text("you workout?", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
              const SizedBox(height: 50),
              BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
                builder: (context, state) {
                  String? selectedTime;
                  if (state is QuestionnaireLoaded) {
                    selectedTime = state.questionnaire.duration;
                  }

                  return Column(
                    children: [
                      CustomWhiteContainer(
                        label: "About 15 minutes",
                        isSelected: selectedTime == "About 15 Min",
                        onTap: () => context.read<QuestionnaireCubit>().updateAnswer("duration", "About 15 Min"),
                      ),
                      CustomWhiteContainer(
                        label: "About 30 minutes",
                        isSelected: selectedTime == "About 30 Min",
                        onTap: () => context.read<QuestionnaireCubit>().updateAnswer("duration", "About 30 Min"),
                      ),
                      CustomWhiteContainer(
                        label: "About 1 hour",
                        isSelected: selectedTime == "About 1 Hour",
                        onTap: () => context.read<QuestionnaireCubit>().updateAnswer("duration", "About 1 Hour"),
                      ),
                      CustomWhiteContainer(
                        label: "More than 1 hour",
                        isSelected: selectedTime == "More Than 1 Hour",
                        onTap: () => context.read<QuestionnaireCubit>().updateAnswer("duration", "More Than 1 Hour"),
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
                builder: (context, state) {
                  bool isTimeSelected = (state is QuestionnaireLoaded) && state.questionnaire.duration != null;

                  return CustomBlackButton(
                    label: 'Next',
                    onPressed: isTimeSelected
                        ? () {
                      context.read<QuestionnaireCubit>().goToNextStep();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OnboardingQ(
                            label: 'Fitness Analysis',
                            number: '4',
                            rightPadding: 40,
                            labelSize: 40,
                            nextScreen: const ActivityLevelScreen(),
                          ),
                        ),
                      );
                    }
                        : (){},
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
