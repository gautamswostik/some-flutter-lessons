import 'package:dio/dio.dart';

const String baseUrl = 'https://jsonplaceholder.typicode.com/';

Dio dioClient() {
  Dio dio = Dio();
  dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = 6000;
  dio.options.receiveTimeout = 6000;
  dio.options.contentType = Headers.jsonContentType;
  dio.interceptors.add(LogInterceptor());
  return dio;
}
