import 'package:flutter/material.dart';
import 'package:gymer/core/utils/colors.dart'; // Your goldColorO1

class GoldBoxContainer extends StatelessWidget {
  final Widget child;

  const GoldBoxContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          left: BorderSide(color: ColorsManager.goldColorO1, width: 1),
          right: BorderSide(color: ColorsManager.goldColorO1, width: 1),
          bottom: BorderSide(color: ColorsManager.goldColorO1, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.goldColorO1.withOpacity(0.4),
            offset: const Offset(0, 4), // shadow down only
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}