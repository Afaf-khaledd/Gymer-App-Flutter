import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/favMachineModel.dart';
import '../../../data/models/favoriteModel.dart';
import '../../../data/repository/favoriteRepo.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository favoriteRepository;

  List<FavoriteMachineModel> _favorites = [];

  FavoriteCubit(this.favoriteRepository) : super(FavoriteInitial());

  Future<void> fetchFavorites() async {
    emit(FavoriteLoading());
    try {
      final favorites = await favoriteRepository.getFavorite();
      emit(FavoriteLoaded(favorites));
      _favorites = favorites.favouriteMachines;
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> checkIfFavorite(String machineName) async {
    bool isFav = _favorites.any((machine) => machine.machineName == machineName);
    emit(FavoriteStatusChecked(isFav));
  }

  Future<void> toggleFavorite(String machineName) async {
    try {
      final isFav = _favorites.any((machine) => machine.machineName == machineName);

      if (isFav) {
        await favoriteRepository.removeFromFavorite(machineName);
        _favorites.removeWhere((machine) => machine.machineName == machineName);
        log("Removed from favorites: $machineName");
      } else {
        await favoriteRepository.addToFavorite(machineName);
        log("Added to favorites: $machineName");

        final updatedFavorites = await favoriteRepository.getFavorite();
        _favorites = updatedFavorites.favouriteMachines;
      }

      emit(FavoriteStatusChecked(!isFav));
      emit(FavoriteLoaded(FavoriteModel(favouriteMachines: List.from(_favorites))));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }
}
/*Future<void> addFavorite(String machineName) async {
    emit(FavoriteLoading());
    try {
      await favoriteRepository.addToFavorite(machineName);
      emit(FavoriteItemAdded());
      await checkIfFavorite(machineName);
      await fetchFavorites();
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> removeFavorite(String machineName) async {
    emit(FavoriteLoading());
    try {
      await favoriteRepository.removeFromFavorite(machineName);
      emit(FavoriteItemRemoved());
      await checkIfFavorite(machineName);
      await fetchFavorites();
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }*/
