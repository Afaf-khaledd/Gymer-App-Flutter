import 'package:get_it/get_it.dart';
import 'package:gymer/core/helpers/apiService.dart';
import 'package:gymer/features/Chatbot/data/repository/chatRepo.dart';
import 'package:gymer/features/Chatbot/presentation/view%20model/chatCubit/chat_cubit.dart';
import '../../features/Authentication/data/repository/authRepo.dart';
import '../../features/Authentication/presentation/view model/AuthCubit/auth_cubit.dart';
import '../../features/Questionnaire/data/repository/questionnaireRepo.dart';
import '../../features/Questionnaire/presentation/view model/questionnaireCubit/questionnaire_cubit.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  final apiService = ApiService();
  //Auth
  getIt.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepository(apiService: apiService));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthenticationRepository>()));

  //Questionnaire
  getIt.registerLazySingleton<QuestionnaireRepository>(() => QuestionnaireRepository(apiService: apiService));
  getIt.registerFactory<QuestionnaireCubit>(() => QuestionnaireCubit(getIt<QuestionnaireRepository>()));

  //Chatbot
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepository(apiService: apiService));
  getIt.registerFactory<ChatCubit>(() => ChatCubit(getIt<ChatRepository>()));

}