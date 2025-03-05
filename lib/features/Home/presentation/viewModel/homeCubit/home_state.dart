import 'package:equatable/equatable.dart';
import 'package:gymer/features/Authentication/data/models/userModel.dart';
import 'package:gymer/features/Favorite/data/models/favoriteModel.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final UserModel user;
  final List<FavoriteModel> favourites;

  const HomeLoaded({required this.user, required this.favourites});

  @override
  List<Object?> get props => [user, favourites];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
