import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:gymer/features/Analysis/presentation/views/goldBoxContainer.dart';

import '../view model/checklistCubit/checklist_cubit.dart';

class ChecklistWidget extends StatefulWidget {
  const ChecklistWidget({super.key, required this.workoutKeys});
  final List<String> workoutKeys;

  @override
  State<ChecklistWidget> createState() => _ChecklistWidgetState();
}

class _ChecklistWidgetState extends State<ChecklistWidget> {

  @override
  void initState() {
    super.initState();
    context.read<ChecklistCubit>().loadItems(widget.workoutKeys, context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChecklistCubit, ChecklistState>(
      builder: (context, state) {
        if (state is ChecklistLoaded) {
          final checklistItems = state.items;

          return GoldBoxContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: checklistItems.entries.map((entry) {
                        final title = entry.key;
                        final isChecked = entry.value;

                        return GestureDetector(
                          onTap: () {
                            context.read<ChecklistCubit>().toggleItem(title, context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 14.0),
                            child: Row(
                              children: [
                                Icon(
                                  isChecked
                                      ? Icons.check_circle_rounded
                                      : Icons.radio_button_unchecked_rounded,
                                  color: isChecked ? Colors.lightGreen : Colors.grey,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  title,
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
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}