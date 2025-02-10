import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/Splash/presentation/views/SplashScreen.dart';

import 'core/helpers/seviceLocator.dart';
import 'features/Authentication/presentation/view model/AuthCubit/auth_cubit.dart';


void main() {
  setupServiceLocator();
  runApp(const MyApp());
  configLoading(); // Configure loading UI
}
void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black87
    ..indicatorColor = Colors.white
    ..textColor = Colors.white;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => getIt<AuthCubit>(),
        ),
      /*  BlocProvider<QuestionnaireCubit>(
          create: (_) => getIt<QuestionnaireCubit>(),
        ),*/
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: ColorsManager.BGColor,
            focusColor: ColorsManager.blackColor,
            primaryColor: ColorsManager.blackColor
        ),
        home: const SplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}