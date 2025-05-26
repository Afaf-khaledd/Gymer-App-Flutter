import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../view model/progressCubit/progress_cubit.dart';

Widget buildError(BuildContext context, String message) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, color: Colors.red, size: 60),
        const SizedBox(height: 12),
        Text(
          "Oops! Something went wrong.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[700]),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            context.read<ProgressCubit>().getProgress(count: 0);
          },
          icon: Icon(Icons.refresh, color: Colors.white),
          label: Text("Retry",style: TextStyle(color: Colors.white),),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: ColorsManager.goldColorO1,
          ),
        )
      ],
    ),
  );
}
