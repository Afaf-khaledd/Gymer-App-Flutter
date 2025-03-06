import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/colors.dart';
import '../../../Favorite/presentation/viewModel/favoriteCubit/favorite_cubit.dart';

class FavErrorWidget extends StatelessWidget {
  final String msg;
  const FavErrorWidget({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            msg,
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
}
