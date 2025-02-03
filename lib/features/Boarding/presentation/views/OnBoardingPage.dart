import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/components/customBlackButton.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:gymer/core/utils/colors.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final List<OnboardingContent> content = [
    OnboardingContent(
      image: AssetsManager.varName,
      title: 'Scan And Identify Any Gym Equipment Effortlessly',
    ),
    OnboardingContent(
      image: AssetsManager.botImage,
      title: 'Your AI Fitness Coach, Anytime!',
    ),
    OnboardingContent(
        image: AssetsManager.clockImage,
        title: 'See Your Gains, Stay On Track!')
  ];
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.BGColor,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: content.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      content[index].image,
                      fit: BoxFit.contain,
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        content[index].title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            height: 1.5,
                            color: ColorsManager.blackColor),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              content.length,
              (index) => buildPageIndicator(index == _currentIndex),
            ),
          ),
          SizedBox(height: 20),
          CustomBlackButton(
              label: 'Get Started',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const Placeholder()));
              }),
        ],
      ),
    );
  }
}

Widget buildPageIndicator(bool isActive) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4),
    width: isActive ? 12 : 8,
    height: 8,
    decoration: BoxDecoration(
        color: isActive ? Colors.white : ColorsManager.blackColor,
        borderRadius: BorderRadius.circular(4)),
  );
}

class OnboardingContent {
  final String image;
  final String title;

  OnboardingContent({
    required this.image,
    required this.title,
  });
}
