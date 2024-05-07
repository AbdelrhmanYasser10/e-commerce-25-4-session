part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

class GetUserDataLoading extends AppState {}

class GetUserDataSuccessfully extends AppState {}

class GetUserDataError extends AppState {
  final String message;
  GetUserDataError({required this.message});
}

class GetHomeDataLoading extends AppState {}

class GetHomeDataSuccessfully extends AppState {}

class GetHomeDataError extends AppState {
  final String message;
  GetHomeDataError({required this.message});
}

class GetCategoriesLoading extends AppState {}

class GetCategoriesSuccessfully extends AppState {}

class GetCategoriesError extends AppState {
  final String message;
  GetCategoriesError({required this.message});
}

class GetProductsLoading extends AppState {}

class GetProductsSuccessfully extends AppState {}

class GetProductsError extends AppState {
  final String message;
  GetProductsError({required this.message});
}

class ChangeProductFavouritesSuccessfully extends AppState {}

class ChangeProductFavouritesError extends AppState {
final String message;
ChangeProductFavouritesError({required this.message});
}

class GetFavouritesLoading extends AppState {}

class GetFavouritesSuccessfully extends AppState {}

class GetFavouritesError extends AppState {
final String message;
GetFavouritesError({required this.message});
}