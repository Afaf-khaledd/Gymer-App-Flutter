import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:gymer/features/Analysis/presentation/views/goldBoxContainer.dart';

class ChecklistWidget extends StatefulWidget {
  const ChecklistWidget({super.key});

  @override
  State<ChecklistWidget> createState() => _ChecklistWidgetState();
}

class _ChecklistWidgetState extends State<ChecklistWidget> {
  final List<Map<String, dynamic>> checklistItems = [
    {'title': 'Chest Press', 'isChecked': true},
    {'title': 'Chest Fly', 'isChecked': false},
    {'title': 'Chest Fly', 'isChecked': false},
    {'title': 'Push Up', 'isChecked': true},
    {'title': 'Bench Press', 'isChecked': false},
  ];

  @override
  Widget build(BuildContext context) {
    return GoldBoxContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: checklistItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> item = entry.value;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        checklistItems[index]['isChecked'] = !checklistItems[index]['isChecked'];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: [
                          Icon(
                            item['isChecked']
                                ? Icons.check_circle_rounded
                                : Icons.radio_button_unchecked_rounded,
                            color: item['isChecked'] ? Colors.lightGreen : Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item['title'],
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Image.asset(
            AssetsManager.listIcon,
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}