
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymer/features/Home/data/repository/homeRepo.dart';
import 'package:gymer/features/Home/presentation/viewModel/homeCubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit(this.homeRepository) : super(HomeInitial());

  void fetchWorkoutPlan() async {
    try {
      emit(HomeLoading());

      final workout = await homeRepository.getWorkoutPlan();

      if (workout.isEmpty) {
        emit(HomeEmpty());
      } else {
        emit(HomeLoaded(workout: workout));
      }
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
  void checkWorkoutPlan() async {
    try {
      final workoutExist = await homeRepository.checkWorkoutPlan();
      if (workoutExist) {
      fetchWorkoutPlan();
      } else {
        emit(HomeInitiall());
      }
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
