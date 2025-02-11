part of 'questionnaire_cubit.dart';
abstract class QuestionnaireState extends Equatable {
  const QuestionnaireState();

  @override
  List<Object?> get props => [];
}

class QuestionnaireInitial extends QuestionnaireState {}

class QuestionnaireLoading extends QuestionnaireState {}

class QuestionnaireLoaded extends QuestionnaireState {
  final QuestionnaireModel questionnaire;
  final int currentStep;

  const QuestionnaireLoaded({required this.questionnaire, required this.currentStep});

  @override
  List<Object?> get props => [questionnaire, currentStep];
}

class QuestionnaireError extends QuestionnaireState {
  final String message;

  const QuestionnaireError(this.message);

  @override
  List<Object?> get props => [message];
}

class QuestionnaireSubmitted extends QuestionnaireState {}
