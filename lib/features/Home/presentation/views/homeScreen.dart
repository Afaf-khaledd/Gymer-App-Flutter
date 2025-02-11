import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymer/features/Authentication/presentation/view%20model/AuthCubit/auth_cubit.dart';
import 'package:gymer/features/Boarding/presentation/views/OnBoardingPage.dart';

import '../../../../core/components/customBlackButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomBlackButton(
          label: 'Logout',
          onPressed: () {
            context.read<AuthCubit>().logout();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const OnBoardingPage()),
                  (route) => false,
            );
          },
        ),
      ),
    );
  }
}
