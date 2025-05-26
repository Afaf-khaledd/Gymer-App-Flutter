import 'dart:developer';

import 'package:gymer/features/Analysis/presentation/view%20model/progressCubit/progress_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/analysisRepo.dart';

class ProgressCubit extends Cubit<ProgressState> {
  final AnalysisRepository analysisRepository;

  ProgressCubit(this.analysisRepository) : super(ProgressInitial());

  Future<void> getProgress({required int count}) async {
    try {
      final activityModel = await analysisRepository.progressTracking(count: count);

      if (activityModel.month == "Month 0") {
        emit(ProgressEmpty(message: "Ask GymTron"));
      } else if (activityModel.monthFinished == true) {
        log("finished");
        emit(ProgressFinished(data: activityModel));
      } else {
        log("normal");
        emit(ProgressNormal(data: activityModel));
      }
    } catch (e) {
      emit(ProgressError(message: e.toString()));
    }
  }
}