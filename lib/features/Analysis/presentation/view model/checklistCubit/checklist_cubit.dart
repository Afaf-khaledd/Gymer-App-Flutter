import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymer/core/helpers/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../progressCubit/progress_cubit.dart';

part 'checklist_state.dart';

class ChecklistCubit extends Cubit<ChecklistState> {
  ChecklistCubit() : super(ChecklistInitial());
  late SharedPreferences prefs;
  late String todayKey;

  Future<void> loadItems(List<String> workoutKeys, BuildContext context) async {
    final progressCubit = context.read<ProgressCubit>();
    prefs = await SharedPreferences.getInstance();
    todayKey = _generateTodayKey();

    final storedChecklist = prefs.getStringList(todayKey);

    Map<String, bool> items = {};

    if (storedChecklist != null) {
      for (var item in workoutKeys) {
        items[item] = storedChecklist.contains(item);
      }
      final completedCount = items.values.where((v) => v).length;
      progressCubit.getProgress(count: completedCount);

    } else {
      for (var item in workoutKeys) {
        items[item] = false;
      }
    }
    LocalStorage.printAllSharedPrefs();
    emit(ChecklistLoaded(items));
  }

  Future<void> toggleItem(String title, BuildContext context) async {
    if (state is! ChecklistLoaded) return;

    final current = Map<String, bool>.from((state as ChecklistLoaded).items);
    current[title] = !(current[title] ?? false);

    emit(ChecklistLoaded(current));

    // Save to SharedPreferences
    final completed = current.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    final progressCubit = context.read<ProgressCubit>();
    progressCubit.getProgress(count: completed.length);

    await prefs.setStringList(todayKey, completed);
  }

  String _generateTodayKey() {
    final now = DateTime.now();
    return 'checklist_${now.year}_${now.month}_${now.day}';
  }
}