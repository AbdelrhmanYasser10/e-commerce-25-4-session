import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_session/models/regestration_response_model.dart';
import 'package:e_commerce_app_session/network/remote/constants.dart';
import 'package:e_commerce_app_session/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  void register({
    required String email,
      required String password,
      required String name,
      required String phoneNumber,
      }) {
    emit(RegestrationLoading());
    DioHelper.postData(
        endPoint: REGISTER,
      data: {
          "email":email,
          "password":password,
          "name":name,
        "phone":phoneNumber,
      }
    ).then((value) {
      if(value.data["status"]){
        emit(RegestrationSuccessfully(responseModel: RegestrationResponseModel.fromJson(value.data)));
      }
      else{
        emit(RegestrationError(message: value.data["message"]));
      }

    }).catchError((error){
      emit(RegestrationError(message: error.toString()));
    });
  }
}
