import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/components/customGoldButton.dart';
import '../../../../core/utils/assets.dart';
import '../../../Chatbot/presentation/views/initChatbotScreen.dart';
import 'emptyBarChartWidget.dart';

class EmptyStateScreen extends StatelessWidget {
  const EmptyStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                "Ask GymTron\ncreate your workout plan",
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Image.asset(
                    AssetsManager.chatbotIcon,
                    width: 100,
                    height: 100,
                  ),
                  const Spacer(),
                  CustomGoldButton(
                    label: 'Start Chat',
                    fontSize: 18,
                    width: 140,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                          const InitChatbotScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                "Progress Overview:",
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 230,
                child: EmptyBarChartWidget(),
              ),
              SizedBox(height: 5,),
              Text(
                "No activity yet.\n\nLet’s get started and fill this with your progress!",
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
