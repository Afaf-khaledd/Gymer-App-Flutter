import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';

class GoldBorderContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const GoldBorderContainer({
    super.key,
    required this.child, this.padding=const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black45, width: 0.1),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.goldColorO1.withOpacity(0.24),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}