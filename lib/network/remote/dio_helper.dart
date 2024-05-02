import 'package:dio/dio.dart';

import 'constants.dart';


class DioHelper{
  static late Dio _dio;

  static void initializeDio(){
    _dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String,dynamic>? queryParameters,
    String? token,
    Map<String,dynamic>? headers,
  })async{
    _dio.options.headers = headers;
    _dio.options.headers = {
      "Authorization":token,
    };
    return await _dio.get(endPoint,queryParameters: queryParameters);
  }

  static Future<Response> postData({
    required String endPoint,
    Map<String,dynamic>? data,
    Map<String,dynamic>? queryParameters,
    Map<String,dynamic>? headers,
    String? token,
  })async{
    _dio.options.headers = headers;
    _dio.options.headers = {
      "Authorization":token,
    };
    return await _dio.post(endPoint,data: data,queryParameters: queryParameters);
  }
}