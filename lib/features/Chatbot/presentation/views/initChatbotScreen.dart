import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:gymer/core/utils/colors.dart';

import '../../../../core/components/CustomBottomNavBar.dart';
import '../../../Authentication/presentation/views/editProfileScreen.dart';
import '../../../Home/presentation/views/homeScreen.dart';
import '../../data/models/chatSessionModel.dart';
import '../view model/chatCubit/chat_cubit.dart';
import 'chatScreen.dart';
import 'customGoldButton.dart';
import 'customGreyCard.dart';

class InitChatbotScreen extends StatefulWidget {
  const InitChatbotScreen({super.key});

  @override
  State<InitChatbotScreen> createState() => _InitChatbotScreenState();
}

class _InitChatbotScreenState extends State<InitChatbotScreen> {
  int _currentIndex = 1;
  late bool isFirst;

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().loadLastSessions();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ChatCubit>().loadLastSessions();
  }

  void _onItemTapped(int index) {
    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const HomeScreen();
        break;
      case 1:
        nextScreen = InitChatbotScreen();
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen));
  }

  void _createNewSession() {
    context.read<ChatCubit>().createChatSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatCubit, ChatState>(
        listenWhen: (previous, current) =>
        current is ChatCreateSuccess || current is ChatCreateLoading || current is ChatFailure,
        listener: (context, state) {
          if (state is ChatCreateLoading) {
            Fluttertoast.showToast(
              msg: "Creating Chat...",
              fontSize: 17,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              backgroundColor: ColorsManager.goldColorO1,
              textColor: Colors.white,
            );
          }
          else if (state is ChatCreateSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(sessionId: state.newSession.sessionId),
              ),
            );
          }
          else if (state is ChatFailure) {
            Fluttertoast.showToast(
              msg: "Error: ${state.error}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
            );
          }
        },
        builder: (context, state) {
          bool isFirst = state is NoChatSessions;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 130),
                    Image.asset(
                      AssetsManager.chatbotIcon,
                      height: 180,
                      width: 180,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(height: 10),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [ColorsManager.goldColorO1, Color.fromRGBO(3, 19, 20, 1)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        "GymTron",
                        style: GoogleFonts.dmSans(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    if (isFirst) ...[
                      Text(
                        'AI-Powered Chatbot For Smarter\nWorkouts And A Better Gym\nLifestyle!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: const Color.fromRGBO(102, 102, 102, 0.78),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomGoldButton(
                        text: 'Start Using GymTron',
                        onTap: _createNewSession,
                      ),
                    ]

                    else if (state is ChatSessionsLoaded) ...[
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const SizedBox(width: 15),
                          Text(
                            "Recent History",
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 19, fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 10),

                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              ListView.builder(
                                itemCount: state.sessions.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  ChatSessionModel session = state.sessions[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatScreen(sessionId: session.sessionId),
                                          ),
                                        );
                                      },
                                      child: CustomGreyCard(text: 'Chat ${index + 1}'),
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 20),
                              CustomGoldButton(
                                text: 'Create New Chat',
                                onTap: _createNewSession,
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ]

                    else if (state is ChatFailure) ...[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, color: Colors.redAccent, size: 50),
                              const SizedBox(height: 10),
                              Text(
                                "Something went wrong!",
                                style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                state.error,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.dmSans(fontSize: 14, color: Colors.grey),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () => context.read<ChatCubit>().loadLastSessions(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorsManager.goldColorO1,
                                ),
                                child: const Text("Retry"),
                              ),
                            ],
                          ),
                        ),
                      ]

                      // Show loading if fetching chat sessions
                      else if (state is ChatLoading) ...[
                          const CircularProgressIndicator(color: ColorsManager.goldColorO1),
                        ]
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}