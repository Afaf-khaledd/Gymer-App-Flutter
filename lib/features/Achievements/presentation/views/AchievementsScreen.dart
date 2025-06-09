import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/Achievements/presentation/view%20model/achievement_cubit.dart';
import 'package:gymer/features/Achievements/presentation/view%20model/achievement_state.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchivementsScreenState();
}

class _AchivementsScreenState extends State<AchievementsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AchievementCubit>().getAchievements();
  }

  String _getAchievementName(int level) {
    switch (level) {
      case 1:
        return 'First Step';
      case 2:
        return 'Consistent';
      case 3:
        return 'Machine Master';
      default:
        return 'Unknown';
    }
  }

  String _getAchievementImage(int level) {
    switch (level) {
      case 1:
        return AssetsManager.firstStepImage;
      case 2:
        return AssetsManager.consistentImage;
      case 3:
        return AssetsManager.machineMasterImage;
      default:
        return AssetsManager.firstStepImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.BGColor,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    size: 28,
                    color: ColorsManager.blackColor,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Achievements',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                      color: ColorsManager.blackColor),
                )
              ],
            ),
          ),
          BlocBuilder<AchievementCubit, AchievementState>(
            builder: (context, state) {
              if (state is AchievementLoading) {
                return const CircularProgressIndicator();
              } else if (state is AchievementLoaded) {
                final level = state.achievement.achievementsLevel;

                String imagePath;
                String achievementName;

                switch (level) {
                  case 1:
                    imagePath = AssetsManager.firstStepImage;
                    achievementName = 'First Step';
                    break;
                  case 2:
                    imagePath = AssetsManager.consistentImage;
                    achievementName = 'Consistent';
                    break;
                  case 3:
                    imagePath = AssetsManager.machineMasterImage;
                    achievementName = 'Machine Master';
                    break;
                  default:
                    imagePath = AssetsManager.firstStepImage;
                    achievementName = 'First Step';
                }
                return Column(
                  children: [
                    const SizedBox(height: 24),
                    Image.asset(
                      imagePath,
                      width: 130,
                      height: 130,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      achievementName,
                      style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: ColorsManager.goldColorO1),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(244, 229, 198, 0.23),
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${state.achievement.points} Points',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: ColorsManager.blackColor),
                              ),
                              Text(
                                '${state.achievement.pointsToNextLevel} to ${_getAchievementName(state.achievement.achievementsLevel + 1)}',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: ColorsManager.goldColorO1),
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LinearProgressIndicator(
                              value: state.achievement.points /
                                  (state.achievement.points +
                                      state.achievement.pointsToNextLevel),
                              minHeight: 12,
                              backgroundColor: Colors.grey.shade300,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  ColorsManager.goldColorO1),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Current Achievements',
                          style: GoogleFonts.dmSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: ColorsManager.blackColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (level >= 1)
                            Column(
                              children: [
                                Image.asset(
                                  AssetsManager.firstStepImage,
                                  width: 60,
                                  height: 60,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'First Step',
                                  style: GoogleFonts.dmSans(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          if (level >= 2)
                            Column(
                              children: [
                                Image.asset(
                                  AssetsManager.consistentImage,
                                  width: 60,
                                  height: 60,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Consistent',
                                  style: GoogleFonts.dmSans(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          if (level >= 3)
                            Column(
                              children: [
                                Image.asset(
                                  AssetsManager.machineMasterImage,
                                  width: 60,
                                  height: 60,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Machine Master',
                                  style: GoogleFonts.dmSans(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Coming Up Next',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: ColorsManager.blackColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(244, 229, 198, 0.23),
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        children: [
                          Image.asset(
                            _getAchievementImage(
                                state.achievement.achievementsLevel + 1),
                            width: 60,
                            height: 60,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getAchievementName(
                                      state.achievement.achievementsLevel + 1),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: ColorsManager.blackColor),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '"Every step forward is progress, \nno matter how small."',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                      color: ColorsManager.blackColor),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              } else if (state is AchievementError) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      )),
    );
  }
}
