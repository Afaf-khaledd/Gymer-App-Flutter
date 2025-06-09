import '../../data/models/achievement_model.dart';

abstract class AchievementState {}

class AchievementInitial extends AchievementState {}

class AchievementLoading extends AchievementState {}

class AchievementLoaded extends AchievementState {
  final Achievement achievement;

  AchievementLoaded(this.achievement);
}

class AchievementError extends AchievementState {
  final String message;

  AchievementError(this.message);
}
