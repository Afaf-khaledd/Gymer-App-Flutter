import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/features/Questionnaire/presentation/views/workoutDays.dart';

import '../../../../core/components/customBlackButton.dart';
import '../../../../core/components/customWhiteContainer.dart';
import '../../../../core/utils/assets.dart';
import '../view model/questionnaireCubit/questionnaire_cubit.dart';
import 'finalScreen.dart';

class InjuriesScreen extends StatelessWidget {
  InjuriesScreen({super.key});
  final Map<String, String> injuryList = {
    'No injuries': '✅',
    'Shoulder': '🏋🏻',
    'Arm': '💪🏻',
    'Chest': '❤️',
    'Breathing': '🫁',
    'Back': '🧍🏻',
    'Leg': '🦵🏻',
    'Calf': '🦵🏻',
    'Hip': '🦵🏻',
    'Glutes': '🤫',
  };
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
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.208),
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
            Text("Do You Have", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
            const SizedBox(height: 6),
            Text(" Any Injuries?", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
            const SizedBox(height: 18),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var injure in injuryList.keys)
                      _buildInjureContainer(context, injure),
                  ],
                ),
              ),
            ),
            BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
              builder: (context, state) {
                if (state is! QuestionnaireLoaded) return SizedBox();
                bool isInjuresSelected = state.questionnaire.injuries?.isNotEmpty ?? false;
                return CustomBlackButton(
                  label: 'Next',
                  onPressed: isInjuresSelected
                      ? () {
                    context.read<QuestionnaireCubit>().goToNextStep();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WorkoutDaysScreen()),
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
  Widget _buildInjureContainer(BuildContext context, String injure) {
    return BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
      builder: (context, state) {
        if (state is! QuestionnaireLoaded) return SizedBox();
        bool isSelected = state.questionnaire.injuries?.contains(injure) ?? false;

        return CustomWhiteContainer(
          label: "${injuryList[injure]}  $injure",
          isSelected: isSelected,
          onTap: () => context.read<QuestionnaireCubit>().toggleInjure(injure),
        );
      },
    );
  }
}