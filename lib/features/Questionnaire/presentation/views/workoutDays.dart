import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/features/Questionnaire/presentation/views/workoutTime.dart';

import '../../../../core/components/customBlackButton.dart';
import '../../../../core/components/customWhiteContainer.dart';
import '../../../../core/utils/assets.dart';
import '../view model/questionnaireCubit/questionnaire_cubit.dart';
import 'finalScreen.dart';

class WorkoutDaysScreen extends StatelessWidget {
  const WorkoutDaysScreen({super.key});

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
        title: SvgPicture.asset(AssetsManager.thirdState),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("On which days", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
            const SizedBox(height: 6),
            Text("can you workout?", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
            const SizedBox(height: 18),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var day in ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"])
                      _buildDayContainer(context, day),
                  ],
                ),
              ),
            ),
            BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
              builder: (context, state) {
                if (state is! QuestionnaireLoaded) return SizedBox();
                bool isDaysSelected = state.questionnaire.workoutDays?.isNotEmpty ?? false;
                return CustomBlackButton(
                  label: 'Next',
                  onPressed: isDaysSelected
                      ? () {
                    context.read<QuestionnaireCubit>().goToNextStep();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WorkoutTimeScreen()),
                    );
                  }
                      : (){},
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayContainer(BuildContext context, String day) {
    return BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
      builder: (context, state) {
        if (state is! QuestionnaireLoaded) return SizedBox();
        bool isSelected = state.questionnaire.workoutDays?.contains(day) ?? false;

        return CustomWhiteContainer(
          label: day,
          isSelected: isSelected,
          onTap: () {
            context.read<QuestionnaireCubit>().toggleWorkoutDay(day);
          },
        );
      },
    );
  }
}