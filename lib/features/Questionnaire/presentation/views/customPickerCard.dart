import 'package:flutter/material.dart';

class CustomPickerCard extends StatelessWidget {
  final String title;
  final double height;
  final double? width;
  final Widget child;

  const CustomPickerCard({super.key, required this.title, required this.height, this.width, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          child
        ],
      ),
    );
  }
}
