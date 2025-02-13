import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/local_storage.dart';
import '../../../data/models/userModel.dart';
import '../../../data/repository/authRepo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthenticationRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> login(String input, String password, bool rememberMe) async {
    emit(AuthLoading());

    try {
      bool isEmail = input.contains('@');
      final user = await authRepository.login(
        isEmail ? {'email': input} : {'userName': input},
        password,
      );

      await LocalStorage.setRememberMe(rememberMe);
      emit(AuthAuthenticated(user as UserModel));
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

  Future<void> getProfile() async {
    emit(AuthInitial());
    try {
      final user = await authRepository.getProfile();
      if (user != null) {
        emit(ProfileRetrieved(user));
      } else {
        emit(AuthError("Failed to retrieve profile"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> updateProfile(Map<String, dynamic> updatedData) async {
    emit(ProfileLoading());
    try {
      final user = await authRepository.updateProfile(updatedData);
      if (user != null) {
        emit(ProfileUpdated(user));
      } else {
        emit(AuthError("Failed to update profile"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  Future<void> updateProfileImage(File imageFile) async {
    emit(ProfileImageLoading());
    try {
      String? newProfileImageUrl = await authRepository.updateProfileImage(imageFile);
      if( newProfileImageUrl != null){
        emit(ProfileImageUpdated(newProfileImageUrl));
      }
      else{
        emit(ProfileImageError("Failed to update profile image"));
      }
    } catch (e) {
      emit(ProfileImageError(e.toString()));
    }
  }
}
