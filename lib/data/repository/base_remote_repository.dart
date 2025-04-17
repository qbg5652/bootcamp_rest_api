// 추상클래스
// Dio 클라이언트 객체

import 'package:dio/dio.dart';

abstract class BaseRemoteRepository {
  Dio get client => _client;

  String? get bearerToken => intercepter.bearerToken;

  static Dio _client = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.0.54:8080',
      validateStatus: (status) {
        return true;
      },
    ),
  )..interceptors.add(intercepter);

  static AuthIntercepter intercepter = AuthIntercepter();
}

class AuthIntercepter extends Interceptor {
  String? bearerToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (bearerToken != null) {
      options.headers.addAll({'Authorization': bearerToken});
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.realUri.path == '/login' && response.statusCode == 200) {
      final token = response.headers['Authorization'];
      bearerToken = token?.first;
    }
    super.onResponse(response, handler);
  }
}
