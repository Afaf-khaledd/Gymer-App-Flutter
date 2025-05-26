import 'package:equatable/equatable.dart';

import 'package:gymer/features/Analysis/data/models/activityModel.dart';

abstract class ProgressState extends Equatable {
  const ProgressState();

  @override
  List<Object?> get props => [];
}

class ProgressInitial extends ProgressState {}

class ProgressLoading extends ProgressState {}

class ProgressEmpty extends ProgressState { // no need to message
  final String message;

  const ProgressEmpty({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProgressFinished extends ProgressState {
  final ActivityModel data;

  const ProgressFinished({required this.data});

  @override
  List<Object?> get props => [data];
}

class ProgressNormal extends ProgressState {
  final ActivityModel data;

  const ProgressNormal({required this.data});

  @override
  List<Object?> get props => [data];
}

class ProgressError extends ProgressState {
  final String message;

  const ProgressError({required this.message});

  @override
  List<Object?> get props => [message];
}