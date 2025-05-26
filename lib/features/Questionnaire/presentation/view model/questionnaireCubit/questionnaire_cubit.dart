import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymer/features/Questionnaire/data/repository/questionnaireRepo.dart';
import '../../../data/models/quesitionnaireModel.dart';

part 'questionnaire_state.dart';

class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  final QuestionnaireRepository repository;

  QuestionnaireCubit(this.repository) : super(QuestionnaireInitial());

  late QuestionnaireModel questionnaire;
  int currentStep = 0;

  void initializeQuestionnaire() {
    questionnaire = QuestionnaireModel(
      goalWeight: null,
      currentWeight: null,
      gender: null,
      height: null,
      age: null,
      activityLevel: null,
      maingoal: null,
      duration: null,
      workoutDays: [],
      injuries: [],
      fittnesslevel: null,
    );
    emit(QuestionnaireLoaded(questionnaire: questionnaire, currentStep: currentStep));
  }
  void toggleWorkoutDay(String day) {
    if (state is! QuestionnaireLoaded) return;

    List<String> updatedDays = List.from(questionnaire.workoutDays ?? []);

    if (updatedDays.contains(day)) {
      updatedDays.remove(day);
    } else {
      updatedDays.add(day);
    }

    questionnaire = questionnaire.copyWith(workoutDays: updatedDays);
    emit(QuestionnaireLoaded(questionnaire: questionnaire, currentStep: currentStep));
  }
  void toggleInjure(String injure) {
    if (state is! QuestionnaireLoaded) return;

    List<String> updatedInjuries = List.from(questionnaire.injuries ?? []);

    if (injure == "No injuries") {
      updatedInjuries = ["No injuries"];
    } else {
      if (updatedInjuries.contains(injure)) {
        updatedInjuries.remove(injure);
      } else {
        updatedInjuries.add(injure);
        updatedInjuries.remove("No injuries");
      }
    }

    questionnaire = questionnaire.copyWith(injuries: updatedInjuries);
    emit(QuestionnaireLoaded(questionnaire: questionnaire, currentStep: currentStep));
  }

  void updateAnswer(String key, dynamic value) {
    if (state is! QuestionnaireLoaded) return;

    print("Updating $key with value: $value");

    final updatedQuestionnaire = Function.apply(
      questionnaire.copyWith,
      [],
      {Symbol(key): value},
    ) as QuestionnaireModel;

    questionnaire = updatedQuestionnaire;
    emit(QuestionnaireLoaded(questionnaire: questionnaire, currentStep: currentStep));
  }


  void goToNextStep() {
    if (currentStep < 10) { // Adjust based on total steps
      currentStep++;
      emit(QuestionnaireLoaded(questionnaire: questionnaire, currentStep: currentStep));
    }
  }

  void skipStep() {
    questionnaire = QuestionnaireModel(
      goalWeight: questionnaire.goalWeight,
      currentWeight: questionnaire.currentWeight,
      gender: questionnaire.gender,
      height: questionnaire.height,
      age: questionnaire.age,
      activityLevel: questionnaire.activityLevel,
      maingoal: questionnaire.maingoal,
      duration: questionnaire.duration,
      workoutDays: questionnaire.workoutDays?.isEmpty ?? true ? [] : questionnaire.workoutDays,
      injuries: questionnaire.injuries?.isEmpty ?? true ? [] : questionnaire.injuries,
      fittnesslevel: questionnaire.fittnesslevel,
    );

    submitQuestionnaire();
  }

  Future<void> submitQuestionnaire() async {
    //emit(QuestionnaireLoading());

    print("Submitting questionnaire: ${questionnaire.toJson()}");

    try {
      bool success = await repository.submitQuestionnaire(questionnaire);
      if (success) {
        emit(QuestionnaireSubmitted());
      } else {
        emit(QuestionnaireError("Failed to submit questionnaire"));
      }
    } catch (e) {
      print("Submission Error: $e");
      emit(QuestionnaireError(e.toString()));
    }
  }
}