import 'package:get_it/get_it.dart';
import 'package:gymer/core/helpers/apiService.dart';
import 'package:gymer/features/Achievements/data/repository/achievement_repository.dart';
import 'package:gymer/features/Achievements/presentation/view%20model/achievement_cubit.dart';
import 'package:gymer/features/Analysis/data/repository/analysisRepo.dart';
import 'package:gymer/features/Analysis/presentation/view%20model/progressCubit/progress_cubit.dart';
import 'package:gymer/features/Chatbot/data/repository/chatRepo.dart';
import 'package:gymer/features/Chatbot/presentation/view%20model/chatCubit/chat_cubit.dart';
import 'package:gymer/features/Favorite/data/repository/favoriteRepo.dart';

import 'package:gymer/features/MachineRecognition/data/repository/machineRepo.dart';

import '../../features/Analysis/presentation/view model/checklistCubit/checklist_cubit.dart';
import '../../features/Authentication/data/repository/authRepo.dart';
import '../../features/Authentication/presentation/view model/AuthCubit/auth_cubit.dart';
import '../../features/Favorite/presentation/viewModel/favoriteCubit/favorite_cubit.dart';
import '../../features/Home/data/repository/homeRepo.dart';
import '../../features/Home/presentation/viewModel/homeCubit/home_cubit.dart';
import '../../features/MachineRecognition/presentation/view model/MachineCubit/machine_cubit.dart';
import '../../features/Questionnaire/data/repository/questionnaireRepo.dart';
import '../../features/Questionnaire/presentation/view model/questionnaireCubit/questionnaire_cubit.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  final apiService = ApiService();
  //Auth
  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(apiService: apiService));
  getIt.registerFactory<AuthCubit>(
      () => AuthCubit(getIt<AuthenticationRepository>()));

  //Questionnaire
  getIt.registerLazySingleton<QuestionnaireRepository>(
      () => QuestionnaireRepository(apiService: apiService));
  getIt.registerFactory<QuestionnaireCubit>(
      () => QuestionnaireCubit(getIt<QuestionnaireRepository>()));

  //Chatbot
  getIt.registerLazySingleton<ChatRepository>(
      () => ChatRepository(apiService: apiService));
  getIt.registerFactory<ChatCubit>(() => ChatCubit(getIt<ChatRepository>()));

  //Recognize
  getIt.registerLazySingleton<MachineRepository>(
      () => MachineRepository(apiService: apiService));
  getIt.registerFactory<MachineCubit>(
      () => MachineCubit(getIt<MachineRepository>()));

  //fav
  getIt.registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepository(apiService: apiService));
  getIt.registerFactory<FavoriteCubit>(
      () => FavoriteCubit(getIt<FavoriteRepository>()));

  //Home
  getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepository(apiService: apiService));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepository>()));

  //Progress
  getIt.registerLazySingleton<AnalysisRepository>(
      () => AnalysisRepository(apiService: apiService));
  getIt.registerFactory<ProgressCubit>(
      () => ProgressCubit(getIt<AnalysisRepository>()));

  getIt.registerFactory<ChecklistCubit>(() => ChecklistCubit());

  //Achievements
  getIt.registerLazySingleton<AchievementRepository>(
      () => AchievementRepository(apiService: apiService));
  getIt.registerFactory<AchievementCubit>(
      () => AchievementCubit(getIt<AchievementRepository>()));
}
