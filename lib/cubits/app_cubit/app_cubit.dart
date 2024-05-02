import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_session/models/user_data_model.dart';
import 'package:e_commerce_app_session/network/local/cache_helper.dart';
import 'package:e_commerce_app_session/network/remote/constants.dart';
import 'package:e_commerce_app_session/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context)=>BlocProvider.of(context);

  String? token;
  UserDataModel? user;
  void getUserData(){

    emit(GetUserDataLoading());
    token = CacheHelper.getData(key: "token");
    DioHelper.getData(
        endPoint: PROFILE,
        token: token,
        headers: {
          "lang":"en",
        }
    ).then((value) {
        if(value.data["status"]){
          user = UserDataModel.fromJson(value.data);
          emit(GetUserDataSuccessfully());

        }else{
          CacheHelper.removeData(key: "token");
          emit(GetUserDataError(message: value.data["message"]));
        }
    }).catchError((error){
        emit(GetUserDataError(message: error.toString()));
    });

  }
}
