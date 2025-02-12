import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymer/features/Authentication/presentation/view%20model/AuthCubit/auth_cubit.dart';
import 'package:gymer/features/Authentication/presentation/views/editProfileScreen.dart';
import 'package:gymer/features/Boarding/presentation/views/OnBoardingPage.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const EditProfileScreen(),
                ),
              );
            },
            icon: Icon(Icons.person_rounded,size: 35,)
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthCubit>().logout();
                Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const OnBoardingPage()),
                (route) => false,);
              },
              icon: Icon(Icons.logout_rounded,size: 30,)
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: Center(),
    );
  }
}
