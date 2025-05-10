import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/components/customGoldButton.dart';
import '../../../../core/utils/assets.dart';
import '../../../Chatbot/presentation/views/initChatbotScreen.dart';
import 'barChartWidget.dart';

class EmptyStateScreen extends StatelessWidget {
  const EmptyStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 70,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                AssetsManager.chatbotIcon,
                width: 80,
                height: 80,
              ),
              CustomGoldButton(
                label: 'Go',
                fontSize: 18,
                onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute<void>(
                builder: (BuildContext context) => const InitChatbotScreen(),));},
                width: 100,)
            ],
          ),
          SizedBox(height: 30,),
          Text(" Ask GymTron\ncreate your workout plan",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20,),textAlign: TextAlign.center,),
          SizedBox(height: 70,),
          Expanded(
            child: BarChartWidget(isEmpty: true,)
          ),
        ],
      ),
    );
  }
}
