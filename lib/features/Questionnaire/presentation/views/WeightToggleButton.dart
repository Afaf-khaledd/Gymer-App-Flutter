import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';

class WeightToggleButton extends StatefulWidget {
  final Function(bool) onToggle;
  final bool isMetric;

  const WeightToggleButton({super.key, required this.onToggle, required this.isMetric});

  @override
  State<WeightToggleButton> createState() => _WeightToggleButtonState();
}

class _WeightToggleButtonState extends State<WeightToggleButton> {
  bool get _isMetric => widget.isMetric;

  void _toggleUnit(bool isMetric) {
    widget.onToggle(isMetric);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildToggleButton("KG", true),
          _buildToggleButton("LB", false),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isMetric) {
    bool isSelected = (_isMetric == isMetric);
    return Expanded(
      child: GestureDetector(
        onTap: () => _toggleUnit(isMetric),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? ColorsManager.goldColorO1 : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
