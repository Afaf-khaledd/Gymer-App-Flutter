import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:gymer/features/Achievements/presentation/views/AchievementsScreen.dart';
import 'package:gymer/features/Analysis/presentation/views/_buildError.dart';
import 'package:gymer/features/Analysis/presentation/views/emptyStateScreen.dart';
import 'package:gymer/features/Analysis/presentation/views/normalStateScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/components/BottomNavHandler.dart';
import '../../../../core/components/ImagePickerHelper.dart';
import '../../../MachineRecognition/presentation/view model/MachineCubit/machine_cubit.dart';
import '../../../MachineRecognition/presentation/views/targetMuscle.dart';
import '../view model/progressCubit/progress_cubit.dart';
import '../view model/progressCubit/progress_state.dart';
import '_buildShimmer.dart';
import 'finishStateScreen.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  final int _currentIndex = 3;

  @override
  void initState() {
    super.initState();
    _loadChecklistAndInitProgress();
  }

  Future<void> _loadChecklistAndInitProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final todayKey = 'checklist_${now.year}_${now.month}_${now.day}';

    final storedChecklist = prefs.getStringList(todayKey) ?? [];

    // Count how many items are checked
    final checkedCount = storedChecklist.length;

    if (mounted) {
      context.read<ProgressCubit>().getProgress(count: checkedCount);
      log("checkedCount:$checkedCount");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavHandler(
        currentIndex: _currentIndex,
        onImagePicked: (_) =>
            ImagePickerHelper.pickImage(context, _handleImagePicked),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        title: Text(
          'Activity',
          style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 26),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              AssetsManager.cupImage,
              width: 47,
              height: 47,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AchievementsScreen()),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 11),
        child: BlocBuilder<ProgressCubit, ProgressState>(
          builder: (context, state) {
            if (state is ProgressLoading) {
              return buildShimmer();
            } else if (state is ProgressEmpty) {
              return EmptyStateScreen();
            } else if (state is ProgressFinished) {
              return FinishStateScreen(data: state.data);
            } else if (state is ProgressNormal) {
              return NormalStateScreen(data: state.data);
            } else if (state is ProgressError) {
              return buildError(context, state.message);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  void _handleImagePicked(String imageBase64) {
    context.read<MachineCubit>().sendMachineImage(imageBase64);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TargetMuscle()),
        );
      }
    });
  }
}
