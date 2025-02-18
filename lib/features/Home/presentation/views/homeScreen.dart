import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymer/core/components/CustomBottomNavBar.dart';
import 'package:gymer/features/Authentication/presentation/view%20model/AuthCubit/auth_cubit.dart';
import 'package:gymer/features/Authentication/presentation/views/editProfileScreen.dart';
import 'package:gymer/features/Boarding/presentation/views/OnBoardingPage.dart';
import 'package:gymer/features/Chatbot/presentation/views/initChatbotScreen.dart';


class HomeScreen extends StatefulWidget {
  // take userModel if null > get profile
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _currentIndex = 0;

  void _onItemTapped(int index) {
    if (index == 2) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Add Button Clicked"),
          content: Text("This can open a new screen."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        ),
      );
      return;
    }

    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const HomeScreen();
        break;
      case 1:
        nextScreen = const InitChatbotScreen();
        break;
      case 3:
        nextScreen = const Placeholder();
        break;
      case 4:
        nextScreen = const EditProfileScreen();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

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
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Add Button Clicked"),
                    content: Text("This can open a new screen."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.read<AuthCubit>().logout();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const OnBoardingPage()),
                                (route) => false,);
                        },
                        child: Text("Logout"),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthCubit>().logout();
                          Navigator.pop(context);
                        },
                        child: Text("cancel"),
                      ),
                    ],
                  ),
                );

              },
              icon: Icon(Icons.logout_rounded,size: 30,)
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: Center(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => _onItemTapped(index),
      ),
    );
  }
}
