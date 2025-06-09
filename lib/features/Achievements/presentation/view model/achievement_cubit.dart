import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/achievement_repository.dart';
import 'achievement_state.dart';

class AchievementCubit extends Cubit<AchievementState> {
  final AchievementRepository repository;

  AchievementCubit(this.repository) : super(AchievementInitial());

  Future<void> getAchievements() async {
    try {
      emit(AchievementLoading());
      final achievement = await repository.fetchAchievements();
      emit(AchievementLoaded(achievement));
    } catch (e) {
      emit(AchievementError(e.toString()));
    }
  }
}
