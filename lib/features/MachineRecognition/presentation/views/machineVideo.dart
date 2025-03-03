
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
                    builder: (context, state) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(scale: animation, child: child);
                        },
                        child: state is FavoriteLoading
                            ? Icon(
                          Icons.favorite_rounded,
                          key: const ValueKey("loading"),
                          size: 43,
                          color: ColorsManager.goldColorO1,
                        )
                            : IconButton(
                          key: const ValueKey("normal"),
                          onPressed: () {
                            if (state is FavoriteStatusChecked && state.isFavorite) {
                              context.read<FavoriteCubit>().removeFavorite(widget.machineName);
                            } else {
                              context.read<FavoriteCubit>().addFavorite(widget.machineName);
                            }
                          },
                          icon: Icon(
                            (state is FavoriteStatusChecked && state.isFavorite)
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
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
