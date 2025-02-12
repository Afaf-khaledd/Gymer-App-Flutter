import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/local_storage.dart';
import '../../../data/models/userModel.dart';
import '../../../data/repository/authRepo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthenticationRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> checkAuth() async {
    emit(AuthLoading());

    final token = await LocalStorage.getToken();
    final user = await LocalStorage.getUserData();

    if (token == null || user == null) {
      emit(AuthUnauthenticated());
    } else {
      emit(AuthAuthenticated(user));
    }
  }

  Future<void> login(String input, String password, bool rememberMe) async {
    emit(AuthLoading());

    try {
      bool isEmail = input.contains('@');
      final user = await authRepository.login(
        isEmail ? {'email': input} : {'userName': input},
        password,
      );

      await LocalStorage.setRememberMe(rememberMe);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(
      String fullName, String userName, String email, String password) async {
    emit(AuthLoading());

    try {
      final user = await authRepository.register(
        fullName: fullName,
        userName: userName,
        email: email,
        password: password,
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());

    try {
      await authRepository.logout();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
