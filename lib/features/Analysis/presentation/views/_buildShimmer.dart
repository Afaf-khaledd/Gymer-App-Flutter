import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmer() {
  return ListView.builder(
    itemCount: 3,
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    },
  );
}