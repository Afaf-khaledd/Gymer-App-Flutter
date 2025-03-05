

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/colors.dart';
import '../../../Favorite/presentation/viewModel/favoriteCubit/favorite_cubit.dart';

class MachineVideo extends StatefulWidget {
  final String machineName;
  final List<String> machineVideo;

  const MachineVideo({super.key, required this.machineName, required this.machineVideo});

  @override
  State<MachineVideo> createState() => _MachineVideoState();
}

class _MachineVideoState extends State<MachineVideo> {

  @override
  void initState() {
    super.initState();
    log(widget.machineName);
    context.read<FavoriteCubit>().checkIfFavorite(widget.machineName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 90,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<FavoriteCubit>().fetchFavorites();
              },
              icon: const Icon(Icons.arrow_back_ios_rounded)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  widget.machineName,
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700, fontSize: 40),
                ),
              ),
            ),
            const SizedBox(height: 40),
            for (var videoUrl in widget.machineVideo)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorsManager.goldColorO1, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(videoUrl, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Spacer(),
                  BlocBuilder<FavoriteCubit, FavoriteState>(
                    buildWhen: (previous, current) => current is FavoriteStatusChecked,
                    builder: (context, favState) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(scale: animation, child: child),
                          );
                        },
                        child: (favState is FavoriteStatusChecked && favState.isFavorite)
                            ? IconButton(
                          key: const ValueKey("filled_heart"),
                          onPressed: () {
                            context.read<FavoriteCubit>().toggleFavorite(widget.machineName);
                          },
                          icon: const Icon(
                            Icons.favorite_rounded,
                            size: 40,
                            color: ColorsManager.goldColorO1,
                          ),
                        )
                            : IconButton(
                          key: const ValueKey("border_heart"),
                          onPressed: () {
                            context.read<FavoriteCubit>().toggleFavorite(widget.machineName);
                          },
                          icon: const Icon(
                            Icons.favorite_border_rounded,
                            size: 40,
                            color: ColorsManager.goldColorO1,
                          ),
                        ),
                      )
                          : IconButton(
                        key: const ValueKey("border_heart"),
                        onPressed: () {
                          context.read<FavoriteCubit>().toggleFavorite(widget.machineName);
                        },
                        icon: const Icon(
                          Icons.favorite_border_rounded,
                          size: 40,
                          color: ColorsManager.goldColorO1,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}