import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_session/models/categories_model.dart';
import 'package:e_commerce_app_session/models/home_model.dart';
import 'package:e_commerce_app_session/models/prodcuts_model.dart';
import 'package:e_commerce_app_session/models/user_data_model.dart';
import 'package:e_commerce_app_session/network/local/cache_helper.dart';
import 'package:e_commerce_app_session/network/remote/constants.dart';
import 'package:e_commerce_app_session/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  String? token;
  UserDataModel? user;
  HomeModel? homeModel;
  Categories? categories;
  ProductsModel? products;

  Map<int, bool> favouritesMap = {};

  void getUserData() {
    emit(GetUserDataLoading());
    token = CacheHelper.getData(key: "token");
    DioHelper.getData(endPoint: PROFILE, token: token, headers: {
      "lang": "en",
    }).then((value) {
      if (value.data["status"]) {
        user = UserDataModel.fromJson(value.data);
        emit(GetUserDataSuccessfully());
      } else {
        CacheHelper.removeData(key: "token");
        emit(GetUserDataError(message: value.data["message"]));
      }
    }).catchError((error) {
      emit(GetUserDataError(message: error.toString()));
    });
  }

  void getHomeData() {
    emit(GetHomeDataLoading());
    DioHelper.getData(
      endPoint: HOME,
      headers: {
        "lang": "en",
      },
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      if (homeModel!.status!) {
        for (var element in homeModel!.data!.products!) {
          favouritesMap.addAll({
            element.id!: element.inFavorites!,
          });
        }
        emit(GetHomeDataSuccessfully());
      } else {
        emit(GetHomeDataError(message: homeModel!.message!));
      }
    }).catchError((error) {
      emit(GetHomeDataError(message: error.toString()));
    });
  }

  void getCategoryData() {
    emit(GetCategoriesLoading());
    DioHelper.getData(
      endPoint: CATEGORIES,
      headers: {
        "lang": "en",
      },
      token: token,
    ).then((value) {
      categories = Categories.fromJson(value.data);
      if (categories!.status!) {
        emit(GetCategoriesSuccessfully());
      } else {
        emit(GetCategoriesError(message: categories!.message!));
      }
    }).catchError((error) {
      emit(GetCategoriesError(message: error.toString()));
    });
  }

  void getAllProductsFromCategory({required int categoryId}) {
    emit(GetProductsLoading());
    DioHelper.getData(
      endPoint: PRODUCTS,
      headers: {
        "lang": "en",
      },
      token: token,
    ).then((value) {
      if (value.data["status"]) {
        products = ProductsModel.fromJson(value.data["data"]);
        for (var element in products!.data!) {
          favouritesMap.addAll({
            element.id! : element.inFavorites!
          });
        }
        emit(GetProductsSuccessfully());
      } else {
        emit(GetProductsError(message: value.data["message"]));
      }
    }).catchError((error) {
      emit(GetProductsError(message: error.toString()));
    });
  }

  void changeFavourite({required int productsId}) {
    favouritesMap[productsId] = !favouritesMap[productsId]!;
    emit(ChangeProductFavouritesSuccessfully());
    DioHelper.postData(
        endPoint: FAVOURITES,
        data: {
          "product_id": productsId,
        },
        token: token!,
        headers: {
          "lang": "en",
        }).then((value) {
      if (value.data["status"]) {
        emit(ChangeProductFavouritesSuccessfully());
      } else {
        favouritesMap[productsId] = !favouritesMap[productsId]!;
        emit(ChangeProductFavouritesError(message: value.data["message"]));
      }
    }).catchError((error) {
      favouritesMap[productsId] = !favouritesMap[productsId]!;
      emit(ChangeProductFavouritesError(message: error.toString()));
    });
  }
}
