part of 'checklist_cubit.dart';

abstract class ChecklistState extends Equatable {
  const ChecklistState();

  @override
  List<Object?> get props => [];
}

class ChecklistInitial extends ChecklistState {}

class ChecklistLoaded extends ChecklistState {
  final Map<String, bool> items;

  const ChecklistLoaded(this.items);

  @override
  List<Object?> get props => [items];
}
