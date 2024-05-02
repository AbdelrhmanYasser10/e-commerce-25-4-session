part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class RegestrationLoading extends AuthState {}

class RegestrationSuccessfully extends AuthState {
  final RegestrationResponseModel responseModel;
  RegestrationSuccessfully({required this.responseModel});
}

class RegestrationError extends AuthState {
  final String message;
  RegestrationError({required this.message});
}

class LoginLoading extends AuthState {}

class LoginSuccessfully extends AuthState {
  final LoginResponseModel model;
  LoginSuccessfully({required this.model});
}

class LoginError extends AuthState {
  final String message;
  LoginError({required this.message});
}
