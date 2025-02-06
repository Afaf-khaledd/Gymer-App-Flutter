import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';

class CustomSliderActivity extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final String minLabel;
  final String maxLabel;
  final int divisions;
  final ValueChanged<double> onChanged;

  const CustomSliderActivity({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
    required this.minLabel,
    required this.maxLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 15,
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 10,
              elevation: 4,
            ),
            thumbColor: Colors.white,
            overlayColor: ColorsManager.goldColorO1.withOpacity(0.3),
            activeTrackColor: ColorsManager.goldColorO60,//Colors.grey[300],
            inactiveTrackColor: Colors.grey[300],
            trackShape: const RoundedRectSliderTrackShape(),
            tickMarkShape: null,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                minLabel,
                style: GoogleFonts.leagueSpartan(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey[700]),
              ),
              Text(
                maxLabel,
                style: GoogleFonts.leagueSpartan(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
