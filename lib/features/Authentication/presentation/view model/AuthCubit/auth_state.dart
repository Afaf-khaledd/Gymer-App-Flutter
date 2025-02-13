part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel user;
  AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
class ProfileLoading extends AuthState {}

class ProfileRetrieved extends AuthState {
  final UserModel user;
  ProfileRetrieved(this.user);
}

class ProfileUpdated extends AuthState {
  final UserModel updatedUser;
  ProfileUpdated(this.updatedUser);
}

class ProfileImageLoading extends AuthState {}
class ProfileImageUpdated extends AuthState {
  final String newImage;
  ProfileImageUpdated(this.newImage);
}
class ProfileImageError extends AuthState {
  final String message;
  ProfileImageError(this.message);
}