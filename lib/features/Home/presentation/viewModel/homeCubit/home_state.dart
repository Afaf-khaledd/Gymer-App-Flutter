import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeEmpty extends HomeState {}

class HomeLoaded extends HomeState {
  final Map<String,String> workout;

  const HomeLoaded({required this.workout});

  @override
  List<Object?> get props => [workout];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
