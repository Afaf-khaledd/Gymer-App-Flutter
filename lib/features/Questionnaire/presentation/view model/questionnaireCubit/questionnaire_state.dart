abstract class QuestionnaireState {}

class QuestionnaireInitial extends QuestionnaireState {}

class QuestionnaireLoading extends QuestionnaireState {}

class QuestionnaireSuccess extends QuestionnaireState {}

class QuestionnaireFailure extends QuestionnaireState {
  final String error;

  QuestionnaireFailure(this.error);
}