part of 'favorite_cubit.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final FavoriteModel favoriteModel;

  const FavoriteLoaded(this.favoriteModel);

  @override
  List<Object?> get props => [favoriteModel];
}

class FavoriteError extends FavoriteState {
  final String message;

  const FavoriteError(this.message);

  @override
  List<Object?> get props => [message];
}

class FavoriteItemAdded extends FavoriteState {}

class FavoriteItemRemoved extends FavoriteState {}

class FavoriteStatusChecked extends FavoriteState {
  final bool isFavorite;

  const FavoriteStatusChecked(this.isFavorite);

  @override
  List<Object?> get props => [isFavorite];
}