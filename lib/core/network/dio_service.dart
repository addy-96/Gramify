import 'package:dio/dio.dart';
import 'package:gramify/core/network/auth_interceptor.dart';

class DioService {
  late final Dio dio;
  final AuthInterceptor? authInterceptor;

  void addInterceptors() {
    if (authInterceptor != null) {
      dio.interceptors.addAll([authInterceptor!]);
    }
  }

  DioService({required String baseUrl, Map<String, String>? header, required this.authInterceptor, bool authorization = true}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: header ?? {'Content-Type': 'application/json'},
      ),
    );
    if (authorization) {
      addInterceptors();
    }
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true, error: true));
  }
}
