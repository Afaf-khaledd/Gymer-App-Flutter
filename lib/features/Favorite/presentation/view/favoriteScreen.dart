import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/features/Favorite/presentation/view/favCard.dart';
import 'package:gymer/features/Home/presentation/views/homeScreen.dart';

import '../../../../core/components/BottomNavHandler.dart';
import '../../../../core/components/ImagePickerHelper.dart';
import '../../../MachineRecognition/presentation/view model/MachineCubit/machine_cubit.dart';
import '../../../MachineRecognition/presentation/views/targetMuscle.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final int _currentIndex = 0; //-1 ??
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.208),
        toolbarHeight: 100,
        leading: IconButton(
            onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute<void>(
            builder: (BuildContext context) => const HomeScreen(),),);},
            icon: Icon(Icons.arrow_back_ios_rounded)),
        title: Text('Favorites',style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 26),),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return FavCard(machineName: 'Machine Name', machineVideo: [],);
        },
      ),
      //EmptyFav(),
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
}
