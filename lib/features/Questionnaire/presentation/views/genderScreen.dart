import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/features/Questionnaire/presentation/views/ageScreen.dart';

import '../../../../core/components/CustomWhiteCircle.dart';
import '../../../../core/components/customBlackButton.dart';
import '../../../../core/utils/assets.dart';
import '../view model/questionnaireCubit/questionnaire_cubit.dart';
import 'finalScreen.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({super.key});

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
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Skip',
                style: GoogleFonts.leagueSpartan(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(102, 102, 102, 0.7),
                ),
              ),
            ),
          ),
          const SizedBox(width: 30),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          Text("What Is Your Gender", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
          const SizedBox(height: 40),

          BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
            builder: (context, state) {
              String? selectedGender;

              if (state is QuestionnaireLoaded) {
                selectedGender = state.questionnaire.gender;
              }

              return Column(
                children: [
                  CustomWhiteCircle(
                    label: "Male",
                    icon: Icons.male,
                    isSelected: selectedGender == "Male",
                    onTap: () {
                      context.read<QuestionnaireCubit>().updateAnswer("gender", "Male");
                    },
                  ),
                  const SizedBox(height: 40),
                  CustomWhiteCircle(
                    label: "Female",
                    icon: Icons.female,
                    isSelected: selectedGender == "Female",
                    onTap: () {
                      context.read<QuestionnaireCubit>().updateAnswer("gender", "Female");
                    },
                  ),
                ],
              );
            },
          ),

          const Spacer(),

          BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
            builder: (context, state) {
              String? selectedGender;

              if (state is QuestionnaireLoaded) {
                selectedGender = state.questionnaire.gender;
              }

              return CustomBlackButton(
                label: 'Next',
                onPressed: selectedGender != null
                    ? () {
                  context.read<QuestionnaireCubit>().goToNextStep();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AgeScreen(),
                    ),
                  );
                }
                    : (){},
              );
            },
          ),
        ],
      ),
    );
  }
}
