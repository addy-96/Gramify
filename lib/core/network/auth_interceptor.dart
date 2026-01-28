import 'package:dio/dio.dart';
import 'package:gramify/core/shared_pref_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $getAccessToken()';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  Future<String> getAccessToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(SharedPrefRepo.accessToken) ?? "";
  }
}
