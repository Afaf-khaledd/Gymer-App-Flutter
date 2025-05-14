import 'package:flutter/material.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  final String hintText;
  final T? value;
  final List<T> items;
  final String? Function(T?)? validator;
  final void Function(T?) onChanged;

  const CustomDropdownFormField({
    super.key,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items
          .map((item) => DropdownMenuItem<T>(
        value: item,
        child: Text(item.toString()),
      ))
          .toList(),
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Color.fromRGBO(5, 0, 0, 0.09),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      dropdownColor: Colors.white,
    );
  }
}
