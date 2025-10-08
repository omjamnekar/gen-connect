import 'package:dio/dio.dart';
import 'package:gen_connect/core/api/dio_interceptor.dart';

class DioClient {
  final Dio _dio;

  DioClient({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.interceptors.add(CustomInterceptor());
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Dio get client => _dio;
}
