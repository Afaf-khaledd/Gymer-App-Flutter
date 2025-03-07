import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/features/Favorite/presentation/viewModel/favoriteCubit/favorite_cubit.dart';
import 'package:gymer/features/MachineRecognition/presentation/view%20model/MachineCubit/machine_cubit.dart';
import '../../../../core/utils/colors.dart';
import 'machineVideo.dart';

class TargetMuscle extends StatefulWidget {
  const TargetMuscle({super.key});

  @override
  State<TargetMuscle> createState() => _TargetMuscleState();
}

class _TargetMuscleState extends State<TargetMuscle> {
  @override
  void initState() {
    super.initState();
    // Fetch favorites and then check if the current machine is a favorite
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoriteCubit>().fetchFavorites().then((_) {
        final machineState = context.read<MachineCubit>().state;
        if (machineState is SingleMachineSuccess) {
          context.read<FavoriteCubit>().checkIfFavorite(machineState.machineName);
        } else if (machineState is MultiMachineSuccess) {
          context.read<FavoriteCubit>().checkIfFavorite(machineState.machineName);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MachineCubit, MachineState>(
      listener: (context, state) {
        if (state is MachineFailure) {
          Fluttertoast.showToast(
            msg: "Error: ${state.error}",
            fontSize: 17,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 90,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<FavoriteCubit>().fetchFavorites();
              },
              icon: const Icon(Icons.arrow_back_ios_rounded),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state is MachinesLoading) ...[
                Expanded(
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.goldColorO1,
                      ),
                    ),
                  ),
                ),
              ]
              else if (state is MultiMachineSuccess) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 35),
                  child: Text(
                    state.machineName,
                    style: GoogleFonts.dmSans(fontSize: 40, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 11),
                    child: ListView.builder(
                      itemCount: state.machineForms.length,
                      itemBuilder: (context, index) {
                        final form = state.machineForms[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MachineVideo(
                                  machineName: form.machineForm,
                                  machineVideo: form.machineFormVideo,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.grey[200],
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: ColorsManager.goldColorO1, width: 0.5),
                            ),
                            shadowColor: Colors.black.withOpacity(0.2),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              title: Text(
                                form.machineForm,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios, color: ColorsManager.goldColorO1, size: 18),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ]
              else if (state is SingleMachineSuccess) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Text(
                    state.machineName,
                    style: GoogleFonts.dmSans(fontSize: 40, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...state.machineVideos.map((videoUrl) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorsManager.goldColorO1, width: 0.9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(videoUrl, fit: BoxFit.cover),
                            ),
                          ),
                        );
                      }).toList(),
                      BlocBuilder<FavoriteCubit, FavoriteState>(
                        buildWhen: (previous, current) => current is FavoriteStatusChecked,
                        builder: (context, favState) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: AnimatedSwitcher(
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
                                  context.read<FavoriteCubit>().toggleFavorite(state.machineName);
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
                                  context.read<FavoriteCubit>().toggleFavorite(state.machineName);
                                },
                                icon: const Icon(
                                  Icons.favorite_border_rounded,
                                  size: 40,
                                  color: ColorsManager.goldColorO1,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ]
              else ...[
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          size: 40,
                          color: Colors.orangeAccent,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "No machine data available",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ],
          ),
        );
      },
    );
  }
}