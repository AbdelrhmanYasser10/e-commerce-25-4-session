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
