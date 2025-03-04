import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/Authentication/presentation/view%20model/AuthCubit/auth_cubit.dart';
import 'package:gymer/features/Favorite/presentation/view/favoriteScreen.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 100,
          actions: [
            IconButton(
              onPressed: () => showLogoutConfirmation(context),
              icon: const Icon(Icons.logout_rounded, size: 30),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () => {
                Navigator.pushReplacement(context, MaterialPageRoute<void>(
    builder: (BuildContext context) => const FavoriteScreen(),),)},
              icon: const Icon(Icons.favorite_rounded, size: 30),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavHandler(
          currentIndex: _currentIndex,
          onImagePicked: (_) => ImagePickerHelper.pickImage(context, _handleImagePicked),
        ),
      );
  }
  void _handleImagePicked(String imageBase64) {
    context.read<MachineCubit>().sendMachineImage(imageBase64);
    Future.delayed(Duration(milliseconds: 300), () {
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
      confirmBtnTextStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w700,color: Colors.white,fontSize: 16),
      cancelBtnText: "Cancel",
      cancelBtnTextStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black54),
      confirmBtnColor: ColorsManager.goldColorO1, // change to?
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
}