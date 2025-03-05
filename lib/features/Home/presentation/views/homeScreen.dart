import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/Authentication/presentation/view%20model/AuthCubit/auth_cubit.dart';
import 'package:gymer/features/Favorite/presentation/view/favoriteScreen.dart';
import 'package:gymer/features/Home/presentation/viewModel/homeCubit/home_cubit.dart';
import 'package:gymer/features/Home/presentation/viewModel/homeCubit/home_state.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../../core/components/BottomNavHandler.dart';
import '../../../../core/components/ImagePickerHelper.dart';
import '../../../Boarding/presentation/views/OnBoardingPage.dart';
import '../../../MachineRecognition/presentation/view model/MachineCubit/machine_cubit.dart';
import '../../../MachineRecognition/presentation/views/targetMuscle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoaded) {
                return AppBar(
                    backgroundColor: ColorsManager.BGColor,
                    elevation: 0,
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: state.user.profileUrl != null
                              ? NetworkImage(state.user.profileUrl!)
                              : AssetImage(AssetsManager.defaultProfileImage)
                                  as ImageProvider,
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Welcome,',
                                  style: GoogleFonts.leagueSpartan(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25,
                                      height: 0.92,
                                      color: ColorsManager.blackColor)),
                              Text(state.user.userName,
                                  style: GoogleFonts.leagueSpartan(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25,
                                      height: 0.92,
                                      color: ColorsManager.blackColor)),
                            ],
                          ),
                        )
                      ],
                    ));
              } else if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: Text("Failed to load user data"));
              }
            },
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AssetsManager.workoutPlan,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Today's Workout Plan",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          height: 1.5,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 140,
                          child: SingleChildScrollView(
                            child: Column(
                              children:
                                  List.generate(3, (index) => workoutItem()),
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                        AssetsManager.avatarGym,
                        width: 90,
                        height: 90,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "If you need any help,",
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          height: 1.2,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Ask GymTron",
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          height: 1.2,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    AssetsManager.chatbotIcon,
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          "Favourite Machines",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              height: 1.5,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoriteScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "view all >",
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            height: 1,
                            color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      favouriteMachineItem(
                        "Bench Press",
                        AssetsManager.benchPress,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Placeholder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      favouriteMachineItem(
                        "Chest Press",
                        AssetsManager.chestPress,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Placeholder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavHandler(
        currentIndex: _currentIndex,
        onImagePicked: (_) =>
            ImagePickerHelper.pickImage(context, _handleImagePicked),
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

  void showLogoutConfirmation(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: "Are you sure?",
      barrierDismissible: false,
      text: "Do you want to logout",
      confirmBtnText: "Logout",
      confirmBtnTextStyle: GoogleFonts.dmSans(
          fontWeight: FontWeight.w700, color: Colors.white, fontSize: 16),
      cancelBtnText: "Cancel",
      cancelBtnTextStyle: GoogleFonts.dmSans(
          fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black54),
      confirmBtnColor: ColorsManager.goldColorO1,
      onConfirmBtnTap: () {
        context.read<AuthCubit>().logout();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const OnBoardingPage()),
          (route) => false,
        );
      },
    );
  }

  Widget favouriteMachineItem(
      String title, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[500],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  height: 1.5,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    );
    // return Container(
    //   width: 160,
    //   padding: const EdgeInsets.all(12),
    //   decoration: BoxDecoration(
    //     color: Colors.grey[500],
    //     borderRadius: BorderRadius.circular(16),
    //   ),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         title,
    //         style: GoogleFonts.poppins(
    //             fontWeight: FontWeight.w700,
    //             fontSize: 17,
    //             color: Colors.white,
    //             height: 1.5),
    //       ),
    //       const SizedBox(height: 8),
    //       Expanded(
    //         child: Image.asset(
    //           imagePath,
    //           fit: BoxFit.contain,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget workoutItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Chest Press",
                style: GoogleFonts.leagueSpartan(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    height: 0.92,
                    color: Colors.black),
              ),
              Text(
                "3 Sets Of 8-12 Reps\n30-60 Seconds Rest",
                style: GoogleFonts.leagueSpartan(
                    fontWeight: FontWeight.w300,
                    fontSize: 17,
                    height: 0.92,
                    color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
