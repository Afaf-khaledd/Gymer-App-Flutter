import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/MachineRecognition/presentation/views/machineVideo.dart';

import '../../data/models/favMachineModel.dart';
import '../viewModel/favoriteCubit/favorite_cubit.dart';

class FavCard extends StatelessWidget {
  final FavoriteMachineModel machine;
  const FavCard({super.key, required this.machine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 11),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) => MachineVideo(machineName: machine.machineName, machineVideo: machine.machineVideos),
          ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                spreadRadius: 1,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.4),
                width: 1.6,
              ),
            ),
          ),
          child: ListTile(
            title: Text(machine.machineName,style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 17),),
            leading: Image.network(machine.machineImage),
            trailing: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: state is FavoriteLoading
                      ? Icon(
                    Icons.favorite_outline_rounded,
                    key: const ValueKey("loading"),
                    size: 42,
                    color: ColorsManager.goldColorO1.withOpacity(0.5),
                  )
                      : IconButton(
                    key: const ValueKey("normal"),
                    onPressed: () {
                      _showRemoveFavoriteDialog(context);
                    },
                    icon: const Icon(
                      Icons.favorite_rounded,
                      size: 30,
                      color: ColorsManager.goldColorO1,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showRemoveFavoriteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Remove Favorite"),
          content: const Text("Are you sure you want to remove this item from favorites?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text("Cancel",style: GoogleFonts.poppins(color: Colors.black87),),
            ),
            TextButton(
              onPressed: () {
                context.read<FavoriteCubit>().toggleFavorite(machine.machineName);
                Navigator.pop(dialogContext);
              },
              child: Text("Remove", style: GoogleFonts.poppins(fontWeight: FontWeight.w500,color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}