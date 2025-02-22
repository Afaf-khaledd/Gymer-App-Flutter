import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final Color fillColor;
  final Color borderColor;
  final Color textColor;
  final Color hintTextColor;
  final double borderRadius;
  final double borderWidth;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    this.obscureText = false,
    this.fillColor = const Color.fromRGBO(5, 0, 0, 0.09),
    this.borderColor = Colors.white,
    this.textColor = const Color.fromRGBO(35, 35, 35, 1),
    this.hintTextColor = Colors.black87,
    this.borderRadius = 15.0,
    this.borderWidth = 1.0, required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // prefix, suffix for password?
      validator: validator,
      controller: controller,
      cursorColor: textColor,
      obscureText: obscureText,
      obscuringCharacter: '*',
      keyboardType: keyboardType,
      decoration: InputDecoration(
        errorStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          fontSize: 12,
          color: Colors.red,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: hintTextColor),
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: borderWidth),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: borderWidth),
        ),
      ),
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: textColor,
      ),
    );
  }
}