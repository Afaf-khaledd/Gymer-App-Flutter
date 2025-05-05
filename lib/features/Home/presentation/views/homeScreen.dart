import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/Authentication/presentation/view%20model/AuthCubit/auth_cubit.dart';
import 'package:gymer/features/Favorite/presentation/view/favoriteScreen.dart';
import 'package:gymer/features/Home/presentation/viewModel/homeCubit/home_cubit.dart';
import 'package:gymer/features/Home/presentation/views/CustomListTile.dart';
import 'package:gymer/features/Home/presentation/views/workoutItem.dart';
import 'package:gymer/features/MachineRecognition/presentation/views/machineVideo.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/components/BottomNavHandler.dart';
import '../../../../core/components/ImagePickerHelper.dart';
import '../../../Boarding/presentation/views/OnBoardingPage.dart';
import '../../../Favorite/presentation/viewModel/favoriteCubit/favorite_cubit.dart';
import '../../../MachineRecognition/presentation/view model/MachineCubit/machine_cubit.dart';
import '../../../MachineRecognition/presentation/views/targetMuscle.dart';
import '../viewModel/homeCubit/home_state.dart';
import 'buildShimmerBox.dart';
import 'favErrorWidget.dart';
import 'favouriteMachineItem.dart';
import 'freeWorkoutWidget.dart';
import 'goldBorderContainer.dart';
import 'initialHomeWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getProfile();
    context.read<FavoriteCubit>().fetchFavorites();
    context.read<HomeCubit>().checkWorkoutPlan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavHandler(
        currentIndex: _currentIndex,
        onImagePicked: (_) =>
            ImagePickerHelper.pickImage(context, _handleImagePicked),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is ProfileRetrieved) {
                return AppBar(
                  backgroundColor: ColorsManager.BGColor, //Color.fromRGBO(255, 255, 255, 1.208),
                  elevation: 0,
                  toolbarHeight: 100,
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: state.user.profileUrl!.isNotEmpty
                            ? NetworkImage(state.user.profileUrl!)
                            : AssetImage(AssetsManager.defaultProfileImage)
                                as ImageProvider,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Welcome,',
                              style: GoogleFonts.leagueSpartan(
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                                height: 0.92,
                                color: ColorsManager.blackColor,
                              ),
                            ),
                            Text(
                              "${state.user.fullName} !",
                              style: GoogleFonts.leagueSpartan(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                height: 0.92,
                                color: ColorsManager.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => showLogoutConfirmation(context),
                      icon: const Icon(Icons.logout_rounded, size: 30),
                    ),
                    const SizedBox(width: 10),
                  ],
                );
              } else if (state is AuthInitial) {
                return AppBar(
                  backgroundColor: Color.fromRGBO(255, 255, 255, 1.208),
                  elevation: 0,
                  toolbarHeight: 100,
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BuildShimmerBox(width: 100, height: 20),
                            const SizedBox(height: 8),
                            BuildShimmerBox(width: 150, height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 11),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 13,),
                CustomListTile(
                  text: "Today's Workout Plan",
                  imagePath: AssetsManager.workoutPlan,
                ),
            const SizedBox(height: 12),

            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return _buildShimmerEffect();
                }

                if (state is HomeError) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: 100,),
                        Text(
                          "Failed to load workout plan.",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),

                        Text(
                          state.message,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<HomeCubit>().fetchWorkoutPlan();
                          },
                          icon: const Icon(Icons.refresh_rounded, size: 22, color: Colors.white),
                          label: Text("Retry",style: GoogleFonts.poppins(
                            color: Colors.white,),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: ColorsManager.goldColorO1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // workout plan generated normal
                if (state is HomeLoaded && state.workout.isNotEmpty) {
                  return Column(
                    children: [
                      GoldBorderContainer(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 100),
                              child: SizedBox(
                                height: 180,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: state.workout.entries
                                        .toList()
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      final index = entry.key;
                                      final workout = entry.value;
                                      return WorkoutItem(
                                        title: workout.key,
                                        description: workout.value,
                                        index: index,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              right: -30,
                              bottom: 0,
                              child: Image.asset(
                                AssetsManager.avatarGym,
                                width: 170,
                                height: 170,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      GoldBorderContainer(
                        padding: const EdgeInsets.all(19),
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
                                Row(
                                  children: [
                                    Text(
                                      " Ask ",
                                      style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        height: 1.2,
                                        color: Colors.black,
                                      ),
                                    ),
                                    ShaderMask(
                                      shaderCallback: (bounds) =>
                                          const LinearGradient(
                                        colors: [
                                          ColorsManager.goldColorO1,
                                          Color.fromRGBO(3, 19, 20, 1)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(bounds),
                                      child: Text(
                                        "GymTron",
                                        style: GoogleFonts.dmSans(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Image.asset(
                              AssetsManager.chatbotIcon,
                              width: 50,
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                // workout plan generated but today is free!
                else if (state is HomeEmpty) {
                  return FreeWorkoutWidget();
                }

                // workout plan not generated yet!!
                else if( state is HomeInitiall){
                  return InitialHomeWidget();
                }
                return const SizedBox();
              },
            ),
            SizedBox(
              height: 15,
            ),

            // fav
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomListTile(
                  text: "Favourite Machines",
                  icon: Icons.favorite,
                  trailing: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FavoriteScreen()),
                      );
                    },
                    style: TextButton.styleFrom(overlayColor: Colors.grey),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 3.0),
                      child: Text(
                        "View All >",
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          height: 1,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    if (state is FavoriteLoading) {
                      return SizedBox(
                        height: 135,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 15),
                          itemBuilder: (context, index) {
                            return BuildShimmerBox(width: 120, height: 135,borderRadius: BorderRadius.all(Radius.circular(12)),);
                          },
                        ),
                      );
                    }
                    if (state is FavoriteError) {
                      return FavErrorWidget(msg: state.message,);
                    }
                    if (state is FavoriteLoaded && state.favoriteModel.favouriteMachines.isNotEmpty) {
                      return SizedBox(
                        height: 135,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              state.favoriteModel.favouriteMachines.length >
                                      5
                                  ? 5
                                  : state.favoriteModel.favouriteMachines
                                      .length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 15),
                          itemBuilder: (context, index) {
                            final machine = state
                                .favoriteModel.favouriteMachines[index];
                            return FavouriteMachineItem(
                              title: machine.machineName,
                              imagePath: machine.machineImage,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MachineVideo(
                                        machineName: machine.machineName,
                                        machineVideo: machine
                                            .machineVideos), // navigate to video!
                                  ),
                                );
                              },
                              index: index,
                            );
                          },
                        ),
                      );
                    }
                    return GoldBorderContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Snap. Learn. Save\nOur Faves!",
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  height: 1.2,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                          Image.asset(
                            AssetsManager.cameraHomeImage,
                            height: 140,
                            width: 140,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ]),
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

  Widget _buildShimmerEffect() {
    return GoldBorderContainer(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: BuildShimmerBox(width: double.infinity, height: 20,)
              ),
              ),
            ),
          ),
          BuildShimmerBox(width: 120, height: 120,borderRadius: BorderRadius.all(Radius.circular(12)),)
        ],
      ),
    );
  }
}
