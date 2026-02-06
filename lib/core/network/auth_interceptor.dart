import 'package:dio/dio.dart';
import 'package:gramify/core/backend/api_routes.dart';
import 'package:gramify/core/shared_pref_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  bool _isRefreshing = false;
  final List<Function()> _retryQueue = [];
  final dio = Dio();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await getAccessToken();
    options.headers['Authorization'] = 'Bearer $accessToken';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      return _handle401(err, handler);
    }
    handler.next(err);
  }

  Future<void> _handle401(DioException err, ErrorInterceptorHandler handler) async {
    final pref = await SharedPreferences.getInstance();
    final refreshToken = pref.getString(SharedPrefRepo.refreshToken);

    if (refreshToken == null) {
      handler.next(err);
      return;
    }

    if (_isRefreshing) {
      _retryQueue.add(() async {
        final response = await _retry(err.requestOptions);
        handler.resolve(response);
      });
      return;
    }

    _isRefreshing = true;
    try {
      final response = await dio.post(ApiRoutes.refreshAPIroute, options: Options(headers: {'Authorization': refreshToken}));

      final newAccessToken = response.data['data']['accessToken'];
      final newRefreshToken = response.data['data']['refreshToken'];

      await pref.setString(SharedPrefRepo.accessToken, newAccessToken);
      await pref.setString(SharedPrefRepo.refreshToken, newRefreshToken);

      // Retry queued requests
      for (final retry in _retryQueue) {
        retry();
      }
      _retryQueue.clear();

      // Retry original request
      final newResponse = await _retry(err.requestOptions);
      handler.resolve(newResponse);
    } catch (e) {
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<Response> _retry(RequestOptions requestOptions) {
    final options = Options(method: requestOptions.method, headers: requestOptions.headers);

    return dio.request(requestOptions.path, data: requestOptions.data, queryParameters: requestOptions.queryParameters, options: options);
  }

  Future<String> getAccessToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(SharedPrefRepo.accessToken) ?? "";
  }
}
