import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  //static method for initialize dio object
  //take baseUrl
  static init() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: 'https://api.themoviedb.org/3',
      ),
    );
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    return await dio.get(endPoint,
        queryParameters: queryParameters, data: data);
  }
  Future<Response> postData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    return await dio.post(endPoint,
        queryParameters: queryParameters, data: data);
  }
}
