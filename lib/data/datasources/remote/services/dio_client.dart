import 'package:dio/dio.dart';
import 'dio_interceptor.dart';

import '../../../../core/utils/api_data.dart';

class DioClient {
  DioClient(ApiData data) : apiData = data {
    _dio = _createDio();
    _dio.interceptors.add(DioInterceptor(apiData));
  }
  late final ApiData apiData;
  late Dio _dio;

  Dio _createDio() => Dio(BaseOptions(
        baseUrl: apiData.basUrl,
        // headers: {
        //   'Content-Type': 'application/x-www-form-urlencoded',
        //   'Accept': 'application/x-www-form-urlencoded',
        // },
        contentType: 'application/x-www-form-urlencoded',
        responseType: ResponseType.json,
        receiveTimeout: 5000,
        connectTimeout: 5000,
      ));

  /// Returns a new Dio object with its Interceptor
  Dio get dio {
    final dio = _createDio();
    dio.interceptors.add(DioInterceptor(apiData));
    return dio;
  }

  /// Dio get request
  Future<Response<Map<String, dynamic>>> get(String path,
          {Map<String, dynamic>? queryParameters}) =>
      _dio.get(path, queryParameters: queryParameters);

  /// Dio post request
  Future<Response<Map<String, dynamic>>> post(String path,
          {Map<String, dynamic>? body}) =>
      _dio.post(path, data: body);
}
