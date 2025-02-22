import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:gymer/core/utils/colors.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final List<TabItem> items = [
    TabItem(icon: Icons.home_outlined),
    TabItem(icon: Icons.message_outlined),
    TabItem(icon: Icons.camera_alt_outlined, title: ""),
    TabItem(icon: Icons.analytics_outlined),
    TabItem(icon: Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0,horizontal: 16),
      child: BottomBarCreative(
        items: items,
        backgroundColor: Colors.white,
        color: Colors.black,
        iconSize: 24,
        colorSelected: ColorsManager.goldColorO1,
        indexSelected: widget.currentIndex,
        onTap: widget.onTap,
        enableShadow: true,
        highlightStyle: const HighlightStyle(
          sizeLarge: true,
          isHexagon: true,
          color: Colors.white,
          background: ColorsManager.goldColorO1,
        ),
        paddingVertical: 50,
        bottom: 1,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 1.7),
          ),
        ],
        borderRadius: BorderRadius.circular(50),

      ),
    );
  }
}
