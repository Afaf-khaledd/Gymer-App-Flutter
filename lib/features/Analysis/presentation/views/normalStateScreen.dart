import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/features/Analysis/presentation/views/activity_card.dart';
import 'package:gymer/features/Analysis/presentation/views/chartPageView.dart';
import 'package:gymer/features/Analysis/presentation/views/checklistWidget.dart';

import '../../../../core/utils/assets.dart';
import '../../../Home/presentation/viewModel/homeCubit/home_cubit.dart';
import '../../../Home/presentation/viewModel/homeCubit/home_state.dart';
import '../../../Home/presentation/views/goldBorderContainer.dart';
import '../../data/models/activityModel.dart';

class NormalStateScreen extends StatefulWidget {
  const NormalStateScreen({super.key, required this.data});
  final ActivityModel data;

  @override
  State<NormalStateScreen> createState() => _NormalStateScreenState();
}

class _NormalStateScreenState extends State<NormalStateScreen> {

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().checkWorkoutPlan();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ActivityCard(month: widget.data.month,percentage: widget.data.lastPercentage,points: widget.data.points,),
          SizedBox(height: 25,),

          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoaded) {
                final List<String> workoutKeys = state.workout.keys.toList();
                return ChecklistWidget(workoutKeys: workoutKeys);
              } else if (state is HomeError) {
                return Column(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    Text("Failed to load workout plan"),
                    Text(state.message, style: const TextStyle(color: Colors.grey)),
                  ],
                );
              } else {
                return GoldBorderContainer(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AssetsManager.restDayImage,
                        width: 110,
                        height: 110,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "No Workout Today!",
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            " Enjoy your rest day!\n Recovery is important too. 💪",
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          SizedBox(height: 25,),
          Expanded(
              child: ChartPageView(monthlyProgress: widget.data.monthlyProgress, percentageHistory: widget.data.percentageHistory,)
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
