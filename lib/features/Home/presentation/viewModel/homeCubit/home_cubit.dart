import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymer/features/Authentication/data/models/userModel.dart';
import 'package:gymer/features/Favorite/data/models/favoriteModel.dart';
import 'package:gymer/features/Home/data/repository/homeRepo.dart';
import 'package:gymer/features/Home/presentation/viewModel/homeCubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit(this.homeRepository) : super(HomeInitial());

  void fetchData() async {
    try {
      emit(HomeLoading());
      final UserModel user = await homeRepository.getProfile();
      log(user.token);
      final FavoriteModel favourites = await homeRepository.getFavorite();
      emit(HomeLoaded(user: user, favourites: [favourites]));
        } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
