part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}


class GetUserDataLoading extends AppState{}

class GetUserDataSuccessfully extends AppState{

}

class GetUserDataError extends AppState{
  final String message;
  GetUserDataError({required this.message});
}