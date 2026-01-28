import 'package:dio/dio.dart';
import 'package:gramify/core/backend/api_routes.dart';
import 'package:gramify/core/errors/exceptions.dart';
import 'package:gramify/core/network/dio_service.dart';
import 'package:gramify/core/shared_pref_repo.dart';
import 'package:gramify/features/wrapper/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthDatasource {
  Future<UserModel?> signUp({required String email, required String password, required String username, required String phone});
  Future<UserModel?> login({required String email, required String password});
  Future<UserModel?> logOut();
  Future<bool> changePassword({required String email});
}

class AuthDatasourceImpl implements AuthDatasource {
  AuthDatasourceImpl({required this.apiRoutes, required this.dioService, required this.pref});
  final ApiRoutes apiRoutes;
  final DioService dioService;
  final SharedPreferences pref;
  @override
  Future<bool> changePassword({required Comparable<String> email}) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> login({required String email, required String password}) async {
    try {
      final response = await dioService.dio.post(ApiRoutes.loginAPI, data: {'email': email, 'password': password});
      pref.setString('accessToken', response.data['data']['accessToken']);
      pref.setString('refreshToken', response.data['data']['refreshToken']);
      return UserModel.fromJson(response.data['data']);
    } on ApiExceptions catch (_) {
      rethrow;
    } on DioException catch (e) {
      throw ApiExceptions(errorMessage: e.response?.data['msg'] ?? e.response?.statusCode);
    } catch (err) {
      throw ApiExceptions(errorMessage: err.toString(), statusCode: 407);
    }
  }

  @override
  Future<UserModel?> signUp({required String email, required String password, required String username, required String phone}) async {
    try {
      final response = await dioService.dio.post(ApiRoutes.registerAPI, data: {'email': email, 'password': password, 'username': username, 'phone': phone});
      pref.setString(SharedPrefRepo.accessToken, response.data['data']['accessToken']);
      pref.setString(SharedPrefRepo.refreshToken, response.data['data']['refreshToken']);
      return UserModel.fromJson(response.data);
    } on ApiExceptions catch (_) {
      rethrow;
    } on DioException catch (e) {
      throw ApiExceptions(errorMessage: e.response?.data['msg'] ?? e.response?.statusCode);
    } catch (err) {
      throw ApiExceptions(errorMessage: err.toString(), statusCode: 407);
    }
  }

  @override
  Future<UserModel?> logOut() {
    throw UnimplementedError();
  }
}
