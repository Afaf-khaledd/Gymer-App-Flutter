import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/favoriteModel.dart';
import '../../../data/repository/favoriteRepo.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteCubit(this.favoriteRepository) : super(FavoriteInitial());

  Future<void> fetchFavorites() async {
    emit(FavoriteLoading());
    try {
      final favorites = await favoriteRepository.getFavorite();
      emit(FavoriteLoaded(favorites));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> checkIfFavorite(String machineName) async {
    try {
      final isFav = await favoriteRepository.isFavorite(machineName);
      log("Is Favorite: $isFav");
      emit(FavoriteStatusChecked(isFav));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> addFavorite(String machineName) async {
    emit(FavoriteLoading());
    try {
      await favoriteRepository.addToFavorite(machineName);
      emit(FavoriteItemAdded());
      await checkIfFavorite(machineName); //+fetch again
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> removeFavorite(String machineName) async {
    emit(FavoriteLoading());
    try {
      await favoriteRepository.removeFromFavorite(machineName);
      emit(FavoriteItemRemoved());
      await checkIfFavorite(machineName); //+fetch again
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }
}
