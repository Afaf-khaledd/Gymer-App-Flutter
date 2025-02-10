import 'package:get_it/get_it.dart';
import 'package:gymer/core/helpers/apiService.dart';


import '../../features/Authentication/data/repository/authRepo.dart';
import '../../features/Authentication/presentation/view model/AuthCubit/auth_cubit.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  final apiService = ApiService();
  //Auth
  getIt.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepository(apiService: apiService));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthenticationRepository>()));

  //Questionnaire
/*  getIt.registerLazySingleton<QuestionnaireRepository>(() => QuestionnaireRepository(apiService: ApiService()));
  getIt.registerFactory<QuestionnaireCubit>(() => QuestionnaireCubit(getIt<QuestionnaireRepository>()));*/

}