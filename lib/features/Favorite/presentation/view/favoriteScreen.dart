import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/Favorite/presentation/view/favCard.dart';
import 'package:gymer/features/Home/presentation/views/homeScreen.dart';

import '../../../../core/components/BottomNavHandler.dart';
import '../../../../core/components/ImagePickerHelper.dart';
import '../../../MachineRecognition/presentation/view model/MachineCubit/machine_cubit.dart';
import '../../../MachineRecognition/presentation/views/targetMuscle.dart';
import '../viewModel/favoriteCubit/favorite_cubit.dart';
import 'emptyFav.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final int _currentIndex = 0; //-1 ??

  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().fetchFavorites();
  }

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
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
    builder: (context, state) {
      if (state is FavoriteLoading) {
        //return const Center(child: CircularProgressIndicator(color: ColorsManager.goldColorO1,));
      }
      if (state is FavoriteError) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: Colors.redAccent,
                  size: 60,
                ),
                const SizedBox(height: 16),

                Text(
                  "Oops! Something went wrong.",
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
                    context.read<FavoriteCubit>().fetchFavorites();
                  },
                  icon: const Icon(Icons.refresh_rounded, size: 22,color: Colors.white,),
                  label: const Text("Retry"),
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
          ),
        );
      }
      if (state is FavoriteLoaded && state.favoriteModel.favouriteMachines.isEmpty) {
        return EmptyFav();
      }
      if (state is FavoriteLoaded) {
        return ListView.builder(
          itemCount: state.favoriteModel.favouriteMachines.length,
          itemBuilder: (context, index) {
            final machine = state.favoriteModel.favouriteMachines[index];
            return FavCard(machine: machine);
          },
        );
      }
      return const SizedBox();
    },
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
}
